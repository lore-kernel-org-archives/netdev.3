Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D11714AA
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249805; cv=none; b=PrG1Su9JFTaVhvXG3qAqfKKGjubopPiRZKorACMaN5sz+fMittvzhLb5rvfUY7wAiuFbzl66yZtbgK/rpK0XRnSBHfJGEQ5yZYVBLRo3u00q/p/BtANAaZJMnZzLiAxTkrwC+y5cfMHj193kbUoWEE3f/H8R7GUEGLm/YMTvVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249805; c=relaxed/simple;
	bh=KgijyQh21u9LJt68yItmbs4m0KNmkUNEPw4VnCwhVec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3Yum1qkoIBEJUE4CuMYZFdKR2nmoKvIQYcWWSVEmTmAK0CqqL2s0MozfF1Vc8G5ltnL9Vb9oxguW+EoB12U8S8gyx6NFiMXcXggVVeVCv+nohZ7tY9nMAPNG3+53yk4y6j0fM29KKcNla7h4Nveoj9Gi4CUpaWrfzxHRBTq2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7cQN5Xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7cQN5Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550CC1F000FF;
	Tue,  6 Oct 2026 01:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249803;
	bh=XbmYD6AEzHl6UKm4PAxVqxoifbq6y4Fx2sPcU3YCLCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k7cQN5XaFdejoQjuj15puthbzoZGOTJS3PJ7tVC89282CVn+JSiGc/q41UbEmmbsD
	 hMXH2n8kx19CehVYfzGH05TORcjuhTtVDPZHsPyf4Gty/HSiJ5CJTQO7FNA4i9Hlhi
	 4FZ+CUjr0AqzHEeoNq2P8FzqaPc7tn0CnFwhi0AfoY8j9+T847zQJjqtQZcKZq33km
	 n791SFCuyY0PHwMj1fL2J4bQnZI68iUAX7W6MQ6IAz0/0sRT/OW2q0py1kzWdS8Agu
	 OUsJiRO+ajO8xzcepLYQBhlw0qTX6ybNz+TjqqSWU5IeUEvvCCB2Ljwbqqy6RvHQij
	 tbJNhsh5eq0KQ==
Date: Mon, 5 Oct 2026 18:23:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Drew Fustini <fustini@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system
 time programming errors
Message-ID: <20261005182322.2bc023e8@kernel.org>
In-Reply-To: <asQcQIh56MV1OJur@lore-desk>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
	<dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
	<asQcQIh56MV1OJur@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 23:53:04 +0200 Lorenzo Bianconi wrote:
> based on the reported error, stmmac_init_tstamp_counter() fails with
> -ETIMEDOUT. In particular this can occurs if:
> 
> stmmac_init_tstamp_counter()
>  -> stmmac_update_subsecond_increment() -> stmmac_config_addend() -> -ETIMEDOUT
>  -> stmmac_init_systime() -> -ETIMEDOUT  
> 
> I guess we should understand which one is failing and why it is failing.

I'm going to revert, this shouldn't have been applied to net in 
the first place. Let's continue the investigation but v4 should
be tagged with net-next.
