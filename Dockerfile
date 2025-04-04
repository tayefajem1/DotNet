# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /app

# Copy project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runtime
WORKDIR /app

# Copy the build output from the previous stage
COPY --from=build /app/out ./

# Expose the port the application runs on
EXPOSE 80

# Define the entry point for the container
ENTRYPOINT ["dotnet", "YourApplication.dll"]
