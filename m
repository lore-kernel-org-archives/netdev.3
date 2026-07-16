Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8A3F44DB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195296; cv=none; b=enHxFW4/K0FnI1g/4vRETJxPSyXoRhAzlhkumdXu7WYfWLY1WrebgRxvs/npFj6NJLDnaxyr6FyS1S1Pxlj+xHcEFoJidd7Tlkx/6cNNsHraKrXGZbfzP4njAt9GzVj2vKdLh1BIpyJQKoaUPr1rXQkhPDO3RSFThBpzI7TcVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195296; c=relaxed/simple;
	bh=Js4qTvCyyBXGSFv7kyXRMakh0kp6EOFSGyB6oeTAbHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCgQI8JCIMQ0824rTuMQspeRVyd940BUoutQkBB2m0H1zNsJaVpffUKRBJVhxtEFXsu0d4bnnA8OJ8f4MNBg9qejclY+PzFy3bp/1E1inJ4PBi1xijY+RMjCC6Ad0gPyKQ+Xh+GBs9Nbv+nvdinItD40a0Jj0q1O7oNcRxBjF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Rx1/HAIf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Rx1/HAIf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69af1bc780bso904842a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1784195288; x=1784800088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mdmiKhaUfRjC8X31unm5agm64vh4S/ipc2r8C/nqgyA=;
        b=Rx1/HAIf60WzBw/LqlkJUtBGV/bfaWKHetbR5K0VmgdrsKva7F9epOC7JsSt3nHvKt
         Y73Va62s9fbU3Qb3CSbm7J502Xq5sXDpCDNrS6uL1wxDClIK+hbnUb1tEHha3gDVVcGT
         GGbdoT5hSAl2NBdL3pvsyRY70CUaSKr8uciex8shLJM/V8mTER/g87yH4uDZKBxYnJUP
         Gm5Hm+piUukpo51T6kblQqu2qe+W5h+pkCHL9ZqsyoAVfTqmzvGC6UWvyY5hRwytP3+2
         jOtDpDNZKUMxKhqiUvG19OfrML4vEF6W1yiCObQKCyBh0iuSF5z5Ke+Qnte5kYf+HPKt
         RDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195288; x=1784800088;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mdmiKhaUfRjC8X31unm5agm64vh4S/ipc2r8C/nqgyA=;
        b=Pir0D9c2k458JmVWMyYwO0naoEZIvsY1H6eTHw2xf8wDQporKcPUN0H2jtwcBvoWJY
         YFZg+KPQdZH2/G5i+lkfYBsaFN4pMioaEcEKQe6yGY7Za10Mw7LCCfmvJbZz9Af46nyB
         ntw2HtVfqkExzGE8zyH1wAGj333uTZlURoGd1NuyX7Rh41M0ElC1tLFzVHg0lo8+gYi2
         zABxepFEQKd9rBRAZBFI+boETFdgipMhqiprU3P8ds3lqeqflKNxWGrt9aL3kk1AyNQi
         t+LmwTRQRx+F09FeOosCVk8GLkIee+zHaIVOJS0HdtvBBM0Qqm68op4e6jWt3o81Gvvu
         1TiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgJJDZAWktjviuElpillZtvza11SnOp9vnivBNrQWt2XyyDGJ7gVa3gKkgxrLIVEmWVKE1lMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEe8F+nO+6gV2pWFrRa+gwwrjQQONn+0A5Ux401GR/sFexJpQi
	mmwc95S9ZQJh2vIbKKr05cyAZi/Hox1s4NsO2f7ZvKk6f2/63Dn2qbDlWT3+oJaGE2o=
X-Gm-Gg: AfdE7clDFL4li7PSe5FhtYKR2hArKaG63eMksBlAsDRUg1rUKdff1xYr3HIXYjMdBr4
	wk1dyzvzfnxanASnsaWB0bDYK3asWeFbECPbTUq2U5/AuLPHTsx2iKSYwX3IObW15ASvfxa4EqA
	Nkqa8UNZiO9YgPPE8U+ZA4E69w8+nGp44EuQRaAGZ0pp9U5JtISG4ebAhv3sfY4q689SwFXRpjg
	9m4cS5sfOJ+vRm3hFMidr/HfyDY0qXHr0+u5i+W9kl9iPJWj8HFyZAWWzZ+aDc5Uga4KcTuRSn4
	3hhTh6zYhRjbruCZl83ZS4SH9SHP5n6nc8hj7NgAXMNeu2QLnnevYFHe/Hp/uHrAv5aHLeo4KWP
	tBt86uupXDQn8AeTASOf8wknDYV1pGOZHOVQM5C9nHDN0Gn9bphZKAYqIVmAZsgetQdDVCO4uzh
	sKhnohs2nFUsk85UviFg6iAJvW82IcThldB0w4GJpct3LHzZmo1bjU93elFJF51hHmxg==
X-Received: by 2002:a05:6402:524d:b0:698:b000:204 with SMTP id 4fb4d7f45d1cf-69c5f241a28mr6312999a12.5.1784195288255;
        Thu, 16 Jul 2026 02:48:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e12ccd067sm2431131a12.21.2026.07.16.02.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:48:07 -0700 (PDT)
Message-ID: <be16e8d1-acff-44a3-ac6f-86abe512aede@6wind.com>
Date: Thu, 16 Jul 2026 11:48:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next 1/2] seg6: add support for lookup attribute
 in SRv6 encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Justin Iurman <justin.iurman@6wind.com>,
 Anthony Doeraene <anthony.doeraene@uclouvain.be>
References: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
 <20260712021155.7621-2-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260712021155.7621-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/07/2026 à 04:11, Andrea Mayer a écrit :
> Add support for the new optional "lookup" attribute for seg6 encap
> routes. It selects the FIB table for the post-encap SID route lookup
> and accepts a table number or a table name.
> 
> Examples:
> 
>   # SID route installed in the underlay table 500
>   ip -6 route add fc00::100/128 via fd00::1 dev veth0 table 500
> 
>   # encap route in vrf-100; the first SID is looked up in table 500
>   ip -6 route add cafe::1/128 vrf vrf-100 \
>       encap seg6 mode encap segs fc00::100 lookup 500 dev veth0
> 
>   # or if the SID is already handled by the main table
>   ip -6 route add cafe::1/128 vrf vrf-100 \
>       encap seg6 mode encap segs fc00::100 lookup main dev veth0
> 
> When the attribute is omitted, the post-encap SID route lookup behaves
> as before, using the current routing context (e.g. the tables selected
> according to the routing policy database).
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
