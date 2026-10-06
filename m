Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787B2BEC45
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248058; cv=pass; b=KauYP7342qCNOllOfZ82PCt+LR9JCAdXniufQdAXdoEp8XHDgOB+XA8BtBzhotOryKGGADqVGLr9m0V/Rz1kz+hgXxBQul9c1JCCNWlxXObdOuPI/A01wIHC+wBCRudyNLYVSBtX8RhYIjt3lgn/mzWQqU/hhtxIGHdnVm8KhFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248058; c=relaxed/simple;
	bh=WlUUULkXecDA3FrqNMgGGTCq58pBRHG2vpFkFbVh+ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP16qWsuPDCTKdl489rNC1GvZEylcA+89uNGNVzhliSLENEZBcg853VlZ3+sCcXcYSPeHV2m0mkN8rGnykSdNpuS75ZVV2F23k/lebhppLnmhzTs+V2L+gzLT+d39XEzmPuaB6kVTi6k5wONzNnMrjGEhgSBLi5N+Gz0QjEAmCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwETqH9c; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwETqH9c"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a6124046f0so24155851fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 17:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791248055; cv=none;
        d=google.com; s=arc-20260327;
        b=PL6aCNoWcO5cd9Dnkg12m/D0oT7QuDZY6iSnRGUmC+sW1ziI+lXjtmIZAMtMDSnTW1
         4LtGMxmoVn078XDxN5kApopx6tjQaZkxdINVPAlrob7I+LxJ7TvO+lyCJsue3xq2KDjz
         HXWgNOuxAUbMGuWVicOg/3+jiTtbP1wrlmXm/YIDn+kQuZVobdWvgpxi07dSLkSJExbv
         DH/AItP04KbgIRfVQureYB9n9VJZPlrHpwPoBCS9EEM5aYfTxtnGPuKvMAo4iT1kvoQM
         80JDafD1HoHWKNq6B09RUtR+sJVJhlP5aoKJRtofkkIuNwUklY61C3vgYsZQrU8oHA62
         9y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        fh=yhOAX79qNlEZg2Tpp+aw92p994hznf7CGs68HyscHBY=;
        b=F9rErROdIMONny+gGO5czAjN3XPTat1Q2xhC3AhOYLjl3jr+4rUZYODGfs7Z16nqgR
         Ba4tvovfl17LILdIZHcZT2CuBsdlGyo8gCY8sDRFNXcQGDQQOQvdxWU+9EIYpM+xRQ5E
         KB+zOfl1LsgkkI8fvOqFlOptWPlH4Z1CDkHhtbtt4qu98VpzWWgwez7shjnIAhoujfJi
         C1QRSH4JlYCX+KoS2XVahtIeKsN4V1v8pprp2oNG+fej3FaacL3Sj1A2Vvn2isHu8ptm
         7bIdVvMqNeL9p0Z7eebNo+1OtGj0ZieMYVY00YAHh0GuXC53Tuyj0tX9b/79jTYqG9U+
         nnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791248055; x=1791852855; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        b=fwETqH9cxxal0fJoOC1pqQuaG+wbRKB5K553A9Fkx3ZoWA8SwJ1hDrPM+4fb8QJB7o
         4uNMGAZFjR+vPB6KRJAuURlA76KVw+IkwbddHQLJtv7Q6kn/0jT2oo4d2WaWUsxtfb1g
         gB1WgFAD+ARVT6SNvae4SOND8I9R4iEc5IwKtgXwPAN4nbqv7D/ojylJAKeGEY3F8XPU
         SfaOK7Vstxy6/Z3o6VvOG0ssIH5Cyyhu03PRzDYyinx/wXqWldkzoXhXpgT+7qa45epP
         No/XJS2lLa+Kh0ZQPg8Z1Q0XKZCWF+ODEQeT20C4jlRLjABHtUdtf5HHbWHTBqkQA92Y
         FjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791248055; x=1791852855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        b=RhhOpxXsxioytQh6kQuY/Op6dzpcKsIyCwTgfOL8v3DzbrglDnPK3bfVe3B9FtZHSc
         4oDXVCrJm3SgZponn/DDuuvuDQ7S1+U5dYvx2sn4WTpp+6F+1Qwbpog0oETx9jGQy0xh
         Nmb6oLxVy/lV8vNdNFUWYGRw1jdSaY6ZGHkdDpM5LtMJISoJBY+X9u6Rwkww9SZl2cKj
         VDrk73X6ErWEXUFIIX1/SHd21KFF66pZMkGY/FccvCcEKeeIU66Qh4DRN83mFIYUdV5X
         aVSamWh9UX4i12rMOSfpjKyzptY05xAePjdGi3/ZwFzZvCytMNIVa2+aPpGhe5CLjv06
         dUGg==
