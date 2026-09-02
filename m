Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFA35E94E;
	Wed,  2 Sep 2026 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313729; cv=none; b=B0/sppUrsPbKrCHz/jGYrvblIUXWXQv4GE3eLhRyKZ4Hoe2WaDkKeCfFLZ2lpCwjwuS75vWvCepYucAnyNTC6zfew1xO3Sdx8Y0aVRMl9+hgdhYOO4rRggrznNBSUejPSTyljmsR1vr+MJqQB8x7VrtbK7zFV01qIE/9MayQq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313729; c=relaxed/simple;
	bh=ZUc4hXdMovvUBU+bVv6Yj0xXP2zTmYbEUCvk1alUn+4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Suqx41+oz0NsnBhqK6M0XAgMncZxSAjREgXhtIjzzXnwYvb5C+WkDFQC42K9gKfhdomPlLc72gNb4QM7+DzK5H5n691nCIc2gAEgzTyV/7zPgkI/8QG4IUr8ouxsG5+T/RBzzLCLkVDxeuhPKZYejcnGK4nvWRajlkONhfTsWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=nIffXOkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cw1+p392; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="nIffXOkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cw1+p392"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A84E61400101;
	Tue,  1 Sep 2026 21:48:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 21:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1788313721; x=1788400121; bh=s0Wp34BsCTE9gs9qeINPy
	/sDm+yywWKNSe4d08o5iQc=; b=nIffXOkkv0LGjh0ICsZlIEuSr42xQZrVSxIgt
	qPZeZWm7psTnv6+DM+lt8adamlZiGMbhY4mcV85vUwgliOFoIhwvWbs2dMDyPuEC
	yOHSu25t/uCFGkEgGBzw5IXZFfwuIn7cL+5MGEwWJUWMBEzAmmpi8PuQukVaSMyb
	udPNbngokGq53v/Su/Mu8dAeDNbfe9ncZXpi9+cHwCJ8C9J/TwzU8BtoSHFRV1a1
	FrPuMcy04z1OGX0H7XL93H3PNibowPS+WT/NILLN8BqssivIhyZofH+E1OqSs3bd
	YOhaWKHdGLfvvF2vCBywn4tq4JnAYWWC+pYrYkHFedZcTjgiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788313721; x=1788400121; bh=s0Wp34BsCTE9gs9qeINPy/sDm+yywWKNSe4
	d08o5iQc=; b=cw1+p392J6WKZRXDekqTuWSfoEH/BByAkl7/AmfWPqqjYwH4pik
	FMgirc1sPWlOO6SxxKLO11n5P/l8cFQqb0bHuXiG/A4tS+/CDhzMY7CeQlEx0CQz
	UkZm4h6G6OjQ8Y9ymsWNjTfpVNCOnH7gGiBVazViW8EGZWqDYAoRZb+VNx6mtlol
	/1tZcv5r3tohDyrqWNZ2mAp9hzNT0WqEIQr5rHJdVlHWSbpVka184MOGPGh2agJ7
	NLaHQx4UX5ohcx9k88ehOxOM1cilPGLcpJFPqiJxH9HK1f8WU3kTqNMqV4JKJP4q
	aCDKLcN2b5C03diPpR6JojBrvkP13mRf2cQ==
X-ME-Sender: <xms:eYCXasUFNQYLt8Bf8FmNY-4ZGy1KhJNMp_9qxWDqdJsppizqPFkJrw>
    <xme:eYCXau341tHNIG7PLHIRd0D0LLHEpHscdAiNLBGU4NtJT2zOck3rxqb6mc64wnWWw
    Ycj1AKIejwu9Y-tAhJOWg3PVVjM2fOp_pjmH2xYlDbJUfb62ZNWO00>
X-ME-Received: <xmr:eYCXapsu93OwoQZzcXhcaUvm5JHGk_5vfOkrhdf1WQQTt9S9y5XwMgi3_2L6_DauaL33kw>
X-ME-Proxy-Cause: dmFkZTFPOhnOfb0wATwmFaNmVd3Ea2WJMYbX8qsEu61r5/6z8zlb+lf6lB9OeIPJOFx3b4
    S930wwmHpmRiCyhA0Ymd+1kPx3PsLag9kX2a87l1Ceacd0v1vCakff2xf0AQbf0/G0zi0I
    EKcescoveDfjVHK0NMgz1h9JVsLGqB+D3a/Aq6i1D1xfamtsf3DrsNauCRRhITIh4+UsdI
    qrH0hI4mGnIzkQNBbgai0UJSjjffYa9C46+maZ5/jBIegrAoB1r3G7QR5r8LfDvauY4F/j
    t5bH2p+joTKQt7+7dAkGK5swo1bri4MS5GH6465SH5+vuRuk/XOtx7qGjY7+dGaT9RHpie
    rnO4fms0gqNXKf87+Xw5ImRnbIew4k9oifaX0a/Q68Z3dqEZpKB7dNTH7Q75piA1L0Kt6X
    TkLIiCCoV3pV19EoxhwRdbZjXMzuzWqsaDEtNHmHfXRoPsJpnPDWYCZfxM7+LPBjEjvwGb
    HRQXzp7IUqicGXwUERdYD6S2PHfLXA6WxBSJOo0PhNYMTmSPf6FxgAy0JXfA1MysMORjap
    ORp6dMZT5jrH8fwYD2lY2b7o5bNi4PtDH+6m0kJbXnyFvsoCVs88vpGseMOJEdqJa+Q5hy
    kK8aIKHhhsErrV4lE/OwMXlgzDyUeuaOT8kTdmdmyviULqyHTtdB5L6tI9LA
