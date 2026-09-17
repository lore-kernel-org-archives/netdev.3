Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D630100E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604519; cv=pass; b=iBAKhO80j4Ibq5d7Ldc3VmPF1VBGHYjCdZ4niRlEknQqH8CIFy2D/P1afHqPFVPYBa8cedGo7bh3tXqKoCO7jUDcVCdGLTh4xia/YB3M4GGJ2pjf9Yvc2pIn1NocSl1OLeC9HB0QqXB5NbP/Gcegu9qE8JFRReSTayEieJt0sqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604519; c=relaxed/simple;
	bh=eE/70tI5lHBfiicghCy5PNB/8uOoQM6gLV3a2ZfYFM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEAzWUrhKtRLOANMuz28BbjWHCpvTra8zM8PvA5BXafO8SbelDLcImGTRm1sWRs25RpOas+aa5KtVyv4SaVyabvvScWPYFUJGFscPONQOJlUNATPG0alEwbmnlyTxYpR/J888A/kzFUoTgd0krJ3TKaMA2jZm5KEdNcekIirkEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAf0Hcwx; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAf0Hcwx"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e56a1b327so256074d50.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789604517; cv=none;
        d=google.com; s=arc-20260327;
        b=NBjoWP5OWewLipCe/V+MTr8DnbNc/4us70hS1F527u3shghRI9dx9FW+0GBFC0r5B1
         tOl6eVnkIOgpCfFJ7Bt13wpHEhuiepkW6TAYp824Bhh4/tHQdNoOQPkIYH2DoSGmhGuX
         WCd9kRiiKvEqCbM2e0KTSk/nCB80didxiUXYGyBEsERcZVBYEsJj2or1GLfp9KNrtCi3
         QAQ4eqj+XpGzpv26igux1ZPx82R5nUji2EcV/QYEEFOhEuUcG0NqfkJ8s/wxck3X/nSP
         Xe48Z/rNDc57JorS+jEH09BKxncLUt7nEY9Lq/atV/PizcoClT3BhhG6hXe1nz795TOq
         IGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MDCyJ4TOKuXbazw0rOc/QKvMAz2VNlILsoPCMfyFwJ8=;
        fh=y00pNY1hFzywtEm5AJ+zySy1+ok3PTgxx32tFjNhvOk=;
        b=Nh7SqVkLjgHvHSxP7GYEeGcsHXGt3sBhj7mtxWKhMQk+V9MV3Wkov4Cg43bJtopG3x
         5yXcrIY7lzIg4UoiV4m952N1cjTtXmZlON0tkhcbTIPjshkXkXJQaFwsYRJzhY/67b4x
         gBY0IT2g+Ui71qTb79r7ZOVXYYAaz15QVVeSvSpeHwEjGKt/J52zkdD3qBncUGY0JGV3
         ovUZQJ4agdwb/AsqW+Gt+ATMW3AUqS5wp5+khSMFooZ846bIrDmLJnX76gcZHXib16Of
         cp6iOjZIFsdXEWiIfzlzK4MO4YmKpdq8Vlh/+W7Z0Io7a2qyqZCdLGZBugWnLxB6OQLx
         D1gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604517; x=1790209317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDCyJ4TOKuXbazw0rOc/QKvMAz2VNlILsoPCMfyFwJ8=;
        b=XAf0Hcwx0wGX1R/eahcYqcItKUB+ei7e0KMV4GnR24CdTGYaMdKYGr7mf9+AX8iSql
         RsVuoQ1OMmJ6BlqV3PChQ5GsQGV+4MdUdbl05Z5IS7iOAeZNpG7J8rvBRLMzSirKsiuc
         oIz4uKvI4TwBNsD8scJjk/PuQ1KRH85sa8azl6DDM7iEcBKkO1WkdNVUe+yyrmbzXyhd
         WEAgdtsKRdce4nk3PZ4WBsAw0+Innm2tSA2AJbqZDfeHb2o/cc33xjc+NElVB8ZsdtC+
         +9UkmcFZR37wrgVIf+wREgrwOMYnR596/rq8UFF17EfpGQnfK8Qn8XHE2DUE+lU/jHmN
         gbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604517; x=1790209317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDCyJ4TOKuXbazw0rOc/QKvMAz2VNlILsoPCMfyFwJ8=;
        b=uuP3vMMsabpMsoZemRqZY+dgjKuJ0wCrSe6Y9SUMzrgIjdLMN5UKZnzct5cuiHFJuq
         0VZsPdOHNhKUP1HU3lqONeClkLx7pzn5ylwfTvfpiGrdLR5oaie1JtR9ldGrxTd3EmZY
         6NLcoXlqqH89S0EA8QYB4Ij2rLK/hSVXgErT7Ylg6UpYU++XT3zoU8P1EHgWhhlxhlcr
         n+SmVQprFJE8+kY9dhIHama2vtfkU3tNFQNCio08qeIywTB2UF3XH4JDBNre1cGFrwhP
         vvrmKJ9LHQZzxoR2UjCPYLTvhLQo+rHyL/ODunFpB7R0P07V70sn+VVkgE+vLepvc+41
         fPoA==
