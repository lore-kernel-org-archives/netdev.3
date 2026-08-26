Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287937419B
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765403; cv=pass; b=LVhgZiDvUuN90z7mIQycyXvX3hX3qKCy+SJNiEupbP7EPhWY2VqW2TmgHXO3bDdzRZ3LyGWHfTcgTGJZjh+ow66Z/DhZsJpK234/jESkttP2DXtX+xo2Q/ks8XCHFjIpMUlXkpe/RV1fQbS9RmyLcdvHba6VoT0G9qZ0sVMl4Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765403; c=relaxed/simple;
	bh=waJ4oIpOx1e021pJUXMarluRRj/hhQ+iLSQ15lQ7Uk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC754KtxFboQN0b6KTlTFw770sgbWDi6rDpCIVqlpoK2TNiQ+VpjFOHsusFM/D1h3X0z+gRn23d9Ei2Qz7o2bErH9a0Egql42xGpylAY3gEmy16Nxf0FeO6a53dcz83F5k/tzmJUdlAvB9TFRUQ6Yw1hHAeflVMOSkT2XjZqkYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6LpKnIi; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6LpKnIi"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so532a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765388; cv=none;
        d=google.com; s=arc-20260327;
        b=eLpAWXvCNrWvweEG9UWKuXbHORO6FmNgdOvsZHZ0Z27sUxcZWNFjppcUQZIbhwY2pb
         IP1UMZu0h1psB9KI7bFAPiAgzAIYxUdOfphexaWb4TaB3Q9kh5pGj8I6SmSLe2q59gce
         /kAMFiqovXHzBI/+AJ72dQydL9BiD/ywN853SERov2mHj4eT9620nmlNEqHVXOtDgs8E
         aAUW9exPWJZr3U2zglcuuixh8m0FFSnAg25PnncLMerjqjP4XkBFUsrVXw2JE8v1nJjw
         Yj6zfDJHycVz63tO4ZsMSDzV9IKjleeYKvQyhlg4Jdp70krTzvN1IJOxM+fK48ngMCWZ
         YVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTcu/5Ld6L3FJvyOFw1tiAOnQ+39+I8YoUDCTqtvaBI=;
        fh=0co51faxv0dwSlT+aPQi5toerqqosqq9gS9wGxCh4xs=;
        b=MueklELH2k9hw2spUR9X438JjoMi3RMOlG7HdU1i7nEHF03ggYcIBcNakzaT9BG3HP
         v/jWoftzMD94/cOnd6LQgQT4TGN7M5S1r4R/USJV/DA2/XYA3W92dtV4J6b8AIooJx4+
         wpSXByVjCk0qKS+vmqrObK2WgUtsTj+8AlMR/wzlvNzqSAthiH54uisgxT1c53fFyCA5
         a8MQbH0XEogf3HG1innKuPy6+UynYQZ3iG8NbWWPWSlMvdEnmr8IRHZSBDUqarwME12Z
         eKuVoojPezwXewgzO3p6Xvl61qoNc88OjjNXSoTxvZMl6pWcpLARhDihwjjZt5Ac6GDs
         +XTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765388; x=1788370188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTcu/5Ld6L3FJvyOFw1tiAOnQ+39+I8YoUDCTqtvaBI=;
        b=M6LpKnIiBdQfQOHJxckALs4ZuZjbvYP8TZvcMof+ppE/1jx2AoJPAxIaTvpdDDJiGr
         78Ay1Mv9i0cdCBEVVxwe9U63KYwoUcuxQxvHBMcyRUqQ3Nxob+tmNeIg9eqfY81vD/DJ
         QCR3Xf6ze4UCFLhcqIm8J5qkNtPzDiSeeUSLj6IwP8glIF5wXi7J81ZYQ6rfOGmrMitM
         wYU1vHjnYX7QsNQ90RjD6eRNSXq9Y/gfh+ORKw5pnYB0wAcdm1xI5Ya4Aa80qbp0OPxH
         oKAO0KfE3wRkxEntLA5WpDRL4tK/nKRR/DUECcEXdBxAl5a9tpX5dbLcCvB2jedjFCXt
         4z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765388; x=1788370188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTcu/5Ld6L3FJvyOFw1tiAOnQ+39+I8YoUDCTqtvaBI=;
        b=k4lp+0I/qrvidt9pvE0kfcL2oyT9v9WYC8Q2FB9zQ7slUuBxnDN83iEKSryMEwUiSO
         wP8lijHtzjz0icu/DVCiCk2a3r2/Q4wDuPvOQPpSvxu9y9PCu+z+IlsYHD9g8xtAOK3H
         5FS2wjMz1BaXeXaGreROKLdguJSPahF4fpViYjLjD2A+hhQAig3eIoej0WuQUvRAOpPk
         fRloEoPmPGnIr17NbfUcJGl0xta6BKJ2hUKH1QkTPtdvEiU1WQ1S2us65mYINcGbtRF5
         Py/cbMmmU2jJS/eZ9iouftMk8qK80DMWGXUWBe08WFYlq3k4YQoa6fkWd6IrjGnwNdZi
         AbrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp60ReeG4MCO2J4ldqGtdsvh1Q9UHe9TKqDhg/LZhIxMwaK2ZSQ1ILKN0D7pX+ku0VXCUgqfZc=@vger.kernel.org
