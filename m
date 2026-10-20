Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525015;
	b=UhlDvFGX1Vlt+FJADgh1ouhUPBclE48V0yB20vmwOnzZO5hos4LrEQY451bXeoOBQ1Qc
	 UKU2m4/OruXm3vVvR5uotGOmQWbOuHtkjL1uSydMmqQwFeDh774t+yYu9mZxjmBo9IaEB
	 NYByqTXbk8yvj3PdBWxhc0fqqLM4JUCf6gl5hpwwPn/Ei2B3zXo5FQEKXyREqAuQ2tMeX
	 xQTx1BLbK1CnBkJbV8K7Afl9w/eoFR+HK2gnfZBX6EmZ0CCbF3rT6w3JLCWTY+iWO/gsO
	 2ok9SxMFIKGZ1y58aN/XwUTJOawV+3zYJNnAzhrhsierdjKweVzzSle+i5rnKv+nJGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525015;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lPnR7EZacCq+16srpHCYbTDuFmgzkYwINPXD6oXzm4c=;
	b=iRWrAEVD3gfIESDK7yjBNaTVQJyh7NsoCQFM/G7rPthjfR9Gv74fiGjBisdGAQ2C/Ghu
	 SCQIoxRDjyJWHsocBIu8ZgfWSrl5JhfKQmI2QlLOi8JQXAl1vH3oY3oaE2w5V+8yG6pTe
	 hPFc8XOaTAOeZz8Xq6R1lXtLeEX3A+RGOIOV7dKOISl1Ie7ij0xCP7UYs7LugF9rj6b/3
	 OEpjjunOuInuRm0OZ0zM0wxvT8/ZWIFsqMpreyhdOLep8g8SPmNNCOqzrjwZ3HR/t2Ml9
	 rX/5bI8srXOyK3ei2WWecpTHNNbMkUXf2uVoV1Rva24+bFiyX9vPlqcw6p6d5rCKSxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bXmIXeK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA5606A319;
	Tue, 20 Oct 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXmIXeK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE11F000C9;
	Tue, 20 Oct 2026 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525015;
	bh=lPnR7EZacCq+16srpHCYbTDuFmgzkYwINPXD6oXzm4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bXmIXeK/BKYoEmzdgUSOrWlxaGfHG9OpLT8T5IWtQ21YhpB7rbsgLnU8X/5hwsJGG
	 My5wAx0lGmM9GDzz3cIJigwvgfvWveRjd1GWCHvtuYA3q59i9o/5ZcfO+g6Yvdi94Z
	 hLp5LWv0z03hScgmubpzhX5sh9Q+eIMxX/+cZ7EmLF91sZmdbYHrvc2gKcxTkurJFq
	 aDXPvc3PDR+m2N46fChsxR5gF2RVXCnPslggjIHYeLbc1Agdcn3QEQmUbsPaHlCt1T
	 oe96gDFgCCji7yVe+pZhGFJiZRYoWu7hq2siRNyOWo6w1OzeTzStMYHQzHoQOqYG3J
	 pLFkMXLWVapow==
Date: Tue, 20 Oct 2026 12:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Binbin Deng <18983559317@163.com>
Cc: sukhdeeps@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: atlantic: Unregister before clearing RXNFC
 rules
Message-ID: <20261020123654.19d56ef3@kernel.org>
In-Reply-To: <20261020022630.515209-1-18983559317@163.com>
References: <20261020022630.515209-1-18983559317@163.com>
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

On Tue, 20 Oct 2026 10:26:30 +0800 Binbin Deng wrote:
> From: Binbin Deng <18983559317@163.com>

Please slow down, you're clearly sending untested LLM output.
We don't want to see more than 8 outstanding networking patches
at any given time from you.
