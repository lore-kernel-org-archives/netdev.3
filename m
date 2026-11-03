Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731083;
	b=NXwBqeYTccmnHhXwG79Wx2eeQbSKmTD4XwJVqaWovnjiP+ZLrVIOd0EU+Nu58BevkSbN
	 KH9k1atAy3QVLp+ChrLjKlavA+JsE4FCXlMiEVhLUeCIZcT4S+LD8tQV5AsylwChUeOsf
	 cUV3TJeRw1MK7RUui9r6IYTXEusNoY7Cbqt5paGI15Xn0NzZJgwKWiY6dhhuqFsR+eP2R
	 cT1UcWNp25JUVpJqbPKpUF+Mv5yg8naxpndPOmUiZu7Wo419GIoRUJ8O46HuKDjlAeU1t
	 gxdriP8LO/CGU78t5/jDPqCPgmV4rl+ysIZfKPRoukFbilJj8i5nHRsvnqNPk2cL32w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
	b=YFNDaf+ppJkdYzM+gQc+Wg7yc2JVfk4k6fTWnGuvrxQp77vD6aseAy4PR4+AdfLpIiCr
	 2UU2v2jLCNs0pWmezkmuXF2L0FuCNOHntF80fcBuSVzKbdGXnv41VTuYKHSMngnuMgLc/
	 9VUJAWnydQehYwA8O3hl2OssZPgtN6CAKNFOQmRp8ZKz5XeIR68PHnDDDxUWyukBW8n4A
	 TwJLxCgVzjLhTlj06yCbcwsmCktOkUMFfruQ9yloVEycGhvyk9M6nF3/B2aJObAni1vol
	 ipN+HzLOkYWK7Jh3tzkhCeVIKFtMLw1TIhYRAe7KyyWlC51cI/O8qea6Mx0pYG8rglw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076D606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D076D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nVCsNw0y
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so4779412e87.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793731081; cv=none;
        d=google.com; s=arc-20260327;
        b=RKlEHxWIQbW55944SuBBjTIZZo3rRMF9HLafFgZYsciCdNvR29Ss2nWxPRnKE7y/iX
         1r/sUprxdN3qcX241tfDOa4FiJTeijgDrEvT/RBHJQQE22BHm5mQAGNATlw48vQ27GOU
         uKoe4MDm/n0mtycjQOA2EG0yckY+zP4ErICZeE7pRdFlhGJ+2Zc9Eugdh34jtpPkm/l3
         b+I/WDo+UgUvw1KZVr+cv4z1mTr8l2himZt2Qub/TOro234eMqpHhZGK34IBu9rvssHq
         O9FH+Ui9ecoIS3hPTMl5UgTd7Qtl3jwnbAHViz8+VumrAyrGpIZko39cYvV8zQrdLrUC
         s85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        fh=s4LG9cQE69HhKeEGQIgTrA403F6nSMfrIvoxsX1Mi9Y=;
        b=LYZ3PPxpN4Qe8uwpEGZHyCUPzPfpT91oVtSRR3ZaFw/bS6rqVgydspsuvG62iy5YnU
         CqkfCg4Uj0R8Q1QT89XFacu8Y5SRWw16cVq6TXEQe//D6KpEpvZy75GMeKNdmlIR5uUc
         cnoHXIcHVpR1uHFopu4GJ45JnbFgndTWpemB+9dyEIj18ewVyLqdvGFlMaaDXlzde+ge
         jdqilSb2BGxwKT63CaF5eXlygnjD5Oq4eK8MkALGmopnsRvZyBoT7WyJAKpQn9UTxvog
         mxAYUWbXqgF6wBv7AuHfyImvlxq9WsSvLmmvOqEs3tkPppeWmWQkCYdtDHyVHcAiRwaF
         t6Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793731081; x=1794335881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=nVCsNw0y6hskrENSBv8EU3amWuYztT8dLT5p7AwDRfBEJgh5KCH4wcnDy1+4F8oz26
         mugE2B8LWKKCR0Y9k2Z98xSLZ5eNvcfR272i+te/45lnsb9AWyAtGJcy3D9bL7ir+f71
         qQpNmsSv7T5esoFkU7QTr7zF74lmigXGg9dzQbwmAGy2M5yd+bQ/6ZIx3r0WugxBJ5RO
         hJm/oKDuQExrJP3FUtAD2VCpRZdYySsqRCW8MbRDOe9JChKA+5WjiMn7EutjmI1dtjC9
         TX6PAuZUUq43suQ5ErDcrLsoaFbkM/WfFXDhbG1erayEtyXYdgmMQ2TL7MALbarBBDH6
         21vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731081; x=1794335881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fviwjroG//qntBAn39plNVA6JSIngXI7akYS02td+eA=;
        b=hDkHcIKwnwEkc5F7hpto/I/VqanryqYmikUD3nVoGaBmwJvGWQuC7/hRBt5Nb5cvV5
         0xT2ojB8Rqw+Vu65urDMut25woz6a+/kIrFAlxexVLH0dWeDq9GDYESTbazmZMdfkI+r
         zJUfTUnRK9Ngi9W+A7QMwroWclCA2CrfMZCP3w9jwRjiBw/iLHQrPTJptcoiu11UfwIZ
         yFgIAzdwTmgPbIjWIFFSjhxhIewq2YHUe31jbV2nvWH76Dx4ofO9+igSVswO9sbPneHH
         sUHFtiD21uvbMXupcXz3wpYDZifkLEf/qimQ/qFHmV2TClRxqY3g9dVqhojShE8oxItR
         bfCw==
