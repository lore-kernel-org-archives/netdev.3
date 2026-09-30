Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB343C7DF;
	Wed, 30 Sep 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758189; cv=none; b=qrAZh/WAKZuVdW2/qhL1Djtv4TRL1qmmAHbz5AbiGXxaUB1ixYeHi+Bl3TKfuN3qjrtDMBEcYJ3iCOqclTPBN1MvFpx5S9gEcSL4z4jvT1asnCPNPSdmBtFPU3yIkWwNFD1MrEX3ARH6ySW54g3dmkzy0Kl+K7D8Gdgp8CaU2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758189; c=relaxed/simple;
	bh=WYP7JetXzosPTpQivXohzgWfi9AKUBQN6yUvyHrLU7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ0dPDB2pimfKAfsuCXtKXqWxuy0706/iRpCPQ6J9rniPuXGtJqTEs5ZkeegsbSp8QfT0GwU4NgdGJUBoilr3W/nZIr1gDSvF4OvrszIDGTU9ZCHZeP9u8+dshMXww7U4Z6soJ2L1aq8yL3v3rk7y08DgTQGCgMvVWEX02cQJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4szDhpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4szDhpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C0D1F000FF;
	Wed, 30 Sep 2026 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790758188;
	bh=FmNn5Xvock/3VZ/k07jBRCEfS09WM6dksfYZtNA0GME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T4szDhpqW2IyY3aed64r0YME9X4Wl/YfcbIhpPtkd0Llku5EgNoKmCsHe5l9EZf03
	 Z4hNgoTxKS6khyREF0OgFrP6EcBgfn/F6YWM9hel8r9vvwL/mntzr2HjcpIlcZP7sl
	 XPkli+OeVuDowNnOs0DYEEvpJ9guXJBWVarTq5R1GJkKn9fFIrI8nzlg5E7fMcCKaT
	 kfFv4+9oM2yyFnISq9YFnmAbODpF4VABCjkmER99fKxTE9z1CCSWVImBxzAybQ+jSU
	 zC7h7pCFND1srocero8v1/vQzuUIe7yEoAk/Wc4xqZ2leGoIIHU6aQtV+33cxK4hlf
	 tdrLOt1tJkcfQ==
Date: Wed, 30 Sep 2026 11:49:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Tal Gilboa <talgi@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] lib/dim: fix 32-bit overflow in dim_calc_stats()
 rates
Message-ID: <20260930084943.GB3401365@unreal>
References: <20260927051743.71460-1-jain.sm@gmail.com>
 <20260927051743.71460-2-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927051743.71460-2-jain.sm@gmail.com>

On Sun, Sep 27, 2026 at 10:47:42AM +0530, Shashank Mohan Jain wrote:
> dim_calc_stats() computes the per-millisecond rates as
> 
> 	DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us)
> 
> where nbytes is a u32 and USEC_PER_MSEC is 1000L. On 64-bit the product
> is done in 64-bit long arithmetic, but on 32-bit architectures long is
> 32 bits wide and the product wraps as soon as a measurement window
> carries more than 4294967 bytes (about 4.3 MB). The same applies to the
> packet and completion counts, although those need more than 4.29
> million packets or completions per window.
> 
> A DIM window spans DIM_NEVENTS (64) events. Drivers count events per
> interrupt or per NAPI poll, so under sustained load a window can easily
> carry more than 4.3 MB: 64 full NAPI polls of 64 MTU-sized frames are
> already 6.2 MB, and drivers such as mtk_eth_soc count one event per
> interrupt while NAPI keeps polling with the interrupt masked. On 32-bit
> users of the library (for example mtk_eth_soc on MT7621, bcmgenet and
> bcmsysport on 32-bit ARM, or virtio_net in a 32-bit guest) bpms then
> becomes the product modulo 2^32 divided by the window length, and
> net_dim_stats_compare() makes its BETTER/WORSE decisions on a value
> that has little to do with the real throughput.
> 
> For example, a 1 Gbit/s link at line rate that moves 5 MB in a 40 ms
> window gives bpms = 125000 on 64-bit but 17626 on 32-bit, and 5 million
> packets in 2 s gives ppms = 353 instead of 2500.
> 
> Widen the products to 64 bits and divide with DIV_ROUND_UP_ULL(). The
> results are unchanged on 64-bit.

How does this 32-bit overflow differ from the overflow that can also occur on
64-bit systems in `nbytes * USEC_PER_MSEC`?

Thanks
