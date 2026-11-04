Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800207;
	b=huWNjjAQHtUq+zO/n9UrxuIg9aiwx51q9VydU2BeFTBzSjnaa2xmOgqmk5uPj1xkxMhX
	 mUtM08pEPx6mLbBnNBybTPlz98BHZSZ910rrmWI+TPPeyRQ9GonYCfnmmvWNUcnSHEEgA
	 Lc8Ys9U2XBTfRkVqel/W4fMphkXPokezbLbm1Sr6KQFuTPlOEVb7V+4TTLHkWFuEa8mTb
	 OI/uRD8GtD3mOROENPPzeY0kSPDXts/XNoE3OPPtUSrdhVSwKwtv2wkjbc7slVYImxZQv
	 9cFnq4xYmtPqaTeCNjNiK2Rlzh0MjZaHaoaypA+XtfhmF9p5WAday/IVuDFcqMT0gdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=m9eNKZymUZDV599TNBQYhGY4P7C2ACNlTZdsK2E7jkk=;
	b=CbEdeLqSRkj6TJjCbZE24uYkxEug88LHIgQ6+2SkjM9E8YA67LpeAbC9eaxmQmP8ECkR
	 KlYKngEtvQvGJLQrV7tMQrJEAinhyf/KISH3+BCHmEN9I/SOGL+SZPgfxiOGBuxY+xhZt
	 YpjbbTumh8iBP0KGaM8etp/7waH8JJ74qtrcEuVULdbSReCb3+chNvQh8i71w8x5ufVdd
	 93oB+br5WKGlbeepPyLeY1K/7Y2I8UAz5UzpvvwOqycQh4Eh8FV+07cPhQ/BtmI2P8mXH
	 L3wiwZ+GxtKPJu7OqxZI++9rABE0lZLiGi3FOmyUhvg5NeCyMesNVCl38dOiksxjL9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yp/1cEzA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAD606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp/1cEzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8585E1F000C1;
	Wed,  4 Nov 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800206;
	bh=m9eNKZymUZDV599TNBQYhGY4P7C2ACNlTZdsK2E7jkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yp/1cEzASPC4ZUrQLOoez/mJDJkGQwSgduj5+/x6UUu+0LetgXgzKVk0hGsCbDSsA
	 RghidlxzU4PslzFOhU/3LKcDVItaws31VXSu25mz18ZrrDlhIQbMD0RG159RJYsf+m
	 n5vYhnzaxVpK/S0HraQ2OM3flgdXQZYfWP7mBvjhk4C24HK/ZO7dY3yelEUnX5taSR
	 zQtze0RURmp8u1N2J1zfz2i5+kMapjD/bOIruYGQC9U8sjjMZ6uPTf082Up1LMX39a
	 E13U+tk8CO5ibeD6YobdnfEVYV+5QmvZy4cvMDJugrDHhlcLr1zjgw4xOHMm4flgob
	 GHJy+laFIcReQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1A039E4DA8;
	Wed,  4 Nov 2026 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: Fix dup-ack detection on non-SACK
 bidirectional
 data transfer.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380020530.2833154.12750982723708485275.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 13:50:05 +0000
References: 
 <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
In-Reply-To: 
 <6426d558e45fc6ab724c40af62e4a8793215dd8a.1793219189.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, Tom.D.Williams@morganstanley.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Oct 2026 21:32:35 +0100 you wrote:
> When receiving a pure ack from a peer that also sends data, we can
> have SEG.SEQ > SND.WL1, even though the segment contains no data. This
> makes tcp_may_update_window() return true (because of the
> "after(ack_seq, tp->snd_wl1)" condition), and tcp_ack_update_window()
> then adds FLAG_WIN_UPDATE to the segment set of flags, even when
> there's no window update.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: Fix dup-ack detection on non-SACK bidirectional data transfer.
    https://git.kernel.org/netdev/net/c/11140c51df12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


