Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A242222A9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210276; cv=pass; b=u77uMjQi98Ww9rfJZ3hbz/X4SUOp/xlVPnSMa4WM0qzyRzh7DuWjXLRBLEeFpWLXN8Il86FeLnLaLHC3Lt/FH3PQyMItgCvVhPWnjVOx0la80zrqNdexB+Iz9AsIBe6dVQsQyh91mWxW+hneh7KAhLDEE2WvOJgIVCOzGdc1tCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210276; c=relaxed/simple;
	bh=K8vS5txHWFEz09ZjpqqSdMVfVwpyc2OkAuMiCyz7q9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw6HzB6FbM+su/wCavQy7eqzI4+SZCaZhVPwDj3G4ha4pPq0YMrwpx3F/yYiMBA0L7ifkXfKmTrrboD/qXydIJM1Qj9+0eyYGJSwFh+5dxpzZ5nSakRrXr5X7EEkiFRyMMesWMQ8W/N7hn9AMSKCKljSpU51UYnw53LjNGMN4ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DF8jcxcA; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DF8jcxcA"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfd70b08cso145403785a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790210274; cv=none;
        d=google.com; s=arc-20260327;
        b=D7RAZHM0Ynh/UeEBurggO9CaQjimDd50QTpx8sZgjt73Rf5eRpOmm1EOLfslFDsXfX
         q7zbSqBXCmcMfq/5p2uOP8ypBoPRKLoQLkJGNqNqGHvNlaDiJHoBYz8v8gEdeBgcbozo
         qBMV8XAFEfiCgAZ3ymuCB3wnzbfibGMOA/7h0s+J1lXUE4AEqzG0laaZYgyGsW61+1lj
         IKkN71TBBVWa/GL6ij7eKmDFLwRteHcWJHztfhv04Yem5QMxzj/sKxm+QY7V0moSjxbx
         7ep8nZTSx0MMEmcl10gfdxkRM6sUGhYCe0Ii9hQdotSGaQJd4/8yYPXrSkOBVIzm2Isa
         iAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcbF8p/gFt0aeBCSsZBnIRbY9cEz0BuiPSlo6+tvpBw=;
        fh=WGimCGS7q2SVpShdk6lvvkAmAApsZfBFcOxU0xPMIDo=;
        b=g+ZZuM8aeORHua6v6fXClczTHQhR4ZZ5MaJ8pi5FIRle10IzwngpS35+xBIQ6jKz4i
         btxQ/NzOj53X1xYMeJhmR6KANTzUNFz6CNPsYrHdD6dumuN8dp+hBpRTQ34MOqrfgWFD
         pZTESbJLFAVFRFJeJXQtkg4bISPp9zJwg7ZlVXsOIH/II2NgQyp9wJTN7IZEDsvTLpXL
         uamxrVus8hWZijqxq7mjV8TuHY8pN4Lw682nkJcYutDbShXnporQQAmj4pxX/s/DvJTx
         hkwaqO79vLvkt8eYysJ7h8dTRxloMkP3ft7VqgbVu3NrTcawCwIt0apIVI8zSx2QZAUB
         5Bzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790210274; x=1790815074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcbF8p/gFt0aeBCSsZBnIRbY9cEz0BuiPSlo6+tvpBw=;
        b=DF8jcxcAmenE8ZVq52vFNHvPYVkMGgbQlihdWSOd1ZIcmbmCYU4M859ewsafBrBm+5
         2vliRBE99T+sw01Rus4JayB1gkPUVf+Z134GUFnbo/F5BFpiVsCLNOMsh5wTMAShimxW
         ajgU7DIHV7I+O39qJfs00312lH4BZ8Tfgl2vAfBrRvnja8/2FqOXu12Z1Dd4/YtWxdYv
         DdC2Q80BkesEgdjJp4/AoyY6eas4FW/wmrUMlxl4gxdLb0Gn3gAA7qeWPx4d/M8CEnWQ
         hphAF0kyFolwkN4/PKIFDhYEjmrSE8xkikDU9lB/JAzRIolEleuWavQvH7qpRH5b5J1c
         G4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210274; x=1790815074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcbF8p/gFt0aeBCSsZBnIRbY9cEz0BuiPSlo6+tvpBw=;
        b=f1lj/qvxMBziyVawtqILeg/ph8yXXLj0w7FocU6S5vf3D7VK11wSswRV1Dmxx/Iiid
         bSTwNUBrhrBJR+8xJSdHziVvE7hF49IoiaPcCIObISD1AWxb9FRm956xzy4w7DYdkZiP
         O5yARYbd505RQ8qLUt3lm4dPpnZiJSzUVYZZYW08NULrunB/DhevVVitUnwxyMz32u3j
         ed3EPYijaBQmqG0gdxzKTPJ+BcUjrU/UAUxBRwOYw+ET/CJg5VAVbX/BAY1PTmff7v6/
         nghrBLRIPZE0ovyaZTNoq/XCPJbS+VgizXNB+etq9/6fCJbKCt8nUPq9hhj6jUDKYu/L
         9n3Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8Ol27s9q8qE49SfQYNF8st27AG3YRrpeT34q+tiCMhQur7OKXq/g3cGNL+p8REedQBsGniuY=@vger.kernel.org
