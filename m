Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792638124;
	b=dZri3hYhw3K6JCLQlSdmfCBw0B9jJ4xIur/r6eWqGiaRItDKn0O50qpA8vZar51ybCWg
	 qfVpvFuoRC+pi935QGg3OxYiWo487+7Y7IVvG11fxOBjmE7ivC5e1bOCNRVMr/m+5ToMY
	 z7AsMwCLXEPTE22jdDXNa6Lu986floMKMathuNoNDtJ9rHQzaHYWDGJfHepvKgMijtNIs
	 wl5m7MAtv16wcNQKknRZABm30stOvr7fOMyv2BuXdbDVzxmfucOBAhP0OXo1hE0olHcHg
	 kQciRVwHt0EnsQFbkdGsvlj38sjasyp5LdduqEq3AxQFFPhS/5V6ZBQkGtzr94SYl6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zwVRCRk2MVhRxyoH0H2D7Zbdx1Ah594UWQaso51Xgy8=;
	b=z5dKzsB1mnQ/NXV2/olM7uyKo6PvF5OjovxrVd1VjsvU7qNBE4H1uFFxbLHltr7/lW+Z
	 RYDfWAG4eT+e9qJhZ3ylceCXPO/IpvxNYYDV2UPMW+c0QahWyOXtyc+wH+3fFoYlDuLN9
	 APdYq0ufwY+IFJgWx/p3/1FiSbIEoPe8FqIGfd9OovAiNJ/p9Horg2vvl7dnj4YAeL1pK
	 bWjbom/ZtNUe17ABEF0lIN9CAlY+l85ql4ychJ67CsyMp1CSU85tzGpDU/Ld/jVrNGaWW
	 BxAymJtaZugxpoC+41GYULBYGM6PkjOmOPQhUpfAnClEjPnA0WeuCcaVNv2q5zAqsBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=sL2tsQl3;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44452606A31A;
	Thu, 22 Oct 2026 03:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44452606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=sL2tsQl3
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j99t33m5Mz1XM4Tn;
	Thu, 22 Oct 2026 03:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792638119; x=1795230120; bh=zwVRCRk2MVhRxyoH0H2D7Zbd
	x1Ah594UWQaso51Xgy8=; b=sL2tsQl3mrcfsRH2OLiit5Cwz/mZaLw4nbd3/p+3
	Fyz1FZjQJGkjhwrE0kGJjRMY4c1gMQIoCOYwbRNV/P6M+zHoGdNJ3iNgybwr7S7W
	kziCy8IZ4g2asvCh1+MGV1Q3c4YTZHwjv6LblqRtDsCx3aKAePnXnA8fVfyaeDDL
	MhzZCWB4oB9KnaO1+HAzEywMGg7Am9jYzEKtC3IL1PsaS7tWq4laawnja2Ie5sCM
	Wsa5Hr7bh47+0cn3+P8/XKqsdcyZuLYnssznyoJaIdt7X602SR8XT1/pntgdb27z
	EQMt3MneX/yKjuVae3vTUeDLLudXmbdz5excGYmYNiXOHg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P1caIBMA6g-9; Thu, 22 Oct 2026 03:01:59 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j99sy3NWLz1XM4Tl;
	Thu, 22 Oct 2026 03:01:58 +0000 (UTC)
Message-ID: <ef57e0ab-f0b4-46d6-a2f8-f6c97fec8d8e@acm.org>
Date: Wed, 21 Oct 2026 20:01:56 -0700
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
Subject: Re: [RFC PATCH] lockdep: Keep dynamic key hash nodes in lockdep-owned
 storage
To: Vlad Poenaru <vlad.wing@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Eric Dumazet <edumazet@kernel.org>, Davide Caratti <dcaratti@redhat.com>,
 Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261021115621.3194947-1-vlad.wing@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261021115621.3194947-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 4:56 AM, Vlad Poenaru wrote:
>   #define MAX_LOCKDEP_ENTRIES	16384UL
>   #define MAX_LOCKDEP_CHAINS_BITS	15
> +#define MAX_LOCKDEP_DYNAMIC_KEYS	1024UL
>   #define MAX_STACK_TRACE_ENTRIES	262144UL
>   #define STACK_TRACE_HASH_SIZE	8192

This patch introduces a new hard upper limit on the number of dynamic
lockdep keys. That's unfortunate but I assume it's not possible to
eliminate this hard upper bound if the key storage is owned by
lockdep?

Thanks,

Bart.
