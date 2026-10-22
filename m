Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695709;
	b=buuZ0gzqY2OhgPKoBXqeXnOBzt/AQgTcXKOyFc3MNT0Ur++8WsIO5cxulwkLk733206Z
	 KPuwEfXIRr/M1Vg+XgfFrzZL2aBnw/tP2X4uyH1qR8aDpF9f72qBzedr1EBPF4A6cr/5e
	 8k4YwoBUVqwi2qewBzOr+Kiwpz+KNbeY1Rn3m4MZ5fQ/67TwmxwqaKigUeWaBlGM0ZvFi
	 3Kz0krTikLZzXU+K11CPIDkKBLWxRNoGkm7YJrSHKdWKaFjuIwSRWH0qVEDTIqfmJ/HOM
	 XAAOX7i5UPLq+0WkNHoQA2Sde+KBBOPl5gVdEzFARz6vhXAr7A2EhZmTTnHsQhgn2cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695709;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zGl6wnVyXS+Nhqd3FrSqOXcqC1CFxdM29kEn0+f7MxQ=;
	b=GyV0D/bnARTPicKYyJ6fcGJ/7qizmT2+A5iAI4NUQnd0b/3eNmCyKsQrxSG3F9dTuy/H
	 9cyFVlK96Qx45UGJIKD/qO9ebdR3om+4+BRpqgsGtv9YGce2yEhSO3COP/H8DFyXSW1V3
	 W/FT72y7qm6SJxkm0BGGU67Hb4Ehj27TO/bFNuRjZz3cnSs1wAxu+KxcDOrYUcvXA26ZZ
	 D7wcYqV9MaZFRsFax2rEbmemTySVyHzLLT/rq6i0kDs0J+R8pgr1U8B5gnCw2F8XUhNX4
	 I70aAzw64c+tAn/6J2tVcxL6jbkTtB3CNCw7hDcSK9kE1USona8u33IGtUmF+Hxkoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpaQqmXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCC606A32E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpaQqmXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089FB1F01828;
	Thu, 22 Oct 2026 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695709;
	bh=zGl6wnVyXS+Nhqd3FrSqOXcqC1CFxdM29kEn0+f7MxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dpaQqmXt0Xz1g8sKcKhV2uquVgpO71dUFYUHBLoVbPf3NxkD67Q/Dad/A4PJeiT8S
	 xc7rP5sLz9PaJ3f0oLIjclefzh1usoEu53DR9Bv3BkaQS+Qf4/1HajSU/JPOalsOgL
	 5hTty1xDUd44oT1vtHEvdzkfA4T7EwRZ+Oo8xLjABcc/HAEeH2klBFW7M7f9uOlYjc
	 5pNdaXafRH/uSJsC4fhIP8xYWHailUDvh6uy4fwkQZswDMF+RbpYDpm63jA/p83bkP
	 U3VVTv8RCDD/OlIvE8pk4qNU60o4LNZD+F5+3nbnNwCffMqhHuVImXLmi8+6d4At15
	 7bj9ONnKpkJiA==
Date: Thu, 22 Oct 2026 12:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v5 00/12] cxgb4: Add T7 adapter support
Message-ID: <20261022120148.365b30a6@kernel.org>
In-Reply-To: <20261023023829.1242622-1-bharat@chelsio.com>
References: <20261023023829.1242622-1-bharat@chelsio.com>
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

On Thu, 22 Oct 2026 22:38:17 -0400 Potnuri Bharat Teja wrote:
> This series adds support for Chelsio T7 adapters to the cxgb4 driver.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

