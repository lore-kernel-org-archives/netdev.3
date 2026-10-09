Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3622609C5;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504065; cv=none; b=Al1X1YIt8tox7iuQU0PCbYxeRuD79Y8rxyThPI3EG0a56ZGlUJpAEKP4kStWjEtZ1rNHgMWBHd72c9fuCUcGxWeAeZyEVQVY/t4YmtaPM3p0VTKyMh7rHuiC79zmuUbS2LLHt8fW5JFG8/KaXO+PC6Fx2L5BDsKT0yn94l09cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504065; c=relaxed/simple;
	bh=IY3PIrb5SJKIE9d5KhsV8O7ykEDOUAqs5XBK3USoiqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ffP3we1GoTZK+Efkt+rKXRfYweZ9uoBG44LN/EeHMIQHqU2PB4U4qLQk8fV1vZoniZBshaIa9nIzVNyidCVgs9azfTo8MSDENiVl/L1QmH7WgeeZxx1uE3XAfzH37mgqKT1CL56YfUKgvTN6nvJky1uxQidXlL4AFaHNdzJcPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2PEnswS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2PEnswS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9557EC2BCC7;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791504064;
	bh=IY3PIrb5SJKIE9d5KhsV8O7ykEDOUAqs5XBK3USoiqY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T2PEnswSQL2m/jHf52bx2E/pXVLsmTC9FkqeNX6dUXWOk11XGFMgGg+JluxNr+NgM
	 KABa3Wz7irsNSPlXNTMAkIbIb+1oj2j6+2fl6YpNELH3d0j3KCoNO9KlRsKNd9OzMp
	 wvqKelCvlOIN6pF58aWXqeLb4zLp/Le7HHYqG7WmvqJT044hU0YoS4UBIhoOgE9GAY
	 2OkoRCiI+m4giqG1eRz9tT04xOt1HPc4+frKesLC0tXwbDzZbjlxWPHrxNTErL0PoF
	 PFRlw4Irp1A4WjSWuwcxAI2fujrN91cHe0PSyTgc7r885mTWDLkkTvR3q35Ar2DzKe
	 HFA0orzklDH2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E6CA6018;
	Fri,  9 Oct 2026 00:01:04 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH net v2 0/3] net: freescale: fix PTP_EXTTS_REQUEST2 for
 QorIQ 1588
Date: Fri, 09 Oct 2026 02:00:55 +0200
Message-Id: <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALcuyGoC/5WNTQ6CMBBGr2Jm7Zi2mPqz8h6GRYEpNFFaZirBE
 O5uww1cvu9L3ltBiAMJ3A8rMM1BQhwLmOMB2sGNPWHoCoNRxmqlLPrI+EmSmdwbp8hhwpQT0pK
 zoH+5XlC31neXSnfWeiiixOTDskeeMFKGuoxDkBz5u4dnvV//NGaNCpuz01Y3N3OtzMMz0ckz1
 Nu2/QBsYeh/1wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791504062; l=1907;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=IY3PIrb5SJKIE9d5KhsV8O7ykEDOUAqs5XBK3USoiqY=;
 b=KkwUq2d3ZcWm9hy2BGF4b4MLkmKfzptFVn8f9Ano+l1700cImIoEYz4edkquEdLYId/1aVPL9
 3eHPsFtocBKAJHsGX+kCj3h3QlIXN5GKY3cmaCwuC2IuEHKfLt44lJf
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

Since commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags
to ptp_clock_info"), the PTP core rejects every PTP_EXTTS_REQUEST2
request for a driver that does not set .supported_extts_flags. The three
users of the QorIQ 1588 timer (dpaa2-ptp, enetc, ptp_qoriq) do not set
it, so linuxptp ts2phc cannot arm their external timestamp inputs.

The timer timestamps the rising edge only, since ptp_qoriq_init() clears
ETEP1 and ETEP2. Each patch declares PTP_RISING_EDGE | PTP_STRICT_FLAGS
for one driver.

With PTP_STRICT_FLAGS declared, the core checks the edge flags of the
legacy PTP_EXTTS_REQUEST ioctl too: a legacy request for the falling
edge, or for both edges, now fails with -EOPNOTSUPP instead of being
timestamped on the rising edge. Each commit message says so.

Patch 1 fixes the failure seen on an LX2160A board.
Patches 2 and 3 are build-tested/code review only.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v2:
- add comments about PTP_EXTTS_REQUEST (Sashiko)
- Name other users of ptp_qoriq_init() in each commit message (Sashiko)
- Add Reviewed-by tags of Jacob and Kory, the code is unchanged, only
  commit log improvements.
- Link to v1: https://lore.kernel.org/r/20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr

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


