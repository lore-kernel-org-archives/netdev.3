Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494753;
	b=ZRtUGeRMx0lRqCXE4XppJAhT+876vVVUC28KMXHNmU4hCqjDeMJggcFfpzKZgNe8ySY/
	 8OEcGeSorbh3KgWX/zlmi+BuF1bXCXnGLJBJ4DXqh+7M5vl4Fu6AS0jE2mUcUKehVGoSx
	 GhfG9obMNeLknc7HFSk8NUyhtfRN8MBz/8AyZxHgOTNX3PyKZcpvlgHfL+UHOD4DVvM7e
	 gxfngihP0LautNTUmHxRYpMJ0YqxLc8iB+oX4KW++t8fv3YfM+JDG/h49OnjIHGtrssOf
	 IlUxgckoHpT5mdmMrxz5tssve2XVZfS5o6clMi16H+RwBp4gnxn8y0QQDWevcMEztxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=/wzsxSoyY0dwh32LBIY6rbjwv5tJyRh8dFNaQVlUF5E=;
	b=z6U0034lCh52WWYEChaV89hz++Ynaf5imDi50dpw7PrLjN+gOP4u5VxB38fo7RLNDCzr
	 LApTpywuf6ZKh5OYJpO23u1FUx85c/jTws1L2tipc9/BGIhZC+V4R2CUdfR1LZ1GsHWTt
	 UdxpaLb4zdrCYUhUGmbWSUaHRAzr7HbC4deE/WhMGryEchdeS62hxn/xwIEPu8ocpiNqk
	 ixCsDXziiPSUKhDbrX0loExWweKefSDMd/jzGdSBpqQCLWeAS+zQskSsBO3BJWTuFfxsZ
	 zGr/UVF3sQqIEws3/w9u/Y5g+z8cIrFOtjsEfKk2dBUdS10Qdsmst/GONybbfCI3P8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0jHoV43;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E00606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E00606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0jHoV43
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53397554beaso34509911cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494752; x=1793099552; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/wzsxSoyY0dwh32LBIY6rbjwv5tJyRh8dFNaQVlUF5E=;
        b=h0jHoV433gWa9Ypca1L4cXFH3c34IMnZgWaPNS7X+TIV6h4+W+S12MAgF6Tvk0SYlP
         n1kmEV4sCp+xT73ZfzJrgGeT73M4A5MaqybKiZ+u+HqwlUZ7QX2zumqRNDExqObyj07H
         17ieLwtb6rk7j4UdSHfHIAB/ROJQqCUZF3Bxw90LZ5umHxZuPn+R487gL3e2nL3SgpbC
         zRHB+Yu8JFZiKxo+vO/GTgQV/DF4OTJ1oXwy2AZlwuphnc7dZiHAB80C1qFTsqJtvlMB
         3/ff9aIIR7LayaXO4Tbt4+jR4fnUmgbo6vn0Rf1yIXGdKNz4AUACtQ0bEeGimbUnUnol
         pAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494752; x=1793099552;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wzsxSoyY0dwh32LBIY6rbjwv5tJyRh8dFNaQVlUF5E=;
        b=iUqeTCKfhYia4kJHzNHlLMwgbZfBVQ0b3kY1ol/VKRFXYTC9ZsbrDSBo5bO33BAqvt
         ZqOSK3bMiinyqiq4w6e9aEV4nm+qMMb/fSWifuEkf1xGQgi0fSRTClZubl8Hnq0OLiQ1
         2i2F1hVtI8SpawZqXtGaeZpoJHCWMOQTzhPKblNCNIi9/jjwQCcLc/xIBp1/EwRzeLeQ
         bRVaL9zN6eMzKJflD9ShRDKYbfcRcHtgQZiFqwspZw2sJ/W3QfOsEs66SBoW7nJB8pfs
         mKldZBj+hLy9Zlt6ci8urPOqAAGRLQQEpzki3r69HHhdjcGpLIjWzqElDw/s0aI1WCOI
         Aa3Q==
X-Gm-Message-State: AFq9FYKVCMd6LnxaNM2vqOpHia8BmKkN89eITCcLlotzLdDqgP1VxxG4
	AKoO6ETTOPRwZNve4HpVin7jg2q3APWqOMnfVpNQYtUXUSBYaTSS22H3
X-Gm-Gg: AYBFou2P5VRumy+4Aohh7/wyJQOk41W6rfHfV4/jiIZCCoH37LWODtGz76Sm+b3P5FN
	F6R2TIWeQL1lMYhaIxgS3F5hNu2SIL0chyGv3hvExtd96NfiU5A49XhZuFx57nNXwwFdMyGOrYP
	OBeHtFP64HOBemObnhnN3KXxdp4tOhg4QUqNZLbLQxWIvYQ4RbLgyzwB6oJBa/XSm/fzsfAkVm3
	H7T7AKxUaobXS1Fj62uq6fOzlX2NUdmBM47XbLJjUrnQRIzpDtaZosqvu60RuW6GwCLxYLlVC/X
	i4Z1BISzOVnRsST6jntmhGu6t8YE5UytE6OkuL8f30FvkkDdV6UHPlhrQbDe9iCkeZdlYUFoNBa
	ukwzk1Y3DJHXuYpVKLkIVisQA+JBHi4W1knJM3L15SXqXAz8tEVsYbvhVcgPz31ihhgLH9xRbVG
	GZGjkaJ7lRfDsdqo1tFATTKOjyYAh9NFHj3qosHRkwRE2i5oZi8P4ZbnS+BycjSrjQJWhiCMkGB
	Ts=
X-Received: by 2002:a05:622a:5514:b0:536:52ae:d92f with SMTP id d75a77b69052e-53652aee3e4mr127981451cf.32.1792494752169;
        Tue, 20 Oct 2026 04:12:32 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536448b6ce6sm96882821cf.28.2026.10.20.04.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 04:12:31 -0700 (PDT)
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
Date: Tue, 20 Oct 2026 07:12:30 -0400
Message-Id: <DM9MCWCY2RUR.25Q5JSF758J51@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/7] psp: support rekeying psp protected tcp
 connections
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Donald Hunter" <donald.hunter@gmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261009-psp-v2-0-5596ab50f677@gmail.com>
In-Reply-To: <20261009-psp-v2-0-5596ab50f677@gmail.com>

On Fri Oct 9, 2026 at 4:46 PM EDT, Daniel Zahka wrote:
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
> [1]: https://github.com/danieldzahka/packetdrill/commits/psp-rekey/
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

pw-bot: cr

Sorry, I should have tagged this myself for clarity. I'm planning to
send a v3 when net-next reopens to address some of the low level
complaints, as well as a CI issue introduced by the rekey drain test.