X-ME-Proxy: <xmx:eYCXauXs5suIafBQ-ifetReCFSx1tyKknSlQNChCg9eHQs-GBHYJng>
    <xmx:eYCXapy2DxMc0bCJ3KGpXScI4WqMeC7KiqpYsS-LMLsPKZagGayInw>
    <xmx:eYCXalFTwpgKy9ZjOLqMqfvHLNRgzWRJfnIerExWQtM5FqmOmoRfYg>
    <xmx:eYCXaut4lXaJhWW3njW0MhkpJ0EU02dYEelPHJ3vAwyaE4Ykke9BzQ>
    <xmx:eYCXaovW1s0pcN7Z33DsEhKARso1fHMAUMLdkf953DELBHtvclAN6AYP>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 21:48:40 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 58F2B9FC75; Tue,  1 Sep 2026 18:48:39 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5644D9FC41;
	Tue,  1 Sep 2026 18:48:39 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <hangbin.liu@linux.dev>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v6 0/2] bonding: fix TLB load-tracking overflow on
 high-speed NICs
In-reply-to: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
References: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
Comments: In-reply-to Hangbin Liu <hangbin.liu@linux.dev>
   message dated "Mon, 31 Aug 2026 09:50:58 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <591551.1788313719.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 18:48:39 -0700
Message-ID: <591552.1788313719@famine>

Hangbin Liu <hangbin.liu@linux.dev> wrote:

>The bonding TLB (Transmit Load Balancing) mode tracks per-slave and
>per-client transmit byte counts in u32 fields. At sustained throughput
>above ~3.2 Gbit/s over the 10-second rebalance interval these counters
>wrap, causing compute_gap() to produce incorrect gap values and
>mis-select transmit slaves. Such speeds are routine on modern NICs
>under heavy traffic.
>
>This two-patch series fixes the overflow by widening the relevant
>fields to u64.
>
>Patch 1 converts the unbalanced_load counter to per-cpu state as a
>preparatory step. The counter sits in the transmit hot path, so
>converting it to per-cpu before widening avoids introducing cross-CPU
>synchronization overhead for a u64. Also use a prev_total_unbalanced
>to store the previous total load to avoid reset per-cpu data.
>
>Patch 2 widens tx_bytes, load_history, load, and the per-cpu
>unbalanced_load tx_bytes from u32 to u64. It adds u64_stats_sync
>protection for the per-cpu counter to prevent tearing on 32-bit
>architectures, and reworks compute_gap() to use s64 arithmetic with
>READ_ONCE() on slave->speed.
>
>Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

	For the series, looks good to me.

	My only nit is that you don't state why you use READ_ONCE for
the access of ->speed, and I didn't see it in the prior discussion
(perhaps I missed it).  Regardless, I presume it's because the access
could race with a concurrent update in bond_update_speed_duplex.

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J


>---
>Changes in v6:
>- Do not return fixed value for unknown speed logic, we need load balance
>  even NIC speed is UNKNOWN (sashiko)
>- Link to v5: https://lore.kernel.org/r/20260825-bond_overflow-v5-0-7a800=
de133f1@kylinos.cn
>
>Changes in v5:
>- use s64 as the return value for compute_gap, so we can compute the
>  difference when NICs are overload. (Nikolay Aleksandrov)
>- Link to v4: https://lore.kernel.org/r/20260820-bond_overflow-v4-0-805ba=
0d3efb6@kylinos.cn
>
>Changes in v4:
>- move per-cpu allocation to tlb_initialize/tlb_deinitialize (Nikolay Ale=
ksandrov)
>- use an extra prev_total_unbalanced to avoid reset per-cpu data (Nikolay=
 Aleksandrov)
>- Link to v3: https://lore.kernel.org/r/20260818-bond_overflow-v3-0-e05d4=
dbc2fd8@kylinos.cn
>
>Changes in v3:
>- Add a preparatory patch to convert unbalanced_load to per-cpu first
>- widens tlb counters to u64 and add helpers to prevent tearing on 32-bit
>- Link to v2: https://lore.kernel.org/r/20260814-bond_overflow-v2-1-d3fe5=
88ad167@kylinos.cn
>
>Changes in v2:
>- update comment description, including AI-detected info.
>- fix tx_bytes/load type detected by sashiko
>- cast SPEED_UNKNOWN to 0 before shift, detected by sashiko
>- Link to v1: https://lore.kernel.org/r/20260810-bond_overflow-v1-1-c9ff2=
9d76770@kylinos.cn
>
>---
>Hangbin Liu (2):
>      bonding: convert unbalanced_load to per-cpu state
>      bonding: fix u32 overflow in compute_gap()
>
> drivers/net/bonding/bond_alb.c | 63 +++++++++++++++++++++++++++++++++++-=
------
> include/net/bond_alb.h         | 14 +++++++---
> 2 files changed, 63 insertions(+), 14 deletions(-)
>---
>base-commit: a8455260b2e9c024d1872ac1c094793d55a7e537
>change-id: 20260806-bond_overflow-ac6a6a78d6a0
>
>Best regards,
>-- =

>Hangbin Liu <liuhangbin@kylinos.cn>
>

---
	-Jay Vosburgh, jv@jvosburgh.net
