Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149243;
	b=eXN3WLTp6EVdVl9d/lg6xNUHfaFawAjUtPqAlUjgSRJzokVez7d/gX6Kr/8pC7JloC9+
	 ZShMEeEI5/dycTi06kFkMd3VnC/EQLsevGGoYlf6ZbZwGjwp1pahP0CXs7od2RrMLIXnb
	 C/FsVdRzgj37iQ0tFbSJcpJE/DjDa+F+t35EhkMPNMwnESDTsBA7sdchxaPBs6i7fHZaJ
	 gEAe/4CnISxSE/KYcIkfgYWJIWUqPmDzSqGuxL+8yZgM6wX5gIFpuamangaSi5fhzLn5I
	 qIJHgNXMQlca6QRT0Jdf4Ux4rC+IT/PmmF91yG1DJlwyyl94kPYCnsdtnAyLBkle6ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0JULXnRo86HLIVjSE/ozuXF9QO2DLs0cXMWvTzF3qn8=;
	b=vrk21gUUHjBe5n+enhDQ7jqEVVzpK6qR0xp4/6EBmw5M/CP6K0m3HF1j0X5or08XpOOZ
	 YsJUgh/6jUeiF+RSY99nsDNX/EQbMlISDSOu7f3xqo5eaBccCGI2xN0BsajuHXKom87LM
	 Kp+nrIS7G/O9jX+QY1ZCnBsG06k0JgQ/PmczHRLF6ruvFhMfXpqebT3aryrzH3AsK5yKb
	 eTyAiY7B3jMXlQlZHOAd4XMpRX75BEkXrw6Xs9in1EMEok6wlnca9eri+FvalVC2BV2LX
	 6vmjpOQsdEy1AC9Dj4AQEP1L5jrnbAT5nibAuiacZ03UFZKsUH70viJWayyv1TUb+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z4xrUWgT;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DD606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1DD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z4xrUWgT
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso60078137.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794149241; x=1794754041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0JULXnRo86HLIVjSE/ozuXF9QO2DLs0cXMWvTzF3qn8=;
        b=Z4xrUWgTEXoSZf61sz94mFYlfQums2nt0QPefvmUtLCB4R/vgWtotFq9TLBLJEq4G7
         j1Rb+FGgfCN3jzYXibimWvaV9/6P4IBW3lSRcbgDZMqDuQudo7z+YR08qESm5dn1YsbG
         Gz3kKp6y5HJwdoQ5xAhy4CDbzlLIext5PVII/g7equldt+t1mgHe3Z45LkOAqeTM1HXX
         eBIybtNSrtnospCJ0R+u/e7ZHd4JvY0EPJQpJOavI/AnO/s8zQonStKKV5s9FXEnllUo
         rBmfIOfICoW086IicNKtlrN6/xzxExjJ/KjQWjuUeIwGWd2f8+7DwpGoIaj4uMw23Mr3
         xmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149241; x=1794754041;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JULXnRo86HLIVjSE/ozuXF9QO2DLs0cXMWvTzF3qn8=;
        b=HUfxuZv7C01sCca35VgJnfa9zJFWpiVvoi8RTgDX07nNcI4XxwfslyylqyEfExaTrw
         liOlzB0FtuSZXwGF9XJ8q2oQABMAXByWOAqYFdWHwZGpFD+SDjzEsafZPOZ5/IsoJ2Mm
         Vsyk/a84YF8f89VwJAIAEaRRj7sQbBgw7Jy2wc/UZZhSTty8DZyKKHyY+jJ1lagWAUTc
         4isKDZVagAXI2yMtBjNG+mEnB+QBhaF6xz0CvT6HprEdVJnl1xo9kaNeWAbVynLm2Yyt
         blhIK6yfTGVNjiAKWJnjjS/nynpII8NlntqJ7EM0qHZLDJmytop7Fpzhyq7dv+3Or5XC
         z77g==
X-Gm-Message-State: APuU4Z8ARDxPBqSIao7nZiRMA96HjWa5n9ov2uN6pmq9ZYP0t9+1Y4ib
	Y2JFyE32FrIror3nBOi0BzwVizbsS9LBkJbCG0V69pckY/aoTtHEo2cs
