Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445888;
	b=Gzd19TUyPyDvdy0RPiY75+jYt9ZS2WZ+i4J6+j9pvu/+eJyd+iPSas7b8CQORcUh4Q++
	 WdD7wnXlU0tNu5EyMjqBtBX3pR/IIpj3s8pCuOSGf/D5b1wFfecOfsRyfxPvUH6c4LWBX
	 bECYg28JnVhztSBjB62XzhYEq8UJ90SglSR7OhnTMxkyZjgCgEmmIs8X6y0kwdn3YEwA5
	 UfV1pUmgPDdTr68iXp7Po2jeWx518ejqkdqdu9YCOVTLBGc0LU+eINDhXtzcWoN3e/2O5
	 o183AD1S0LbmB4Z9LtnZ9EAGt934AkGMPeHNe4XaDe6RtYAYesBKSksQFqR1SyzZxYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445888;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NPvdJpUYiMmd7l/W4W0OMNhwmI0o3gJBVIay13n3kvk=;
	b=mdSi9caioKUwskhfbrfPKgs2I+ppBF/u4DZN8Ij4THus1ay/hPdSaz7AgFfqChbk0EfP
	 FXknQ+XbofcRusPxAvIZ5VLWB2U8Yl+e2rUnSVHfHZ8/pUP6anVjgBYylVnF/LJy060Ld
	 JT7HIqYDu0jV22qFHnEyn2ZV5W+vl62+5zkqkTmt1Kzswp6e5+082VplLrqSmG2bo0c3G
	 WsdAnddMnKbBnNykIjDMQrUX/Ex2pK+IZxnrN5W+qkAAdzno9s9Vh52yRpS4eQq3edH0b
	 I+yGyjaCpzpxmWQZIEmwbIcE7QZgrTcYHCBhi1TCqxEawLXoOvOse11gv4mOX39GdLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfwFYZnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2365606A883
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfwFYZnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE401F00A05;
	Thu, 12 Nov 2026 01:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445888;
	bh=NPvdJpUYiMmd7l/W4W0OMNhwmI0o3gJBVIay13n3kvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nfwFYZntcpiSwABkl3EmNwHLU6SB4lZkYVNtaJTlW3lT8GAdaDmLSkUPj/N63ABF6
	 3KR3Zi59Qft0xX2UZHxZX2cy6IRahkfhO7zkoTwS513OmoHczK+h8mjxDrYYrOC8rn
	 YwyYZ06r7zgIomZGdKFtllSyAxU7Ls9JnaPWpWNfj8jlyOgK8fVPLZYJeNd39NqYMJ
	 MPGZSR08f9M+RyiXZ+rCT5HrnJMw0E+vmVmjoas5i/RgF75U0l3+JAa7v5PikCYLbs
	 qz2frS6lfmENlRnFGFhyxxmvwtWdi8dSk8oMUGuJNrENWTkEBaJ1qxK0V/0ryTECu6
	 UpCzivD8hxA9g==
Date: Wed, 11 Nov 2026 17:11:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: Avi Weiss <thnkslprpt@gmail.com>, David Arinzon <darinzon@amazon.com>,
 <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ena: avoid double-counting TX DMA mappings on
 failure
Message-ID: <20261111171127.7ce982b5@kernel.org>
In-Reply-To: <179444039825.7144.5680478965949082764.b4-review@b4>
References: <20261109123934.824610-2-thnkslprpt@gmail.com>
	<179444039825.7144.5680478965949082764.b4-review@b4>
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

On Wed, 11 Nov 2026 23:39:58 +0000 Arthur Kiyanovski wrote:
> Therefore please do the following:
> 
> 1. Add a From: tag to give credit to Evgeny Ostrovsky, who wrote this fix 
>    (without leading "-"):
> 
> - From: Evgeny Ostrovsky <evostrov@amazon.com>

Unclear whether that's warranted TBH.
Avi is making the effort to upstream the fix, they deserve the credit.

> This should be first line before "ena_tx_map_skb() increme..."
> 
> 2. Evgeny has agreed, please also add (without leading "-"):
> 
> - Signed-off-by: Evgeny Ostrovsky <evostrov@amazon.com>

SoB indeed seems appropriate if the patch is based on prior work.
