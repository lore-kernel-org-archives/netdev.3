Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140319;
	b=mCNHhkc661w0OphM+06XGpO5SyJZWEl4lGcHlXf3OnPkkAtCME9L5lBv7JmPDLvjKJLo
	 VG69ue7o1VXYwqGweh2BPkv2faVFnFxD0d4VGvfap8/g790vWf/upjPbbMlt3dot24nPx
	 dpTVkiwasiMX7TvBzD9F98rv8p+fzDhTwtiovnkel9Qau13eVir8UDdWJWMcjZPQbTEYS
	 M4R9JKfxcG32sJdVTl34NyI6opxgum8pPoL9glq+gnMSPUi9TxoRX1DXYan4CwOv8QUZl
	 hm8mPEU2j0aqknfjd0CLBIbTJp6FRGmbz1X0I+CfzjUSzbl+WXlcNdX32sQ5fT31fVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+PPpnOQxSZYwtu5QSb9+JP3bYXbtqNziMbHySC33BY=;
	b=untWH1Gx5Nrnsjs8zxyo7GaKl+EvY4jsmyov0Ynn0SRHGmv/NWYDCKRInBnAFjQfaSGS
	 zwFBnKWeYLDb0y6NLI0374TVSLCXUTYDM2YfFnoYK+UYx287ynBNR1WXy9BpGpEiqU0rB
	 sXpLBCPEI64cy+iMCFDKvRTSlvcr6IEIXwr3L88SAs+h5K1NUjmsj4/3Hv3e6SZaJW+0H
	 Hj+u/9vCHSr+9PkS6ryUbRQttMw2W0/I6JjEy62WRCvSOEBWrCG+22yI02KEyp2Pa9CCW
	 90aOe3icGYHFKR+NDsYB1D0citH6R5jwXm9UzlqZ4LuYk/qqks8P8deEaTiaLyx3Gcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnh5+UAi;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0A606A336
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA0A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnh5+UAi
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-188406bb948so286287c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140319; x=1793745119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+PPpnOQxSZYwtu5QSb9+JP3bYXbtqNziMbHySC33BY=;
        b=tnh5+UAiqE5hbSR12IUGc/3SZ/hYoTA+p4lXS3Rl2dMCTFRJV5PFKgnl+CMyAYsfm2
         ySDOeOfrolTiyo29GYAz2H8erQEJEO6oyr1IWS2VMDaXsYeHXXpa+CsKj3KuJej7Zz5t
         GtZIJo+y0Ljo5FhtiLHKJxZfggPf7+VsOrX1ma37oiG3F7v8V9eBVcWFvB70CZsIfToZ
         VW+mtoRE/b9ofi9qq6ATgMWSH037xvUdZUlOCUV4VVDBwk91XUCsw7DHZvRBE8JiymvO
         zb4HNi3MyV4MA/o90oPyvXhBXLDF0LW8ucPjulgkwgCYQKrfHEQOgZ9OWxzEmxAn8aLw
         0BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140319; x=1793745119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+PPpnOQxSZYwtu5QSb9+JP3bYXbtqNziMbHySC33BY=;
        b=sUdL0zM7cLgetsLKWnlAhYxa2knz+RHCr4VsUVJ7v1NT69tPPbTPz9IGGSQJTpZv3l
         qbaiEC6muHlN0fMSlZEAWaY1rJhVxZt53ZheygcxwEP3Ha0yrCrtGwmwy5tlIxnJaTFO
         Op/hEvlNkGKaTQGQM8syGw7SZL107dYHt8yA8W+6mPLYpRXz/YTpv6geQoqQTkNHc9VK
         P/QMdm3oGu9wxbLxA0swdLX1gyy9puVL7p/HrNQwHa0VY2XlnrWz58dBI78ZfVqJABqU
         eGYmxglfACt1bW4G1dD0pn/TPlGFv4i1HpVRWQnhdGKPuBDU4YL9eDKFIdx5zNyPAibV
         id5g==
X-Gm-Message-State: AFq9FYJKmUAOM2fSTswM0Dqk6YG8IXx2xGOR6RQKoJeFy3yxFD20drWE
	rwxWlOYbk2L48i1IgZn6uU0HC0zHfgfv/2YoOTmg5j9VsVcP6/WlMkKeiDapbrwJ
X-Gm-Gg: AYBFou19HthxU9u2G3g+qrBtKiS4OUV+rmlppwtQfxZisysaRad3TCJ6hn3+LdurKxB
	SqdYwX3SRTLuPo8A0xl7iY7anW/35XZi7Tzwyhbm/yiAE2f6rfQAP4QZukuw8L/7l4AqgiswP7O
	IuT3U7qzaN6+76MGoYepUL9AVP1XQDPLt2GOIcTsZP9V5MBl7PlRuDwn6OFewuYQziHzW/JZ1m7
	htIgNxLeW5hG6orIBTGU4wPbQcPiizI8YrqLojAEfg8dc3GWrG2i3RokFxkByX7IU4V2GDDdjf4
	76e+SOUZ/Wvv+elbtXx77hMqQ2dqRMCbfQgxjJzAeA1jCTMZNAK/D6nTDSU6wikXfDG4zRbMFfj
	RTmQYs5yX9w5G3H+DZfx7ezEiPNrDfoMIoM95Vb//2Bi/dkZl80W3331r2ZMfu1j/rADCS7//m/
	+4R3JH2X1NzPh2QRucsLQOxaAsMyEYiBkuRpr2fRz1/b/+IyzLB4K7ZJcMngUuqugI4XFLdXZvK
	IjoyMoOo1Vic1Tajf5UCYQ3EKhnXWJkleORf3CQH8ckKKzUiKaUfOCq44XcCN4ghQRwSxaTuiS9
	MSbaAg==
X-Received: by 2002:a05:701b:2702:b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1a6cd77f059mr627923c88.15.1793140318317;
        Tue, 27 Oct 2026 15:31:58 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:31:57 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net 03/11] net: au1000: disconnect the PHY before freeing the MDIO bus
Date: Tue, 27 Oct 2026 15:31:32 -0700
Message-ID: <20261027223140.3774570-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

Balance phy_connect() on probe failure and removal. Otherwise PHY
interrupts, device references and the attachment to the freed netdev
survive teardown. Disconnect before unregistering the bus while its MDIO
callbacks and MAC registers remain usable.

Fixes: 0638dec01e89 ("[PATCH] net: au1000_eth: PHY framework conversion")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 58bc8e1b539d..70319b432182 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1287,6 +1287,8 @@ static int au1000_probe(struct platform_device *pdev)
 	return 0;
 
 err_out:
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
 	if (aup->mii_bus)
 		mdiobus_unregister(aup->mii_bus);
 
@@ -1334,6 +1336,8 @@ static void au1000_remove(struct platform_device *pdev)
 	struct resource *base, *macen;
 
 	unregister_netdev(dev);
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
 	mdiobus_unregister(aup->mii_bus);
 	mdiobus_free(aup->mii_bus);
 
-- 
2.53.0

