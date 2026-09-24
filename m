Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA8E37A827
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258543; cv=none; b=lI8EkrYq5ZZZRkOC/H1PP20aGHwh+3UKIH3dTK3MA932pEo+VfYG4cnce12Y6ESWNGGgScwOG7px+v1bvOGFVLNakiKRCznHiB4EKPzPjnQ5nedDrFkx0dBybqkUJ43Nv3cRPuvz9Cm1Psvg8xVzg1NEhQHC4fCTDyF9uYbMoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258543; c=relaxed/simple;
	bh=2M5N5UiBJ1ddyg8dMOiNcYvvUIbd7ffwpqnthWQSKK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e22tU9krNr5pcobAg8b8l5kLdX4mVSfdyegRxZ1qenrn9VOUDBg4ITXSmp/G6MI27Rsf/MGaGoAPGV4oRXDn249yY3uCO6wB2QYxUZ6UjPo7Yj09Ae5zBYOc7KjtrSY8eX53iM7vvWyQrsMMTgRQvaGmRjheO+GrbPfN/vsM7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1YDm0NR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqC+MYGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1YDm0NR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqC+MYGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790258540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFq08BvLQ73uZxTwrfW2vsefzRBYnKQFNvixjN+bfos=;
	b=W1YDm0NRF1OeiOoppS+Kjr0FmONu8E/sNAfIB37u9oZmkQp6F1YFlB7pxAV+OhoN1lcjDa
	nN7fx8N5xco9RaSmU3LxNZ0D+7JD8zHMHYcee6sFM28SKxaiH4ALQ0qPlHV/pHderxK995
	7xDpSAP7ybARcw27075FLJoRSVwMz6M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-vVd7PpvfOKmGZdNQdBWqUQ-1; Thu, 24 Sep 2026 10:02:18 -0400
X-MC-Unique: vVd7PpvfOKmGZdNQdBWqUQ-1
X-Mimecast-MFC-AGG-ID: vVd7PpvfOKmGZdNQdBWqUQ_1790258537
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so29373095e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790258537; x=1790863337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFq08BvLQ73uZxTwrfW2vsefzRBYnKQFNvixjN+bfos=;
        b=WqC+MYGILkkGpF6xQuGtjQ65hA4+7R+tfXc9COPwWz0ynCedCsKu6IKjhSubilJw4t
         2sPPg6NDRAlYFadxmLdmg2avHjjl8l0Z6fBPTeXbXGW5v2qf+Jd3Y26sesW9+G4IfI9h
         hzcQzIlbtjHkpWm1ogkO/jZg6uGI4AEtS9vipbdvTP0qHwK9dq4es+bOp7jSlvNjLAm5
         JNuE/VmUNt4j2Aby2Aob+hLTkI/rgKuF+X6XgGMHT4lmMQR6p5soXtZuJrjyQ4suxToV
         oCfHW6v83aXryRiYKDKF+RO84C0vypKv+G+tjKETuVtZz0hLR6ZdIsvckZOeWj72jB6x
         ICMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258537; x=1790863337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFq08BvLQ73uZxTwrfW2vsefzRBYnKQFNvixjN+bfos=;
        b=J/Rm5luHKwag7MCDM0vfaPZyPX72Ubz2Qgh3LQXs3uE8c71Z1tp3ErgymRdOFhRw/l
         gNeGx0LDP3OSkbTxWOOqcvhsuzAd3LzpVbUgH29lu2okBznh732OZnVNdpKCIbQp/bPN
         ywAsQsJZtI5lLOLPQZ8kzUdc0VP+D3H76JiJmWsm4uLxa3Sf7Hk3re7UIrv3AK8OpEli
         J0pKWjmCVhLDllHLd2l+LHoDPaq4aSVg9urY9cFNpROiKt2dlLrdUmu6cHn0j50TLlaT
         mYlW/GvKqH0XVjq1AV7mw+aJ/V4NQnmb3d3VDrb6EnyIl+NM01DyWrRm/9/2FiL534hL
         d3Vg==
