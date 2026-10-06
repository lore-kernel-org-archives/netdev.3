Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE145C70E;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293704; cv=none; b=Uldij0BSUEBeDcXsZe6MWotr5u2jBMed/IA93Vwcw+ZWB/txONhD9blu0XoFZAYNCf8QLG1E6SzoT8K9UoIV7jFIbjlBC7NKYNkr2kFlTCv2F1mvlDMsUSuu6UhKh9eQFsQQ2oKoQKYZYJQPdnMPSaUqjCTtyNDVTjWY5pdSRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293704; c=relaxed/simple;
	bh=DLWabT5aH8RTvB/cmdF02GgTnJCcM8kNS+En6yi3ndE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt0c2LVS3mjkI9QRUzOrMrAvTZnKmfF9UUCxroA3DMcNeJmEcZ7tzW+atf1pGJoQJuMZRhKaiCHG4buJ46fHnemQuA/7RbhWZ9K8WT6cbqhAWWZPnj6nZRlCg49bnX60Yw1RY4RL/eaPwXUHO7em21jOAOscCGP9WJtRivn+XOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0tZS5jM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0tZS5jM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 897ECC4AF60;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791293704;
	bh=DLWabT5aH8RTvB/cmdF02GgTnJCcM8kNS+En6yi3ndE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K0tZS5jMYnxrRvgVJPCgQ1EmzyiASz0vpaSzS4LcZZqid9c6qduyCzmZkfuaW0itB
	 Z1/BztYh6Ngou5GcFSbWUQxM5m7wHX+k/GhTQb0yOPWTVlTsRMBu6Duom0QDAjBptB
	 SzvC4E1nZbB6I6ghf5ZnK5Ko+vtmrpQI6s+3geJXnz/7RGb8tG0ZaRS1+lRGSwSQTS
	 Qfbz9dA7IzvZV4Zfq81JvxdNEdwWg/DoKEFMR8p44l601rt/MDMb9XDew66SQFluLC
	 AFDmohYnv8YDemeH21s27YAuVrA/pzEol92nEKFebOsVIv2OBmHrgbFDmdR9yA1Aku
	 t/lEKY/U+bo7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635BACA5FF0;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 06 Oct 2026 15:34:51 +0200
Subject: [PATCH net 2/3] net: enetc: fix support for PTP_EXTTS_REQUEST2
 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-2-b4a161b92832@free.fr>
References: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
In-Reply-To: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791293703; l=1458;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=4PIeh40ykqWFUyr4J0o2X526W8LmvANCbTomAJ8JenU=;
 b=LBsxsSD88oLwy0iwYGdQMn8AqbkPcmNnVq9xadTmTdE7smTpl0XBefIp8RhCkH1mS9CKjfKqJ
 0zAM46K/KjhA9QNClS4lKyX609iTE6hNru+T16Fx7ycmtgFuewShNwG
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
but every PTP_EXTTS_REQUEST2 request is rejected with -EOPNOTSUPP

The ENETC timer is the QorIQ 1588 timer, set up by ptp_qoriq_init(), which
programs TMR_CTRL with ETEP1 and ETEP2 cleared, so it timestamps the
rising edge of its external trigger inputs. Declare that, with
PTP_STRICT_FLAGS, so that a falling edge request is rejected instead of
being timestamped on the rising edge.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
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


