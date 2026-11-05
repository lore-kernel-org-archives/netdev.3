Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876757;
	b=LoiVIc+wF0GvRQf30pjDgEpy2KGSBJfrkF6OxMl0TCO0vdGh/ONoASceJYDrNaAYuh8f
	 Qy5ZEU1EuQ37nVVSBqVMIvgQjWOb5aNjVjH8P+3rWaFpsU2GevkQidmrYLpe1P1sS7yVd
	 yE811HkMegj0SH8nt355WqBaaRnAcoDf+Wa8hmf7dXCi0FxENDGslV0t/mdNCShLq/893
	 FLLh9giZFhnF/iwxwkJvD4IEMcGXRVH5GOJMuOh1gfEa/OEAJCNCtmvA5cgqcGOA6pDAR
	 THRPhYXaX9YBRaIvNKg3nlQ/f4322WahfnetjJceQX1jfL0KbGD3FOKmIFNMj+Lgj/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876757;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UkU61sxV7gzGCXcoseb2sfWpv/CEGqGt6zB6Q3Q0kmk=;
	b=ryH4sQqppP82x2qKoQLgmy+b8/1E1BxrtmxEuJJJdXgWJ+SVTd7wClVZU3Gd1/cDd09k
	 rszktNsDO99xSvinpzdbRTs4PuxjKiDc1ph8cwhx0ipw6hIAwqma/kw3hc2avTwOg+MRt
	 f/k90O2GEVou43GlLoS9yAUY9ndeTqvNMg+lQrTFAItavFB9V/nf2Vuc77IO/kynH9amt
	 4yn9bibZLTV7hEljWXnvLpb2r3SYIj/X4cgLOJ+Uo6/fVz7TokxyhZA/JXQ3BePkBA/8+
	 +cTuhPiKP22wA9OgjZXldn4W5fS6p0TyirVmXtgrXr1ilHdOcKIjxE1JmISAugZQKTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D+6Ehlwy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WsXbCiUM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA29606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA29606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D+6Ehlwy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WsXbCiUM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793876755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkU61sxV7gzGCXcoseb2sfWpv/CEGqGt6zB6Q3Q0kmk=;
	b=D+6Ehlwy+x8+EJ0dquXRsmlom9wUCfn5ORJeFjR06TVINdFC/PlGXT8tI2mPlWQ00Eo+cr
	Dh06bk0YoIXIhhQPBgAsJT+j+T7smxKthUsYq+AQngfokuy64h1Xn/wqbFDuenTFa4quvY
	hKJnisJWcC17vDiCkhzszLZYk+50c18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-EFLVW5ilPYKMl2aFT3vS5A-1; Thu, 05 Nov 2026 06:05:54 -0500
X-MC-Unique: EFLVW5ilPYKMl2aFT3vS5A-1
X-Mimecast-MFC-AGG-ID: EFLVW5ilPYKMl2aFT3vS5A_1793876753
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso10850645e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793876753; x=1794481553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkU61sxV7gzGCXcoseb2sfWpv/CEGqGt6zB6Q3Q0kmk=;
        b=WsXbCiUMSkqnE7ngUMd5bOc1Y7Lq5+aUK9198qqWt7QWr0eDvbmtZOI1vFmOKCjCVz
         fA44mYEnwS8K/g2zCYrINd6So33X1L/gDnLg/GQAZvMRYDZALc34jwUR6wOr8CIF5UOy
         +3BVK/kmtB9JfESFQdCVUCW+lCTlUt3+9X7a3swK7j4IVqgh1QQ+w8q6ac2lMCSLqHHi
         tsFJkYT6d7vB8jQpu2K+M+RpWi8VqiHAdDZtuJJXlgPClPdWiq/pE55S2yTwp4qjncDb
         K/zMD8S8Cjdz2kqrZiL3W7Q/Y0NdYBxuajnx/UwMwbrpWczieFQnuKBcA5LtYfG9is4N
         serg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876753; x=1794481553;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UkU61sxV7gzGCXcoseb2sfWpv/CEGqGt6zB6Q3Q0kmk=;
        b=irjnbysbs1zLhc9Uxd6PN8wPZYuV2kkelpTxf4VLAVCBKJmW525IlVb8MO5Kvqzc19
         d3aSA1G/iO7XPc+Dfak8Fc63gsSnTVjnAuL0VZl9loL0MtlHLd6ni+wSX9tv6H8aDaPi
         mMBM9E+velsjPW+dgYxL6upTI4UXmyMAzgscEtvu/SyujugccQqcGukQNlhW3uYKBX2r
         lvMpS4CQ5G7JHnbgNDG2SViYj00Vuvi4Sm3JLOUhMHcDtCowZfb+Rm16DYu6gDYhCPbW
         VIZHzPexsWinPt2u9j/R8myZelZhqoHpvb3MlKNaFg2fu920FeSkF9ryV2JQSl2mZI28
         020A==
