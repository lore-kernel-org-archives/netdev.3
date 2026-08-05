Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BD46EC69
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935646; cv=none; b=ra8VzyMjvkKbUiP4pNmSvS0CmqAmUn8z1xputOEr6hm2sisfwyBNuHAjYIFgCKtdh2CGD8FcRG6XKqJbJer3Bx/PUhTBN+mVRvEqVy3z835Zj3+hXL8Qf0Zf8Y44y+ocegrvt8rTtzXiyqYqKwN3r11eCXtHwb7WWZN8bRgRQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935646; c=relaxed/simple;
	bh=E8KcPaReT4/79TPxmSbpFfrntjUX0IGKPewdhSOM758=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z0GMXZ4lKLHoo0KvPkgDeaEEq58t60nJV0TWqN3O5WrIDigJic71v0zKHMDdHo+iCqqzFapNEU5c5UjTkFL9j5VH7NTelp9N6DPH3O4vQ1qGh31cRpmkVPJw/+bU34wVxzJJ+v1ieRF/DdFIKbX1cyoTysp1FEyrUsXHbKgXzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owkK+zo+; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owkK+zo+"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6611669cd16so1277060d50.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935644; x=1786540444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAMkgjQBGnc0gNI3l/Z+Z850lBBLV8dJEidADPlnC+w=;
        b=owkK+zo+tR11ZVUaXbnd31iqt9PcwKCK8/7VleoNvktbQblAb6eu2GY9IGY+4OCqjt
         Z2hMWKJ/9LDVxggIVORAJ2bVAYU4m2C19EKHYItr+I/ccZLavPhp6R7Py4ckoFv0z5Oj
         JmjctBDIeg1LHN1iBFI2k2JaTyViE0ZELnySgKHbBYGVj8mFjNOgI+UEGFOmbjknFK7L
         uvwPo/vvEZE4xCS3PHFyujoumc3K08Qd0qr7bcmySUSC16dhELlgmKSGtkc2tpAbTwO4
         XFjJK11YKpF5t57ukDwJO4eCcdgFbNcOEnAmhxAfiK8Ci9GP8RI2jEkekhm2yna2eVMt
         qKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935644; x=1786540444;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAMkgjQBGnc0gNI3l/Z+Z850lBBLV8dJEidADPlnC+w=;
        b=fiHLMIuFOdrFNdTnEiUFkJXz+Ywo+zjulaZ/TP0uqwp8btqDaDSes8F3fTQz3+ukBP
         Bi4WMp6gm572x6cZTO9UkScDY0v0nCHXOpKWuQRCrX9s9nvGBtABWTSeihF7yhpcOFrl
         rVOVB6CSiw4HVfMSQ0GCDHmtai1ZpMYLuRGvuSEd+Gp3YCqMo4XmlywxxyBSyaw7jjQN
         e32JBfrO1YZ/xz93IrdIbRH+JKNthURUWVCbt7zMPtICALw0jG/Jx/65NoEEfdbFJ2lV
         HMQMc4ubn7FW9FD5hc6XttO4n8/TqM1An8MkWo4E5s3wxbywk8kx+EYuhlBsl/POrjy2
         Ii6w==
X-Forwarded-Encrypted: i=1; AHgh+RqA2TK+vfBQPTVfJEWnh7zzeMXWWZ8cpYe8I3HRupwriAmkBAa9wengKhAZhwqD8CFCd2Xf/MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBZi5oGoScdSptwuUidkWPL0jUcb5J0W6SkmVI2z19jW4xe/i
	vQKLjnf+ZHe7iN6NHqA+CJQiq5/LX/zd2SC2VWwKL3FjYkv0dtw3ISAx
