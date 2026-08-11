Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116003644C1;
	Tue, 11 Aug 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464300; cv=none; b=OcKcBucz72QgfRj3ab4uKA6TsfSehtU93Et7MkltX40dyX0cP4420nEtp1IBnb+gmBwGd/vla0NJ32PVHIQYUA5zyqaR2RxmVrE3SbeMR8sdAIYvsiFVIhPDtPtTL9jDZU8nBwNmLOJvWe19dbXjcVi5/iwNPBZgO8iORIQxJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464300; c=relaxed/simple;
	bh=IW++LElHxv+PhYFMZjcC3XEs5psi3ZAZjUfancmfwjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EANmt4FQnkoxXpWk3ME2oHiY1Dr08fLgUZuv1NXCZJ+PNgkq904/p9SPNrV9g6/ecJ/fARF8mbKrZZsgJMIULu/Cxef0oTQ+JNqd8f++Dy7Xmr98AzdP8MZoWCIvyzJ4h7O/x98zuUhfJqyteiO1SAYpxjfqNBJWEmgne2RUl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=O3gaHaHM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHpWKurl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="O3gaHaHM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHpWKurl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3462014000E6;
	Tue, 11 Aug 2026 12:04:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 12:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464298;
	 x=1786550698; bh=di98Sqj52BGEFbqxelGbLPcgLYeq5yayCRwJcDFP1Co=; b=
	O3gaHaHMad4lIJDhxvWnQsbs3KqHA3g7kRJytxD4z9twPu04s9WubKN7nlrANwQL
	mZxLlqGt3DAAbv3tB9NchL3BeFbmikl6+k9+5UAonE02biBkylpwb2ivwdJGXjMe
	ybNp/5JNC4tKtT6Y6Yy358RSZIk908cKbjwdYH+XtGqcZ9AdH71m/35ZNOWcoALF
	bOGwkL8IKJ7jWQsuTVANXHS1eD/64uNmJKo1oPYgIjos4L/xhRBPPYQsX8gZVjLQ
	VNV7JvRQw3S4ONx7veuJe4KqQyb0spbQ1lJ7moirwilVtT1syFE1mRi/+lKl8Lu+
	y8M9ov96azcZXnKnJYvM/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464298; x=
	1786550698; bh=di98Sqj52BGEFbqxelGbLPcgLYeq5yayCRwJcDFP1Co=; b=A
	HpWKurlvxR+iYRZlisMe6CGrnKbNLRNlIjpo6RWeh4yUDvtiGQaiQu3412Io/xiw
	0wMj9cff+NHIf43HQP2hBXFzvIa2AnfqTq4H0OeG8NySXaKb/diha30S0k5JNRz0
	tYMtyYFvzvR5DhFNegGxDLk9nvB4n9m/RX2SxRBiDLnkjfIGgMlJ9j0cAJavqsNJ
	LFiQRPL2UOW02QY8wZoWObll2dlkDTUaWFXidU6U7KHdd5/uZcV7IAvH1nhARPxC
	HhlTujojStFXHIS8qnnqvYzgdWl+4/7yfacKvoMUL/6vJOLxW7IiAy9l6UrakdgU
	6Z+SU3B7uip5rSpjtu5VQ==
X-ME-Sender: <xms:Kkh7am45wHSIJD2fyEI1V8T6tecfbQAUjpHy9d4w1-QoKoggbRBibg>
    <xme:Kkh7alZneAnwnyYbon7rVVuHVdZI0OQu3q9zwhWEYUMHRpby9PDc3b0dOWzjBw-9A
    mvFx3anqMg0qFdd4LXsC8ozyf8H8Ozp_CImsQ44Bl2I7SnwsaOE6A>
X-ME-Received: <xmr:Kkh7atzafW4lJchhjb__G3RA5LuCsCJL48ee1Ot_5px6FgIbcgSjh9Du0MVvrqv9zbUaq9UOPgTkUFi7R0vYBaB9GNrDFhk>
X-ME-Proxy-Cause: dmFkZTEHSKU/mHe+6lT/LKJ8bgeRk/V053AqRrN1BR5zk1Shu2DOwdZpAbiAy9Gu5V3kwl
    d1h5rYgq3ypc8+YqRDw6+W1dLYGl7xAf/JnE2fouoUr+uQ91a2BYYQH9MIj19hgAFS85bG
    HKLTscK1JcTpPAqcQJWvsSlbtUp0RdE6RTfSS+w1mzdxNe3xP0yAJfQK9V9lP6dWT+dM4P
    mUlTM4aI20t5AwNoSG0JmkMiw/Mr+hK7RWJaGzCv7Qao7/mJJZshfXyd+BX97L+xujDMkI
    ysyzJYX2sNeQaedRdU3MhBFGetibaJ+uJ7gBG5oaNX//F32Vx9hqF9Rh8nKQaqzD+8IAWI
    e5tnBKhoZJN54v8DJoqaxSguRvDBwzT61EhIqMS1K7XsWyLNr3qo9KuS1DwiHEQ5C5GZAz
    5jNbd7p3FdE5kBri/h3FmqowzmGC+1Lv7DEXmmw/rcG57OHPuj3Ml3ci2Wii2IakyDZuIP
    0Jksh083LYWVa8DSbz2TvV2YVjD1zC9Zqkfxi7hQZhH3iygluQ46s/r/6Lv6Mn7bU6is7o
    cs8t7bo5M7vdgQARBMxCkeyxE+Ihol0EZgC5aDeOwrWtjhgCj4lnmJVw2XPGP2VPcfyCQH
    tl7lAZFdRXqgjgZk5+mkyGp3ZasJaRBVdTlPeETyLPbrjWMmaG0A/xhlWLaQ
X-ME-Proxy: <xmx:Kkh7ahOXvkTm7mg_foiKYUw58GCtC7YChkq5F-6cs46CP-cKLkNpeQ>
    <xmx:Kkh7ar4bXESU98GDLUTr52yqv-TiK5aMwE6uHHZeJ1pAaI8Fat55EA>
    <xmx:Kkh7aneN8khM-OPaYGEF1kO0eI3wgfbOPqE-jN8NFvs47UFL0cCYWQ>
    <xmx:Kkh7akKD9qqDZSw3mxftmWb12fCIUTqcytl-RJseI111T-6RxOEGPQ>
    <xmx:Kkh7aqQVbHufumKRP7dY-pGBHEcaHCt1GIthZ05iuhZNaJTVfoeznJqt>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:04:57 -0400 (EDT)
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
Subject: [PATCH net-next v2 01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Tue, 11 Aug 2026 18:01:51 +0200
Message-ID: <20260811160200.2049987-2-niklas.soderlund+renesas@ragnatech.se>
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

Since commit a6a85ba36fd0 ("net: ravb: Move PTP initialization in the
driver's ndo_open API for ccc_gac platorms") the gPTP clock (if
supported) is stopped and started by opening and closing the ndev.

This makes the special case to stop and start it when resuming from WoL
redundant. As the ndev will always be closed and re-opened when
suspending and resuming the system.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0..77c0645a1c4d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3179,9 +3179,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3201,9 +3198,6 @@ static int ravb_wol_restore(struct net_device *ndev)
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