X-Gm-Message-State: AFuF++nC9eR7YFNw1olxa78+JaASO2m0Y3LirP4bKBdSz3Pg1hxoBYvY
	x+42BiwnKwkNA7kQSrYxFKxFF+itFpSK4t1Ec4XA8I/mAYpDCdO9THOePAEdD1nztqimIZiQFQp
	VLjQF/BUIeA4i+r5ZzKV1ivH51QrmRrGTFm7eD1hk
X-Gm-Gg: AR+sD1110JXf4eXSLqzr0/ITgSJmblYTdAY1LXz9PiJ1cgTknbFW3Mix85EMC83Mil2
	oMd3v51Nie4iXzvGfhAzH01mBV5AVfXNHS6fGNoFguWiAomH05phCVIg7xzRcaUMB3yEwoP5s7w
	wByu9D5t1PECYas67SYY3sweovP+mZOGgB8llTGFDM2Vmwf/hGd8R66rew1fAyRS6zLT3qaxrZP
	YvP+F4iWV92cSAz7AhnpjScWuZHagPynUMTbT5WbB3KxN+ChonV6CznlEGiX9RdfGQp9lIfk7Z9
	KgcTNGaJg6Vd+0S94NyiQ64Jm77uHVyAxQH226/plX+4c2PLmL+dyZfN4/DQFnWSIPOfaw8pMK3
	qHmP9lIgDrQ==
X-Received: by 2002:aa7:ce15:0:b0:6a3:f44c:bc5b with SMTP id
 4fb4d7f45d1cf-6a5e22bd44cmr67837a12.6.1787765387634; Wed, 26 Aug 2026
 10:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
 <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com> <75cf5a10-f7ae-4b4d-ae47-1556a30d76c9@gmail.com>
In-Reply-To: <75cf5a10-f7ae-4b4d-ae47-1556a30d76c9@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 26 Aug 2026 10:29:36 -0700
X-Gm-Features: AcwNN1W6HxqL9Ex4t7v-vAgOMgM6GGeLrqPvjpYrBoK6bZaDIpK-MFElVNhDTDc
Message-ID: <CAHS8izPB6xS5KOKOUORvJ99d-mF7F+9gZCFe5aoQPQpUeDhWBA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:36=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/23/26 16:58, Mina Almasry wrote:
> > On Sat, Aug 22, 2026 at 3:57=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> ...> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index b4237d0e994d6..1e34f50770446 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1170,7 +1170,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
> > msghdr *msg, size_t size)
> >          }
> >
> >          if (!sockc_err && sockc.dmabuf_id &&
> > -           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY)))=
 {
> > +           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY) |=
|
>
> This check before your diff fells off. From a quick look, via io_uring
> you can have a sendmsg call with dmabuf_id that would happily pass this
> check but never goes through net_devmem_get_binding() and
> msg_zerocopy_realloc(). It's not much too problematic for now but feels
> dangerous to rely on it in the current form. I think we want sth like
> this in the end.
>
> if (sockc.dmabuf_id && !sockc_err) {
>         if (!binding || zc !=3D MSG_ZEROCOPY)
>                 // fail;
> }
>

OK it sorta makes sense to me. I think we're making a mistake checking
SOCK_ZEROCOPY/MSG_ZEROCOPY when instead all these are conveniently
condensed into 'zc =3D=3D MSG_ZEROCOPY' when everything lines up. The
point of this line was roughly 'if the user is trying to send devmem
but not MSG_ZEROCOPY'd, fail'.

--=20
Thanks,
Mina