X-Forwarded-Encrypted: i=1; AKwUvBzzy2l/jXCtFuZrwFZWg6/4Hzyh/BkXgHv5uqMCbiHA1mFfhqD+6XtD0l8sVUztufLK1HvtoM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z99Fn8aKOka26FQHPM2gX/K21MNbWiHKvjqfv7Z4p1EFuVrJG2i
	AgO+nyRZE+b5NMr9HDLFCXNAOkpBrCvgXBXRaIavE77ka4kGBAoga7IfMH9GvwDL9hBSuXPh8RH
	0E/uaVnUNjxwbTe9zhwN6uv3sgmPwlL686XoJIVYYpCiLNbfFrenJdq0qPQ==
X-Gm-Gg: AYBFou1NygfMc1irTTbwpbnNXkbXP3VMRry7gS8sr72kY80D6J7uWa4RtezGtLy2W2Z
	0odebZRmPobIaqwlcVI+jNkF0IWtSjHPYJlvAUmR/XS3CCJ6adk/Y9cHbA1/+vJznDdnUaEItJr
	TZOxVwavGTPblcMqGYxWyGVxZAegT2j3yx8qwFwwbFTEQGPpagfTd8HEifcnNb2S0VZpYOJxW87
	JznDGxlfLDUBnHZ80Ltu5aXjHvG68+eQbBF0vX/c6E261ZBVq63AVTinAYczSnCWODYgHAnPkdK
	mYAodpvJDR+YqcG5dbQKfzaJadhDnxai2jt0aU3VXleNjpntSHoEcGgtYR4JzgFVbI+2lEcDfXL
	MD0avXd5x6xTgFNH6yU9qtsSkUNsTQutKXamgDGCjkdgYyyTRH7Go8uw99jrBKgFlaTNduPWDun
	9afdeyKw2lmYriqYMaLljuojsN0aj4/Qjkp836YjMqrKA=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr423454815e9.9.1793876753381;
        Thu, 05 Nov 2026 03:05:53 -0800 (PST)
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr423454415e9.9.1793876752918;
        Thu, 05 Nov 2026 03:05:52 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm59042825e9.1.2026.11.05.03.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:05:52 -0800 (PST)
Message-ID: <1518ee19-95b3-4a13-b36d-5791324a6a23@redhat.com>
Date: Thu, 5 Nov 2026 12:05:50 +0100
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
Subject: Re: [PATCH net v3 0/5] net: fix misc signed overflows caused by bad
 sysctl values
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 Joel Granados <joel.granados@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Petr Pavlu <petr.pavlu@suse.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 Oleg Nesterov <oleg@redhat.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Gerd Rausch <gerd.rausch@oracle.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261101061331.286404-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/26 07:11, Jiayuan Chen wrote:
> Recently I have reviewed quite a few fixes for variable overflows caused
> by config values, i.e. a value set from sysctl, module params or netlink
> that is accepted as valid but later overflows when it is used in a
> calculation. I believe there are more of these still out there, so I
> used an LLM to dig through the code and it found the issues fixed in
> this series.
> 
> All of them have been reproduced and verified in QEMU.
I think that the 'net' target + CC stable here is a bit too much.

The uAPI changes, even if reasonable, can still impact weird scenarios.

Targeting 'net-next' without CC ing stable would give time to
possibly catch such users.

Also issue predating git history and exploitable from root only
nowadays is a quite a good signal for net-next target.

If nobody opposes soonish I'll apply the series there.

/P

