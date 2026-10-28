Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228049;
	b=ONVTBvGKfCHRhz0sXNbhuTSTHi/4qyxAIN+YLRHKVKBjNQwM3qo6YzDTtO85UxVFcjeD
	 VzIAAtmWAqjF4oCdSGIhwbaT9b8XRvIhvn0YXPuGyCWcSCWrzXP9KUPIg+mTYQmdg8VBq
	 28jZyCQ54qpPM78cT44aVfXivXwm9/8jwMTTq0I6TUNHUO1xidtt1ROafiZQm5CA5hORg
	 uCduoKNHsGlruTn7XGwjAwH6R54etAdRT6P3Ko2ItoqDWScHDpy8pqsM4qeALF8dM4zgs
	 M83pod2uuQPtqT6gVmbSNWjNLaxJpx/D9nc1WehRJ6kGrptyRg2Ri0Ez854CiHuwAUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J2JFmHQKnXzvuthRFeIJu+fw+iA/XAbaNbguxe2zCS4=;
	b=lL3GbMlV3dCRNOlGg7nYNQWlbQFceFtRKCn8t5CbGWdDXS5tr1eloRd82MtKK1YLrFx3
	 UPmqFD5M3LtLkfXOsEXMENwNj0uQ7pd9vI3hd1BJ9fauo/fZFSVzhTEfqb0mkZMi+OOcp
	 jjD6Jmoi6SltOZS5gpmYzzTILBNwThlhWpP/s+vg/naeakUcQNweQXyXGL9CK1tLFDyE+
	 dm+z14eDf71+Adt34KHWjtN/vX8AfFQY83rbli3yBhlm7L/nIqb1CmO08T3roTeh7GTNb
	 KvmnZglZrr4C/VLOUbJ3a2npogixLASV4YQvtCTsSLds7aE4mA1rbi/jtcGXnUCJ9og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhGFUVTE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFE606A31C;
	Wed, 28 Oct 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhGFUVTE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E130C1F01825;
	Wed, 28 Oct 2026 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793228048;
	bh=J2JFmHQKnXzvuthRFeIJu+fw+iA/XAbaNbguxe2zCS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WhGFUVTEM6tytriTUoc6gHMhGzY16YKQFA5sMaTPmS8x6Qjv9xcTYiggRDUVBEtCQ
	 WOHt6dPjyCpicCM9a1vkFygQ4EzIcthg2pfyGa4fTmt7rG8TNVLn7nXN5zPtfaA2OV
	 sW+emRvJuNBcD086YSsJEjwyMM2AWdmDwBvXb2Xe8qXJqc2Kq8VPvcu0gHdNn/rDYl
	 HNNRzuw07POf3puuhnybvm+VSoNYHmGNx8YvNK9s3Ka2MSSpieaiGz1pR1iwsv8S7B
	 TDp34QmCu8uXmf5tO7ImeHkail5h9uO2Hx0S2zhFREOtVBsYfcI69Rt8GkmcKDfmQA
	 jTQNbad13i6cA==
Date: Wed, 28 Oct 2026 15:53:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhewei Yuan <yzwlhm@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] tcp: Fix fastreuse cache initialization on first
 bind
Message-ID: <20261028155358.10d03bae@kernel.org>
In-Reply-To: <20261026095208.58504-1-yzwlhm@gmail.com>
References: <20261026095208.58504-1-yzwlhm@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 09:52:07 +0000 Zhewei Yuan wrote:
> inet_csk_update_fastreuse() initializes the reuse caches only when
> tb->bhash2 is empty, but both inet_csk_get_port() and
> __inet_inherit_port() link tb2 before calling it, so the first-bind
> branch is never taken.

Applied, thanks!
-- 
pw-bot: accept
