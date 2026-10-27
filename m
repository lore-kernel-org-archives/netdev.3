Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140335;
	b=J8fDdMWJ/aC4IVAcNLDA4M0vneNfGg2cIAsJ4O+YEEa+9q7Sevg0/FzMYPZ0trVVchMv
	 2LBN+wWb6XaRt6hv6S4tOSvcX853Y0nUeG9/nPK9HjOFC4nAxTr+/ZyOg6Ai1ZansTNiS
	 IfTP8M9/TXBO7B6FnJRqV1Vid6xliXRM2tr2neBHEX5yjxV72vFmzSm6RDWBaQU8OyjsV
	 RMsFuhVCvpdSDYqHpQ7USprxQ2pHR35dXi5VT2nWjkZNIzytv3OZTN9wYSsmIn5cmv8/r
	 Uu/gfuhImAU0DW/w8xvmMUPSjgd+1IGYd2LZQ8uRM0lAr3GUsgsXnAMTELIbz3XbA0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HZPyG3s7DWLnksXjw7x8gzIGPWb9n7MYHVZSQ0mRqaw=;
	b=pYUNdt96QzC2dEFmD16x5RnOPRzHZgnVx2Xs3q0QTL4DjvpJRhIely/nxxdtQ8S9gA/5
	 wowfHjIbwArRqshJBqTrOAQPOVBYejb+Ke+gr2oqIBbWYLqIn3ZjoRczVC/2AYydaZToz
	 ctOPd17pGLRi6WZwM2aey8Om3Lf7ZLuDaCT1QKJ/9TCewgu8adrm+nAI8fvgw7GlD0msu
	 ApL2qyF3hrB19bhrCXOwv88SFk+KcMEVVFArZEZ7N1qPT9CzAX2TjiYPSBVoEM4p5PRzg
	 nOJA1Ib5FsOLzgHjQrJKATcKKR65VfDITkXeN2ddpTi/9R/vHmqQc4XGScOcfgAsuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qAVhB1Mz;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDE60A382F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EDE60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qAVhB1Mz
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-14394530ec6so404885c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140334; x=1793745134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZPyG3s7DWLnksXjw7x8gzIGPWb9n7MYHVZSQ0mRqaw=;
        b=qAVhB1MzvHea3AWoyYZcyCmQVJyz7UeIExsB/xBQwQlkQ9UVMFArnoqF39ubNHR3yE
         yf1W58qP8T4lPxx4NlU946vJ7T9C0UJ051quCX5hE7oJ7fxtO8c0QacTIfDsk3TCy2bi
         jBApGV/866kvZK4ErtSAs5Tz8XI+3fr5DsviLTZ7NE6cEcafOAWKmQ8rt+iYUGRFuAtr
         MLN+G9rF4QGIGiNhxd7ge+bYOGRgRbiVF8uH4W5oxdgxIhC4lbadjAz1tYpUkBRle+Ra
         J8WNoSEH+DyiG32LLksgIzxVrgZ9bfdE3Vj29U40J9fBXEklqtiSG72znIAOl1mZ/CCE
         ojIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140334; x=1793745134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZPyG3s7DWLnksXjw7x8gzIGPWb9n7MYHVZSQ0mRqaw=;
        b=Ld7Uj04rYfiZNi+D8c1RvF5RKwJNNLJRIWkWI55cf1zlULZG2n++fmPDnOwqfrkc5M
         fKi77HpXFqdLH/YcFRKtw0zdIk4Wry6T4r9USmRbDSU1NQHwwQLAji947KH3I8Scia0P
         W/26F0Fi9Usx9ekjG2p7Mg5fLoWe2/S90ao5uT7erc/mrQgb1+fXY/v9FBbZ2GjgS3pm
         O2mnLKzxEMjMYE6AwYsODL4lUN//mSy6niBzjiZv6s9WKb1HLyTOu90ZudN4SvunCq3s
         0sF3I3e0PF3llwXrCCprLwlvEw3hSkJZNcAGeMyxyDgTFr6sZEp6lcpBYc/G1gqisKq1
         XtVQ==
X-Gm-Message-State: AFq9FYLtk8as5Mx7Ls2+zSWexerWR5cqA3+gczxV/CI5S1BXeGZFexKI
	pzc4EH8qYH4Vq1zr4M7CVtkBFwj0+oVMpGWpSaJ4ptuZGm7IWZEbtG3AdKqZFXH1
