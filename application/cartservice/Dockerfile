FROM mcr.microsoft.com/dotnet/sdk:10.0.100-noble AS build

WORKDIR /src

COPY src/cartservice.csproj src/
RUN dotnet restore src/cartservice.csproj

COPY src/ src/

RUN dotnet publish src/cartservice.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0.0-noble

WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:7070
ENV PORT=7070

EXPOSE 7070

ENTRYPOINT ["dotnet", "cartservice.dll"]