X-Forwarded-Encrypted: i=1; AKwUvBz6BiB9JCsJaInRkNpqspVhJyJR8n/yv62pYPQ7nYChKjReaG5bDRkh6LYLUNdHhB6yCnXWcWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGkR53hQgKxMsJJHAMsNvVLJknPuMQLpFSvFvUx35kxEwVPCUG
	h55xxBwdzR8+KWz+2yuJvn0z3q/xJT4CXQoO79thlzOJV2/sU4+O0xCVjmXqWeOY/THpXY0s3nu
	71nlZ4ia2Y6Ef9cMFMfpWJ4OE+yvK9AI=
X-Gm-Gg: AYBFou17WW7B+oSDAS4zVFHMQUGYGUJVTKTD0HfQP9BfyoL+8gVvdWd3j8gJ7BqX7gc
	t20p75wkXbwBnGaKwFniJDmoGM3TEwz5RiKS0olwscTxD6lqdk9U+UXJONnq9j/g+sJIiZON/M6
	2ly3yc5UKmPecYT3AtIXx4V+KSs2q5canBSX4i3wLnvluaf6OvSc4A/tgYrSMa1ib54r+BRmkdJ
	tiZIJnRJYK8m5a364UlDmsLMNpywtbIV7djVbFA/EQ6bOEINY76dj2iUAJYAV1y4AxNgzerE18j
	6zvQAWibYsZPwGvPEIplyhD+3ByNbsPuJ4pFa0h/OEi78wniPoqPLemQZp3ISNehvKY+nbuKWzu
	/0uXuOJ3AhmHO
X-Received: by 2002:a05:6512:8345:b0:5b8:e716:64e3 with SMTP id
 2adb3069b0e04-5bb9bb05b58mr2911017e87.31.1791248054559; Mon, 05 Oct 2026
 17:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924011554.3494-1-sigefriedhyy@gmail.com> <20260924011554.3494-3-sigefriedhyy@gmail.com>
 <6541b309-4e1f-462b-a867-57b67bba1b94@6wind.com> <CA+7S2vL-6m4RACthX==UVhVw7N4xRc73EbwMJHLXTY+=Px=z_A@mail.gmail.com>
In-Reply-To: <CA+7S2vL-6m4RACthX==UVhVw7N4xRc73EbwMJHLXTY+=Px=z_A@mail.gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 6 Oct 2026 09:54:04 +0900
X-Gm-Features: AclHuK8fWL_vlv3-mm3wzWj5P4aeBqPD8cwdje1eUbLrdaL3n_CnWcUcb1-y-B0
Message-ID: <CA+7S2vLwtrKyMcZ4YkKTetnn4bMrg=BP6sjYa_R8pbROhTGrRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: add a generation counter for dev->mc changes
To: nicolas.dichtel@6wind.com
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > + dev->rx_mode_addr_cache.owner = dev;
>
> There's no need to set this?

No, only dev->mc is looked at. It was set for all the lists of a device
after Nicolas's comment on v7:

```
  There are several lists owned by a device (dev->dev_addrs, dev->uc,
  dev->mc, dev->rx_mode_addr_cache), the name 'owner' does not reflect
  that it is set only when the list is dev->mc.
  I wonder if the name should be changed or if __hw_addr_init() should
  be updated to always set owner when the list is owned by a device.
```

v10 takes the other option: the field becomes mc_dev, set for dev->mc
only.
