Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405E3C198D;
	Mon, 21 Sep 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996295; cv=none; b=G/Gls1elCv8XW5LN3a69azZY/Hl866YoP9jxBYG/WBS07+irKMMRLzJ9FhsOz5yOnpUYOYZQ8aywprIeDlRS2C7tqfAK7QHWKvwxsekxU2gTUsqdExMNCaufoilL/n0SDNHXGxzPah6Ky6Ex/Mmfe7Sr5DAY3Mz+v13fo+pIot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996295; c=relaxed/simple;
	bh=170G/wINedk/LpDaoAUfkaU+wcfqyh6TsCo0Nr5U4IY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=f7mA0dFU+SS/ZmV0SBrb0/gVP0faziXxB36Jm8d7rG0PPlJpdNjB2fL/Mkyt0iuqACsjsPTCR5chvDnng3taP17wdFrJDiP9D7IxQXGdpZsQuuMNI4Awe79O8rTTmeh5ffJvhQ4slpVLtFQZ0VS8/1HwOA8ZkiNDxdOl9P9jYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dkFs4YnL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dkFs4YnL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E14001A0F03;
	Mon, 21 Sep 2026 13:11:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AF915FFB2;
	Mon, 21 Sep 2026 13:11:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54351103281DF;
	Mon, 21 Sep 2026 15:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789996282; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a/OAO1hWOHct6RHp0uO2yGO4InwES539CJG3xP9PBEQ=;
	b=dkFs4YnLMzIYCHARnOQpHmY3nod7H7OhdhcBmN1zDBS2tadgxKDlb1G/wYhn0I7aPHShfa
	foAHlM3tmyxsRyHVJ6LiNs2+e7nB3ewJkGyp/DxEuazB1pqSWKHahB8OVQKB2JpCz+nC32
	FJ2DX0NmzP6Abc3LLLNtNPagkmYCa+vkIrQlyWAWfeQWtaIIJb2eUJ7AqGi/YB8cwBszSN
	uIAgMGVfRq73aZteFRnvygrbyBb729OJgUS7puGqUNVh3hRTMpSyv2GktJg22ohJjqNU20
	+duD+AwF0zsECpR8CpYLP11XabnrGLvmgM3GoYUbIZk3v5a4GhWe2oplkBUROg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 15:11:13 +0200
Message-Id: <DLL0PZY25HAD.1RWXC61P3MZRV@bootlin.com>
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
Cc: "Paolo Abeni" <pabeni@redhat.com>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: =?utf-8?b?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghA==?=
 =?utf-8?b?7J6Q6rO17ZWZ6rO8KQ==?= <5mghybrid@khu.ac.kr>,
 <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
 <20260915083839.71546-1-pabeni@redhat.com>
 <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
 <CAH1Bc_z6PFc7N6XVZ2dQEH=7D9mkXwGkXP2KKMW-Emd4zcf3fA@mail.gmail.com>
In-Reply-To: <CAH1Bc_z6PFc7N6XVZ2dQEH=7D9mkXwGkXP2KKMW-Emd4zcf3fA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Woo-seok Kim,

On Sun Sep 20, 2026 at 11:04 AM CEST, Woo-seok Kim wrote:
> Following up on my September 15 reply. I noticed that the series is
> still marked "Changes Requested" in Patchwork.
>
> This series fixes rejected timestamp requests changing the TX mode and
> the two PTPv1 RX filters disabling receive timestamping. As explained in
> my reply, the additional issues predate this series and are not made
> worse by it. I propose keeping those fixes separate so that this series
> remains focused on the two reported bugs.
>
> Could you please reconsider the Changes Requested status in light of
> that reply and continue reviewing the series as posted?

To me it all depends on the intent behind your series. If you have faced
this bug in practice and your patches are intended to fix your usecase
and prevent others from facing it, then we can take your patches as-is.

If they are edge-cases cleanup patches and you never encountered the
issue (maybe because you don't have hardware), then either
 - the patch won't be accepted because it's overall churn or
 - you fix the full sequence fully and we consider it a noticeable
   improvement and take that series.

About "the proper way(TM)", I expect something like:

int gem_set_hwtst(struct net_device *netdev,
		  struct kernel_hwtstamp_config *tstamp_config,
		  struct netlink_ext_ack *extack)
{
	struct macb *bp =3D netdev_priv(netdev);
	u32 regval;

	if (!macb_dma_ptp(bp))
		return -EOPNOTSUPP;

	// Step (1): tstamp_config->tx_type validation and precomputing
	//           of TXBDCTRL and NCR values/masks.

	// Step (2): same for tstamp_config->rx_filter.

	// Step (3): read-modify-write NCR, writel TXBDCTRL & RXBDCTRL.

	bp->tstamp_config =3D *tstamp_config;

	return 0;
}

Improvements:
 - we remove writel from the validation code
 - we write to NCR once and not twice
 - we don't have a tiny gem_ptp_set_ts_mode() function that returns an
   int for no reason
 - also NCR RMW probably deserves some atomicity through locking

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

