# Use official .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set working directory inside the container
WORKDIR /app

# Copy project file(s) and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application source code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o /out

# Use official .NET runtime image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set working directory for runtime
WORKDIR /app

# Copy the published application from the build container
COPY --from=build /out ./

# Expose the port your app runs on
EXPOSE 8080

# Set the entrypoint for the container
ENTRYPOINT ["dotnet", "YourApp.dll"]
