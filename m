Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00E4ED19A;
	Mon, 21 Sep 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013068; cv=none; b=bHifiZ9Ffn/HjhuiSE5zB0JURd79avtf/tWy7/TgDRNyZj4fpvkWVIimuyDonJLajxgMIa1tu7NsU41Jm1FA3V95UTubggxg12tztZ5f6OM170aEPKCLX7zlgBWmzBkfkbRAw62t9fijZVJA0d2tAqDcxdVR1yG6MAckvm0513Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013068; c=relaxed/simple;
	bh=RfD39CrFszYWmLvlkyR80p6gowbn6xTMaq0aOLyOiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMbM86x2qKUZKFAGrnSmCf6CGD1AVg4jRmNj9UmQqJ6pZSam+AnPoelbalta4cWFwyVPcBuuisywzD3btHSduQ3yK5Pv3sBeBiYhmvV5gCUQK2QsOGpphlBsInPOwbUzYl02c9ojtWtPL8j/2VmWMpWUigrApSedpwCrDNFICdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=AZLeDDM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAqs+sMK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="AZLeDDM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAqs+sMK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F7A01D000D6;
	Mon, 21 Sep 2026 13:51:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 13:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013063;
	 x=1790099463; bh=IrhSvj+nx3bsDyqmh0CZIarm7FuOw+qs7by83REZ9gs=; b=
	AZLeDDM5DAM+FNoE+JIZ0CwiBDZsYLlF4jmfICEcxN5vveA5tTfyAJwhfGsNcMiT
	n8XVx1tiu2WU1xERMRiT4cLhxCoxa8YnfyyeA7ZDrwukf6mcE6rh2H4eNYQiHl8V
	UrMlOm+PUEEd/6Buz1kyRxC4rp2BzlxVYMPE9CMpzG7ZA3B0XGMPG7OcSZP7aioi
	V8stLykVAPP0GkIX/M8n4K2id1UWMR2HvTvfzHS2RpFG+f6vt7d7Ys/phhE+pVtp
	NMWDsRnIVcM8+37bcZ48KbMMMEPj/gZV74kqyjc0ck0tgpUOCCb9UxBxus4U1wLT
	QC27qhXaWya58uRsnXIKGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013063; x=
	1790099463; bh=IrhSvj+nx3bsDyqmh0CZIarm7FuOw+qs7by83REZ9gs=; b=V
	Aqs+sMKucPG+Ab1b0MLib0r0g5Ioqb/IgBT4tZGhEsA/Tb3tXDiplkpPI0UENXB/
	WAmqdkE/Qxsm95WpY7GNlPVur60Pwn9bzTgyez1yC7gON2l5z4/O/Q5/RYRQ9Hu9
	IMVLd9Gk4YqzArIwz0bxWq/eh7SamhiSRxBuown8iLqB3Uq2QiS05PgIoedCpyds
	oFkjCEUKNhvJL7iv9oD/AOyNNPUANsfp/zacfM9ucmCv/dZvCLTxhOL5GlHydlYt
	jatTW4ZpdWVxD26HajdeVltlcE334EQ6k/YO7xUzP2yNoSDnDnNpmDhhT0tAUQlH
	WTnn6flvqy3mnUU+ms3mw==
X-ME-Sender: <xms:h26xaoDTgYX05DF_kG0rnTmB_Q6GmtDrP3RO-jRsf6O4BdTleYfKEw>
    <xme:h26xahdrL4sPQXbIIhUJdK4MqjlCZzucT8gIG1bh3AFsV93FIAzhqaZrSeTxbR1d1
    mrpfQq1nU4NbXxkOVMCY2CeNgHlSkjDJHqSOdYOWX9m-e3XhrMq7f0>
X-ME-Received: <xmr:h26xagqVijrRWqv59RMb3d1ahGPq_V2gx3BWdLBB72In_Bswu3GsgHU60aW_KZWRFavjyLeSg7Q58YdlqJ8b8wgmhLj1dzw>
X-ME-Proxy-Cause: dmFkZTFKyuwNHokJCgIndgtoOusqu1/6uPi/0uzv51oOMJoBVzbBuuQBERlY9Rv3NvmA6T
    d/CD1lxyU3UgPnEeJyPNbZpf+4OQPJ3AbFbyzvtJqzJyhSU0WyRw2N3jkO5MC6tTob5H+B
    TCxu9EekrWCaHBw+6MstQGy681MV+L5ictmDPIp7n4+FYelCRH1YJ2M1xfPZF1CqF0smxw
    c4JIURjRlH1wsfm+CyMKRUhHTOncPDoh9a2aZMLd+DzObP2w66sKePqFvy/aIxy5vDMgrD
    fRXTZksUaWctOWTnUr66Aqn0xuMYZyKstCQR4Y6Vusob1m7Y0ettnqm2yu1mZb4HnTRWTB
    CXw0yx8G20+twMHKTFIQz+upxN1DFiPdPgB+2b+NdjVGTESWkmuQRWw/j0vxxNGU6M23oG
    r3qsoYm68DGErRGndv0r/EVz4V79AoNgOail4hU7ni35A3s6vHsZ12iTM0jJYiRZkenqzc
    ZfshMB8gl+zwNQGvpfcCjmwGMlBjt1mdneMXhig9ogKMCV1sxzOpUsE5GGROtgXX9s4Q7j
    MONHtC8IeavJGscuZUn4QD7WF/BvK+hbs4tQ+nc7EP3Ws9ufso1hBhgWrq/pvoLyovhW8b
    ECOGLIMfcgHovn9ekxI2jEKSpnrszkmBTa/ioXObhb5mrrmFFlcLL5NgUeEw
X-ME-Proxy: <xmx:h26xal6p1qScM9BapBTqzFSCWvH26fiFW1hz-i3VG8DVbj-Kvnk6-g>
    <xmx:h26xaoCFl8zRqWuceSdy3dQlWg_4hqR0TeqZvWG3u2tWLnCM9WhaOA>
    <xmx:h26xavauRs1Hqf3XLj4U6AGTVcZJHOSVfRx95pBwsQAsXKu1YfRqIg>
    <xmx:h26xakLLXboI4K8GNGrRUCP03JeRncVh7BcWCP6AcJOfkxbB4KOevg>
    <xmx:h26xahw2l4_9R38_L9rBRVTUofCHRCXSAKx6qdqcPaUj-5CdUoUgN7YQ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:02 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: paul@pbarker.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v5 01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Mon, 21 Sep 2026 19:50:28 +0200
Message-ID: <20260921175037.4084310-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit a6a85ba36fd0 ("net: ravb: Move PTP initialization in the
driver's ndo_open API for ccc_gac platorms") the gPTP clock (if
supported) is stopped and started by opening and closing the ndev.

This makes the special case to stop and start it when resuming from WoL
redundant. As the ndev will always be closed and re-opened when
resuming the system.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes from v4
- Updated commit message to try and address LLM hallucination.
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea1c7e536791..36173a09e2fd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3182,9 +3182,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 	if (error)
 		return error;
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
-- 
2.55.0

