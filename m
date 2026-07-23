Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33742B326
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799552; cv=none; b=ijuDpJViyMiaLy48bBneabkSeGD/8CUgGiQEzsDTlxUv3CCpR5Qi34unI1cXnb0K6CmXp5/VGBvwot8aXm0Vj8efsb1FEQZsvPL2uWYsikJOIIvzWWQaVvv32lLw4JoB2f15wYB8DVD3wIvHoBOETKIQe+7psfPgVzBLWuIlNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799552; c=relaxed/simple;
	bh=OZk86Nuk8QhbqXeqWRzYzNHQIe/fONDTO1JMIin17us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eu0Pr8+JCd0uostl1gI0j+GdDzSR8u/2riLgUUtKlnNQu+rB9yDncRwF5eOromNYkbebBoULgdSxQguXlAgbuF2XK9XghLSXMY9F4xOGW0rfQgLVsj6SzrrQoAl+dh0sqx/m2rLIFHcbWWqOoeHSpL6Divc8u01Y2rmav8Wn6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3M3ilpi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnMWbCZs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3M3ilpi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnMWbCZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784799549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8L9jKqKY3esq3XP/zkPIB6l+yUZzZQXNNleYISjsJQ=;
	b=Y3M3ilpifscZhMtPYbty+6jXECs0k3a81bL6nqNpZEdWjvLWaRjmjbn0vOZf7hTtFe16uP
	M1nb8Dl+XxSFagaiVBsrEcG5V7MlAsyATNMDKYPFJ31NWKpuN3kqVOscA4LV4OAnTTtcJw
	mTVDmZ3mX4IX28vxF2OTIrP9yk7Ny0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-o88ApSMsP5Gef0Lt0-o7Ng-1; Thu, 23 Jul 2026 05:39:05 -0400
X-MC-Unique: o88ApSMsP5Gef0Lt0-o7Ng-1
X-Mimecast-MFC-AGG-ID: o88ApSMsP5Gef0Lt0-o7Ng_1784799544
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f8158485eso454215f8f.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784799544; x=1785404344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8L9jKqKY3esq3XP/zkPIB6l+yUZzZQXNNleYISjsJQ=;
        b=MnMWbCZsBlyG8AMKj3sabRJQx11TZHMt05EfsbLrLru9T2uxIrXr9iMQtxAiOTd73B
         EikmzV5bujs5NhRaDHE3bcOgNZH5MCFuwZ2UJnGqqs26dfn2gFKLHFXjE210TENpQyEN
         lKFHHo4BoqlX8o9H3J8JeaCJTLJLidBVhBmBURjzgmRvP1N+Wnn6dTlaozUqJ8IaCGRB
         6QoEZdkmOd94JHA8dUfs9L5d3u+330z1KQcBvrFvvd29JIOBXN28tXuiyNiEAdRA19D1
         blvVP2bps8ALIL9kN/oUyXb7FM6xKjVJ6H0Y914xIrCbeGttdXMEs6CJh9b7Ukdh6AI3
         YxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799544; x=1785404344;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8L9jKqKY3esq3XP/zkPIB6l+yUZzZQXNNleYISjsJQ=;
        b=YL8EOyKP3EI8Jn9a6NzpeOiksKZfp5TUxe/YfY/LSbF0kpd/U77OAfdE/4WdmIjsrg
         +wSDLlMieQEaygGf0OJSZKDO1F6ScRxZ24HD59m52B7FDgmffczFTPPzTRRWXP5YFaTG
         DIxw2nbdb0Fd68hHpyHKkiTWXA1/mrYE8HdDyAu3PL8teGtX7CbiTj0rkHMGBHwhHYLU
         tHITshIA3R04zaNzvAX/LoY6bO0bth2Ma4bchEMYaJDhSVekDa3h7iK9hLmojK/7X+K1
         5TLF62AloPurq7AEpUMCqFgE6dXUFKGPzH+XVOwcBQN6vpf1RNlBd/eRmMY1qkZzKkcI
         zKcQ==
