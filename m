Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA911F936
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425463; cv=pass; b=mpWemOE8ZkbQjEkgEyccfnLygSPui+pMZq9nFFX//4KEVYu2yA64+FPEiVvWCr2YmNZ1QC9H0x16ZNuYcYvKsDn5skhMDabUNGzfsIyJ+dBnS5ek7AaoAGrhUMjnm+4AzGQx9IPTDqDCeUl4RjSG7pV046emXpiZ84Ws6wyIoWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425463; c=relaxed/simple;
	bh=tRcdTjRQ5UTW4DHDrkJ/ooF5c3DO+DoLfJDkOdlVFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcvRjdqoRblzzZehdb9mkZ0ZTtn/ut+/QUPUDdurnOIohI2nCErwpF3LFKa99YcOMj+C2UDbtgISrNSQtQ0GePK1A/cS+49ykH5JjgRIbRQyIybf9umWmHCxmQkzPyERGlbTOeRuU8NHc8oeDcBEH9+lrMK+AOLOdXEsToI798M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5EMnMyN; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5EMnMyN"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ab0140ecb2so6245a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425460; cv=none;
        d=google.com; s=arc-20260327;
        b=Wdcpr8UEYqgjgs2c4fgRtDiqouk+wyGY8MlbXkF2ClUd/4Y0cWLslAnUlAfqWIh/hA
         95uQxgSqneVY9CvRMUBihah8BZ7VSKtgj2XJqO2ZqLJkSd1aJFj+MhI3KB840C9bKMwR
         BFGswWrbMfmpQ/cn4BNfqUXLOzEBTw4Ql1xhg4/9KYLTZ7RVzm+xtHyHqCxPY4sEa4av
         lNAkHVQ4eIgQhKsG87LaI1q9d2qkmSgOj1fhXm+NxVz2HSLj+GUXeBvvtM88oa3TRFul
         eCjaARIwU/8eCJreLfLxBp1vXcGPKFX0+gELUIv1fKx0d+axQZM+0YBX7XYOpCm27tWH
         u7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        fh=2t+T//Ymg9/pKVFtBLNioe907x2NXGHt3aQLwTAKpVE=;
        b=pkxWQbJzqT0Ze8jIs78g+a5UvCZ0sT56n26XtiKBjDqiOGqRILiUG0srFbgeBrZrYp
         S+5+8eMfpqEplyfuY6yHA4Eogmfe5i4MaC/yTiYn9oRuoHaPS+4W2RxkXMF6eIrRSqES
         w5MlpdNdNMZuDXQL1v9jaXJxxQ+igr4JRPPn2OFB244Hr7egzs/vf+aqYtrxsDtFTxCI
         XpVWI33IF13aJr1Yl5lNrfKz6F4So6sKy5UHKuNPNrO+I87fIiqBP1By/NJxsHygO6zZ
         5LamcRKWlkhX/nO6NzZGBknyU8JZSgGD0W3dfzr/4JkhKn9B4onNoCrxA6RQ23LGdysJ
         uCkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791425460; x=1792030260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        b=I5EMnMyNwBCKYJCIs/h/xX5KJX7bNOo+0PYb/stAlNBfJvn0JC3k7SszWWtFHhFvYd
         SM7dt9heTzBwPrZ1vDo3sHVqhR80CEMXtwz47ChBpq26B2UigRNdecmZzLDeZyv/ZtsE
         hc39fNd5I31Ovznoj7Tg9K36yVoKOFP33RXXE1Bv66dprnTHKRMgKwNltJTgSCNOW97f
         cXYiWHV9xkjWyChFDxTCeDUWBEWOx/z7E4xDKwQWbSSkNXr8OBuWhrcnjug7eNy+u3bc
         +tAoxIu71q81QrEQabZtLrMcrStAES/XYJu73LVcuAcAfLKkk1c8fO/XR8NVNgrDhGBP
         NcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791425460; x=1792030260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        b=NszP6Ij8wt1kIOFe4K371UxieHVdQDHISjobYAa0ZIRj3Yz5vWPJvNI6VfQ/PeWD/Z
         X8IHauEsJau1+JRHo14nFP2dFrzrbSOgr4sOK6r6kZfbktAk5rPTyLGpwh8PePglp335
         1delpNva12s71KdiYh0Zbb4nn++g91k6PtH421ySc69sgd0JQ0bR4q+BfUvIMHJD29BR
         nTaR/eujH6tzWb7zbmysXAvr+ya7O9g3lkwIdiPYE8sPY/LiZG55AbGLVqdYhvyb+ZfY
         FZ5VWeDP4jByZvBOERrjoooTTFVNEjZX6o89Qmx5OaeyKCYjYzqDb47ts8UJx8AoZI/C
         v0jA==
