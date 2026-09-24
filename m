Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBD2EACF9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209662; cv=none; b=fbrX+WsQ63CGnLOdj0s3ya39FPKLGCZuGvR5pVBRkWyc6U5qX9O3qAaeNz57igbTxDkwEQ9y2BGqvY6fz+Ub6R/U7m65Inb9r8vAUEP5gqY+zGMz6yFkxxz/KguCr3SBJtpP9tw7jMDaiymlEv9BIn2nPi25ixHW4T81ykh29Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209662; c=relaxed/simple;
	bh=DzfsgSOs3FOqWHm8xzYAoxZ7aUWXEEaBIv8P6kIiZXo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8VnJ3zIJDlpA9AKWHp7X0Ky4mdzvP+6LiKRYsVnCiRBVrPP4QEJhfJk/2SKSBtq0f42FpIFeEqP47NTuER2uuwulPSIPQcaOa+XUzIkV1iQZkpFk+vapHnjyQ4HEZcJGm0Th0Bv2aFlh5NQgrCVBDGw5sMngX5Jwna+G/Di5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1q+8UcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1q+8UcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5181F00893;
	Thu, 24 Sep 2026 00:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209660;
	bh=kT8gQlyxXq7Szn/L+OIsbZBMaZnX5MjZA2EUtLyVm9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T1q+8UcG19GyAfYsvpVakh217AONvTP3Ucdv5fbMaoISi/SynKKaAPEdRO478T+Cl
	 nRNQAlSkft8eemW/gSnbSKsua9868PGzKXjujqiOEqpAV+61b8iunDL/JCT9JhebU0
	 iGb2mv9AJysZTztVhPzEVj1dhrwH1U0ysI0yCJMPzpiPYhViITnzqnQItx3sV6aorM
	 Y6wKED6BIijBszbRJMDMHQlV/5Hagoh5MVjsqnxW/BmYsb/wdnmq2X3rxue6pRDV2Q
	 NJm6cMW8t8p46vtkfLSZWcM5Erh3jCzqW88ljJVEZ08zjdsyNe3Ia0RfHb3lm/XJEn
	 iaRZzDP2OJE9w==
Subject:
 Re: [PATCH net-next 2/9] net: add sk_set_nospace() and sk_clear_nospace()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:27:40 +0000
Message-ID: <179020966002.2160803.11537948312109210054@kernel.org>
In-Reply-To: <20260922122721.3568295-3-edumazet@google.com>
References: <20260922122721.3568295-3-edumazet@google.com>
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

- [Low] Changelog overstatement at this commit only: the commit message
  of "net: add sk_set_nospace() and sk_clear_nospace()" claims it…

--

net: add sk_set_nospace() and sk_clear_nospace()

This adds two helpers in net/core/sock.c that fold the sk->sk_socket
dereference and its NULL check into a single place, and converts the
SOCK_NOSPACE setters and clearers in core, tcp, kcm, mptcp, smc and tls
over to them.  It is described as a preparation patch for a later one
that gives TCP a private mirror of the bit.

> Add sk_set_nospace() and sk_clear_nospace() helpers and convert all
> the setters and clearers to them, so that "git grep _bit(SOCK_NOSPACE"
> only reports the two helpers and the remaining test_bit() sites.

[Severity: Low]
Is this description accurate for this patch on its own?  At this commit
the grep still reports twelve open-coded sites outside the two helpers:

  drivers/block/drbd/drbd_worker.c  set_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  drivers/nvme/host/tcp.c           clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  drivers/nvme/target/tcp.c         clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  fs/dlm/lowcomms.c                 clear_bit(SOCK_NOSPACE, &con->sock->flags)
  fs/dlm/lowcomms.c                 set_bit(SOCK_NOSPACE, &con->sock->sk->sk_socket->flags)
  net/ceph/messenger.c              clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  net/rds/tcp_send.c                set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags)
  net/rds/tcp_send.c                set_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  net/sunrpc/svcsock.c              set_bit(SOCK_NOSPACE, &svsk->sk_sock->flags)
  net/sunrpc/svcsock.c              clear_bit(SOCK_NOSPACE, &svsk->sk_sock->flags)
  net/sunrpc/xprtsock.c             set_bit(SOCK_NOSPACE, &sk->sk_socket->flags)
  net/sunrpc/xprtsock.c             clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags)

The remaining sites are all converted by later patches in the series
("sunrpc: use sk_set_nospace() and sk_clear_nospace()", "rds: use
sk_set_nospace()", "dlm: use sk_set_nospace() and sk_clear_nospace()",
"drbd: use sk_set_nospace()", "nvme-tcp: use sk_clear_nospace()" and
"libceph: use sk_clear_nospace()"), and all six land before "tcp: add
tp->tcp_nospace", so the single choke point the mirror depends on is in
place by the time the mirror exists and no intermediate tree state is
broken.

Could the changelog say that the conversion is completed by the following
patches rather than by this one?

> Callers that had no NULL check are all called from user context with a
> socket attached, so folding the check into the helpers only makes them
> more robust.

The same "some with a NULL check, some without" wording in the first
paragraph reads as a description of the state after this patch, when
drbd_worker.c and net/ceph/messenger.c still carry their own checks.

<br>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922122721.3568295-1-edumazet%40google.com