X-Gm-Gg: AYBFou0LC8ON5ITpWNxoWLAPeUhlj5CtydzwO25JCUli1+diGnpdqphaCstVsf6YO80
	1m7SV+pUWtrMHzdSZvD8dcefVpfI02vE6wMOqsOpYnEqJorVtP5EE3y1QwQcWRqMBVGkuSRMv+N
	z/tNNEDB3QBr0bIbMdZ+ASARCL0e85pW73g18PaEFAZiEjPVP2xz9mCL9Tb5wQa+w6Vja8+6tfv
	deEYgS6b7kkg6qVSgkMIcaEgdlzVY5DxFjQcn2Gl0F7m04HS/9woENgJUeFEOmY8kkCYevSSXUV
	0qpKpip0WLjINJ7Si7IDnsTkv1Y5TR7/+SWSpjZQESekuldfjaebXqjIvDoaTYVTVYG3YbaiA5j
	SAXR3gWrmAYMftD9hlZfj+j8tXgBhJyYagIpPMwN5b9g1pePQDBjZ4F7HQZq8vibjdlGNE4airc
	EdOhZIh3Sz+dre41gMK1tHyimZpQoE31Ry1eA5FZwMJyS1MB/DsUji1MwROyR2aHssYBV3HXRlu
	pPxlZcXALdmMgcQscSAg4ZQ9KN1F0SvLPdFe0n9TAfNE2P67e1C6OKuEXsSQPCgkNpHWIe8m8Bg
	wKYlJSViJwRryibo5eKH3UZeDMCxVp0qrlC5/geRXHgb8+uZcfxgTv+QjnHY4Je6T6W6lnngBHq
	eofrZ4ea+EzagZPyDbrl2lRqOiHfdJaXCIV4eN8mP9GhjsTwEp2CVumM1J2AJl423/otWcPU=
X-Received: by 2002:a05:6102:c09:b0:7c3:e156:da3c with SMTP id ada2fe7eead31-7d2db19223cmr459510137.15.1794149240821;
        Sun, 08 Nov 2026 06:47:20 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a28e4asm1839813241.8.2026.11.08.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:47:19 -0800 (PST)
Date: Sun, 08 Nov 2026 09:47:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1735f64577408@gmail.com>
In-Reply-To: <20261106-psp-v3-0-a8dd38f5a727@gmail.com>
References: <20261106-psp-v3-0-a8dd38f5a727@gmail.com>
Subject: Re: [PATCH net-next v3 0/5] psp: support rekeying psp protected tcp
 connections
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

Daniel Zahka wrote:
> A note on v3:
> To keep this series short, I have split off some of the content that
> appeared in v2, and also have planned future work that will make this
> feature more robust, but not necessary to start. Here is the current
> queue of follow up series:
>  1. core tracked tx-key-count stat and SADB drain test case (from v2). I
>     see this as able to stand alone as a series, and I also would like
>     to report key deletion errors, but will have to touch mlx5 for that.
>  2. core to end grace period if BQL is stalled. I think this deserves
>     its own series for human discussion.
>  3. Rate limiting rekey uAPIs. This has been suggusted by the bot, but

Hey, I'm not a bot! :P

>     whether or not it is needed depends on a bit on the deployment
>     model.
> 
> Original cover letter:
> 
> The PSP architecture spec states the need for rekeying connections in
> the event of a device key rotation. After a device key rotation has
> occurred, a new rx derived key needs to be generated and sent out to the
> other end of the connection sometime before the next device key rotation
> occurs.
> 
> Because PSP connections involve two different keys at each endpoint,
> one for decrypting ingress traffic, and one for encrypting egress
> traffic, there are two types of rekeying events that need to be
> supported. From the perspective of one endpoint of the connection:
> 
> 1. rx rekey: we need to allocate a new spi + decryption key pair to
>    provide to our peer.
> 
> 2. tx rekey: our peer has provided us with a new spi + encryption key
>    pair which we should use for encrypting traffic immediately.
> 
> In the case of rx rekeying, there is a period where it makes sense to
> accept packets authenticated from either the previous or current spi. To
> deal with that, we allow a psp_assoc to remember the last spi that was
> valid on a socket due to a rekey. If authentication state does not match
> the most recent assoc, the stored state from the previous assoc will be
> tried.
> 
> In the case of tx rekeying, as soon as we install the new tx key, we
> have no use for the previous one, and it can be disposed of immediately.
> The only catch is in the case where hw uses a key handle in tx
> descriptor state, as opposed to inlining the key directly. In this
> case, psp core needs to be sure that any of these unaccounted for
> references to key state are gone by the time it tries to sync a deleted
> key to hw.
> 
> To deal with this race condition, we introduce a different path to key
> deletion for psp_assocs removed from the socket during a tx rekey. psp
> core will use bql byte counters filled out by the driver to determine a
> conservative grace period where key handles can be disposed of.
> 
> Lastly, some test cases for rekeying are included that go through key
> rotations and rekeying.
> 
> There are some packetdrill tests that are queued for upstreaming [1].
> 
> Future work can include a time based rate limit on the rx-assoc/tx-assoc
> uAPIs to prevent an untrusted user from creating lots of wasted PSP
> assocs and consuming SPIs, SADB space, etc. For now, users should use
> network namespaces, or otherwise not present PSP devices to users that
> could abuse this.
> 
> [1]: https://github.com/danieldzahka/packetdrill/commits/psp-rekey/
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

For the series: Reviewed-by: Willem de Bruijn <willemb@google.com>
