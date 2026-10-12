Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E42BD033;
	Mon, 12 Oct 2026 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779433; cv=none; b=FBR9GR0PN2x21bqRg6HTmdLxzahaEL7bJGHSTJUfgHz7zMSiGurvn2K8l4y2Cp1iNlQK/60fThjP+YLATwd/QOn97dpJf/w/kaoy6RRJlgw4btiaM/oqybiR01sJQiWcU+cq3vY8MeA22WOEHQGUwGQ7EqYSGhQwiGOI3tD5WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779433; c=relaxed/simple;
	bh=9jY69FiLw6WSt8t0W8Yy55L0q0eRB4ZdxPkG7etOsrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uafmnLycmqdBEOcoxv+WVKgRVoIobEZ+I6Z392E7ey4qD8j5N+i1nk3e7ZnIYFlShosYbq5WaPRK4CilACBAgg+giHu9Ydcn1KeVSgdNW5HlWOPcDzb/sz22Bemw7SJhd8TZUK7YMU2WvW/Tng096W8PD+8xY2asODiAuvHesNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5nto+yM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5nto+yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990131F0089B;
	Mon, 12 Oct 2026 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791779429;
	bh=LmxiW8ecbgTyq0XIhapOQCCxxMkdGoDLUc516Nsm02M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C5nto+yMoAyhCwKUjoMBZoQCrTiJKbs7f3q8Unhlryl2rZfBdsFRQS2i50Y4YtQiA
	 hDg2rYfglnSu1WVGVyetbMNYLP+KsSgEBaMVilNqli4YUVsPz2ivvtvicGvOF0V/Ky
	 RrbxQScvT9epn5hXe1eneKENaQRH+miF3IaNeUrs28/7JcFzG2PJaetzX9aDb9srJl
	 qMc9HnMi34xLUCZjqa63/EvIpt1X2YzATqU4KsC1GkZp849UGn2KkPUu2k+2aZiJ1K
	 ua6URIEwm1cYuz/QLpAWsuEogTSih50xV1ndwdIaEw1cRi2rnaJRTDcWgJqGb00OTF
	 VAdmdriFWEZZA==
Subject: Re: [PATCH net v2] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS
 responses
From: netdev-bot+sashiko@kernel.org
To: xinsheng.zhu.ny@gmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, oliver@neukum.org,
 giuseppe@southpole.se
Date: Mon, 12 Oct 2026 04:30:28 +0000
Message-ID: <179177942813.434549.3756195226539512858@kernel.org>
In-Reply-To: <20261011035150.53315-1-xinsheng.zhu.ny@gmail.com>
References: <20261011035150.53315-1-xinsheng.zhu.ny@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes binding stricter for every CDC NCM, MBIM and
  Huawei NCM device, but the commit message does not say so.

--

net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses

This patch changes cdc_ncm_init() so that GET_NTB_PARAMETERS must return
the full 28-byte NTB parameter structure. Before, only negative errors from
usbnet_read_cmd() were rejected. Short and zero-length responses now fail
with -EIO, and negative errors are passed through unchanged.

> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 35db38cb3e4a2..79893d2342ca1 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -524,9 +524,9 @@ static int cdc_ncm_init(struct usbnet *dev)
>  			      |USB_RECIP_INTERFACE,
>  			      0, iface_no, &ctx->ncm_parm,
>  			      sizeof(ctx->ncm_parm));
> -	if (err < 0) {
> +	if (err != sizeof(ctx->ncm_parm)) {
>  		dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
> -		return err; /* GET_NTB_PARAMETERS is required */
> +		return err < 0 ? err : -EIO; /* GET_NTB_PARAMETERS is required */
>  	}

[Severity: Medium]
Can this turn a short GET_NTB_PARAMETERS reply, which used to be tolerated,
into a bind failure for devices that currently work?

ctx->ncm_parm sits in the ctx that cdc_ncm_bind_common() allocates zeroed.
__usbnet_read_cmd() copies only the bytes the device actually returns, so
any fields that are missing read as zero.

The driver already replaces a zero value in each of these fields:

  cdc_ncm_check_rx_max() raises a too-small dwNtbInMaxSize to
  USB_CDC_NCM_NTB_MIN_IN_SIZE.

  cdc_ncm_check_tx_max():
	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */

  cdc_ncm_fix_modulus() resets tx_ndp_modulus, tx_modulus and tx_remainder
  to defaults.

  cdc_ncm_init() itself:
	/* devices prior to NCM Errata shall set this field to zero */
	ctx->tx_max_datagrams = le16_to_cpu(ctx->ncm_parm.wNtbOutMaxDatagrams);
	[ ... ]
	if ((ctx->tx_max_datagrams == 0) ||
			(ctx->tx_max_datagrams > CDC_NCM_DPT_DATAGRAMS_MAX))
		ctx->tx_max_datagrams = CDC_NCM_DPT_DATAGRAMS_MAX;

  If bmNtbFormatsSupported is 0, the driver simply keeps the mandatory
  NTB16 format.

With this change, any reply of 0 to 27 bytes makes cdc_ncm_init() return
-EIO, and cdc_ncm_bind_common() then takes the error path:

	if (cdc_ncm_init(dev))
		goto error2;

cdc_ncm_bind(), cdc_mbim_bind() and huawei_cdc_ncm_bind() all call
cdc_ncm_bind_common(). Would any NCM, MBIM or Huawei NCM device whose
firmware sends a short reply now lose its network interface?

For example, a pre-errata device that leaves out only the trailing
wNtbOutMaxDatagrams field would have worked before this patch. Would it
work to require only the bytes up to and including dwNtbOutMaxSize (or
wNdpOutAlignment)? Another option is to log a warning and continue.

The commit message says:

  "A short response therefore leaves the missing bytes zero-filled, and
   initialization continues with parameters that were not supplied by
   the device."

It does not say that those zero values are already replaced with
defaults, or that a tolerated firmware quirk now becomes a probe failure.
Could the commit message describe this trade-off?

About the tag:

  "Fixes: 36c35416a94f ("cdc_ncm: fix endianness problem.")"

Before 36c35416a94f, this code went through cdc_ncm_do_request() with
actlen == NULL. That returned 0 for any non-negative usb_control_msg()
result, so the reply length was not checked there either.

Is 36c35416a94f the right commit for the Fixes tag? Because the tag points
at a 2011 commit, this behaviour change is likely to be backported to
stable kernels.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011035150.53315-1-xinsheng.zhu.ny%40gmail.com
