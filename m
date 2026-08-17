Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8D23741;
	Mon, 17 Aug 2026 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948157; cv=none; b=XCe4xQQyjhEmI5e9l7e6mW2QIWEYdgmoNVE/GJFs1Ke6qjYhEAm0zvKTc1PsaLgsQaNVytMizbaz6TLLUQ0AxqJCespnmpJlQS0J7A8EtKjmE5nQP2ZaimjzH8FicMvntjmyKcOTjH0rBME/u11ll1n19k2lf+SdQCHbOpHCkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948157; c=relaxed/simple;
	bh=clA6b7CxVK7l7rzUdRiE/LMIJ5I5D3XfzVfbVR0kge8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbBjeuGEDaew4mrV+tvfuLUwIGmcpsfsUb/Stwu4Z9rrh8P0QT+Srbbv8pWtUE+hwxsWuWwz4yU3ILMhRc2gb9AUz+65b2Jet3bnirEoyVfJnvMdAz8MX/ARqFzqWG1fa0F5I2d0BojJoAtbVWtjNdvstg8DdgQ1lrzn+invrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBaxSAM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBaxSAM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08B21F000E9;
	Mon, 17 Aug 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786948155;
	bh=rGuj0TXK9Gf4jbd/TaHIlwxx+1Y0rd7UNGo7CFHlOds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NBaxSAM6+kK0DZi4AgsTCW4O+0vUgMKJLfr82V1GQevh/KKAQ3oNzLc4d0DXIDbga
	 tkB+OhMMbdhVT0j/eB34tNPgkhIol+kppyLyW+drC/7n4tp3HO3lKk/yOD9bTelq22
	 3jXsQP1lKfOVpVFJnqLgf7oBHt0FOctRPeNzplWCVYamcuBVjB8Mep70zAURHOmd/x
	 xhJnU57pPsonxSYrMMI7P5790/8SxNfTrW9/AV0SCh6aPpxQ1Qa9+aEg1sNROgI0eg
	 MZj3KXqPGHW48iWEE6BAkpP1sOcc9D9rMlFNrAMXMddVsrlpCAjvHGmEukd39j76Dm
	 iuPVpOYhE0CMA==
Message-ID: <c4d970dd-cb54-4530-9491-01b6d90e4a2b@kernel.org>
Date: Mon, 17 Aug 2026 08:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: remove dead 440SP code
To: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, Frank.Li@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linusw@kernel.org, kees@kernel.org, colin.i.king@gmail.com,
 rosenp@gmail.com, joao@joaoff.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260816125615.985387-1-julianbraha@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260816125615.985387-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/08/2026 à 14:56, Julian Braha a écrit :
> The 440SP config option can never be enabled, making all references to it
> dead code.
> 
> Let's remove support for 440SP, since nobody can be using it anyway.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.

It would be good to include history in the commit description:

As far as I can see, users of CONFIG_440SP were commented out by commit 
f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in 
arch/powerpc") and removed by commit ff5f483f3091 ("powerpc: 4xx: remove 
commented out Kconfig entries")


> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   arch/powerpc/boot/cuboot-katmai.c   |  2 +-
>   arch/powerpc/include/asm/async_tx.h |  2 +-
>   arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
>   arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
>   arch/powerpc/platforms/44x/Kconfig  |  3 ---
>   drivers/dma/Kconfig                 |  2 +-
>   drivers/dma/ppc4xx/adma.c           |  9 ---------
>   drivers/dma/ppc4xx/adma.h           |  2 +-
>   drivers/dma/ppc4xx/dma.h            |  9 ---------
>   drivers/net/ethernet/ibm/emac/mal.h |  2 +-
>   10 files changed, 10 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/boot/cuboot-katmai.c b/arch/powerpc/boot/cuboot-katmai.c
> index 034a748fde24..fcd71e76309f 100644
> --- a/arch/powerpc/boot/cuboot-katmai.c
> +++ b/arch/powerpc/boot/cuboot-katmai.c
> @@ -31,7 +31,7 @@ static void katmai_fixups(void)
>   {
>   	unsigned long sysclk = 33333000;
>   
> -	/* 440SP Clock logic is all but identical to 440GX
> +	/* 440SPe Clock logic is all but identical to 440GX
>   	 * so we just use that code for now at least
>   	 */
>   	ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
> diff --git a/arch/powerpc/include/asm/async_tx.h b/arch/powerpc/include/asm/async_tx.h
> index a14758426dd5..1ff5b2ca3ed1 100644
> --- a/arch/powerpc/include/asm/async_tx.h
> +++ b/arch/powerpc/include/asm/async_tx.h
> @@ -7,7 +7,7 @@
>   #ifndef _ASM_POWERPC_ASYNC_TX_H_
>   #define _ASM_POWERPC_ASYNC_TX_H_
>   
> -#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
> +#if defined(CONFIG_440SPe)

Replace by #ifdef CONFIG_440SPe

>   extern struct dma_chan *
>   ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
>   	struct page **dst_lst, int dst_cnt, struct page **src_lst,
