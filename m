Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698713AB29D;
	Fri, 11 Sep 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120524; cv=none; b=Uo9zByNUkre0v6WGAisafmZQAME/ClLCemCdDLpxBAe5Wt6c1vOjtGce+n/X5e3GNyGl+17Lh9ebxJ4lZg6dn9cONgtdB9FOhwG/5GEca93jWYxtg/FJKtaF+qqT21yFh5/waYoQV2WkK9pcnK/A0uBscXffBqg4YG2iqw5MZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120524; c=relaxed/simple;
	bh=0tQ5UOcfmXeoMU2bbIGxdIrQatK2ev1arDHG7vwy7T8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tlPSVep7WrtMKZKsdNiPcPJUidWD/GOVn7+I/E4Q7O7O3VCFnj12mHuqkaZzHkJFVfLAGwyzq16q10CpvcxVLUer4pRc2Td+hiKS5f9L0K7RGOtj+3gpalIKxGzL6kL/F/C5OdceqZVtsMUSk+DwUh9rM8jj318nmo9KmmfPa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5SglTdFH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5SglTdFH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB6E6A4C11;
	Fri, 11 Sep 2026 11:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789120515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U+rkct1N0ewPgHDfDC9pZh5mG5IDXEtz1Rz15dwMtTM=;
	b=5SglTdFHwNSNPAs7eSjcxRbhk8Z7Is044GE5xQP8mc2+bVSShmluT3VQE2eL9cgv381Yom
	6kBBW1Fykq7wBLy7/F8KigE1U1f35N7qD42HyyGLDN9D7wcUzW1Vhagrg7l1HYqvSLTbha
	P+nZj9K+GQRGmMNERS4DG7o5wAnnn+WuIxACZ3buGtgtnx+VL9/O1jvlNwMMJ59CDqvfPT
	nrNkL3hBgwSRinec+tXnlf5T6QMFYirjAWT0vn6/NCedkezJmwOJCSd2ToDCRtgpnDbSr0
	XPqzhHS8CsDAg5/eeLQ3oone7n0SXNfS3Wqumt+vhONUbHJPHoQ3GTYg+T5PrA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 11:55:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: kimwooseok <5mghybrid@khu.ac.kr>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net RESEND 2/2] net: macb: Use all-frame timestamping for
 PTPv1 RX filters
In-Reply-To: <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr>
References: <178911388592.25348.177462085059763031.macb-plaintext-resend-cover@khu.ac.kr>
 <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr>
Message-ID: <185fa72f08b8d7882a48c3ba922c10b8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kimwoo

On 11.9.2026 10:04, kimwooseok wrote:
> gem_set_hwtst() accepts HWTSTAMP_FILTER_PTP_V1_L4_SYNC and
> HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ without changing rx_bd_control from
> TSTAMP_DISABLED. A successful request thus disables receive 
> timestamping
> while reporting the requested nonempty filter to userspace.
> 
> Handle these two filters through the existing all-frame fallback used
> for HWTSTAMP_FILTER_PTP_V1_L4_EVENT. This enables receive timestamping
> for a superset of the requested packets and returns HWTSTAMP_FILTER_ALL
> to describe the configuration actually selected.
> 
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: kimwooseok <5mghybrid@khu.ac.kr>
> ---
> Resending as plain text because the previous webmail submission 
> included
> HTML and quoted and rewrapped the patch. No code changes; the 
> Assisted-by
> trailer now names the tool.
> 
>  drivers/net/ethernet/cadence/macb_ptp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index 51659bb..2ffc46b 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -430,10 +430,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  	switch (tstamp_config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> -		break;
>  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> @@ -448,6 +444,8 @@ int gem_set_hwtst(struct net_device *netdev,
>  		regval = macb_readl(bp, NCR);
>  		macb_writel(bp, NCR, (regval | MACB_BIT(SRTSM)));
>  		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>  	case HWTSTAMP_FILTER_ALL:
>  		rx_bd_control = TSTAMP_ALL_FRAMES;


Reviewed-by: Nicolai Buchwitz <nb@tip-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5

Thanks,
Nicolai
