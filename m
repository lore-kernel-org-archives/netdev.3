Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E22EDD58
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203547; cv=none; b=XwFVkEGe9DT2whqxUauh0KjNJC8P9tFvsjxUt94GMZFXdR78FSJoKjEARTT1qB7WiNv5u7htX9tMhoOfaY7iHSwwaCkxEwXTiXjzHzgrNvI7xC0K7lEdE5LABN4QPPTDkjI0XxNoL6Lb5iC3hteRhLiFd8kQgtk15aatn2LHNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203547; c=relaxed/simple;
	bh=ul6zbK1uBH+navfqH9vWdUlC5ega/+y6fwg3dD+fcw8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rr8RFj8EWXBXdbLH0acS9SvkigSXXLsYEc6HYYt+ps3CeTcAHUvFVgGBZ+OQ/rfJQ+DpmPTnCbPrwoFhyt1nCHoZgbq4CSJ2IxILfa2b7VWisNB8jb5NSZdOdIsi2rxMqqIwfiYty1VXR34ZSL8byItCvyPTNMZCJuHkY5HI5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM0s3tuB; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM0s3tuB"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-668c1b780e5so670068d50.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786203544; x=1786808344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QOxmHWpqoC/61YFgwGva4jTZ6surf2tpxM8DUZurnMY=;
        b=WM0s3tuB+u27sOKoYn5Fff9E/3W4R+G3Gqv+KO1WBRgtNxAmLHpcHqjxo2XlX67nZQ
         YPh/4vaKh5BuGdGen/QrGQuLQlqa8YMJy6f01D03TXfS4yf4pltNjMNcNbpLlZTpXzur
         Fip4ad41kHCXTiuUhs2GRUBbeYjIRs2+/EgrpppCW0s6VN6fvi69Vzi9EMoimK1ueZFC
         xJ67CpkczxZInuQZZT/asz92olBwO90wHAi3KIgHwzkK/TthPYzzuGMHa+OSfnthpO/T
         iVSg86/GqL8aotlMmTisR8fUwvP7b4VMtnMD8WVgo1/jeXRPjvPJP9piS4RjHbhb6NGt
         VNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786203544; x=1786808344;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOxmHWpqoC/61YFgwGva4jTZ6surf2tpxM8DUZurnMY=;
        b=BiMaBFKY9uB9twf7asbxe+LdyQufB8yv5d681gqp40LutFsvf+Knk0JC5MV6TR57W3
         HMnN2LfZb58TuGgwZjX+7qPAmQk4EmfBqzunwagDrS5+hEtMGgiUtwOuJBWrunPHql+L
         B4C7dQoJzjyqlh56dQrjkDiD8YFMWhOjWY5RprRxn8StrRf0nBi9ee1J6vSLbnfKxnd8
         1Pa3PLEovYlvgf6SuNG3hcBRC5/m+3tbsoj0xkype+upRs9zBgmsE12IFSfr9exgehe+
         8PPfi64GrURau+9Pm5cUPffhW59ckmVPpIuPcvFSMSQUMNn/LZvjWXy8kauxGqb1L6at
         iIdg==
X-Gm-Message-State: AOJu0YxW7aq82R62zXMGrhKGMnfLjYLbpI9tqVWJ6VfgvG/8HQQzQUZ/
	aoO5t4po983N+MGWiTORxTVAEwhWsgmG00qzeSmMndmzvr095b+VWSMR
X-Gm-Gg: AR+sD12Y7rw1c90TZOd9Sg6ex0zE5NVRi0d0pxBb3brTqkWvUDzmJIbttbLTp8agZCU
	BzrRQsD2100UXOfpz4zwFAz31GYpbNqkFMxy1uCjWN8mkNGG6/Mfbdo2/qa2LuzHa2twRM4629w
	Tykrf7x4TsuQPeLp0gI6SvjQ6EzMYZp3zjXzo6HV1KhE53zm9Sp7GRhliEABPv3ac2bxiB1y9mn
	F12+MOpAheCpL+YBva9DEzkP1nyvMzkSkgDzVrJnfidPjVtjo0bP+zb9VQKOVmOc9xt6DbZuNxs
	W++h/IFD5oou5E/Z2N32MhBB8D4MA1MUWpGPdxQZADAIc6xCWYJd0OjIsTz8KM+hq7GZvaLs+WW
	p1gSlRupxy8bE/VVfalU3I1LWALKtt86X5yvuIDFxMKFYLZTBEI0mto8iCuPZg5fP3N/yfSBmgr
	Iw27+GJxF6FsycfqeEiFxOs5okwZiZbBM809DX+IE104WJk39ENFf2m9Cr+ejSa2yfUNxEBrDAL
	tEaMog9YScWwqEMgtqGcTV/+9L9fvKZOw06uWZ9LORPmpM=
X-Received: by 2002:a05:690e:4252:b0:668:9148:17f8 with SMTP id 956f58d0204a3-66ad7261175mr3852609d50.43.1786203544445;
        Sat, 08 Aug 2026 08:39:04 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae63149sm3163693d50.11.2026.08.08.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:39:03 -0700 (PDT)
Date: Sat, 08 Aug 2026 11:39:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2e2d53367799a@gmail.com>
In-Reply-To: <20260807070914.112698-1-clementwei90@163.com>
References: <20260807070914.112698-1-clementwei90@163.com>
Subject: Re: [PATCH net v2] tap: fix incorrect variable used for USO check in
 set_offload()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The USO features in set_offload() incorrectly uses feature_mask and
> features argument.
> 
> The USO feature was written to the local features variable instead of
> feature_mask. All other offload bits (TSO, TSO_ECN) are stored in
> feature_mask which becomes tap->tap_features and is used by
> tap_handle_frame() for GSO segmentation. Without NETIF_F_GSO_UDP_L4
> in tap->tap_features, making USO on tap effectively non-functional.
> 
> Keeping the USO handling inside the TUN_F_CSUM block avoids enabling
> GRO/LRO when userspace requests USO without CSUM.
> 
> Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Substantially changed patch, please don't keep Reviewed-by tags across
non-trivial changes. That said, I do agree, so adding it again.

> ---
> v2: Fix more incorrect variable in USO check.
>     https://lore.kernel.org/netdev/20260806163949.2807698-1-kuba@kernel.org/
> v1: https://lore.kernel.org/netdev/20260805072121.117472-1-clementwei90@163.com/
> ---
>  drivers/net/tap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5d2d34d24ce8..d4ca2fee538b 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -883,7 +883,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
>  
>  		/* TODO: for now USO4 and USO6 should work simultaneously */
>  		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
> -			features |= NETIF_F_GSO_UDP_L4;
> +			feature_mask |= NETIF_F_GSO_UDP_L4;

Drivers/net/tun seems to have this same issue.

Do you want to take a look or shall I?


>  	}
>  
>  	/* tun/tap driver inverts the usage for TSO offloads, where
> @@ -894,8 +894,7 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
>  	 * When user space turns off TSO, we turn off GSO/LRO so that
>  	 * user-space will not receive TSO frames.
>  	 */
> -	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
> -	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
> +	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4))
>  		features |= RX_OFFLOADS;
>  	else
>  		features &= ~RX_OFFLOADS;
