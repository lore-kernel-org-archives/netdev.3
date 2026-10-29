Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271837;
	b=vBwPRWuVcnNbFIB10rLkXg97cTZBr5WK8DV1H8AEKBym1h9h2AWIgCmR2aY2La8LuwV0
	 VdKKeRWU6sEf4TQ0pLIcbV2h9MgYJahuUcvkdzuaPHAGYLNuDRabONr5Rhd8EIqjiJYfe
	 pAUVKEvofWq/5EdNQ349E/hR7Kw2/L0oFAjd89E/6P8DHzbIOcUeB38kLYYxTWlbNioqH
	 W09HLL2Cx/JgxcUOTx2XIZPi3Vi963J9nCF+2m5tM6F/inwJPY0O1OiarfhT2670hI01y
	 soZh0m768JxFasfqpW+CQZ3TEA7Tqczo0V8puNhzw2ZsK92ps55kt6lUTzF0C7ajSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=muSquEeptmJIsXJiarZANV9wpj/9lTOSCGNsvcEZLTo=;
	b=ZUE2EmKkGHc+/AR6LtVmun9G4ZoCY7r2A7y3qLqxT+qzKgHJc5MnfHDPA0bOBjzvWxyy
	 8emRLf0gSdwpfMwb4N+XLecBTBJnOjhL/h/dKkoKko4viVcg0TEPFFl4xh/1Z6W4XGxUv
	 p/Meg0Lvc7inPccDn9gnwVn9X6bY6M8CHGqPCUCuHh4obB+Ui21aX7/LovOkvbVOqcZmh
	 /TRK3c0Py7GHH66Yvo3UxmBbm9ucjjLCpB78STDC63gqJRDrcpzHyHdybgE8BvL+FxWRy
	 IOe61I96bpC0QVwk12AROop4aKtgH3BWs6NusduNqrjpyJyjxUtVn7Qep0uVz9HFd1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qvHinnD/";
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA4606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6AA4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvHinnD/
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f269e335eso228843685a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271836; x=1793876636; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=muSquEeptmJIsXJiarZANV9wpj/9lTOSCGNsvcEZLTo=;
        b=qvHinnD/zBOohgWrBCPjKhxrCzsM5HIs+nI4rv2uerlKKl4bAfAogD0nXVnEzVc6E7
         /QPewiKO5a3PhClnv8wrwJHy4hWNsd1N5JOXDhXrYiqwfGGWk4Eyi2PRTbkOn3EvNE3f
         bzHsuT9CuuNzS/XKGTdWov126Pyo/KycEqR3JkcwfoPBdxwZTjlGWmqDWC0IvPb+STt+
         vGUc2mxpeYiT/o6Tt64YokXfvgkLvmTzniUq9524kWyfOGfzXFS6Jlm7VFsqFI74uP8N
         glpJ7XJu/M2le5uQVgKOhgpK/u3vfnmihOyeM3U3AOTEBBR2+q1/ek6cNwxtoFZVYwLJ
         xtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271836; x=1793876636;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=muSquEeptmJIsXJiarZANV9wpj/9lTOSCGNsvcEZLTo=;
        b=H6Jst+iqfMKXrSFBIyETKIwi8ls1jNtWFui4xGyalAO/aYvFT12X4/Jsvjr8UwXucx
         0y/fFncX+6BI9Ywi/kmbbK4W0FIAr94knuiGEzORd1gCIRkTV7WEO9cwS8b33nxfQV98
         2P8wRpzZnUqHeJUJcCPBEtsKt7+56+196Lfmm0jqdDQz3ao+n045PnUVCLUGORSWJv1b
         w1MzNo66f3aOJLAdGP3Zxq46yPgUX3HSFzmsggBz58WlgXwt37Djz2txRdfw/64v+VXk
         8ujjBxuEua4pfh4QeNqAZKkF4d8HSTbYQY6VJ7kEGdz9cyRlFqjWQz2Ei01cu4NM9XLQ
         PgGA==
X-Forwarded-Encrypted: i=1; AKwUvBxRlyYckLEe9LO7ZCmtFiItxAptKBkYrN4RRjU3B/j+FuB7kwPaLP2pLbznA9NzoBvrIm+vDHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLPFEUObRgeIBPGL0WiOo2YGt+0MMnqPpVHWHMJkhXkLBY34pA
	NGQG+riuKBNlx9hHahF4Et6VtfJHVO+bjqvfN8+hoVFYCWk3IdJ7Peeg
