Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729913CD8D3;
	Tue, 11 Aug 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464303; cv=none; b=hTEQEfVlY7855Ac5gE9LMua5ffGvRYwIQBWLg4t5RJgWArZACYH7weu+yCWtgYpKyP7QnEiyxbOxQMhbu2CpHaI6vNSt5r4ZhDqoRZVttDBWRmqzisg0FVA4L+Tc2ax156wb2CwuE6E/Asyz47xVtwhMbob3xOmuAcQoHX4Icgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464303; c=relaxed/simple;
	bh=KcSMiQ7xtuZZ4OFCS9XaPDFEiIAcblfYJHAv5IdaQSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejTiOGnJZwnjXNyRhLyINFchMSgBjI8pSlASWOkNkpRs2w4Fyi4P9wuTaS0nWxFKjq9nEH7gFURbjU9I5T0z1gUd8pB4IFdsKzGJtdVZFStGrXoDh6mRnFGev28K3rik5gApQsPY3yIW5pTPiZ+QDoldR50reyguGSFaTNC+TAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WDT0SKXN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFPbEfgE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WDT0SKXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFPbEfgE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 944AE140005F;
	Tue, 11 Aug 2026 12:05:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 12:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464300;
	 x=1786550700; bh=1zUSdIDIiHSXKnhOvLThIACgva9NCcclSlSjHChc2Qc=; b=
	WDT0SKXNqAq8OYjNt/iCkAnDfpmt3yIxMUIoOW4LnVOIlEGC2NfccUvbC+mGmCwp
	WKZ+6piMHy7lxh37IFaoxukw3dUvAuUQBaavZsmgsTWAVwE4SrairIDLuuGo7oaQ
	BMSW+ysyUey9iuvVnu1wqxrhdDjAFmwVl2ZSwaCN8qDG1E42amqFcH5XkQNioxJC
	HUM6BNj9vv23ZavtfjDmIgCFlp/g4Sfvw2mX6ulNHZlOeF71V2WsdzMGOwyZGb7s
	TAFQ04B+HKCUUfUEqg+ZNrPdVMvpbgbqHzgtJZm+Rb6hdGYKNYoUoU6Mf7HI+ouM
	+0542XYiqNT3kimhJUrZMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464300; x=
	1786550700; bh=1zUSdIDIiHSXKnhOvLThIACgva9NCcclSlSjHChc2Qc=; b=D
	FPbEfgEFgMl3J5s/VZtJ5hdQzEudklhPyKSaGMW+eTuoeIpzLL7BTk2R1bf4TsYc
	iqPu5MoibBEn99zCiMNJglqjJn8RDPjJ91QY2LfhOF+5iqcojLBX3afS06TnyOmt
	InBZ76RJVCwM62eDp6op59qe1Y8X829UKjAc4pTzwOOMlLPdHIosa3OyexUq/QYN
	miIRvQlyeBD2NEIRQcivpJM5rz1dxSRKMw3RQKabjGhBo9FNvbGvyl/Wasf7wbr4
	zDHPnS5SG2P9MOcU2aODn1i12U4++nNY/0qBPLAi8GO+x/NGqQ2ycmNmv8brsl+E
	ABcJvxg+qBKpUtNyM8Kqg==
X-ME-Sender: <xms:LEh7alz81tYofd_nmVyxslWQydRlq1ttkA1OkJrT9dQWBCnCDwKqNg>
    <xme:LEh7auC2PKqWGPh_LTjW1vcvQNnarEP97VuMByH_51s9XTIkk6R9Q3ro0ylGZ4vO-
    gJlrwXzAF_TaoGr4RrALu3QkgDjaCqpiKO8eRyX2w76vazc2hHfNsM>
