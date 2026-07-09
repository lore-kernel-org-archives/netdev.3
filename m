Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0787402BA6
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613682; cv=none; b=kPRUGCD3SDPRs76sivi7lbQKk3ZzunrjHdmxSjgJUlip4fOHBCF2NI0AcMXTu3O8s4BzO3vgNMImoTvuH5iUjGmQZY+CaVfQL7QqQ+EeGwSE1RgPrdGpwOFiU6gWhTgCE5wBLMJ3l0w1ar1rQF2EsH703nAILs1WydwX4QmoRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613682; c=relaxed/simple;
	bh=2n6audIKA2AGay4M1uHLGIi1NvVXcPyrqpcF/JOTS6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIyQam1xfRITEdWlPr9H0JLD8CS5YGapi8vHTMFAfWoQPJCA7+0VBzkRrKOhSFHBYpuv3PoEzobV3tT2Tbeay/vgELPu3qhDrOIyZNISTdfnMDDR+YKyJg1HBDH6G86Y3gar7Cmr6eo3UhKq13xR/0NBcLX0Fq9gl9Tq42ML6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J46x5i9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J46x5i9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A7F1F000E9;
	Thu,  9 Jul 2026 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613679;
	bh=k064ZvMun284uDaXZd4Db14gBsND1gm4KYQ67hv9h88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J46x5i9RvK2/EnDTyF1VX/OcvrhzbiVnrFH274TGikFB3gfR2FzdAeou/x0Cy7gtR
	 LY3vL7tAIYDRP2oFB7CSpkr1QO1562a6nsiOEGHGpYkA35/xmzbI3ITMadaczaDaWN
	 EL/Z7L8GpMRmv2OXJ7T7h0BO014EijAV6iQaegtltUopWVT1MM881d0KCLs1U8hVww
	 MHUuQ4/ifUYl1ig8iAVOtBYT2zdICzI1cPjRJwT7c3gaAxJ+sFHXOmANwQSvAtYhn4
	 Hv0QtKbVFTq7w2FY27YoXst7BrjThs5rnIf7Q10rdbmxbn9ATEBRXb9krMairuIQCv
	 iIina1BbBhyeg==
Date: Thu, 9 Jul 2026 17:14:35 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
Message-ID: <20260709161435.GR1364329@horms.kernel.org>
References: <20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org>
 <20260703-airoha-ethtool-priv_flags-v8-2-015ba5ac89ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-airoha-ethtool-priv_flags-v8-2-015ba5ac89ee@kernel.org>

On Fri, Jul 03, 2026 at 11:19:26AM +0200, Lorenzo Bianconi wrote:
> airoha_qdma_get_tx_ets_stats() has two bugs:
> - The hardware counters read via airoha_qdma_rr() are 32-bit values
>   but are stored in u64 locals and subtracted from u64 baselines. When
>   a 32-bit hardware counter wraps around, the subtraction produces a
>   large underflow value passed to _bstats_update().
> - The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
>   single per-device fields, but airoha_qdma_get_tx_ets_stats() is
>   called with different channel values (0-3). Each call reads a
>   different channel's hardware counter but overwrites the same
>   baseline, corrupting the delta computation for other channels.
> 
> Fix both by:
> - Narrowing the counter locals and baselines to u32 so that 32-bit
>   unsigned subtraction handles wrap-around naturally.
> - Grouping the baselines into a per-channel qos_stats array so each
>   channel tracks its own previous counter value independently.
> - Splitting the delta addition into two statements so the first u32
>   delta is widened to u64 on assignment and the second is added in
>   u64 arithmetic, preventing overflow when both deltas are large.
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

