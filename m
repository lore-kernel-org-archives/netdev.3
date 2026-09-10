Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791C3CB2F8
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024402; cv=none; b=I8wPZBDeK5JvaYt+2Pw6DjLx4EBDvWf6L3UbIG+QlUQcbakV48TK6qQRoWRESdtom5xau62+jNrMMxmgdRpxtNQ9et643qjBMnF4Dx9DeldQRp+/28ZVTGHEQvnkteKPPda9Vcm8D9wSMOgkKK3RnkZA2lKFpsHfGpUFcISzoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024402; c=relaxed/simple;
	bh=fffekK7AapVIVynDE9YUbHpgRADon2nGwP8qdjLXKSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ef2rIJ4VPoobl1OuaQHyd2uY3nwWHjQm63Im3TiVVNvSI/mfJd+3PrIF1C5OI8m7DS91nUF0DtVdd2zq1VnQtgI18hQXCKqWSDNtRfxaSdp+kSZkYsqrJHoCrbLWRlQnKitOQZWFWHnJ9Bbws9XlLJEg5qhtc00xLWjdje3ViFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P0DUM8I8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P0DUM8I8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D0D601A1A8D;
	Thu, 10 Sep 2026 07:13:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CD07602B8;
	Thu, 10 Sep 2026 07:13:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BEA411C7AF5D;
	Thu, 10 Sep 2026 09:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789024395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9WU12DE4FC9F3p5LnbxXD4loTgoWcD6hopLD4rZm3ME=;
	b=P0DUM8I8olU8qUDSJoUZoms3xMfWsySLLNWY5RjffqgIREOJvJAmRO5G6ZiatSunyCSo7A
	2/3ryUpWPFZNVwQB1ARVzc8jpoWjkAAgJcD4htkY7k+tBR5DSsw75WTHms/tGQkzqajdBV
	ERJe2l+k3VKM4tfWNgRmiaNNX3Hf0V87r5+sKyOtJ2U7OWRRTB8IZXmfQcTrrYhVQo7L5t
	cTFsYXgfwdBtt0kMCv1UeNu0rWhgS5MU5erYTz1Fia7wlB6y1UGg2LcbPBEFestLyJR1SL
	xWAmyn/cO2MGnlHRhh96Uy+WcpDvYOHo8Z2MOG6NEK2VhPaBaNa0M2pTe6CRwQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 09:13:09 +0200
Message-Id: <DLBG7UPDG84Y.18RL7VOGSDMQY@bootlin.com>
Subject: Re: [PATCH net v2] net: macb: fix ordering around PTP timestamp
 read
Cc: "Richard Cochran" <richardcochran@gmail.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, "Nicolai Buchwitz" <nb@tipi-net.de>
To: "James Clark" <jjc@jclark.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260910040658.18359-1-jjc@jclark.com>
In-Reply-To: <20260910040658.18359-1-jjc@jclark.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello James,

On Thu Sep 10, 2026 at 6:06 AM CEST, James Clark wrote:
> PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
> bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
> returned interval can be as short as 37 ns, while an ordered register
> read takes approximately 1 us. This biases the midpoint used by phc2sys,
> causing CLOCK_REALTIME to run approximately 0.5 us ahead when synchronize=
d
> to the PHC.
>
> gem_tsu_get_time() reads the nanoseconds register using the driver's
> relaxed MMIO accessor. On weakly ordered systems, the subsequent system
> timestamp can be taken before the register read completes. The internal
> smp_rmb() in the pre-timestamp path also does not guarantee ordering
> against the subsequent MMIO read.
>
> Add rmb() before and after the bracketed nanoseconds read in both the
> normal and seconds rollover paths so the system timestamps bracket the
> PHC read. Adding the post-read barrier increases the minimum interval on
> the same Raspberry Pi 5 to approximately 1 us.
>
> Fixes: e51bb5c2784c ("net: macb: ptp: Switch to gettimex64() interface")
> Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5, min brac=
ket 37 ns -> 981 ns
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> Changes in v2:
> - Add rmb() before the PHC read in both paths, following Th=C3=A9o Lebrun=
's
>   feedback. Explain why the pre-timestamp path's smp_rmb() is insufficien=
t
>   for MMIO ordering.
> - Wrap the post-read barrier comments.
> - Add Nicolai Buchwitz's Tested-by and Reviewed-by tags.
> - Drop RFC.
>
> v1: https://lore.kernel.org/netdev/20260908053150.28694-1-jjc@jclark.com/
>
> Nicolai's review and testing were on v1. The additional pre-read barriers
> in v2 address Th=C3=A9o's feedback.
[...]
>  drivers/net/ethernet/cadence/macb_ptp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethern=
et/cadence/macb_ptp.c
> index e5195d7da..4fb287608 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -50,7 +50,15 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp=
, struct timespec64 *ts,
> =20
>  	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
>  	ptp_read_system_prets(sts);
> +	/* ptp_read_system_prets() uses smp_rmb() internally,
> +	 * which does not guarantee ordering against MMIO reads.
> +	 */
> +	rmb();
>  	first =3D gem_readl(bp, TN);
> +	/* Ensure the PHC read completes before taking
> +	 * the post timestamp.
> +	 */
> +	rmb();
>  	ptp_read_system_postts(sts);
>  	secl =3D gem_readl(bp, TSL);
>  	sech =3D gem_readl(bp, TSH);
> @@ -62,7 +70,15 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp=
, struct timespec64 *ts,
>  		 * (assume all done within 1s)
>  		 */
>  		ptp_read_system_prets(sts);
> +		/* ptp_read_system_prets() uses smp_rmb() internally,
> +		 * which does not guarantee ordering against MMIO reads.
> +		 */
> +		rmb();
>  		ts->tv_nsec =3D gem_readl(bp, TN);
> +		/* Ensure the PHC read completes before taking
> +		 * the post timestamp.
> +		 */
> +		rmb();
>  		ptp_read_system_postts(sts);
>  		secl =3D gem_readl(bp, TSL);
>  		sech =3D gem_readl(bp, TSH);

Honestly I wouldn't be surprised to see this code without comments.
Especially as the rmb() were added in a separate commit so git
blame/log will point to your commit message which is plentiful. It
would have been different if the rmb were part of the commit
introducing gettimex64 support, with a commit message which would
probably not talk about why rmb are required.

Don't bother sending a new revision just for that though!
With or without the code comments:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks James,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

