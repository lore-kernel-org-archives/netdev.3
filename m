Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340527A123;
	Thu, 18 Jun 2026 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745960; cv=none; b=Ud9OzcBIoRMty9BNFim+OR3Z3dTtxUzoKoZ8Lw0uRK9mjyxZ7QS5kFjuPZqbjA+vqM5bpv44j3wXlfXouL5nXwEzF5D2ZV3mZPDO/lu4HfiuKag1AE1vQKXy7ePFSua8enS8Ta5OZI6rns+Z6h/LOPFgrEZLyqImBp/A+G0fR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745960; c=relaxed/simple;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3iTQb74IQ0ShYHSJ3c/e9qVfdxcARKox/74VYLxDvZLq0tpEF4OHQpQac60R1qQ1Nvpi9eYq5nOke39nTHQkiD57AZsvQIN5ihPqdQJqBvAOg2LGAHjYrREsJ7izi7tJM90Fi9UTJAGzFEaCnRfunWcLLlshucCpnsYYkhU520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YeUMjgq5; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YeUMjgq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=edji6ohfindvvaar3ohyzfy2dy.protonmail; t=1781745941; x=1782005141;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YeUMjgq5RCVdTetuI5yb34xTm4SMkHOuDClbFAfs5Ia6sDybWU4ryD+E3fJfzyyzs
	 IvMClPTp/YWHfFU5HTpTVf/3jQKYWRwaiTLsEBdmZW7B/UVqm44mJLznK4LqYm5wLm
	 KTq3KpaOk1F2d5bHhXZBzowUcbN1XKo1k4YsZqFvyD+Nm+QtXsG8E6NvbBnRiG79WL
	 AgvC8HDQa8bbquptr+yIj7f4RWbjWioZg/Kdi2L2ZA+o+G5736Ee6iCGRKO8s2iKQ4
	 TIxSV2Mv7SU6q59mBtbNbA0PLtJJCZgsRBW/tSW6Y0yjIUSFSKmcMbanyyJeM8xWk3
	 lQ3cFAKuVSKtw==
Date: Thu, 18 Jun 2026 01:25:33 +0000
To: Matthieu Buffet <matthieu@buffet.re>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260618012527.34964-1-hexlabsecurity@proton.me>
In-Reply-To: <20260617180526.15627-2-matthieu@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net> <20260617180526.15627-1-matthieu@buffet.re> <20260617180526.15627-2-matthieu@buffet.re>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 578dcb4dea7ac936c800840fb4f141f9fbb80230
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Matthieu, your #41, so no competing patch from me. I built your v0
(Landlock + MPTCP) and ran an A/B: without it, a confined task with CONNECT=
_TCP
denied still reaches the port via sendto(MSG_FASTOPEN); with it, that path =
is now
denied too, on IPv4 and IPv6.

Tested-by: Bryam Vargas <hexlabsecurity@proton.me>

One scope note, since you mention MPTCP: an MPTCP socket isn't covered.
sk_is_tcp() is false for the mptcp parent (sk_protocol is IPPROTO_MPTCP), s=
o
neither the new sendmsg hook nor the existing socket_connect one mediates i=
t. On
the patched kernel my MPTCP arm still reaches the blocked port via both con=
nect()
and MSG_FASTOPEN. If MPTCP is meant to be in scope for CONNECT_TCP, the gua=
rd
wants `|| sk->sk_protocol =3D=3D IPPROTO_MPTCP` (not sk_is_mptcp(), which i=
s the
subflow flag).

Bryam