X-Gm-Gg: AYBFou2IMaWEU2f1a6PAnDlABaZCNjpH10ohR4m0QJfmTq6T0mSjrQYMixU5oGDRF72
	q5IVlhmZ/tWsjbwfl3oQbXWsSCJCOsrajmTX0GlESPKC72ozoUfvDgoPOpnA+mjyhB0d0zDyPvw
	hHdIoPvDfkmyXnc/i3CLKzUb3nHmT/6sXJvi1b1b+fneqoj9Hr7D7CDOJwRMYPWJGw4ue+gRHO4
	xiW5UX72BVRdyWHdYUUdc8I4ieRPfb2vv9YomziLZc/ceaXoSqgjVJmcczBCMtQxAYIdcLlc68/
	TsubMQsX83hYt0IqcqBlqLMU9HzZXVntSbo/Lxg11IHuuBP2r4y9g2z8LGpI3HnUOj3BR6S0/rG
	0VbH8yhENl3iiPQa2u18xON9D38JndQIFh2QVhQSkf1+YG/8WIkMz1y3CxcjKgx7E4EfQAOsZgX
	Dq8rW22hLnrC30eFqRwBX1tJoP0M8sIBe4ntIEjtgt2G1U7vq6FWxDgghD15KKlTvSbpV0Sittn
	//yTDz9wr/FsYtPzb1n8yH1tGUksvLvZhtuMn+pfupokfPePX3n/bN53417n9QyQwDYqijhsjph
	+4oYQGciSnENjOU7TC3ljzWVwMueIV4SOg==
X-Received: by 2002:a05:620a:3183:b0:93f:2c95:658c with SMTP id af79cd13be357-94408a7fa2amr789388085a.14.1793271835721;
        Thu, 29 Oct 2026 04:03:55 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05af648sm1506079685a.1.2026.10.29.04.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:03:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 07:03:54 -0400
Message-Id: <DMH9T7NY96VZ.X2G6APCG51K0@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Kiran Kella" <kiran.kella@broadcom.com>, "Jakub Kicinski"
 <kuba@kernel.org>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Donald Hunter" <donald.hunter@gmail.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan" <shuah@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/7] psp: add core tracked stat for
 outstanding tx keys
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261009-psp-v2-0-5596ab50f677@gmail.com>
 <20261009-psp-v2-4-5596ab50f677@gmail.com>
 <CAPHeo3erVfzLE0wTmz4=0HKWdOL63+7W2KXO67OuEfRXhf_M8Q@mail.gmail.com>
 <20261028152950.6624ee83@kernel.org>
 <CAPHeo3c0RP34ASvzV3UrwDa4PvXHhuAOq1+-Bn0Z5+QXFV+BpA@mail.gmail.com>
In-Reply-To: <CAPHeo3c0RP34ASvzV3UrwDa4PvXHhuAOq1+-Bn0Z5+QXFV+BpA@mail.gmail.com>

On Thu Oct 29, 2026 at 3:14 AM EDT, Kiran Kella wrote:
> On Thu, Oct 29, 2026 at 3:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
>>
>> On Wed, 28 Oct 2026 17:16:17 +0530 Kiran Kella wrote:
>> > > +      -
>> > > +        name: tx-key-count
>> > > +        type: uint
>> > > +        doc: |
>> > > +          Current number of Tx keys installed on the device.
>> > > +          Only visible if the driver stores keys on device.
>> > > +          Kernel statistic.
>> > >
>> >
>> > Maybe it is good to have a counter that denotes the number of PSP
>> > sessions set up on a device, which is managed in
>> > psp_dev_tx_key_add/psp_dev_tx_key_del operations similar to the
>> > tx-key-count. That way, even in non-SADB drivers the user can know the
>> > scale of the PSP sessions set up on a device at any time.
>>
>> AFAIR the thinking was to also implicitly flag that the device has
>> an SADB here. So this stat should probably be called tx-sadb-key-count.
>> We couldn't think of a reason to count the tx keys when SADB is not
>> present. Rx keys? maybe, because of SPI exhaustion. Tx keys - why..
>
> Tx keys to just provide info to the user about the scale of active PSP
> bidirectional sessions (after the key exchange) for debuggability and
> for any other derived scaling/performance metrics.
> Especially for non-SADB drivers, where there is no device limit on the
> Tx keys that can be created (of course limited by the SPI exhaustion
> on the peer).

The main use case I had in mind was seeing how much of a device's SADB
was in use. If the usage is high, maybe the user will have a policy to
not even try rx-assoc (which always succeeds), just to fail tx-assoc
with -ENOSPC.

Total active PSP connections on a host is something I think users will
want to track. I'm not sure it needs kernel support though.