X-Gm-Message-State: AOJu0Yyp2ML08SjaLPWmIGlSYNzyNmIiP1uLH1jUO5BMM8+UcW5c5bkg
	NWDQ+hx8KibgJpClTp9D+nH/afclhbtvoX6uZ2l+TZ93kIvhewv1VtszmokaOK2TAMRtQ1G3XR9
	RGiMdWCoxrZB8GrKmvFGGZnrgdBcepU3ReTpPqFQISeCaW4bdv6z50atkYQ==
X-Gm-Gg: AR+sD11iZxDBZViFrnE1Dto6zRamWuOsDUh+mB2qoa0Z179DZMV1PLF2WRAPc3fNZ6F
	F46CSWuqVASgC2M/Di5lEBkNcPThDHdEMeZM0UhsK7r4it65V2j71TbYmDS9CSRgGL0Nm0OSjjB
	Z2h0iSFjuPz+xZNfFbRLSDs9lEbKC6351uKCb6hNJoWY+iDwBkaF/ykMaHRJ8I6bDi6y6WUxzEL
	n8s15ov4NiCHLT63pIHPZWVorlGUm2qmlj0nBUow9m8U1SKQfSjfJWMQafe6toKqFmmOtbSXRq8
	xIVtyXMU8dJ9tvxokhK/yOWDGo5/o+Fn+hyKjuhV/bUp/sUl9Qgo4PWPTnsbj8kNxV7srD8U4+o
	yTFpql5LT2SVMFhMVuQbqs8ltCTUpgegJ9NLUgJS709IQc6LSf0+dIfRhLnHjmwRTewi+oLkYN6
	Xm3g==
X-Received: by 2002:a05:600c:5656:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-49573ccf784mr17578945e9.16.1784799543693;
        Thu, 23 Jul 2026 02:39:03 -0700 (PDT)
X-Received: by 2002:a05:600c:5656:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-49573ccf784mr17578705e9.16.1784799543249;
        Thu, 23 Jul 2026 02:39:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5c4sm13460775f8f.8.2026.07.23.02.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:39:02 -0700 (PDT)
Message-ID: <7f8950cf-701a-495c-816c-b26fba328d83@redhat.com>
Date: Thu, 23 Jul 2026 11:39:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/15] bnxt_en: Add kTLS TX offload support
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 8:49 PM, Michael Chan wrote:
> This patchset adds kTLS offload support for TX direction.  A number
> of new files are added:
> 
> bnxt_mpc.[ch] handle midpath channels (MPCs) used to offload kTLS
> connections to the chip's crypto blocks without going through FW.
> 
> bnxt_crypto.[ch] handle the crypto interface and resources.
> 
> bnxt_ktls.[ch] handle kTLS offload.
> 
> A new CONFIG_BNXT_TLS is added to enable all of the above.  The first 6
> patches add the MPC logic including resource accounting and reservations.
> The next 5 patches add the crypto logic to handle the crypto resources
> and to send/receive control data using the MPCs.  The last 4 patches
> add kTLS offload for the TX direction.
> 
> There will be a follow-on patchset to make the TX offload more complete
> and to add the RX direction offload.
> 
> v4:
> Fix kerneldoc prototype warning and uninitialized variable warnings reported
> by Jakub.
> 
> Fix most valid Sashiko reported issues.
Sashiko has still quite a bit to say on the series:

https://sashiko.dev/#/patchset/20260710042400.3996847-1-michael.chan%40broadcom.com

AFAICS genini feedback is a superset of nipa.

At least the cacheline consideration on patch 14 looks real. Bitfields
are usually not the preferred choice for fast-path, but in this case
could help.

Also the quite convoluted refcount/bit testing locking schema seams to
foul the LLMs and is IMHO indeed hard to follow. Any chance to replace
it with plain lock/spinlock?

Finally but likely the most important point, the expectation is for you
to address sashiko feedback alike any normal review feedback; you could
debate it or you could address it, a reply on the ML is expected in both
cases.

Thanks,

Paolo