X-Forwarded-Encrypted: i=1; AKwUvBwqRj9vollIX8nvr8uyDxCXSsvRoJ8fqul4Q/1VNvDC94WIxpKms0K5B/nanvVJriN7C+MrZT0=@vger.kernel.org
X-Gm-Message-State: AFuF++n3QL9E1NJtI2AfcOiRncbe0FQtSpRuQ3dROlErEkxa1nKl9yy6
	jhBcBLF87viY0lhUDlAcFxoLQOS1dhZWcxnr1SfYmKa83Jo3VvPxGNavTBpNUgpdS+Hki3wDIoT
	JOGpXBKwgI5jIpVR6d1b3DJyIdhnSJpHHtA==
X-Gm-Gg: AYBFou0lGi3W203AKZTqMrdF3W3LBiHHPNAxWTfxKFOFWmlwRK/5uZBRnJLHVJ/w4J5
	14EwYJS+dUZYkgEGErNbSrAXwgZvW/XiAYPmx8Gx4qIZ8/r9NBBTCnFTfk5SpOM2vQk1WrRL84J
	UZxLOcj/aGY13902o4P7Na2cNYiqGMqRUK/B0Unx+JQZBuC8P0wU07lcykYIlcQF2Xjd7e+dmel
	2mGBDXNoXuSY054axrJVNGz+UKNABnHjmOXfq/rTUPkUgBD7ZZ/LR1+JcfIehmxUTOYrT45sr6u
	7RGuOTAvgReLNZWa6HHvSq5jNnS+8etkc0SW1kduKes+7V+rUzwVh4ol
X-Received: by 2002:a53:d016:0:b0:671:4c1c:d571 with SMTP id
 956f58d0204a3-671632c9f51mr1604029d50.43.1789604516779; Wed, 16 Sep 2026
 17:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-psp-ktls-fix-v2-1-0eedc3b148ec@gmail.com>
 <178960039456.22033.8739239860645875280@kernel.org> <DLH4YA9CBAOR.302OMMH65TVUD@gmail.com>
