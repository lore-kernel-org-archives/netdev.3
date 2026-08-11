Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BC40F8D0;
	Tue, 11 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464309; cv=none; b=VDhDkA94uGXi8EX+3le4XdKfc83FeJGZi7ISAu7Ei1QuGPeiRGSszOaRKSkJWrsI+vwlLXrCGSzaxybhEp+MvXPZP/oLSZRqat7mpM6RNWYNLkCG4ReCq62XOgBjqdNUO8UHa3iAbZSjNDuk8hE86Akfqb2SQ8ojsRikg3anc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464309; c=relaxed/simple;
	bh=EgES/V6H2suEzJKWy4WsoHghAL9oan1/7pL8qga0NkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dboA2sllhS2TjKgMXQmXs3ZuJHe6oUxLcDKekrbjUQjRQqYBqG0DK5Rdl21FFAms/zjf39CU6OMsOSh8FcboT8JcDlUeJgIv87SoRmwiOnK46uu1w1BvE0W8mOy2xARQ6p6QH108yQ3A/zpwPtvz0bbmROMzG/IrMn6q12fX5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=sdVYuxWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+upMGU8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="sdVYuxWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+upMGU8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C9D414000E9;
	Tue, 11 Aug 2026 12:05:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464307;
	 x=1786550707; bh=6188lcywujrOsVI7jiy+Cp443WOFrm9bebd+NSrCIAo=; b=
	sdVYuxWcmhKH7rKKChG9vVXw1XUyrizi+JG6uv4vEXtoL0Y+LtUPUqWoGT4IiOa2
	aVOqW5P3oawAMhQm4TkiYPsAeXjuxJ2CTo7ENLO991EUShEq+Y6tKHwancgKS0ry
	z+fsfWRrXz5960J8qPG5A89+NBucbnFtWUwpiGF75DtMpJDy4eY4NimDesI4xDIU
	sIP8skK1Rb14lRrXYbnNVPzlIvZhQbdk/nTfIIsvZRcqDsg68X+g8qJb53aJoTw2
	tkdrds0BJbk4NR9se1l16w3jNnqNOmzFVtYewu8LHWXFKQdZImFc9hU53Ubvg74y
	qK3DmU2BPf3KWcXbAROhxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464307; x=
	1786550707; bh=6188lcywujrOsVI7jiy+Cp443WOFrm9bebd+NSrCIAo=; b=k
	+upMGU8f+yyk3IIbriNO100Kwx9E9ebWRxHxBHt/rZcFN4xgONoV8z6sZIljzHOm
	X/8XJRKgr7i5QVLTfVYkO5v4cHWFDR4xPnsIgFU3xjBc3/trTIL8akbXEA4UwbRs
	+1JapekezfqhQjDVH635GXszhwKrkEmY4QEX71fXPWonx3gmcSFAjSvB67GqQ6cD
	7tD/YTQbxk6tX52k5DN8VmtQ6VC6A1JH2ywRyFIkTzATsEA4k+UsBRL7dRuKmwmk
	W5h6EyDYgblKw42bxEP+59tLkaga2UCmbYlb4eHUwpmlaDy4FEW3O60lZz3ecsw0
	HN1bOTXuH2H+2WzlSqnYQ==
X-ME-Sender: <xms:M0h7aoJyTkF68SpDjwcB4EoNb9O3aKRg-UxgVtVgl01Lf_015FgBZw>
    <xme:M0h7ag4pSDIk2DMWjK7P4Qy2dexeh6bewLtGh6EBmkb_WoazpLvZTtNLZuEsPVVH3
    Ipd_zw8PvRH2BD-csXJWV_FkiHLyOCMp6DqwfK8E1vQa4ukABDlK7E>
X-ME-Received: <xmr:M0h7anYuI4WKTdeusqljAqFiUiSMHupdf4E2CHT14k2xKw4LYqDLAs2LXQcGgdx7tZg05qZUwok4Uj7JFkzwfrG179SgeQk>
X-ME-Proxy-Cause: dmFkZTEHSKU/mHe+6lT/LKJ8bgeRk/V053AqRrN1BR5zk1Shu2DOwdZpAbiAy9Gu5V3kwl
    d1h5rYgq3ypc8+YqRDw6+W1dLYGl7xAf/JnE2fouoUr+uQ91a2BYYQH9MIj19hgAFS85bG
    HKLTscK1JcTpPAqcQJWvsSlbtUp0RdE6RTfSS+w1mzdxNe3xP0yAJfQK9V9lP6dWT+dM4P
    mUlTM4aI20t5AwNoSG0JmkMiw/Mr+hK7RWJaGzCv7Qao7/mJJZshfXyd+BX97L+xujDMkI
    ysyzJYX2sNeQaedRdU3MhBFGetibaJ+uJ7gBG5oaNX//F32Vx9hqF9Rh8nKQaqzD+8IAsA
    M3/m7JHdRxDYrgN5wOCim2wdws7OqEblrCFzVAVtqdQun9J/pODok3jhK8wL+RUj3+ITSz
    t6SuoV5zpH0vmXeZJC6AK8mjgPzHNuiyRO9FR96+AtkbuckOXm9ot5nLYhbsE2rAEZIaQn
    BrrLBmqGGcANjOa5FhzZJdKBep6t6XyMSXBOCE+3zJp/OLL5zc7hvURhTPs8bWSa6iwDy3
    pdBtARpUhWSGYIsYljcklh1d4TH13t49WiU+ukJgOdiik5zYwHAJRsr589+Y7xG+giRvO4
    L4rsWMoWVeT28fpB3r7TWL5OsRFB+8eDu8N43shWPzj1vLsgENMIZju1JmSQ
X-ME-Proxy: <xmx:M0h7anxjm9YAHzabNBqwXsY_ibAliuVAYSr3bfeR0_VVXj7VOoIrzw>
    <xmx:M0h7ajODkdXMh8QWmIqAKX1F-qjTzrjscBt9HS6wrL4MTAckJDpL6A>
    <xmx:M0h7al5lz9tz3qOKia4VKexEt3rOmXVEZm54SBJL9_laA_7Eioziiw>
    <xmx:M0h7apemrvj0emVcOYXkTeJh2mggjqTeNYFZEFQ1ht_0RUkjI4UuYw>
    <xmx:M0h7aujwleese5nVofEm-_q-j3enGsNkEE5_e_eQxzrD13zBVmsLxrd1>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:06 -0400 (EDT)
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
Subject: [PATCH net-next v2 04/10] net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
Date: Tue, 11 Aug 2026 18:01:54 +0200
Message-ID: <20260811160200.2049987-5-niklas.soderlund+renesas@ragnatech.se>
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

There is no need to explicitly pass the struct platform_device pointer
to ravb_ptp_init(), it can retrieve it directly from the private data
structure.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 5e56ec9b1013..013ced6dcf29 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1160,7 +1160,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev);
+void ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index dff66a347baf..b3cc4c79b29f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -713,7 +713,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	return 0;
 }
@@ -1968,7 +1968,7 @@ static int ravb_open(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 7c78f75cb284..1c9b33d1b8b9 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -312,7 +312,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
+void ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
@@ -336,7 +336,7 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
 }
 
 void ravb_ptp_stop(struct net_device *ndev)
-- 
2.55.0

