# xvfb-vnc
Bundles xvfb and VNC server for running X11 apps in k8s. Loosely inspired by [comiq/xvfb](https://gitlab.com/comiq/xvfb-container) but with VNC running as well and built more recently. Uses supervisord to run both xvfb and the vnc server.

## Usage

Combine with a container that leverages X11. Example:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample
  labels:
    app: sample
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sample
  template:
    metadata:
      name: sample
      labels:
        app: sample
    spec:
      containers:
        - name: sample-app
          image: austin1howard/xclock-docker:git-7ba085ed
          resources:
            requests:
              memory: "350Mi"
            limits:
              memory: "350Mi"
          env:
          - name: DISPLAY
            value: "localhost:1.0"
        - name: xvfb-vnc
          image: austin1howard/xvfb-vnc:latest
          resources:
            requests:
              memory: "350Mi"
            limits:
              memory: "350Mi"
          env:
          - name: DISPLAY
            value: "1"
          - name: SCREEN
            value: "0"
```