X-Forwarded-Encrypted: i=1; AKwUvByAo9y4m2c+cuYCScBk6c4fA6J1v+ePPnlQNczCdixzIsB0AS71wpPSGNLxQ6vY0GqMLcTrqPA=@vger.kernel.org
X-Gm-Message-State: AFuF++kRUZjfjrCzeP0UReeih11nnUfyFbbtp4Ou5CA7SwFFoPn+ZuiG
	YuRdsjO/hYUqjAe0uN9ccU4d5tuzCb2QnXzwz37lXvcCXierMsovu1ZlVgKUGmfJzEft5UIPASq
	2x40U5RVUD9NBlb9s/olJphkSrtVS6eDnT6+HpIdSzUcoM7PN2++nKZEHEw==
X-Gm-Gg: AYBFou3aHC2pN0MkEWLny858eshyy2ddHPXhymK+pw/2S4YJ/e1AchiwGlUgujjrRKa
	ZIUC+aY4+UHmIPcnGfx0V/kdg8LW51gJTGFyllYXtFQnHQo04DGf0huZqZhTJ9lTF9JwPgPIh+q
	f5Ssszi+3kw+Sp333ePNre3OEj1QAWYa6+KYPVu11xdMLmIHBi2hPeF10BfOxEnzY7TpzkHJHm2
	brAyR//Tn9xuHtPEfH5Alj0Tu+EUMn1g9o4YmtCV5f/abssd6BOALR7yc2ee7DRm7WHlOvnmjSy
	ZuOweuPS22cIRrHoJzfjq2XGxs+uacNiE4dacz2QTpix+9yk8ULLwgSnwx1/5v/cZYBVDM4nfru
	udTPkmZuEFBu/2g8fGYOOhrOYPalitIiPVaHgmWnweFIpI9j1oT0nUoTeaVUKz/5om5ssquFcQw
	==
X-Received: by 2002:a05:600c:8b8a:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49fe6701f1amr41645595e9.27.1790258536787;
        Thu, 24 Sep 2026 07:02:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8b8a:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49fe6701f1amr41645105e9.27.1790258536267;
        Thu, 24 Sep 2026 07:02:16 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b44db6sm77245595e9.0.2026.09.24.07.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:02:15 -0700 (PDT)
Message-ID: <6c73d85b-55f3-4273-8090-6a7826c70f3e@redhat.com>
Date: Thu, 24 Sep 2026 16:02:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: core: resegment oversized TCP GSO
 skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, keyong.sun@smartx.com, Ilya Maximets <i.maximets@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jason Wang <jasowangio@gmail.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-4-wang.zhan@smartx.com>
 <willemdebruijn.kernel.32be703ea17ab@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.32be703ea17ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 17:37, Willem de Bruijn wrote:
>> @@ -4088,10 +4168,29 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>>   	if (unlikely(!skb))
>>   		goto out_null;
>>   
>> -	if (netif_needs_gso(skb, features)) {
>> +	/*
>> +	 * An oversized skb loses its GSO feature bits and is segmented
>> +	 * down to MSS sized skbs below.  A TCP skb can instead be split
>> +	 * into GSO skbs which do fit the device, so keep the bits and
>> +	 * bound the resegmentation.  The features computed without the
>> +	 * limit checks say whether the device offloads the GSO type at
>> +	 * all.
>> +	 */
>> +	if (skb_is_gso(skb) && skb_is_gso_tcp(skb) && !skb->encapsulation &&
>> +	    !gso_within_device_limits(skb, dev)) {
>> +		netdev_features_t offload = __netif_skb_features(skb, false);
>> +
>> +		resegment_max_segs =
>> +			skb_gso_resegment_max_segs(skb, dev, offload);
>> +		if (resegment_max_segs)
>> +			features = offload;
>> +	}
>> +
> 
> This is a lot to put in the hot path for a rare use case. 

+1

> Consider how to make this less expensive.
I think that performing all the resegs check only in the

	netif_needs_gso(skb, features)

case would address this concern.

/P

