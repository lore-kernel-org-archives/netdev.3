Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC633FCB37
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357893; cv=pass; b=g/a0Spr8vbrgn734XnfQbH0Z8kttwfjab1XNFq30ywg0bNuynmVw4Pe2tdNXFmg2WCQeNbyYKWIae5Hmuz61y7CUirIayuiiI6EbgnhPImZyNHU0p9lls2pRc/XzzzjimxBBZj+CDczeuwkkz5VxG7xNWOGfnxxuFvp+WQFu7Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357893; c=relaxed/simple;
	bh=mpdFxm3cH7x/QBy79PiEOUh91yFexqdYbtc2kig8VZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuAkXq979olRjZuDr1/FpZShQa1JCToOaT1Y/mnQMLnJt6kVqhdH5aiX5HBp5mCzXNiPbR8dUBMNHIkcSUwkSBmS4awkjUdrChKOkMO7KnatPNryxRbBnCNzfmBfub9n+BwMco9R47qSVetm/twktFYjO8bKFcNxi50lbUfZXzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=VznJ5mha; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VznJ5mha"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1268274a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785357890; cv=none;
        d=google.com; s=arc-20260327;
        b=LwOX+YZgCeWU6XcvBmcjDTFCLqKY5yGHVM5ey1B7bcnH5gGPUdOPVuuY3sVtedZEBm
         pZovMY34s0mJPEueYxAs47j2uoteU8vfa/aUcC/dGriCn6adPwCgtWUvFr4ZgO1r15Ce
         2leWf3p2ZTR5asvWQyQEplhs3cey/Ze6NB2Lv6JbswM4mxqRXjh95bL6umCY0vU72NQQ
         7msm+tRRFJKGt2qKaqSC0qKEzlfw9jyi91tI2oDREfkURaE7d97aWlAyWgXC8CndVo4U
         hha3fjvlJNEhqxVLkJvn6VMyqWMMo+XV7Z8h5BfP4Imlvgn4qGuH3lhrXa/hivBNLj8x
         mwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mpdFxm3cH7x/QBy79PiEOUh91yFexqdYbtc2kig8VZ4=;
        fh=Y7ukfPuuXnEIDc9xfrz6bikNIgI9SCF3Ykqr/efy9us=;
        b=Zi7IxeRwqeIjbq0MY4boTDxf6K+1HxiPKQRsmorbKpINseamwWAXBEeUpsvxlFO/ML
         Pl+r7mu/m9XOWsiowIiHw9BM2BFwhrehG+XKzxiZzYoak93UsAL38eeJTyoKdqXVKIYh
         KV87Q7lrPCSLHnzv50joi8Pc8b7zK0eYOJm5m7s482ttwND7kPTcl6RzLyEb8iDNf7HD
         4hJ9sjt/8k8lYzCawWCIIYvZHb9tu3gwPBbPCDxSVfkxWw8z2IU3oHdwQWjbWrNDe+Ce
         EgmblhAs72uIkoPCtgh9anNXYOWsEmik94Bt1jQjUZOzJS6hqRUBbucRWXkf9orUKKkh
         DEFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1785357890; x=1785962690; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpdFxm3cH7x/QBy79PiEOUh91yFexqdYbtc2kig8VZ4=;
        b=VznJ5mhaOuVenHa0+vqUWserxUuKHJH1a4oHanag6byNJMex2WNKcDhRRP+VR6Pef0
         BiGgDZl8s5STfi3IOyNJLLGvRQXxtRTD3q/5BDaajGqKIC40M0KDp0OLLQQ6l7MKaQBg
         yhzkUkgzp7Q0zziN9tGhA69YWu5WaNGEzgf14FCoW7R3tu6eaqB0aoMNdESx6VeYekWW
         IkN6GE5Aea61/yRFG9DN3iB66pMLtdGYUxqZqNKRx0uLrOSBFqzg9I87Oa0VSOU1vTcG
         H1DhHUggt8WUs5p5+UhBCMnHQIPKmtaF5pNz4cglS2cjdnAk6ZHZCo2wOxeoMY3CYyN4
         bdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357890; x=1785962690;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mpdFxm3cH7x/QBy79PiEOUh91yFexqdYbtc2kig8VZ4=;
        b=cFU/uge4AvtDbyWg2SCl2u8oGQne7ZuyC2AcTrmYgflZ66in60WIwVetLdYqiAubNt
         Plgzb8tbkcR9L4rmnajWTiFDSRLIJvmygX7W3vqbe8LHNWP7yl6QwkwlbGAwH3B+fu5u
         KrGTon/tady/G44CqnSnD6bYf+5ofoJ5/tT9EN0VJolNAv4nZUoMU9nVz/xD+4REX99B
         461YSDAoiDLcwiVa3iURawGGengpHtyskQUeeIljdDd7q6THXEdLi8A28lX7v2KK9g/4
         vVhyvdpMCf3qf9TeKy+6p3uarfUKtc48VvBkQcyDtRr5JiNui/fVmqZ3nXk31Di/Itmt
         xMlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBeQyVwMq9odPkrt5BqDQ6/qlo/ggZW8W2ZFVUgATBUHJISm5f1SUk928B539+dvW43Xf1M/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBIIQplQW8YHpbY755h2idCNaWjYgDJV1RqBCJOp3mg01Vp1s
	APoLZiQglfbRVLRO4GvQJ30VAkO8T5WylVpY9UVCMjFSXvPmtELpVEECvJ8nFsRAC26gsYizuGj
	iFQKylEa6eN5J3HgOFbGkNN5mK9zv0BDrUVVIjOcPEg==