X-ME-Received: <xmr:LEh7auA8RimrpKVSD4yCdUosYAG_w5hprfmeDUm6djmeFH0aZGzs2ECl8wwF14uHY_ouaAh2qF6Nr4u5kQEGS5GOf13ew5E>
X-ME-Proxy-Cause: dmFkZTEHSKU/mHe+6lT/LKJ8bgeRk/V053AqRrN1BR5zk1Shu2DOwdZpAbiAy9Gu5V3kwl
    d1h5rYgq3ypc8+YqRDw6+W1dLYGl7xAf/JnE2fouoUr+uQ91a2BYYQH9MIj19hgAFS85bG
    HKLTscK1JcTpPAqcQJWvsSlbtUp0RdE6RTfSS+w1mzdxNe3xP0yAJfQK9V9lP6dWT+dM4P
    mUlTM4aI20t5AwNoSG0JmkMiw/Mr+hK7RWJaGzCv7Qao7/mJJZshfXyd+BX97L+xujDMkI
    ysyzJYX2sNeQaedRdU3MhBFGetibaJ+uJ7gBG5oaNX//F32Vx9hqF9Rh8nKQaqzD+8IATR
    QznxkQMtv15yFibxXAUyX0KXExSw5kyWcNX9TNX9iQ+l7rAlYPbWwA6Jn+5Wua06b/ne1O
    0xaltypsjT2l/1/CZKZVrAaXPfH+bApSlBkaIz65Z+gvwtuYCeTofMNg1utdgyL+OchTZj
    Ng6KQNlrErZjCHFQgYwDW0a65uMm3oGdwinAUSOei2C3kjRX/KymduhWStOros/NmLxNms
    u9/Ndj44Sb9h5T3SP4VYB/y/H9P+LrnkA4cWANmpfuCL5/jbypDrOyFjSCRTbTXg610ZtS
    SzqAXDdmF9wsNw6B+x3Gj4Ra8Fl01J0iWJAKckftfulT+32L4400U5wPiIbg
X-ME-Proxy: <xmx:LEh7ap7CM24-dcPOQ2iQ2xZp1yZ3nLOebBmmJNP4mvylnvKJq2X-IQ>
    <xmx:LEh7aq2QQnabRrgT8HFjtAIo_L4HrN5sIK9NkwYDhKaJ3XTg0vXJ0g>
    <xmx:LEh7alC-xZFkTMOxuXsVVX6JQaq94RuDFxycbGVDKJVzs0kYMZjelg>
    <xmx:LEh7aqHxk6FgLPgMEDMYQHdQ41yZJYy8rfPVkIO2rLJjNxtXHPfA8Q>
    <xmx:LEh7aubeOtBP5-nDtmWKZegY-Ps2nCODfh9h21NiNcdx5LJLnQ3Cbxsd>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:04:59 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
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
Subject: [PATCH net-next v2 02/10] net: ethernet: ravb: Move programming of gPTP timer interval
Date: Tue, 11 Aug 2026 18:01:52 +0200
Message-ID: <20260811160200.2049987-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f384ab481cab ("net: ravb: Split GTI computation and set
operations") broke apart the operations of computing the timer interval
and programming of it. However it kept the programming of the interval
in the RAVB main logic.

Having split the two apart this can be improved further by moving the
programming to the gPTP initialization function, as the first action of
the gPTP init function is to wait for the timer interval programming to
be acknowledge by the hardware.

As an added bonus the interaction with the gPTP registers for the
programming can then also be done while holding the gPTP registers lock.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ----------------
 drivers/net/ethernet/renesas/ravb_ptp.c  | 11 ++++++++++-
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 77c0645a1c4d..dc2fbbeff895 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1846,20 +1846,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return error;
 }
 
-static void ravb_set_gti(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-
-	if (!(info->gptp || info->ccc_gac))
-		return;
-
-	ravb_write(ndev, priv->gti_tiv, GTI);
-
-	/* Request GTI loading */
-	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-}
-
 static int ravb_compute_gti(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1974,8 +1960,6 @@ static int ravb_open(struct net_device *ndev)
 
 	ravb_emac_init(ndev);
 
-	ravb_set_gti(ndev);
-
 	/* Initialise PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 226c6c0ab945..7c78f75cb284 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -319,11 +319,20 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 
 	priv->ptp.info = ravb_ptp_info;
 
-	priv->ptp.default_addend = ravb_read(ndev, GTI);
+	priv->ptp.default_addend = priv->gti_tiv;
 	priv->ptp.current_addend = priv->ptp.default_addend;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Set gPTP Timer Increment Value. */
+	ravb_write(ndev, priv->ptp.default_addend, GTI);
+
+	/* Request GTI loading. */
+	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+
+	/* Wait for GIT loading to complete. */
 	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
+
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
2.55.0

