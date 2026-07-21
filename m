Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7039E6F8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643503; cv=pass; b=Fta4s13AAEtmgtBHwRoqsPWutB8FSNStQtPlnCEK8CVtc7G3WJ3iSiYpGoCLdHtOkBoz7XdpqwVPwLel8DGnuhFVSIZkGfunr5BZRtSUbnIWgNQCuBiSHoQCyckMnSMH0EU4v9BgpsH3L6MvQWjEBJeC1tr7tOfjd3SB+POd090=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643503; c=relaxed/simple;
	bh=NVV3+XDFCbVbD84ghmSXs0xAXUmYE6494NLi6qq1uFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiNw8BRrJJjwS0ZRQ39NfMH9Wx54APK/QQKS0fth9bHiSgnRTERoNVVr3nTHvfi5Rcw7C30Hiqqbv0ASiqa1fV2FoF2TYEVnR48jyOTqW+TnLuWp6t2p5u8y8o/V4Q/E7hzS4mdjcUcM5SnlI5b1uXHwewGWcygSyjj5aQoC9OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSMb7bK6; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSMb7bK6"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0a81d286so45345901cf.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784643501; cv=none;
        d=google.com; s=arc-20260327;
        b=dsK6Sm9vMRGqIwgedoMc4Bl3A0lVCyOYjczWXPyMYxrTHBYPL41xxuCaTqMOuxF0dV
         2KlW2LjRquhWakAlqxsuUpT+KaATJfTnNyhmUimFyANS9SwamggyHp26l4L6fx3+BF1c
         MYcVNlJBX1PK92o0r9WT5QrEerXOpsJyQYwrbFQJlWznoU+vYKIYCtDFtMJ8DqJqHJTE
         lQJHe4BQD4/X7IldSn6S5ze0pMTAA/L3fE86q86n76dnhxcTTu/eHVc2qiTMqL0RvgWY
         UeVIPS8DjjLyY0enjTFjU70xguewesFgkMdD1Wt2UCTi07Yx+btdi0AotuaO7ZsDWonF
         5N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRhP5ACQsrCIUXo6VjCCwsValOT8tY41FIY4pxKlbkA=;
        fh=RxnvesgU0U5UxN6RLiefUk32FLLJZI+cHe08jav5tSE=;
        b=PJqf+ouQAW4hangttKF07aRC7BNXQVGVE6IbrrehOCSRIZAfXOobBT7DOdi4jBwO6d
         8U24kTw5AboPjYq3YwPwrxErWfdE1Snjz05v0PalJka35uG0v2vw9CPMnSHPXPutEqlI
         pg5vpqPbtQybAdkHTqkED7jkyVI8OlXS75muBqiYv8WLJF3/OEhWdp+6f4D0pITDEmJ6
         gzyBrEVqiS94mrqTSPbYDKDHjYEXHJQMv78iGOzFV9B+eBtbQShHMvZwGwX02lODA3Wq
         /lP2eBPzqWxbldqnRytwAh4/Kwc8jVIHQ4/Cjf4NTvgwPw/7Jy70Scb3RirQzicBeboz
         CMBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784643501; x=1785248301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZRhP5ACQsrCIUXo6VjCCwsValOT8tY41FIY4pxKlbkA=;
        b=JSMb7bK6p/TG7RWEv83WKT0A7YRt6KDZSUKm0LQbE5GhcIMK8lYcjukFwZemJtGiUK
         /bl2mcrqXNJeC3Q71rGRA7seVejD5zYrUDLkf/wiLcwA5EDfcsqKG0uQhjjThTineNn4
         y/n31fMpiLqv1S6OsTkTuBQ90V9qdb/WtQng1CzEDjmhWgN69qUBXt5NUoKV0/ZO3XPZ
         37decJx8R1e1HwpeBvxzKqZArNBv0lWqyFqVEobtH3eoWMO3Ft+blZpyWpTAdpuqbwF4
         Y+GLmYQy1YcK3FtJS/6VjpeHdIm4YY8PEwffcxhj8+qQdNyCgxrP/QW2FZ6X016+/HRL
         c55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643501; x=1785248301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRhP5ACQsrCIUXo6VjCCwsValOT8tY41FIY4pxKlbkA=;
        b=fKQHOrrYGWcNnYFQyS0qrCq8X2uufloKj82CZvuN2FQSNq4aTRvQYVLkmaspgvz514
         5cHnBX8LcW0OE5ojJ9pH4gFoXg3B6arki0UTzbhFKAFM5g27h3Qh+q0Xj8aNQsNI8Ons
         i8Y5nfzoS8jalR9aYkxRb/X3n38uJGhdnJxFfysj9I2g8TGlLLBTHlo9oJkIpULNzSs6
         nrULPnsvez8Zer4g81GpuE5lc9Eh1VEp89nw7e2aIzYryTO6+9HdSfQjZ5hKcgH3Xp1G
         RXcJZycbDMU7fO3Yx7//vMePHJuLhDdvB16xPP0tcHLdR1AY810xQ5YmbDxdasDitkcY
         yL+g==
