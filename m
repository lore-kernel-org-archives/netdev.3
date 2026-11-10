Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326808;
	b=ftZuee/bt8ZiLR3paFTMNp9FgBL+qeyXXIRETzUMKqiPkqKM2TaFuIPFc3oYoI4eGLGJ
	 RHZlbEfjC/VOddf3LiAyk7YO8FFVcd4qGPYvjq8txxuvYGcEjl8QIndLPHISW/CStH+6S
	 WcTduyqs7KGid+auiWcFFdJWszIO86yTDnfBiUgLWG4f91V1SV0hKAIC3IGDhYuJqse4U
	 p7OURa0cnXgxJggTqpdj06F+11TpzsogWZopaJATONCM//myRdUB6HlPnFkbBvckGdtgL
	 HGq6tQVYFsAJwPkirXcbLMJD7VQejUvBkH0Xi2sRJ7qQOCYGz0MUjoN6/m3ootaOxtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sVnxZNWX6ViUZL7bQPqGM+4jUAh9aQEpBFmSldUmrlQ=;
	b=f62vXP9n2NhyHZ1TQwWLrMKQkuAuAtqeMVAYF7kdCw/mYynRlrbZ17sfl6VYpMNLBP2X
	 hHy+i2YeWgZ7a+QW7AgzXlQITAGWKMubgg+SY4OabJw706KjbBxq7C3/zPNF6X3qiVgfX
	 4EUUPn93rz2Je/uFQeUj4WvnBtOC0hSUbV6aMC5AZmGH+XFFaey6wlAtY8UgwuVb92NLg
	 0NOJ6ZGRKDKcbG+ZDbXfwVj9n/Xl4XQTwW4t7JFrKFb3ne90ENPyxRCNAUDMUpFQBzQ4r
	 jAyVhgANxIfFii3bQD2j1zL64vnEHjImn0qByiS7zFYQjCkd43azEOywUcXn0CusuxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAN2STO7;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944C60A2621
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0944C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OAN2STO7
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1483861eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326807; x=1794931607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVnxZNWX6ViUZL7bQPqGM+4jUAh9aQEpBFmSldUmrlQ=;
        b=OAN2STO7B85R9kJqiCGzQFrvQYP2o66S2deLrOpr2qEy/bVUP3Mn0/k8Anfe3qc/Kw
         n/udwGni7k/eLDRlUv3XM9dC10WZj0JhptupwNJhM0uVURIXbrFjut99sZhqLvidW5w5
         UXnHlOdbQZcKcAbQh6E7kTUxTiWNnDcld8+F7fvTqngIy+lm5fi8l1irrsdFRM6q5XLS
         SkCpeZqx/zKTNm8j7uTENkReHI9WO9fnbcRm9U/iOftJo1G3kQNQ26sL7DfB0PUOB6Ac
         +H3zVOr6UmgXVcUYWwuURGpfJXUDLPM12EFo157qZUHe12HPK+NtdFw5Os/DMm7YfXL2
         cAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326807; x=1794931607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sVnxZNWX6ViUZL7bQPqGM+4jUAh9aQEpBFmSldUmrlQ=;
        b=T3XDt222tl1gIPK6ig0pSa4DGi8biHShaXHKSfQ0g1yhFZIJnltO2LZCPZ6UeI8pza
         BPb6wN3piD+PMzvQnXW6twXwjEzoWNxfSYcnPpqrM9TbHQ9L0eUNoytbPq3XPE9wumvU
         k7B1ps8vZ2SB2WfGZkSCBnbYGTDnwlb785N58DbCeYXURb2tMhWsaLgaBwFFUbrwEr1b
         68YfCo8xkijDv4hkvhDEUPRvgz+OYJDNpjx8r6qOnHiSuFzj3fQNNrJApIowAkYiovk7
         8sOTH+8Hh4MLf56fZ3+GLpE5JOLjMLUqCyp/JtWtpzp6FD7N10ad/0ffAaCM+m1Kgg7F
         7Whg==
X-Forwarded-Encrypted: i=1; AL+hErFiYCBzjJkn2Y/esE8t1+VLWOF5aoDka2UWNCqJ0zIoqZYCxiM5JIwqCfFOCGGkrq31Jc0jt3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VkYp4zJL9FnfmHlOD8PS3gLWRtql5FurheLm0oMTWvlkKg9io
	DJQaxH4E5N65bols5/13m9qCPZAQA+2R7c48jFs27K92caVL33UMeXs6
