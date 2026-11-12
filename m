Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510393;
	b=ZbIaJwQvjvYtAte8QkkJjMQM6DiTN8tWnX2tvN7ZhzoJ/p6r7QM9tFfj6QP36eB9O4nC
	 OezvxLaSoJqpQHkjr/N48+iIUTcrKLl7XWIbYdHOZNkK7j9REqOs+aCkKHOPQYx47kPnR
	 of5mVHWd0OJv1Y6EBiBRc/eBrjVwEV6rIJxj8WfJVYJEm3coU3y2oD5kEZYEpEE51ZPjN
	 pkR/WL7OcS2e8uKmjbfS8GTFT2iO2s2Moh+lD37NtxnRizVT61YGPUjWg2nMfsSp60Vnu
	 Vg1SVpxR3F4aHTL4ahOjEaIeev2kEYtu9NZwSxSe4YJJFDueN5TiLJjMF1c24GO9+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r0zYc4cnCv2J3Iy4kEtuDQvccNYIff5xrHTWmszqY9o=;
	b=lqyCWdF6NIEdCkOPsmCt3Wvuakk3agSODq3vMIlzc4fbPdxh1m+Nrmi5RT4t5izAHCXW
	 2R9yfMX2Owlcos/LmSKipP7bYC7gQndF2BPX/6Y+gIrl2m4g2ovsStEIlLN/TSYYjy9Wi
	 8QuwDbc3aYqDYsFLqYmyxkINL58wjQIbmjC1iYUt3ZDvJIlZnU9SczfeNxv1bGUb/KrjK
	 1SAW1CA9IR+2/uc9qsg8pJwxpOMB7onT0qGGBTN03KNZ+m0kvWUCrkGoWVQ7ZJMwZpk9+
	 cDUFgZRMsKi1LRhhUpHRDsOtP6dRKKCDWKsIUJMO6nvvi/kD/CWYHAnBrcyghkIOlVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUtH2EiZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F89606A31C;
	Thu, 12 Nov 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUtH2EiZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E76A1F000C4;
	Thu, 12 Nov 2026 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510392;
	bh=r0zYc4cnCv2J3Iy4kEtuDQvccNYIff5xrHTWmszqY9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YUtH2EiZ7ul0IhwyzfFys+N/U7TRvLCD2fN5dTbux0dKUlM9z8NyGzTiU4ZfKuGZJ
	 Js161mWdV1PFM54WGuZ8VpCB5hemhfteLxTiZHCwK+J14BHf9d1/JXv5xy/rwvDhWo
	 cQRSdBKTpL+pYPYhokBy/d3xG228N28GJFuCbyT8ZTNFEodvBcEGO/mfePbH4z7h1q
	 mYJGvMPOK7NKBcSvVpcTxHwQizEB7XBskkoRqB7Uk4dpGh5XI3duzHornEtWOXk8Z+
	 e5ZsDzuHNdQmMDL9MjvYEHAbd6PI2MQg3WsdD5IdmbvxLLjAZQoSbAtGFQJXYY+d3A
	 f4ONQULQora4Q==
Date: Thu, 12 Nov 2026 11:06:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net 0/4] net: hns3: fix multiple bugs in reset/error
 paths
Message-ID: <20261112110631.2ec2d378@kernel.org>
In-Reply-To: <179440206352.2168702.1328392786936670574@kernel.org>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
	<179440206352.2168702.1328392786936670574@kernel.org>
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

On Wed, 11 Nov 2026 13:01:03 +0000 netdev-bot+sinfo@kernel.org wrote:
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

Please make sure you include the answers to these questions in the
cover letter if you repost
