Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794356392;
	b=VXR91p3fLvD3qrTXO/9jAIsWh6obBbupEpA67EHsqdofHXVx4uq31XZbCJBuMj1FXWJw
	 GDskYvg+ZxayWE3xrRWj+tYYuf6lUiQpF8XTQFnmBC6LgZQXXhNVsDnBC17wUDnZCmFs6
	 2+rpsWAdquhDomikyMTIrhfGfVYOplmp42cAJ9/H99kQ9TH59URwCvYXZMsK7aHY5xWCw
	 V04Cfi/Xyjg2PXL7qdB9WPHXAQriwfB6Q1rpZSesu8rrMSe1WJ3BAVH6htGw13it00ybL
	 2C+ZWPOBvdLHIcuPKmR//HmJn2KzDUi7nuvjO8zY3tlMKBmV9OBmoDRR20QGx8dT0jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6Zwo9AHcxIV1PbGvndP9vQegJQo63E0CzRQOvlWjQIk=;
	b=VfMt1l1GQeTO4LB/Ii366ySwC5NhQ8mkP6Erl6XZ7goDIzfHlql7QkTGncTifW17YoZI
	 aq6pLAjeiWyHLUGOHTk3N8VN4McyLms6nMQa37ZauCWO08O+bxYiAoZPRnqO2TB2grEQL
	 Krjvf562MTHDp3/d6mQodRUTTQulgl22xhVdkrKq4FoBpYuGu1AAfZQTZgeFkc+/JPBnz
	 sre8STg+XwZ2mzyonUqWz5MaPxsNMG6XA4ztCMQLEFbO5P+MTTIGreZAGAeQhgt8i6Qil
	 2s2BLRltsThuTGweX5uLZ8A3j4X/msWrjsxjqao+/tEugPWsJ+TtHV1dpaFI59DtOdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWa7xEYx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C77606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C77606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWa7xEYx
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so4178275c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:19:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794356391; cv=none;
        d=google.com; s=arc-20260327;
        b=OT06+C3HIDNOqknM49FQlN+TcsnwooTssv1w2JeYb4oQpFUjkrX73WYMQrCJJRL4xH
         mCYx1KVeMvT9QFYrEDhWNadnhLrLNouJUpdx7tEgIty8ZKdMLShesX6hEzu/8Te7jotF
         /44f3dWbcGwz5J5rxWIG++y4JC79a2YL9m3YVRIqwsejWmuV69ftmuFD8LSNuFbumWTR
         5maZn88jyDTCBpSqFwKpm1VXpb9/P6q2ArNlSLKMFKJKYC9kqMB6eQ75KQUlN2Cg5kBP
         NDqXzlOmfaRV2HWDCB25U1cZMB2eCgGG5Oe92uu3nRBMitCAKuSc86lGE2uWQKVwGHjt
         5/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Zwo9AHcxIV1PbGvndP9vQegJQo63E0CzRQOvlWjQIk=;
        fh=CkXAlJ+U9LBEQibacWBp2NBMdzv+sz0aF6Ld+i45GRs=;
        b=NiC0XMX5NpS9PvIEO2Ixg0TmVe+rw7yrqUxDmdS3tVEYE+NgUvuCfnYcMiK3++uDN9
         EPjjouWOKYGEFnRhkmob+K5uJMJEoPtwvBOkJNVoP6ceOP+velpipX6fE9u6H5GHgJfN
         uPuklto/BsRuDvNnNwOr8FBFNY7XqCUP6Y1azxcFVIpoCqBu0TAhZ/CWDhC6V7vvDgA7
         RGJCKFQfzJNx2SdA203NhrOdXEG7Ihw9SzNIMYw8BzeKIAsB3RSbqixuVdZifGxEY9NU
         qhfARv2XjwLfR68p9jq+4xTWIWHm4ZVxsJ0dWXL/I3UYN50aFI4OKEd8urcXXrRLLbLU
         OOZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794356391; x=1794961191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Zwo9AHcxIV1PbGvndP9vQegJQo63E0CzRQOvlWjQIk=;
        b=dWa7xEYxBUTo3celsm3pB8DDkRcuypW3MFf249sft3N75la9khJM1eduxnxPfSRg2Z
         sGfE5z9AuF8WcflGD6MSQBaZ4y38BrzPS6EYn4VuCIaiyv3VQR5Ts4+vM0Fsyicy0Kf4
         wX2ABxlWw2E9bv0rm08hMjrA2DDRQKP0ece8rYRM8351murdlghf9vKTSXetunIuq46m
         8liEjV6JVQYBimHaPfo513tBr3noOtw2zpKpXDg3ncJ119qXpVqpUTkHIRy9tTv2SYcG
         sETataP+TcgSt76nYMnZI0JclmiQO3zUe7pOvWL68TBC46kDxOdI4DSoyE/AfJcff5vS
         3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356391; x=1794961191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Zwo9AHcxIV1PbGvndP9vQegJQo63E0CzRQOvlWjQIk=;
        b=pGZ9V00CPf7rtbwpOeDGTf0z/XJT9QXNwJQYXZ69SdZiwnyFz1GzPFaeDRQaFG6hSf
         5/mOrU4JNax9w45G3BFq7ad7BFv8kv7Vj8OlnJ+TgBzlCZhJ3u0rRtV71iTTSemAHCyd
         dAgJ43JTVacs2g74FHoHiAqxV318BgTQHVRfWoD7L0j4FTGbHQmHd3ncIrjWxU2VMOQ6
         B24cc3/bC3P1jWPGXHvY3etX9i50gT0m09xShMUcvzZYzDSbb9cXhR/yCI3lWKDc1hX9
         aSz2GbNwEZ9zJPTTj/H2Jiz0R/sQJsO0caqFg02AHBFjNRKafRsdbSzUn6VqZoPqHn4Z
         52+A==
