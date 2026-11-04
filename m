Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782751;
	b=UaJ+RAEefw6x/SxRyAMw3BLQJbna6OAGi7N8PotPDVQZwoddfvyifMAueBSCwKbvPKdx
	 rwgIG+frfAP9lG1+JeuoYZi1rL9eRmrmCsLwTgIHwjHfZddQOk/jrycQVVypfyUCQIs/U
	 BsbHvo35kLDvlGs+0JNgTt4NcSkDLEUy+JqUr/IJkaY90Qo6qehwwssiPrz32RRJmyXfJ
	 plgpIwzmx3M9xskMph+wjvjFelRIzUUggYzPvXADgU60Y7P1RhIVYd3WzrgOFrKZtHB5N
	 lLZzXATcuK1jNa/KK2IRhh9hPUSwo9gZgYlMYQO8AfAMyiWMLLtXZqavFgNqYeKM3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782751;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=zGI141Yv9NE58oB2X+pDlabk+YgIi5wX/jsZU8v8Pp4=;
	b=2kX10Pg87v4gxCzWqWE8KPbhyehbuXU/0qhSzjBDbfggg2PnoA9B7u7UtKbAk33VHGcr
	 H38cTSFkAoG46DMlTzBfAkqAFIffOqQRMHWuYBQjJf4JdHA6wmslKxmybtRssyFolm5IQ
	 x3ONSAPt4Ys2HABo07TISLA2/fWoqJqA/YZNtUFf0Tp+mWbzaZi0iFsVCVIu7qW21Zuwi
	 mhoYQ2D5G3+G2OiU7XG+AASjmVs6u055u40A+0ZEjQykZW8+JqwDOrSkqLbwPuyXGW2tT
	 gwsgyArgVxsItwEip2EFc97Ac28rORoLmR4NkPOX0ejRjDGuCcVA40MqL7VY6tsp/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B9jQUyba;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E11606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E11606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=B9jQUyba
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5C0834E413F5;
	Wed,  4 Nov 2026 08:59:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25E8060770;
	Wed,  4 Nov 2026 08:59:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5956C103290E8;
	Wed,  4 Nov 2026 09:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793782745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zGI141Yv9NE58oB2X+pDlabk+YgIi5wX/jsZU8v8Pp4=;
	b=B9jQUybapG8VyvGtxfdc988sJ1wpJSrRRaIjB0f4qfG9UkAzdIuWysoxrFlVg1gs9uNg+O
	rgWJQ9kNG6cN0wXpHsT1zTjsdilkYYtKw7YLwHnaTwmbx6i8/91uR9gT78efnP2R7sh0Kq
	8IUjYwcLBk2vNVunpBTWAGOwCdLsWBid1rulPd+vo/CCuGDijTCCngpzHyN69BEHxJ18vK
	8P6llNfWIvU2fUgxbpTY8JUT1dbI/gGKmN6jAXreJbdZZA2GszkzNKan4Nzop+vZlAjxUF
	HopBkl8lC4BS/e5UjqgUl96GbhAEY4BBG9IjGeFyi1l1WUSct1mATaeJsBffdQ==
Message-ID: <7c4eec6a-66a1-478e-8d9c-15394061b8da@bootlin.com>
Date: Wed, 4 Nov 2026 09:58:57 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104052504.1886335-1-jjc@jclark.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261104052504.1886335-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 11/4/26 06:25, James Clark wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> stmmac_enable() and dwmac1000_ptp_enable() ignore the flags, and
> neither stmmac_ptp_clock_ops nor dwmac1000_ptp_clock_ops was given any
> .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for
> this driver with -EOPNOTSUPP, where before that commit the same
> requests succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> Tests on an NXP i.MX 8M Plus (FRDM-IMX8MPLUS, GMAC 5.10a) show that the
> auxiliary snapshot inputs timestamp just the rising edge. The reference
> manuals for the STM32MP13 (GMAC 4.20a) and the Cyclone V HPS (GMAC
> 3.70a, which uses dwmac1000_ptp_clock_ops) say the same.
> 
> Encode this in .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the
> rising edge then succeeds, and one for the falling edge or for both
> edges fails with -EOPNOTSUPP.
> 
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Clark <jjc@jclark.com>

funny this wasn't noticed before, this looks good to me :)

I've tested this on cyclone V, stm32mp157 and imx8mp,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
> I used an LLM coding assistant to help prepare this patch.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index a37405534beb..31a66e855d6b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -277,6 +277,7 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
>  	.n_per_out = 0, /* will be overwritten in stmmac_ptp_register */
>  	.n_pins = 0,
>  	.pps = 0,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>  	.adjfine = stmmac_adjust_freq,
>  	.adjtime = stmmac_adjust_time,
>  	.gettimex64 = stmmac_get_timex,
> @@ -294,6 +295,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
>  	.n_per_out = 0,
>  	.n_pins = 0,
>  	.pps = 0,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>  	.adjfine = stmmac_adjust_freq,
>  	.adjtime = stmmac_adjust_time,
>  	.gettimex64 = stmmac_get_timex,

