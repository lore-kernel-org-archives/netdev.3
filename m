Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283290;
	b=deYmZGF13wkY90meSvt2L1M618++ols+ncMsIqo3hOZTFBxL0YF7xXMmEwoMC9ZHUrQ5
	 PgyENdJqzIpreQckqU9BznoUwgPyO87rDopTujDz2YFtXuglxlAoOseoUvKJDt26hKQob
	 GPlgVShTN7cvf1Vv0EilC9y4oINB06f2fUhDB0hAqm6Vp/IsjWJQV+FGqTsAdNi+iAfvb
	 PGuaW/IYWLr0dpEcORba59N+N6KvzQ0Y5wVl8rPsyss2Ks7OfjXOCawdxJma4vUzwf1qI
	 T3FeJBgzFRG7ZkSowbDHE+vub5Zt8+Yyf24g0w1kFF9EMBu8NaGcmXe8JrKBcYtXZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0BQlHx7uCCJcA5mUCx26J9pjaFYyDNKs65K/9B/VtGs=;
	b=lezXPqCj+AgLBdgKSCWJX1niUsxcHt5uD2nK7Qa7OlOm/DlfnRmZuIVprZ/H0SaAsWdA
	 yos082Pd0tQzGAemKwVYCLUZvwSsBnIR5Em6wuC/i+WGLf50jM0hck5NBzGCJ5ajAgTP1
	 DBA5xrg3VcZC4Hm277ehmeLBuLm+3Dydxg3RPdzN4zcb21On5jjIb6swUgUHHt84FTdJ0
	 /Jip31isDLykvNY6egDnPr4z5rINcbpLObLApEtAJdy+xlbZIxagFKFRT2tOv75pEkLe4
	 qFht5dDS2byeXarPDuRc0PDmfpOpiTHqZFxCi4GtNhumjPeeMS38xz/UWBS8QW9kZ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdUvPot+;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33461606A324
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33461606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdUvPot+
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99061e2171cso765561241.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283289; x=1793888089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0BQlHx7uCCJcA5mUCx26J9pjaFYyDNKs65K/9B/VtGs=;
        b=zdUvPot+5P7sRsEp6OcuAVheltJO/GLA7fZARf54rY3MIBO6q2USZs0RZqNmDdSFSL
         QuTU9P67jQmg8cfIYMPxDZNSgOsnfjFYSwUpOV/quCDT4UQ9vslXNywhBAaMlqzRI/di
         UKnS9gCuWqxcxkqjlAIWNpsoj/7UFF3bmw/jd0CsoEpqB7sfgLb87Qd9GG0pr/EFHTnF
         Hj7VRNVTDn7L9shm1DDftcNcouGn+osiI4+Sv1qHQIPv+zRkkTO2OYHRCFxrqBhtOwdR
         6YmZV/i5KAlAtuWM/TLcLRisXVr/9fytzOBoi2wFjXJh7HukJhMnltkd8y9OmFh4jhmU
         74xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283289; x=1793888089;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BQlHx7uCCJcA5mUCx26J9pjaFYyDNKs65K/9B/VtGs=;
        b=12XqGOEAVvZWaXA96IPAY2fyOeesFRUmvefQv4/mwKQUu5EAIUDRv6E5d1DEkHamwx
         LkBSFIU5tou+FjKAx0wzxTbecBtmCc5SZUlNoWxvbgtW2TJ6Fyehobc5BTboPS10ehUf
         6unUAkjdIgD+5RfC5B5d1acPW6OqWVqyOxYv2kVk3pgd2DLyUaRtU446y5QNGyalKgVl
         zoG0hJFNpiw+HekLo/DxIwm6u8nKo53MY/iFjr0tK0SlTdXufOnvipO9W0aBvMYvMkwc
         mChOBreisrvMgyAvvCJHIX79M4qJGdOqCh2IKs4kU1UiJaOlsl3IaYNjs15sjKqyQhgw
         5Wkw==
