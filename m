Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C2274FE3;
	Wed,  9 Sep 2026 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919287; cv=none; b=iijDwzWR6QRzZX9BxSTA8yReTyUmazpskPWWeYisfc3nQD15aLpADwnb20Qxu/4/XhiHEfTm7m9Dfp0iNr38NtoJdzWPac12NyhU6mN5rft+hWYBSyyJ8gqm3BlfwSY+OF5hIbcGVSFoBtrRhPJ1YUNAL1o/opWxL/Vzrpx/AR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919287; c=relaxed/simple;
	bh=9FED0+0cToj5EruOToZ8Pz7W32lWWYgjFsW9rF/pBLU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/ssnOdkE92roWS3ii4Ts7YBu4N3Yj4w1oLURyVuNPMW9vvsIL5Eil/Pf2rv6I+fqYane1opM7zNmLJOnra7hTQ/Eqfz7t2JzQNBsYX3EWbBcWZWGf5GMUuHKvELoI0qGFWeanzHldTNtodZCb4df/mvCbaophmYqtZMxZmjr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SPpwoX4+; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SPpwoX4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788919273; x=1789178473;
	bh=LPF3q0P1vel19jW7wZDPg7xJRZ74Ih3BUhDtAItYkk8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SPpwoX4+NN+p5O8bM0bHfe1suEFf+mn0nzINzoEADFGzjUoF/pJe/zcAYwHrTQIKH
	 nl1EeMyQEpJUxgCC9b/VP/gro2B/4+RFJ9AmHtNG0z8b8YXuwDYA/270I6XbVsh0fb
	 ORQbQFqmic6nmXEznJQVu/Hd81zA7iT8Ud3N5/xu8dfWWM89uevKJE80uqHlUsedKh
	 EnOUitVKrVfwU8fQ5G/fJmK61kcTTzJqaJ74FXDsIOEZU+v9oBBIHy4kR4YpSWpYrj
	 HL07c3RhAKXFsl/8fORlo24m8GpDBSdf8wXtQOYbfdnOwwyqGDZ2zrD3/eNEAMLpMG
	 2fdh41dMfeVmA==
Date: Wed, 09 Sep 2026 02:01:08 +0000
To: Matthieu Baerts <matttbe@kernel.org>
From: quanyeyang <quanyeyang@proton.me>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: fix data-race in tcp_recv_should_stop
Message-ID: <AW63XbL1Qe0HLtPs6V1EbRuEJORVpqWA1Q-y-xpkvFfznOfDC7YR_WiqBYKo6kISh-Q-JkL0UBiQCizvHwzI4dgkmpI3S46JWifGIS8cIhs=@proton.me>
In-Reply-To: <fecc9c2f-c083-406a-b6a1-55b0b0d2798a@kernel.org>
References: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me> <fecc9c2f-c083-406a-b6a1-55b0b0d2798a@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 1a305181539ada12c479e112c9a2ff4b98458033
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 > Just to avoid some confusions, this has been reported by MPTCP syzkaller
> instances, not by Syzbot. So just not to have people trying to get more
> details on the wrong website:
>=20
Thanks Matt, I will add the Reported-by and Closes tags in v2.

Quanye
> Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
>=20
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>=20
> 
