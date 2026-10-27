Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140331;
	b=1iEwUQ9Fk+hUO8rjHAARx6C0C9rWoOSruiUvua0gbFc9cbnlcRb+Dd78gw32vuDjPVjU
	 pWjwjNw0mzVa85tTqRYKr3CvnYanZKZ34qswb7q7u70VPh+PXnXeKLqfy4mV4tOQnOTPi
	 fdvH5AbDJj+NDmziefc32yrW4OdjeE9nRrXwo37q32eCm3gc/6qccSkq0GSRXRreGLGCf
	 edSymG7P5WEh8Dw1xRaTwZ6l6wPJ6sacp0hh6JIVmY3q7Z5QCpakhmVaCBObdS9TLVIBh
	 Xyi+iZ65T+SzIx9bdUlT1FpGDKynhpNTgp733FbSS/8g/rmCZJq7gHDT1hYIMvIsJyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UVKrm4SxR7vRiZDaPeH2gqLrUndpLkILXeCxDkU1Wtk=;
	b=Zx8XO8ITKnpnuS2HZ5uyjV28ymfHVTPWY5d9VUpp1wE7kIwF933YCv6Nw6FmfVn/vQg4
	 jYinNcDM7UCjZl8mbPi+8rTW4gpJudU3Wvopb+WpblFdjNUdjVekShmBrpDZi7COuveOa
	 0j/fVlFz0e/toNp7CEuRY4BFkOAUgKCUPDDg3yvYkXilBKsxYDS9fWme7C+SghaOnsu/a
	 JhSMKeuB07yfcTTVTbXvO0v4681kt6vDzJEFKgmDJslxlX3Ipa6WD6zP6X2M49iDaFsae
	 DvNImt2FowNMftNaYWhHfbHNp2ByEuPOVKVru3r94dRUzznk9Dtnu86iPHPkKbGsa3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Miy/4m91";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E2606A32D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75E2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Miy/4m91
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-19305bcb72cso317933c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140330; x=1793745130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVKrm4SxR7vRiZDaPeH2gqLrUndpLkILXeCxDkU1Wtk=;
        b=Miy/4m91SGotJnq6ko0yK0avIrbhSItJ9Iq8AzCMmKJWwAju1/IUzTMCsc6SyYesoI
         0H4D7eMqNz8qMY4v62ZhA9F2PICDurIm7JMbnzfCHmwh8U3yXnICuyXytzTGRdAQTCNY
         A0jRta6C78xUJ7L8sS7h7uDrXWe3BiEExf7KEbxnFyxouJE4KXNJ3ZwtWKkZpdIgXvrF
         a0r8hkALTIMysEUsJtUd12PqdLyjWwvOvS/Gu1TPT0ENeG3k90CQQBLx63a56lc4q0UI
         lRzfSAobUDfLCQjG3QqRJ2gmj73FkVAhCVe7prsFYLNmH9lTabFmpiHEMv+RELD5aBgt
         J9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140330; x=1793745130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVKrm4SxR7vRiZDaPeH2gqLrUndpLkILXeCxDkU1Wtk=;
        b=meDFFhiAjtzJCK9jYskY8vo0zv/TdmwHLVfhy1oBKwkbepOOUPPJqZirBS73iQG7TF
         KYTzNIWeaQHASbrOMswmC3lBKmq6a8uEf7zfL5ozxGIWzOeri9Gcv2L2upK9+Was9G4q
         3iRlXumbO3cCtr1Niq0Zvixjf7iU4kbRw1+WIKDBDzLVEpew5W2KKB7zH4yoVK9hHV5W
         9ECf0X1dvrEgWIIFNm3bJd8GoWiI4uL9dL87E1SvrRVaS57VC1K8Ocjidq/XlF+rp3fW
         LOGS8YRYDY42ogvg5HXpq84Tl9jp0/A4V5WU8KVItIXVpUQbVYizBMRTEoM/WPAq0/T2
         gxVw==
