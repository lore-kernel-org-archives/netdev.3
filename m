Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275779;
	b=S9JT23bqiFUjLvFGA18qU485yUEejSSvBzMO74rjbh9WvaKA0lLuCyhedPhWm7+uLC1U
	 McM+kaVnm9/w/9bPxiohXP4dNNZkT3Tg13ZBCbtDfV994zVFJawYe+l8HbzUXiReKnYNz
	 cjkgAPiBSkdOG7bQT58QYyqjq3vE2Ih93aqejIv2AJ+30PpBK2C1FTRrmTuNRP2IZTCGP
	 Kf8nsCzXtnD+SU6XuhiiUTmESOaxJievjmBlgGiZLuDCnGRxdaSraM+KmldT2kaLmM5t6
	 iMBzZsGbkMb2DJW+0aInIV8zMLOdoKarTBetaE65rlA31AebJWOZwpUtsWN7jOELN4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275779;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/MiKP9fyeCAaFA13wlpLP5Q9RvZIGZFi3hjz454dnr8=;
	b=lZi/SZjwnraNjskQcwmmrpM05m7L4E0iph6f+1u5c7zZTHS0Cz6yShsu4BbPJY7WIyRx
	 1s7xF2Mod4DWbFrPv1J2zsDYp1YpvptCx+KB+fhfl8/ontVlasLb+QjsUkFjIlBDBHg5w
	 QkOzxBjOjacRVvpTi8SsHJ7CxDCYn1gYAbE7XaaPNJPCs4GrFJa6DFx9OyQuB5hapl4Id
	 5S4XuFT7hfg8bsg4zhP/xyVl2EwIyld9A1geeJ6sibZ71GhKEGRRwQe/29ZKn3nxpFqH2
	 LgMmpWs86sRl9YZL6bgwSqn8IlgbMsWJYyFX3R0C1IMR0zRMArMfpW0CtUltzNIcTgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5jlBlxs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VzPi2lyC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E0606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5jlBlxs;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VzPi2lyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793275777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MiKP9fyeCAaFA13wlpLP5Q9RvZIGZFi3hjz454dnr8=;
	b=N5jlBlxsn3C3dntKNHpktZZKy1nTyLpmBQFr86ZjVjlv747jjjcUfYtPLFWAdv6xK2vshv
	vy73OY0g34JjSfrGH1keHmWvdX8wucFSGLwmbNBjZ0uKQYcPCKztksEt6VN9qgfzemiR9V
	ZCffb2S5VX7HS5/SqWfNMvgvfscsCIo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-U5b-8odkM2qR-1-tlQZGlw-1; Thu, 29 Oct 2026 08:09:36 -0400
X-MC-Unique: U5b-8odkM2qR-1-tlQZGlw-1
X-Mimecast-MFC-AGG-ID: U5b-8odkM2qR-1-tlQZGlw_1793275775
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso21420935e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793275775; x=1793880575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MiKP9fyeCAaFA13wlpLP5Q9RvZIGZFi3hjz454dnr8=;
        b=VzPi2lyC1gDfVNKIkL7/03RCEGjlS0zUU4zgmxAT61ShYkZ5/2DEQsTNv/1NEasox5
         zUYkHqFQywwQ0EhHsL81xDuCjpl8qrL6e//KxpvtQntsZ4xbIVBSqcAnXSFgOMCDH5zr
         tJ2y+PE9r57UwoNu/REswSMMlYFxNoCyjwCuG5oQEIWQrZbx+s6ekFA4OcXbaXibI/Ue
         7gW7A6FvPknaWZr9T+9TfySlxRjIeUaC6ddat8s3CT4hHc2gP07thYUhsEzBJT/OzklO
         5WWKzbmzzLn7a5KpMFAJiP0A9l99v+9goTAti2UWtI5oqS/loKs5Cr9BDYdaE+MAfgfz
         tuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275775; x=1793880575;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MiKP9fyeCAaFA13wlpLP5Q9RvZIGZFi3hjz454dnr8=;
        b=ROu9yl8Nc4NLWY+q7/oOXd3JXDAeVan7g1KIuWRuf4Y1Zx69zZmij21AmhIZX8yUEL
         BUTalhubqgLSho6Zot95lz+PGbwsHMURlRtPyW18m23R53SEXFFd0ioeMP24AXhfk43h
         TV0BdXsX764fSu/TBcUVQj/D8EPV88lVC7pXXhX8Km9Mp5Q4yrsqpJJOoDrk6Ox9qgto
         BScL33ZgGCtCfCNCXPneYSqH+jlNG0aNn1y7xr0ljG+Vw9/0E2bMT0Ge/+D5gzXjslW6
         itI8SNw+B3dz8DgScCF46LDKKx0fEBEid0gR1qpyKSk0CqiQUyN/eMh757VU463YcENH
         Wmyw==
