Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F33413791
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727595; cv=none; b=DWvzslz17FhQdZ6K3aeSdcjEmztLoh2H6GQSuz30aAPQ17IOA0MAASypFHDXXGsPbXzmo3NxczDvGtYG5owgOKbrzoQXe4Vq2AK0h73Fsb2BrfqESyOqJgDrTPBLGHZIx/2TaNis/N4kXvgyDi1jr+aEdaKh2jYgQCUdT7m+IEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727595; c=relaxed/simple;
	bh=A/tEjZoBN7a9c3qtaNIe7aIzPtvWCHu+qwmJ4L5eBlc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W96J6MjSqEz6Oj/wVI6+J9r7hZWyJUIoZfh6gMrw5Fns5yHyVmKbdwr+29U3DL1LwzmWAUB64ZoNW5Zrq/uRPBe8YtqGx/qioPgqy7f6RS3CVGZBmY8zX9HwJeLIOmDukLLTKVnzxF16kSoDY3sFZbv3/5aDwEKv7xFXmppOTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KFU+Blnu; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KFU+Blnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789727590; x=1789986790;
	bh=A/tEjZoBN7a9c3qtaNIe7aIzPtvWCHu+qwmJ4L5eBlc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KFU+BlnuR58y6Hu93ROIMTeGaEOG7lu3H6LMwesd1N3/YyDrfuAUOajEzlYdMVfaX
	 QwCIDvk6CTxVuy09xJnulIYupYXN6Kuubw3mslDorTyD/G0oSPyjyMc7E2uxrF2+CD
	 3acsE5BgOhclIOums1zB82CI6f6oV6GIr8VQqw/8skL8/dOiJAfytfsw88Y0R/9CXe
	 d1taupz5d6veFWlg0BH//9K4kWgUmHkXizQVmtPGX7ZjImMTLx000W71viSu/CfKxt
	 vWKf1pstUHlMj3g2NRivx/InYo7GmqWd4c+s5jOWMJVMFK6poNOoKvjxD7qK6hoDrq
	 xfUIqE6QOmyRg==
Date: Fri, 18 Sep 2026 10:33:04 +0000
To: David Laight <david.laight.linux@gmail.com>
From: quanyeyang <quanyeyang@proton.me>
Cc: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to sk->sk_err
Message-ID: <zEvCcu9s6PbTRajtbCvCik2zCOJsXozLWWvYsLfl6AV4IJLyXmS63i5nuaCmqk_5DsRajMO3IjRtFpOSpmRY55ByjpBJ8NmtwDk-kSpr9bM=@proton.me>
In-Reply-To: <20260918105142.3dc675eb@pumpkin>
References: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me> <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me> <20260918105142.3dc675eb@pumpkin>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: e4aebc8f100fec9c82f878819c0676d89f2b8046
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, September 18th, 2026 at AM 2:51, David Laight <david.laight.linu=
x@gmail.com> wrote:

> Don't they need annotating with data_race() ?

I think READ_ONCE() is the intended marker here.

These loads are part of the I/O control flow (stop send/recv/splice),
not diagnostic or heuristic reads. data_race() would silence KCSAN
but would not restrict compiler optimizations, so the load could still
be torn, fused or reissued. READ_ONCE() is a single-copy atomic load
and pairs with the existing WRITE_ONCE()/xchg() updates of sk_err,
same as tcp_poll() after e13ec3da05d1.

sock_error() uses data_race() only on the fast-path "is it zero?"
check, which is then validated by xchg(). That pattern does not
apply to these peeks.

Quanye