X-Gm-Gg: AR+sD13LS8a4VvYdrVnvDPePclMqlzcso+Qi2syNrK5c7vZxASWRVG7dt4QVJfSDzLL
	z7I6IQH/7C55tBThqt6/AWJ9smA4rbUTU5v5gp2Db3feKGz/kOLR3Dfn6PnGcOjjQztnqIdm66Q
	KZdxvGBLW5Yj3fQShr5gb+nfUTRzXCOT7DpFYWq1axfya+VY9F+l/kUxlFo0UIWRw29NYSpBF3d
	C1H31erglNhfxnuaNiUxS3FvSgdclCQSdJU2blqM1Y7LYeIUM6Qcf8uHNxmXfdeEQ6h1Ot46MAy
	VFVXupHYkUDK08r7/RUH5KpMzXmFOo+McHgfWjG2h7R8Nt1+F3gSET9IOBZQ/jJFClzA0Ld2CjH
	IY2gsexiqoo0NROYte1zfr53e8QFsG10=
X-Received: by 2002:a05:6a20:1d98:b0:3c0:e6c3:224a with SMTP id
 adf61e73a8af0-3c8ba5d8f88mr9255047637.37.1785357890204; Wed, 29 Jul 2026
 13:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723140241.132120-1-alice.kernel@fastmail.im> <47b580de-9d11-46c9-91c5-55eb13c00bc4@kernel.org>
In-Reply-To: <47b580de-9d11-46c9-91c5-55eb13c00bc4@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Wed, 29 Jul 2026 23:44:32 +0300
X-Gm-Features: AUfX_mzxMWpvdxAVyL3h3UH1AGjypdIO4iLrwwXAqUSW4Oe4-FmUj8hDWjnsjy4
Message-ID: <CAD0BsJVqmQRz1yNKMMWH1MT+kgVEh=wY=LOTy_ObeTDCsrhHFg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add a missing config option
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 at 12:09, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Alice,
>
> On 23/07/2026 16:02, Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > Commit 5cb53743e1ff ("selftests: net: Add a test for BIG TCP in UDP
> > tunnels") used iptables match comment, which was missed from the CI
> > kernel config. Add the missing config option.
>
> It helps, the CI can now run this test!
>
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
>
>
> But I think another follow-up patch is required, because this test is
> flaky when using a debug kernel config:
>
>
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=big-tcp-tunnels-sh
>
> Maybe because wait_local_port_listen() is required after having called
> netserver?

The issue is hard to reproduce on my machine, but I could reproduce it
in ~12 hours of non-stop testing in a loop. It reproduces even with
wait_local_port_listen, so it must be something else. The log above
(and my repro attempts) shows that it fails in a non-first test, but
netserver starts only once, before the first test. If the failure was
due to netserver not being ready, it would fail in the first test.
I'll keep investigating.

> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