In-Reply-To: <DLH4YA9CBAOR.302OMMH65TVUD@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 16 Sep 2026 20:21:09 -0400
X-Gm-Features: AcwNN1U4GDt9jigbNmv_Nr_CFF1szcdzklC14Mom0RTgeef43I5aY0c4jLpwzWQ
Message-ID: <CAF=yD-K2d4i2Jgc3v5okzuGy3GPLXD+E490r0FYBcW7+Rg1fxA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: psp: avoid conflicts with skb->decrypted
 and sk_validate_xmit_skb()
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:39=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> On Wed Sep 16, 2026 at 7:13 PM EDT, netdev-bot+sashiko wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > - [Low] The patch adds a new, user-visible restriction to two already-
> >   shipped interfaces without updating Documentation/networking/psp.rst:=
=E2=80=A6
> >
> > --
> >
> > net: psp: avoid conflicts with skb->decrypted and sk_validate_xmit_skb(=
)
> >
> > This makes PSP and TCP ULPs mutually exclusive, since PSP and TLS both =
use
> > skb->decrypted and sk->sk_validate_xmit_skb(). A new helper
> > sk_has_decrypt_user() is added and checked from both __tcp_set_ulp() an=
d
> > psp_sock_assoc_set_rx().
> >
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index fa60b7494c586..9489d9c479493 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >
> > [ ... ]
> >
> >> @@ -2670,6 +2671,12 @@ void sk_setup_caps(struct sock *sk, struct dst_=
entry *dst)
> >>  }
> >>  EXPORT_SYMBOL_GPL(sk_setup_caps);
> >>
> >> +bool sk_has_decrypt_user(const struct sock *sk)
> >> +{
> >> +    return psp_sk_assoc(sk) ||
> >> +           (sk_is_inet(sk) && inet_csk_has_ulp(sk)); /* for tls */
> >> +}
> >> +
> >>  /*
> >>   *  Simple resource managers for sockets.
> >>   */
> >> diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
> >> index 2aa442128630e..b58045df101e5 100644
> >> --- a/net/ipv4/tcp_ulp.c
> >> +++ b/net/ipv4/tcp_ulp.c
> >> @@ -136,6 +136,10 @@ static int __tcp_set_ulp(struct sock *sk, const s=
truct tcp_ulp_ops *ulp_ops)
> >>      if (icsk->icsk_ulp_ops)
> >>              goto out_err;
> >>
> >> +    err =3D -EINVAL;
> >> +    if (sk_has_decrypt_user(sk))
> >> +            goto out_err;
> >> +
> >>      if (sk->sk_socket)
> >>              clear_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> >>
> >> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> >> index 1a2a6b7516b0f..e9b53eedf8dba 100644
> >> --- a/net/psp/psp_sock.c
> >> +++ b/net/psp/psp_sock.c
> >> @@ -143,6 +143,10 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct=
 psp_assoc *pas,
> >>              NL_SET_ERR_MSG(extack, "Socket already has PSP state");
> >>              err =3D -EBUSY;
> >>              goto exit_unlock;
> >> +    } else if (sk_has_decrypt_user(sk)) {
> >> +            NL_SET_ERR_MSG(extack, "Socket has incompatible state");
> >> +            err =3D -EINVAL;
> >> +            goto exit_unlock;
> >>      }
> >
> > [Severity: Low]
> > Should Documentation/networking/psp.rst be updated along with this?
> >
> > Two already-shipped interfaces grow a new failure mode here:
> > psp_sock_assoc_set_rx() now returns -EINVAL for the rx-assoc netlink
> > command, and __tcp_set_ulp() now returns -EINVAL for
> > setsockopt(TCP_ULP).
> >
> > The "Securing a connection" section enumerates the restrictions of the
> > rx-assoc/tx-assoc sequence:
> >
> >       PSP encryption is currently only supported for TCP connections.
> >       Rx and Tx keys are allocated separately. First the ``rx-assoc``
> >       Netlink command needs to be issued, specifying a target TCP socke=
t.
> >
> > but does not mention that a socket with a ULP attached is now rejected.
> >
> > The "User facing API" section also suggests a TLS-then-PSP bootstrap:
> >
> >       The expectation is that higher layer protocols will take care of
> >       protocol and key negotiation. For example one may use TLS key exc=
hange,
> >       announce the PSP capability, and switch to PSP if both endpoints
> >       are PSP-capable.
> >
> > and "Kernel implementation notes" says PSP "follows the TLS offload mor=
e
> > closely ... and the use of skb->decrypted", with nothing stating that k=
TLS
> > and PSP can no longer share a socket.
> >
> > One more thing worth spelling out in the docs: the check is not restric=
ted
> > to TLS. inet_csk_has_ulp() only tests icsk_ulp_ops, so any registered T=
CP
> > ULP blocks rx-assoc, which is broader than the subject line suggests. T=
he
> > commit message explains this is intentional, but nothing in-tree tells
> > userspace about it.
> >
> > The follow-up patch in the series ("selftests: drv-net: psp: test PSP a=
nd
> > TCP ULP mutual exclusion") adds tests for both directions but does not
> > touch Documentation/, so the gap remains at the end of the series.
>
> I can incorporate some changes to psp.rst into a v3 if others think
> that improves the quality of this patch and the PSP code. Personally, I
> don't think this suggestion is worth while. What this code prevents is
> something I would be surprised if a user were to try without heavily
> inspecting both the implementations of PSP and TLS ULP first, at which
> point I don't know if using up words in this doc is worth it.

Doesn't seem worthwhile to me either

Reviewed-by: Willem de Bruijn <willemb@google.com>
