Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAD4266A0
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518417; cv=none; b=tLoxgN6imnsEk8rSOMPDGNWILfrS17YHxsikX5tNcRULFpomxEXfqC65J/YsGr/usPNS/jjWvoBxWge+u3Ds3SAp6LvEbhQba3CbtPa5+rguzv2qu+QvCNeuGPSfVH/tEqSL4GFDuv2Gub9gktoJTEIANFYcNq5By662gC9jgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518417; c=relaxed/simple;
	bh=ieprNEftwYIz0PEqwv+lZWIWv+anmUqRT4shxU8WfRo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KFy3BFaomTDqshAcmpWi31aobka/JQv3cxmMhLeoolN+ACYsyOcUi6XYRqADbyhxittXgyLEIiNHEf3zQQKCDTVigxM9SeMOE3o33RjL28uMPEjJyp1MJbSEOozqzMDakwhLdWtDCL1NUgFdQrCmUUDYyDrE7FeGJqSoeEXbQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXxt+CQE; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXxt+CQE"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c21049dafso4125259d50.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518416; x=1779123216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNCfA4B6oVFfF4KvBVDRI03KRMfSBcZ5kzx5bM73bqs=;
        b=QXxt+CQEjLku2UKObxsPapcNlZziNxFFWeNSfm3/Z9M0Jao8RIA16xFHRMbt/zGCYM
         SDGGjIqI3BjRTf24Oo7PIM30H7NMfxnkbpZasXgR385xFSt7zIB+a1+VHEQivIi+T5fq
         VEc8EIYSLhjZjqKmYoEOEmuHRffvPI+8YUObqArghi9HdZ8ORSedFcpmOjOF2qRJfWe8
         czNXay0mZZsSaiPHyYmcX4ZA9xT6gNy72Yzexk1aQH4Gb8uDCIauWJQUT14xlXFhRH1h
         GQJIEwjXaoOw3unV98ztiQwOx3y6iS5l8k9iCfP3Q6RSAAFAjfqACEL2O9RBpakEivch
         HtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518416; x=1779123216;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNCfA4B6oVFfF4KvBVDRI03KRMfSBcZ5kzx5bM73bqs=;
        b=WrPG+MydxLrnxckOb0Siqa69Qr+kKmQ95KuWnQlsVGrTMpbdyGIYDDEe0G6dKQdE5q
         w3fXpQjRboBHTAPytbkUie0WN70SWbji7yt7knMHK+oyPRIHmitNKF/Xo9CKzWtSTqx0
         OHyqOW3PVMvLgWH/5YurKN9BueZArumsD+VFArV+kR0Oz+BDNwKZtmi0SGBysZuEwLBL
         rKSSDnlnvUygbnYRqMqtfmTxLzq3/5TLgvhLMFmsDAtjVEf9bt8yN41iAHcOkIi4DEIz
         u9dlMqkNanAjMXX2+1RVceHpUijGzquvRlIzJtAfnA0anWZz0dM0T9ZHlblyucjAr3Or
         Jygg==
X-Gm-Message-State: AOJu0YwNitFh/fDtlQRbGn/RdBwqGPdAbU4xQKxsRi4/hsUgKbkvC5nT
	ekTkGuMUbUGxHmJXfQ++TW23Eh9M+1LiD4qcjObrFQLRcVk7emlKsF+3
X-Gm-Gg: Acq92OHNS4NzGJ5BO3hSRBItP5mpXN+xqj5CO9CDHHZQ9M/scCwalKQCeBJdeNi0wuC
	ZeIN6H54DRQpzdm2HLSC1nz5BUdAn/eViMQbpjyYeOTkual5+VtZVpNPIkoweZIvGgyVYPDuOh4
	Ef4XonWiSIZsu6hPphhNOSB4CNkifnA8BPkZP78Ru+SEwov/YQm9X+hAIlXYFZrCp+Rbf/zWhVP
	fZAqSub8v3Fy1VMLxp3kBb/eTl1hG2S4XG3tgSztzq3nCjMGWtmAlcQd9eRrvfBGrdT9Tgo6Z5S
	Bm3+Edhn8Em38Ho3slyC5Ia55uPU1Qd9vv9ukVHHuWDpmXYiUTq8rtDBZI7WanlPg3fdZoXyIGO
	K/QGQid9Tu4/IImgnC4x8yNbISlBgFomlpVc5OqIi/K8dS9gUIAH7Kbinw9zHUBCt/5HWj/fwFt
	7clhmJovBXmPStbzXi20RSxVcuCkz9NGNlEAduPughfVH6CwzmtkzxXMmfRpar3Ulkn4/7kpLnJ
	ASh
X-Received: by 2002:a05:690e:12c8:b0:64a:ef61:188c with SMTP id 956f58d0204a3-65d94c95f02mr14194008d50.47.1778518415568;
        Mon, 11 May 2026 09:53:35 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c0e243sm5516726d50.19.2026.05.11.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:53:34 -0700 (PDT)
Date: Mon, 11 May 2026 12:53:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.22d046e36117d@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-1-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-1-4b50ed09b794@gmail.com>
Subject: Re: [PATCH net-next 1/6] netdevsim: psp: reset spi on key rotation
 and check for exhaustion on alloc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> The PSP spec states that the lower 31b of the SPI need to be
> non-zero. Though not in the spec, I think it is reasonable to reset
> the lower 31b of the spi space after a key rotation, and to also
> decline to generate session keys when the lower 31b saturate.

Since this is already a 6 patch series, these two independent changes
could be separate patches.

Agreed on both points btw.
 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  drivers/net/netdevsim/psp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> index 6936ecb8173e..5073bda60883 100644
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -132,14 +132,14 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
>  		  struct netlink_ext_ack *extack)
>  {
>  	struct netdevsim *ns = psd->drv_priv;
> -	unsigned int new;
>  	int i;
>  
> -	new = ++ns->psp.spi & PSP_SPI_KEY_ID;
> -	if (psd->generation & 1)
> -		new |= PSP_SPI_KEY_PHASE;
> +	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
> +		NL_SET_ERR_MSG(extack, "SPI space exhausted");
> +		return -ENOSPC;
> +	}

Can this all be more readable without the use of XORs? This is not hot
path code that needs to be optimized.

        if (ns->psp.spi & PSP_SPI_KEY_ID == INT32_MAX) {
                NL_SET_ERR_MSG(extack, "SPI space exhausted");
                return -ENOSPC;
        }
  
> -	assoc->spi = cpu_to_be32(new);
> +	assoc->spi = cpu_to_be32(++ns->psp.spi);
>  	assoc->key[0] = psd->generation;
>  	for (i = 1; i < PSP_MAX_KEY; i++)
>  		assoc->key[i] = ns->psp.spi + i;
> @@ -162,6 +162,10 @@ static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
>  
>  static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
>  {
> +	struct netdevsim *ns = psd->drv_priv;
> +
> +	ns->psp.spi = (ns->psp.spi & PSP_SPI_KEY_PHASE) ^ PSP_SPI_KEY_PHASE;
> +

        /* Flip key phase and reset SPI to 0 within that space
         * (will be pre-incremented, as 0 is an invalid SPI)
         */
        if (ns->psp.spi & PSP_SPI_KEY_PHASE)
                ns->psp.spi = 0;
        else
                ns->psp.spi = PSP_SPI_KEY_PHASE;

Even while making the code more self evident I still feel it needs a
comment to explain all that is going on.

Maybe it can be more self-evident.

Or maybe you find the XOR just as readable already.

Your call. A comment might be helpful either way.


>  	return 0;
>  }
>  
> 
> -- 
> 2.52.0
> 


