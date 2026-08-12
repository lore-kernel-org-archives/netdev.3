Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FA25B093
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504600; cv=pass; b=brlYlGq11nTgM9/MXn0587mLdeg8r0gI3Rbt+TYFTYA9uXpvdqVLqmUjeefw3N4NFtHlGbPTyGoWrEoUo05hTAp9EXSYk43mw+O0XdAzAd8LPbAohCsvsauPcpLxEgVe02Ff+smyUEC/j4RU9+I7SqpwJRjvZAuLeHpN8oQwS8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504600; c=relaxed/simple;
	bh=fxEQP1cB9k4Ugjie22mCjyQ9R2ddMIZJCRPxa8h2Vt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2qRPxRGOI4tSwvjunBTfuhAZj9iUA3867W6H3/lMUfC00GQAQfmNGRUQXYEMgEdQF6JzpqboaXubRFrAFwEQnA+aPD7w8wVV9V5pnLAaZnQVPvq61Kx6Yt0z5DWrjGM5eAfDSV4hUSAYC2+2pxYdIuyvoxIST14+o/D4p15/Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h87mnhxV; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h87mnhxV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d02b4c3601so2770015ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 20:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786504599; cv=none;
        d=google.com; s=arc-20260327;
        b=XP1C0IRXk/PPnpr//AyUjdU13Nvt1lVNnGKPdsFXXjnaWySylPFc4h5jhXGI1kLJod
         UCJqG+3aquq4BsuPxqyX+sOjPBMkJbSPXRGbcPnmfZMu3eykcJhBN3V6lM2OIMBM//Hz
         Xpl0RBll4ZusfrykutlEruDoztxEtzDo7cohQ9ISI6vGl19igqIDcWMOWjyTI3P1zKpj
         AtImIa11JPTsF44j8ic6n9aGXsSsMRjJpCPA5lVe8AojtvKIk/nMwOel6ZmbBdz9yUc3
         Po8y1otF0RpwKOM5FUi6nAG8AsSBBc06EQkO/Y8PWyFXHN2BfyJemD4xMwSqSeJpf9fS
         j1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        fh=sQ8Db81G0m+tDH/4vIUB6wNlwejIzBrwPMqDqR2eZ2U=;
        b=SHDCNCnCoiKgHBAkhwl2d6JbQT87tZU7fBsiF2FNlcWDKRRvdOrYAEJOXuFZenYoUp
         dYqz4LkchGT8Y9tBLx3OvFbc4y/MJbKTfi1p/R4+91VwfSRbH5EmLrDHe5v+JRgpmlKz
         lvwtv4tPaawHitxKfy2P46PLDBFT40ZPAqliYAcC5JhECusoQr1yaFIL5yhx9MZNozcZ
         qCfnMARUgSHUD1p9X6klHoyqlf8yyn/MUG492PBP/GTF0xxzDVXW/S897sRBNW4JeAtn
         1u3iZJnaW6mI+b5O0MoInSuUH9URKMjx5k3ANYcAVl2bPmvBAUhb01B9/swIpWTgBvUI
         qC4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786504599; x=1787109399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        b=h87mnhxV0AvIijHhPyoFcXOwv5e3AqR9km0oPK4V+73ULTrF/QQVHHoJzSrHBkj4RH
         OSliRyBbubFD38PkfUSezefC0ja7MR7Vhhku60Cg5fAPnRdNtTUaG4V2irQlyj73rQQs
         i1c5BhtqXsEu6YpXejfwV2UQqe/16lwTFD9uJYme52qqWhvORtMRHtpYmjIC2Os9kLuX
         fkHJwkyf1Ds6Z3jdRP+XiyB64+8TwOo7ByZ4D2+CQCf3XyYvNelcmhWBYmISc9rGgdd5
         9o+a+uvq1RB4Qa7x/+ArudUAS9WoUyLNE5o/Ve170N2VKuOXW7XY9qGxqJe7f9QrWsxO
         D15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786504599; x=1787109399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoroZKDxIj4XxhgtnU5mE8RN0Po3//NZA/PtxjJGOqg=;
        b=V/OmBPbxdrpUptR7zo3JJWVoQAFcsO2A0PwgIuI5acYVrNe5PxRlZ70D4UtTuLD/fC
         ahL3Gtw+2u0V04xXNIeykjb+vW2tf8zts4XzuX2YRq1muBOTMcKIARSRbYLJ2uyyfPhL
         AD4vE7cJeiLIaooUkqxbEvidzPkXAhYJGria1U9XL4ePmuRmGNko9cWBczNPpiaYX9JT
         mHsMhGkJgHNAKkyFrExw9HUWUl90fwr83mxU+EfvVsIn0VIcQB1FhjedPCaPoIhifx4s
         xCwtZSKMyZ6o/A18gaLeBUAHdp8ak3zKGvbJhtGansYxxwNe44cHYe/yWzPnK1oRTeBL
         G/IA==
