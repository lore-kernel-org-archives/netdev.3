Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955433E37C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638565; cv=none; b=rDc+O19FgJiOEcg8iM5lTCJilzsd/Rk3iTy98LIWFKAcx0eiL95cZCTMZRiVQJ6/p68uKSAd/PG+rYKqoSuuhFWFLmakZKFl675LE9xXhrJZ0PfNhCjgW9Lz1Wuz0djqaLNlSu08eZBY0uOYV0rmnJIEAM8U/199+bmi2L/QjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638565; c=relaxed/simple;
	bh=OKJtxxKRKZVlLn/j8zGfQ6M1uQSLXvJaDDgEisZM6TU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YOYDeNmapySou6G7pqqn0YILBzJDwpir9BZL+jZG68jPjGdGhchd7o/5sZQopPEY+RalsBCW9pEB7pkqwN7NTg24AB4LUqYRVJKnA5niAiQGMQTyPK0iweQuHfAX/OnsVDkbygGeZrGL4aR3r+84iqh7WfQTBi5R73Oyi0vg7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJUHMNd8; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJUHMNd8"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6714595153cso338245d50.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790638563; x=1791243363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ypztmmggeQwY1kynuS5eEuCp8AzH10EMEv9oXj9nebU=;
        b=IJUHMNd8sOFyZDeMPmdVpDaED3R3LVJuQyhWPLpQBYIrwaboP/0hGFycxkuxrBSaKp
         C5j2MRY6T+UDJn6ucajzjGKyHLHsOY5mOGfkzniEd1fEOoRXX+cY4BqwNFSmCNR03/VZ
         CzlvikQc9/bVeHDiEiiVqqFqsE1OZNkjNIeEwaaz10M5/39kWxDXhAfUl/3sU/jUFxWZ
         su6fftACpLCLnYg1YygEeJNUSsBqUpLIM6DV0YEgyUlc0e3oAgmV2kbKNM5u1ZzfuJxd
         WzQBEeut9zrtDKNlbEsDW2Q8YlN8kisIv4V1Lf1J2treynN8wKI8gClQ/vLaaMM9n5En
         NoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638563; x=1791243363;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypztmmggeQwY1kynuS5eEuCp8AzH10EMEv9oXj9nebU=;
        b=Qgywq2IlYsBMi7YiFLeY5k6OHSTcUTxP3cl4XGrQVdObMbM5deQdjkDslo//moQW5r
         D3TeoAREia+B8GgmmktU4kvz+S0nhaVKobhE0ixIt4+O5CGdTFtCrYkB2zgegCARm8Y/
         ZOobY+6GA2ZIVIxAbtnMxJGw1YqQFnCzxpLrmxSIiZwyuDR6MdeUkoxi1G96ldpmCEKt
         5/AxbjrvnJP423VVhQxerHxDB+lX7+gMtWCnXBzQRnDTgwsmnZdLOCeiF+Lwgn2fXRSn
         NE6xoz+X+W+thOE2vXJivghoqmSmdzY1O1RtruGVfCHLKb8rI5cqjLCgOd20jsKt1R3j
         t7hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlPS+Jz0oaXbVdg0b7114iXHZg8MJ4ZYBeB98EETSK90xcrlEFtpZ1bIVwRMw3ZuOGiwajUfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsM31HnAd8BY7Xm/Lb44BIRK7izQaa2r6F50JYXcLv8gsBCSaK
	dEeI556anjO1xzlkCYdDCOgXxBt0w0ptHMMk88RE6t2AFQcmxfxQwSoV
X-Gm-Gg: AYBFou0q8Zz33UiVrplpmDzFqfF+dec8MCl7IkuOWgTZMUDvHEOpqalHWpx+KMcY+2K
	ghSE2DRCjvNEenaTJDc95C+guC0W/95m5UX+YHmpIdTNT+VGi4ImLs4AKUBLqRUWyYK6fuuvRHp
	LgYAYnHFauuKPA+lX1EKOyW3DXlDxJXhOt+t8zHvnDqluhBEMlkc+t3lQVYKu6+xg1OpDj58ckv
	GCUrRucm85CHY4JqpXkYY4g4N3VrfjPwFGYIKMALUCJ+Yib8TWRLh2lAX6Zx70pYzaby7t43qAo
	zm14vRfuNYXDXRBnnl1dP/+4NARrCwLVG+NR8TNTD5X9IBqDwQS/pZUx1wutkpFC8s3UUbtnBTE
	K/Q5FeOijCWYwSymemEJKv7shrB03DAQ7snI+0gRIHO78Qe97OayQtfhg85FHukHzOD2m/bCKVW
	BmHYw9h9800xbbWWohw5t2XGZStGO9pDy+JPAC9lq4o/6FS/ci2GdtA/d8LmBAnaBbEJ21RRJNv
	I+8w4d4Lzpwm7HuAofxdyI0x8YG4lPdYICvu57wN5wPGX2UZL2/
X-Received: by 2002:a05:690e:4009:b0:674:11cf:a3d1 with SMTP id 956f58d0204a3-67560c1f4demr386789d50.36.1790638562904;
        Mon, 28 Sep 2026 16:36:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm5408871d50.5.2026.09.28.16.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:36:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:36:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
In-Reply-To: <20260928044102.1004310-2-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-2-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 1/5] net: core: use the packet's L3 protocol
 for the GSO size limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> gso_features_check() compares the frame length against
> netif_get_gso_max_size(), which picks the IPv4 or the IPv6 limit from
> skb->protocol.  A tag which is already inside the frame replaces that field
> with the VLAN ethertype, as skb_vlan_push() does, and an IPv6 packet is
> then measured against the IPv4 limit and segmented although the device
> could send it as one TSO frame.
> 
> Let the limit lookup take the protocol as an argument, and pass the L3
> protocol, so where the tag sits does not decide which limit applies.  The
> helper cannot look behind the tag itself: it lives in netdevice.h, which
> cannot include if_vlan.h because that header includes netdevice.h.
> 
> Fixes: e609c959a9396 ("net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size")
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v3:
> - new patch: the L3 protocol fix split out of the resegmentation patch
> v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
> ---
>  include/linux/netdevice.h | 4 ++--
>  net/core/dev.c            | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d037faff7c44b..1c28861fcbe2c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5562,10 +5562,10 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
>  }
>  
>  static inline unsigned int
> -netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
> +netif_get_gso_max_size(const struct net_device *dev, __be16 protocol)
>  {
>  	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
> -	return skb->protocol == htons(ETH_P_IPV6) ?
> +	return protocol == htons(ETH_P_IPV6) ?
>  	       READ_ONCE(dev->gso_max_size) :
>  	       READ_ONCE(dev->gso_ipv4_max_size);
>  }
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc..ffa9b0c27788c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3843,7 +3843,8 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	if (gso_segs > READ_ONCE(dev->gso_max_segs))
>  		return features & ~NETIF_F_GSO_MASK;
>  
> -	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
> +	if (unlikely(skb->len >=
> +		     netif_get_gso_max_size(dev, vlan_get_protocol(skb))))

If netif_get_gso_max_size needs to inspect the result from 
vlan_get_protocol, call it inside that function directly? More robust
and a one line change.

>  		return features & ~NETIF_F_GSO_MASK;
>  
>  	if (!skb_shinfo(skb)->gso_type) {
> -- 
> 2.47.3
> 