X-Forwarded-Encrypted: i=1; AKwUvBxdTu6Di2FJXqjvW6pouu2jka+4K2ytmbVVMYPI028OFG0mIzpVdX0jH53xX61d+sfkDpwFGys=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgCPUX8XfoNXxQ44z6yQ+VSzqLxgzL3sw8S+VZ0E17n0G9Ol84
	8IIXBIBHo41jkA0CggMcxfq+2VwUTSzhnfz2+K306e7NbsQi3sef5+E8QhFM9srXWSiXDMUGMut
	f6ur7t4HqX7z8uvT61hseqN02s/8R8ufubVLVtYmmbnY3vEzQmGmLONVJGA==
X-Gm-Gg: AYBFou14N5A5whiLJmS3BVc0as+v2SDoU8LL946Hdoh6/YW1C4e1xRemg83wEQTdHHx
	A54g40zM8DYjtgrWO6u0HjdAvGsnU5eTWuDSkxmR9t1uXYAZuqzUa7m+wRmuXIrr3jSP38HsvVM
	LvzxvaEQ8PCsI0Yps2pkDJvZZ1P4lwVFnWheD3sv3CKAQuiDcIphG36L/0M3yh/necqInywWxUd
	CtQzXi+oBTcGiRMczo/1B45s94UrfE7Kj4hWvaAZeHqGQligj/2IEClk6lHLOFnQt9Qlj4Ek8Iq
	5apyfL5piztX+fkgEOWv6yUFDAcD0neM2nYKcqENI3KQU0N9Tz/D5R4B9xhKDqUf0xDIxLGohpf
	OdDW4To6MVUqRWXjkgyHuO561xKMVy7Kw4yC4MH2oxh4M42362VZMklitJpls+fOVhg5hDyLHqG
	M3AuNHFsGQ0qaWrQTtqJP+Lr0o8vtHxqRejDr06s3RwFYxvvw=
X-Received: by 2002:a05:600c:4e01:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a967ca03demr123795495e9.35.1793275774937;
        Thu, 29 Oct 2026 05:09:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4e01:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a967ca03demr123794855e9.35.1793275774447;
        Thu, 29 Oct 2026 05:09:34 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm28654975e9.15.2026.10.29.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 05:09:34 -0700 (PDT)
Message-ID: <d2cadc0f-f52f-4a89-99f5-4a5fb621e944@redhat.com>
Date: Thu, 29 Oct 2026 13:09:32 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: bound temporary address regeneration advance
To: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 alexhenrie24@gmail.com
References: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/26 09:22, Yingjie Wang wrote:
> @@ -1394,6 +1405,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>   	struct ifa6_config cfg;
>   	long max_desync_factor;
>   	struct in6_addr addr;
> +	u64 min_preferred_lft;

Minor nit: please fix the variable declaration order above.

>   	int ret = 0;
>   
>   	write_lock_bh(&idev->lock);
> @@ -1430,9 +1442,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>   	 * idev->desync_factor if it's larger
>   	 */
>   	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
> -	max_desync_factor = min_t(long,
> -				  READ_ONCE(idev->cnf.max_desync_factor),
> -				  cnf_temp_preferred_lft - regen_advance);
> +	max_desync_factor = 0;
> +	if (cnf_temp_preferred_lft > 0 &&
> +	    regen_advance < cnf_temp_preferred_lft)
> +		max_desync_factor =
> +			min_t(long,
> +			      READ_ONCE(idev->cnf.max_desync_factor),
> +			      cnf_temp_preferred_lft - regen_advance);

The above is quite ugly, you can probably make the statement more
palatable using some additional variable to store the intermediate
values.

/P