X-Gm-Message-State: AFq9FYK8YeRqlZNQSgWbCmA9S+UlF0culCtNZZXX1/9DSWSHUzKbASbj
	SaJNk0zrk2ooJ/xbm9ee6B/lH4paXVEaRDCxAT+jd5J9z2b0mPCA3ngQ4NZOtiiw
X-Gm-Gg: AYBFou0QZtMVN7cDSdAM0p9c3O5eHpteKEYRuRbIYzhfUHX+cKF5w+xX2WOuTA0Dpwu
	I8ZZivdKXsTya04OCl03iwgCI9lxbLCw97rKNjhqjICKDPVrgAXnIzQpJO6OgeVtBH6lGX9qIQx
	/MwfVihwu6Lfn9M77ohnrsFxxcR8PwtuUfC/mNDihH214IGhmMJw6nLhwcMdHEASFIgpjEALzwj
	y8VHOa619gBdQDeE7iKaJ/4wQFGWvi0JdMiWnP82iZWQWdh37ARNNRCMW4ppPLQwxEqmNRdWApv
	OWL5kWAM/uLMmlez2NNhS3GCRGu5udF8yDAj6JQAKpLWr4SfqbRUpYV1NEBffRrafXE6Ej9TOJw
	vl55w++L5lF28n5v6GDA4RiiGb31u7066Dn1FUiVxiECI7YX0mdghUX3fPsyxBFov+jgBWnJLe/
	B97i18/Jsjmja1yeyJ9GCPmEQmAmnb1ozxiNjnEE1EZh8brqcYDnXU6ha1gpc5OGywnF3P+fhMS
	QJvHWho66KpdvrNBhsq8284uEwmHBtQbWqaHSUra8Whx7Pr4Xvbpd6ohIDhdSUeDHauBIGGT2F5
	X/olWw==
X-Received: by 2002:a05:7022:423:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1a6c2e5b801mr1106860c88.0.1793140329772;
        Tue, 27 Oct 2026 15:32:09 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:08 -0700 (PDT)
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
Subject: [PATCH net 08/11] net: au1000: restore receive filtering after MAC initialization
Date: Tue, 27 Oct 2026 15:31:37 -0700
Message-ID: <20261027223140.3774570-9-f.fainelli@gmail.com>
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

MAC initialization overwrites the receive mode, dropping promiscuous and
multicast settings after a watchdog reset without notifying the network
stack. Reapply the current netdev receive mode after initialization.
Protect the control register read-modify-write with the device lock so
it cannot overwrite a concurrent link adjustment or MAC stop.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index f8976e324f0e..6b817d18329b 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -684,6 +684,8 @@ static const struct ethtool_ops au1000_ethtool_ops = {
 	.set_link_ksettings = phy_ethtool_set_link_ksettings,
 };
 
+static void au1000_multicast_list(struct net_device *dev);
+
 /*
  * Initialize the interface.
  *
@@ -742,6 +744,9 @@ static int au1000_init(struct net_device *dev)
 	wmb(); /* drain writebuffer */
 
 	spin_unlock_irqrestore(&aup->lock, flags);
+	netif_addr_lock_bh(dev);
+	au1000_multicast_list(dev);
+	netif_addr_unlock_bh(dev);
 	return 0;
 }
 
@@ -1038,8 +1043,10 @@ static void au1000_multicast_list(struct net_device *dev)
 {
 	struct au1000_private *aup = netdev_priv(dev);
 	u32 reg;
+	unsigned long flags;
 
 	netif_dbg(aup, drv, dev, "%s: flags=%x\n", __func__, dev->flags);
+	spin_lock_irqsave(&aup->lock, flags);
 	reg = readl(&aup->mac->control);
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
 		reg |= MAC_PROMISCUOUS;
@@ -1062,6 +1069,7 @@ static void au1000_multicast_list(struct net_device *dev)
 		reg |= MAC_HASH_MODE;
 	}
 	writel(reg, &aup->mac->control);
+	spin_unlock_irqrestore(&aup->lock, flags);
 }
 
 static const struct net_device_ops au1000_netdev_ops = {
-- 
2.53.0

