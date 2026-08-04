Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861043FD11
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855008; cv=none; b=dM85hT1ogfxX3Y2JW7PGo3JpZhjyXwqtPZ4doDXwdb6vzSfYVa/DEP2SGyf0zHw61n69PYHtr0U+qq1yGwD2Jh6rZbjh9mVRgi9Q70MrOlOfT8uHsQUs0dJxEa3kBs0eqUszCZLT82an9IsOQjcHY964EJXHt97sF2J7ye6Pwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855008; c=relaxed/simple;
	bh=gqPCJwNk1+lfMV2dt9/GSiSzz3eomKWxhZ66tnw3U8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxnp7SisyvjAWZF/sAjVzJ0kdCgv+QXEswVtxjW3N6SFp9l3JCqJzEYM/OX378slHJtw8n9M8uGM3mCLjqMrYCk1ZJT6iGaLE1ez4w26b/oMX0UBXD8DEJcCO6Fdj2ymCKl1oB3lrkKPNYPk7kCMwaJucdOwC7MLOP7rPvht8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Uux1Z2YV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Uux1Z2YV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f5d5dbf80so273905f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1785855004; x=1786459804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+cEHIVakSLT1mPOIXcjrTOODhL8FI9shkgRG7uYO/jc=;
        b=Uux1Z2YVmPjyd6IbXqXc0xUjUCKZIpgifnm3EXosQ9MJblYq5HvEP334M8w3PaWzOe
         fmF6tXNBImt2qjY+e4twKYnazDVJ/NDxbjAveisKhN0uIpDQOvReE4gKJYrYbKS9Q2Um
         idm4h5LL4iA5ZIqC8rcFOnIKrNyMqExhG/Tsdb3bYx/PFX7qVXWgAL2mAQj5SMRC25LS
         DjmiDxf0kST4W+ZQG0UwRooikKEAmiMKZ1mCW5Btcaqr4WiKMFouZ3bVRfXmA0R63r8C
         GlcTcwlo1BlcgQWAM5R9E8Us3JPO2oxBtKCFurJweZeBE0bYiiEtppYi+6lxufavVtkK
         FeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855004; x=1786459804;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+cEHIVakSLT1mPOIXcjrTOODhL8FI9shkgRG7uYO/jc=;
        b=fwaI6Ebk7ROEt2A12G+UqqKiRGtSlGddixHtj6RENgmed6zU1YRXYXw9rQzTBcbZyh
         GZxo0BMzPql2vzECHRIQJjNmZYAizR/V9Jp14cSbaB1ndo4gNSn7a5wyQXyUjhmauSwX
         R9UaxTWuhVUSSHZpiLrEvIkGJrI8jYSI7dYgFtPdxCzW3ZgfOPVwUiy5Ih/ZfT0dCvKL
         mBfQL5Z1XzzSuXkhnXAP7LifixKFaSvdLmhLsjLd7aisdZKCh8cj09bF2O3uhlZvntKV
         q47R3tJ0xFjZ45RYSnslEuDjeAoLuTOOuuCW8yhb5WhmP2SgyRsLqEAqiPruVNOkGcNM
         +5xA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+0YsjcyI1g0wamhbtnKVuuGZtiTlfjZXqlU7jlWwnSR2xsC1qt8lRrmwTN+IiM7kjNWPpJ88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFTy6uTevFcJZ73Ne34c4CnjM01Zam6B43meLbHxP8KlrHiet
	2kRZTo+53fZ4lsNHF6tlGOdgZvQCaGKOrYnRC21fbXxuXACiZm/9x+KYg8SnxXV5BIc=
X-Gm-Gg: AR+sD13AfYVuQXM+EGSo0pGnRAoqedNJXx8KS2Eml9R22m1/FYpm4J6LF4utWGo/wDb
	wsLGZDAGvLtw3H1vgaLxnyFdSatZyzXMeeN7qI5LXqCq6Qr2rGn/yQaOaKmyyyyIoZbQpIQ6xmY
	F1cLm0pFLryhPwshj0KmtLSCIp1osrtjPpaC8Qczx3TiwXVTjwQa2MZnwCI4YlBTgmdZNoE8znh
	/5O5q48qgBK+x3zqgj2wTsdvaxLK2AwkFcS54IpQPlzVQSlvDNdSk9yMc2rkJl0K+xXQyl+M5sI
	IbcvhL41aEXFn0C7eSw9OIoxEKNVt5cN+vxzHNfzUBWhcs/Rgjm1k/2dPzABYywy1wlrmmfzmRR
	NDu9TGSsrs9IHPIW9X0r8KBVHBgPaIdD6D/kIvXTcOdhdM2ETuXhwrYMxMphkss0/zQDF5ixiLQ
	V3bSUrdOcUkjaAR90A4pZnvn9Q+WfbFjczWQPXZsI3ry+ZPflshgsWZb01xFtIN4Mun+JXInfml
	2JRvbsFD6EK/Aj6ioTBNxIuvcQ4yhSypSAFVoHjKA==
X-Received: by 2002:a05:6000:41cb:b0:47f:8e4c:8a4c with SMTP id ffacd0b85a97d-47fd7312532mr20496377f8f.4.1785855003616;
        Tue, 04 Aug 2026 07:50:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm198422f8f.20.2026.08.04.07.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:50:03 -0700 (PDT)
Message-ID: <519a06fd-c9aa-425b-a374-607aff0a9140@6wind.com>
Date: Tue, 4 Aug 2026 16:50:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] ipv6: seg6: clear IPv4 control block in End.DT4
To: David Lee <david.lee@trailofbits.com>, andrea.mayer@uniroma2.it,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804094625.715305-1-david.lee@trailofbits.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260804094625.715305-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/08/2026 à 11:46, David Lee a écrit :
> From: Kyle Zeng <kylebot@openai.com>
> 
> The End.DT4 input path decapsulates an IPv4 packet and sends it
> directly to ip_route_input() and dst_input(). It therefore bypasses
> ip_rcv_core(), which normally clears IPCB. The skb still contains
> IP6CB data from the outer packet, and IPv6 extension-header offsets
> overlap the IPv4 option fields. This can make __ip_options_echo()
> copy beyond the allocation for saved options.
> 
> Clear IPCB after validating the inner IPv4 header and preserve the
> ingress interface as ip_rcv_core() does. This prevents outer IPv6
> metadata from being interpreted as inner IPv4 options.
> 
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Changes in v2:
> - Restore Kyle Zeng as the patch author and correct the sign-off chain.

You didn't answer my previous question:

> End.DX4 also calls ip_route_input(). I guess the same problem exists. Am I
> wrong?
