Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824364E50BA
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742998; cv=none; b=sZf3OmxJth5F4i4MwZklMnYXrHfQJ6Sgm8t8z5bg9ZX54fvL19VZ6Llsu0zE5Dr6y6k+Zs189vpu/ZPb1wRgNUC7xEX4hJbZzoEhO2cT67uu9l8GoWSTRa566N+ZSdHvM5SIBiIkI/kzQ4TwzZhQ4aLMzwntG1fpd+qooCoyYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742998; c=relaxed/simple;
	bh=mX5Fp0cedAQ8gUI2DxAXpXEcuHO6TangyCkeMGL2wlw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIL93d38VYbFD/9ZEWz8yvol5Rb3ZTDanxml73nReW6nHcAEhXW3pvzFiZLugIxoad2uMhQCQw1hWbhUoqHVa7xIy4HPWrouLXlnn+KuYkwtyqQXOEacIeNpLpjmIQYny82eu+hHMCsp3QxphRMJRCfuQ10umdqnLlwpz0taV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=muBGmk3p; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="muBGmk3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789742982; x=1790002182;
	bh=dvU9mX0+VRxwNBAd7M5TgBl03Can4J/5HqzL3YIZoY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=muBGmk3p/iBjU2gpzxsYH3G/zS2CzBJCSSzCtpzxGZWQPb23d+xSZ66bbAY27qtmZ
	 OXAgqh1nb3OfdNqTexWJBqx9MTe+BIPzLmclr2AR8JK7Oek85o/Jx481hJQYKQP6ja
	 uKSnTdptra9tjTyv8Ppz0Lkfl8rdaMaV25loyQVClbDFvm8NAA4pY0x2P5F90w6/37
	 VQJymRyq5NqkqrCIYsSWw6kc8DzjQnguIjonJCmUWRxq6PM0+7sHAZlIC+UhNQb4bb
	 5wDzRutdpoKzLqKPMeOD6MSMiYPSRK5KUpL/1p+GPLTOD4FL4Qf2MYgoDPLA4hTGZi
	 Xz8X49MQ+8HNg==
Date: Fri, 18 Sep 2026 14:49:36 +0000
To: David Laight <david.laight.linux@gmail.com>
From: quanyeyang <quanyeyang@proton.me>
Cc: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to sk->sk_err
Message-ID: <3Xbc2sQjLprXByAnJqDFV0YozlncqBdk3n_5MSppJHOCg5e7npnTsSnaW6pe_lWgXs1jnGm2v_orUWs7qIgMdkpHb63hjuw_9XgIpqrr184=@proton.me>
In-Reply-To: <20260918132747.6ac8beeb@pumpkin>
References: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me> <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me> <20260918105142.3dc675eb@pumpkin> <zEvCcu9s6PbTRajtbCvCik2zCOJsXozLWWvYsLfl6AV4IJLyXmS63i5nuaCmqk_5DsRajMO3IjRtFpOSpmRY55ByjpBJ8NmtwDk-kSpr9bM=@proton.me> <20260918132747.6ac8beeb@pumpkin>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 1819dbaee6804864bc7593369e826cc1f32b5abb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, September 18th, 2026 at AM 5:27, David Laight <david.laight.linu=
x@gmail.com> wrote:

> If the race is with locked accesses I think you need both.

Thanks =E2=80=94 I think I see the case you mean, and I may have been looki=
ng
at a different pairing.

If the stores stay unmarked because they run under a lock, and the
reader is the lockless side, then yes: READ_ONCE() alone is not enough
for KCSAN.  The watchpoint is still the plain locked store, so the
report is marked vs unmarked.  data_race(READ_ONCE()) is the usual
answer there: READ_ONCE() for the compiler, data_race() so KCSAN does
not treat those remaining unmarked locked stores as bugs.

The splat this series is trying to fix looks the other way around,
at least as I read it.  The access KCSAN caught on the write side is
the lockless xchg() in sock_error(), from getsockopt(SO_ERROR) /
recvmmsg.  Those paths do not take lock_sock(), so the peek under
lock_sock() is not actually exclusive against the consumer =E2=80=94 the tw=
o
sides really do run concurrently.  The peek is a plain load, so that
is the unmarked side of the report.

TCP's own stores of sk_err were already converted to WRITE_ONCE() in
e13ec3da05d1, because tcp_poll() already peeks without the socket
lock.  The consume path is xchg().  Adding READ_ONCE() on the peeks
is meant to mark both sides of that race, same as tcp_poll() already
does.  Wrapping them in data_race() would also silence any leftover
plain stores instead of leaving KCSAN able to point at them.  These
loads also feed send/recv/splice control flow rather than a
diagnostic or heuristic, so READ_ONCE() seemed the closer match.

If you had a specific locked store in mind that we should still treat
as unmarked, or a reason the lock_sock() peek should stay a plain
access, I would like to understand it.

Thanks,
Quanye
