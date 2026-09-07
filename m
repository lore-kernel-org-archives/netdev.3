Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B394908DD
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783512; cv=none; b=Ny/vi8YONkbNPEq1udF3c7mtKH+4drbxRBypWSnwqFpaJerLQGNPcNJVZ8ZZyT/Z7x1xee/dKxHO6faUiSCG2Xb5lsJl31eLy+43xXCM7iZlxtN0LjRokebk2j9ijiEQYj6FXLUGHqZMFXyRoYWcXgt0zm+IWZIRP66lw8qDyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783512; c=relaxed/simple;
	bh=DeVxAo49YGbv7fx3J9NoLQbOb4uGHpt+SzJr/w/kcdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwjfNp13Hxl36lhEe82iqbCypkZ358TOAZV6pR9tn75dutEYwa5R2ZvaVDXZJ3dRZZPW+io8kAKhkIy5pxBf29wfpr2U3Vhp2sooNK1wEcXm5vEoGMmqCvSbNn8xr+K/3eqN7775k6ICnt/IZ2qxZ1MH47LVrmdUbQkWN0Rpl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G39IIZ8r; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G39IIZ8r"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39675172593so2727010a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788783510; x=1789388310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yH+H9iYsqFk1XtIUt3nOXiw8tyyJ0b7pPAD8JeW8qgM=;
        b=G39IIZ8r7bawHhXvI0UlyE6JJaVC3WiSVLh2UNPFjRH4EROuMh5ocsBL60Eb9vej2z
         Am0VszAUS6Sr6tUCONL6SVKLpuqMLhdxADWUbPgCzhdpcDTkeiI/BqVey+y1Y3ne7Zwi
         H8J+JLyJSw5WLzT37RX/I+UKPuhl7oDmAmDVV4WWO/PQxUmqnxqINqmxStjT1Dv4pl8G
         phlrFg/6/Lrv7XQHrSubo9KGLkqccI21Uesmmr6D7aGk6aPYVIcODKtEblzSdvd1DGl+
         cQgQ5ZpTZezZtO+e3IJL1h+kbc7lwT+Kcn0kM1NCNEEum/hYjmmnUah2BDsQyD94PZFj
         pL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783510; x=1789388310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yH+H9iYsqFk1XtIUt3nOXiw8tyyJ0b7pPAD8JeW8qgM=;
        b=mJvW7nvfbXoensZY4tDhJow/Dxbd8Y9qtVZFWagud3n9hOCg06rmq8MdL5ovd+bwR+
         +FH2BcGIs0q/PJopvvGN/3ym1BnmSEJo5LhXjz6YiSrc2i1xSkkmDz80gR162ZJUMZMV
         dkANhAvWX+C8m3QsyCmFAfasv+KKC4el1Jar/xqiiqyVfvSszWOVmOTdaIEYMZKYsA+L
         dc3kJz5RsxP7CP+PdIltfBnUodSZLpBVeA21F5XOorViC9JTqWqjkQYr6wcjScSgqHEr
         TegmQyaqZ67wmCcEgxVoO9QaRl2C8beeGKLMDFVVpU5UYxb87ipc3HdCBlh9jCOxImJS
         zTzA==
X-Forwarded-Encrypted: i=1; AKwUvBw+jb3O9RiJBMpwdGpiE/K4ICH3Xqmm20hLhMm4V2epihAlTsh/nk4bebpm6jEUqxhWkG81MKI=@vger.kernel.org
X-Gm-Message-State: AFuF++lSjxHs4sUu4mwUQVLVqIVp+f6DEQLciVg3tn0Sidv0A906UEW0
	oBzWkbhd3z+3PYgXYXUv4ZSpcQDWyDQmIv5xcjXNd/Dyb3PLLjlzS2LU
