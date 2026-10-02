Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80D47D44F
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935589; cv=pass; b=PW94sueg/ZXkGyVD8YPPFOLN03uW+ZL4hSjSdQDLKd7A19bk8n4ivDLbgRaGfSzkmX3+cYjPzXoPd1b2ROiKi46NLF62ifNLWWlIQTrhroMWu6DUiQMvzxnAeBngIpbhINfr+fk1vk4LcNYoY0edADU8gLeowJNW7VbxiGXMBFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935589; c=relaxed/simple;
	bh=gmmThrJvDx6E/5siZJqxDO5qT13qL6bZJindI281JSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM5WMLVJ6wHccnMVLBIRresi8oHD2FcJ5CvWxu9ERxyOaY4EX5QGbFZwTXUgimnXrXEQZ/vpDwEQ+/Um7Gn55tRqXyCjdYUG4AEHdl0wkCU9NstQoPQ4v6IlP93m/LResA4V+EikQyOcRqcHOyfz8IopooiZHSXVHAeBcYJZF9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epO5KDgd; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epO5KDgd"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7d702c76so2617342a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935586; cv=none;
        d=google.com; s=arc-20260327;
        b=ILXptMTXzMW0O/woZHfMixtXURr9F4ZAfc7lXZirVk+dG//WbGbyhQ+yo+vc8JaQRJ
         mNI+rGkyxQ3Cur17OUDkz4AD6KXdxZSmd5gUGhbv8cJiB5eZWJs9Tr/B6gCKslViNDPy
         spAs5f3e/SgVQg55D0vs1N66PJ+rLbVxUvZG+oZ9IIMSWPFJl0Iixd6pNXh5DASVggS2
         d2iRkbaDcZ7E0ucjNUB0MCRBwTCqA392clF4pCk3VfqKuMUMXxDbsS7n6QOydtfBsEN+
         1Zi0xkyRrM3EqByosd1QChGg4yk55/vNTTWp5sYREyU4aXvimdC0Zy/H9HpBQ9a72JUC
         EiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uE68pqUdgB501HIODogSgxT3qz6bLjZb6VtyoVku90c=;
        fh=Vt49FwxZAg7EMToqkQ7nUblfVdJT+9O9jiiBs30sa/I=;
        b=hqwiexkmYW3bQKGSSDwRsZ+1kv5CrS1ZNAAO3mqNY/0jbmmqVz2sxipiIsZgDVYyaY
         NRBvEewmMAIEwGe7Cr4PVZUS6ZnGlOT0VnEXq+7IuOYEi+kmMKJuIiruk82rTUFUyP+C
         mELgIIOCRCitg0OL6SBMWEqp0q4dFukL9Mtr4u39OTtnuSKPGwkRiBwqxY3NU1y8Mfmo
         rB5fkmZIkA+s+CJDZxd9xDEwO82PcndlEkNFsNl3BI4PjRp9fz9pJYw4KVAQHgQKCWyQ
         ftpkxfqp6TXl2sgTvnbdU4upVZIdixyAVelR/ATdWLpAGXD+oDjNj9TVFBzz0+ao0YpI
         MAqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935586; x=1791540386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uE68pqUdgB501HIODogSgxT3qz6bLjZb6VtyoVku90c=;
        b=epO5KDgdxoUEOsm+bOUGUZqPkAwpBQ6qGKI3Q0KmFLfAqnZGFX9xlgGPT71bjT4C+0
         EU5M9NzD7O5tyh9gpQSVV6kwVWa6m6p1frx3F+GkDArVvG7yYV77LnpDJkOjb4Bbl/i4
         ks7WJDQe2d7C1KL13pPz66eFqGbLTvj1ZXMB0BfOrxoUtL3JtOA8Kyhr+QQkEXusVOkY
         ob302smIiu/vJP7w2SoCjcXv8V6XFJdZzUG+rQi3DL++tvgsq62oarvJmAflKUtEZPBn
         4TNJozGSRhxLbr1G2OAkbQHSyJMO3E4S9MRzv4LjuN758HT6XXxWssVePhAGPyFpjOOm
         OdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935586; x=1791540386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uE68pqUdgB501HIODogSgxT3qz6bLjZb6VtyoVku90c=;
        b=EZQKjQe41iA3UE+gKCHsGVZRCt9E9+GRPsfocX42qaVxa23iXlKrXAH9ynXUm5hLa2
         bB+Pl7MBiNVa+aFS2dWBzmirZ6hWrAKXvXvWILgK2lFhO4xZi5lSLyU+ajKEOwbrjBKh
         9gHqJScpo6DXCgKa6SDCsDsGKqf8cN1Y9FeOS8ZHLvLaoOUB7S4kyK+5yZBA+nbkF+Et
         9vUq8LwZ/IBWqhjmgKJ27Gt8ykPUqeBVvByH5E0LB9Kp01NwI9MRFaSGUqf3oVm/IrFE
         tzCvoaw+2YZIl5Zm4PaFhKQOoNd9ZKmjt5eszhed6RHFJK9j9n/dygWvLdHnIyfcStbj
         o5Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwFSLsrCj4zwJs81xQ4tl//vc4P0siwM+qZ+KTBIuDDD3/g1v8vmc1LMaUWn5STdP9ntAv+3DI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg9YDL7I6h2bI46pa4KKL3cU3g4zMD8ypmOR5pjrvQlCswxgLc
	Bp876JYxnhzfhx9vN4TxtcflHAoodbI/W97TFH85574D10AigEtPa1uumiHhhgEzVbEvb2nj5Fa
	rdcLC3LRHRFGtbw0gCT/slJc/PXf7Y4g=
