Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015538;
	b=vTjIo5sjAdWYaYCJcP5ok+eYCH9pF7zYDmuRVcBvYtO6nVnoQu/B8RlBQOk9wTUvZ5/6
	 pl9uAi/yPmyjUpB6nEoJcfOXwUs8Qkebr2P/NR292+xPfJJ4gEamQabSIdm/e/T5qwGN7
	 /z18891zZXiM7IJlw2jihXoLVwpxsxDWwjZpcqv6NmLum8ngsXOuU4YGGepr6wJ8MhPmy
	 LcYIzCbCXYm6HkXQ8OJckF/oOYmvOPzYudyIkE3mG85+x1NmEN7vPliMoN/z7cGe+68C6
	 oMAAyaYzyGo8TtA8U2ZeIg1AD4tsMS5KviiNDqQCRfTaJGzhXVJaveVJx+yeyIVfFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015538;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fBx8fIg7q+AUQrtKXGrJRvTA5S00RQ78AYgios3WxSU=;
	b=inuCHybOY48nD+fOQCF2mQGRwdXMaxthaV06Oqmw28ZsVFAPCvZyIDoWl2bjOZCIbGtZ
	 cQb9Cn/zhStoN+Os/iG1XPAfZve4mFpsA/hpjDe5un+HKZDlKIpV+miLgKQ2Uc7WAhbGG
	 tXZNcvQKSFutgdahRNSwu70uHPTL6Vg87cH51ZXotCNADRXe+Kq69FrM6RZRMserKEtbj
	 ugyJeEQHXoLgJ5avpKa8wtvQyaclE2RgLy/Yuab6w1+Pa8GfAv4U7KI5IUFBUg0OPGpZU
	 mitMphrcwA3UVjGjrQSn4NkrSTMkK3YLd+NasrDwDPYiWBlQNpUNS02JL4S53xtS/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Isu3ldAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A9606A32C;
	Sat,  7 Nov 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Isu3ldAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152011F008A1;
	Sat,  7 Nov 2026 01:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794015537;
	bh=fBx8fIg7q+AUQrtKXGrJRvTA5S00RQ78AYgios3WxSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Isu3ldAQ9MG9GR8//V88uu3yPh4SDFFHCmRvZ/JAj7mlra/hfv0VC+d1MT2tO19w7
	 w30NazjxARUBaChL0sYwjWJX13QIQWRX95Q/m80We8fWe8u2D24oHohTr4+e8hpiEx
	 JbkJYTdH9LZt2uj+eiYoxuJ6RbV6k5jYxnoq8EuLHfczaJX8YFXCge0RAueOV9wyXU
	 nHkHEkTPtH3PNYWpDBHk1eiRQgf962zlCpwxAepd12M2tM8YOkyJD9Ay1JJ9llGapd
	 QJmuPui9YvrpIiAamtWvUeRBMNBovF812Wa139NFJ1bBt77Y8W43+Xd9UuI28v2u9U
	 YzqFZZX6F8cWw==
Subject: Re: [PATCH net v2 5/5] net: mvneta: keep the TX rate limits across
 open and MTU change
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 01:38:56 +0000
Message-ID: <179401553657.994134.8119365679563489731@kernel.org>
In-Reply-To: <20261103125021.70845-6-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-6-pepe.schlehofer@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message of "net: mvneta: keep the TX rate limits
  across open and MTU change" does not say how the bug was discovered,…

--

net: mvneta: keep the TX rate limits across open and MTU change

This commit stores the mqprio bucket refill value for each rate limited
TX queue. It then programs the rate limits again from
mvneta_start_dev(). Without this, mvneta_txq_hw_init() leaves every
limited queue running at 10.23 Mbit/s after the interface is brought up
again or its MTU is changed.

> Tested on a Turris Omnia (Armada 385) with 1 Mbit/s limits on a
> 100 Mbit/s link. After the link was set down and up, or the MTU was
> changed, each busy TX queue carried about 10 Mbit/s. With this patch it
> stays at about 1 Mbit/s.

[Severity: Low]
This isn't a bug, but the commit message may be missing two statements
that the netdev process now asks for in fixes.

The "Bug fixes" section of Documentation/process/maintainer-netdev.rst
says:

    All bug fixes must state how the issue was discovered and validated,
    and how the fix was tested.

and:

    The testing statement should explain whether the fix was tested
    against the reproducer and against kernel selftests.

The paragraph above names the hardware and gives before and after
numbers from the reproducer, so that part is covered.

It doesn't say how the problem was found, though. The document gives
examples such as "observed on a machine in real use" and "discovered by
manual code inspection". There is also no Reported-by or similar trailer
that would imply it.

It also doesn't say whether kernel selftests were run.

Could the commit message get a sentence on how the issue was found, and
another on whether selftests were run? This requirement was tightened
by the baseline commit f56daaadfecae1 ("docs: netdev: try to force
agents to disclose info for fixes").

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103125021.70845-1-pepe.schlehofer%40gmail.com