X-Forwarded-Encrypted: i=1; AHgh+RrTANz3IAe6J1EwaXJ5/pCnoFP6C4wFyieG8rdxCHTH2wPUbTC/QdINPOKiKSpvnABeIMUA0S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDqUusccBWxOrVS/FCP4apf0Qe7yeZquDVglGtyNarKIaP+gi
	Pp8RW8fHVqrRMvOuYbdhcjSSGAiLiBhvknAw2M0Q7p2IVRikNBdte4HDTG1fo8Cxd9kT6UiFFsd
	7nVBPnnKWjw0nPzbvzbzD6ib1L3qbpVaC3wjTHyTE
X-Gm-Gg: AR+sD11gjWEcmNhVjdcjvAI4P6azijwHQ/SH5K3iOBPm8ZfiWyLrwJvhI+kGzaZRv8x
	XhXf0cI1WTvSDDYONeX0gG08GkUcrpEIL4d41oILDPBg3m5r3TpXPtsuDWGQTVR5dJMs3z9FXLB
	xKwITwUTKKaAittVmw5hUN6ZDu7sdPjhOqLmYlVAUqnegolBu+AYANSjbEa/5Debv3+qdN8dUzj
	KR47780OuXQERTWMBtGksjmBJLWHAE1q/wGMJ2x/hF6zPUYP5DLbGXIu9WdnOZCjKrroQenPMy/
	nfLkhnKi+gLJyJUvZeNGaeL6CDtfDFADiiohUjm0VWBdVwPhBVJ763p066sM2Hyi3SGAUr4g9A0
	+MJWlA0s5LFSU2u1F03rBpicoiWKeanTtyeWZZNNypG4O+Q3sX9dWMZr+LTo=
X-Received: by 2002:a05:6a21:a8f:b0:3bc:5284:4859 with SMTP id
 adf61e73a8af0-3cc3f5ebd53mr1827573637.13.1786504598065; Tue, 11 Aug 2026
 20:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811210925.1751466-1-ast@fiberby.net>
In-Reply-To: <20260811210925.1751466-1-ast@fiberby.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 20:16:23 -0700
X-Gm-Features: AUfX_mzMg8OAlOzFZdoR67KtYST5Z3cNuYZyh3B59IA1f09HK50nGhqMl4SokMg
Message-ID: <CAAVpQUA6XWef=ra526WaBo4ft2=Q6Ovdwa_i_5C63TDKbh0bYQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: reset late connection after listening socket close
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kristian Nielsen <knielsen@knielsen-hq.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:10=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> When __inet_inherit_port() returns -ENOENT, the new connection is
> dropped silently.
>
> In that case the client sees the connection as ESTABLISHED, however in
> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
> -ENOENT, and the new connection is dropped by put_and_exit.
>
> A client may therefore hang indefinitely on a blocking read() if the
> used data communication protocol is initiated by the server, like SMTP
> and the reporter[1]'s MariaDB protocol both are.
>
> Had the new connection been processed before the listening socket was
> closed, it would either have been added to the accept queue, or
> inet_csk_reqsk_queue_add() should have sent RST.
>
> The call to __inet_inherit_port() returns -ENOENT because
> inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
> called by tcp_set_state(sk, TCP_CLOSE).
>
> This patch adds -ENOENT handling to both __inet_inherit_port() call
> sites, and ensures that RST is sent before the connection is dropped.
>
> Reproducer:
>   https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c
>
> Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
> Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
> Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in __inet_inheri=
t_port()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
