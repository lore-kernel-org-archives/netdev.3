Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851054;
	b=s6Q0jIeEvsI/rCNtfxS5zt2n46hmIoEyAiD/FxpkIam/e03agjW1YASQJWMSnT1jKxo4
	 yO/BFoHZZXNhYAGW+pI8ut4kXaOKbqsmUpJeY3reFRxIyYGOOknSLYK3CPiDAmeOPBewY
	 pSSUzJg1Eaft03xcnNJrCcR6nr8ucuty4k9QGWqSyqZRCZ19XD+e26fYdTDkTYM1gBqmw
	 MpObhE0hlUCdikMCix7507HbnQ6f8mne6xUOLtFyniDLeZu6XqNb+fkLu64XMiBTHpV6m
	 vJxXED+jMHqdBEiwroXHP3Ce1qOrt9amilxaQ8RpGsYPKAPWhZVt0ySDnnWfzl2mJPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8l8NznFr4i8f4HZg2RDz7wzmKDAun/MnYmfkpx3XMNA=;
	b=IZCn66vIoW3e42ljuvoPPlCxY3OPMmRPexwzq/xqaAhBV5/pLor4IgKR0EfB+x+bLD91
	 d5Pq88ve+gMEmgaLZ36bJ8yu9uUuyG/HzsU0ZfAyfu+Je5YqnZVRZgfV84SYO4ej90lIb
	 vhl1z6YkYHAoKNwiW7o7x+dEU8D/ORiEJN7MQZay76/PBFvmJZ5bZvvKOerwQndPe67hM
	 xwC77ZZMaYGwfGkRljIJJDPyYSbLiNjxm+pT7iLWLt3jT3V96/joc9EdQ6W7RKKJeDorM
	 nNKvy0W+HFQ6YRbsdhWU7BZ8mxTgPcAU2sxjtWriU2Dy+YQoibS06M/7cDzKSrBx1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ehy0o0vX;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FE606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6FE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ehy0o0vX
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so369026e0c.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 19:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793851053; x=1794455853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8l8NznFr4i8f4HZg2RDz7wzmKDAun/MnYmfkpx3XMNA=;
        b=Ehy0o0vXAh25nCaE4IapKKrjJvR3e+NPZv7lMrousBE8IIbBiXWKwe2IMPbqoWfS3b
         ePctUoQkdusQ/F11Dx/mROlqEmqV17VEbgaKeSB3EggpQVRa9fEhKeknT8d5ge0JWrO8
         g3uOIhj58+ttafvEuuP+4kw0cvGdVe0xymVJCPz7eoVNapUuQHPZV2jkMV3g2GxWfiLH
         ru8sQsdEPd//O29th1W1MzSrM7mnWXqxZHNXf1tpsIuMYiMcBVQ/GsAcxrExlxfGsPBU
         YQJPJOwImELdzII9fspXYlPT66248lLmT66u3QyRB/optLjsaPhdhVqmtwtsQbUpx4dW
         ZqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851053; x=1794455853;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l8NznFr4i8f4HZg2RDz7wzmKDAun/MnYmfkpx3XMNA=;
        b=WXR47lyn6io2KSoUEMFvXn7N/zWXGJ9nMl+mNan1gBg0Qy+NxcposOXNN2KC4TeT4s
         yzBSyPW6vEP7cvXA67cCKQB3SPoSMHJdKwJ9Z0CTEZt0OXCDAnh5i/joSRctWYLEPsBz
         OFmxRS9Y+C+1Xa7xlYndDMOQv4A7oWpWhWa8gm4mlIUWkBtaXPqcGYKUQI0J1PYuOgtg
         c0cFEH3wHIyNcjnvp2E3NGsfl6AuSuFkZWfZpq4XB5RK/bjAjaRxz1pt2gDxLzGn/caJ
         QOY94zzFkwLkqyPnsb/ZWzj/oHTYRcqHgYylAis/ujXvmkR7r4zKYhBF1gAba5XeGC+D
         2eVg==
