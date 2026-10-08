Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136622A4F1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426536; cv=none; b=BSwqt98ewuyLvoz3UAv8CuTT4eGJsrFg87KyDSQHQLxXaWSRbkw+GQjo5hfE2P8rT3WMxFDmno2zoMEAOFx+DwdbAFh+ib1yNFfzDYxp2k9V6JTv4lu57QBxB8QZvklaIWFBX3+Ke5k+4wR8Iuld3+zJjnE56ARmppMDgqu4HVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426536; c=relaxed/simple;
	bh=yQ7griu5XhD2aPhu4HbCisP++1R0bq6ceS2ER3eOUL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1LolwnI1pxgqVirE95bZHiXE+MjbP/vtBGQVw/R345wOaDK0XoBsk3VrfVSMrNWF+ROj78Uv4RsyQ0639+Xg++s/zdb4uQZLIZkCupH/NSZ4pXtfQLs+Dns6PyY3WBAO/7x+pvJ5tDeq7Uhpisz4NB+Ss64XfOE/vj6/qHXtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct7FEEzx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct7FEEzx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d560775ca2so13310045ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426534; x=1792031334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLLDCAsceokNY+xwokpVffSC3XQbfRGpIBX8r0xpvd8=;
        b=ct7FEEzxfZCawDvO1ssmUUFPlTUeMm2Z5ZDG8alfAeCGBQhy7OfPR3eGioMOp8cRTL
         KCHRMkQFatz7idV5ZTuWkEmJf8GOOuH0kwOhBiU6JiEVr0ZzQPNW3Y9N/aZJYPByRqYP
         a3+zRoAa8eI4eKkcQ4w9M/v14gVRJwqUz0NGmwLTWrx4H35rcVeA95Mk87CQwGHL4aKX
         mu9wG91a90D5n4RWu5U8l8vOqVd0X/fIGM4e+a5hD3Fp4fcYANX7AfS6xdAKqdehtgcp
         gQ0sQn39YZ9C7Jif0/KvPjaFTka4J8V+MqJVupyds3LtvU//DhpG01gwnR2t0z9w5clP
         gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426534; x=1792031334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLLDCAsceokNY+xwokpVffSC3XQbfRGpIBX8r0xpvd8=;
        b=qnW/Th+Jx0uon72S2Cw6aHS15bm4LNuSbELbNcTbHBJFSbv68Hx7gsKgCx9KLFvppC
         bUwigKrPZqg48SXJwoQaoesRJpuiphNMEndR4ShhYEhseDEchniaUQq98UuJjCtkDomn
         8YSOmAxSNSRLJ4jcZ8Ad1DD6EeRylLcnC6shrCo3vl8baWqtDnPk9QvIKLfUpq5RoMAk
         dmCpOFiAIii7VklFw+nZjgRwgpDNCzFxqBBn+MrAvNJdTpZJtr4DGYmEEg0y6ORnxLEM
         S8E18gAurKt4d51jgbd9iX6vD0uzMwlW6Z3duGQXiBjolAevAJt8vNKF+eLOlj7kNkIu
         Wh5g==
X-Gm-Message-State: AFq9FYL9InCmHpW4wdg/uL+R0VZ0xK8IQZWgBWjTtD+WirAhWxEjsQyG
	ubiFvXbEl9l1gx6YbH6BU8dSy8NfsVTwM6G+6Eglx04ZhqAJpznyTqa6VmZcu+pDECs=
X-Gm-Gg: AYBFou28avYoQyEitD2tjKIP9HEYlf5jwsxTK0JJ7c7ijbaNl98qL9OA9Z3T2gTvzz/
	Mk/E6i51VUe51RecOrM77Y6S2dR6hM2k/1uNb3C/p8I2VkSz1EiCiKa4PdD404CCUOoV3ayN5lA
	ldzq/HGKZpB3AIG3ITy0gXqsmwCywMrMhleHyUpPEgX5b+rLiEWScgSQDS3Mizawq+cNb41KP8l
	KgOwuIs3qSw1V1J5Oqungb6+3QskECbI2B6+Vkz7nn6aLOWeo612OPubG0vN66AkrXwGNgPl02W
	jG0Qe8RqKMbeJZFX/jgmmjBAeuk5wIZknliwGKiqVt78czB9qhm2kigG2LFRUpZcj4mM2d+O9FE
	uK96Noi3GMIIrHSBcQUKnTwo5Q8iOpHIrb5YbMqSYLrCgCzOzAU9NfDm+WwdvVW9dPxduAUJn7C
	aUwBbWzZlRa8EziPgRnyAVCw5O/ETaB/9+IN+9QHYe4YVSNC/86VF8vAUtmKGFsZWd0LUgFMtka
	r40JSR71p/97bwmtW1d26P+Eg==
X-Received: by 2002:a17:903:2b0e:b0:2e8:1361:e50c with SMTP id d9443c01a7336-2e81361e68bmr3508025ad.4.1791426534123;
        Wed, 07 Oct 2026 19:28:54 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:28:53 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 03/10] net: ethernet: actions: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:45 +0800
Message-ID: <20261008022656.3592191-4-mmyangfl@gmail.com>
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

owl_emac_probe() calls owl_emac_phy_init(), which connects the PHY,
before netdev->netdev_ops is assigned. phy_attach_direct() ->
phy_link_topo_add_phy() reads dev->netdev_ops through
netdev_need_ops_lock() since the commit in question, so probing crashes
with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/actions/owl-emac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index 0a08da799255..2538275a1e57 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -1552,6 +1552,8 @@ static int owl_emac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	netdev->netdev_ops = &owl_emac_netdev_ops;
+
 	ret = owl_emac_phy_init(netdev);
 	if (ret) {
 		dev_err(dev, "failed to initialize PHY\n");
@@ -1563,7 +1565,6 @@ static int owl_emac_probe(struct platform_device *pdev)
 	netdev->min_mtu = OWL_EMAC_MTU_MIN;
 	netdev->max_mtu = OWL_EMAC_MTU_MAX;
 	netdev->watchdog_timeo = OWL_EMAC_TX_TIMEOUT;
-	netdev->netdev_ops = &owl_emac_netdev_ops;
 	netdev->ethtool_ops = &owl_emac_ethtool_ops;
 	netif_napi_add(netdev, &priv->napi, owl_emac_poll);
 
-- 
2.53.0

