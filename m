Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5B4825DC;
	Tue, 22 Sep 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066196; cv=none; b=oP/8laET/rQ8kgsGilbXSNNgZaOD1V+BZTU9MoKiTCr95MALx2OiYoIb7BCE4XYuO+F0HTxYqan8/WsWqgCgtdV+XyenFrvNcKWOcRugqUF6D7boBTQlSuQx45xCcPTa3ilo0Qaxjz71X5yiGcpMAcXkTDBHeRmjcX9G/MUL7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066196; c=relaxed/simple;
	bh=OdXW4d0OBvTdeAS4NS/4eGfV1LapWifczJxRiY77+Eg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c5KCPb6aEbar1v6w5P+Jr150/uuoS58GNA2IF+8MHz0H/eIHxCrenCGXqVHHCmDXOTtC7z1jsLEtnuVTG4g+dI76y4jgYGvGkWq2nYUEZWAb24JgW5PlbCaSEzqQcZDWdPqAamY9MXV01gKKdtQVVD33u+mbQx2Sji4GGWO9qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lFiKivtV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lFiKivtV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9EAAA4A2E;
	Tue, 22 Sep 2026 10:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xwykvJFdBTPMGF/t3FfOtbQ2mRuqK4UzmM43MIqyX8U=;
	b=lFiKivtVx55l08uMNmCoztgvC74kn4lnHbQf/y7l3v0b1G67mtlMuwwZ1RjuIeF2hJD8Rg
	h4sJ+rUzkhUGMreSmWTThqwy4iwXvirW6DX3LtqI/ebjZQA3MLsZ0bQe0xcRcr39PMtHkm
	q1rYx/c55Ru9KJUW+EFhfFlH4zPNrL/aa6QdF6H6H3a19C9Gqs6hvb4wHNUWA5U6palBzc
	UcGlW7zA1s4xazIk4Bk8D1SbcmhtAcyPQxmVuayN21OqXozwHgdlFe7//wSPIyewWCk0oI
	dx/x5IO9ZmkAfzlhHxbyq5QU5LzNUkF0JSJhIQT05BDcBpnG39x55K1TlN5BhQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:36:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 01/12] net: systemport: Fix buffer overflow in
 bcm_sysport_get_stats()
In-Reply-To: <20260921231305.394773-2-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-2-florian.fainelli@broadcom.com>
Message-ID: <d03b360c6fba3c8f67a9233e46d25cc9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:12, Florian Fainelli wrote:
> When running on SYSTEMPORT Lite, certain statistics are unsupported and
> skipped during bcm_sysport_get_stats(). The variable 'j' tracks the
> compacted index into the destination data buffer, whereas 'i' iterates
> over all elements in bcm_sysport_gstrings_stats.
> 
> Because the buffer allocated by ethtool is sized only according to
> bcm_sysport_get_sset_count(), storing values at data[i] instead of
> data[j] writes past the allocated array bounds, leading to memory
> corruption.
> 
> Fix this by writing to data[j] instead of data[i].
> 
> Fixes: 10377ba7673d ("net: systemport: Support 64bit statistics")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 4d06c6ba6641..db627cd15fb7 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -482,10 +482,10 @@ static void bcm_sysport_get_stats(struct 
> net_device *dev,
>  		    s->type == BCM_SYSPORT_STAT_NETDEV64) {
>  			do {
>  				start = u64_stats_fetch_begin(syncp);
> -				data[i] = *(u64 *)p;
> +				data[j] = *(u64 *)p;
>  			} while (u64_stats_fetch_retry(syncp, start));
>  		} else
> -			data[i] = *(u32 *)p;
> +			data[j] = *(u32 *)p;
>  		j++;
>  	}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
