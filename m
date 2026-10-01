Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FF3E315E;
	Thu,  1 Oct 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870809; cv=none; b=TmjP10kle5MiSqzLHTLnb5nEPsq7AspMOxLcZEU1BY5oveznnlQg33dy2eW+6jS7ui0OfWSqxmass7stIUC6ImxL0WjVz3AfVb/ZlrQlMrEvWVSeR1mZvYvm36XDGVctjpm7iKTLDNkvcZkd4PFl0UonD7qlpu+6bOKHqq8Wl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870809; c=relaxed/simple;
	bh=F5mU3kl9Q2F5fwusJRX496NOIuwaavSa3cvDRpB5g50=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Okrf/K9b+izoFQfUeFElJCbv5g7LTpM0eWGGwVY+ujTcM9pFAEVx2zlyAxSJynLpzJ34IpZ36fOovQUi1YqcCFwrhg7FgpP7pOVyoJWTY85nCLf9vy4nvMqbBHah5OuVbeAhmRybb72OUkNh61L2+eq7hxuECQFJgZ+f5gUNUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO6DDLSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO6DDLSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9621F00903;
	Thu,  1 Oct 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870807;
	bh=DX02iYzTZaCoemhyaPZuLm9QwmSCRpZhJHz9pgsaGC0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MO6DDLSQ/YRYkWVJ6+5uzywXPBrKgN/8MXy4JOizCJDSrxZAyWFPLsSce8FiIgkRZ
	 73u8uE+O53h3jw/j8F3QhrfQvEqfV8MNd9ImMGyGZy7JhjtZ5UW5PGN6crprDCnejs
	 bXnK+uYgHS3IxKW6YnxTJ7bVTHPmX90qR7oMZeksEvXz1WOtvV+H+sBMdxr3LUDFOy
	 xioUazdp5Xkojfnr4r87pcsqinUMhpvLzbiuzE19ivsUInm4EILj3CDSzfFW2razPa
	 VRuLIe/oxy6aqYImnka+VFsu/64WKYuIFErXS3Za39SQWfK/RnkWXQXvMCMcnK1jTa
	 iH/FPf/M9+wPQ==
Subject: Re: [PATCH net-next v15 4/7] r8169: enable new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:46 +0000
Message-ID: <179087080624.434549.12502317761885183568@kernel.org>
In-Reply-To: <20260928070423.202-5-javen_xu@realsil.com.cn>
References: <20260928070423.202-5-javen_xu@realsil.com.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the patch "enables new interrupt mapping
  for RTL8127", but at this commit the new code can never run.

--

r8169: enable new interrupt mapping

This patch adds a helper that sets INT_CFG0_ENABLE_8125 to turn on the
new interrupt vector mapping for RTL8127. It also moves the rx error,
dropped, length, crc and multicast counters from dev->stats into per rx
ring u64_stats counters, and sums them in rtl8169_get_stats64().

> r8169: enable new interrupt mapping
>
> This patch enables new interrupt mapping for RTL8127 and add error pkts
> counter per ring.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 4656ae108f9c6..20eb7987f03dc 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -4092,6 +4111,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	RTL_W32(tp, RSS_CTRL_8125, 0);
>  	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>
> +	if (tp->irq_nvecs > 1)
> +		rtl8169_hw_enable_vec_mapping(tp);
> +

[Severity: Low]
Can this branch be taken at this point in the series?

At this commit, rtl_alloc_irq() still asks for exactly one vector:

rtl_alloc_irq() {
    ...
	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
    ...
}

so tp->irq_nvecs is always 1, and rtl8169_hw_enable_vec_mapping() never
runs.

rtl_setup_rx_params() also still sets:

	tp->num_rx_rings = 1;

so the new per-ring counter loop in rtl8169_get_stats64() only ever
covers ring 0.

The next patch in the series ("r8169: add support and enable rss") adds
get_min_irq_nvecs()/get_max_irq_nvecs() and rtl8169_set_rx_ring_num().
Only after that does the mapping actually get enabled for RTL8127.

This isn't a bug, but could the commit message say that the mapping
enable stays dormant until a later patch allocates more than one vector,
rather than saying this patch enables it?

>  	/* disable UPS */
>  	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
