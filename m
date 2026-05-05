Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812E3B0AD3
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958974; cv=none; b=vBk5yzouYVCBQe8l2/U7GAnDNC/zjl+IUSrIekqKyj8mkGg0duzHrRTR4D6tWEikbb+lzSW79WGxuYeBJXhaJ/7xvLsiKsGMwrVOuVv04/GX3Bbh18AgHPcA1KHB7xYHvPWrCH/LNpg7cOvVUEHBlNbGK1u7k10JTatWM77EicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958974; c=relaxed/simple;
	bh=4fHxp8Q3woesOCXXrtJkOcW34n60i9kmwv85rTk8Mm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnLPt8ZD/0jTdaZbA5DByaCN+0scgXp9XCTKIvd4tvDPsIM6i9I823XhC6ddLz88K3JnEpdBb2dqxCrDz88APJnsJLU79kOvHHEvUH8pVUeMR4vS4AjqbHMpb3JWTeilvvCmFouYUbM2OYgPn/0yckIHpSBJnotb5QQXhqOIaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpzC+qsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpzC+qsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F720C2BCB4;
	Tue,  5 May 2026 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958974;
	bh=4fHxp8Q3woesOCXXrtJkOcW34n60i9kmwv85rTk8Mm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hpzC+qsQ/qpsgVzgGx6hDiGsj/wjF5kCtTo22kPAr8nH+vEXKi7AX4ScKH6rB5/sV
	 wzsqtRrtaJKC7cEmm7dOajyTY0kRcixWmUI9s/UWADXdG3IZVjZQI43rwUPU45Q9Ns
	 uv/bA7I3mj1wIT5drWOmqU+9RSJRa1fuaSHCENdOgfq6qp5eILS5HX40n+LacV1B57
	 DQcd/GMjr9IMk5dnmHSwW5753uXFsu2jdPOCSuhDf/sPdn/NmLkXpgxPP/Z12u7Zt2
	 ypNvbNtleQxHs/d0gMPI4ky3YEKKPmKD5SnxjQ2/bmCIQ9CX6oZ393QuySthSJGG2W
	 ucPMbBe7heS2g==
Message-ID: <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
Date: Tue, 5 May 2026 07:29:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 04/05/2026 à 17:56, Holger Brunck a écrit :
> If dma_rmb is used it has to be done after reading bd_status and checking
> if R_E_S is zero. Therefore we need to move it into the while loop.

Can you give more details ? Why does dma_rmb() has to be done after 
reading bd_status and checking if R_E_S is zero ?

> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 15bfb78381d4..09081f128a98 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -523,12 +523,12 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   	u16 length, howmany = 0;
>   	u8 *bdbuffer;
>   
> -	dma_rmb();
>   	bd = priv->currx_bd;
>   	bd_status = be16_to_cpu(bd->status);
>   
>   	/* while there are received buffers and BD is full (~R_E) */
>   	while (!((bd_status & (R_E_S)) || (--rx_work_limit < 0))) {
> +		dma_rmb();
>   		if (bd_status & (RX_BD_ERRORS)) {
>   			dev->stats.rx_errors++;
>   
> @@ -610,7 +610,6 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
>   
>   		bd_status = be16_to_cpu(bd->status);
>   	}
> -	dma_rmb();
>   
>   	priv->currx_bd = bd;
>   	return howmany;