X-Forwarded-Encrypted: i=1; AKwUvBy2Ab4bi8oOBqNeXF2kJdZ5d1BrKBnE0GgXzrYi3WxvF4C1lSMOf3y5XmnAINHYDnJvWzN02hY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8//0wx7VXJB66Ud0tLl5wHV1aJpDj4Grn0d3v89nHt1+Jd6hku
	XN0XHtT0YpwdKw8a2/IsTH+O50UxgOpht7NFO9aZXvb5ViiujQSW6/+W
X-Gm-Gg: AYBFou3PQjAJZh+JT8ic03NDslULtsjiARFNuEby5J/d/+L1gUZVjYxuyCPxNWpkXo/
	z6gKkLGABrrAdw8ONNYPXRE7WZ3+ScM8ZzhuNWnJ/vLO4ymYATJw53lSHCAVEecSYb9Uz8zoiKw
	PGyhova1OwfA9PD82FKL3XXDCo+3k/WEvVcL7cwXCNeWdC3FQmc8/HZjw5TcMFvsKu0snQruiRm
	2y2NQ0Ny6eJDdspiMYfeKSaVZh1oKkSPWyRtkV8QN1hPNhNdYtPEjNGpH2MHKlaONgVYQZtAG75
	HNWksihSMgEkF2jTwQhTATc5VsYiTX/2VQwMEU5/rzMTOIk/3T67Upa7jfkT/2PYhKpSncT+xvt
	Xjc+9Qzm+UI6av6To+lLKa05L2M5G7dIt+oZwlzY2atcgMfAAT6Iaqbz7rJHuhvOCvsI+RaqxV8
	Iu5sLMgwsGMcwEhKu1Z6qVR71Y2y3YjHzzaBvIcucYHQJxUZQjwnRxyyUnrjgTpHR3newPgvTS9
	UEW5qo47irQpJ0zCnFIUO5rqU6hkchwvKJb16VxWaMpULv/6fT9PIgdeApOjVILPZvsbsHYCSkq
	ZCXQgyJM2tH4ghSTOMXbTJnvJQe79+82x52oYtAYW1x51P+Y+zbCUShXnhwyTZJic5pPauD0t2j
	dcCCS7zSwhXO1UnVnNI7BuzrJPlTJvuad2KLI9m7lMBAAARcS9IiNzVixLqCnOu/VZ9AhwJg=
X-Received: by 2002:a05:6122:398b:b0:5ea:ddfd:3e99 with SMTP id 71dfb90a1353d-5ec68976e2amr8457062e0c.10.1793851053304;
        Wed, 04 Nov 2026 19:57:33 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecb6d79d9fsm751342e0c.7.2026.11.04.19.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 19:57:32 -0800 (PST)
Date: Wed, 04 Nov 2026 22:57:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Simon Horman <horms@kernel.org>, 
 Thaison Phan <thaisonphan@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1915b523166b@gmail.com>
In-Reply-To: <20261103000712.658501-2-kuniyu@google.com>
References: <20261103000712.658501-1-kuniyu@google.com>
 <20261103000712.658501-2-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 1/2] psp: Check pas->tx.spi in
 psp_sk_overhead().
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

Kuniyuki Iwashima wrote:
> The next patch moves psp_sk_overhead(sk) from icsk->icsk_ext_hdr_len
> to __tcp_mtu_to_mss() and tcp_mss_to_mtu(), which can be called
> between psp_sock_assoc_set_rx() and psp_sock_set_tx_key() while Tx
> packets are still sent in cleartext.
> 
> Currently, psp_sk_overhead() only checks if sk->psp_assoc is set,
> and even without the next patch, if ipv6_update_options() is called
> between psp_sock_assoc_set_rx() and psp_sock_set_tx_key(),
> psp_sk_overhead(sk) is added to icsk->icsk_ext_hdr_len twice.
> 
> Let's check pas->tx.spi in psp_sk_overhead().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
