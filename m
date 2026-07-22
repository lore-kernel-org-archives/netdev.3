Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5D43B3E4
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711431; cv=none; b=QtwChYIPzIRKBE5rEnMV1Jk6wROjD2bknRauJgJUwoJa68Pe/QfcI/QHttqLHUWefy0ieaUeIUU21YcWMTsrojXru1Dc+FxsHPAuFUF+NXB3r6RGvW1xyacCjyXzKL5gSe2kj0lUhi6RSRAHgq+6G+v3ejgLr9KbFZGT0U8Bxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711431; c=relaxed/simple;
	bh=nJcFxXIvLPbkGK1QMBaARCqOIjn0L035Y4w8OrFc2Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM67glkF6ekF2PX9rtkzc94y+3MchITqMFNe0rQkKs4Fq3bd4mTKagj1BVRAAuPwMLixdsKAvMN48ecIQ9FrsYGlLSvqU7jGOSPKbH9P7su0rdZBIM7LE3UzULXq2EF9cbZUL6HDcnzYAJK4tClpHL8Dqvb29WPT3fGoT64Udac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li6FIQYh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li6FIQYh"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f752b3423so2537161f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784711424; x=1785316224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdluEnbV/bjkMK1wXPlyO1mpDVHkDRFSt41DayM9cG0=;
        b=Li6FIQYhdA+2f4uoB1qCbVkgXFrFNMa6NLNMMaQRXo5CnBAXdzfbOisx5o0/LmOe6E
         GrCU5VPi2UIQWQ3dPytAxvGmSORpBAyFAV9Z9D7Smu6cKn7heM896z4iFxiOvsW/bjjj
         WGywKh+GRApQyeL6ZapU7fGaTAicQo5mhYv8+xjCzKZKLuC9ZWGxcK2Bp+ledwr9S8TH
         5jKMmMGLgL2f/Z/B1ZPHfI9l6S1pcJpTgYJ/xnl4oBMzUGxFqGgtZ8Qw/F6INfnNhPKh
         0BxjWvK+2D0DZN9U3X1INJ37WnAxxFJNnH6ApKQhDPZfdS6hyFlrQth3LkGzIcPogYXk
         +hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711424; x=1785316224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdluEnbV/bjkMK1wXPlyO1mpDVHkDRFSt41DayM9cG0=;
        b=RElAWJ/zYRttsslzX4454fc63Lsy0b3GhFfKZcxqqVVTM4B1PanjULrYyv46r+485H
         5eITPuA+b6cItivs7r9skIFqqyrVxJ02f0cEWes1786TqANWqWs99QFSP1GpR6fHMBfX
         j2H0LckHyirZ/ZPwQjl7R4FfpQmzUCF2iZvIl9VSSsZwyW8zavsbwEI0ScR+XPHeYnVm
         lmjFq2Fcs78JlYnnp3g0PFI5VQPIJe1rjampeOZiZUro8ejWmrIYynIgN1Gz9axhPjTP
         X15if3wZyq5IWy3Ykd3+gY1GkiYuyIatP/IeTYdDbwH0GKUlavbd1BgYwZ5WThCCHipV
         85Tg==
X-Gm-Message-State: AOJu0Ywgq++nosrXdkMoQMw7UdcaxhtnC9jBbQEOTwyqYuL47cpXQiOw
	IINtq45leehFtiFjPmvdinO8P/o4EFeoUxfMVkyV1aFidDN6QpKL31neMa66nRPY
X-Gm-Gg: AR+sD11cqNp6z9bpD0cqoj60tRsiJO/s9rNYJzxvwC/xsQgGgPtb2mTRjnpZnzu/QQo
	CSBw2ykLHq/twUsNfpJS0ydN4kWXtqFj1J879qLbpNBf75baAlLqBOev4WL5jCz4vcY4T6rJ7Sz
	JBKPWW5RgKlid9OMc8S25NQCdl7DtxHRjNoCevVwLfQa64OIT1GtAUUPEtKs2n9kF/GORstixew
	hHDwH8g79TNDaLTzpsoM+NRvkzqehpdrrhi5ru/uF02HjfocFBoyVrId/RCXLqqux5K8rdZkhnx
	VZtPIlQ5CMmF4NUg51bm6yx6rTjT1xeJawWOrlAkfdnowtaSodrkPyTQz6Ysb0fOk1fqH1CR0mz
	MTdhWDG/SpN+8l7AkyUbGanU1N758ylY3H6LcwYfvsJgygxhx4gXnLep/neVbj0JMOics26Nj7k
	/6UY++EN8oTZR75AL7vNGogw==
X-Received: by 2002:a05:6000:ec7:b0:47f:77a8:7e20 with SMTP id ffacd0b85a97d-47f77a87e95mr11285574f8f.35.1784711423685;
        Wed, 22 Jul 2026 02:10:23 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:bc9c:3808:e25e:32ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm4406792f8f.9.2026.07.22.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:10:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: wwan: add exclusive open mode capability to AT and QCDM ports
Date: Wed, 22 Jul 2026 11:04:51 +0200
Message-ID: <20260722090931.2637025-3-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722090931.2637025-1-dnlplm@gmail.com>
References: <20260722090931.2637025-1-dnlplm@gmail.com>
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
 drivers/net/wwan/wwan_core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 8168239e52c3..8acb09dcb83a 100644
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
@@ -769,6 +779,8 @@ static void wwan_port_op_stop(struct wwan_port *port)
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
+		if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM)
+			clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
 	}
 	mutex_unlock(&port->ops_lock);
 }
@@ -1031,6 +1043,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
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

