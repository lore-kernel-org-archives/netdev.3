Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0627A92D
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991094; cv=none; b=CSJMsmwslSl03morlwgTHH799ILDmS7z5d+42quiEg2FW/jeiD2zs2/7zQWPZNh9pek1Y5Gt7syP18ry/8xdDfIQsUoGIOoFLXvHrrjOuSUPWANjrXzxZLxrGOx/vs0XQWKS+cWOjUzXog/cjvfTOAMOVmeoxe177U9lGv/2DZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991094; c=relaxed/simple;
	bh=KZs1Us200zaSsvqhZvrAFPnlls04ZdqH5I5VmDa9ki4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebGIXqDC44ahbxrIzESqmXh6dWUNABgTk5nqmFetDsVEjni4v02nqOXNVIYWzfyIZoKCgm93U6PNum9hziUEytaO88wEA/gzCszlWZJB6bUcOLvPuU06w5IvStF51Lg+Be5MnZBUy/UDPklEhtDexVcTz3oLKkE5wYl+pt31rN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VwHokeS/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VwHokeS/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956242332dso12048135e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784991089; x=1785595889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgrPUXs+4puy9cY0msWgnbxd1bLXilsXJgyDMqCeWgM=;
        b=VwHokeS/3PCz80tpID9Db1yuYpP7ZDtqT+Pv9KHhG7bWIsoemiXGCzaGb6eYnpri6Z
         J6rNqwteWvht7CfpeMSl5W9BS1VUAUDjAU+g03JFA5MeABb3lqKx4ucqPW0FvnEDZ/Hu
         98P/f8Ahjn05NiZYaN/snyGtAIxlNWtJeREFokWugN5NiN+V3zuVbQY6zr6LH5Y2r4sv
         BJhmITrbntN/E0G6m5K1wnck7Cqr84qJYqSWAr1Ut34rnIL5CZ1MtRgj8Ym4k0Y3lpkV
         CsR5gMyhs4VwqKvVZD+kiOoHPKS8VV/oEa7ZIFUXM1JmA6fsCNRMP+FSljWIcgw8L0j3
         oAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784991089; x=1785595889;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgrPUXs+4puy9cY0msWgnbxd1bLXilsXJgyDMqCeWgM=;
        b=gVdyNOoejpph9BS5pK/btpjGtn2v57H8Tj5vCnNCSG5Xqfm+tUFd/nu71735W1eWhv
         h2Odkwju5/S4KpOFUnlMWZuEF4NWq+CvKhhRreXqQodWvpJ9XNUq7AfomWSh75uXvX0x
         Lz95F9vqT7zVPxJtf88qcEuzI7fp3i2LzxfF10LB9RE3coA+Du/zAbIt6WDNaPY7fxtW
         +Bocn+/1L6Q5tcNiYiVnofVuP2KqkmYycj0hdiG7Ew4q0zMiJsbLmK4yYpwK9UIk2gJC
         3r+OVBOTtzEGOAJS7dTA02scP9urJXBQyQ+SpU7oUWTDhKPT/8Tsbbb2IC10R6J3Vf+G
         fZjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0SB0dq4TDU3v/ckhFKRtPpgKjeSJJGejXasbFpJU1pOmlF6xNsQp4YkEyyWeS2Y0aheaaR8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4RYpLCz2NzWNxsOaLj9dAPYlFZ1nEva9ncwOdlytkNCXpd6a
	Y2wQBcJRPElJvRnCAFqNX0DPe/Hz7kuB0V2K1YTpeIB0J98mqK0XlvxWa7aMapN5x4c=
X-Gm-Gg: AR+sD136XKilPtOshuGfBEnb7VoEjyvgDAcY0R7/UOG0YADHQ3EWeBH92KeM46tWueG
	cfXPe2n+B4xNz1yqyGHQDJABvU/iwSQNYlLdNtYaIeHnwQOJ4qr4VUNrwZ1K7D7cGZAH68pJf83
	hzLcyUegWQ+J9bo07Kp04o0vyqKpmiJG4TjzXPVWf+HIlOWhJdq1JcO1xdpIMzi91MEmMVcs1PR
	7nVRCcX0wwP+lsm/xe+8zC6OiwmJspriojwXnGd7HRnSulEH40UQIigvuDG2h/FOBH2IGmJMtWO
	b+bMAjkHNol28rYPNytaxb8xfWtTo49M0HonDIAyWw5p4yfXmonAvSVkzc0u2PVfPIwbrZIC7JE
	D813s+nROP3Lfujq/U7QmnNGkqF25DM621dITuIj+8JH+/AbQVwsIvTqFQ/Ht21XXB13wygwhPw
	==
X-Received: by 2002:a05:600c:3551:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-496b56bf01emr30334965e9.10.1784991089051;
        Sat, 25 Jul 2026 07:51:29 -0700 (PDT)
Received: from localhost ([83.222.177.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm83072585e9.9.2026.07.25.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:51:28 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:51:21 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Corvaglia <david@corvaglia.dev>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bridge: mrp: fix MRP_Test option TLV length
Message-ID: <amTNacya_ZXLjoDn@penguin>
References: <20260724051202.61946-1-david@corvaglia.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724051202.61946-1-david@corvaglia.dev>

On Fri, Jul 24, 2026 at 05:12:02AM +0000, David Corvaglia wrote:
> oui is a pointer, so sizeof(oui) is the pointer size. The MRA
> Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
> causing misparsing of the frame on peers. Fix is to replace
> with sizeof(*oui).
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
>  net/bridge/br_mrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 3f7126a7d720..179d2470b724 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		struct br_mrp_oui_hdr *oui = NULL;
>  		u8 length;
>  
> -		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
> +		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
>  			MRP_OPT_PADDING;
>  		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
>  
> -- 
> 2.55.0
> 

This is clearly a fix and looks like it is needed for proper parsing.
I think it should be targeted at -net with a fixes tag, probably
f7458934b0791 ("net: bridge: mrp: Update the Test frames for MRA")

Cheers,
 Nik
