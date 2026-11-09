Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216979;
	b=Bgfez30pz1+2VmSrkGEmYTX/ve9OP18J/qoES1yvEnrpvJ46SEnDYKhDjovq1Wczit+M
	 XHnmc07i3KXQ17a0/wwqT7NCSnwvLHNa2pFpDzqohmkpiExxi/gRsA0/ya3WDfzwNKL3k
	 3ZaBFyjZ0xoDBJ1sP1FtDKsrbsV+PXoPk3sT1mQHPKAki9OKwLBSVvVx8MFmylFNnTfSW
	 xrfPP494WM0UJxMwbypvrazIWtm9xFTTZRjk+//FtHch5yUW52scZKa19EJ3iN4IQo7rQ
	 OOFChEqrAFb38LZwyCdBdaVBGf7Lopuc1I0K/+3bONdFB2SCwa8XU9JxBFe/6CeH/8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216979;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=dHRGfCgTvHqw+Xm+mcoU8W0ABowFwhenFntbddoej4k=;
	b=GdCK97mWYkD58zX9bZhBsQvhmJ/9U9zhfXyUb9BAZHkra5ekU5usC6Z530VswQciT7hR
	 lvSbrb0hdQTVTHEGBhCnQYWrRi31VTb/uvjAhyv0GeNDoYgQNFAEVBXPwCPBtS3sl7FH4
	 RLSfAJR49l0gs3Pljc6nBxUOIWef05ManidY9Q4lOfl5lesljcIoYPgXCuN/05cxQZpj6
	 UoySjUEs7C0E+XWgijX5WvP3b4EPfo1DVbIFJiQaVN07ye+wVg4uGp0wEGbAvI1sgDP5V
	 CvtlCcAdu6mLvz7Tifh/8pYE4JkDGaG9zEPIpHi5uJFm1EOKh+V5rzVuL0oeltitk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=t97r7erB;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A9606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48A9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=t97r7erB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E46761A15D0;
	Mon,  9 Nov 2026 09:36:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B959C60051;
	Mon,  9 Nov 2026 09:36:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D38BD103293AB;
	Mon,  9 Nov 2026 10:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794216972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dHRGfCgTvHqw+Xm+mcoU8W0ABowFwhenFntbddoej4k=;
	b=t97r7erBFKewO+0p16spvAdkRX18pXHGfVRcQP++9YFkQUSf+rH1ByZeKuZwsJQChpSdPw
	qQKaj6dmhoSJmh3QeYxSucSHAu+oF+fbZgahyYfHMIRrThTpVLm1wmEDSPhc57ispC9gxO
	kzo84Rswy+xxi0gFta4N73DdU3IU/jKsQNswWGPQSupbYywvJZLLuhNaxkBTkJQF2xwBUQ
	K3qkTzRqffk8QEfsCwN78uUovqmaodRnfSTvzqyCX1mceiBGaOk/pAoaG3e+W8sEna2n+/
	MmZ050cZshpjJ7LobLukabhAmU/b08JUeSxtJ6jHKCo7eFtRMADMTabzC6su2w==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 10:36:07 +0100
Message-Id: <DMQKTZSD2W8Z.42K05D0EP34X@bootlin.com>
Cc: "Sean Anderson" <sean.anderson@linux.dev>, "Robert Hancock"
 <robert.hancock@calian.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 0/2] net: macb: two fixes for macb_tx_error_task()
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
In-Reply-To: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Sat Nov 7, 2026 at 9:58 PM CET, Nicolai Buchwitz wrote:
> Both pre-existing bugs were flagged during the clashiko review of my
> software FCS patch [1]. These are the promised follow-up patches.
>
> Patch 1 credits the frames dropped on a TX error to BQL. Patch 2 takes
> tx_ptr_lock in the task, as macb_start_xmit() moves the same pointers
> under it.
>
> Tested on a Raspberry Pi CM5 (RP1 GEM). The bugs are hard to reproduce
> and the error path never fired there, but they are worth fixing anyway.
>
> [1] https://lore.kernel.org/netdev/d1f02ab923c0464fa73cafa75a21943d@tipi-=
net.de/
>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Nicolai Buchwitz (2):
>       net: macb: credit unsent frames to BQL in macb_tx_error_task()
>       net: macb: take tx_ptr_lock in macb_tx_error_task()
>
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Yes! Same as you: I never trigger this codepath, so I cannot test
easily. But with your two patches, macb_tx_error_task() is a bit less
broken. It should also reduce Sashiko splats on future patches which is
a nice benefit (of course it won't be silent, it still has
macb_hresp_error_task to complain about).

For both patches:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