X-Gm-Message-State: AFq9FYLp3ZrtuTHtM3rG34rc0kbN1AezLDQJNfGQf6zKrmTeQ81P1EQr
	9BfGPWhKijR5selaI3v51YWipomqa3UJ9Brvx5GR/5Zz+5ci21+uJ/QDcr3njuGlYHLFi6KYeTY
	m+rxDKsIVI4BIKS3qjbhfKTLIePxvYqu8lKhnsIzm
X-Gm-Gg: AYBFou1aS4f3jtA47Ou5yVtHWmWiLLbZ3KSOiwD243s0SHiB9Emxf/EJfcUcbsxT+a/
	e0/FK3uvbV/OErmp+fvxniM/2OqdbPVah6J2EqujIKAzQG7iHP9E1GNFiKBQz2tCav1zJW4/TGq
	64vw+Neua3DbOyL/HIR9QSaTisXjy3wLJv1+KwxKnhHQGEXs6L1wivh4HH/M2Lujzx87mqGiPow
	SWlEIK8zG5UIU/XthCEE44eJ7BGJKGg6jAcSMkd6qtgdh5LZGXxjXeSKVW5SU0Jc+r5JQZMyyJh
	eXNz3JANQ9xywVuNcT9StZL+B7FcKvKh4HcubT+v9dVP+rgJup2DbA==
X-Received: by 2002:a05:6402:46c3:b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b01174ca66mr37674a12.2.1791425460145; Wed, 07 Oct 2026
 19:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-2-almasrymina@google.com> <4818da7c-be7e-4f97-b5a3-bee05ada500a@kernel.org>
In-Reply-To: <4818da7c-be7e-4f97-b5a3-bee05ada500a@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 Oct 2026 19:10:48 -0700
X-Gm-Features: AclHuK98bUqu0UNfrer7PsXheWlbUfZxQHPGdS03OVcyzs99X4ytv2QdoZrorac
Message-ID: <CAHS8izOmh+cjHsF9X39=Gxsw-wMHNrkxBD9OTPApVw=P43Cfbg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] net: netmem: document netmem and memory
 provider design in comments
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luigi Rizzo <lrizzo@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 12:43=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 10/5/26 02:49, Mina Almasry wrote:
> > Clarify the netmem, memory provider, page_pool, and skb fragment design
> > principles in header and code comments:
> >
> > - Memory providers allocate struct net_iov or struct page, cast them to
> >    netmem_ref, and pass them to page_pool; page_pool, drivers, and the
> >    core stack operate on netmem_ref and must not downcast to page or
> >    net_iov outside dedicated netmem helpers.
> > - Memory providers are not restricted to net_iov and may supply
> >    page-backed netmems.
> > - net_iov is not inherently unreadable; future readable net_iov types
> >    are allowed.
> > - Per-provider logic belongs in memory_provider_ops, and per-netmem-typ=
e
> >    logic belongs in netmem helpers.
> > - All frags in an skb must share the same backing netmem memory type,
> >    and skbs with different frag memory types must not be coalesced.
> >
> > Cc: Luigi Rizzo <lrizzo@google.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >   include/linux/skbuff.h                  |  4 ++++
> >   include/net/netmem.h                    | 29 ++++++++++++++++--------=
-
>
> ./scripts/get_maintainer.pl --file include/net/netmem.h
>
> Returns "maintainer:NETWORKING [GENERAL]"
>
> >   include/net/page_pool/helpers.h         | 18 ++++++++++-----
> >   include/net/page_pool/memory_provider.h |  8 +++++++
> >   include/net/page_pool/types.h           |  6 ++---
> >   net/core/skbuff.c                       |  3 +++
> >   6 files changed, 50 insertions(+), 18 deletions(-)
>
> Changes LGTM.
>
> I suggest that you Mina is added the MAINTAINERS for PAGE POOL.

I'm thrilled to be considered and more than happy to help.

> And do we want a new section for NETMEM ?
>

I'm fine either way.

--=20
Thanks,
Mina
