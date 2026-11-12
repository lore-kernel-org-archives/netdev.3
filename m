Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472674;
	b=MB0U6YdkEkSOZm/y0D41lm+DUGv6vF1Kl+I9sZjN1LRPVR3e9WUaOTyO3JNBz6yFY+cX
	 zSQJyL3XLIxBjv0LeI8CMYHBd1e+ZOlgkHYezRd9o95lhel7e3ejW9d49ofFWAzoOamMS
	 LsfDXwzqZqAw90qOyXHq54HRKEN7BnQBzi5J5UbJuPCu/KfzgAXscy9vSBazj3KUgNlSo
	 1Eg8r4Ydz5Fwv2W6alIkZGk5RzpcuKxplw0u5JknDK2srybcdAFvvGupO0refwsBr7DRH
	 kZlcNmbNv46abTvCJBQV+y5riBL1jH+S7sAidPjuVViegYRu4FkvOHdpnvETb6Aunyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=TMY6A5GcpY0Fbu9M9UiBvO7xlXRTKZ0wp76lY/Bnv2g=;
	b=imRJp/xA/D4bY1TvXCPgh6SGVXYYyYOh07/fnMEUpFGlVQ0bmsNTV43K1mqrPWoAiPnL
	 zMrOOTtXzAgSkMuNDI1f3K8kooy3GbyM14PAxBZcqnfT7VSp8oFiw3BXk+V9RwEA5TNUU
	 Zu2vGAT8CIQ6q7b1wivXLCVAggajiJpCKD31JB81f0Ho8KP9rtf4voBA0xAmEv5Gbyulo
	 CaYKH5kULjxgYUANp8EzYVsY0D+e1DWK4ZhIWon8EE4/tiv/pf/1nGRM8/Wk4gkWwvD4J
	 vPE6OGJNYHVT4g0i3U1GALLo2TxDnsx2YPKMTW2EjQD9yu+vt+ItQkmzxJb9ENCIQYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="JUGHk0/U";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1E606A8A5;
	Thu, 12 Nov 2026 08:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF1E606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JUGHk0/U
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5F09C201A86;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TMY6A5GcpY0Fbu9M9UiBvO7xlXRTKZ0wp76lY/Bnv2g=;
	b=JUGHk0/UI5gBtpv3ECJ4K1LK2hyn/5vBYIrQtDcUOmd8tCvCM6MEe1rt0DGODxUA7Z7bJQ
	4e0mDaXNKysLvqDGRdWcZPdveqbD66yLgkXbKyrjyIswoKNKwNMHMSlSbHigT5AESwLDnP
	VNK4HKXwUh8CxuEN5Mtx0usoB7+VfEry8IudMqrzS+7ffPBeabqJQrQE78rauCiIopg/lh
	BOyKT0moy/siMCpHRgQvTcWINERip5LVdXbGGSi/gwi0cV8IADZhRZje5bOMdNys+0Ciff
	aik36rejD30wq48L8dU+hJpTPyCHxIvwOx3FwmQi8Rz4O2Hlx8XWLwiyjcqmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TMY6A5GcpY0Fbu9M9UiBvO7xlXRTKZ0wp76lY/Bnv2g=;
	b=LMwmZiUrPDOKakP/zKmJ80DwTrxZIWMpJKabMtcGcYaeMNveFQW/epMHIfk4kX2ax9+/si
	KN/pP2AY3ZB47YEJlcZQ5uN3IYQmVRZ6V1c9ZAkSGtEv4TyDQzUfmJK83FhUn8EoLJeLUG
	TG8FEIdCC4ycXM8Ik4+8bSsohvOaplExMVidZcWVJxXElFzd28UAbhd3AIeH8NNt4Ac14Y
	Wxo/FWDSBzt/akpTSNN6znBmqYEi66Obv8S5I0Vww3RDmbi0xWoDx5n8LPNWQ9dHJ2jCk6
	kMSO2jEfzFC9cI5FVRiR4nhB9t5AUeQVzBqN84Ir81S+NuKfHd+g84BzHtyzww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=QUh2UVWItogChS8lQdp5UPLBWk0cO3M5mGy2rdie3+0FqC7YC8I6JV3knMpCRnGFR4tUNe
	fNgXQd189U/d9/5y3VFFW3UzJlpB8E5Qv8vcJAdFunu7MVBn8fjiRPOUgg+3FwR9/RbWhy
	4+y9d4cwQbsJPNaOT6nqtpKuac9HWhKl2N6K+phuAbz547tNH/pwjXgVhxqtfv0pLGeq1j
	ojEOixXFOFKRo05d71Pli6+s/5PPXS0Y2M/fRt7SeW6Q/hJp18Fi67ZTGg/8gnVQRz3fV+
	xb+dZpvxbTxYNwv7CN43H1IBun7IfLvgJ/ea/HRNa+bcDfdF/Y6g0vtOxvzE1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 502CC3809F9; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 00/10] net: dsa: realtek: rtl8365mb: DCB
 ingress QoS offload
