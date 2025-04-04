# Use the .NET SDK Alpine image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /source

# Copy the project files and restore dependencies
COPY aspnetapp/*.csproj .
RUN dotnet restore -a arm64

# Copy the remaining source code and publish the application
COPY aspnetapp/. .
RUN dotnet publish --no-restore -a arm64 -o /app

# Use the ASP.NET Core runtime Alpine image for running the application
FROM  mcr.microsoft.com/dotnet/aspnet:8.0-alpine
WORKDIR /app
EXPOSE 8080

# Copy the published application from the build stage
COPY --from=build /app .

# Uncomment to enable non-root user
# USER $APP_UID

ENTRYPOINT ["./aspnetapp"]


