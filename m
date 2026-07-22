Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69240F754
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718344; cv=none; b=Fa9rlx1Bj2hxuHG7MJbo/lcc1C1KzHbru4QwBdyvDoD20liw79kCwgf3OKvmPlf2AHOrAc4GlK35uYefn4b1CccX5hVoEDm5i2PeRpPJAYy3jwas5X7UwygYo2xhvwHocpNQfIlH14j8hUXSTodM/PphxqAG3S6VNg2RUeWbUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718344; c=relaxed/simple;
	bh=oCtEdF9DTcmBP1H/f9ggXd0GhzMOE2IrNrjF/TcKUW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn46arKwy++d2Jcpr0LByTmiUmP9tmY33PzWUhzfkKHzJD0lUqehkElXLj0wYT2OAFUIOWUme8hKCvicH3ZaJ8KPi6IYSwXiMvXfOfEdnhMJf7QwUqz6VEFWZcR5Trmojbs3eozMjw4ps5gTPZtuDLxLGukySc/9ZOszLu+YKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgGlspMm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kxpCOrfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgGlspMm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kxpCOrfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784718341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCtEdF9DTcmBP1H/f9ggXd0GhzMOE2IrNrjF/TcKUW4=;
	b=RgGlspMmzHZ9MGYK6rrtAWVEsXNJOtEAzUnRD1gGYc1dvdQLkuM8PfQLY64wmFvlIPTZjk
	s581a1yM6VjcPR5Rr6HuzJy8u749cYFmG6zFTBYX5QCuBse/YD7sgYCWVcX3Z+LSlhFms3
	SpgNocH9vlseeS0WgfrPrZxZtP0qZIc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-JxxECbjqOWe9fxnSdXm_JA-1; Wed, 22 Jul 2026 07:05:40 -0400
X-MC-Unique: JxxECbjqOWe9fxnSdXm_JA-1
X-Mimecast-MFC-AGG-ID: JxxECbjqOWe9fxnSdXm_JA_1784718339
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f726186c4so2460167f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784718339; x=1785323139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCtEdF9DTcmBP1H/f9ggXd0GhzMOE2IrNrjF/TcKUW4=;
        b=kxpCOrfAaBB8Omq0f/jfkH6FdpmIWzpkNOMn57GQlowLpnm+v+Kn6EuHcu+DhfgY26
         aS7BFWI1fiaGFjky6zFe7/b30MWt74x4YyZrgWTcEw6gQSSHjXOS9etsEZcwX4kCo2rl
         h81iZ+iMe8Yp0KcnMRF+CvH7btOfC6QjtdHzuzLUhDUsMaLp9uPzL1w30D/8Oa76+P/Y
         2OJILyoRghCZx983CZ/TkI9vqxEHUZoJcS8ee7+qYVqxe1w5CIDE05W0J/6+xu32jU+I
         lF/7wMLxXTIoE1SXluHtcbeph/Ss5UG2J3vNBDuNGF35bzEUiO+ousLOctMNylgR7ueD
         F6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718339; x=1785323139;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCtEdF9DTcmBP1H/f9ggXd0GhzMOE2IrNrjF/TcKUW4=;
        b=AL0gAWumnlqVi/LZT3PriyYaSUHuXVyXv/zyroG3v6D2dVIYob1H1Oqne2j7qCcf6P
         TJeCwcKZPqYWzWpqC+5kuSj2XPcJqZfALFekJeUaqYCKO6s11suR99hrqwNvwhTQ54U4
         Xa0JzejcGMjkaZyswUJgzDs6kCoMBZ0dkOtiWCsHKOU+Pd2jPg1cDNGucDBRbrwH0pYO
         1Z3JRazX8VuoLO0urrcEdKFPlehNIUgmaeAEtxFGCqiAeJBimJU81vD/9Eba4aTaUQ2U
         xL4XjfeJNfRmGySe/3UVy+o/R5FC/abCdkWHZ0+2iFXhM+hWypzNApcZ9hQLCLDW3b1a
         O8pA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3RIiUXaE+CRzPdLDg2XSNRPSXAzhd0OlW5RDSPAxmUtyIbiAIcJ+Rk9IYGVihNMY7k539luY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRv0+umQ/7LLICFRoL4KFFxxtSvJAT7swTYkQbSB092LlS76LQ
	IcN6+wB8JV534JwOuxbR6mPfo9JCL7k/ZaamJ1PRxhVmnlEkFwvc6fs78K+en7uKIPswDF8F/9J
	+O2ia09qLwa680rtgU6dUM0WwsmY4MjKe5vJi1emdIHxhI33bGx+PyV9mlw==
