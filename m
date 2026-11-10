Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298835;
	b=QSPM8Abm4fRe55k4UUDycXbQcminkc3W6yQVUp304QBUMyo98vQb440cLkdhg5LB7o98
	 wG39NiSa9phi9PNubwegpVWNU4snwGBRHCsA/jnzFWDCiglUH8r3rQ8OOUrQxPxLE5b9u
	 Oasnrt0BnaUTOAo2vbuBxxCyUfT3EDkInLbokAFmkdwt0a+MVECPtY2FDfbLFH2wZQXxW
	 xF6ahP7tu+jdnd4Xlz+aJg9xkEItMiiHQHeHKnFdpmJh8e8adzQKB82kp/0ESDoivxNHR
	 vKTXpV5/uYF9WcnuRsQUQS/eQZg4RI9mkCnOdkuJi5tqJlzUQvbapbT0xo/LLL5+LQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298835;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GJJBtOoZyfbcw9vYJ3AjIwJnWc5wtaVwm6uJ1XWEjiw=;
	b=NBY/DmUhWn8vPXplrNbijGQZxF4dd2XIeZ2OY4S67xzs7WuMoqeJKbmoGHmr3jtHzl9o
	 xJImgu+RA8j9NOzQx4Zb7BAmcb6HLBzaQcb9iKCmSVT3NRxgsBtsHgUgcddTKl0xN0Yyy
	 dH+NsMDHOEuF7GTSFrrhoipIBNQ8HAMlnRf2hAbGn68tjI/BZsD4tKa4Q8GgKaetpgpH3
	 QrnBfu6v1ZVuArsS3ymSgl/I8vsCTB/hCsHyFwM3Gb9766tzXCjRxgqeu/Xw+R4KdtZ0e
	 DvNMx52OJ+Bmt30tVGVbYEsPqUNVcYEKJHTvGVjA2sZ8E6WEZGPqcerHb1LsiBPWCqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBjpGpqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07E606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBjpGpqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680271F008A4
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298834;
	bh=GJJBtOoZyfbcw9vYJ3AjIwJnWc5wtaVwm6uJ1XWEjiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hBjpGpqddtvfd3/+do0ngbGw/TGaW8acIZrmbE0IlUaJE8IoV7M29f3Ilv+Y5INTe
	 bfVtqbJFmzc6wiTdYSfPAFYAoYwYKuYjnOQ9nBP0mtHYvnjOBCmxTP7sAUOEBnpD7B
	 Dq8Ecgp+O/T4hiXIHrWWYU7mg2uHcU6qmsCQbDjGeCLFncWeFCsWhxiV4I3uR13EDA
	 q1dMOuQgn2bgNaRTXiErpxLwr3sFSe9oKa0fGyyvK0Ib5cNIOK1JUD3ZUQ/d5d51lV
	 7yeqtG6DUNQqtc29PrX7zddEkzk5P7pPQ3gH1JSyDKSOEGAxjnl9XPNbU+Tc3Pm7cq
	 oaPBSOppePO2w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4adae187d94so1060664fac.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 00:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHZid4bDq12UzQGpdhKighJ0fPd/i3enWYhIenJbpjN8Ej3CF/DRD5nHztgaI02y9m8rd8bjwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8f3aRnJdS3j/cCyGL2sCJwhWXIqDkSUTsPxn9AMtLtGJeIAHw
	sc7oPAbcWX8nqBvY04C5hnQJD1F4FtkTMmTghgQ+tZNZxYK92/fD0kKeAqFgHii/h/i6+Y/TRs7
	BZ4CF1vS6PR3ud/ClbRBHOTrf9soDwWY=
X-Received: by 2002:a05:6870:241e:b0:49d:e4ee:659e with SMTP id
 586e51a60fabf-4ae2262135dmr1084844fac.30.1794298833635; Tue, 10 Nov 2026
 00:20:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110072208.3273638-1-edumazet@kernel.org> <179429558345.488859.16534342073147950836@kernel.org>
In-Reply-To: <179429558345.488859.16534342073147950836@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 09:20:22 +0100
X-Gmail-Original-Message-ID: <CAL4Wiio+i3nwZxK1AyvEvoNjRCv8rBC+3ggvzo_7DbOnts-YnQ@mail.gmail.com>
X-Gm-Features: AclHuK_rmdJX-rTYUQYX1H1-pUnjjkvd_Rf2CiSdSVrVSTeW5T8P9EZaVG8j0OA
Message-ID: <CAL4Wiio+i3nwZxK1AyvEvoNjRCv8rBC+3ggvzo_7DbOnts-YnQ@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: annotate lockless accesses to rdst->remote_ifindex
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 08:26, <netdev-bot+sinfo@kernel.org> a =C3=A9cr=
it :
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>

Manual code inspection, I am not aware of a syzbot report.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
