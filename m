Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261102;
	b=5Mv8gc/CL5UEv04b/HB2zn8ACpLKJvDxK3Ck7IA8mliuSWiiNXXs29OsUNISLi1He52+
	 HIWWbi2yQ73T0qQUAaqS01jMNVOOlugOjcNU8btLSyaPXXwjyy77UXx5DSlq5xuo68Sw0
	 VO2cMSxQZrUhAsLcUvJ+zzHCkmoM3wkbnfItKB4ZAv86VIqIBkVdAkCAyLay9qUQqIkSY
	 JJMVN2OIyTailLJdemRVc6mtu9gqJeXWpz2HqADhEenqDqG0FQCbqAUbPffWtAkO2SGOs
	 GokrrIQmrChkCWWZTvicH4WvUw9LLHHDRJtZxS73mc48qtogchuBtjDb/OVlgxK7HRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261102;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SF8dwUj75fnZHjig+DxZAIwMQw2xj1TnQIo0SleoAhU=;
	b=A8Ybkk7AhjVMsLaiFq8FPvUQDVfdp6k5IUKwboBwh3ybZXOGTcoNtJJCaOcCzotAXBTe
	 Za1pfYm+idSA4UNCGP8bJWrU5aeq5p5Y/3Ub4IeN7bEXvR4BXQ51OHuQ55RybTeIKSnA6
	 IlKWNsuLGd3Qtzj95QtxrVNCFFPeyip0X2AkAdMjFN049mRPstFB/OAexYgwjrPB83owo
	 bwz3lrTvKdPxtBuzV6MV7x9066wO74g8mOWaHsG7t59Zw6XdQ6kbyIh51H7NLcACJ6Cp6
	 54mssakdonchfLTe8i2sbd56xxdRqsnjmsNGnk/rPK7AxjzsZnvc4T1Bq8F0oRyMvpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Z8/DO4Gw";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Eny5EZIr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC4606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z8/DO4Gw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Eny5EZIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793261101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF8dwUj75fnZHjig+DxZAIwMQw2xj1TnQIo0SleoAhU=;
	b=Z8/DO4GwII/7JYhW2nvBhmADg1XQeaVJrN5Z1yQ6IMi5mVO75D2/UNhVq7nWeyFKL8CMuO
	YCpuOSC0/5DPIFRaFSVrouujX2zhUnT+p/aTgzXyQ0GgUfEs5Wti2pXos8FTh+3a1RwBDB
	WZHkpIDqwJojJpliebcimWirP3o7eUo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ryuIYLDiOh6kBKnsLwwvrw-1; Thu, 29 Oct 2026 04:04:53 -0400
X-MC-Unique: ryuIYLDiOh6kBKnsLwwvrw-1
X-Mimecast-MFC-AGG-ID: ryuIYLDiOh6kBKnsLwwvrw_1793261092
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4046a3bso1535195f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793261092; x=1793865892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SF8dwUj75fnZHjig+DxZAIwMQw2xj1TnQIo0SleoAhU=;
        b=Eny5EZIr7g3dpe1Pi7TjDGq/EYXStSKsoJuhVmHoqpM/oVrL8bsgtPgSXl0ey9vfB/
         r+4n0reB7ybxESgp7mA67LE8FYbS4rBtnevLTF5BQqtGWamPg/C4g07Bwm16zZeA7nK5
         OIoV6mSOHH5K/Iy+jGk1a+c8PMmDFJp0CTZuG7anpRPmDZAPZDovSQOuIkqTS7vzfEnc
         U6fIjKX7Yjdn65BW1BUxAv3SN2YzPxLBibQb+snJZ8XsYElF58lITp5vLJK18qGaGFKg
         bXm9pLZ7vDZgOf/ZTfK/O0IKuP1ZoNh4T45UMuYeq/SaliCCa+l2waC7bxwwwrJrbj4P
         +MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261092; x=1793865892;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF8dwUj75fnZHjig+DxZAIwMQw2xj1TnQIo0SleoAhU=;
        b=J79Yo217RsfKB2Uj8p9EWlxKG5FxeDTqWNQFfOxhek8J1LVs2eB8gNStXmlXMmL0uy
         qSYkK8ftdnWym5WWPqGqL9/99Do/1QM6itJo4ls/x7qV2avD9yJ4Pk1qt10+zrRvErG/
         2eQLj7QcR80frY/J/MFM+pTI0Acz+x4ru47xVPmTo/NsR1MqcxVBFZUygqWFT7BOMe/S
         YSkJ9Zvp0aGlKg9tfbJXi82uxe4jEDaU/AyWwt2jK3hGhFgyeoI+BHiuggaNZCj3Fx6i
         KB9ey0lLQXLC2/Ay6+J4dyic1PI/b6yny0ATOy6hcSZp/RZxd/zi5gTawcz0namfgWWe
         Vd4Q==
