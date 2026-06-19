Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E5321F5F
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859720; cv=none; b=lmTyX8dXaqto9vEUk9V2i0oZrQq3iPDJk3XlSdAzeSQE02f1WoaZWnJgYkELereYqnefEfj2TS8YEbYV1sx3ysOw6BoJ5nOyM1V07OiHyOn2MgZAou/DxCfhiu8rXfH/GC7Dh2JMlGYFO8oYWTltsgrTwhl/dSZ/ilK17OCfyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859720; c=relaxed/simple;
	bh=qlt3unF5ADdOjMo2KBuKTFXOq9Dx2WnxtfNKVKqeVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZSkeiIppuVHVv0/nd+dS2pXFDd/6V/k7Urpx0CmQrTJ4RrjVpKfOOODh/a2t63A19COVKeQD2VSJBm2fZ6cpf21puVAELPUEpE1wSqeqHKBAsre+L0Go/jui/WTG17Ttb6eZBllurezMBKDP0g82xQHHvSgJiHHo+DXDz8gaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRKdt6bm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRKdt6bm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1417632f8f.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781859717; x=1782464517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZUtLgzlYSejsSflnvq6CI0n7/gXqTfTxCmqp80pW8E=;
        b=VRKdt6bmZITEM9FTXW2U0s2KCcLCfczEQeLVqCsvkBeGa49C5i7bFRty7pn5rjfkQ1
         obIaNoo7L+pz5IJ0Kf8St7ypI+X8e93ySV0ngfc1qGGVMrii3dblR84g1JZulGQ06cAn
         oRRBuVhaB1wXo72+3QpxfDOaDSbJTRSyUSbruE6GA0LO/5ODVCQbeBcWqWM9cj5iCtBB
         lF2v960n/+2vwuYJoIdWrJXVNIlencQq4oEucpKGeNRx20IHxdZ3IYdHTSBZVUQvSCim
         p/tQDA1sku2tTCWWAwo71AlH21LQb6ZD60ZMJyoYbwLK2tQQGibGkOEUv77icjNdvP2u
         0adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781859717; x=1782464517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZUtLgzlYSejsSflnvq6CI0n7/gXqTfTxCmqp80pW8E=;
        b=h9bNnekx2QQXypc5C9wtqr5k9T6CVTQD2D0NfvxUFpG/hkv0qdR/iV58qTpA13Aq5C
         Lr+IWBQxB3JAafh37/OYzgrpEAKcToVAgb+B6NY0FWl+5D6tyzQChIiAbdbY+CeIs8RF
         PdvCZ4BdmlNeB+bFGWJ4QSJ95qqYYfSA6AHZ31XnU7LOfJk+7cdxlPHDJMsjFCor08lc
         vig9XuFR6lmEtjTmEkael55TtJKfTSzb6TsdUVq2FRDqHpAyUt9yNKxMg5xY/shPSJUg
         TFduk+sqkTffnd8TzkQcKw0moXcvBIRogKbzkgZoiiVF7T3FgO3VvCufaWgewo1XSpc8
         awig==
X-Forwarded-Encrypted: i=1; AFNElJ/TJs5MuCtBJsi3G9+UKMCr+VfbZBDCDjMWD43UIyyVVPMGwq/h53IDsszofiaADAaB5FLW5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqq/fMAE+4uGO7ZSLQvonqOQnNV/jKO8gEjMF3G+2uhniIJTI/
	PxFgIPz/9J6xP1U9UYt+g5OUa8Dr7FgSUKerLiVqw1ta09WIev4lYlaY
