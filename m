Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29A1ADC83
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276459; cv=none; b=nyzrVHNplFXfr96xXZcYpc/b75tONdZw5mC1pkmKQ1rH00ZDiCk9rqeyJXpa2RjEm3/o8XHT35mWC1LEZ0GT5TcdVrw7n+cmL8rE6MVXLtUtLDOI4zyR8V/51kwPYp02zROhSI/TWQl+5SvHM9o52t9ukQc3mnBTJSgZ4L/JrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276459; c=relaxed/simple;
	bh=NGIySnMvAM0jHvVh0CL9ARVufhVbCh64nqGYzjpiAvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SohOckOTecRE1d5kcNxci1+YOZpyDZfGm69IAExfAcZmZhb2t7xvTga3muFHFbSFVG5ts0okRNndxizehc41A+rOfjLfXDx/j5eVFaf1G3ixtxtGqLJGPebZPbd5WTx7URfCEYnsL8P6TwDDpntlGA1kT4jDx+9MsSq5t2YMFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/rFqmw8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/rFqmw8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47122683cf3so4292588f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276456; x=1784881256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7UHnlNn5lnaiCI2zNeXXOwskIZFs9ZGzASi2Xvtrbf8=;
        b=K/rFqmw8M5zSnpB0mqBJv+8eir0yMBcHevXWkxZ3C9HxW2ORaPgaaoWFiN6ju/luEn
         r9PSEycs2zD2zZonzBILYb/g5kpcZjPEQKdhPsYDQnuDzokYLBSaYjItOcPp3jCDit0U
         zkuwQyleJGZ95IJuy8wP3Kp9AHQ2FCz9HAp2CKX5N0BFuB0hjOCIIodwKf3JZGdw2F0M
         VpYTCi8aZRgeEmzUJU0XOsK6nAs7DG2BIzsVtTd45TFuEo27arNxNjh+FmgC14itWv05
         2AU9q3sjD/ga2/wxosIZ8tH2uwlpjmhEazCSHIrv1G+T8Y4vi79lBRowqYAjNonaQyJk
         5S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276456; x=1784881256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7UHnlNn5lnaiCI2zNeXXOwskIZFs9ZGzASi2Xvtrbf8=;
        b=G9Opqw7WAoBHVAc4IKcO8/TBGLUHK5aB+TtKEXAwFOTd0mqoSNz+8iWkFhJyh3GmtI
         +Kj4Yuk0ZxXULRpPz88GPTzJlh47OMFc9bK/xZ194Z+nSDX/8p8vpU+MryDE5sEF5apI
         cYg/2tkX1DzEk+uu+67o5BqjynUMnrAXLfyfLl8t5MEFm3wRRhFDDTYUsjtSz4Uqwfhy
         9SdV9pp3iQvQp/Hb0COJtCdkJ8wTVLpNeN2b53DF+pLnlzXz+dVg+gTsmbrS7tPQRovj
         /c0XtdpLLUt9zSVat7kvdWXWGjdi6FGy9EDL8Hni7A/tLpyQqLa9UJGw+0UIaAXRPUwQ
         ne1g==
X-Gm-Message-State: AOJu0YzU/Dwz9J+392srQ3xXiBpqbWcpIsrDyIhsb8Kk9keGVUknD4qy
	oTyMSKvuavZ+5UpZNuq6EycBFy65qR8olN8qsM+X0ZMDj/eGA0NDM6Or
X-Gm-Gg: AfdE7ckkVYCZAwrOTbUYGJsfJrjvIoXQy0Cxwepzmx1ksVCo+s/y20pbMw34OOpIWbb
	FxW+A0cfQxfKi1Z1L5pBF+hyPh3jiX/myTQ3zRH9R0fIHhmadIwxW+WF0i0fRG/wCYXAeFDCEE6
	jlTI7JPauO+2N5oCzs9itcJaXaWWq3gVU1Uivn0aZaMEbWUbgWSS1lW4Um2bu04YYiZR9JID2+N
	MULnnf6bxm7d7lcG1WpLjZLTf1Y94V/Z7Z/tT94zpf1DHkLtyi7PKbzA1YvaqxmlDV4Xwc96LgW
	7JSK5awkyFBhT8vitcQVFJLF10C9CPIWgJMXiInOokTi/7KmrF0P8N2nbHSqcqDhcRz9RxhT6Bf
	5CGCVRXjEPkFmQglKK8zcJGjLDTfca0JNlznvZIavn4UUm9esn+Vfr8t4+uZF/UUE+9MDYEPWXK
	nzcFcooCO14BwApie3mWqGug==
X-Received: by 2002:adf:e542:0:b0:475:f0f0:9ef8 with SMTP id ffacd0b85a97d-47f6233f14amr1649781f8f.61.1784276456077;
        Fri, 17 Jul 2026 01:20:56 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:c817:c1b7:3e78:551a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm1671314f8f.4.2026.07.17.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:20:55 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next 2/2] net: wwan: add exclusive open mode capability to AT and QCDM ports
Date: Fri, 17 Jul 2026 10:19:35 +0200
Message-ID: <20260717081935.2071083-3-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717081935.2071083-1-dnlplm@gmail.com>
References: <20260717081935.2071083-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add exclusive open mode capability to AT and QCDM ports to improve
compatibility with user-space tools using the Qualcomm diagnostic
device (e.g. libqcdm).

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 8168239e52c3..3e4491235674 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -22,6 +22,7 @@
 #include <linux/termios.h>
 #include <linux/gnss.h>
 #include <linux/wwan.h>
+#include <linux/tty.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/wwan.h>
 
@@ -79,7 +80,7 @@ struct wwan_device {
  * @data_lock: Port specific data access serialization
  * @headroom_len: SKB reserved headroom size
  * @frag_len: Length to fragment packet
- * @at_data: AT port specific data
+ * @at_data: AT/QCDM port specific data
  * @gnss: Pointer to GNSS device associated with this port
  */
 struct wwan_port {
@@ -98,6 +99,7 @@ struct wwan_port {
 		struct {
 			struct ktermios termios;
 			int mdmbits;
+			unsigned long flags;
 		} at_data;
 		struct gnss_device *gnss;
 	};
@@ -748,6 +750,14 @@ static int wwan_port_op_start(struct wwan_port *port)
 		goto out_unlock;
 	}
 
+	/* Check exclusive open mode for AT and QCDM ports */
+	if ((port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) &&
+	    test_bit(TTY_EXCLUSIVE, &port->at_data.flags) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	/* If port is already started, don't start again */
 	if (!port->start_count)
 		ret = port->ops->start(port);
@@ -857,6 +867,15 @@ static int wwan_port_fops_release(struct inode *inode, struct file *filp)
 	struct wwan_port *port = filp->private_data;
 
 	wwan_port_op_stop(port);
+
+	/* Clear exclusive flag when last fd is closed */
+	if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) {
+		mutex_lock(&port->ops_lock);
+		if (!port->start_count)
+			clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
+		mutex_unlock(&port->ops_lock);
+	}
+
 	put_device(&port->dev);
 
 	return 0;
@@ -1031,6 +1050,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 		break;
 	}
 
+	case TIOCEXCL:
+		set_bit(TTY_EXCLUSIVE, &port->at_data.flags);
+		break;
+
+	case TIOCNXCL:
+		clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
+		break;
+
+	case TIOCGEXCL:
+	{
+		int excl = test_bit(TTY_EXCLUSIVE, &port->at_data.flags);
+
+		ret = put_user(excl, (int __user *)arg);
+		break;
+	}
+
 	default:
 		ret = -ENOIOCTLCMD;
 	}
-- 
2.43.0

