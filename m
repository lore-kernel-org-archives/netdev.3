Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609769;
	b=QNArxBC+fWELZNweOGHEI+llbkzFlfNIDXJWVfvzZNYtehWvKMIHKU5xvsohpmnO4tL9
	 fusCJzbBYpcKDbZPK70zpTqYMkZbZhYmC9hZeMi9DFWnsfys5JAcNLb9PPZBugWy4TJ9E
	 KoxtlNeJYziXiuwuJ0Sw2X9hkBswL1iQtsErIPUWZwXePZMcDPt2Ti16Zv50tLwi3Qh4F
	 yK++bBNojDCfUNZ29zXxHhDb3h21Owvp0Nhvx7DhrZCKstBXzdgJ2SpiFuZ7c9PmL/7XZ
	 WKXemkTs4OQpo97Lkp8YxFeqHSMol3GmbwC8Ry+qSqB6hePuQYJ6hdGezczZlfK2+wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
	b=41oziL2fGlIy5vAOU9u+5IacPtKQtYDkrhGmrMXZcc/ikpeTwXOecCw+iEY6lVn0S/YB
	 AUr4+SC6Y6JxdrmEyXSvuYZhKMVHU68W2uGVObs4fhvLll6r12KjF/ejM+M5J/G3HDvRk
	 HJc3l14BV7OXLTcca/kdgvtEI371qD8hs9ZSoF4UkICmJMupAsyS90ie4h/7eLH3nyGlk
	 SJQWtDSncYWhU+8GEViiHMeK6Sv7pHO5LHroLuoUxm7XZ8+1VJuO8R8i/T1UPhsy9K4mI
	 HhzyAQprITlFkGkHV1sm/ECqY+M+cbeQeHlVYptzKZyhuLxDjAd7I1htxb6pACL7F5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJW083KS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE6606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJW083KS
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67489c8202cso964622d50.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609768; cv=none;
        d=google.com; s=arc-20260327;
        b=oiKYs6h98S4ZiW7bIjeKVGKt779iwNXkk7xhXckveWNZMy4nxgUzLyYgHLpTujoPCR
         WwUMUbckRbav4ArUxNGs299TpREsavcygIHt1rsvmnXVPCYCrgwmeD1P/ZFYVxBNato3
         lszBxGEy3wC0CdfU396diuhJbLHUvHIVD781UJMTAUsnxu8NmNAqya584zVbxkqzIxKY
         ktytUk9aLCrjBg8bahNhC88sgnvug6rb9nNqTzwgqRBALdaStch7BXLbVG4dQIT+/5p4
         0Js3xjOGNqFCK3hvivhm6OjJS105I4/lSCR4FCIl80JCprO8gTm6SYpOXl3ypdTBMsAS
         TCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        fh=E8ItXDy2g3KAr0kXjr9Xx9S0R6X0SQSsyK/2keX4ovs=;
        b=pcB3kQZcN1JvwDWSCLQuu8gGxo/O0EBhnNqB0h6QSxtk4n39tIqZAttvMpmCsBs896
         CsjALmLBPB5ZyjuyTp4siq2kfxGONYMaQEvUXl/12mU10jql4MMs9HK6bVIwGNR3hMhb
         ibr0dIfdPPgnMrARY71pqKl/cnM9Ss85O6RkQHJmIBGfT8VDU/1QpHaPbarFXq/J4604
         kAub50DhM+D4qCPOrE4VopYJjE4Q758RGEsqt+Wjh8TDq+x0lYkv9vbvvW0N5tVo4XK4
         wJc1uhPBbKwfjZdcW3q9q3/CZL65MPqX4nwmyB8cyY1HSmFVHAj81IcehGVNz1xJp+tx
         6UIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609768; x=1793214568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        b=FJW083KSn1VUn7MrgFasH/OzdbUwqjVvb4YWYOmZ9GeV4J6Tc2QQ9PrMYGR63yIShf
         b4etRlqON09weOqlry/x0R8rSN5d9Hukd4dJR/j+iXck1GwKerOSXAE/ZuTA27Uz1xa4
         vmPn1WAMIvZcMPxt3ys3jnA5ZjnsLR9BmOEV2HCgi0qOrQL8nuUUZsbmBXVPuYxCscUp
         ehzjDIPMT0xEB6S/gUrqL29Q8cPXryB9Egd9lFoe1BM94GRcCm93R2Ai5+C19w8g7MEE
         7jVEY244CP1pYcFMDf9xAuRfyvdtvH59XpSAj8lhEouepThjMf26MCyhvAnzJO5JCay2
         LOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609768; x=1793214568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        b=uD456c3ZsKnN3rCg1Mxjlr6wTPHXBanLB+yZQIG/nQm93vREIzi1AsTJHs1V220qI+
         lDKiGRtPc6DjhQN3xLG8eHlNgTb+0sPp2xN/OsYBHK7BbqBv6ziSQQaS/GDcU8OSm75d
         BdUy6/VOVWDRfmiXV8dnwdYxU7Sgv75m+KSiwAiGBIZ0IFcAtavyofISRgFBHEdIMHfo
         9eYeDgNBNJCCx9WHy5kQ9i08gHwso3ccrImnKOlcTzrIHhw3/CiBclPtQfdwIMj5xZ9o
         M1NapmVAPJFELhqfEaF9R6mESn+loSXzan9MlIOvdHQuDNfxFsyd8WAfBV7UB4ZMEoKW
         a1zA==
