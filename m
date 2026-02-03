Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBA1391;
	Tue,  3 Feb 2026 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077272; cv=none; b=LwjFtT037etkfBy4qZeDzk2inO0Q89CGBfp8emJrvJhIwc0zmlC3zuRl7cH9RncKxan5QDcwbVvajbFIhuvJXy1c3cghgqeR5V+L9EG914EZ5b5SyjwKIThodsDXHjVXFJGqgu1lajv3HGKxcudjOTFQAlwKreBch2suBr8m8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077272; c=relaxed/simple;
	bh=nXqk8d1z2oz+UoGCCuqxysoycNxPHubr8IUMz/ULFgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noUzz/qNKCHuA9vZ24kCPoc4lFxqPC3M5W4tmu3zlkzk8nJTEB7c2vn4lSAyKxtyq9IbpzwhfGcbSNhFcC9CssFZFp5GAlmF4BB6fsbkijr8WHhUYStcMyROl/wdSkL1mUA4e3gMj3IPQE1k614MdrcjrrrgXWRcTAQ8xWP3OH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBgtpe0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBgtpe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB0C116C6;
	Tue,  3 Feb 2026 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077271;
	bh=nXqk8d1z2oz+UoGCCuqxysoycNxPHubr8IUMz/ULFgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFBgtpe0XnEQfXrd+gJO5dWJ+hrMrwgxSojv3dFmcSPhw2KHVNTfbreEFbPU0Njjz
	 nvG5+uvdv0WldgD5IJAdtjVVeKUwgMq9tD5IsGga8IhdLZD1efoHIVSkmBKHMi3JaV
	 36SPMDYDfoIZPcCSxGfzgNzb0okwJ+gBvEzo+be2Gb2KH3tjywyAIOs6tIFpytw+0W
	 rODxjslQT1MRfqe+83fsY1kc4Q88KbziWsV7RzZIY+0DVy50/f5TAcViY8aSbBsaLi
	 WDE8GStBBWpLN4iRWevisau18U4ys9bf7ept/vH7KjD83kesN5hDfCyp1Yjm9ZRtfc
	 1pEw0azB8lGTw==
Date: Mon, 2 Feb 2026 16:07:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Yanteng Si
 <si.yanteng@linux.dev>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i
 to clk_csr_i
Message-ID: <20260202160749.454a7ffa@kernel.org>
In-Reply-To: <20260201023619.366505-1-chenhuacai@loongson.cn>
References: <20260201023619.366505-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Feb 2026 10:36:19 +0800 Huacai Chen wrote:
> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> so correct it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

The CC stable is unnecessary, please repost without it.
-- 
pw-bot: cr