X-Gm-Gg: AYBFou3Z3j2RCD6c9psVZnHif3n5ET6jqUU5X51EiLsaps25Uni82075hzbqOlD1KAJ
	16DfoEVp1abnqUTm4ih3smQwpu5gWZpsJlesACod4MEeE2XEDrSRwGN4bHbmUp7gE4Y8q7YDxLY
	qO/rwCshgNwskM9v2xJ+0/A0JuTvV/EUjGxjs5JRR+1/9QpUIHrNkvtXqWtW21PBgl0o/5UiR5l
	6zlHAei2NL8mEZaKJehZsphTJwh60BZpTgdyDFPmBAkPlw0sulryx/pL1dQ0vDDGpdBv+bF6ASQ
	M69FDiT4Dl+wkt8XO0LMWSYbD1BIRbTjItxTPoF5OGUJ/iR2R7EvykySWu2mjwmR35ShHav3RWq
	R/SzLZPhtP1Se0jRE+wOxfyO6CjgXS7gdLnM2oceskWcH2rXlWrO369ojHVA00H6UxWpErgieeW
	rc5i8r7W7g9cAA4ChlQwA0ESMYWR3G2aRhb0DtHqsyOPEnlMsHmJTxVueezKhg1s/ZJAsra4ZIn
	TrQxhByUBLT/TYCErgSVVcwzG34E8x7PQKn0gzy9zgEmbr+RRqdrLx7rOEQd+5L1N00eLfT+9/1
	k3daLM+tL5Xkxb4649vQRASoR2iDH+ldWA83bVxYrYfGP/XmHs3gAO0W
X-Received: by 2002:a05:701b:4288:10b0:14e:d0ba:7569 with SMTP id a92af1059eb24-1a6c9cdae05mr791294c88.6.1793140334001;
        Tue, 27 Oct 2026 15:32:14 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:13 -0700 (PDT)
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
Subject: [PATCH net 10/11] net: au1000: keep the MAC stopped until the PHY link is ready
Date: Tue, 27 Oct 2026 15:31:39 -0700
Message-ID: <20261027223140.3774570-11-f.fainelli@gmail.com>
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

phy_stop() powers down the PHY when the interface is closed. The driver
leaves MAC receive/transmit enabled on link-down and enables them again
during initialization before resuming the PHY. The MTX-1 can hang when
the MAC runs while its MII clocks are absent or still recovering.

Start the PHY before initializing the MAC, but leave receive/transmit
stopped while the PHY reports no link. The duplex update enables them
when the link comes up. Stop the MAC in the link-down callback before
phylib suspends the PHY, and stop the PHY if MAC initialization fails.

Fixes: be9dad1f9f26 ("net: phy: suspend phydev when going to HALTED")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 8c2dbf72652e..c616ce616541 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -458,7 +458,8 @@ au1000_adjust_link(struct net_device *dev)
 		/* link state changed */
 
 		if (!phydev->link) {
-			/* link went down */
+			/* Stop the MAC before the PHY can remove its clocks. */
+			au1000_hard_stop(dev);
 			aup->old_speed = 0;
 			aup->old_duplex = -1;
 		}
@@ -727,7 +728,7 @@ static int au1000_init(struct net_device *dev)
 
 	wmb(); /* drain writebuffer */
 
-	control = MAC_RX_ENABLE | MAC_TX_ENABLE;
+	control = 0;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
 	control |= MAC_BIG_ENDIAN;
 #endif
@@ -740,6 +741,10 @@ static int au1000_init(struct net_device *dev)
 		control |= MAC_FULL_DUPLEX;
 	}
 
+	/* The PHY may still be restoring its MII clocks after resume. */
+	if (!dev->phydev || dev->phydev->link)
+		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;
+
 	writel(control, &aup->mac->control);
 	writel(0x8100, &aup->mac->vlan1_tag); /* activate vlan support */
 	wmb(); /* drain writebuffer */
@@ -928,16 +933,18 @@ static int au1000_open(struct net_device *dev)
 		return retval;
 	}
 
+	if (dev->phydev)
+		phy_start(dev->phydev);
+
 	retval = au1000_init(dev);
 	if (retval) {
 		netdev_err(dev, "error in au1000_init\n");
+		if (dev->phydev)
+			phy_stop(dev->phydev);
 		free_irq(dev->irq, dev);
 		return retval;
 	}
 
-	if (dev->phydev)
-		phy_start(dev->phydev);
-
 	netif_start_queue(dev);
 
 	netif_dbg(aup, drv, dev, "open: Initialization done.\n");
-- 
2.53.0

