Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BF3CDBC0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638647; cv=none; b=FJEQJLm8Sm9P0xVCOIOfOzfx0M/VlFxqC8WDxNh8qLrHsCdKh4jRsTBev+XLuKc50xJLfe4TmKvyoyYapI10CxYilOuuYOyjkDTHrooaksCLS3qFnucxHfJKSVujs7743RgFD2xLrl+aEMfNmNUO94yCIzZJdhq1rLkFJ3qyilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638647; c=relaxed/simple;
	bh=W4W7AS3k7bTUDWy+5+TbqtoLoSWqMpba1Y0G4KgdsVI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N2e3MgCNzLQEDssxWO66HAl/NSOfO/9DBHX8qaEwv2pmUjEnlLoLWE9i+n3eucDplzoOZBYuKDJKxAxgbvGzEEMM/m3zn7hMtzUL7y7SddMlBvPKc4n8PEeHTKsu2mEEGqDZbVdfVEZG5O+xuS1PzfJdqA1dbkBlsljoOj2HLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8J/1a5m; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8J/1a5m"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso3461889d50.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790638645; x=1791243445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1BfEukceiMzwLnFjtJoLDtaw3hO9Ctps7fvem2vYIs=;
        b=P8J/1a5moqD75f0KZhD2jgQ0qfUzKHMJS4rO3Uqrdg4NvuUvVaIFbUyce7DOp5pYRe
         e5HehMUAzCph/ETv2JSyRJ45lWa8y/6QoeF+uA7KWmE98jv4nBBnnBSG+fybLzx8MmHd
         /Y06UizHFRh5bRV08nr+oGu6dLyL5jHtEPWbEUxWKifRt5hdHCqZvYl15bVB4oFW5aSD
         jW24BQySvnyEAb0QZi4oLT0G0mn8DXnD691R3gDHzXEv5ijpNkhKIYDnxm0YQz7HNIBm
         f26i3D7T/7WznYB7R3u4UPgLb79PiumHT+pPSVphajhojmPQ1qESr+BjyS8eSKLg+MQ8
         kFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638645; x=1791243445;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1BfEukceiMzwLnFjtJoLDtaw3hO9Ctps7fvem2vYIs=;
        b=HxN7hs3H47S2iydjlvokSbdlTBPT2mBT9UZb+ck1xuEQfc7m6/ITBmumrgOGMoNGjI
         mFoBn7h7S8sAqDd3TlFX65qPuYatJ4rm4PN9EBBcqJH+Cp5JBSV9iSRVJq4aqWD729KD
         nmB66avoe+9SvUhmOtNHoJsF45fDsfMJ2cuBaCzqbTxdxNluAfRqgmLeyOJr6vxIA45A
         Ee3hBAdc+mafXxOv+Yzp1eLfGD17PQc+Ih++aoeQpaO2LKMj+KVkVHkJ2ifP2xeQBkhT
         hvXYRZZjeqfTd/qv46pvkhNQmdqJJYh9h31Ist+Pb3JPDuSSIgA8FRooGSoHauQKJR9J
         Ax+Q==
X-Forwarded-Encrypted: i=1; AKwUvByvKiz4DQ7huBYVewEoR0bHheJNul2DQyG0sqLp5LANwdLDUIJ5AGyJ/2h1Ov/vw3JEq1xsOUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh2huDRxS+WEvsyUKlmHapLdmb2cc4fo3W2BdHXt9JshZqWjw6
	wvoZC6HOJluGtvf7CqPfrZXbz4LafiAzf4wMSPMoHoTq/qSdfybZOYUH
