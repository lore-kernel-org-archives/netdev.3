Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BC2D0C94
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337807; cv=none; b=rFq9YzvCGYrKwyy4F28VafVu9mOv5R7FLsQApChbKxu56AN/O5wHxMscITYL8RmAMTSZ1vCDdSNLrQAZ7799LyhvCE77vcCvUcHkUiC1czWUW2SZQUKWeDZMjbZhPeA7cYmtE6vJkrJlFPY9+iPyJq+mCj9825tGKJO9sYZhJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337807; c=relaxed/simple;
	bh=12saGpQCsyPvcyoHas0G7a63bhlRxUB1+FfgpNhnIjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DJoArGw04Z/eZny8joU1mFCSLmQIlM5fil5RG7K4wviaPXUv2oqkocDyGYoFeP3L1S19iO+dTtGCKEWY7Z2mK90feuUmQEMoTmg1T9x3/QaxIRRVN6EByGV1NPxRSHuuIehfu+soOqKkrfXD8vDIe8HjzUVrsjDGQxlwr0nHSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbZlQCv/; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbZlQCv/"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab19125so1219940d50.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789337804; x=1789942604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KwJQ6M25sDzikcUA36ZvZh5n4DhA78o4GRWDhlmgmoc=;
        b=RbZlQCv/e41tUD02a3AzvcXzRB5AcOHgbw96AaKkkrRupwNvwAE18SU76Y2vnGPquz
         xAeqUEiw4Upo5O2ekz8uc4jFYTNwAagz8582DzY2hXmOkUiNrASBeJCOUEaFVHREEpXQ
         z1SjMqy1+25rsuGtk3Qft0jcFgutQntSdcm5nG9xOvwTcSpDWPYtDtvKe8ofc6np4djJ
         NAByFOBEUkLmXmGanCWpRNABT1UDwvpCll61/reC5wPviICZ2zFcEn20q3aMCus/XKqg
         t90jJPAPniyBI4SN9d49KPIPfRgwvmBLS70SMXRdzA+V1qYX//Ya9DdAZpeHOWvW3s5O
         YWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789337804; x=1789942604;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwJQ6M25sDzikcUA36ZvZh5n4DhA78o4GRWDhlmgmoc=;
        b=HdaxbKJwqLsmjG5Xf3KNr2bNmUAB1tTUF5NdxCKbodL4BfCOY654u7WMTGP30mS7y+
         JiqaWh95jcnTDiagnkuyCTRh7KH0TwSYWBI/lDNFEg+9ugKKnkAXi0MyEhDlN2QM5ujO
         qz66CxEYVQRwbqPlBGn5mXHK4yQEXuhEH/mAdqhbZi5lxbW+NNKjcjOFoJhD98rIOE6+
         4xR7RyGbWe9+apfvbFRNQH5SWRCr9asrx6bE+16F5WI1tFN4Ah4K7HK31AdoqMEpXgv8
         HgnGQx6z9UqkdNT0bZmvvAVCeTZ9FVW+t0Zjr0G5H+tnHTaWHTLJRaNytTH7ZPHenpkx
         QpDA==
X-Forwarded-Encrypted: i=1; AKwUvBy9encoCVVeHVAzLQsFhNcE2mkFVYdX0TELoSe4WRREZkbciw2uVZXdhuy/CVn+ufK+Fpdd9bc=@vger.kernel.org
X-Gm-Message-State: AFuF++nB1lNFqgLQyLBAsz3/ZQxWNL/uQhIg4+Xmf1jidFGojBchdLK+
	mrFPeaYToWhe1v2McgHDWZLt2VkpSHjuTJ+034/RFU0nD+NvRrYuvMj1
X-Gm-Gg: AYBFou1N4z5uL52IN0G8aWgPKbB8lgtLVaXlAAGSd55wGHfn/FHjBf4Vk7nJtauPms5
	vGpUxrjTxBBR8LHFIz30DTt+ONvruJqbxXcv6WErCmL04sPRgV/sMi1GeWMVS//7kZ810FmAH/5
	zLQ1aZva3Gf1JvmLahnN2TMxKeFtgzDFPN6P8+QOBpNzTIIOEY2yswR6ZyOnXTCx+GRbQOmrgJx
	Ojegjmuw9NNNW1dNu3lwKXGPPjBo3JEVJN/FOUGIAxKpNcA0JboeF6YvZJjNohgqxYzyfoSveMZ
	km6BPeNG/SYC1pXne+MNyML/6zxWSj6t5Wfc/IElH7aYDjzxpc+JWzXS5agWan1XaD6cIz0lKDK
	WrfgxJ7gxonKxRzKrPDwDF69zNxOjkpq2Y3Z7Apcx/8SQPeHivKpzh0aFLSmohtIeLlSeHd5WPa
	0R75i2d1DsCeJi6iPejj+58c26YaDxlTFfzO0Xe/hL6TzEZWSYSQ8w3dYARCQ5Zf7KOBH/Fk9Vx
	WCUCnGA5LNxjB7Cw/ZU/YVuhOT8jCHMqh0zi4VNPeRhbrZspt0A
X-Received: by 2002:a05:690e:1509:b0:66f:bc5b:1d33 with SMTP id 956f58d0204a3-671245110d7mr4867599d50.9.1789337804364;
        Sun, 13 Sep 2026 15:16:44 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125db3459sm3754086d50.6.2026.09.13.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:16:42 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:16:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Chetan Loke <loke.chetan@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>
Message-ID: <willemdebruijn.kernel.1288a752aca73@gmail.com>
In-Reply-To: <20260913-b4-send-packet-private-v1-1-925eab2cd388@gmail.com>
References: <20260913-b4-send-packet-private-v1-1-925eab2cd388@gmail.com>
Subject: Re: [PATCH net] net/packet: avoid truncating TPACKET_V3 private size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Amirkan via B4 Relay wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> tpacket_req3.tp_sizeof_priv is an unsigned int, and packet_set_ring()
> validates the full value against the block size.  init_prb_bdqc() then
> stores it in the unsigned short blk_sizeof_priv field.
> 
> Commit 2b6867c2ce76 ("net/packet: fix overflow in check for priv area
> size") fixed the validation arithmetic, but an accepted value above
> USHRT_MAX still narrows when it is stored.
> 
> For a 131072-byte block, tp_sizeof_priv=65536 is valid.  The narrowing
> makes offset_to_first_pkt 48 instead of 65584, so packet records can be
> placed in the private area that userspace asked the kernel to preserve.
> 
> blk_sizeof_priv is internal state, so widen it to hold the validated
> UAPI value.
> 
> Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
> Cc: stable@vger.kernel.org
> Assisted-by: Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/packet/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index b76e645cd7..f5c8cd0eed 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -21,7 +21,7 @@ struct tpacket_kbdq_core {
>  	unsigned int	hdrlen;
>  	unsigned char	reset_pending_on_curr_blk;
>  	unsigned short	kactive_blk_num;
> -	unsigned short	blk_sizeof_priv;
> +	unsigned int	blk_sizeof_priv;

This could be moved to avoid growing the struct. There is a 4B hole
further down. But it's no big deal for this struct.
