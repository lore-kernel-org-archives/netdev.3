Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388744A4852
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344156; cv=none; b=G5cI2XVz4VR0XVQVO8kvqcAwGEh/9gUSc+iPbf7+UCBejMsFO3hjFjPUrxaLtbTfTSwhUFo27wVWSAVqUR4joB+lapX+HhRcE4DEAUloE7ms5CtbHO+1hWoJ5jqjRSyxGquWy5b6qNzeDw9utjIrqs4Wc5qosDm0oM85d25Ch3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344156; c=relaxed/simple;
	bh=tUe9GrCHs+m4VSFoAyfXEVxK2G9hfqNSWEOdWXh6JAs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQ04RiuJNUI8LGMwyLrWB1v3kQmSyt7SQOduYRB0WIryNRtkGsU8m8TiI5Onpe6UiiAoaOoIbExHrpFudemNbeg10pSeFycOee1OdnOTM34Q7RfEwgqwG0CLyp+jbHhr/J6t02FLkkk4f+wPxJr7i/80mt+TpumHvllqjJ4xsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxoPJQrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxoPJQrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593561F00893;
	Fri, 25 Sep 2026 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344154;
	bh=2UGuePPlkczTdqwChoy4uqFCsGsHS1f5hWfcuWW/uS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QxoPJQrYDeyJhZ2AADPXX/051kkxJhT4ZUxqv0IpCAkYO2ORaHffh6BXg7BaotQFQ
	 36r7ALLt8IQd40dJgcmTKCnpfYhE6FX1OHNwdaNgLK/QBdkvtfNd58zrEQved+j+ye
	 UAztIlLCy7yUaBtahTQ9KPnIZtCnPiiuWnkoSDRR2t6opChpXkNFp9CapS5Nh+NWCp
	 M8tB3tRdNcT7vwAAc1Cwn8uxNDBaroxZWVkW60sW8xiO9xTPSzxLdmFai1ucdKyKNe
	 HTwukABTjweHWs9xV7b9XhAaLC0PNdgNKgvfNUBV2Wc0C11yyzsE/sNuMiQJk86/7s
	 UrOsVGxav3s4w==
Subject:
 Re: [PATCH v2 net-next 2/9] net: add sk_set_nospace() and sk_clear_nospace()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Fri, 25 Sep 2026 13:49:13 +0000
Message-ID: <179034415390.2160803.16684449131851836526@kernel.org>
In-Reply-To: <20260924134729.2047213-3-edumazet@google.com>
References: <20260924134729.2047213-3-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc added for sk_clear_nospace() in net/core/sock.c
  says the helper is "Called from ->sk_write_space() handlers, once send…

--

net: add sk_set_nospace() and sk_clear_nospace()

This patch adds sk_set_nospace() and sk_clear_nospace() helpers that wrap
the SOCK_NOSPACE bit operations on sk->sk_socket->flags with a NULL check.
It also converts the core networking, tcp, kcm, mptcp, smc and tls setters
and clearers to use them. It prepares for a later patch that gives TCP a
private copy of the bit and needs a single choke point.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2948dffcc3e1b..11a22aec7e414 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c

[ ... ]

> +/**
> + *	sk_clear_nospace - tell the transport no writer is waiting for space
> + *	@sk: socket
> + *
> + *	Called from ->sk_write_space() handlers, once send space has been
> + *	made available to writers.
> + */

[Severity: Low]
This isn't a bug, but does this kernel-doc match how the helper is used?
One caller converted in this same patch doesn't follow the documented
calling context.

kcm_tx_work() in net/kcm/kcmsock.c is a work item handler
(INIT_WORK(&kcm->tx_work, kcm_tx_work)), not a ->sk_write_space() handler.
It only tests SOCK_NOSPACE and clears it without checking whether send
space is available. After that it calls ->sk_write_space():

net/kcm/kcmsock.c:kcm_tx_work() {
    ...
	if (likely(sk->sk_socket) &&
	    test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
		sk_clear_nospace(sk);
		sk->sk_write_space(sk);
	}
    ...
}

Other callers converted later in the series are also outside the
documented context. For example, the sunrpc svcsock code clears the bit
from a helper that checks wspace. The doc text is still the same at the
end of the series.

The commit message calls these helpers the single choke point that the
follow-up tcp_nospace patch depends on. Could the kernel-doc describe the
actual calling contexts, so nobody relies on a stricter contract when
adding ordering or locking to the helper later?

> +void sk_clear_nospace(struct sock *sk)
> +{
> +	struct socket *sock = sk->sk_socket;
> +
> +	if (sock)
> +		clear_bit(SOCK_NOSPACE, &sock->flags);
> +}
> +EXPORT_SYMBOL(sk_clear_nospace);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924134729.2047213-1-edumazet%40google.com