X-Gm-Gg: AYBFou0Stdiu4Ns24xE9bw1ug8uKRPwXza5cJ85T8rUdKE0ksQI6hDWFIrju0BiPNqi
	W01/SHHw5To34p/CInuL/ugWh2ihqZx6kdbjiXORo2shOajLkA5BbmacRbd01KP+tqrlIfXFekl
	1n0jPyMOJtfrIS5cXZqMWSxtWF8gqkcvYI18Dx2MhjJIMNDl8mo55A7SjSmgaubv/s+OSLGRlyM
	UXlieuJWs9d7XOL9fSU4LhKdFenMj405eRiohzy33q5mVlGGC8BizcU2pseMAAQL8ktvl4pw/a/
	bSIrhg5e5C6jIqHbTa5z9iEajONW3JRiQg0DsOA00PuLahsJ1IYmsrThiqFTNp+Jkm8XYJA8FRE
	DW266gZxYVnOd1klSqsgP/vDaGjZqnkJ3Ilt1PcrKEcgvLYMsJ/uY97UfdyDcIEUoW0+uYAJ3AL
	96T4JrlYT7HYJBJvu/jJ6Z+IKu+0bn9Fd3j9cUeCTbPmZ3OBO99RvBqHLrWXTWNOFcPezzs0PHm
	GSHbxuNEd2+wWwd9pBp03R26X5nSQ==
X-Received: by 2002:a17:90b:5106:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39b260feb03mr33322398a91.4.1788783509576;
        Mon, 07 Sep 2026 05:18:29 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm26350223a91.1.2026.09.07.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:18:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 07 Sep 2026 20:15:55 +0800
Subject: [PATCH 1/2] net: usb: cdc_ether: add NCSI passthrough support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ncsi-over-usb-v1-1-6b74d2f1196c@gmail.com>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
In-Reply-To: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oliver Neukum <oliver@neukum.org>, 
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Mike Hsieh <Mike_Hsieh@quantatw.com>, Mik Lin <Mik.Lin@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Adrian Ambrozewicz <aambrozewicz@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788783501; l=9154;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=IS46g8ZZnzDHNyw6psl3bd746BmoiNTKXV1msvVJyZA=;
 b=lnZSXRtePLNu2U3kFSdVbcVwCUvptp5vJLDoUVlGiQcixI8HTa2S1rPC8PwLvR3aHB48atNjW
 4FD6mPu7IVdBlJzDIcf++ubyzHb3wbYJKMrE4OphmW5GXf0b1sOLuPj
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>

Add NCSI (Network Controller Sideband Interface) passthrough support for
USB CDC Ethernet devices. This enables BMC-to-host sideband management
over USB, typically used in DPU platforms where the BMC communicates
with the DPU via a dedicated USB connection.

Key implementation details:

- Register with NCSI subsystem in ndo_open, unregister in ndo_stop
- Override netdev_ops to hook open/stop for NCSI lifecycle management
- Keep carrier always on while interface is up, as NCSI control traffic
  shares the USB data path (unlike PHY-based drivers)
- Ignore CDC status notifications since NCSI manages link state
- Forward VLAN operations to NCSI subsystem

The symmetric open/stop lifecycle is critical for USB drivers:

    open()  -> ncsi_register_dev() + ncsi_start_dev()
    stop()  -> ncsi_stop_dev() + ncsi_unregister_dev()

This ensures NCSI packet handlers are removed BEFORE unregister_netdev()
checks for them during USB disconnect, avoiding kernel crashes. Unlike
platform drivers where unbind() runs before unregister_netdev(), USB
drivers have the opposite order:

    usbnet_disconnect() -> unregister_netdev() -> unbind()

Placing NCSI cleanup in unbind() would be too late.

Supported hardware: NVIDIA DPU USB CDC Ethernet (VID:PID 0955:cf11)

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/net/usb/Kconfig     |  20 +++++
 drivers/net/usb/cdc_ether.c | 190 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 52a5c0922c79..00757392128f 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -241,6 +241,26 @@ config USB_NET_CDCETHER
 	  IEEE 802 "local assignment" bit is set in the address, a "usbX"
 	  name is used instead.
 
