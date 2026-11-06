Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008218;
	b=pD7deFBOnZ8M58U7WIk/9F9l/kxGZ0ENJITDhUoTzr7TzxypJkGfcQzQiGwq7oU84534
	 MKDVzo5LzWkauMqoODz7R8YPfAxgHinaiR+KpNaIHwcDGj12PEyl7MxwqnPnSB4mumjrt
	 qL2M/Th8DZyzxZbz6E6Bmdt6idn+U2vqAPwVbqWRVSCqo2P7Ls3/Cbe9vhSTUFI/v/nN7
	 IUiGX9fK0lzWPAhfMFOSedPPYn9TU+UiRu8nnqNnA5iA2w07IxgtUAFjVqDasAC+g8zhC
	 ckjUn881WfYhPzR9WIpCA4YuMYnyqY/PY73IHYpQt8y9NQN6UrLECc9OwOepdjcRt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008218;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JSoyUd22ElUNlUfJBu1nXtrz5TuJsyXI6flKPi5TA3I=;
	b=PaZotF6dbzfbrxeW2EZF0ZcdjpXw1i/UD7ACKXG44ZuqlXtRoLRvPn/4f0pU8b84iMQ3
	 eMt1ECo95jku2PyUXEa4ifCW9WYppV4J9d6DZIIqXME89DgLcyccPEd+F8ix1L08zfnDx
	 JHss7aijSjsx2IXzMp53IBsE0ENcCNIltVzpcgvsK7o/gR3S7R5rqfPvFdZ3u2u0xd+4d
	 B4Paxfjx3J7mwtl5nAGJO+mjoU08LrxodF7lbj3MKTbPTgUvWcNwrYH+FZ5SdaUKLFtzC
	 aJOxT6M8C9Guo1Yh5Ar9KX+pkeBEr1i2TNmZzlg1d6BqLQXJoBh9DIKqqIcGV/00jWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLOUqlsK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7A606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLOUqlsK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB4D1F008A1
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794008217;
	bh=JSoyUd22ElUNlUfJBu1nXtrz5TuJsyXI6flKPi5TA3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DLOUqlsKi2Pxgq9FZ/JJnVDxVI96n45KgqVrVyY/Qp0eV1TgYlb9mXzaYw7SoxiRT
	 sbgg31DKlApWxHMGiKTluWxBnzb6QqARzpi7IfKA1W5i2tkY8J9yJ9b31S88l2mGmB
	 0LAL6Knpi+z8QgfW+q1TjQj5y8OvbyJ6FSe9cOKTNw2hDCbR28GaElhDXBZw+7iWAv
	 tu8TV0OylnE7NNGaPXJv2NbMq8yrvzjM26dTG7hUBMaaWG2uzkqRWK3h+AturGIzUZ
	 ibPTjfHaRlIcouZY1k/SqwClaX6YLtVgX19ddSF9Qb1O4SxviIcGQ01z9QUKKtvBYI
	 s0DXuwwKcaqJw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48ed0b68895so758368fac.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:36:57 -0800 (PST)
X-Gm-Message-State: APuU4Z/PihSXNlBtqrFG/cjx9R0DFEAT+IOlbrQOhmpbdN+liw02YPDr
	mcTzS4wAJuNyOaF1KH/G9X3oFPwETFqmVmHhuAlSaA3R7xqsbFy/jjmm1nlGBJVKCLxsKpUPtcv
	MDxR4lIht5khlL/tCki5eLDcPvEm0hEI=
X-Received: by 2002:a05:6870:b524:b0:448:c946:9ae1 with SMTP id
 586e51a60fabf-4ad98ac871amr2890812fac.18.1794008216716; Fri, 06 Nov 2026
 15:36:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <f084de67-85b0-4759-845f-513879ebee5f@kernel.dk>
In-Reply-To: <f084de67-85b0-4759-845f-513879ebee5f@kernel.dk>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 7 Nov 2026 00:36:45 +0100
X-Gmail-Original-Message-ID: <CAL4Wiips_uVD45bC2DpG5BqywmueUBB_wiNCnd64hNUe8YsH2w@mail.gmail.com>
X-Gm-Features: AclHuK__eDki7Wxo-XbWR5HbF1W2HkFdH4esbYzWFhMVnanxY9PUSb18OlJtPXo
Message-ID: <CAL4Wiips_uVD45bC2DpG5BqywmueUBB_wiNCnd64hNUe8YsH2w@mail.gmail.com>
Subject: Re: [PATCH] net: leave O_NONBLOCK to the sendmsg and recvmsg syscalls
To: Jens Axboe <axboe@kernel.dk>
Cc: netdev <netdev@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 7 nov. 2026 =C3=A0 00:19, Jens Axboe <axboe@kernel.dk> a =C3=A9crit=
 :
>
> ____sys_sendmsg() and ____sys_recvmsg() turn O_NONBLOCK on the socket
> into MSG_DONTWAIT. That is right for the system calls, but io_uring uses
> __sys_sendmsg_sock() and __sys_recvmsg_sock() for a blocking attempt
> from io-wq as well, after the non-blocking attempts with MSG_DONTWAIT
> have failed. On an O_NONBLOCK socket that attempt can't block either and
> the request completes with -EAGAIN, unlike IORING_OP_SEND and RECV,
> which call sock_sendmsg() and sock_recvmsg() directly and don't look at
> O_NONBLOCK at all.

Makes sense. The socket.c side looks fine to me: all syscall paths
(sendmsg, sendmmsg, recvmsg, recvmmsg, compat) go through ___sys_sendmsg()
or ___sys_recvmsg(), and the copy_msghdr helpers only care about
MSG_CMSG_COMPAT, so setting MSG_DONTWAIT earlier is harmless.

Fixes: tags? And please tag the subject [PATCH net] if this is
meant as a fix.

Fixes: 0fa03c624d8f ("io_uring: add support for sendmsg()")
Fixes: aa1fa28fc73e ("io_uring: add support for recvmsg()")

>
> Move the O_NONBLOCK handling to ___sys_sendmsg() and ___sys_recvmsg(),
> which the sendmsg, sendmmsg, recvmsg and recvmmsg system calls go
> through. The io_uring helpers then pass the flags the caller asked for.
>
> Reported-by: Luk?? Lalinsk? <lukas@lalinsky.com>

The name lost its accents (Luk=C3=A1=C5=A1 Lalinsk=C3=BD). A Closes: or Lin=
k: to the
report would be nice too.

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> diff --git a/net/socket.c b/net/socket.c
> index 2e3b5737c481..08658a9b8065 100644
> --- a/net/socket.c
> +++ b/n

This header got truncated, so the patch does not apply as posted.

> @@ -2697,8 +2697,6 @@ static int ____sys_sendmsg(struct socket *sock, str=
uct msghdr *msg_sys,
>         flags &=3D ~MSG_INTERNAL_SENDMSG_FLAGS;
>         msg_sys->msg_flags =3D flags;
>

pw-bot: cr