X-Gm-Message-State: AFq9FYIypq1DVbBmWdAsH9ksQWfQR2TkMCNTC1I5BCxp9ZVkFs6PBi0B
	GhiTP/mIdKdLAwFxRb+4fc8wXkztxvGhJ+aETrglklfgraDrB464gIT1EfAlwiDXzEu344wgMXB
	X3D1RhsW2rErXuYBNbELj7HatFuRMBFWcHnKJRSduFa8=
X-Gm-Gg: AYBFou33RI9/6KZyIanhzIHnMWMoklgYWMBC5E8a5gP/W4CMJE4J0kxw2UsJam1g4M3
	NaUK8C9QhPk2VVdCSUMqFEiWc6upg/xcpAsbh4uHOFKhBVtDxc7BxMyCJS0IsgpBZMtoECb7bx0
	E75iRlsFwTjuF4O0tF4GWRfu70IwDCg5znmSqX1qyBwcEKYTOAfJHdYIqB4DzwcZoiPf62ThNUI
	qdWHx7mrxxZyisEXvRoQQhPUZZHTPGH4u+/dJ8jysz4m3nz9hEYUtvTleb0SHjkXp7sOjzNhbtX
	rBv8psJb/CmFHETwaWCp8G19hB7GTIah0Dyx3iviN/mgaVhvSd//ul8Osyc4WPiEoPoUZnVGsDc
	9gEGvUMyMJWRAEAhGj13PzOV19Ku+wYZv8gei
X-Received: by 2002:a05:690e:147:b0:679:b0d3:9f1d with SMTP id
 956f58d0204a3-67a0e4f771emr1009384d50.47.1792609767831; Wed, 21 Oct 2026
 12:09:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792607608.git.zhilinz@nebusec.ai> <179260934140.3290.12382990945643523195@kernel.org>
In-Reply-To: <179260934140.3290.12382990945643523195@kernel.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Thu, 22 Oct 2026 03:09:16 +0800
X-Gm-Features: AclHuK9MeXpeNLn-EU3mGZxdX-1U_EvCX4QVyPCBo27t-D9R4k2PDnYoaJgt4qM
Message-ID: <CANB6i5zH4BsN02FCWCJC47-5VWODVdQaurE62P70LRkZaAY23w@mail.gmail.com>
Subject: Re: [PATCH net 0/1] tcp: release congestion control reference on rejection
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:02=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

The issue was found during manual code inspection of reference handling in
tcp_set_default_congestion_control(), assisted by an LLM. The inspection
identified that bpf_try_module_get() succeeds before the restricted-algorit=
hm
check, while the -EPERM path does not release the acquired reference.

Thanks,
Zhiling
