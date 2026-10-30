Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399762;
	b=S259KpRRlb7DjnPTMm17TIb2GueLKmXF3Xsy0YFJWX40xvRGPle2NC3XCzGSFz22uKPw
	 UwjQpO4rphkg8XI4w837Q+ffinCpsvnWL8rlu6BUlucunIcFj52JzkBcjXLd+Q0u15CFL
	 PJOHeJrLFtB1thLOv8fVOlCG2QtIfCwxtFce7a7krVgGZvVvreUEFQrFbg25BmdzFuWvh
	 uxU03PeTGzH7OcabCBig4h7MfOF6ZN9H3hv15GhNIrUKbpYPs5PEgggvoeYixbrVg6hxo
	 eVAJyynkXmYl8A1ImXEiu7XsjaprJw9vC3kaT6nkdGlB3fM75ynVq1RH73GsTGnXoLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399762;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kfxy8AkKk5nLFTiKmVqas7UIE0D6SaxWgJyLbq0LLeU=;
	b=Ct/VNipnpmnik2OSbDVEgxdiGm0Sud1Pa33bcvW+yQx7aZhsnY7DSb+LTtENMtSAhcHu
	 q8/eq9+0PTiPayig2/MkdNhFmcZUSPz62+mnf/89P/YMZH+95J1Vir9b/iEnPw5AK5Z3s
	 bySWmPex/GOXUvISt9InJcYDeTCs46PET6i8Zmd0DoBoY6N+geHvH+HM46TbdH9koYXvr
	 5c8yrBvgv2wMKAjgb+dLB9fSnV105yQjLcwzjCc5LoCNOvYS6VB1RLO9pygPGvyKbgxoF
	 vWnFMxCwoyWiI7h3WlP7dkkOYQ+uXaSkBkrnNOlrt+8WAPRlEexptWBoMfh5oJWqWqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=om3SSaZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DB606A31C;
	Fri, 30 Oct 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=om3SSaZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BAA1F000C1;
	Fri, 30 Oct 2026 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399761;
	bh=Kfxy8AkKk5nLFTiKmVqas7UIE0D6SaxWgJyLbq0LLeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=om3SSaZbX9SkipDSmF/DAAQXklzgJUnna29fn1DV5+gDVEbfGwbbuj0Ki5mzAtw2G
	 TP8oW4og9Wda6JiI/HE3q183D99qE+vCSNv6cFOgu397mYXj1y8AlhbV6ljJT4oJo/
	 COWyzfMpYfvq/2PuVRN++0Qv/CA+t/jXf5uOPo5fhJDsakiOYHVMUgTohaKmbzyLnO
	 oMkDpg48AZq9Jr3uyu5ikmo8J0yRapR0xaLGz68MocROOoqVgNe7ItyBWAnoFl3/wo
	 ydCm7+WMT+SQgi3YwNSVT+Z3H5h8lqfg1gGRYzSAKYC+DEXBY/cFTUasgzL6oE0kvf
	 RBnJApSDD7PMA==
Date: Fri, 30 Oct 2026 15:36:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Asim Viladi Oglu
 Manizada <manizada@pm.me>, Eric Woudstra <ericwouds@gmail.com>, Felix
 Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julius Bairaktaris <julius@bairaktaris.de>
Subject: Re: [PATCH net-next v3 1/2] pppoe: pass bound packets directly to
 generic PPP
Message-ID: <20261030153600.7462ad5d@kernel.org>
In-Reply-To: <20261030045943.2093-1-qingfang.deng@linux.dev>
References: <20261030045943.2093-1-qingfang.deng@linux.dev>
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

On Fri, 30 Oct 2026 12:59:39 +0800 Qingfang Deng wrote:
> 

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