X-Forwarded-Encrypted: i=1; AL+hErEE7Vv9cXaO4S/6VRPIN5Lb04kTo5jTmgOSizc9CGeQUosjQ5rG9qAMYJNBV5BPRYcpOb5KRrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bCvVhX9hQK1vX8Xds9BiploWErUnkzwuW1+nxpl6MbEKdxpMU
	YHt2IE4oWI7qjvSw8zGfiKfAXXcGPH/vclia+cca+nqchlLt1uJpz9VzthxV5kcbfSRc6LmP9JM
	LhiRCO8+frRM20VDUTrjdraMAaA2WEoprF9Fz60/J
X-Gm-Gg: AYBFou2nHHZUIDw1HAazOgjRs3NJHF9Gt05KSCJUQg19ZajGmkp5mkPzv2YobuGwIMw
	SnDDHFJbv5fmQonTxNch/unkCIoXNuh5X0bBzNKrwofDHF9wMuRRdBBFxtQmwzAIEGmzmYbgNzL
	l5RZLzfKM/6XBRpUlCfLihw1Wcu2ht33Q4vtiZEKpylXgtXusSFK4GIRKVZK5bWRR9D3bf26L17
	yAXe2F4u/VYWNYkoXdRdQqnOICfMCTHCZwO+alENz6ZMyIENOxQn2QShpaisAlVj0F7IZ3QctVs
	18DJrj9WiHmaHfWylhVXjM0YyH+5r7u4re7/M0Nx9/b8thQCLm5gToZQmuuFktnYeSLTF4UsZCg
	xk3BJHPf56oqi6KznANzW1HLwfNX5yzHPwbHc3dA02apYZ2hzvA9Oj3001ulUhq9OihNx1X7U3k
	mswZTSzbvVkI1e1Ktjj+XMec4fBAMesPdZko8ZWwfmrUCt80NSZ1dgWbVNfSnMHFByKB0xD8vO6
	Jc8qo97U8hpfqj0/Sj55hH3rb1C
X-Received: by 2002:a05:7022:1582:b0:1b2:558a:d781 with SMTP id
 a92af1059eb24-1b3c02483c6mr957756c88.5.1794356390378; Tue, 10 Nov 2026
 16:19:50 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105212905.3122712-1-kuniyu@google.com> <179391463924.488859.10033550397120765032@kernel.org>
 <CAAVpQUCYHbdAdfxckQO=T5L8Y6896SZynJeGFUwP9Hv2dXDpTw@mail.gmail.com> <20261110152541.04462dda@kernel.org>
In-Reply-To: <20261110152541.04462dda@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Nov 2026 16:19:38 -0800
X-Gm-Features: AclHuK_4AqhqVXIVIpwO4ZFlFLZfJSm2C9JIuAsWXpHlR8ERbDnbEJc4TPX700E
Message-ID: <CAAVpQUAyV5XRhWPTKMumbsjgZssCCna6qc+PAMonaRj80FAdcQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: Fix memory_allocated leak in __sk_mem_raise_allocated().
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 5 Nov 2026 13:45:21 -0800 Kuniyuki Iwashima wrote:
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > >
> > >  - Whether the issue was actually triggered, or is only theoretical
> > >    (e.g. found by code inspection).
> >
> > "Found this while converting sk_memcg to obj_cgroup."
>
> I assume you mean to imply that this sentence answers the question of
> whether it was triggered, but either I'm too limited or it doesn't.
> It only explains how you find the issue, which is _not_ what the bot
> is asking.

Sorry, I assumed it would fall under the latter category by
breaking the line (not before "or"), but I should have clarified that.


>
> > > If it was triggered please include
> > >    the symptoms, like the stack trace or error messages.
> >
> > "Then, if mem_cgroup_sk_charge() succeeds, sk_prot_mem_limits()
> > checks are bypassed, and if mem_cgroup_sk_charge() fails,
> > sk_memory_allocated_sub() is not called, leaking counters."
>
> "symptoms" mean dmesg basically. Please suggest better phrasing,
> if you can think of it.
