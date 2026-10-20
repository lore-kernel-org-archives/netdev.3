Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480316;
	b=xX+m2SMIzc1rl43dfTjb7Z2AlwVxkjOsSW3AHjUQvBgAUE2QxG8rIL2igw2+IM627ZDk
	 YgxV7V7ieVXRkXjQ0U1/60CKHJRdaSV762WfF6D4O9BO37pCnKgu4I9HhDz517cIpokEm
	 Kc4vFGqqQKFpaclT6dwsEuUHfjED5wBZOa7oN1jqvXTxc+EclkJ1FnlkRN7P1AOb6yVrZ
	 EYzVVPif5I4eMvzfqpoblIPcu6+w3qa9lqmAGV+BMZbfopFpbzgc0/K+PjhL4kO6X8+dU
	 wF8xxnEXgohj2UPrVkUnPMKq5FkEr5vJJEHwqghGCu9lphCy0bkkgcbg3YD/tipRCkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480316;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=M2ZWtK3jwBgT6W5EC/9V6YJ1MiOaCmKaMmxzxQcJy6w=;
	b=v7EUGkfzJb4WyUlDxy9Avkonmw1L19osTm40xBNgApuJxOGx2ZLaVl1sJWBMEjD6EWzn
	 uBeetpHfudZ0eF636LInBJqEdqWiob8UHl+yaJPhUG4X9eYSy4XKBaHhp8a5/eU4kJ8sF
	 Lek497m3jMLxe5z8aHmiazRLdSU2M5j9rJ7h1rmWk1ZwX1u3s9c8FGatdeW7ENClJFbUK
	 gdt2Q5pts0VvUsWlygPta7f6yNsdw7U3mxNyUt+T0/6vmIGay9TXesq8GxIENi3nJshG5
	 BFPq40jBF/oGSJ3FCNP1xvW3X9YBgLRagLp8n9yh/tWa98ynyzK9606C1TE35B/jZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlzY38nc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rVBKfbQY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335B606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4335B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlzY38nc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rVBKfbQY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792480315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2ZWtK3jwBgT6W5EC/9V6YJ1MiOaCmKaMmxzxQcJy6w=;
	b=YlzY38ncoermWzDcATucwp7c3bM3wTKUhaWZua5w4faAStmyh/1rXjcSxxniDnTGoL1ESL
	gS9h0bUNpp85DaF/1mBoWkfR2bUPw594zFDiWRBmbMEN2naQycfSTsTWFBvjejkj8fy7bv
	fyv049ducVmWcRpkddI9UKbfL+lZrAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-djGhAaxWPJ-Z45KJCuJSOA-1; Tue, 20 Oct 2026 07:11:48 +0000
X-MC-Unique: djGhAaxWPJ-Z45KJCuJSOA-1
X-Mimecast-MFC-AGG-ID: djGhAaxWPJ-Z45KJCuJSOA_1792480308
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so29728725e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792480308; x=1793085108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2ZWtK3jwBgT6W5EC/9V6YJ1MiOaCmKaMmxzxQcJy6w=;
        b=rVBKfbQYqDfcxMDVajSJ0//djDSLUEq072XS+G5TL1DWTT0+GB4v8hqSlkBH/fHiYT
         Me4ww78z3ubKuKElpTYoIogjUXyPMkuqowXO93J3x+nDZkR21E0A0kO8qfzpKIoC8OpR
         vePp6xjRYxl9Zt+ym9JLChvG0fbMHq0XOMTJcaDLcsSm04nGo7scVy9fydRuuzA7r+Lg
         LrI06nWVKT0x2/xYp35Wkl/uSpPwo6pgwDxc3yI6/QNkjKT1YLn3TQmtRTa6G4FNio3K
         KmNM5uYcp/W9UmNDDK5w7mep/tycZo+DZ9cSAFgyeCdZBuqYgJO1oBCKqmC5UvvjEKWX
         EDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480308; x=1793085108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2ZWtK3jwBgT6W5EC/9V6YJ1MiOaCmKaMmxzxQcJy6w=;
        b=V6a3PZZi/rX2w9bbAbXgDTul+w6O8va2k6leQURACqOuTYyfuYhr5HTsIEPW0USU6n
         LjVfCulCjwXmSjWpsTuR2hVMPlrJC50trRmXcR5lzUAR74ciRPvlZdX/7V3DscHPg8+E
         D2Ls+jU5OOFzriBNpkw3kop+EbtYPEHEfSVeML94CjyuN9R+MNOG+/uUjvltSuaWucBp
         Mpom2v5US1/BgFGP53OAqw1dwiQmqA2wg3Tq0XZRa/1cLdPbY+6tOOyb+jvc01ubxz/h
         irxKKDvLi6vr1mgqqR/WC1TNmSWMp1HojsLuOFPMosMbrELWG38vS4Q8GMpT61y2TY2x
         l++g==
