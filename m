Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709848;
	b=e4NrIdUg9k1p3u3S0jmgI+7MJ8OkTWszZ3GjwG93hHacIV3ZaOqoy2She4qsK//lQyIy
	 XYORwRjgukhd0zwPDKL4AK40ZFjmuyrlzqqn+VdKbkAzzYWEpG4PO40TRcpuVgtldTR/v
	 aOqQvErKOKMin8r4QfCEzAVo8b0d/c1YFs6Em3BzmH++ubdqBbmhVvkESoR0GI+l3sx2p
	 ZPiA1wbQYYybnduqEVBVfGN2gpywECB7jlXtTR1sEw7gU9uqhoeeo1Fnyb9JIbGZt/Xgf
	 AkiUMma9tokS/zri9lF5xnWitKPAgNNN7/2dwrFr/mWs/MijIEtYLvl1dcaUahNgXFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709848;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=0hgSB5REeOoOU4+uL52FWMra36mU3bq54+5dt+GWlSg=;
	b=SWwC3GAjwcFy3cNoLSwo8/tUNdBawZ9NjlAMGIDp2c2/go2y8VYLSlmQNZ+WmoBwxPfp
	 yWFDTFeZun52jZ0miPeofi3ieIrNzyFfEgu288FZOXOVCDHMA7IFrma/4IgP83w4DAjiZ
	 qfnCjrzXqKpgh5Ovn+SVbJgC8Gev62AMNyNl2+K08avf+u3sJHfDW2GLKGQzVEasrblVP
	 Un7f0krMOi0im9ggCJNRzlvVEbodklNyss74xG5Ci96G0uURvXKK5et0pqYMkBFglLGo2
	 25MEu5D9NXmTD1peoE/ZMPU2sPdSysqDHXTTGhE1zQmqhw8JqsoamiGGSJ2HwmNF0Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kx9o1f+1;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1D60A260E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A1D60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kx9o1f+1
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so129962a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709847; x=1793314647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0hgSB5REeOoOU4+uL52FWMra36mU3bq54+5dt+GWlSg=;
        b=PJLAx6fQp/EEhDqV8guAsRdwcrpVorkhgQcK6h3T5Cq8T2+3o+Gl3IdSMH99S9vTn4
         HnkVrHsdjj+gXjQwjnzOkSQis0u75bbZ3fGPmEeN8noEpQlr1gDIgrloRBeFfVpV2L15
         wm7UBbNWD75AezBd6Bx7YfJxKAnBetL/C+x3LBL04m+rJ1c3nNqcFRYQkDIgzlLMavS6
         0JJRgrelIXFijpoQRKlaBGyRq6JEFPpA5Yp9ignEJglZCrtC/xzPDTWjOlSiQeQuz6wQ
         6W68AtCotn2uHEWJosu+bhAt5UWuE6TNfvuzqg64z1KPTs47N6vclAnKSHUsGz+hSPVG
         pKXw==
X-Gm-Message-State: AFq9FYLcb/Wu3ubKMibf4k31UbgoLHDoLD4kv5BOgQ190uQKrrxPhL22
	ImU6wHpltECx5p9JLkc3vEjBiVcKTV1v332WZbcqPLxGdhIjk+1T7EzVRb944BwZaaptBcPZilW
	GiasB6oyHevpX5nr+UwS9Xs3dCu0dRxRwh8aXetHFFovIBOBGAtZous3pLY2Qlje0WqeHxenSW+
	U0UQdn9AzRMUj/gghG9rRyO+5Z/kB7IDI7OUoPVSBbtyrILF+FrP5Rw3ipMWxWKcwomLIcOB7G/
	2hSdyoQLoJ9qTV+
X-Gm-Gg: AYBFou1/Yf/2pPMwA/+EKAJltfEc3XxkpB5zPOuOxwJ6DwgiqRx/iQoCrD+iffoRlLl
	JQwQTzC7GX2EK4fQ57MOimMSOHA0gc9ukJ1punfzGyF4KA8uyh20lPNwgPHXlOJKtPEeEscRNTN
	SFXL5V7X3zNzRlQJZ2SlMxA4/tbbqAecwWSQ+sQNukDCZ4bQmJnsrwn8MxDZUN4MMDQQgVHgrqG
	Xt2p1MLAqnflJlIvDFHVKXrD4fOqUDD3dIqXIRDMoF1vKwoFtIpPLPxqaerZ+Rz/4tUQGF8WSQh
	mluZDu7lL1I9kQYYrrgMVcVSJT8FfnZb9sczMYDteTPjmavGRwY0NBpPWJxzJxJMxUGpiNuIM9T
	Tsfo0A93i34swPDSvRWoyI2y7XPqjL1/DOGUWlNdVTovEjEEqpCIUZTGmDBTxsi51WgRy0cjMYc
	KShnI/QVq46WZOzPdRknqr6he36GhbwPW4To6D0zmv
