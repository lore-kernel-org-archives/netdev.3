Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D2421F04;
	Mon, 13 Jul 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948791; cv=none; b=jMw05hJ5tfaIdwTNHi2PY/2E7x3HW22rHaoYY2q4sdfuizGAbIaqVe7fFYsE82CfqAsaOZKC7RuLYdSZPj7YeKBVJs5MWQbkkJ3iFlHxIYISYysKyQHdt8lbwh/3IbPU8NXMIw+9LPDeJ81MUxVNA5Clz45tINOcZNSx3g04k94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948791; c=relaxed/simple;
	bh=t3Q5iagn3wfHS94LeoKVnztC3ceDoZccEptt/4oBNmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JungxZDkYocHyWHP3+AV7YZqtM1q0TudZbtREgRjrkGD8qt/PKfAsRdU971c0KakT1qYziPubEgk7XLVlJd04x0bUKMMVlnXg9uU2waOI7tRdu494yGOWnKUUIlKj5c4iZPkpcOzA0eYl3FAUtznu6FhVb0VlzM02HDuI69RNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5725C1F00A3A;
	Mon, 13 Jul 2026 13:19:49 +0000 (UTC)
Message-ID: <5da2b557-6942-496a-b47d-fba9553c54e7@linux-m68k.org>
Date: Mon, 13 Jul 2026 23:19:46 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] net: smc91x: do not use readw()/writew() on
 ColdFire platforms
To: nico@fluxnic.net
Cc: linux-kernel@vger.kernel.org, arnd@kernel.org, netdev@vger.kernel.org
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
 <20260609142139.1563360-4-gerg@linux-m68k.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260609142139.1563360-4-gerg@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping.

This patch is independent and can be applied as-is.


On 10/6/26 00:12, Greg Ungerer wrote:
> Modify the access macros and functions used to access the smsc hardware
> registers when used on ColdFire SoC platforms so they do not use readw()
> or writew(), or derived functions like ioread16be() and iowrite16be().
> 
> The current set of readX()/writeX() access methods for ColdFire have
> historically been non-standard, in that they mostly access memory
> big-endian instead of the expected little-endian. Before fixing the
> ColdFire readX() and writeX() supporting code to properly work with
> little-endian data existing driver uses need to be fixed. Convert the
> smsc driver ColdFire uses of these to use the raw access macros - which
> are well defined to be (native) big-endian on ColdFire. This change
> requires some byte swapping at time of access to retain existing correct
> behavior.
> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
> v2: changed from RFC to PATCH
> 
>   drivers/net/ethernet/smsc/smc91x.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
> index 38aa4374e813..1290335629c1 100644
> --- a/drivers/net/ethernet/smsc/smc91x.h
> +++ b/drivers/net/ethernet/smsc/smc91x.h
> @@ -142,22 +142,26 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
>   #define SMC_CAN_USE_32BIT	0
>   #define SMC_NOWAIT		1
>   
> +/*
> + * Access SMSC device registers using raw IO access primitives. Byte
> + * swap as required for device registers, but not data.
> + */
>   static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
>   {
>   	u16 *wp = (u16 *) p;
>   	while (l-- > 0)
> -		*wp++ = readw(a);
> +		*wp++ = __raw_readw(a);
>   }
>   
>   static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
>   {
>   	u16 *wp = (u16 *) p;
>   	while (l-- > 0)
> -		writew(*wp++, a);
> +		__raw_writew(*wp++, a);
>   }
>   
> -#define SMC_inw(a, r)		ioread16be((a) + (r))
> -#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
> +#define SMC_inw(a, r)		swab16(__raw_readw((a) + (r)))
> +#define SMC_outw(lp, v, a, r)	__raw_writew(swab16(v), (a) + (r))
>   #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
>   #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
>   

