Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793650973;
	b=V7yWeoRPgyBoZ6c5W/Hi+XXQY2/FA4QZOsNtLSWC03lK0s+j3FgcbBPDKFt0BmAu4M35
	 0YjpPRY+H/V1WQ8AnPDUXsxvx9vEUWKWiF17DLHoeF22uMItxo0KW19PPtEm1pa5Nv5dJ
	 uXVfMeu+MIy6B+jY2tHltqL8oXWDQBOK+tLKrXtdyBa6Y9gVeL3yD95/2g1ybT3ldRAm7
	 21rodSJGrSvNMuVZqtm6JysF6IKML8EURRnA8cB1hbK7IwAdFDOJtlHjaQR52rcN47tYh
	 3IzZqwLzqDWBNaB40sj6d3rVUXWD+hg/es2fZEhBlkU0gTPxlhG/DxtB0nvI/WcZwTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nGgNd76Kt0jva/qUzoPfHVBqT3P4/TT41j1U9WFJiKc=;
	b=Hfk23MzKb7jzREJo/euoEPLSV46eDmQxbmEDdyVEvhqj34m2kiC1Aa8xx3TGg32miD99
	 bcJpe8eDdXptpg3UL0M7WiQjpvFq5TuZvi14RdLQabrSiSxOrwYZJjGIAYhiNr9h7r3Je
	 sXN9rHVXtTd3sJ8KvhXRybD9Tvz6Gy9NKV3zZ0PhrgeCNcJPK8w+rp/aUhI8nOhuvI8qY
	 +FrdoTg1UtGXcvS9JvGi2SmNgWT9m0nBG7q1wXkq5ZeOpWmknB4hf5qJhplRDCzTRcFRB
	 T4MX1qbXnYJprE5fnfY0pTu+aqqEH91j5kiLKHFwD7MHt9jyp0+17TIHV9D2tt3jTkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xuj0cyZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8D606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B8D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xuj0cyZ4
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1649a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:22:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793650972; cv=none;
        d=google.com; s=arc-20260327;
        b=RsQbV5GbWv3deDNJPTL7jxbLV6kI9L5SRu3wbeoMKpoZyS9A5xbTiNDs1QR17Gwhkz
         xIIZvRUoPRbkclJO/bWYMydcFmc3s5Ki56r1nBd/ibAS2cu8FA/pAjTkXfn1QRZYD+MN
         SZhf2HEwiyOFz1NGf/D50+Wax6DAwcUcAp8wFzMy21iAdWy+aF/ICvEqkg4x4hAKUXR3
         f4JVkhauSqVrOOwCmx418BjZLvm7fNmVn4cjGy6ND2z4ZFN/ChnN3kKtbyKuOvbEAXIt
         vD+FlRWXp5nvRS3WLyzHnEAV1hAFY4BJ19HY/N/G2k5ozHViaK2QEOlcog+uVuOs+wjZ
         kyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGgNd76Kt0jva/qUzoPfHVBqT3P4/TT41j1U9WFJiKc=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=WrDzQRfp8fSwLWVY4i1qlg+yG+pgPuh0SQE4/0SyZykHU8b5zHqsGP3rlEAX2CwHwS
         FqCId7qWgplbuSoTLkWkDjFh1fd3CsHpb1uZCL01A/jG3rIQkW39zFP6RKaaamx18eR7
         uYUlyF3VYPjdof/oIAGiV0Y/rtW3AbLTY7YszYlzq7f0AfNmo+LJFn46crZ/L4O0Kss4
         LMlI0KWJn4Ald333690eAwwmOQxG6Rni2OguLmv75JOfIZBJi5vjdxbF8wdKdQtsfAqQ
         0LB/qUc608CIWOTkiXSjJkCB3vsA21ERIfGARLQjlY9JIM1gpX8VlH8acA95uA4RGG5U
         e1Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793650972; x=1794255772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nGgNd76Kt0jva/qUzoPfHVBqT3P4/TT41j1U9WFJiKc=;
        b=Xuj0cyZ4emQb1iCBxP+MN2UJGJzsbWOms4z/k2g2RQzUR0FwAme4c5ZkYjCgOB2CU7
         iMeBNnzO9gjmOq3gRDuDFcNiXWDfChvkjvK3wfirDwEPKD+pdNpcVXwwF/ZC9DO6Afxr
         o5sPOMnYusljsvrxxu5b9Lq/8FpYF1Ka6bLAEWcZlRzMIQe2xe56by117331u530ceb9
         cHxgyIQ6hUKyUrgJCUfeyP7MyIsw8Sn4fRgo7SLgeEcWb5DYvaKFnFZinrrDjo0eS31t
         y7kLbmugsHME1CI/r+BjLGWUS4a66mt16RN+QagEcXFyq/NIiGYkBVaG8bqCWz35Fk+c
         2URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650972; x=1794255772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nGgNd76Kt0jva/qUzoPfHVBqT3P4/TT41j1U9WFJiKc=;
        b=Mkidw8m/JeqrAFcYTNNL6oc3xHAoPjJyAgeekC3O7ZHNxArvB6jiXok5OrlcM+KgMp
         Z1ukRSU1e0BBHC1Qy86aSnb1Zc5MAXT0K6jXZIzdXRGro5WoGCfRv3yLXORuOvzT/J04
         P0q9ZMTgA8QGcio3yyXfjiQr7JyxC2+YoOzdLYN7Y4+T9ZGlSd/yaXux6BjwFHczEe+1
         /Jp7muZR2THWYBPkNWio7sVfeHKuuBfW1QiluD2egQzPsfb8IasWscPKvYuM4+foWD58
         i/v+o9utWYpxKPz+4LbVId0bR9fn17vXOtcjPGsn7RQGGTF/uo6r7BNi7n+n3xITp3kN
         P7Pw==