X-Forwarded-Encrypted: i=1; AKwUvByo1/4p8NPAxpf64IOvrZE4jr6lPItYFLxpRdhAvDFZsUECtqhz0eChKJvK2xtwxorPdE1XUl0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ25SAdQqSOVs+FOv7aCwUq5Nwa6qzpObmm5KZ2IqvlyoFRikqD
	3z1S56AghxBqkwypom/87P/Glm1OJWxVNPgU0cSVcARlrqa3zKJp88gy
X-Gm-Gg: AYBFou1Q4zmEOe60p58f2ReRAjxv4MNgfxj91919K21pEI6+lvfvXTKs/wIwqvu6EHR
	o9tcpaj3tQuug54fLwO4LWTp54W+SoZP9tuNyrq/jwpjnnNgtdGXaMDlWzXSiCDsYy/J+2blZpr
	ZhiGeCnV/oWmBK5f0RmeqG/809cPsiixjtfEVGhbgJ1kniWimpCsU5tQJyxJamlhgA/AXk7Elk5
	57Q5qBzK54jJZ+ksN038QDXlFQF84dthzTRAfSnKzT9S16YEduC8Ll9YbOpnr/m6Z8QjN/gLBqA
	7SC8Dgn/ctM6LvqNiPgnDH6l5Q+PCWYjXduOWLW80wCh7SM3EmdY2tznmdyp+hIqaxSYatGibyM
	oZjK/BfYoJ7ODi7TUSOKfnZaIGDCTsplrvp/oZ+K9PPFoaImke39k8GlrNbW12SVtFkzrWmB7Wh
	Kf3Ww83KWtbzSxcyJDw7bLMNXburXxA+rFM1a8DcaJWe8jj0yZqimnGPfNYB46k3NZwFcBG2dBx
	Khlhp3AU7FT/FFtRo2iA7zW3ZsOigtclo5vg1OQLsx7swHCzOSTp3WZsE78fm58oAMUc4i6volo
	ls7SlY1T5OsbYkwGN5pK1QXsIv3w8w+SaGIwcolSSF3NvNBcQekXm8WW+AzTgwz2gCdJpkClmEr
	nUrC6DIsftKHiFqPbuhQ4rjuBbyuJzV1T+f/bOTNIU/RUAdLE4zKesSyS0X6ck56Z5tyQ
X-Received: by 2002:a05:6102:4b19:b0:7c2:635a:4f4b with SMTP id ada2fe7eead31-7d03a5fb4e5mr2639244137.29.1793283288981;
        Thu, 29 Oct 2026 07:14:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259db2d3sm9696732241.6.2026.10.29.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:14:48 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:14:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Tom Herbert <tom@herbertland.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 AutonomousCodeSecurity@microsoft.com, 
 netdev@vger.kernel.org, 
 Cen Zhang <cenzhang@linux.microsoft.com>
Message-ID: <willemdebruijn.kernel.36b7e61b82ce0@gmail.com>
In-Reply-To: <e93f9302-b2ce-4e3e-b317-f867d80e8643@redhat.com>
References: <20261028141325.2103814-1-edumazet@kernel.org>
 <20261028141325.2103814-2-edumazet@kernel.org>
 <e93f9302-b2ce-4e3e-b317-f867d80e8643@redhat.com>
Subject: Re: [PATCH net 1/2] net: gro: do not undo remote checksum offload on
 merged packets
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> [adding Tom]
> 
> On 10/28/26 15:13, Eric Dumazet wrote:
> > skb_gro_flush_final_remcsum() calls skb_gro_remcsum_cleanup() to undo
> > the checksum adjustment done by skb_gro_remcsum_process() when the
> > packet was not consumed by GRO.
> I have a meta question _not_ intended to block this series. Is
> remcsum offload still a thing? Can we get rid of it entirely?
> 
> AFAICS remcsum landed upstream before GSO_PARTIAL, and the latter
> does a better job (specifically, it actually validates the inner
> hdr csum, while AFAICS remcsum offload basically ignores inner
> packet csum).

And also LCO, which requires less infrastructure to offload all the
tunnel checksums.
