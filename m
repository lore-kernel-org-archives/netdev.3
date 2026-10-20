Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524276;
	b=XUR5DMKqw293/o40JS+dMw3lrtPO8CoZlPrK1RtEvnnBvogOwuR9QP5xzKvtQOiSmx/s
	 3xsaHgVZF0FGvBGYvN2HnHRmdQprOXGyXTIFGo8VlU/X5SUFFJOYDsxxkzuww6NlD7y34
	 wsRQ1EY82HPQRiQ5EJToJbCyyZvhims6cE2++o7yYjViQ7n0rL/f0EonSN7taY4dzRDse
	 3Cr6hdR707zpLjMR7BMvWFNW8QWaziViN0d0Ox4aO5P3SrsZ08O+qbz8vRIApiXxjVbP4
	 vk90pOA4m9KE0sdiiSKvcu2xp0Q9QwyrEMDqmMFcPuC6R+f95z8tpWNTlVWGxTCTCOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524276;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M+Z/CSLfbtLNI8KeSX5aKzw16HLuhGFRAPfRi2/mK+Q=;
	b=Jo/EZU1iJlZQYGqC8iBXMGnu9N3QQ/qDxiV3LsrZihn00j0YND9t5gLUrmgORbr/9awk
	 v+ZBjleLJjn1XRsym6GppwGAMWIMcp3cvCYmJ5m4aA6yhQkiexr/cKZi3kQKeWNPZe5d8
	 2GEpOCae+n6gnjZB7wIj0vEWmBbobgivPRwA3bSsuUVwqrZ2y5T2eu2t312hcYfE+C8GN
	 oL57+Nvg64tjnfcFDzz6x0F0Wn4SkEkY4cm7sksKtYa868YnFEYLd2WyrTxFfvCsAjKni
	 18bK3kMtYNBUCBvR+5Wxfow8KXQ5AUjHIpoS2xPe7BVIxB6DbIv79MONBiEQj9ODCOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQYQbvSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC8606A319;
	Tue, 20 Oct 2026 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQYQbvSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C571F000C9;
	Tue, 20 Oct 2026 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524276;
	bh=M+Z/CSLfbtLNI8KeSX5aKzw16HLuhGFRAPfRi2/mK+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SQYQbvSSg9eIQLU+57l0bR1dxOfpeKYESIKHUWNz9JoioDMv3Fj1lxY26LXV0jQU2
	 EDgnWLIZJnGddMMvgFdK9940KXRUN/hCQCx1eBDArjd2jHuQ59XyPjTB3N1rEO+yZv
	 xhxnessAWwtS6Q4+ODoiX8ThveA29T03rDZU5PR2cLp4SkGvPHVlkXsowiQaQyvFDE
	 JAuopzelMV5mIrmmyyEguGQn1rm/NA7/avt7uYWzeiCObNSv3m3JUcMmtRDQeuuGaC
	 XzWKbAJ51RezPlTc4qiuvamvRuN+aY2jAYwdwEP1cV3l4TTaecar8FAAOWOxlyT1jN
	 zZvRAMatcykMg==
Date: Tue, 20 Oct 2026 12:24:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/4] ipv6: initialize temporary ifaddr before
 publication
Message-ID: <20261020122435.055178e9@kernel.org>
In-Reply-To: <20261015143230.GC1794897@shredder>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
	<20261015050651.1841557-4-4ncienth@gmail.com>
	<20261015143230.GC1794897@shredder>
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

On Thu, 15 Oct 2026 17:32:30 +0300 Ido Schimmel wrote:
> FTR, I suggested a smaller diff [1] which you decided to change without
> a comment. Tagging this one because it fixes the problem and because I
> want to put this frustrating submission behind me.

Ido, FWIW it would be more than fine for you to take over and submit
your own patch when the author is likely an LLM jokey simply feeding
sashiko reports and your replies into a machine.
