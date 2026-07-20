Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321783BADB5
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538895; cv=none; b=ruWB/rO+T/LMjocffoOtDmYOEcHErzX6Ufx9mLqi/OZe8ZiNOHDqKipCKhZ9MgnXrgTBGDwGmX7ky0oqGsZh8zJMBHg4XQ1nt0TYs3BC5/RcmkjGVo8fIS4JjC7WdYLMvbo3fnVyCUyMnkC5iLdXzXFpGJdR8QTJCSH+0XyqRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538895; c=relaxed/simple;
	bh=n0cYgeO7AYelPNLANCH9y/hwheUejDo61R1XtpNA9/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4rpO0PAXq4G/is6cKNzXxDJXwQAZ5gOYqx8WcvTPLitTRCuPtXeIi8KwAY7lvpuI3HDV2Y0J8OyTrj0+OPI77cs+Fa7w7ez7qkXFSNYZ8tndlf+nn8KHwY7s6yE+9NpVCRL40Fj5revT4feQdYukNcKgrdBX9hvuEUjTZPT2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KzDO169s; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KzDO169s"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so8931171f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784538892; x=1785143692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qYe/cwTmtSYCyBAS9PJyu1+mCd/R/Mo9vdMOvvfakiE=;
        b=KzDO169sEfwOeytGE1Ra47AQfDmFXaFzf2h2IVGppYlddMIQJ1aZzwL+jewQnlHNLB
         x/8cg9qW3T0Pag4yrQNoHKuzorgonA/hn072Ni/n/ZbW0gLrDritj3pzt5Sq/w2Lzl4Z
         fFdJNnPEnkM8BQsNeSouSFo51CvREeiug2l8GuXSg5rh3+fEGEvp8Pmo+KaSQ9q4sSI0
         1fsg7MA66yk5Zbmfyim9GEKOabt6GcZGZT9QyKZYQreg7/syAULum9hIHujUUBTFygWv
         0HpYNdyNxxT3W4GqK02YrNsM4Y/6yfI40QqtpW0zo3rYppv2EF5UJI170RyagXZxLOis
         OyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538892; x=1785143692;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYe/cwTmtSYCyBAS9PJyu1+mCd/R/Mo9vdMOvvfakiE=;
        b=TkWFYZye/zQH+mM/mDaXRPlePDrGJmeOTCqi2u6fmEBkIWRv6TlD+QSZpRkFj6UyTu
         gFPO/pLRHodqt2oF9BhM0rdmtsf9BxUIM4PMd/y4hTeUrG79VrpG0YrB3045hqf24+k0
         cfLfYs6icWCItznQQd4NPzO5Ap7hGDrz16X2qCkxDctr3LrFlwLiS8sF5/BdVgfrFJ2T
         5TJmtkXpibhNwvFM3PdRb4BiQtdAcgjgrZ11wP9SxUVvM5ZQi509ff/vOHd0hcnGhnhV
         h1ikgxsrawrQFsJlQODAf0J/p0LqVpA40StP2k1TIx9MCbGz8kgR0qGxRisQQ1VCX9fp
         AKmA==
X-Forwarded-Encrypted: i=1; AHgh+Rr79Ho2H+KohYE4azBqYDK/++6KDoOAV9q/jqcEGxYTSA4Hgpjgfos9lU57vk4m4Bt1C+XEzG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVd4xlu3O2lUu2QW1h9xVKwJH4daOf2mtwLPswS97HDRD47/En
	7oRay78cA+JCK/kq2ojphGY7NadVI2TpWZyrm5Xyu/8vBvEqxPJqPkULBcozBGHltbo=
X-Gm-Gg: AfdE7cmpjIJiPm4nt7Xd+ugib6q0SQEVGJwje3Ik7vHeUI52kCuEimyJRKYiD0erfLM
	52rdfzNkC7iTZVQt0thKIhi9FoWVl69Z3556HfYkdu0g5Fb5u01MgbmvY7b8/Ts+h3R8Eb2qFm5
	Wlds6iGi8RfW7sxLH2IkHAZ1e8/aQDava62FtdNmOYhiqIiqvFOPG/9ARxLHxVj0dPegi/pZr9l
	vhon1vxX1D/0i01aniVk8MuP6PAI/g+DRL1vOVRHos4QgXrEXGMnbQabaVfKg1p3dq3Tm+1bmbc
	7xZJJFHrVadtXV1az/CpLL0JbXRvMbx6eZ1taeWJQ3yuYf/z83x5HERMum3RSS9oANFXckc91vc
	Co10YXEh8qJOqWRB43KWKZCjoMkKxOBIi+0Dc2iOTiH58UyaXGZHHx/2hlOCKFG3QnfDqeoL3Gs
	QrROlZID5Y0hSIJcD9tX4R4ipz3KRAEUwA
X-Received: by 2002:a05:6000:4b01:b0:47d:ee9d:90c8 with SMTP id ffacd0b85a97d-47f6230659bmr16136823f8f.3.1784538892521;
        Mon, 20 Jul 2026 02:14:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm29580156f8f.21.2026.07.20.02.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:14:51 -0700 (PDT)
Message-ID: <78f42aa0-70fe-475a-ab2b-eff062a629db@blackwall.org>
Date: Mon, 20 Jul 2026 12:14:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] bridge: Validate NS/NA messages using
 ndisc_check_ns_na()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <63efa708b4b0bd9edb3a6f6a521cb5022c43aaa5.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <63efa708b4b0bd9edb3a6f6a521cb5022c43aaa5.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> The bridge performs neighbor suppression by snooping NS/NA messages, but
> previously only checked the ICMPv6 type and code. This leaves it open to
> acting on malformed or spoofed packets that any RFC-compliant node should
> reject.
> 
> Wire br_is_nd_neigh_msg() into the new ndisc_check_ns_na() helper, which
> enforces the full RFC 4861 section 7.1.1/7.1.2 receive validation:
> hop limit of 255, valid checksum, correct code, and type-specific rules
> (NS target not multicast; NA solicited flag clear for multicast
> destinations).
> 
> MLD messages are already validated by ipv6_mc_check_mld() before the
> bridge acts on them; this brings NS/NA to the same standard.
> 
> As a side effect, the skb parameter of br_is_nd_neigh_msg() changes from
> const to non-const, since ndisc_check_ns_na() may reallocate the skb head
> via pskb_may_pull() and sets the transport header. The returned pointer is
> now derived from skb_transport_header() rather than a direct cast.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 11 ++++-------
>   net/bridge/br_private.h      |  2 +-
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