X-Received: by 2002:a17:90b:3a4d:b0:3ad:68f7:dbcd with SMTP id 98e67ed59e1d1-3adce0e1210mr297878a91.55.1792709847452;
        Thu, 22 Oct 2026 15:57:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adcb1c5c09sm452440a91.5.2026.10.22.15.57.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b8306ba68so7812546d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709846; x=1793314646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0hgSB5REeOoOU4+uL52FWMra36mU3bq54+5dt+GWlSg=;
        b=Kx9o1f+1Er2yF9nGynciYriCgi+cGH2pLyBSUR/amEKN+/7Dl9XiWSe/gNkkjm5IL0
         OVhBBRnBhBNSUD7KCxqHsY9b/i/XtXDjWUOkEJl0VaCsZetdegoOJvjPLAO8eGc/MJsS
         HoktTTY3ewoQY5JMfycIV1sf/fJay74oFEZxA=
X-Received: by 2002:a05:6214:d42:b0:91b:5d3b:7abd with SMTP id 6a1803df08f44-91c3ab25d34mr4344476d6.57.1792709846095;
        Thu, 22 Oct 2026 15:57:26 -0700 (PDT)
X-Received: by 2002:a05:6214:d42:b0:91b:5d3b:7abd with SMTP id 6a1803df08f44-91c3ab25d34mr4344166d6.57.1792709845589;
        Thu, 22 Oct 2026 15:57:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:24 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 6/6 RESEND] net: dsa: b53: apply resolved link settings to serial port MACs
Date: Thu, 22 Oct 2026 15:56:56 -0700
Message-ID: <20261022225656.1387306-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The serial port MAC callbacks leave speed, duplex and pause under the
hardware's autonomous control. In particular, changing phylink's pause
policy cannot affect the MAC when Clause 37 negotiation is in use.

Use the existing MAC override registers for SGMII and 1000BASE-X links,
including PHY and fixed-link negotiation modes. Apply the settings passed
by phylink at link-up and force the MAC link down at link-down. PCS power
and link observation remain independent of the MAC override.

Preserve the existing parallel-port handling, EEE initialization and
BCM5301x CPU-port pause quirk.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 50 +++++++++++++++-----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b04f9d5f0525..172ada124cbf 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1600,6 +1600,17 @@ static void b53_phylink_mac_config(struct phylink_config *config,
 	}
 }
 
+static bool b53_phylink_mac_needs_override(struct b53_device *dev, int port,
+					   unsigned int mode,
+					   phy_interface_t interface)
+{
+	return mode == MLO_AN_FIXED ||
+	       interface == PHY_INTERFACE_MODE_SGMII ||
+	       interface == PHY_INTERFACE_MODE_1000BASEX ||
+	       (mode == MLO_AN_PHY && is63xx(dev) &&
+		in_range(port, B53_63XX_RGMII0, 4));
+}
+
 static void b53_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface)
@@ -1608,16 +1619,8 @@ static void b53_phylink_mac_link_down(struct phylink_config *config,
 	struct b53_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY) {
-		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
-			b53_force_link(dev, port, false);
-		return;
-	}
-
-	if (mode == MLO_AN_FIXED) {
+	if (b53_phylink_mac_needs_override(dev, port, mode, interface))
 		b53_force_link(dev, port, false);
-		return;
-	}
 }
 
 static void b53_phylink_mac_link_up(struct phylink_config *config,
@@ -1633,29 +1636,22 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	struct ethtool_keee *p = &dev->ports[dp->index].eee;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY) {
-		/* Re-negotiate EEE if it was enabled already */
+	/* Re-negotiate EEE if it was enabled already */
+	if (mode == MLO_AN_PHY)
 		p->eee_enabled = b53_eee_init(ds, port, phydev);
 
-		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
-			b53_force_port_config(dev, port, speed, duplex,
-					      tx_pause, rx_pause);
-			b53_force_link(dev, port, true);
-		}
-
+	if (!b53_phylink_mac_needs_override(dev, port, mode, interface))
 		return;
-	}
 
-	if (mode == MLO_AN_FIXED) {
-		/* Force flow control on BCM5301x's CPU port */
-		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
-			tx_pause = rx_pause = true;
-
-		b53_force_port_config(dev, port, speed, duplex,
-				      tx_pause, rx_pause);
-		b53_force_link(dev, port, true);
-		return;
+	/* Force flow control on BCM5301x's CPU port */
+	if (mode == MLO_AN_FIXED && is5301x(dev) && dsa_is_cpu_port(ds, port)) {
+		tx_pause = true;
+		rx_pause = true;
 	}
+
+	/* PCS negotiation supplies state; the MAC applies phylink's policy. */
+	b53_force_port_config(dev, port, speed, duplex, tx_pause, rx_pause);
+	b53_force_link(dev, port, true);
 }
 
 int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
-- 
2.53.0

