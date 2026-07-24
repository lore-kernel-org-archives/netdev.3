Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187940860B
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903523; cv=none; b=YEOXtyD91ZoD35z4rYOkksYfcgYK0kQjlRxZuNJK52SrAHCz9/diRZNK5axLHXscPzfQco/JlaOWYKDeFtFRY1Yxluk6eh9wtpwWMyd+dfFhNm5YBR+kDXpLCpY+MOTmR47no4J6T0GbvLIytOg7/2d2T+GVkgMRe5wD/Ns+Zec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903523; c=relaxed/simple;
	bh=WJZ8ZQ+mI1ku4skFN9/E52lfEw0RXSYfEieKPOM2gsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEPv8iMYTTiTxUDk+NO3Oqvbw8sq1u10mQ4PPLDAwuO4gDXZHlHVXbG/x+E5VGwB6zV62bSZ5Wu5LM7T5bb1FXTFDEbyuagK94I6aUiMjggmRQC8QAHhPmJ0aiOis9G5/zZwjuD6uLXTwdTSC0jPGECYKICQgLrU5KM3XtaQEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF4MYZV1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF4MYZV1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so309972f8f.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903520; x=1785508320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBTvudv5nuwmsacz6bQ69IP+IrpWEPTqGpSKsoSMxbg=;
        b=eF4MYZV1vMUNrgvcFRkuO5rS1mxYPKOK3TpPOb+Meqbh8JeLv+clS2Qac0baei2PcP
         pG8TzeLIiJAiGNNfaxtJIOHroj1qAO8FFDQzY+QPPKyC9JF63psEH1X5ZV4ojq8eNFpw
         c9nFa3HGT6x2LwIjHT1n1g8KaIdI4Ax+Biq0fymjFl5jYiZ05IVOTViz9jmzDE/q0V9j
         TeODyjQRKm+YnTGdHypDPF4j7OZF4aGKRv8vKyBgEjUsLUR2jy94sVWjRXmyDI3I200F
         urkAqa70LV1G3KoqrK11I9haNhaDeg4AIp/ELuNa9aABuzu4SS8dmsKeATMDTUnEryPu
         7r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903520; x=1785508320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBTvudv5nuwmsacz6bQ69IP+IrpWEPTqGpSKsoSMxbg=;
        b=b+6CzQ0qUtvBmfy8LKjoT4J2KnWDivbbsl2gPVk7CZd5OIKdLjOa+DzhuUmfDAd7m/
         Ow4u/P0XLv5nki+v/AmX9LMEZTbbD0/BOd8RVivpSTkSf8JjIMlFcTtzRsuEydKRDzjp
         wJeIqcVJA8EHh4JjW447jxtuqocHcTrf+kxpDTNiuVVjwTtQGW9jpe/2dPXwBgq8QpCE
         joGEjbH14Ihp0Q5UZR235KFWdVvndB7p5PQz7BQGEkLZhTRDTWZirVeL/QbUikwJ80Vs
         0lEYrKUzNU4ZH1pca65vKulKvkMiTB9QrYJ2Dy3hssOC+G59h+bbAA36x3O86M6Ayd+I
         CAYQ==
X-Gm-Message-State: AOJu0Ywowr5bPbF6zxovKkShMLgrpMBz53jRQNsIPV3uY9RgX/aHzoE2
	vqBBnC4A83tLO5inZv6Lwk7UR9uGi+of0UUX+/J4IKiWY5U4O52iPqnN
X-Gm-Gg: AR+sD10YDyqbwobmyyfqJJJHA+Mund7YZabxrnsD1jItmZVnEPnEdPYdBJmR/xOgZ/9
	BduY5f5Gcp1jj1d4zsUHdXnr/u4pyFneyRBlPAtjFyy/C6OAYkkWZhkzT1gRot5+K6K0DMhh7oM
	ymF8PdTwYUtqrrqgxxk1lJMIn9tFDuRf5TP4f0n67AFXMnjszq52kbNjoM2C5UWOp5gLSb+FdB3
	CIWsANMrMa6dCWAGE7bJoDYdosAy6i6Mov7MoTzKJS86MWEHG6DbmbCYdKe1yQFkZGpqDpX20ao
	rPIFqWCPsjr/AfwP4R/xD91pcJk3mORORk3p8QEYqCJgL5X0WYJuIbcaHdblWGXM8ZTHHmiPLvF
	fYvDkJnNInGtT6aaS9TZrniSOYGFOSgMdWAo4Iz5ZjPRtPjM7MOLxEZsSMrnGFmd6bPyFY14Y0w
	L37ZsseJ+DAjnZ7BXlwc6KuJfGAcfw3ySu94qpLj1/2wXs38n5Gn5jvrzp6YxGetGzbKAK+tY=
X-Received: by 2002:a05:6000:2507:b0:47f:9260:4bc9 with SMTP id ffacd0b85a97d-47f92604f65mr7600505f8f.29.1784903519772;
        Fri, 24 Jul 2026 07:31:59 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm23898298f8f.17.2026.07.24.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:31:59 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] net: wwan: add exclusive open mode capability to AT and QCDM ports
Date: Fri, 24 Jul 2026 16:28:18 +0200
Message-ID: <20260724142909.3270824-3-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724142909.3270824-1-dnlplm@gmail.com>
References: <20260724142909.3270824-1-dnlplm@gmail.com>
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
 drivers/net/wwan/wwan_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 8168239e52c3..ffbcf11e4e68 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -42,6 +42,7 @@ static struct dentry *wwan_debugfs_dir;
 
 /* WWAN port flags */
 #define WWAN_PORT_TX_OFF	0
+#define WWAN_PORT_EXCLUSIVE	1
 
 /**
  * struct wwan_device - The structure that defines a WWAN device
@@ -748,6 +749,12 @@ static int wwan_port_op_start(struct wwan_port *port)
 		goto out_unlock;
 	}
 
+	if (test_bit(WWAN_PORT_EXCLUSIVE, &port->flags) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	/* If port is already started, don't start again */
 	if (!port->start_count)
 		ret = port->ops->start(port);
@@ -769,6 +776,7 @@ static void wwan_port_op_stop(struct wwan_port *port)
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
+		clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
 	}
 	mutex_unlock(&port->ops_lock);
 }
@@ -1031,6 +1039,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 		break;
 	}
 
+	case TIOCEXCL:
+		set_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
+		break;
+
+	case TIOCNXCL:
+		clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
+		break;
+
+	case TIOCGEXCL:
+	{
+		int excl = test_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
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