+config USB_NET_CDCETHER_NCSI
+	bool "NCSI passthrough support for CDC Ethernet"
+	depends on USB_NET_CDCETHER
+	depends on NET_NCSI
+	help
+	  This option enables NCSI (Network Controller Sideband Interface)
+	  passthrough support for specific USB CDC Ethernet devices.
+
+	  NCSI allows a BMC (Baseboard Management Controller) to share a
+	  network interface with the host system for out-of-band management.
+	  This is typically used in DPU (Data Processing Unit) platforms
+	  where the BMC communicates with the DPU via a dedicated USB
+	  connection.
+
+	  Currently supported devices:
+	    * NVIDIA BlueField DPU (VID:PID 0955:cf11)
+
+	  Say Y here if you have a system with USB-based NCSI connectivity
+	  between BMC and host. If unsure, say N.
+
 config USB_NET_CDC_EEM
 	tristate "CDC EEM support"
 	depends on USB_USBNET
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a0a5740590b9..e5d3924e6a2e 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -538,6 +538,168 @@ static const struct driver_info	cdc_info = {
 	.manage_power =	usbnet_manage_power,
 };
 
+/*
+ * NCSI passthrough support for USB CDC Ethernet devices.
+ *
+ * Enables BMC-to-host sideband management over USB, typically used in
+ * DPU (Data Processing Unit) platforms where the BMC communicates with
+ * the DPU via a dedicated USB connection.
+ */
+#ifdef CONFIG_USB_NET_CDCETHER_NCSI
+#include <net/ncsi.h>
+
+/* NCSI operates at 100 Mbps */
+#define NCSI_SPEED_BPS		(100 * 1000000)
+
+struct cdc_ncsi_priv {
+	struct ncsi_dev *ndev;
+	struct net_device_ops netdev_ops;
+	const struct net_device_ops *orig_netdev_ops;
+};
+
+static int cdc_ncsi_open(struct net_device *net);
+static int cdc_ncsi_stop(struct net_device *net);
+
+static void cdc_ncsi_handler(struct ncsi_dev *nd)
+{
+	if (unlikely(nd->state != ncsi_dev_state_functional))
+		return;
+
+	netdev_dbg(nd->dev, "NCSI interface %s\n",
+		   nd->link_up ? "up" : "down");
+
+	/* Don't toggle carrier here - it must stay on for NCSI to
+	 * communicate over USB. Carrier was enabled in cdc_ncsi_open().
+	 */
+}
+
+static int cdc_ncsi_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct cdc_ncsi_priv *priv;
+	struct cdc_state *info;
+	int status;
+
+	status = usbnet_ether_cdc_bind(dev, intf);
+	if (status < 0)
+		return status;
+
+	info = (void *)&dev->data;
+	status = usbnet_get_ethernet_addr(dev, info->ether->iMACAddress);
+	if (status < 0)
+		goto err_unbind;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		status = -ENOMEM;
+		goto err_unbind;
+	}
+
+	dev->driver_priv = priv;
+
+	/* Override netdev_ops for NCSI lifecycle management */
+	priv->orig_netdev_ops = dev->net->netdev_ops;
+	priv->netdev_ops = *dev->net->netdev_ops;
+	priv->netdev_ops.ndo_open = cdc_ncsi_open;
+	priv->netdev_ops.ndo_stop = cdc_ncsi_stop;
+	priv->netdev_ops.ndo_vlan_rx_add_vid = ncsi_vlan_rx_add_vid;
+	priv->netdev_ops.ndo_vlan_rx_kill_vid = ncsi_vlan_rx_kill_vid;
+	dev->net->netdev_ops = &priv->netdev_ops;
+
+	dev->net->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->net->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	dev->rx_speed = NCSI_SPEED_BPS;
+	dev->tx_speed = NCSI_SPEED_BPS;
+
+	netdev_info(dev->net, "NCSI passthrough enabled\n");
+	return 0;
+
+err_unbind:
+	usb_set_intfdata(info->data, NULL);
+	usb_driver_release_interface(driver_of(intf), info->data);
+	return status;
+}
+
+static void cdc_ncsi_unbind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct cdc_ncsi_priv *priv = dev->driver_priv;
+
+	if (priv) {
+		/* Restore original netdev_ops before freeing priv */
+		dev->net->netdev_ops = priv->orig_netdev_ops;
+		kfree(priv);
+		dev->driver_priv = NULL;
+	}
+
+	usbnet_cdc_unbind(dev, intf);
+}
+
+static int cdc_ncsi_open(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct cdc_ncsi_priv *priv = dev->driver_priv;
+	int ret;
+
+	ret = usbnet_open(net);
+	if (ret)
+		return ret;
+
+	priv->ndev = ncsi_register_dev(net, cdc_ncsi_handler);
+	if (!priv->ndev) {
+		netdev_err(net, "failed to register NCSI device\n");
+		usbnet_stop(net);
+		return -ENODEV;
+	}
+
+	/* Carrier must stay on for NCSI to transmit/receive its control
+	 * packets over USB. Unlike PHY-based drivers, we cannot toggle
+	 * carrier based on NCSI link state without breaking USB I/O.
+	 */
+	netif_carrier_on(net);
+	ret = ncsi_start_dev(priv->ndev);
+	if (ret) {
+		netdev_err(net, "failed to start NCSI: %d\n", ret);
+		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+		netif_carrier_off(net);
+		usbnet_stop(net);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdc_ncsi_stop(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct cdc_ncsi_priv *priv = dev->driver_priv;
+
+	if (priv->ndev) {
+		ncsi_stop_dev(priv->ndev);
+		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+	}
+
+	netif_carrier_off(net);
+	return usbnet_stop(net);
+}
+
+static void cdc_ncsi_status(struct usbnet *dev, struct urb *urb)
+{
+	/* NCSI manages link state, ignore CDC status notifications */
+}
+
+static const struct driver_info cdc_ncsi_info = {
+	.description =	"CDC Ethernet Device (NCSI)",
+	.flags =	FLAG_ETHER | FLAG_POINTTOPOINT,
+	.bind =		cdc_ncsi_bind,
+	.unbind =	cdc_ncsi_unbind,
+	.status =	cdc_ncsi_status,
+	.set_rx_mode =	usbnet_cdc_update_filter,
+	.manage_power =	usbnet_manage_power,
+};
+#endif /* CONFIG_USB_NET_CDCETHER_NCSI */
+
 static const struct driver_info	zte_cdc_info = {
 	.description =	"ZTE CDC Ethernet Device",
 	.flags =	FLAG_ETHER | FLAG_POINTTOPOINT,
@@ -946,7 +1108,33 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET,
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
-}, {
+},
+/*
+ * NCSI passthrough support.
+ *
+ * This implementation enables NCSI unconditionally for matching VID/PID.
+ * Per-driver integration is required because the NCSI subsystem mandates
+ * explicit lifecycle calls (ncsi_register/start/stop/unregister_dev).
+ *
+ * OPEN QUESTION: An alternative approach using DTS "use-ncsi" property
+ * for conditional enablement was considered. This is viable only when
+ * USB topology is fixed and known at build time. Whether DPU deployments
+ * have fixed topologies remains to be determined. Note that DTS-based
+ * control would still require per-driver integration.
+ *
+ * A future generic solution could eliminate per-driver modifications by
+ * extending the NCSI subsystem to hook netdev lifecycle events directly,
+ * with interface selection configured via DTS or sysfs.
+ */
+#ifdef CONFIG_USB_NET_CDCETHER_NCSI
+{
+	USB_DEVICE_AND_INTERFACE_INFO(NVIDIA_VENDOR_ID, 0xcf11,
+				      USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&cdc_ncsi_info,
+},
+#endif /* CONFIG_USB_NET_CDCETHER_NCSI */
+{
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long) &cdc_info,

-- 
2.52.0

