Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076533803DB
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622292; cv=pass; b=sb8BHEwCoFBwDuD3y4TY8IpAGpliZ0KbH0rnpnLcq7sRCRPbcn1mTMggulaiNofuMH/XMmTx1zzQn23qUF0mL4X6xVWN2A8xBc4MZMS3Th50ZnHm14NC79ndUuJTklykFrWqAnHG5WH0coKObcSaBByu/SyeekByZqoobTZUFhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622292; c=relaxed/simple;
	bh=u6d7SFXuP1ZVnuQoZ762H6ZqDSQEKstty+kgOiz1vSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQzXzWaiMDz+ijpLTRKi6qKQ0czaFZSZUy8X6B6JcVV/IRAxBBvZoozZdwonHwEF/8CeKBWgjBQcUY0j2YubEBHDiksGlZwZvKfJ062bFTlZR7k7kFuHbUUUPnZR1eNntFAb2rUbIdAogYloazub0I/70zQDCUkdSl0ZggBjWwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvwAxthP; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvwAxthP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1427a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791622289; cv=none;
        d=google.com; s=arc-20260327;
        b=PtN5N2dJZzSyEQEB89T7G+vNpv9TMyiRkCSgiZ2VR5MmafR7J5zyrYzNFWp0jHXZdd
         oIIxEO0HBl9Xt3lFdi/Pb7KCPHdhLOcPF+fj+HUMEEOjZ830VGk/vQf6R+jCiqIIQ4lt
         uAAee0at9hKjl3FWqLhgLYwtHHPWSnRHrre7HNT+hl1CLpl8tmS6U/G95IpZP9iHWbrY
         fUmOXYSNhsLp8UV9kfyUOpJ1bJyxtbJqRNgrz49+T7rwiqr4JjEJ06aM9HazwnU2PRG0
         GzNWj66YLRbkwikDXxF2hwsKGqJYVw1TMqRMDSYBrdK5Fd2DTFFfII2QT0Mrt4OX3Yd+
         fzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        fh=2sU8VTGr4ErOEM1Gum22Y1eqjpOt12hG/2OK0Ftr+xQ=;
        b=FEx4mdg94cnvCjy2NjTxpJrmy5Lsy+n+z8FSpudQGngxUV3gpnkzfr48UK95yRGpwX
         RhCZZRHuqknUKlc2eG2t/QCPyy3UFY0/dpg70BLsKUJn+ti5y7Ca5abmp882nnzfaVBK
         Ju/dO6Ig0AuyO02WD6yL30KTKg6vwUPoCCJKh5gJyRdoGWaEP5QQ89b6IBbKdqwK9LUY
         b+LMq8u2y/oYo9gz764jEUSS4gI7gVZFH5dKnEl/lEEYhzPBMyWxMiR23fm5InQV0him
         icTbdwm4/WHR++9mbZbSDgNRFDZVstsSCNtQi7E1oOZePdjdACvds7W0smb0rJtc7qDj
         SwAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791622289; x=1792227089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        b=YvwAxthPJyhOL4eFMPj0oYntTOJvVIk9w6WH9Kt1na3Q8Wgx4rZMnn9dxOU49RjCKr
         CO0sEt9yZ/E7IjKLXwLT5Y83fZ3rqqiMxVfKkAXqAtusxKuuSC3RJxzOHeb3JfGiLciL
         KFXvToowiYRZkcD5JR9G8fThOogDpnD+lPlzyEScANN8zpz4f5jjHswzU7leUSYxVWQP
         yFnsGOluSCCxaSRpXhIqn/dOweHPSCbD1K9BOrQXQnRqGJYKCM1GUaf4cj8TkSN13ayP
         YNc8Yndp9eBUghyyjftch4P6OF/fGHjktFbAfr2FDPxvVSLNB20orh0BWXSJb6kD38Js
         GBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791622289; x=1792227089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        b=PKEh7VEmvOodvxoO/RBFwwnRM1pA8Vq0bB7XUOvcXPfTzUn0CI8DhPKIHtqeUnTzME
         jP9e43Oog8O2xkQLuPZSTLoNroHrNMdUv2ggO1xAqK9mCZfDzsJOyphidkyxpgbcWvhI
         pKkCkCDDIWIjLyPSHVPFvR8PB4sQeIzmqiU0NomWK0iUlevh/kTGEWS3B/tohFuEULTG
         KbD5rIwFnOPv4dgKgMq523GF5cJJ2YEkXvIaPnZl6ItTWMENGihfBn1c9T3MxqMZARDf
         A6TA9RQHJxpDWv4yOMPEWIBlLnxZRDTzEBUPD0flNeONxLgedA5XBWx7Z6Z7c1u8r9wN
         oJkA==
X-Gm-Message-State: AFq9FYKrDkGtB2iBR3gPApcThnlY0PP0WPc66Q0jTGMl0zhZji71Y/9Y
	JI4iPmoZeXrhyKDhqJjmnVs867xYIUJFWtOIyl6o+xk9dnPWhgmcN6ZxiHVoEcyCuOOM9itYLRt
	aYfbGIAVrRl4g1tLjtpyEBt70zyRye92gbgOuC/Hw
X-Gm-Gg: AYBFou3gtN2Bns4ICRxjzMQnyGAkAP7l2DdzOm66pX5IHcTrSEfOpx50CvA/fQStf0E
	dQ1L9QUy/nXQ/grKfv+rLo9HOsXXZbV5GJHpGLe2IjBsDLgjJBtn6XBTyZgbkG5RYn/bwFNuD65
	eUXFocOQ+FoiULAQBIMnXUVVzhmjFCP0PU0e9xfbyWQVUvmMNrHW3ecCr7D4dMkj+jkFR/l71zY
	/grvfWJp8o+1RszokcPZ+YZetw3JWPea1pSvLOHBKWxnl9BbM3y8M6fdJMzpI3YNslQWJBrW1/H
	jxrXnzTJDXFzOrv9/kNzjQJWeQimgqwmd29+LB0dBHF08BO9Fseeaw==
X-Received: by 2002:a05:6402:c4ce:10b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b19883993fmr15040a12.2.1791622288658; Sat, 10 Oct 2026
 01:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com> <179162194176.2527009.17837283221529280785@kernel.org>
In-Reply-To: <179162194176.2527009.17837283221529280785@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 10 Oct 2026 01:51:17 -0700
X-Gm-Features: AclHuK_yiP687Fitsz3qcW8jp5keSTQlvPwHmngAicI8BRA9_47JLCvvHXQHfsY
Message-ID: <CAHS8izO=MW1Hy0k0yjm4HbJ0P9F5_oOQieLvFA5T4SzBDdDP1w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/6] net: unify symmetric netmem and page_pool refcounting
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Petr Machata <petrm@nvidia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 1:45=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I was reminded what I complicated mess skb frag accounting currently
is when I looked at this patch:

[1] https://lore.kernel.org/netdev/xfrm-iptfs-pp_ref_count-underflow-v4-1-9=
12fa72106f0@secunet.com/


And saw that the author was trying to write their own skb frag helper
inside the driver because core didn't provide one that made sense :/
code inspection + LLM written tests for accounting confirmed the
issues. I worked with the LLM to fix the discovered issues. Not hit in
production or reproduced organically. Only code inspection and
artificial tests.

--=20
Thanks,
Mina
