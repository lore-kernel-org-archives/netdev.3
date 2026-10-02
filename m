Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF90418A2D
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931072; cv=none; b=lGO+XOWEkeEdR1cbmbjbV5Y6GKXMbMaWvvh1b8iqC26dTTtGGpUGWgmjfxpD8yZhdJ36sahbeoZofblsQ5Zzrabb+ObLNR7ut8HGSyV08HDwxZN8Fs4CMGDtRh4DNSTzd+UoFBK0/sI0MCuKUCohs7MnqncK+EcC9xgRHij1wms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931072; c=relaxed/simple;
	bh=xoWZSIEv7HOInPUI8RIa16dxBru7TiEIR0PQ+44/t6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYrNs//v1JpvzbSuUdmSzVlCP+UcAy4lcld7RSywsVmwNHinvsLQF/ZdaQ/EBGBlGUdwBiz2tIlFWJJvJCTAmaEuXKioMV+sVVUAqj1P2L1dXrDV94RX8KNuKiYCqMPbXSfHRH87ZWYQ7iuInLqoqhJ6W8AB7zPhK941VB6Abe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6CwfXrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6CwfXrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203921F00899
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931070;
	bh=xoWZSIEv7HOInPUI8RIa16dxBru7TiEIR0PQ+44/t6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E6CwfXrqQb0ca/jAvz7YROY5bHpJF4gr3nFeN1YRgDr/ljfULSibjnxFBWQkfvaHP
	 R+VUR0S4iVpoAO+HOtldmgN+zffqbTW5ibz53LX+y79Xdqfn/hdFnLI747Cet6YvrG
	 NYuDprSPlzK8u65zcenVZp/zBCR0aGRjwAChWe9Djeca+a3joQP4VU2yXPfxrCObpf
	 db0cgA8PwjafAgK7jTcmMubgwBVSyrU5tjCNtRdEoYG+7Cq4CfF6LuordswqhMHiI9
	 Jv1msMShx4yIvkbsOIm5aShMcOBhJIfQt4sAu+UB6zM0M7uvyBqUdYp3oK/I1rJCra
	 l3Uaid2P4ZJOA==
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-821ab84c100so900438a34.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 01:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzL8yYHquW1cValJqogD3l71ZVuSn6HHUvIDWP/ToI/fIna8UF2+WcgiJSdfLURERSOHhMB5Tw=@vger.kernel.org
X-Gm-Message-State: AFuF++kZItsYNIuzsy4pXEjaHptmJXDJmSjQyPaqL8iuy5n4iRh77h9o
	bVh07FtMJgb8xFcNm7BI/5+Dve9p1kiJ0DGlYSIlbS8Dbme/NYbkqvRpk1khyMwZ0KflJOKG8Vc
	/eqFPMZ0NdwZrLsBEq2kphZcHntQPOC0=
X-Received: by 2002:a05:6808:169e:b0:4f4:ad3:3ce5 with SMTP id
 5614622812f47-4f529d36462mr1470621b6e.17.1790931069475; Fri, 02 Oct 2026
 01:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me> <20261002-tls-fix-sk-kcsan-err-v1-2-baa0ba056323@proton.me>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-2-baa0ba056323@proton.me>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:50:57 +0200
X-Gmail-Original-Message-ID: <CAL4WiioVeB1Hj9p5t2iO6r_Nhon-n3ooDC3hwOuOX+JVVpMz4A@mail.gmail.com>
X-Gm-Features: AclHuK8ma2xr2S7Nd2mIXaqvV1AfESX8_NNCLGgVpsMCRSopQdfu6BquIF1bhJw
Message-ID: <CAL4WiioVeB1Hj9p5t2iO6r_Nhon-n3ooDC3hwOuOX+JVVpMz4A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: annotate lockless writes to sk->sk_err
To: quanyeyang@proton.me
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 9:29=E2=80=AFAM Quanye Yang via B4 Relay
<devnull+quanyeyang.proton.me@kernel.org> wrote:
>
> From: Quanye Yang <quanyeyang@proton.me>
>
> do_recvmmsg() and getsockopt(SO_ERROR) clear sk_err with xchg()
> without the socket lock. TCP, MPTCP and kTLS already peek the same
> field with READ_ONCE() or consume it via sock_error().
>
> sock_dequeue_err_skb() still uses plain stores. tcp_recvmsg() can
> call it via MSG_ERRQUEUE before lock_sock(), so those writes race
> with the annotated readers and with sock_error(). The same unmarked
> stores exist in strp_abort_strp() and sk_psock_report_error(), which
> run on the TCP/TLS socket.
>
> Annotate those writers with WRITE_ONCE(). No extra ordering is
> needed; this does not change who wins when ICMP error-queue entries
> overwrite sk_err.
>
> Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365=
@redhat.com/
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
