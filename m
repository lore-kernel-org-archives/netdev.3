Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0D3A48F6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426552; cv=none; b=iONMc06vqv9vK4aQ38yqD2+5+Z2L1DDyrn3r8IPUFV1PFDqrpGShJCw8Xd67u5eZPgDXW+2UGJnq7MtpQqfSAYphGtwlCS9NegnqyHPkkK6NFmjgq0UJh3qHYHyhmobVSKo/kIUf7pZvSlBXsK5VK9tpN/KSMI3RxLNBVK27Ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426552; c=relaxed/simple;
	bh=nU9QI7lMrwi5fwz2h6IFe8s3YbLmKmlNRTkcI+D/iCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbjG2U57IKhY3OygHhg4hKStqgpdqB97ACEtHBXCHk7KbWMJ9/1UP4k9pqt+h4VFBDo6+Y2ucQelblnonriGsdgnH/87cBsiqRVbtlgVRz17WCxbSPlptzLjJjMyMwvhR2ET3xD5C7OsdARToDKOnJyC7TOXi7Nf6wv+rcuWg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmvxIQ6q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmvxIQ6q"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6e954afbdso20098045ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426551; x=1792031351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeu19lsuIXp4350R2VFt5HGY0igWCtsP+eL+xnwXOpg=;
        b=AmvxIQ6qfylWDb8qih6iXXkyar/QZBrvIE86zyNQrJ0J5ujKXbPuco3+Z/dExaF/RD
         ZhWLqLoYlHWPnm7mVUO/gHUiHxjcxGRCvRzpdF1A+Y5JROC4jWdfdn2J7o/W84r4xM9n
         wymXjvbZhfvkE0byisjpzliFzcPJJvlHRjbmEcC0+ieOXMu0ywG2gqFHVdZqFCRPmQgY
         4B15dpJVdpC+9R2VD7xhNO67gnC2W8ody1cK62Zy1FJetg1sEKgxM0ZE1ecmqAt376s2
         mUchtX2gieRpwqdff/blB/7dH1xXqWibW13MuyHlmZY/B1/tKM/uZpXcqvK0j+s8WOl2
         /aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426551; x=1792031351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeu19lsuIXp4350R2VFt5HGY0igWCtsP+eL+xnwXOpg=;
        b=t3kJYVmezDTUqTMD3zWmbaadGQbakw8Bp706aupTdEf649QlS0iH4z++wTOkpqaG1Y
         0XWgV7EEv21fz3UkXy1UwFRlA8hz/HG7xMU9qEf7YKUviNOZE3MyqXRuBigM7KRFjHsC
         YY/wxcjsznq40tmZhbra5T/mhDffLWa3tHNktJo+zowvbgCLLvcDrjp7Fhd6XRze/1mk
         Qj2D9Ap+LQtyNGn4DbdalFj0FV55nGYwThz9jRm3F4qjIfl+KA3Snts5BREc5S7dtkgz
         KupkVxBp68wR0I/CEWf9nufmLUmmN8WYlv2W4BEYZuD8N/QL+NBD0kcrEmP88rdt5y5h
         8+RQ==
X-Gm-Message-State: AFq9FYK8A9a32E4C2wMYAGzAdFsZi9UbFlY9lqVb0/1Yg8ZhTjllSsWQ
	3jJKbjTfro3lu98i9GlbwIREqIczpz6PuvXtEaRIsQ1PSRUIsc+PGJAfjpBjIojS
X-Gm-Gg: AYBFou2f4xIfUmRb+1Re8Y2K1XwqP878ia8lXxqATovqERUfRvcZzl6/xQ3pXHte2rc
	dkfkheDmd9OhiMm+miVnMg7VtJhAVfOwcYNtNtR0aaENRbaHnNJUfbZqwMtCdESIGn8CGnPaIl+
	t/mPjG0Q2urcwqjq74apV7gpVMxdMXDrfZvkTJasN0Rb6K59fMzXaA5HSKBUm1aw1KOAYQPMtYA
	f2zGo/UZoYAOuZTCPMWGQGe/jGuUefAElaHcioDfuTx6zDIY+WF74JW9NgfiKM2bnPK1W6+GcVN
	7C2o641q+L+tNyQqCEZwuOIOpQQ3K8LXpcKgrelK1lk/djpSOIaRN7q3L4l0mUxcg16ICPkQst4
	zMcN7V98phLqDRLL9NeqgLyB3YWdD7Yz5RTV9ei0/C6JQPp6LwDlzfJRQ/FkAgzKvl7NXY+MH/N
	cUmTCI39s47MFWIG/p4k6Zv+Zy3G8Qhe9oTZELmkF7LXy1lCY65ryO/cotNVWrszcL7BkUHRG8I
	TWHVaUHTwaz1AirzR7a1D1vYN0=
X-Received: by 2002:a17:903:3905:b0:2e5:e542:fe34 with SMTP id d9443c01a7336-2e5ffae5a84mr39318505ad.4.1791426550965;
        Wed, 07 Oct 2026 19:29:10 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:29:10 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 07/10] net: ethoc: move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:49 +0800
Message-ID: <20261008022656.3592191-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethoc_probe() calls ethoc_mdio_probe(), which connects the PHY,
before netdev->netdev_ops is assigned. phy_attach_direct() ->
phy_link_topo_add_phy() reads dev->netdev_ops through
netdev_need_ops_lock() since the commit in question, so probing crashes
with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/ethoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index 0c418557264c..e5b7df43e8f6 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1211,6 +1211,8 @@ static int ethoc_probe(struct platform_device *pdev)
 		goto free3;
 	}
 
+	netdev->netdev_ops = &ethoc_netdev_ops;
+
 	ret = ethoc_mdio_probe(netdev);
 	if (ret) {
 		dev_err(&netdev->dev, "failed to probe MDIO bus\n");
@@ -1218,7 +1220,6 @@ static int ethoc_probe(struct platform_device *pdev)
 	}
 
 	/* setup the net_device structure */
-	netdev->netdev_ops = &ethoc_netdev_ops;
 	netdev->watchdog_timeo = ETHOC_TIMEOUT;
 	netdev->features |= 0;
 	netdev->ethtool_ops = &ethoc_ethtool_ops;
-- 
2.53.0

