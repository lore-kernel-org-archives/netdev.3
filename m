Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88651C043;
	Tue, 22 Sep 2026 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074093; cv=none; b=LnbhvPNzl+G2OvTQUfv3CU1MNaFUmOUo+IoBR/ej2JS7XNeZwRSllhiTx7srY2rIC31DZ7rIavC7Y05vXAHWX7iQElWU0MJ8i5VVMylSeRc9CFo1LS3k9A7OlK3p89b3tXzPoehiCfzxLZ6BWgzHsp8SFLSFdAIxmCZ4xYR1TLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074093; c=relaxed/simple;
	bh=5XTj1EA863DQasURQDAmZbHghEd6eLn4G22Pvz7bVXs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dHMU6trpjWLnDe1XUvojv0T0D4uT/OEcs/FJwNDUJGIweck2wfaRBCi+WspYBpwBEwghHYKVDULhZXn6VpVsCCh/OJ6ErUDKVu9zc9ay6eOREhArEUggQjS03VAHYZ1BiQMn3+Vd6/Lq6e/qJdBPxmy/k4s/Z5nL2R/gyGHmsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VDKHHDGM; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VDKHHDGM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99DE3A3808;
	Tue, 22 Sep 2026 12:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790074089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+3fixJm91Sq7EWmB5NYvMP8ut3zsm7bduoF8KuWeDtg=;
	b=VDKHHDGMX9AmEG3dZhlBvNiiEZu9ea0/NvWSOvF+jPB3/oqlO26QH1TFnKDl1f+aoXjHk6
	8BVl1t6vAOgoLFQyFsVbCRI8DUKjvkKoCBMm+46q/ksO5Hbp8qPwptgew/pZEnD6q3Oxvt
	9ZSscWKIIPKasB6U0GFcT5KZf1P6t0SuJaYyoC/C/tRSO6LaPA5ECgGh8z/fcCIkfCizCn
	GUJ3LsNcDlKrfUvNLBpeDJnxTIHXXTbYSLPp7nx8CcVdKCTp7//Ubw8uAcPpWk/qQ5JGye
	/+txGXg94qSucEJTG4bGbEGVGXJYOyEfvulp2Cn004qeV6RmY1L5nGHBwwjaFA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 12:48:08 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Rafal Ozieblo <rafalo@cadence.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: macb: Clear SRTSM outside PTPv2 receive
 filters
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
 <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
Message-ID: <37a63a21097938f8057ca336ff3bf40e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 11:10, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
> 
> A PTPv2 receive filter sets NCR.SRTSM, but switching to NONE, ALL or a
> PTPv1 filter leaves it set. As a result, selecting the same filter can
> produce a different register setting depending on whether PTPv2 was
> used before.
> 
> Update SRTSM whenever the RX filter changes, setting it only for PTPv2.
> Switching away from PTPv2 then clears the old setting, so the bit 
> follows
> the currently selected filter.
> 
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
>  drivers/net/ethernet/cadence/macb_ptp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index 6376b6631..637d0da32 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -390,7 +390,7 @@ int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> -	u32 ncr_mask = MACB_BIT(OSSMODE);
> +	u32 ncr_mask = MACB_BIT(OSSMODE) | MACB_BIT(SRTSM);
>  	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
>  	int rx_filter = tstamp_config->rx_filter;
> @@ -429,7 +429,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>  		rx_bd_control = TSTAMP_ALL_PTP_FRAMES;
>  		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		ncr_mask |= MACB_BIT(SRTSM);
>  		ncr_bits |= MACB_BIT(SRTSM);
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
