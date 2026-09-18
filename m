Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1214BFE77;
	Fri, 18 Sep 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726417; cv=none; b=qnp9utbVdpYoOqrkzEjka9HSaUTERxcER2mrDo379bPY4qF0jLHeaoZBdF3tqhzVREObzR2FhUu+IJZqKfXVTm/hVwJy4cj5MxQZZdRy9S4a/ERX9Bo9gl9qPlhISqy32dImoPCfAR3lkqC06AxJTjLIOlMBSHSIkIbkqf+J04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726417; c=relaxed/simple;
	bh=fRrqI5J+OlElTMaF/UNHADJVENN3ol8ONwJxSkxWZZw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lE5xcnOlcVti4JeiA9vfXVntkXSvMh9OXs2VsziGZGKXeLN1jIGg3+LY0LFKQJrAweQXLUtG9P0daa+8+qdObSSOq16rw99xTGFppt+DVW28HaAHRw/PsSE+j3VLzJD+uc/kGT4ZxD6j1B+ozkGQyhit0h18pa3QopmShRfoEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pymUGmbV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pymUGmbV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 153ADA50C5;
	Fri, 18 Sep 2026 12:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789726407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3CYQS4HO8f0XF+m33dmFezZdv8NcnvT2y/K10fo+O68=;
	b=pymUGmbV5foIdqUNdFn0C6JsuZpw1yrH8JlG6lFLhVGgFUNkZmOBm8jewZpdC8BDzLFXCL
	BIf0xaFaa6BnEbR+fLjol4nhU8b3dH7su/ICjyC28XAl7xEaleSsLuoM2oDAhPknXiPjQ/
	QwAIYS6YA4fD7seVIFm3jJVQy2LTsilZgcpuStyo/+ouwpCFHYJQwoqvoUiGmeIGuHmQ5l
	tSiX2CgjkXTY+XDR5aAyhv9mcQ2ENHzyfHo/QzIYd4NPet5gmcrjkg30ezoHwGKEdq49kh
	7wBp9mUeiZ+t4+r2nD2y+DyDszdEy2psxP7NASHXspzbo35KM6ea5E731Hjc1A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:13:24 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/8] net: bcmgenet: fix 64-bit RTNL stats reading in
 ethtool on 32-bit systems
In-Reply-To: <20260918000732.276506-2-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-2-florian.fainelli@broadcom.com>
Message-ID: <3e7e04d782c22ab609ebb1e5297a4f47@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 02:07, Florian Fainelli wrote:
> When bcmgenet was converted to 64-bit statistics, STAT_RTNL members 
> were
> switched to point into struct rtnl_link_stats64, whose fields are 
> 64-bit
> (__u64) regardless of architecture.
> 
> However, bcmgenet_get_ethtool_stats() retained a legacy check:
>   if (sizeof(unsigned long) != sizeof(u32) &&
>       s->stat_sizeof == sizeof(unsigned long))
> 
> On 32-bit systems, sizeof(unsigned long) == sizeof(u32), causing this
> condition to evaluate to false. As a result, 64-bit RTNL stats fields 
> were
> read via *(u32 *)p. On 32-bit Big-Endian systems (such as MIPS BE), 
> this
> reads the high 32 bits and returns 0 until the counter exceeds 4GB; on
> 32-bit Little-Endian systems (such as 32-bit ARM), the value is 
> truncated
> to 32 bits.
> 
> Fix this by checking if s->stat_sizeof == sizeof(u64) so 64-bit fields 
> are
> always read as 64-bit values.
> 
> Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I3e9f2f8d4fd136392148d6c0cd4eb40f7ccbe4ef
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index b916080f4ff1..7b089de9484e 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1346,9 +1346,8 @@ static void bcmgenet_get_ethtool_stats(struct 
> net_device *dev,
>  				p = (char *)&stats64;
> 
>  			p += s->stat_offset;
> -			if (sizeof(unsigned long) != sizeof(u32) &&
> -				s->stat_sizeof == sizeof(unsigned long))
> -				data[i] = *(unsigned long *)p;
> +			if (s->stat_sizeof == sizeof(u64))
> +				data[i] = *(u64 *)p;
>  			else
>  				data[i] = *(u32 *)p;
>  		}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