X-Gm-Message-State: AFuF++nLT5yAzTUzj9RUP2LYhUWp822VQXr5OubK1CDyLfmLWHPzyMUD
	1fUtfoHXgk7L7BWyJNRe8CHK6NE1DkpktMyzAjGtriTf/iS88c1SGhTxQf2vNf+H9IMUW+3hI6a
	r+6pPAYXJs9Q6U8NVt1w3Mrh2upUo9gcaGcuiwZMP
X-Gm-Gg: AYBFou2/7ucfKvHog50GBGLjRqWn8WrD4/WkaOJpOSBkI/HMHxkiB6rwAbqySitGpim
	1xnzsH62Q9vVVnROcvAYJbzITEuiF8PJLb1/OUHxx0O8eoNpvKJzWF4k3+NMqzX3tPvT1WgcpKh
	DaVWdsVrXX4m6obqv4mOODZDx+vjF27hbUffazJ9H1Zmm2dk3/6hBYdN6z0YsCdDeqrSYAUVOgo
	ktBFLFKiPKJTdpya9CQuroLlGP4H7rXNkA/1y7xBD9sxVyaipLQMfdfD5+l+REDLbFv85BrJT7Y
	Q6u0NF7j0CB5FPRLfgUHYPF0fWR4lVNKv9Pw2cJXW0lau759vV7FUtAiZoFjwICGdQZ4SkMnKYQ
	uZWb9sWUqQD6a/1wnwMfKm7t/OgfuWC1dCxsMNEnd9S5BcSrUS2tIgbDiZObc1qyQtxp7
X-Received: by 2002:a05:620a:29c6:b0:93a:1092:48fa with SMTP id
 af79cd13be357-93c3625f116mr62219485a.4.1790210273625; Wed, 23 Sep 2026
 17:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-2-edumazet@google.com> <179020965880.2160803.15947896824748271639@kernel.org>
In-Reply-To: <179020965880.2160803.15947896824748271639@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 02:37:41 +0200
X-Gm-Features: AclHuK9csIZmYDxwCCpigVKfEcyzxaDI2cwn4y8NMP8OJG6NZ8tmbMbiwkZolQE
Message-ID: <CANn89iK4AVNi0z=oA4o+_604aAyEk6+RKXVSNOV=3VNADGfWXw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, willemb@google.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:27=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] fs/dlm/lowcomms.c:send_to_sock() =E2=80=94 making the CF_APP_LIM=
ITED
>   branch live for the first time in ten years introduces a permanent=E2=
=80=A6
> - [Low] fs/dlm/lowcomms.c:send_to_sock(): after switching the guard to
>   SOCK_NOSPACE, the guard and the "Notify TCP" action now operate on the=
=E2=80=A6
>
> --
>
> dlm: fix send buffer backpressure handling
>
> The send path in fs/dlm/lowcomms.c tested SOCKWQ_ASYNC_NOSPACE in
> con->sock->flags, a bit that has not lived there since commit ceb5d58b217=
0,
> so the test was always false and send_to_sock() always returned
> DLM_IO_RESCHED on -EAGAIN. The patch switches the test to SOCK_NOSPACE an=
d
> drops the matching clear_bit() in lowcomms_write_space().
>
> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 2aff1c7c17de4..abe9ae4c643fa 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
> >       clear_bit(SOCK_NOSPACE, &con->sock->flags);
> >
> >       spin_lock_bh(&con->writequeue_lock);
> > -     if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> > +     if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
> >               con->sock->sk->sk_write_pending--;
> > -             clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> > -     }
> >
> >       lowcomms_queue_swork(con);
> >       spin_unlock_bh(&con->writequeue_lock);
> > @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
> >       if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
> >               lock_sock(con->sock->sk);
> >               spin_lock_bh(&con->writequeue_lock);
> > -             if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &&
> > +             if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
> >                   !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
>
> [Severity: High]
> This makes the CF_APP_LIMITED branch reachable for the first time in ten
> years.  Once it is taken, is there anything left that can restart this
> connection if the TCP connection then dies?

I do not know. Maybe dlm folks can answer the question, and take care
of this patch.