X-Forwarded-Encrypted: i=1; AKwUvByca0vOouEubH423oUxDvwFUQ+hs86RZdSxVdGRUXOaoBQ2cVymgWtMThHsr4+7sJ2ii9IY2LM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5G5IM8PK3CTEB6sS8sIg1ARS3lJCdTJwzwTbDBg5qSya92txI
	R56JJNQpTUhF6Sbrlcd1lu/RUw5CM+QlZ+WPJEqOviz9sjgZpjfrKuqhGOhwW/nQ+LZhittTH2s
	XOq0rAHb2pVZb2+I8yucsJ38UCePn28Z6Ot7c09ze3GNmK5gY3As0VpeB5A==
X-Gm-Gg: AYBFou1Uh6PfIxajlFYvGT3UjtNrXVcVVqPH82NxZeTNPnUKkOxve643NTjtrxlw065
	1I+tqDCz+Rq4MDbAuL0XduWhRknt4SHZS236Mo9PVbGkccShSSKKef1Fd07gLqs6Ls5RtsvLZ6A
	kl5zboRrSR9XXl33DtaJmrxr456v52cvqn0J3lJ3aOFB+tIPrWjXGj7KBi0+yNwBdokWbyo80Kh
	wMGNh5zBK7DT04T7E3xZWwiZ2AI6sPYNktry9OyKDfLfuLiExRn2tUIU6vjcv0zBpAMfZvQaYKL
	Jb18P5dl+Bd409Coz7DzWp1i/4RiZ4INsGOf+5CQiFSiTPZpiP9HvPBjA4QmvU97vCCpI8x4cw2
	iJCpEYSJAKWKOzaaGR5mXoLxXSjDPUfDcNG4aJ4a5d+vjr35AwNYUJYSgdRWh8jfoOuYRvIFyO5
	f11tplpaLTJdVUxz0/6dQclD8rtWQiviMYr53XyAi7WrJG0SI=
X-Received: by 2002:a5d:5e07:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48e5d30e197mr10640335f8f.45.1793261091893;
        Thu, 29 Oct 2026 01:04:51 -0700 (PDT)
X-Received: by 2002:a5d:5e07:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48e5d30e197mr10640305f8f.45.1793261091563;
        Thu, 29 Oct 2026 01:04:51 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm35722335f8f.32.2026.10.29.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:04:50 -0700 (PDT)
Message-ID: <e93f9302-b2ce-4e3e-b317-f867d80e8643@redhat.com>
Date: Thu, 29 Oct 2026 09:04:49 +0100
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
Subject: Re: [PATCH net 1/2] net: gro: do not undo remote checksum offload on
 merged packets
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Tom Herbert <tom@herbertland.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org,
 Cen Zhang <cenzhang@linux.microsoft.com>
References: <20261028141325.2103814-1-edumazet@kernel.org>
 <20261028141325.2103814-2-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261028141325.2103814-2-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[adding Tom]

On 10/28/26 15:13, Eric Dumazet wrote:
> skb_gro_flush_final_remcsum() calls skb_gro_remcsum_cleanup() to undo
> the checksum adjustment done by skb_gro_remcsum_process() when the
> packet was not consumed by GRO.
I have a meta question _not_ intended to block this series. Is
remcsum offload still a thing? Can we get rid of it entirely?

AFAICS remcsum landed upstream before GSO_PARTIAL, and the latter
does a better job (specifically, it actually validates the inner
hdr csum, while AFAICS remcsum offload basically ignores inner
packet csum).

On the flip side remcsum offload has even lesser device requirements
than GSO_PARTIAL, so possibly some use-case still exists.

Am I missing something?

/P