X-Forwarded-Encrypted: i=1; AKwUvBzkZ4wz7CvQg2Km2KfFfkIETe12KAEASPoRbMNKYTm03RC0p2F6lpLcWLZaAzwF2uGa3OTt9kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk501N4IJAO1+Qb+66oMsN8P0Rp5uOnTMg9+0wmtOl5Ca3n281
	cGrjf9clCS1UvRuuUFQa8So8YwaDHo75wJXrBNcU5MRPRKlu8di07UuuPJLH938cl2rUTVIzeO5
	lcRCZ0ghC+boAquzzOhkw+09y4GnbVl13ZMJXP+Atb85EAdhWaud4gl9KZQ==
X-Gm-Gg: AYBFou3soAS5t2msmRJDCPEPsiOgvYHqLp3p2Q9uKiBL6hmrcO3ZQwFmqTVQspG2I/g
	ZaV1wn9I5D6y59+GoAdtQGASCva9r6/UUGzKlwEokMX/MuuK/rVxtIGHSfuYPl5BwCooYTwzG3U
	V3V8YWo+gL/dmY699Soqh2eV2v9S7mbZSIop2XmDkvAcm3srDZ6v+KyG2sUsvnUZEroQuPk1Zo5
	2R3xS6JINwNsnm0zV5C/ITAhcMuZ1Hzc2RKyWYLgXxCtYesCtn7mLFoFHiqPtjJYqRuHmq4VrnZ
	ULETlzGGSHGSMddoYKOuqbqmkwfsHU8f3AQ6dkpy3ecwOZtoFN5UBRpvUCcJS4eA/A0uM6Pm4CB
	Qe0uSQOCvW9JPHVD4+cwObirndrHbBl7x/jIaN02axli8FzFN8djNCXw8sPMggxhyDRc3zi0ByA
	==
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr205330425e9.29.1792480307705;
        Tue, 20 Oct 2026 00:11:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr205329845e9.29.1792480307327;
        Tue, 20 Oct 2026 00:11:47 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm331515125e9.2.2026.10.20.00.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:11:46 -0700 (PDT)
Message-ID: <976d815d-a9ec-4fa0-9b16-8e55695706c2@redhat.com>
Date: Tue, 20 Oct 2026 09:11:45 +0200
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
Subject: Re: [PATCH net-next v11 3/6] net: add a generation counter for
 dev->mc changes
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, ajay.kathat@microchip.com,
 aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 claudiu.beznea@tuxon.dev, davem@davemloft.net, dsahern@kernel.org,
 donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com,
 jacob.e.keller@intel.com, kuba@kernel.org, johannes@sipsolutions.net,
 kees@kernel.org, kory.maincent@bootlin.com, kuniyu@google.com,
 nicolas.dichtel@6wind.com, nickgarlis@gmail.com, sd@queasysnail.net,
 shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com,
 vadim.fedorenko@linux.dev, willemb@google.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261012011707.3378-4-sigefriedhyy@gmail.com>
 <179185709988.434549.15422498299449004512@kernel.org>
 <CA+7S2v+LHUWXQMD-cYPEzT5-f3Qhw_vz+LEssQH_A_oqDKtnnA@mail.gmail.com>
 <8dcd9564-e9a3-4b00-93b8-3cb023d68047@redhat.com>
 <CA+7S2v+rWYvz9xKPEeM6=3HPz3o7TbX2uRfRKk95f9Y60HnEiA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CA+7S2v+rWYvz9xKPEeM6=3HPz3o7TbX2uRfRKk95f9Y60HnEiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/26 13:35, Yuyang Huang wrote:
> On Mon, Oct 19, 2026 at 8:19 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> I agree this is not a blocker, but I think it would be nice if you could
>> follow-up on this one.
>>
>> The solution proposed by the LLM LGTM.
>>
>> Same here.
>>
>> Also, still speaking of possible follow-up,  I think it would be nice if
>> you could change the addr list lifecycle to RCU (no idea of how much
>> complex would be that).
>>
> 
> Thanks for the review. Since we're already at v12 I'd rather not respin
> just for these, but I agree both are worth fixing, so I'll handle them as
> follow ups.
> 
> The first one is a simple fix, so if v13 ends up being needed
> for other reasons I'll fold it in there, otherwise I'll send it as a
> separate patch.
> 
> The RCU conversion needs more thought and will probably
> cause quite a bit of churn, so I'll try it if there's a v13, and if it
> gets too messy. I'll post it separately later.
To clarify: every I mentioned in my previous email was about possible
follow-ups - not to be included here.

My understanding is that there is sort of a pending/implicit question
from Jakub on v9: why are you doing this? is does it solve some
specific scaling problem or is 'nl is nicer" thing?

/P