X-Forwarded-Encrypted: i=1; AKwUvBxjviSpgdJmrUKa0YmnF3usn5vs7Lgpi/fgs1+hXz/E1bob6slBPivhCGVUZH8eVdWafQ1yFDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QaZS1XTgU+TgeNV/l25SIaxlN97rC2oC2+AZGI/QCXXa3ccyE
	DCWNtyk6IrLxTlOskXkr9MzOgM2x36+HhFvsBNpTrvC04xBqn/XsSRb6oLlP+5wMyzrnm5nTKGF
	hgNBhYkoKq2JJi1hpLzxQy7lmM1h1Oz7ax/mqCWSb
X-Gm-Gg: AYBFou2Vl128m/O0ODgwnADyIQeuemPbskHfO+vj1iDrUXAU1CI40asb6PNlbTlTMi6
	SHNIb+QaNLmLn23xmuQtfWkIJWJ+gq3vqhk5h/9rFRqr6xPlnaJFkdiESYNypk4Sdcona+OvEPe
	BoyVrzNoN4AK+OlicrZGaHeOHC7rgr0U54zeX6ujHTPkDJkaz6qTRWUfhB+EwAAk62qEjnTgZi8
	4hyBHJSDd7aaGxS4+rmh3BvW1j/Mui+MNuUo4qJkLlsIn4ljZiDWiDJ9g5pRl/AdzW41ceA0/MR
	XgWIEb/zW24kY8on3wusrH/+qTEirp+8eAasipNuiuN1XflRtiGCzgLRWebW4ZHMFo1dM8iMQ89
	eFn8cFjo/7q4nnKOxAO0pOH+Sw5TjLHFDYw==
X-Received: by 2002:a05:6512:3ca7:b0:5bc:e8b0:5652 with SMTP id
 2adb3069b0e04-5bfd9589099mr5147409e87.63.1793731080985; Tue, 03 Nov 2026
 10:38:00 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <auM32mOlBLu6ZUlt@google.com>
In-Reply-To: <auM32mOlBLu6ZUlt@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 3 Nov 2026 10:37:48 -0800
X-Gm-Features: AclHuK_sfbKF658HbwyCTsOToNn9cXs0qzXn8uaPUG4vxi_nXA5hXmjvbt4jwHQ
Message-ID: <CALCETrUD4vh_iSHV7G0bprUFU8=c+ECo701-tXcbQ3UXBWC1ig@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:

> >
> > Why should the task's cap masks affect this?  *Maybe* cap_bset makes
> > sense, but I'm struggling a bit to see why cap_permitted and
> > cap_effective should matter.
>
> Sorry, the phrasing here may have been misleading. Just to clarify:
> none of the creating task's capability sets (cap_bset, cap_permitted
> or cap_effective) are used to restrict the new user namespace.
>
> When I wrote "reusing the existing task cap_bset, cap_permitted and
> cap_effective sets on namespace entry", I was contrasting this with
> the prior series from 2024 [1], which proposed adding a 6th per-thread
> capability set to struct cred.
>
> In this series, when a task creates or enters a user namespace, we
> simply initialize its new cred->cap_{bset,permitted,effective} in
> that namespace to user_ns->cap_bset instead of CAP_FULL_SET.
>

Okay, this makes *more* sense, but I think it's too weak.

I have a sort-of goal of having the creation of unprivileged
namespaces be allowed in most contexts by default, *even in Docker*
(which would involve the Docker team changing their default seccomp
rules, but that bridge can be crossed later).  (In furtherance of this
goal, I fixed an ancient bug in newuidmap that gets us quite a bit
closer a couple weeks ago.)

But tying this mitigation to a parent userns means that it's
completely unusable in the single-deep case.

I do have a question about this whole scheme, though: are we talking
*just* about CAP_NET_ADMIN?  That is, is there any other bit that has
anywhere near enough security relevance to make this kind of thing
worthwhile?  Because if it's really just a single bit control, maybe
we can come up with a nicer scheme.

--=20
Andy Lutomirski
AMA Capital Management, LLC
