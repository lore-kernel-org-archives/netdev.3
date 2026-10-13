Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19854145F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924758; cv=pass; b=ohWbtSNwOkq1Sxp3v5HBtGMMWqIauQ2EXGovN3yio2/HyzBd1r9vxxaCos7LsEuBJo+v2/cVxHVGOtKkwvIjzRUhDQ4M8aT2NsuSpFhE/O9hmdBF5s7IfGSXxjmhP7d6/8mldOtQ27jct4st8MxGfU7ainDnSBvQqZu7qPUVgZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924758; c=relaxed/simple;
	bh=/vVh4JekJSXHTPyscsLCDkMqYS00gf29hChLgo3TST4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiZKZMPT9vQUKkLZApMzAM0v6D345/oKiJPqLaaFZQXD9MiZtNUivt+yQGiIETxlJb7pg6yBXzZaYNTAmMBJ9GdXpBjDJMS9Y0jPVtx5z8kxmoTSsJ5PmAXCOsFyAZS7pFuF/l6DkkYiz10qYtxlgqvp66gZ9rKVViPVaP+TWaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2wOCwT+; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2wOCwT+"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c33cc572e6so2444508137.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924755; cv=none;
        d=google.com; s=arc-20260327;
        b=g0tpC4hPU+RpGL5DGIuB4GDiRmEhrxw0P5+O6u1Kp3BKL6TLIS39LntojiWKLH4/nJ
         dtYBGdLSU9QtK9aJYv1FP3q42NX0hwQan74UfS7mK+mNdD6aGmLydmAl3TheRq4oWQSd
         WZ8VRyTDTdfZBcS6UnSOHhfsDBxkWuPvAcsyTDe755zDC9mIWBEN2/qsfG7Uaq2J+6ia
         BOyi4bF2UsU0rJpN8AtF9eWC4BqDZ2KqOq/f19emxQQTYcW4JRZ26p4RbYoWHKm9G115
         XBCsMW9180D6AQx6OysgOuA2plq3sH9g20ihGJoMcQ2zu6/8j+iNv8LXOax6HYErhkZw
         gZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        fh=nmV8RPvv1SDnb6bZrKTgUYR3VWuHcVx5vadCxbZfWHk=;
        b=F6igd0FxgwbpxjZvXaIegbRX8jfZ/1ujX4z3xfgH+3yKPm+V9Ak3mEhjtHj1WPn4iR
         jhXJYe5z8DeXH3B4z6Ok0rKZ6C2fIIYOkuUcIt/MXvKx0mFrzMbn8iEDrbyvFHpnUHAO
         5lhGLgYz9V91MLDvP3TTaYt4Xku7uOwaFHf5IFYsFJ91S5ZG0c4A4zgiWTnbxOjqqykT
         LDlGx+UW60HvOsZOAWoKON3R24zBPS3p2j97PIjwf07B6hJaWzXesNn33j6TYEhZxvMQ
         Q/hzRWvQDJ1nQIxplkrIo23LJG/1zAqu8otZJlJxJt5Mjcco4hb7dE2KfZtHS2CGRFk0
         uPsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924755; x=1792529555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        b=q2wOCwT+ztWfw9vBVnTNVbs79q5S5GB/c6SjAvezCMkrFTmEhD9SK7XFDX2jaI49Xr
         93ZMp2DP/vhqHSHcI9RWzDh42pl5FL2C+p3VBNzvC9nTMZ+JhujbAwGANk8vK9uHM0Du
         m7fJyAVlzFJoyfzZAQfQVoZl8i5o6J+tjULOtLqi15hLc1DpjwomKKtzDpmtzfvsyWUz
         yWzmAh0S19qVANRVnf9dEkTHWwC7JeStlMp6juSitFiiNw9UhXwwBp+jOwFoO6n9O0SQ
         8lYz6HV2I5IibYp73NCFh28+L+NAwg99/1BJ2nCJhQxQjP7LK5Y1hEvERZN1Dg+Bzv53
         2Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924755; x=1792529555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkhVrgc9OmPuX9zRiI9eMYevNzdxLtYphs0y5uGuLPs=;
        b=PWO5WALW1yn+W71Z6VH+P1Unlj4wJ3gxG09tYqSITtDL6PHTJfLiACWMk7RXCRrNyf
         dccwWcn6ijJCSnr22E18ksrCA3nH0JDW9ItBQIdxSD8fR34onLFsJWcPbbYHK9BKXvxK
         TAqXny0iiVPFwNSo1Tbo/cRPvu7RzdUtK1MWkf7TqN1EokGPCK/luIczYhRFlRW8+87J
         ofA3+LANZVd/E2P8EuuxMejIcgDg1rU26ojEkN46jQf75pFCK7FrfR7+qVt0K4ogLEmi
         aZdh6IrpPr1jjO/5Ks+4TmwTvod04KOOWCaPb3Rekf6CK2vVlsJ30xqhdoB+ZLBUjT+/
         Ip0A==
