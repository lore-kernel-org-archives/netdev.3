Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78D2D592D;
	Mon, 29 Jun 2026 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773916; cv=none; b=t8TTDuFXcHu+IeOc188+AxwpxWmjigthXh5ByblAoDhlRGZRmTl0g5XgWpmX3H2VBvWIVAYoMpgWAypQ8SLGww8PEEUN2EwPCRCrf06Pa0YlgIX8+2KZkrMm87VYbIpnXbxwbPvgPqBLSxsbI/TsV/Ck1q7StugKqtyz5aUubYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773916; c=relaxed/simple;
	bh=yGx7DxEbSCphS2M85ec3eu2QAKixfHHq9oDNjGgdaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie3nPBDzXjxAk0iTa2g1UK6JgrDsUHTKdGaNokICUCjGQbz5F8DVpcvyNVby6iLdXxk6HnTFfreyLUd7/7hM3xIJ5m1ACTsy70Ujc7NCsjlqZyYfDGxjkxrcma0T5R6sfNEOGOFPgKEdFXV/jum+HkZgBky5cXhdCEsDMxe5gCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcPR6Qxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcPR6Qxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812291F000E9;
	Mon, 29 Jun 2026 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773915;
	bh=naNO0cLize797Ryer+m+V3y1tGWzRhZX9KSloLSx1cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kcPR6QxpY9bp9p88FsoIaS5/m9QP9+eJYq6ZbyHWg62CgsR6Ixw3UYBtOpXMEaWrb
	 4GF88HyuZKavAKvEFg94viT6SALg0jhCoEOxDMGPIxIFlmCjFeyh/q8VA0+SprXEcq
	 oHOSxF8j63jCuE/cPcsZXyM5uvWGPvj5+nypZa4vpUk2AL/IJrS6CA2A7t5ZnB4+qJ
	 Xm2Vu7c6/LiwBEvtQ83nD1U22tToIbUtmZsbwtW8PZdJB2q/8Mxk9VWMn+pvSux3sa
	 x4O3nwGfiSE6oOSwmkpv7jYQy+Bx01HgajrRwpHaAyaA8h5f/McroX+TQ2N6JegK9H
	 k26HpTEERJztg==
Date: Mon, 29 Jun 2026 15:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, horms
 <horms@kernel.org>, sashal <sashal@kernel.org>, bigeasy
 <bigeasy@linutronix.de>, netdev <netdev@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, "jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: Re: [RFC PATCH net-next] netpoll: hold RCU while walking napi_list
Message-ID: <20260629155833.1b1c2c26@kernel.org>
In-Reply-To: <akJSi1g0F2k9a3cs@gmail.com>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
	<20260627142105.29f1322c@kernel.org>
	<AFEAtADoKs22QyipHhKwe4op.3.1782623057057.Hmail.220255722@seu.edu.cn>
	<akJSi1g0F2k9a3cs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 04:17:10 -0700 Breno Leitao wrote:
> > Sure, sorry for not including it in the RFC.  The warning was from the
> > reviewed reproducer used for the CONFIG_PROVE_RCU_LIST triage, not from
> > a production crash.  The relevant part of the dmesg is:  
> 
> Reading it, it does not come from the kernel's netpoll code at
> all -- it comes from an out-of-tree module (!?)

Yes, like Breno says, we need an in-kernel path that can trigger the
issue. Out-of-tree reproducers can be useful to validate the fix, but
they are not useful to prove that a problem actually exists.

We try to avoid defensive programming in the kernel.