X-Forwarded-Encrypted: i=1; AHgh+RpWz3WlXplSWdJd/rRNrOnQm4l2Oq9jlj4i6JDe2fR0SVaoSaFD/HrJwGgoAdVQ/4S36P2F6dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+POKEIu2mZ/BH1YYtoDhGwCnTkhbeeK2zfGrLkjjnmoSOSrJ
	grO6QJ+QF8nFCNnS6D1jEWmhfQMIkNK8sUcUXuFoTO9PWg9/mBAd9F1PHrh0Ndq4ppwnknaCvuN
	vLSfoaGua0hVDqp8zFsNQ0QPO/30NVZDiL2rhcthQ
X-Gm-Gg: AfdE7ckxTKzItGVUKLQDhpXtM9dnXUauaV945xUcVUxX0RGSSyunB2yqGpvlE67kAqd
	pXQJT6+uCZ4txFe/Dy2X36X7CXhB5va4Bb8VKAVfNWZrK3t7fxUMpSPTy4M9xUvP+11rd1BqcwI
	LByuoEsym8Q2FvFZ1IZ5f4SDMOmuJuqr/gmJnfL98WVgcA4lvI0Muw8QmoE9TwVQ6b5J29hctMP
	Zpv0wAO8YH1Ir6iUzbEIqQlQi0LNbUNRTSrXh11+q54209TmikJijur0bt8qjhhu8nNyn8letxB
	iw45GwxIH2fyDusvHwuiEtqyAbVpu+Muyt6rBjDhgGbRr7uBlIHDlsg0+GTnnve17duJinMGOg=
	=
X-Received: by 2002:a05:622a:2586:b0:516:ca56:a44d with SMTP id
 d75a77b69052e-51fbeeb311amr230976181cf.6.1784643500180; Tue, 21 Jul 2026
 07:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708180837.9507-1-emil@etsalapatis.com> <6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
In-Reply-To: <6c01c713-14a8-43c2-aaaf-2fcf622f7e4f@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 16:18:06 +0200
X-Gm-Features: AUfX_myMdfGpwIg699dlzD79bXwYZGcMlxQz1zT8a0S0_8lW6OzhsmCLSDWqtqc
Message-ID: <CANn89iK6JBjGcbf_AAKGO-wkR2mjAdnSBFxwu_ExNE5dRnv+Zw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/8/26 8:08 PM, Emil Tsalapatis wrote:
> > The tcp_syn_ack_timeout() function gets inlined by Clang,
> > preventing tracing. Since the call is not in the fast
> > path, prevent it from being inlined.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  net/ipv4/tcp_timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index bf171b5e1eb3..f7215d53bbda 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
> >       sock_put(sk);
> >  }
> >
> > -void tcp_syn_ack_timeout(const struct request_sock *req)
> > +noinline_for_tracing void tcp_syn_ack_timeout(const struct request_soc=
k *req)
> >  {
> >       struct net *net =3D read_pnet(&inet_rsk(req)->ireq_net);
> >
>
> What's the point of tracing such function? It just increment a mib. If
> you want to discriminate between TFO and non TFO syn ack timeout,
> possibly adding another MIB counter and incrementing it in
> tcp_fastopen_synack_timer() would be better???

Tracing has some merits that a MIB counter can not replace :)

Emil, next time add a link to the V1, this would have helped to
understand the motivation.

https://mail-archive.com/linux-trace-kernel@vger.kernel.org/msg24624.html

Reviewed-by: Eric Dumazet <edumazet@google.com>
