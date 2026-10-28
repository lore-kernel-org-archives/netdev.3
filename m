Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199854;
	b=ekRWfz8xzClNdIX0Co+NkqUzEkWIMKD3KWNNmafuIzMgWAsMLASSS9kFBn/VshFspUu6
	 Yg1q2VV7VPjp6t21540TrlsEa++8WQquYeh01/41pQ/jtqS+Csgnz3wgg94cIBreeliGy
	 UuZyGGT5lXKXvwYma2+qOogdQ+6EVh6tRLA1Xvi3IQkOlXjbPnL+B6REh2+Sz2qyIdopb
	 W7nTm3BTYnXF0qoaF7MqJpP+OWA4McR9LWkAJ0fw7xMcVhsSodNOWbnXzuXrAqHX5johk
	 1Vcr+ubjIZyMmmGx527Q39/4UxPaKbUeba216htJbYVbU/2OXoMDqakaPYJVw3Jvm5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=;
	b=DffiOGniAVLtoq2EtdbEcj/DOxrYx2ECEcsBgvyrtblIHERS5kJErgiOjhDeRU9mI8vR
	 H8q9gvfjI7tVu92dD5fxup6C1b14TtWsqNiM6UhrxGn5xDzSxklim+OycVSP9Q73ZTQKm
	 MjGaIttIk7jtRvVKs2TAv49AFqN/Mv4dy86cP+CtawpJ0BwlfhbRX/jKKKIuVgDCrlhDv
	 YXWCx3i5/xdlKrbLWNQI+hk/oPRJn0y9IOmni32NElfF8ThaNAiVSUu5gTagtrtN+sASX
	 HhWsJ6cjky1G88Z9YxKqnPYhhGdqrQBFe3UbtAatWa7s87SVfwIMnBourh4obZr1ooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.135
Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A675606A324
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A675606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx2-f7.google.com with SMTP id 956f58d0204a3-67a3d39e403so408985d50.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199852; x=1793804652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=;
        b=nLZ39PZVwL1PoPlygMJlIvcfGuuOPrNBWgv24ZKvoP+4t/gn+t6AfCvFVEtw91cRYs
         G4R3bB6IjLiZ0bZyeOk2XHgNpDFSKfgZw0xwVTbvXIr59b0KfqJz7wgoh+o7Gpkawwut
         o8H3JNQdNVwJy1w6v+dG6BEwXaFdn3InBqT6PYH0cLV9KYYFJ8Z0WWgckKSvYTmdo+xO
         m/7O88442GstrD64mZzKw1j2Zov6MKaQkjvZXJJbc6ZUEr9YsszkYk0FJ5/uKBk1x+0N
         bBTSrMzVKLUC/Oa3bY2vbixte9U3e1qfIh6Kac8HXnQz/MaycDPtIjd8rHvOcVBFVOd1
         m8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199852; x=1793804652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCXqgS3tOYFFVjwacZ7xyDyYJmCnOTH5vXf1QqB6sJE=;
        b=vSHRsHAx3K/sozirmuwoWIFWb/ymv/K9ToFEq2e1tw5bJ9zYSLwK1rFQ/8WImCibbe
         uh5nb80XFTi2d8oj0lfa1+BPWZCv9lWATdJOsckwbUF005FnLWd/ufpM7Nnbp19Jxa8/
         8PuK2xGo7NoDyp9O2me6yF1Uy1dTpgOkHycx3YU1x9PtHgNB6sGsK4dv4rEiUFb1JwZu
         9kui9GgpShXAJDfF4TGZAr0srl1OPg3KfD409CzZWZPLIG55Xh4Agn5kKAasXdp13ZwP
         H54Aw1aRWt2BkbYl2BqzZnYdRYXAq34uftbnBfDSfU26+UogDCDiewBqi97oJJs8jjt+
         J/AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiaXHemYGRL+Ea5Akwazyue+9vhxS6BhlHoUlzQRO0KQbVNQ06yODhe3ajzYB6JqJjLQzGV04=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZoXdqQLN8ZsREFJjiqycXDWonN4uCUU7sSsD9zUKc/EKAITma
	yTql/dX6/M28iqIWUqYDL5ORZjh08EUP3JKR76L3XuILhpyO9spBbRgn7WLZmhSi5AA=
X-Gm-Gg: AYBFou0fXWgwVVudkWa0znGG3rgJj6rUctXQQmaa4mfFbAIpJ8tp/C08uYHa464oVhk
	EJ10nAZbyPGEnlgVo5kMCc0nEi0zGnWTUPqwM5/s9sdg/25oRqxmpdei0G93AupI8y1VR3bGbm1
	cP42f5gan2u29aqh56Fei/JKe7iRNmFTvJafL382oepvP7j8SYCQWHJ6tgtOm7jL5aizNU7Gzy2
	qn6t+GBMNg7/Dk8BVcgkBgP/WYPZnfFiOYivczxmw2cpBK+d6DimmOXTPXkK1jJAH2udrZ6qKuA
	idl0h/AnszL6MottZPSHjwFCHDUUkf+wdzYfcHeVD3Yh/mhju3SaYKFMK3hpcl8+xI2bgdIRrTB
	aZV/cAotFO1S/h9nrAeCaFtdMhFoqEa+xbNbLgJxxDGOstjJ2JNDc/4gKg+JOC+ySPXFZ1CPYth
	MrhNj7VdrmytYQ5wro8p09/yVZIyc8a+wmZEE+FiD5Zix5kOhmCCEUcES1Uh6uv2xu+H5xj5QtJ
	ur+a1OJp7HPEvW6DNPJBdaUvA3vfQnjSXJy/gE9gcKH3UP06XqfMx70TQTsgB5lF5mV1S6/nyKf
	YwiOA91AD5uPVw/CxJJB2dZZGUaDT7QIV69P
