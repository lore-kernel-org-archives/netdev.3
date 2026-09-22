Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D763769F0;
	Tue, 22 Sep 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074054; cv=none; b=VYD4mhYrzGIVhccnnwcvT9+3cYI0UzjbipBPFhxdIYgy5hCmtN9uQcF0v8amuxOgTVUEoUsW1QfzHnexMCswM6LPwgYyOxp1uPJHMuh/DRYCR8gcJ/cUO77qGPgc5UTEaB6Qkii/daskNaForebbZ6+rUmOb0RZYdv3e9waPtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074054; c=relaxed/simple;
	bh=K/EZD4N5uAypOMeeivMXp69VKxNLben19XbhGFj91R4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mEqleXpaGlg+TX411MszxNYyn7LXea9E2dC6GJDOjJ0bK1puYugl9pkHfMv9qCEflYjB+W/6KjmPzE+bvzAnzDVFO2TlCah45cUJmdeH/v3ACvcnYimNtJ+M18eUxp44BBecNI3BjEBnixkl2MvG1Kqh8CiE3fCMsMAyYz03FTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=J2H8v7R/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="J2H8v7R/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A4C7A4A18;
	Tue, 22 Sep 2026 12:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790074049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2WmHXEkqtynLjuFW5yperYBEsi90cIv86wVIU8h2gng=;
	b=J2H8v7R/m5y5T926bsdZ5cfZgjpHUdE4XVl3rC7/47JEWFGL2D5HITrTxvol70eFmqzHTP
	4sRlr8sQl8SJ/Z6f8SWLLd3aUf/rNppkXmqpe9DjmNHoUXBxQ4FHAIbUhA5Y/2DLKZb7ay
	7HeJ6AK+AbQT4bC+KlP3KOukSOS43YwoTBtUBh9FapaRHLjuCGQJZvfxZ69TK1746Ap37T
	Zh3xE/o0h2iWjsoH1UhKFn5Z7GI/cohS4arJRZ3qoEFzaPhyCPU589Xirz1rckpPFDKqeO
	aUIlpEEZ+sEix+N6DNRohqd/S8YNja4vvbBZK1L+yWxAEynDpKmrDapocDBOFw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 12:47:29 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Rafal Ozieblo <rafalo@cadence.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: Enable RX timestamping for
 specific PTPv1 filters
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-2-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
 <20260922-codex-macb-hwtstamp-submit-v1-2-9d1abaa53296@khu.ac.kr>
Message-ID: <3510714425aca52a9c6a8b716f8efbd7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 11:10, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
> 
> Selecting a PTPv1 Sync or Delay_Req filter in gem_set_hwtst() returns
> success, but leaves rx_bd_control at its initial value of
> TSTAMP_DISABLED. The requested filter therefore appears to have been
> applied, even though received packets have no hardware timestamps.
> 
> The PTPv1 event case already enables timestamping for all frames, so
> use that path for Sync and Delay_Req as well. This enables timestamping
> for both requests and returns HWTSTAMP_FILTER_ALL to tell the caller
> which filter was actually applied.
> 
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
>  drivers/net/ethernet/cadence/macb_ptp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index 4dbb6daa6..b6d17fef4 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -419,10 +419,6 @@ int gem_set_hwtst(struct net_device *netdev,
>  	switch (rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		break;
> -	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> -		break;
>  	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> @@ -437,6 +433,8 @@ int gem_set_hwtst(struct net_device *netdev,
>  		ncr_mask |= MACB_BIT(SRTSM);
>  		ncr_bits |= MACB_BIT(SRTSM);
>  		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>  	case HWTSTAMP_FILTER_ALL:
>  		rx_bd_control = TSTAMP_ALL_FRAMES;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