X-Gm-Gg: AYBFou08Ltkp8sznrdmkyMIRMUKAQOA60bgdtsvC+Sm5jV07ASVyUHcU+VniYm0Jta6
	ihXmaqCgZ/fofYJXcjAKCrn4u5FeV7UMV5RqgSmc8BzGAdi+tK1Lv8nswDatseoDBUJiDX5p/hF
	3Tvzl8zORxiAZQjpBcFqsIYajaZ96zjDFlqForaX/Bw4g5u6DV1P5EydQy4AYMjrjy5cqLGfA27
	GdUe5W5IX+ix71Eqiev2jn98sFEqcFlIDiqnM720xwumkFnhssIusGdKEzAwk/bcz6LsJIT2KPV
	PcZVPFdpBtTf9rNMVezVDt/YcJRlhi9BlOhZc+YAVx3+dOTeStPGqmnFqSPKf80fAD2hJhvE4l7
	fjEjwcfykyHX7
X-Received: by 2002:a05:6402:1908:b0:6a9:9522:f87f with SMTP id
 4fb4d7f45d1cf-6af9e320e56mr1486442a12.41.1790935585981; Fri, 02 Oct 2026
 03:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926090039.1714460-1-bestswngs@gmail.com> <20261001182326.572045-1-bestswngs@gmail.com>
 <20261001160958.00a95918@kernel.org>
In-Reply-To: <20261001160958.00a95918@kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Fri, 2 Oct 2026 18:05:49 +0800
X-Gm-Features: AclHuK-DuqEHJWA_x2c8da-Y6I8oMIIctXWrMoUX8UHFH0_s4ggmWmgZgdUAJu0
Message-ID: <CANgPUi0-OMgEfpFmWWPr4RgXMiFfupBa-n_JNzHy_PemP_28kQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: team: fix transmit skb ownership
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+2cf741c3005abc20@bugs.sh, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=94 07:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri,  2 Oct 2026 02:23:24 +0800 Weiming Shi wrote:
> > The queue override path can pass an skb to a lower device, see that
> > dev_queue_xmit() returned a drop, and then reuse the consumed skb. Fix
> > the handoff decision separately from the transmit result.
> >
> > An AI-generated review of v1 forwarded by Jakub identified a separate
> > broadcast-mode leak: bc_transmit() returns without consuming the skb
> > when no port is txable. Fix that in the second patch.
>
> Do not repost just for this but, please, DO NOT post new revisions in
> reply to old ones.
>
Hi,

Sorry for threading v2 under v1. I=E2=80=99ll post future revisions as
separate threads and include a link to the previous version.

Thanks,
Weiming Shi

> See https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> --
> pv-bot: threaded