X-Received: by 2002:a05:690e:441c:b0:677:d9d8:d927 with SMTP id 956f58d0204a3-67a7bebab48mr1814453d50.74.1793199852326;
        Wed, 28 Oct 2026 08:04:12 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a1887c9sm1801270d50.20.2026.10.28.08.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:04:11 -0700 (PDT)
Message-ID: <69b373c4-4a1f-4863-a1e5-dd8aeea7b02e@gmail.com>
Date: Wed, 28 Oct 2026 11:04:09 -0400
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
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Hannes Reinecke <hare@suse.de>, Chuck Lever <cel@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
 <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/28/26 10:42, Hannes Reinecke wrote:
> On 10/28/26 3:21 PM, Chuck Lever wrote:
>>
>>
>> On Wed, Oct 28, 2026, at 9:52 AM, Martin Belanger via B4 Relay wrote:
>>> kTLS does not currently handle TLS 1.3 KeyUpdate. It never sends a
>>> KeyUpdate. And when it receives one, it blocks the socket until the
>>> application installs the next key. kTLS also does not enforce the key
>>> usage limit on transmit.
>>
>> No argument here.
>>
>>
>>> This applies to TLS libraries in user space as well as kernel users such
>>> as NVMe/TCP or sunrpc:
>>>
>>> - GnuTLS sends a KeyUpdate after 2^24 records when it runs its own
>>>    record layer. With kTLS, the record layer is handled in the kernel 
>>> and
>>>    GnuTLS therefore never runs the check. OpenSSL never sends a 
>>> KeyUpdate
>>>    on its own.
>>> - NVMe/TCP and sunrpc don't have a mechanism to install a new key. A
>>>    conforming peer that sends a KeyUpdate stalls their connection.
>>
>> The design intention of these consumers is that they are supposed to 
>> break
>> the connection and create a new session, rather than stall. If that is 
>> not
>> happening, that's a bug. KeyUpdate is complicated enough that backporting
>> to LTS is not really an option, so that bug needs to be addressed first,
>> IMHO.
>>
> Yes. But Martin send already a patchset for that (well, for NVMe, at 
> least).

Thanks, Hannes. Two points to add.

A reconnect is also a valid answer to the record limit: RFC 9846
section 5.5 allows closing the connection. The cost is the problem.
Depending on the load and link speed, the 2^24 limit can be reached in
less than 10 minutes in many cases. Each reconnect stops the I/O of the
queue and needs a new handshake upcall, for every queue of every
controller. A peer that sends KeyUpdate on its own causes the same
reconnects. With this series, the connection stays up.

> 
>> The argument that was made that put tlshd in user space is that we do
>> not want the kernel to handle something that the libraries are already
>> good at (IOW, mechanisms that have been soaked in commodity usage by many
>> consumers).
>>
>> Is that rationale different for handling TLS KeyUpdate? I see that the
>> series adds back the HKDF functionality to the kernel. That seems like
>> an indication that KeyUpdate should be handled via an upcall.
>>

The series does not add back the HKDF library. It computes the HMACs
inline with the HMAC library, as the NVMe PSK derivation in
drivers/nvme/common/auth.c does. That is why commit 6d888db2cfd9
removed the library. The QUIC series also derives its key updates in
the kernel.

GnuTLS does handle a received KeyUpdate with kTLS since kernel 6.14,
but only when user space keeps the GnuTLS session. tlshd does not: it
hands the socket to the kernel after the handshake. So the library
cannot help nvme-tcp or sunrpc here.

Martin.

> Yes. TLS KeyUpdate requires that all records _after_ the KeyUpdate 
> message are encrypted with the next key; idea is here that one can
> (and should) do this in-line without stopping/resetting the connection.
> _And_ TLS KeyUpdate is done independently on the RX and the TX side.
> 
> This makes it extremely hard to implement via tlshd; we would need
> to pass the KeyUpdate message to tlshd (which is easy), but then
> we would need to stop processing incoming packets until we get
> a response from tlshd indicating that it has installed the new
> secret.
> 
> Which makes the whole idea of KeyUpdate (namely that you can
> do it _without_ stopping packet processing) a bit pointless.
> 
> And I haven't even mentioned that you would need to be able to
> stop RX and TX _independently_, which I'm not sure the various
> ULPs can do.
> 
> Plus there is the question why ULPs need to be burdened with
> protocol specific knowledge; why would I need to code hooks/
> handling for an extremely protocol-specific know?
> It's far better be handled by the protocol itself.
> 
>> Are there policy decisions that need to be made during KeyUpdate (like,
>> has the peer's certificate expired, or has it been put on a revocation
>> list in the meantime) ?
>>
> No. This is not about the certificate, it's about traffic secrets.
> If a certificate is expired you need to reset the connection
> to install a new certificate; TLS 1.3 does not allow you to do
> that while the connection is established.
> And handling of expired certificates is an admin choice, not
> something one should do automatically.
> 
> (The last thing you want is your root fs becoming inaccessible
> just because a lazy admin forgot to renew the certificate ...)
> 
> Cheers,
> 
> Hannes

