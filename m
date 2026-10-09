Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2831A6811;
	Fri,  9 Oct 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504065; cv=none; b=d1A9jvKfh32KiRItaQHXAqlQt9N6PHF3gkBRyTK3ccolwU+5MK8Lv+ztElFSQeT8CSQ5vRcnmPaFRZESbyp6WDPxNwDDWCGN9APCfIspbDrgAUbrm+ZVnAQbrJj4UYtvfll7rbTvrBKu5ff87JvJxu9GrHcLX0PrMnbhWdDn+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504065; c=relaxed/simple;
	bh=Y7LkpHq/EqWyjjE+GG2bE7LJnfYFsJcrS++uxn1ph3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyIQwr99XNKKvG9WqOvbWsP7GFzFO/mJveGVDQAuD0G96W3+9ikuoykKMZLNnBVR19ZKxAvwSwhv6PwyVlunnDhyTebU6VZrkMxbOWxy2yLqsSMNiMgYGOmk0W7Z6Y3euSqttGTUzkLbC9j2pr2iFN2Ep4vEYvoWx809c/SaIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy4xOboK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy4xOboK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B31C2BCFB;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791504064;
	bh=Y7LkpHq/EqWyjjE+GG2bE7LJnfYFsJcrS++uxn1ph3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Iy4xOboKNHOGe1rTDUN/8G99DffoU75dV2Go1gIB9F+EMsF+xYzeKfsRLPLhKIXL1
	 n7n38nIfveBu2VtJd4A4oEseSQONdEoifAsER8WXuznNKfWrBV7sheZm63GaualyyJ
	 gwEZzGJMonUiTc7xU8KSB7eifA9B6j2gMVJsC9xKxVRYMuvjOULnq4ewK4+VpIagGC
	 xauznlRn3pHOgEnFapL5LqZIEXRB6RHdJ6ZxmqvdWOkOOnKJizwIBfvYggdU39GpVk
	 gh28UdBGiqSpDRG2+Wre48WHGeM91Bw4ZZIwW70WG8jMeOhxcz0nUofiVcm1F39RZC
	 3IWCONWBe4vWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F95ACA6019;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 09 Oct 2026 02:00:57 +0200
Subject: [PATCH net v2 2/3] net: enetc: fix support for PTP_EXTTS_REQUEST2
 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-2-0f4eeff2295d@free.fr>
References: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
In-Reply-To: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
To: Yangbo Lu <yangbo.lu@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791504062; l=2060;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=L1S1HG7Gx1BM3jj/P7AoxFPVrkOFse7kf8sg7YIEDiE=;
 b=eRmCe6sdAQofk50PVPdYb/GrlX5PQxhsMTvHS4wDa/VC2UP92BHXocWqQ16BPBsJ8KuLwgtor
 LTSjNZ3wQlYBnbub8b+CbAPxtgNTQZBu9ZwbU2s6MeaQiLC2MvVLXQB
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") moved the validation of the external timestamp request
flags into the PTP core. A driver that does not set
.supported_extts_flags still accepts the legacy PTP_EXTTS_REQUEST ioctl,
but every PTP_EXTTS_REQUEST2 request is rejected with -EOPNOTSUPP.

The ENETC timer is the QorIQ 1588 timer, set up by ptp_qoriq_init(), which
programs TMR_CTRL with ETEP1 and ETEP2 cleared, so it timestamps the
rising edge of its external trigger inputs. Declare that, with
PTP_STRICT_FLAGS, so that a falling edge request is rejected instead of
being timestamped on the rising edge.

This also makes the legacy PTP_EXTTS_REQUEST ioctl strict: a request for
the falling edge, or for both edges, now fails with -EOPNOTSUPP instead
of being timestamped on the rising edge. That cannot be avoided: the core
adds PTP_STRICT_FLAGS to every PTP_EXTTS_REQUEST2 request, so a driver
has to declare it to accept them, and once declared it applies to both
ioctls. Commit 3200fdd4021d ("broadcom: fix support for
PTP_EXTTS_REQUEST2 ioctl") made the same change for bcm-phy-ptp.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index 162cbc801730..5ffee882d624 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -16,6 +16,7 @@ static struct ptp_clock_info enetc_ptp_caps = {
 	.n_per_out	= 0,
 	.n_pins		= 0,
 	.pps		= 1,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine	= ptp_qoriq_adjfine,
 	.adjtime	= ptp_qoriq_adjtime,
 	.gettime64	= ptp_qoriq_gettime,

-- 
2.43.0