X-Gm-Gg: AR+sD10qdVpSFZA9oMCWo4LjEbgTCg65yIFV2rpOiBTEFa4KRZfLX5IGs/gqbQmiiip
	kRFRAaVYaTBqhc2vtI7h+8hMg61pRigvFkUv2Hh8rqasiIkTVd2YHR0kujZ/2IkHQ54AE+HHze/
	yfPjBsgxo4aby/qvZ2zWzqNUJKxJw+MMpLAuWjJNR5kNrAFFOT17Su+eW6cN6mLBAqna1lbwvBw
	0IQebcwhaYDjNok1hlPsDLSAkuAsuPDI5vBuWIt9CQotjf5Wz2HDnDoQJuJSiG4cWpqgT1ix3fR
	ICraXbtstgB7ukzlaYkQrCPSNEKjxPYL9czirN0YmXm2cBJxdfxAWxXE4S6ln4j5XzmWCoOc1zB
	HqHcgOEFJVSVA27XfUetW8jzNtP53iU1q0vrjRtoQWy7Orlbf7ayRn4GvYDtOCXIqS1e6MPpAWS
	uktKzqNgYazqwix4ttYscn5kl2mAPDSC58n2RkLNVL/o6BqPnonQW31UbSeLGyCMWU39Lwdtpt7
	bMDZpFXSZr1hPggxrsO9Vt/XOuRsqsOt9dM
X-Received: by 2002:a53:e039:0:b0:664:c535:ee36 with SMTP id 956f58d0204a3-6699aae52c8mr2633593d50.41.1785935643797;
        Wed, 05 Aug 2026 06:14:03 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66991639dbdsm2991208d50.14.2026.08.05.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:14:03 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:14:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <willemdebruijn.kernel.25faae4ed8f11@gmail.com>
In-Reply-To: <20260805084504.953162-1-manizada@pm.me>
References: <20260805084504.953162-1-manizada@pm.me>
Subject: Re: [PATCH net v2] net: tun: bound receive headroom
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Asim Viladi Oglu Manizada wrote:
> tun_get_user() uses tun->align both as skb headroom and when choosing how
> much packet data to keep linear. OVS can propagate an oversized headroom
> request from another port to TUN or TAP.
> 
> When align is larger than the usable space in a one-page skb head,
> SKB_MAX_HEAD(align) underflows and the result becomes negative when stored
> in good_linear. That value later wraps when assigned to the size_t linear
> variable, and tun_alloc_skb() can place skb->data outside the allocated
> head.
> 
> Bound the headroom stored by TUN to the one-page skb-head budget and the
> largest non-sentinel 16-bit skb header offset. Leave one linear byte for
> raw TUN and a complete Ethernet header for TAP, including NET_IP_ALIGN.
> 
> Also pull the raw-TUN protocol byte and the TAP Ethernet header before
> accessing them, so these checks remain safe for nonlinear skbs supplied by
> other allocation paths.
> 
> Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---
> v2:
> - bound tun->align instead of clamping good_linear to zero
> - derive the bound from the one-page head, 16-bit offset, and TUN/TAP
>   linear-header requirements
> - pull the raw-TUN protocol byte before reading it
> - make the TAP Ethernet-header pull unconditional
> v1: https://lore.kernel.org/netdev/20260721014117.2234892-1-manizada@pm.me/
> 
>  drivers/net/tun.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fed9dfdfcc3b..efd2e7d75c9a 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1107,11 +1107,16 @@ static netdev_features_t tun_net_fix_features(struct net_device *dev,
>  static void tun_set_headroom(struct net_device *dev, int new_hr)
>  {
>  	struct tun_struct *tun = netdev_priv(dev);
> +	size_t max_headroom;
>  
> -	if (new_hr < NET_SKB_PAD)
> -		new_hr = NET_SKB_PAD;
> +	max_headroom = min_t(size_t, SKB_MAX_HEAD(0), U16_MAX - 1);
>  
> -	tun->align = new_hr;
> +	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> +		max_headroom -= ETH_HLEN + NET_IP_ALIGN;
> +	else
> +		max_headroom -= 1;
> +
> +	tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
>  }
>  
>  static void
> @@ -1822,7 +1827,13 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	switch (tun->flags & TUN_TYPE_MASK) {
>  	case IFF_TUN:
>  		if (tun->flags & IFF_NO_PI) {
> -			u8 ip_version = skb->len ? (skb->data[0] >> 4) : 0;
> +			u8 ip_version;
> +
> +			if (skb->len && !pskb_may_pull(skb, 1)) {
> +				err = -ENOMEM;
> +				goto drop;
> +			}
> +			ip_version = skb->len ? (skb->data[0] >> 4) : 0;

Overall, LGTM, thanks. Let's wait for the bots too.

This can be a bit simpler. pskb_may_pull checks that len < skb->len.
And it is not an allocation failure, but a bad packet.

	if (!pskb_may_pull(skb, 1)) {
		err = -EINVAL;
		goto drop;
	}

	ip_version = skb->data[0] >> 4;