X-Forwarded-Encrypted: i=1; AKwUvBwnkgRzRC0J+QqcUBeYcHFjepEVXmBuI5tOeFfCgZ558qmh1p4h5Nn0EY3XXeN8LLy6udAFytU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKugHTyuX071FUXtXoAPQKoIcYx8UT93eHaime3rTcwE6T72syv
	K576IWssd300Mxj+kNzoGRk1sifzDjqkWAp86SPN3TQuQWydViQ1mM9E7VHUS9A8XWqHFGkT2NA
	jqs3SjFWgmsvF3IWrOgqrTmNQQKEp6So=
X-Gm-Gg: AYBFou12gn3y52GMjr/DbGXyPt5bvhP5HBZhYlAD94RrdBuy/3ndTTnh+oxeV55tzJi
	dk9ACi7hDdHRNYin048Xest6mIWdVzrGl3PsWj4bhNYTgcTWXPbGN9StOWdkEBq1BGwdxpmH0Pj
	e/8N+qUl2vva1Uc06XIxOLn2ISjGF5uTCaO4tyXazQrp4HINyMlhfaKvWnGL5gUo5nzaDu6/F0A
	pJVUTcBYPaA/LO146eOGmVrZI290tRmh32n6vQa1At8Gi5ViEWOH7nFszzdw7OOQ6cDaIw3RHhZ
	qbo5h3J4Zg3TtcohaUrdAVBPgmWltNwZJt8kNDR/FgQuS2AXaW4TwJVCjIu6PKIr6SH7xdmgkPR
	0x+EBF2wef21nNditk86qEyjc393CA/kFagwCww2TvdHaul63tlIW0Z1MbKz4rCM9yxrRrx6JPd
	A0eUYwQFw+RswV+GKuLRJ0J/dqTzR8BPxlRu0YdgWpg1zK
X-Received: by 2002:a05:6102:b11:b0:7b5:8fd9:27e9 with SMTP id
 ada2fe7eead31-7cb42386482mr3026014137.2.1791924755421; Tue, 13 Oct 2026
 13:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
 <179192400014.160550.9046457038671470723@kernel.org>
In-Reply-To: <179192400014.160550.9046457038671470723@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 14:52:22 -0600
X-Gm-Features: AclHuK-F24utQ7hdbiPLO7cynxwSmEL20qXjDzlC2RlDwy8M8X2Q-IY3WKxAQbk
Message-ID: <CADvTj4oKGOQ9rgqbqVxxyx=LzzzEwf4xpJas_r9omeU1yS3y_g@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: avoid duplicate XSK TX completions
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:40=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

This was flagged during Sashiko review of the larger stmmac recovery
series, then confirmed by inspecting the existing TX completion and
teardown paths. The bug exists independently of that series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The duplicate accounting was reproduced in a local KUnit test under
QEMU using the actual driver cleanup functions and AF_XDP completion
queue code. With three completed XSK descriptors, teardown published
another three completions on the unpatched code. With the fix, the
total remained three.

The practical trigger is bringing the interface down after AF_XDP
zero-copy transmission while leaving the socket bound. No allocation
failure or hardware fault is required.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This change has not been tested on physical stmmac hardware. Validation
used the software regression tests above and ARM64/i386 compile checks.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