X-Gm-Gg: AYBFou2i92Fh474khV7JQbGnwBj2Qf+0s2F2ySQ7jYVYsv3qsqrcPhM+nV2hBFvIOHI
	zks6z45v4XR85nt4TSWUPOJJfUnyLgulhlCnopuJMLznf+XT77fjTCLGu2FeLKe2j3moTgoVAK1
	HFmIW0B/EnoA/C8f41yafUHZ5OOljS+MIfYdFqzKbMPyOChcOLnisCHClonWTHJNtP3LKQOua+I
	0gpNKdCWGProCQMAFkssxPDQWfWDzWz/RD8l2Oen9PGRmxJxxrippvao5fHbN+kIHcxiHF4957I
	H7gCZBIPnXwnUvdyHmz4gKifO2xAZqPv1cZ0esY0mnmXfICsvIqbT27CGYSI+5pZP/GCGaC/M7c
	VySyLzhOJhv3pmbc6xJ5pNwROOlBco6kneh7FBo+GuxnXq4HV74KWrfWPvPpS7qAeGZhrhxizGJ
	qB/2pv7gF1Lwea2BbKEzV5dV1swLq/AQeuNnz00v+ng4vITziunI7aRgkDHCGaGbDz7Js8ElFNx
	F1now+DOa9iBJok7rmC7i14pr3eT1FkSCKgLU4HZ8HUTaJhPek5
X-Received: by 2002:a05:690e:1685:b0:674:1e39:445 with SMTP id 956f58d0204a3-6741e390b04mr3870823d50.36.1790638644883;
        Mon, 28 Sep 2026 16:37:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f85e57sm51324307b3.19.2026.09.28.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:37:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:37:23 -0400
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
Message-ID: <willemdebruijn.kernel.1a1de2bef031b@gmail.com>
In-Reply-To: <20260928044102.1004310-3-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-3-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 2/5] net: core: factor out the GSO device
 limit check
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
> gso_features_check() decides whether an egress device can offload a GSO
> skb as a single TSO frame by comparing the segment count and the frame
> length against the device limits.  The resegmentation path added by a
> later patch caps the MSS segments per output skb and needs the same
> features computed without those limits, so put the two tests in a helper
> and gate them with one flag.
> 
> No functional changes.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v3:
> - rename the helper to gso_within_dev_limits
> - move the check_gso_limits flag and the wrapper split here from patch 4
> v2: https://lore.kernel.org/20260918084651.3022878-2-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-2-wang.zhan@smartx.com/
> ---
>  net/core/dev.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ffa9b0c27788c..d66b667071837 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3834,17 +3834,19 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
>  			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
>  }
>  
> +static bool
> +gso_within_dev_limits(const struct sk_buff *skb, const struct net_device *dev)
> +{
> +	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
> +	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));

nit: keep the separate return statements as before. It's easier to read.
> +}
> +
>  static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  					    struct net_device *dev,
> -					    netdev_features_t features)
> +					    netdev_features_t features,
> +					    bool check_limits)
>  {
> -	u16 gso_segs = skb_shinfo(skb)->gso_segs;
> -
> -	if (gso_segs > READ_ONCE(dev->gso_max_segs))
> -		return features & ~NETIF_F_GSO_MASK;
> -
> -	if (unlikely(skb->len >=
> -		     netif_get_gso_max_size(dev, vlan_get_protocol(skb))))
> +	if (check_limits && !gso_within_dev_limits(skb, dev))
>  		return features & ~NETIF_F_GSO_MASK;
>  
>  	if (!skb_shinfo(skb)->gso_type) {
> @@ -3893,13 +3895,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	return features;
>  }
>  
> -netdev_features_t netif_skb_features(struct sk_buff *skb)
> +static netdev_features_t
> +__netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
>  {
>  	struct net_device *dev = skb->dev;
>  	netdev_features_t features = dev->features;
>  
>  	if (skb_is_gso(skb))
> -		features = gso_features_check(skb, dev, features);
> +		features = gso_features_check(skb, dev, features,
> +					      check_gso_limits);
>  
>  	/* If encapsulation offload request, verify we are testing
>  	 * hardware encapsulation features instead of standard
> @@ -3922,6 +3926,11 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
>  
>  	return harmonize_features(skb, features);
>  }
> +
> +netdev_features_t netif_skb_features(struct sk_buff *skb)
> +{
> +	return __netif_skb_features(skb, true);
> +}
>  EXPORT_SYMBOL(netif_skb_features);
>  
>  static int xmit_one(struct sk_buff *skb, struct net_device *dev,
> -- 
> 2.47.3
> 


