Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3D45C6F7;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293704; cv=none; b=cYPYq6l3MtyAN/VQh9n7ZLOQDy6Dsazu0duZ4KSKngGuiErxEz0nBBUH0kkai6a5tuRSJ2crPOA+LFN77va1Gy534p0jjxNHvpcSjLbbSDDe16Ps/ZAKLS0wRe47S6unSv9Fn0OH4equQPheDvFMHCwmijCxv/rZItxbqBjI43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293704; c=relaxed/simple;
	bh=N61tQOxTMC2LBXGugG3ji/4JgbnLcxTpSZkR/jWKgM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p4vrIPSuZnsHC8UBqXb9s0yAGAohRGeuT2j/NO8yVEJLvOaycld34z+TAnaBMh2UYuSOkR0UDxIF+vrEJInLm9uD7jqZJIxKy9tOthk5I4ic1z8++lRzspvgLgI1ajkcqIofsYRBH+AaFvEQlbK6f80ujROeXASiEdpTkgKjdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM9iJnrM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM9iJnrM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66DDCC2BCF4;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791293704;
	bh=N61tQOxTMC2LBXGugG3ji/4JgbnLcxTpSZkR/jWKgM4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BM9iJnrMJeadIJPwT4ZwjmRzel/SCdlx8CpNgtE/V45zxvNXXx1SL8rsRKcMN5P99
	 pb77b5QACG/xsjyRZYFMqMLYc7VnK33XKZvaPT7Tn9nw/Dagzqx2EShrvaV0puInla
	 Xd+Kplr+MPVJS2q4bi0Eqe6bsBTCi1pPQS7I+cyeW6LOfu5Gq0LFDUsynL42huy3Is
	 H+NvL3jCw6Uqbny/kbwWDRkBIpBT0NyQ43WYI2icr10oPM8V4DvlBf8EsoO6URKcm8
	 WE0/qGN46KiL23bHyhxSIkG3StfQ0qSBLQcSnP4QNoMG+PM9KmSur0UFicwmjwrbmQ
	 2wAK8MjP00b8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDA9CA5FFC;
	Tue,  6 Oct 2026 13:35:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH net 0/3] net: freescale: fix PTP_EXTTS_REQUEST2 for QorIQ
 1588
Date: Tue, 06 Oct 2026 15:34:49 +0200
Message-Id: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPn4xGoC/x3NwQqDMAyA4VeRnBdoHXSwVxk7FJtqYGtrkokgv
 vuKx+/y/wcoCZPCczhAaGPlWjr8bYBpiWUm5NQNoxuDdy5groK/piYUv7hW4RWbNaTdTDF/4qz
 op5DT4+5TCBl6qAll3q/JCwoZvM/zDwEKjqt5AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791293703; l=1256;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=N61tQOxTMC2LBXGugG3ji/4JgbnLcxTpSZkR/jWKgM4=;
 b=hwjXxIdv1DQkqRX60jcCXDonlt4EW5N8GrY38a4HR7bpMQeY0x4rwgJuLOrIc0R7cZBFVoP1F
 B2dx9y+T1L/Dn1T4gfnfclAjajHuUAEAlmgFksqX5uxJSWIUgLb0TV7
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

Since commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags
to ptp_clock_info"), the PTP core rejects every PTP_EXTTS_REQUEST2
request for a driver that does not set .supported_extts_flags. The three
users of the QorIQ 1588 (dpaa2-ptp, enetc, ptp_qoriq),
so linuxptp ts2phc cannot arm their external timestamp inputs.

The timer timestamps the rising edge only, since ptp_qoriq_init() clears
ETEP1 and ETEP2. Each patch declares PTP_RISING_EDGE | PTP_STRICT_FLAGS
for one driver.

Patch 1 fixes the failure seen on an LX2160A board.
Patches 2 and 3 are build-tested/code review only.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Vincent Jardin (3):
      dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
      net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 1 +
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 1 +
 drivers/ptp/ptp_qoriq.c                          | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
change-id: 20261006-for-upstream-qoriq-ptp-extts-flags-1c6fd731d66f

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