Date: Thu, 12 Nov 2026 09:37:43 +0100
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANd69WoC/zWMQQrCMBBFr1Jm7WCSYlGvIl1Mkmk7YEZJQimU3
 t0ouHz8/94OhbNwgXu3Q+ZViry0gTt1EBbSmVFiY3DGDdaaG+b6vPbDJXmMwaPonLkUNJG4t2R
 cMBM09515ku3XfYByReWtwtgWT4XRZ9KwfLuRVk74f5wTicJxfADiO+/klwAAAA==
X-Change-ID: 20261109-rtl8365mb-dcb-ingress-0dae31a02c0f
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Add ingress QoS offload for the RTL8365MB switch through the dcbnl app
interface: a per-port default priority, PCP trust and DSCP trust. The
mapping helpers go to net/core/ieee8021q_helpers.c so other drivers
can share them.

Two changes are visible to users. The driver now rejects a devicetree
port that the chip does not have. With a default priority set, an
untagged frame that leaves a VLAN-tagged port carries that priority as
its PCP.

Tested on an RTL8365MB-VC with eight queues.

ETS scheduling and CPU-tag pre-classification will follow in separate
series.

v1:
https://lore.kernel.org/r/20261002115850.962676-1-o.rempel@pengutronix.de

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Oleksij Rempel (10):
      net: ieee8021q: print traffic type and queue count with %u
      net: ieee8021q: add pcp_to_tt()
      net: ieee8021q: clarify the tt_to_tc() traffic-class mapping
      net: ieee8021q: add tt_to_pcp()
      net: dsa: realtek: rtl8365mb: describe the ports of each chip
      net: dsa: realtek: rtl8365mb: store the egress queue count per chip
      net: dsa: realtek: rtl8365mb: add QoS baseline and DCB default prio
      net: dsa: realtek: rtl8365mb: program the PCP of untagged frames
      net: dsa: realtek: rtl8365mb: offload DCB apptrust
      net: dsa: realtek: rtl8365mb: report the DCB DSCP-to-priority map

 drivers/net/dsa/realtek/Kconfig          |   1 +
 drivers/net/dsa/realtek/Makefile         |   5 +-
 drivers/net/dsa/realtek/realtek.h        |  32 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  70 ++++-
 drivers/net/dsa/realtek/rtl8365mb_qos.c  | 507 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_qos.h  |  33 ++
 drivers/net/dsa/realtek/rtl83xx-qos.c    | 209 +++++++++++++
 drivers/net/dsa/realtek/rtl83xx-qos.h    |  20 ++
 include/net/ieee8021q.h                  |  21 +-
 net/core/ieee8021q_helpers.c             | 103 ++++++-
 10 files changed, 979 insertions(+), 22 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261109-rtl8365mb-dcb-ingress-0dae31a02c0f

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

