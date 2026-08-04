Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3E4519B8
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848888; cv=none; b=AAFw+H+j1R4q6bDT5IYtVNlGEAbymgAmPBt61nbpjdNagV9nz0yflvoLi4XKP/q+SjRynWaAOyL5M3s1+4knI9rXl0q4wmaJkJw8brDIjcUAJ9UgFGcBg1aezNDa8JsDQEjmuAR/JI9ylozQu9X6DsKoklfn3+LnwVlSiTMBVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848888; c=relaxed/simple;
	bh=VZN95RkofrBhoDS17rpPR01NthOtP67U6pNL7gLlSqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G926dIiLMgSq0IK3G+l6uRWfjY8PIWJsCmIicLdtzGVILF9bfQ5p3GWX45n6ZhL/0KlnBCLukUhvOpO4eYy+yEZz45c/bFqSt9SUfkMM7kbkCMJxJBoNFmfPQ+kgIpa0fEBW8n8k72Tod1n7XYS9NINp67WeoGHjaGsQrZm/vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBtmHnrP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oXXwHE2U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBtmHnrP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oXXwHE2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785848885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
	b=RBtmHnrPvcT/ZHtrZ/T58VHMdAA6Nftj+t5EJFiMRtT2398+sE7WxPU2kSEEhLr/uIlL69
	m3zbjeZKtDwt9XkympgdNRRGA6BZdEOxU82r0J42hu7d0D68X2zeafrIV1fC5J7Ssgfqfq
	xPv11hk6BzFi0PyN1lH1EYbgR2YaSoY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-n_iWaU54MnW10M2yt1eofg-1; Tue, 04 Aug 2026 09:08:04 -0400
X-MC-Unique: n_iWaU54MnW10M2yt1eofg-1
X-Mimecast-MFC-AGG-ID: n_iWaU54MnW10M2yt1eofg_1785848883
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fe85684b9so835376f8f.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785848883; x=1786453683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
        b=oXXwHE2U+wm8/4BgeUKunSTO0H0S547mkHjMyyFqTPHmKrn9wu+T7bf1NDo7ovl2hs
         eydBRSbc/PKZsar3jx/WiggQOV+HTmCpcuF9no0ZDJGZwrrNa5orNNDzDl4Elbc181UJ
         3rg33hvgJsM1NsVAn4bZhqwZ3gdhQKuXIR03RCtta9sE7WDdB8pmpOHqzRhAKcS9gCix
         f39qcQAMZUgiPtLsLKOErfPyhvACe3UA/9ezPw4VNTUfJgN3l7OsWq+Va9TEzrGzSpAh
         tvfggRIr8AfpcmUdkNuyYX5mTtWsVFjF2QPrIzupN9fODPngzqwnLgCdBAWqZgsHePFx
         Ixvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848883; x=1786453683;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Au6oX4MGDxMM7D69D4sBzTxdn67v9QMgjFo5KDy/9E8=;
        b=exTw/Jf3TBs3op1QsudQmvLQAHpmPmo/tR2VqWRb7N1jZXkrX6+aE3Mj1AvBJRlqN2
         DVToL+OAzUAAqBFUZl1lNAIV8FAlO0tLCJi2Fk8xKgHmoZp/XXK7TAg+N0M5bYM5ZQz3
         RQggtRKXtVTFrgGWrZ95zaea2//2g0AVi7T05jjJgTnoKVl0Q0tP8+kl0fdRxUkzjqsL
         DzLcX6DsMcI2+igJcgI8I3iLLr0TYgXwDdleUJ0JITZHp+4V8EzgP+GEMLiPpsZIHBVT
         oyqTVGWZNRCo+7tw6hWjJPsFxsxyaAZ6ifb0e13Ucx2ENHh33zGXuiqZQB0mcgXjy2aq
         SPPg==
X-Forwarded-Encrypted: i=1; AHgh+RqUSmBYi84WjlqzHPqlaqbYN3sugbqHbKvtxU9wlBGaqMUmYlVTml2p+0ChmH52Fk9CenjhvCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxif8atGCxlW0N0cEyJOoqZtrGUGTppIsA1QpfEv5EYih3b3SJk
	3RjPS0cWg5AnjZty3hdZte5HJ/f1C57fuEIkB+kFfyy4v6yiY31JXbCZZZm62VyyMe8oiU+AIm/
	M1tef0Wo1SdtPc9ivXaw5ukMXQePGTQVtVHLARkhri9tMBg0V9M4ElVVN3w==
X-Gm-Gg: AR+sD12ODf1h8gYTxn8+lwv7D90PE4d15mEuDnhailFe1KMvNRXDgmN6VqtpK9K+vsS
	siFWTjKn8QrgtbABbfH5dvfLozNFBXMpYy2iY+UL2iJ161SFb7F5MRo8Py6nDcjdAw8B15RRywx
	knHSR9X0LZjbDCaq1yXifuzM2lO1GK3iX9EPV6XS2aFTiPxAffDnzqQMWFSc1j0dEKTqj3PiqPs
	gkrE1DCN0OB6GZPzhT88R/jlU+oUN7+yVJP/lnXyaWPEsHOXWkUPaefiXVmGiGtkIUjNzlW8azZ
	Rk4rfs9JCU0nwUqsoJEqycha3FHhXpikhrPLIb9GwKM9mnKO+eZPlW0A3AKQItOdNyZ3A8SPoBg
	hCvDF8FSIbxbDi6m0py3UCA1fAqEY0/18ZHad3CM8MxQk8FQ3b5+Z876qHszMOhzxjtJoW/NXaP
	0=
X-Received: by 2002:a05:6000:60a:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-47fd706349cmr39912175f8f.0.1785848883064;
        Tue, 04 Aug 2026 06:08:03 -0700 (PDT)
X-Received: by 2002:a05:6000:60a:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-47fd706349cmr39912042f8f.0.1785848882595;
        Tue, 04 Aug 2026 06:08:02 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm42401998f8f.30.2026.08.04.06.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:08:02 -0700 (PDT)
Message-ID: <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
Date: Tue, 4 Aug 2026 15:08:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
 <5248054.31r3eYUQgx@sven-desktop>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5248054.31r3eYUQgx@sven-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 12:38 PM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 12:19:13 CEST Paolo Abeni wrote:
>> On 7/28/26 3:39 PM, Simon Wunderlich wrote:
>>> Dear net maintainers,
>>>
>>> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
>>
>> Note that it's preferred to avoid fixes and stable tags for changes
>> targeting the net-next tree. If the fixes are really minor, both could
>> possibly safely dropped. If there is some real problem behind, such
>> changes should instead target the net tree.
>>
>> Can you easily rebase your tree and adjust the PR vs the above?
> 
> I have a different statement from Linus:
> https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u
> 
> This is why we started to not send out net.git fixes PRs for things which 
> aren't highly critical or for Linus' "just merged for this release commits"  
> late in the development process.
I actually think netdev preference is consistent with Linus'ask: move
the "fixlet" to net-next.

The additional twist is the ask to drop the stable and fixes tag
(otherwise stable will be flooded, too).

PR are a bit apart from plain series, hence my initial questions WRT how
problematic would be stripping such tags and how impactful are actually
the things addressed in the first 6 patches.

/P

