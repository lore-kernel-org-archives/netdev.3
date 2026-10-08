Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D049BD80
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463279; cv=none; b=tOkTV34WtC0MCZsdDHeh7144cB8c203dkmiOJn+tEcx+82LJGlC9tQ9YKPDcWcaapr8cifUlUfQcLc/hs3syygMGcrS7Q8U6yU0XT2A6hudfaO2aC+TaK9WT5rhbN7fxQicC8s5IwaCY6b8yfqJJvfAI1q9MytEEg3PP0q3Qmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463279; c=relaxed/simple;
	bh=qJEBQGC9eCj5KtCLTDsudR/tROhYukVxbLHo2N8daD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWco3URtt+Xw6IF8kj6Wfh5qjYHzqN0bgXvP+A7hn9sG2wg70diaJkpdwXxClVnz69X24pnyazWZuvnSd2AL04UflYp+LV4lRzhdL/bGQwZII+KHE3iUY5/+m7u44q7nYWCj8TjQ5S2U3acx3RslIcU/pj3TzV/AD5azsd7v0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiUJIL4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiUJIL4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283D61F0089F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463278;
	bh=qJEBQGC9eCj5KtCLTDsudR/tROhYukVxbLHo2N8daD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WiUJIL4pYbppRkg63ymBFGg3AkB9NUISE0GBOGJja4hGsPWgbKXDuF8eLf4xQ+Kax
	 tNQVKcTILCZ1u3+O09zy6tDGxiKBdChYw6sWmR6xJnIjmb28bw97fX+BfAuvxsvokm
	 wVsc/+TAjvLiz61jNnrvM1CWTlPZ1npl7lUXH7Eup02iImFh0wm+rYUgNLBkKmwIqG
	 sAMucqdIMeC/kM3fiqKoCd6guRLbjDk5YRvzppbEXkx0KFC171cngWyKEnGy94kqaZ
	 CY87w9jPt/9Qifo1EsJ1v+9hQGqQlEetlY8ZGBYTKxDkPua7wpL2uZt8uxmueA2oDj
	 ubRTlB9kx95bA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-455ca262ccbso2045340fac.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:41:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXr7/RQT54akT2WSAq1vigVxUs/mmLp0tt4dOlqLv/uHA7cE2fpHfrB7m5CVv1fClVWwXiGyw=@vger.kernel.org
X-Gm-Message-State: AFuF++k5T0KvzmIfHHRnaAWTg55qwO7l6hUG9pjbh//3wvv+2SOuoR2j
	8pOoU5Y3U2imZK0FfOhAE+jT1emzMui8W5KV+THtxqJDyjIFP5SCqPf0Nl9IxcdixjggEwEbjR+
	3fXvIQoaJvaJanGkOwMUgYk5brAQxQvM=
X-Received: by 2002:a05:6870:160d:b0:49d:f5ef:5d3c with SMTP id
 586e51a60fabf-4a25968a45emr4362055fac.55.1791463277409; Thu, 08 Oct 2026
 05:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008100423.1256884-1-theodorlarionov@gmail.com>
 <CAL4WiiqDffWyo7+gbffB2PYuKAbjboK7D=JJD+z=5J5MX=9Y3Q@mail.gmail.com> <CAEZyMPCUQvQ43P5sGTC_moe5boDirjcBS0E+-eTQ9dBBW8w_Qw@mail.gmail.com>
In-Reply-To: <CAEZyMPCUQvQ43P5sGTC_moe5boDirjcBS0E+-eTQ9dBBW8w_Qw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 8 Oct 2026 14:41:06 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqbKPQvO+vRvKMbKpEM-MsyVcu6YenwEoDRCGMUMM1hJw@mail.gmail.com>
X-Gm-Features: AclHuK9cSs47oI4uRMMfI4Rfa8I4OFoaAiNGanp6V6VnBtMS7b6zF_PYhJWXLpE
Message-ID: <CAL4WiiqbKPQvO+vRvKMbKpEM-MsyVcu6YenwEoDRCGMUMM1hJw@mail.gmail.com>
Subject: Re: [PATCH net] net: use the full socket in sk_mc_loop()
To: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 8 oct. 2026 =C3=A0 13:54, Theodor Arsenij Larionov-Trichkine
<theodorlarionov@gmail.com> a =C3=A9crit :
>
> > (Was it a public syzbot report ?)
>
> No, this one is from a syzkaller-based fuzzer extended to target nftables=
.
> The fuzzer reached it through an nft "dup" rule in prerouting, which
> re-injects the SYN over loopback with its dst already attached, so the
> martian check never sees the multicast source.
>
> A raw IP_HDRINCL socket sending a SYN from 224.0.0.1 to an address on
> a dummy device also reaches it, without nft. That is the repro in v2.
>
> v2 with your inet_csk_route_req() check, the changelog, the trimmed
> splat and the repro is here:
> https://lore.kernel.org/netdev/20261008114942.1376889-1-theodorlarionov@g=
mail.com/
>
> Thanks for the review,
> Theodor

OK, but given the current flood of patches, we ask for a ~24 hours
delay between each version.

Note that the Fixes: tag could have been refined a bit, no big deal.
