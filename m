Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7D3AEF51;
	Fri, 11 Sep 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120286; cv=none; b=Ja8U//zMjFp5p87lXHgXj0mZJ2cbXYymmDsQlPe7bEzTb5lPTjtW8rkXDlaWnfGk8DLSidLyHikXnS4Srd+jkuXLH4uso/7adwt+LwSEFxYnAUfWvnVlWBQxxuFOAHdg5SyXpTU43JK+dTuaiQsHUi+CxS6L9YF04PXykMEJwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120286; c=relaxed/simple;
	bh=AB4HvI5yH8f134zmYFHs6P/e97IQEZB73uyMnHjSy84=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oV64DVG7qF1AqU24EYGUiBdwX3srtD8NxxoQTB2O10ay+jVd+wurYBh2LFsIGwhlxuHGC2iLnnMYZHilw3fsc1CxuFLUYfMWiaDwSj05/O+vIgsB93usVvc5oWRhFFCPOOLZro3fnNOFSS1/3HxMLSXmbXGAiB/2Lju3YFKhRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=a4AKDLgx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="a4AKDLgx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13D7CA91E5;
	Fri, 11 Sep 2026 11:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789120274; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WxltCiMmZCVVD/wZemNpAc0sPf2VHFiHQIPln3Gt0OI=;
	b=a4AKDLgxsreyUu28KpBr9dW7kD7JMIMgACDD9QZheDQES1rRbPa2EE1gTsTmdMSAttxFP/
	zEhGG9autKMP+UG3XXjoWdbsr4SNDNYjxpATCr8atWxzW4y3pnFQxXIKpOqhYdvCPn+Krn
	+/qBmUBx0X1Lt+X7qOFU616D5Q+HhM8thMv0r9vFpvc3yd5e4BxENusBhVxjoUxndAsWZ6
	C/DxT2sCU3seS1V7d/nxn2S6NrhM+IayWWHgrtUUbZAGQHvPdwnDPEMqPRYeZhw/EKMQ5i
	N2c7w1txfJD6m98Htutw38r8qtC3Lr+Z13Eh7FjqOMTWB+e2E48eLEPibSVtGA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 11:51:07 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: kimwooseok <5mghybrid@khu.ac.kr>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
In-Reply-To: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
References: <178911388592.25348.177462085059763031.macb-plaintext-resend-cover@khu.ac.kr>
 <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
Message-ID: <6928c282c12e03e4487f75afef4f0080@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kimwoo

On 11.9.2026 10:04, kimwooseok wrote:
> gem_set_hwtst() programs NCR.OSSMODE while processing tx_type, before
> validating rx_filter. An unsupported receive filter can therefore cause
> the operation to return -ERANGE after changing the active transmit 
> mode.
> The cached configuration is not updated, so a subsequent SIOCGHWTSTAMP
> reports the previous transmit mode even though the hardware has 
> changed.
> 
> For example, configure HWTSTAMP_TX_ON with HWTSTAMP_FILTER_ALL, then
> request HWTSTAMP_TX_ONESTEP_SYNC with HWTSTAMP_FILTER_NTP_ALL. The 
> latter
> request fails but enables one-step synchronization. The reverse
> transition can clear one-step mode despite returning the same error.
> 
> Defer programming the one-step mode until both the transmit type and
> receive filter have been validated. Rejected receive filters then leave
> the active transmit mode unchanged.
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
>  drivers/net/ethernet/cadence/macb_ptp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index e5195d7..51659bb 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -418,11 +418,9 @@ int gem_set_hwtst(struct net_device *netdev,
>  	case HWTSTAMP_TX_OFF:
>  		break;
>  	case HWTSTAMP_TX_ONESTEP_SYNC:
> -		gem_ptp_set_one_step_sync(bp, 1);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	case HWTSTAMP_TX_ON:
> -		gem_ptp_set_one_step_sync(bp, 0);
>  		tx_bd_control = TSTAMP_ALL_FRAMES;
>  		break;
>  	default:
> @@ -460,6 +458,11 @@ int gem_set_hwtst(struct net_device *netdev,
>  		return -ERANGE;
>  	}
> 
> +	if (tstamp_config->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
> +		gem_ptp_set_one_step_sync(bp, 1);
> +	else if (tstamp_config->tx_type == HWTSTAMP_TX_ON)
> +		gem_ptp_set_one_step_sync(bp, 0);
> +
>  	bp->tstamp_config = *tstamp_config;
> 
>  	if (gem_ptp_set_ts_mode(bp, tx_bd_control, rx_bd_control) != 0)

Reviewed-by: Nicolai Buchwitz <nb@tip-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5

Thanks,
Nicolai