X-Gm-Gg: AYBFou0U1JLIY3SdyfF/uQaoOMQYjmi3epmAE0IuBeRmaocuAy8Tv+qL50mmU7emxSG
	mjocjj8WhkPiHm6Ghz8iZ1CIqpvtVxEJDM+8c2pztppVBTMaQW/i9E1R7Jn0KzoZDpMOLIoummO
	LiuLso3QIny21JXXa6twilzEskbd7CY+OlFV/E8Q/4fQJ2KOzYPX+lDqQtO8fB6s0l9T0y1znHV
	UarTwBWBUjt43qQ3z17hO3Fa2mwDLxfy4wuGwisKz2IQ78GPFN5tc1oAEHVnC+Teo9PR/C+cdnZ
	A4Ho71Z1/hTYekt61skqwiWwQWb1rers8inDxrBwDr/gj/kVf1DN+j/xgxzs6fEE0D1CQaUF9vC
	aT+XHOQ1R00grA2EpUs+VPqtvcUTGZ5j+v+GquphSp45zgjh3quu+5WZ0dDgF8QR9lSeMpc5nHv
	inazYk5KUowjIkXy6j5GcquTAWm0Qoh5z2aocBO3RIY1ex8RweDA5LOdW+evCcPIpjEoQWPMf3O
	UQknj1T8T0hBbZnlD958TgkyImEnjrHn5e2Le7qA/Da/xn9TB7zfGOs873QhlukY0esYvnukGv3
	o1RkRBue2dmpodcGELlglU5nX+n2PCwLOo6eQVLaEWaNeAye
X-Received: by 2002:a05:7022:1505:b0:1b3:ac53:da84 with SMTP id a92af1059eb24-1b3b603ea3cmr4271960c88.32.1794326803608;
        Tue, 10 Nov 2026 08:06:43 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm8453403eec.7.2026.11.10.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:06:42 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v4 2/2] net: pcs: xpcs: make supported_interfaces authoritative
Date: Wed, 11 Nov 2026 00:05:54 +0800
Message-ID: <20261110160554.918652-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110160554.918652-1-coiaprant@gmail.com>
References: <20261110160554.918652-1-coiaprant@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcs.supported_interfaces is the mask of interfaces a given xpcs
instance actually supports. The compat table describes what the
Synopsys IP can do in general, but a specific integration may support
a different subset. For example, the RK3568 XPCS supports 1000BASE-X,
SGMII and QSGMII in hardware, but does not implement the C73,
10GBASE-R or 2500BASE-X modes that the Synopsys compat table
advertises.

However, xpcs_find_compat() only walks desc->compat[] and does not look
at pcs.supported_interfaces. If a caller ever passes an interface
outside the mask, the core would still find and configure a compat
entry for it, contradicting the mask the glue already set. This was a
known gap: the mask was written but never consulted by the core.

Fix both sides:

- In xpcs_find_compat(), return NULL when the interface is not in
  pcs.supported_interfaces, so the mask is authoritative for what the
  core will configure.
- In the Rockchip glue, build a platform mask with the three modes
  supported by RK3568 (1000BASE-X, SGMII, QSGMII) and intersect it
  with the core's supported_interfaces using phy_interface_and().
  This narrows the mask inherited from the generic compat table so it
  reflects the actual SoC capabilities.

Note that QSGMII is currently filtered out (a no-op) because the core's
compat table does not support it yet, which demonstrates the intended
filtering behavior of this intersection. If the core adds QSGMII
support in the future, the glue will automatically pick it up.

This is a logical inconsistency rather than a user-visible bug in a
released kernel: the affected Rockchip platform is not present in any
released version, and the MAC side forces the phy mode, so phylink does
not normally pass an interface outside the mask. The patch makes the
mask the single source of truth for both the core and the glue.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-rk.c | 10 ++++++++++
 drivers/net/pcs/pcs-xpcs.c    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
index ad187fba4e9d..e29f473776b2 100644
--- a/drivers/net/pcs/pcs-xpcs-rk.c
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -480,6 +480,7 @@ MODULE_DEVICE_TABLE(of, xpcs_rk_of_ids);
 
 struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int port)
 {
+	DECLARE_PHY_INTERFACE_MASK_ZERO(supported_interfaces);
 	struct platform_device *pdev;
 	struct dw_xpcs_rk *pxpcs;
 	struct dw_xpcs *xpcs;
@@ -536,6 +537,15 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
 		return xpcs;
 	}
 
+	/*
+	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
+	 */
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_QSGMII, supported_interfaces);
+	phy_interface_and(xpcs->pcs.supported_interfaces, xpcs->pcs.supported_interfaces,
+			  supported_interfaces);
+
 	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
 	put_device(&pdev->dev);
 	return xpcs;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6466e0ff2a98..46878a66064e 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -169,6 +169,9 @@ xpcs_find_compat(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
 
+	if (!test_bit(interface, xpcs->pcs.supported_interfaces))
+		return NULL;
+
 	for (compat = xpcs->desc->compat; compat->supported; compat++)
 		if (compat->interface == interface)
 			return compat;
-- 
2.47.3

