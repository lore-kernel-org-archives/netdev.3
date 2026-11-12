Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505027;
	b=gEEbto06BNqIhLs2d1ZulwtOMHkhj2Cj+ah3gk9rQkBuBSC2yfZqnDrQDQP+Gvy7hwsy
	 bVgRZ4r9mbKF3lTlyKlOSti2HmR6UkTG7p1Be408HF37UGRGWv5ehWo4RwPXrrRJEMLbd
	 U0s3XN40j9MZS3rWUlLFPu6jAcW0X4T11CXVNod0OFC7iPNHQemuj1gf4R8Y0YgTHT/Ed
	 eigJAX88jvDjIbyoOgsOXZOJ94xIfLM/0jnrh6Uyf+4HdEbOM4LvqZWxW2rtVbH7FNtVL
	 JSXpaF7NR/JBbNGw/jW7lILcNHhN+2L/IlSJIz4bZr9dR1GwosfiMFFRksZqLeqy11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505027;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pZyA3EpLAz0HwtOG8dc+2ffMftVNufhrgpMkSG6Hj+k=;
	b=f+tZ/eChVDfSAuBzlXKeA1Y/BNDo3AvGZiBZ/K28bxGIlEyjSykV518OB88w9kpYQO8W
	 aFSY+nPbDigJERNGtFnppJOS08Fqq75SgczzxiYIWoDKZwGI1pYx+t1jprRrXO+caQ/oe
	 v0DK6NEhoFW9MbFrtpgU4dM6qU0VNf2xzMTP3ZczYRGGPqyEjznwUqLUMGJKTN0o/YOoO
	 u9BYGshxSqESmArIhhI4LgWeFDyvTl/gXz+TumDs2T7jKZ5+LYdL17Bu0HQ8OkOJJG6+6
	 k0vnbZ1Augk5gbrR08FhBrdgaFW8PYnGS3vYDQH7lLZkhkbHdC05vJfJc/1tiKgcrOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mZK4sQ/V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7D606A215;
	Thu, 12 Nov 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZK4sQ/V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1D71F000CA;
	Thu, 12 Nov 2026 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505027;
	bh=pZyA3EpLAz0HwtOG8dc+2ffMftVNufhrgpMkSG6Hj+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mZK4sQ/V61IBTdDb/xUTCzQeB8Ui+G8oORNL0r//144FNjWK3EMCM/Gfnt0KhgZr7
	 mP912F0KK44EoxEL9WS+cG9JUxy87cF5EMWYmYfo4jJBTMtxard1iTBFyAF0a16ZBd
	 2l1QVVb6zj5xSERDw9/g1cXjUxgsBynF25Fyqnq7T8jkjaicCd66yP7S32oq9k+rQD
	 sJZxX84VsJJtArLnhyVkeNn9d/auOrnsnvOQGSzL/a3JmX0rIAfOjNEj3Hbuyh6n0c
	 GoTaBS4geV+PxRVOSF85VHrgmcjx/h5k/ZVGk4Rhg9OOUR4iZ2js5xsLTJUXkI99nH
	 NnUlxmeGCSZYg==
Date: Thu, 12 Nov 2026 09:37:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, haokexin@gmail.com,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in
 prueth_probe()
Message-ID: <20261112093706.55e00f17@kernel.org>
In-Reply-To: <20261110150500.3142-laixiangwu@cmss.chinamobile.com>
References: <179429318364.488859.2256720144223130993@kernel.org>
	<20261110150500.3142-laixiangwu@cmss.chinamobile.com>
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

On Tue, 10 Nov 2026 15:31:38 +0800 Xiangwu Lai wrote:
> The same information was provided for the v1 postings of
> patches 1 and 2 here:

If only you read the message the bot sent you would would know that
you're supposed to add this to the cover letter when respinning.