X-Gm-Gg: AfdE7cm2vgFsZN2FCsmaZJHPMzVx+sk5bg8hfG5Fwdfa00Uvj9hyb2tx0wKFJlUEDbz
	ns+yW9qrqCDIT7PF/621N0JfAUCdzkZWSYY3YSGur0pqt+uhPxdCM/ahuxCue8Vy49CYpI+LyML
	lPRKWSM0aX2MW9egvdeyoALuDOEtgC1UWY7Uce0cb3eePoLIV0oknY2nkoPXn5PESeJsJYp8W5M
	Ork8PQgDI2v5/+MFuCty2Az0gu4icsBWOzrC9XiAd2oR1BlPhyKLmt3BQ6B/nO43ogHW9P62PD4
	A82CULHKrYyxYzC6iMxLKW7yKanDqYViBK0lqiK3k2+adFGAfEuQ23iLylNu6mSqVnmTE9LwwNt
	CbqeRO/0r5Sl6+sTnkdI9rPWcVLCyPGMhQWStgsxtUvvfaS831+3YEXtFW6BWhpDGokxUg1G2On
	TEPWYBKeIzGx0nXkCaYItC8+BqqUHg/6IKRSPydt9DDGMWZT5Igw==
X-Received: by 2002:a05:6000:e43:b0:460:31d1:74de with SMTP id ffacd0b85a97d-465077bfaa4mr4316021f8f.10.1781859716765;
        Fri, 19 Jun 2026 02:01:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04c15sm6388699f8f.3.2026.06.19.02.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:01:56 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:01:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit
 access in api_wrap
Message-ID: <20260619100154.794168e5@pumpkin>
In-Reply-To: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
References: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 04:39:25 +0100
Daniel Golle <daniel@makrotopia.org> wrote:

> The MXL862XX_API_* macros pass the address of a stack-allocated, __packed
> firmware-ABI struct to mxl862xx_api_wrap() as a void *. The struct has an
> alignment of 1, so the compiler is free to place it at an odd address.
> 
> mxl862xx_api_wrap() reinterprets that buffer as a __le16 * and accesses it
> with data[i], for which the compiler assumes the natural 2-byte alignment
> of __le16 and emits aligned 16-bit loads/stores (e.g. lhu/sh on MIPS).
> When the buffer lands on an odd address these fault on architectures that
> do not support unaligned access, such as MIPS32.

Isn't the correct fix to not pack the structure?
(or probably any of the associated structures??)

	David

> 
> -Waddress-of-packed-member does not catch this: the packed origin is
> laundered through the void * parameter, so the cast inside api_wrap looks
> alignment-safe to the compiler and no warning is emitted.
> 
> Use get_unaligned_le16()/put_unaligned_le16() for the three 16-bit word
> accesses. The byte accesses (*(u8 *)&data[i], crc16()) are already safe
> and are left unchanged.
> 
> Link: https://sashiko.dev/#/patchset/cover.1781319534.git.daniel%40makrotopia.org?part=4
> Fixes: 23794bec1cb6 ("net: dsa: add basic initial driver for MxL862xx switches")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/mxl862xx/mxl862xx-host.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index d55f9dff6433..882c5d960941 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> @@ -12,6 +12,7 @@
>  #include <linux/crc16.h>
>  #include <linux/iopoll.h>
>  #include <linux/limits.h>
> +#include <linux/unaligned.h>
>  #include <net/dsa.h>
>  #include "mxl862xx.h"
>  #include "mxl862xx-host.h"
> @@ -349,7 +350,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  	 * zero words individually.
>  	 */
>  	for (i = 0, zeros = 0; i < size / 2 && zeros < RST_DATA_THRESHOLD; i++)
> -		if (!data[i])
> +		if (!get_unaligned_le16(&data[i]))
>  			zeros++;
>  
>  	if (zeros < RST_DATA_THRESHOLD && (size & 1) && !*(u8 *)&data[i])
> @@ -395,7 +396,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  			 */
>  			val = *(u8 *)&data[i] | ((crc & 0xff) << 8);
>  		} else {
> -			val = le16_to_cpu(data[i]);
> +			val = get_unaligned_le16(&data[i]);
>  		}
>  
>  		/* After RST_DATA, skip zero data words as the registers
> @@ -453,7 +454,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  			*(uint8_t *)&data[i] = ret & 0xff;
>  			crc = (ret >> 8) & 0xff;
>  		} else {
> -			data[i] = cpu_to_le16((u16)ret);
> +			put_unaligned_le16((u16)ret, &data[i]);
>  		}
>  	}
>  

