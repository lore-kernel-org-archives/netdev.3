Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0CC45C715;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293704; cv=none; b=bNnD6xjUPUsvYNT0vpQJ/tw/krie8pKNGYD1BrYWHdu+xtLkn7UVSB1fv9BeC+ukPApPS460yUrmol63ySKSjT4bX7qYv3/pDL+rZD8FgsTCIQrT4/6fIfFY5kC2hhX0tdF++RTtwa5NGhYK26sJ+HiDn36YXt/WrqY7mqQ9P0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293704; c=relaxed/simple;
	bh=GCoK0HCJ3SReKIatAVAogwKr5j5eKZs4kvGO4JyFfKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXX4rw7G0JOTbIOWufVD5XTT7ltqsyuS8/H8lqizffyiMMYdqAczGBOnbtBb+pPJEJVe0Ad7axiE5Z58Ai1gv5/pRIV3lgk5AqJw9Dofs6GvPqicCPkrLxLZqEAcXelagjQTwH7N0+WotxA5tj7YOov9s/n6fx0AHhKZvcmqXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdT/PvzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdT/PvzT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72B26C4AF0B;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791293704;
	bh=GCoK0HCJ3SReKIatAVAogwKr5j5eKZs4kvGO4JyFfKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MdT/PvzTmUxAiKK2qkqPiDYLzrwfdcudkrfotRhjTflv9R4fnnQqVA64ld90k2jY4
	 5SW7gbMZuXmdnHzLaQWScn5NCwt4NJPoLenO9uiC2h4sEOz0WTiwZ+mAGviENkt+Pv
	 6nR1ZMkvnvBDAdvJqiPvZ7x0SgjU/XufZNfbL7o8VB+uyihf9XfEEmg0T/Fuzoaxjo
	 DV6+j0mk1L+iL8EybJsDhL7jUtbCso2NZ4Pwv9T+uiD8oWwcvk8tnZCK8F36cyEaPs
	 H10biJ1HY7pVV96un/VczB2chnK9pDglmoU+1Ppi0dL++Czphlg+s+BRXzZ3BNZV9m
	 GOX9bCMiSdG9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51634CA5FED;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 06 Oct 2026 15:34:50 +0200
Subject: [PATCH net 1/3] dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-1-b4a161b92832@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791293703; l=1617;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=7iboOTM68ywkt06m8hkuzsd/d1QCyhUx0dOWtEHWzM0=;
 b=ffdclmp3YniLrkAc3yp6+NmdytdM+tT+4/dAeZpgNnYQBYqaRWZR+rcvZyj9F1sGmlsIeZRAc
 22CkyzT/7tsAIG/PY0xObBeO0L30LCobOOj/9IGVtpW9kEb3F8fqoPI
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

On an LX2160A board, linuxptp ts2phc arms the external timestamp channel
of the 1588 timer with PTP_EXTTS_REQUEST2, gets -EOPNOTSUPP and exits,
so the PHC cannot be disciplined from an external 1PPS.

ptp_qoriq_init() programs TMR_CTRL with ETEP1 and ETEP2 cleared, so the
timer timestamps the rising edge of its external trigger inputs. Declare
that, with PTP_STRICT_FLAGS, so that a falling edge request is rejected
instead of being timestamped on the rising edge.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
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