X-Gm-Message-State: APuU4Z9KvP5YrUXUuEcOgwAWpjBNb+bDKSgVSBLGQBO0JwZO+oOtuIGW
	IXbdZJGm83tyRuu1h1DxuRo8G8hn1vm3IJIh9ufQ5phCSEvvFYRVNtxasS9edcSPQ7UCbwf5e5z
	77pP3trBS7VInl/23M8WIFLgSKoWDEiQBZfWqnd/I
X-Gm-Gg: AYBFou0VFI26aOT+Mmm/SkPN5xvp/2X+vzlQNjHDVp9fTS8vQl3199G1ElDFJr7WV3r
	mcJBAIlzIITekCC/YIMx+wue8GN4tiaTCyEZsNF0cEsXp+oq5MbQ9jezr4eCiwf2FRyGMwIf8R/
	dCddDbNSRQJ3U8kD1AGmQzOjYrbM1uzRNQ/t6SE8d5ezdDCkuvO5BZ/YVjuAUc82AIzqvrT9j++
	bmtulDXKmgbyZxAxZ8GipQqVTOUIRJ3Y6GMkmA5GX3E76O1epNPQJg265zhpU0+d/cB3ZDlUa0M
	/3NGzQwOdHd/7ldTZMC/K+msGDmhqLoo5+RGlft6yBKdMabbYdNzUOBJhge4o9DC+stwvPK3px8
	Cii8zKLt9xf90okQkn6b2CVszbiIebblty+nrnSzj91m4BkXpGmjkEa5xOE3y/7def4Q=
X-Received: by 2002:a05:6402:15d4:b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b539cf5521mr2845a12.4.1793650971061; Mon, 02 Nov 2026 12:22:51
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-3-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 12:22:39 -0800
X-Gm-Features: AclHuK-QodshQH_GCQKz7_frUweWOEIBaSlwEKwxSIRLVgKwE5w2Aav3CTXsWCY
Message-ID: <CAHS8izPefhGytGNeDWZzgZOi=gLeigZ63nFnkq1ERXXGwrNkeg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: devmem: charge the frag length to TX
 skb truesize
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> truesize isn't well defined for devmem TX frags: they point into a
> dmabuf which stays mapped for the lifetime of the binding, and freeing
> the skb releases no memory. The charge only feeds sk_sndbuf and TSQ,
> which limit queued bytes.
>
> Charge the frag length instead of PAGE_SIZE:
> - TCP uncharges in bytes (tcp_trim_head(), tcp_fragment(),
>   tso_fragment()), so the charge must not be smaller than the frag.
>   PAGE_SIZE only guarantees that while net_iovs are PAGE_SIZE.
> - Frags shorter than a page now count their length, not a page.
>

I don't know about this patch. The justification reads a bit like.
"net-iov charging is weird and broken anyway, so we can do whatever we
want. Charge size instead of PAGE_SIZE for no reason."

I agree that charging for net-iov is extremely weird. Neither of
today's net-iov types actually allocates any memory. Of course when I
was developing the original infra, I took every shortcut I could and
just charged net-iov as regular memory, but that doesn't mean we can
do whatever we want.

I think either:

1. say net-iovs are not really occupied memory, so do a global cleanup
that charges 0 for all net-iovs (optionally making it conditional on
the net-iov type, so in the future someone can easily add a net-iov
that actually can be charged)", or
2. change the net-iov size to be actually size instead of PAGE_SIZE,
and keep the current 'we charge net-iovs even though they're not
really memory', and then this patch makes sense.

But I welcome disagreements.

--=20
Thanks,
Mina
