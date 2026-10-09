Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30925B090;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504065; cv=none; b=PSYX7Y8MHgcRLDHSUn8QsvPAmpV2joqBi4CT2nfdG7W8iSbFHN0KUZgy5jkI3HIoxwNWSZtWUrKfaNvXlo9l+deagQr5pWVi9YCYrRLm81pVSsFMlE19eeDaYuSID+YsiOPlOaIATqiUeVV5+7THgKsWCcAVU2cWOc8aoWnyd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504065; c=relaxed/simple;
	bh=RRma2KbN1FHy0Y4ixVdrlSOKkfgIjlJNNuDSKj+qcFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuGQwXpRtKNM3bZaeaiRSkrSwpRKEHAlGP4HQBjptO2zVHtrfsXbCz5zTgVIvAt4e0KV0G6ytijgaKGfvrHK3q79iIjx/ytwKOUrlouYsdU4DFluE8yvd2QYhkXbsjXtC46r+Wn7L10ujQmXhgQw1SJWxr42TiziFWZtsyOpHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOn2fDmw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOn2fDmw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5895C2BCF5;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791504064;
	bh=RRma2KbN1FHy0Y4ixVdrlSOKkfgIjlJNNuDSKj+qcFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qOn2fDmwmG1eL5yRqEWptxBPWJsy24hpwMoFKUAlXCRBNm7RslxD1H0GWWQHHK/aD
	 1Ei13HZH0YuatjT/jR98ik8ay5+SwJ3qeDzKZfDrTZ8e/iR5v2fkGkNsHykL7Z2BIt
	 g9ULhK9Qhzxioi70qEwuQn3vfIuyDQ0Cla3VrUawNSfjLCMfVms+Nlm1hdr6TLRgMi
	 39hnSjso17cgBe842SSmZBokPAWiOkDpU/DN3eEnPBAfsVQu5HTJZpuVGqNmGd0DcI
	 vHimTp+6vF+I6XxnJ6o3LFU1/Uc2bIHJ9cpIfob0M7mBo0wEcRcwttAMDHT2dTot8B
	 dvHIrNG7/V5wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE4ECA6017;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 09 Oct 2026 02:00:56 +0200
Subject: [PATCH net v2 1/3] dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-1-0f4eeff2295d@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791504062; l=2219;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=2yT0o0riRSrsVASmLi3H0zLRSjRqiYSHr6khgqWQ8DY=;
 b=H7olnyCP+bmgGnWdyLKm9T/tu26CEG9WEKTXYGWG9BMi/UJJU6jOvj3MbDgFHKf34AUz1hky6
 ctEaTV+5pHbBN5PHGM4AdtKCcKvqkJcqJCAx3y6zXlMKv0+t6u4kXYg
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

On an LX2160A board, linuxptp ts2phc arms the external timestamp channel
of the 1588 timer with PTP_EXTTS_REQUEST2, gets -EOPNOTSUPP and exits,
so the PHC cannot be disciplined from an external 1PPS.

ptp_qoriq_init() programs TMR_CTRL with ETEP1 and ETEP2 cleared, so the
timer timestamps the rising edge of its external trigger inputs. Declare
that, with PTP_STRICT_FLAGS, so that a falling edge request is rejected
instead of being timestamped on the rising edge.

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
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 4497e3c0456d..ac2b873dcf8e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -78,6 +78,7 @@ static const struct ptp_clock_info dpaa2_ptp_caps = {
 	.n_per_out	= 3,
 	.n_pins		= 0,
 	.pps		= 1,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
 	.adjfine	= ptp_qoriq_adjfine,
 	.adjtime	= ptp_qoriq_adjtime,
 	.gettime64	= ptp_qoriq_gettime,

-- 
2.43.0