X-Gm-Gg: AR+sD13a1lDoV9Eh72qTrm2AeiF25c9cGFar9iPInr0BXi63O7T5H2FyvZkv7mllExT
	Y0YJ0BVgKmY7OdBKgDAif1K7q+YgWW0QmPUuhfZwqRJWw7BV39WkXjLnAPZRLlAq+UNRj5pn4lH
	I1vem1Zxj7lrWl/CEolkFIVbtUmW2dAyv21L7UKDbiMHBaFPp6FeCHDDdTZKvf4nulUYpoZUySt
	pFyUwSSmaOSXiqaxjzLSIEmu0eDppZd+fR8fcelzXKGilH3Owf8/MLZAu+sqRCouRsOSr5BzJPG
	5YcBSeTR1RC308maPSyM0hF8bxy1a5+483G/zxzRPSBRG8KGEIqhmdY3Wi6we+q+CE7ph6IePok
	vbtSG1fBqvk5byz+kW1Zt+USQg+6nUPVSyvxGC/IMOilZOh6PZiqnr9E7CderjzYa0J2VqBcaaF
	U8MQ==
X-Received: by 2002:a5d:5e91:0:b0:47e:96f4:4a5b with SMTP id ffacd0b85a97d-47f623454d1mr27822579f8f.51.1784718338954;
        Wed, 22 Jul 2026 04:05:38 -0700 (PDT)
X-Received: by 2002:a5d:5e91:0:b0:47e:96f4:4a5b with SMTP id ffacd0b85a97d-47f623454d1mr27822530f8f.51.1784718338472;
        Wed, 22 Jul 2026 04:05:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm5042278f8f.37.2026.07.22.04.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:05:37 -0700 (PDT)
Message-ID: <f65cb565-0899-4e0d-932a-28e15b3fe864@redhat.com>
Date: Wed, 22 Jul 2026 13:05:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536
To: Alice Mikityanska <alice@isovalent.com>, Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
References: <20260710134242.216538-5-alice.kernel@fastmail.im>
 <20260716144742.334586-2-horms@kernel.org>
 <CAD0BsJV6SU_UxygMt8ruLVtgsrC91ZKNUyJdh691xphKmqqwDQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAD0BsJV6SU_UxygMt8ruLVtgsrC91ZKNUyJdh691xphKmqqwDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 7:04 PM, Alice Mikityanska wrote:
> Normally, gso_type for tunneled BIG TCP packets won't have
> SKB_GSO_PARTIAL set, because udp_gro_complete replaces gso_type with
> either SKB_GSO_UDP_TUNNEL_CSUM or SKB_GSO_UDP_TUNNEL. This way, we'll
> get to the correct branch and subtract skb->len. SKB_GSO_PARTIAL is
> only set by skb_segment, which is called after this check. In some
> very convoluted hypothetical scenario, if we have to reenter
> __skb_udp_tunnel_segment for the second time, this time with
> SKB_GSO_PARTIAL, it will still be correct to take uh->len this time,
> because partial GSO packets have a UDP length set to wire MSS.

FTR, my evil mid/long term plan is to use this (BIG TCP over UDP tunnel)
in tandem with double UDP encapsulation GSO/GRO (via geneve hints) for
containers over virt deployments, so the above convoluted scenario is
going to be a lot less hypothetical :-)

/P

