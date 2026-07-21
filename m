Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A434F270;
	Tue, 21 Jul 2026 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594513; cv=none; b=cGL7bAzscS7zdWx281PsDX0usBlMEhdWeORR2DQxcMpqgqx2yYBnEULP/hXIHC+OntJ3oHo6bM9zpa9Wjr5hF3O08UWkEnX6dY+A5TOIB80CfxdxcNKS+BdeZ4FI4MLCOHE7QAKHqDU4/cPZ8/ZOcKaa5zZSUzqTBGMideWu4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594513; c=relaxed/simple;
	bh=MGfDe071gs3SSZKt518ll+2Nn4xbrhWLj7pXiyD4fQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1myna0qn/mqGrtBO8prTLm8VaQ9QUA+FnLzrOw8IgS6frTOHasn2SK3JIg6jHT4wQgSzjU8qPiceA46NSx/QJi4HfJlHmbJG2CerIEqYgTRtAMXHjsXRg4grMao1PzZ1wsEvo9loCa2rK6O/HT1hUFF7a1759SFXJ57NBYrQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLixyaUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLixyaUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9A1F000E9;
	Tue, 21 Jul 2026 00:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594512;
	bh=MGfDe071gs3SSZKt518ll+2Nn4xbrhWLj7pXiyD4fQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jLixyaUA3WhIg7XE9Ft3BL7mTz6+rYXliV33IV8gSIZnn5bCUAZgwqACmeP5EsBGP
	 uHo/BoHqMAIPnSNmTme8FTaO4OzICvvmTc/+iY8CBfsf061r92bG1RTkWwBkJnNIBw
	 gCSEXhyknew26utLISmSvK8LsE6a3eTQlrA3vXZqniv4K7EEg3D8IwK8liBMGT4S8w
	 aES4eFZb191fRT/pSrVZLYQhSx2r4iyUSWsF9BD/s6eM/aaG/CyQ+zJt1fOz+xWr0d
	 LVKDvaH4d1PgSQDwOO4elw9/9B9GTSBfzQDigdaOhVV/VU0jI4mnSjhpZ/WIbWE/KS
	 wwAeD0NnmyHGQ==
Date: Mon, 20 Jul 2026 17:41:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bryan.whitehead@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 0/2] net: lan743x: add RMII support for
 PCI11x1x
Message-ID: <20260720174151.3adeb8ae@kernel.org>
In-Reply-To: <20260706093150.9033-1-thangaraj.s@microchip.com>
References: <20260706093150.9033-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 15:01:48 +0530 Thangaraj Samynathan wrote:
> This series adds RMII interface support for the Microchip PCI11x1x
> Ethernet controller.

The netdev patch queue has overflown.
If these patches are still relevant you'll have to repost them.
