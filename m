Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035E41F349;
	Tue, 11 Aug 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440978; cv=none; b=WH+2BhItONCfBqCYXwZ48tfAUtcSenZ5IQH+lpxqEJ2UFVSUzCb32moOHWCTGp/jNK8AY15TwnvSSg01J/6830mbAUi+nZkrFtSZcn90hTIitM69mU8qPyBsm73dySLCraNF79O2ERkQJfgrs40nvWM+yE+o/AUcGu3DDFKyBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440978; c=relaxed/simple;
	bh=rNECVYttPJXRkLDQTwvzgFZfTa6shAnpcGNPWE5RGKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYF1PIWBi/wlRAJAQXmPPogtuGLN0p0Tm5ln0GanDBhomBCnLBvtHb8rMiuObO31sWvtP6p6wkXzKbkVfJBOn46oEuS6Zfr5Rk4j8HKJ082mPEOeyppZS3vavoDD2VapcqBFl4KA2nfxGI67xuMmTazndVl/tjnpy5F2GpeJw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhcEyBLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhcEyBLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737111F000E9;
	Tue, 11 Aug 2026 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440976;
	bh=HZT+zjBaG4GNDVXxnzBjYWXgumXbZ+jUWdPESO0+yzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WhcEyBLAbbmW83UWvq0DuzIvVVR6dfBbhnRk93T+dGBc/gY1Fk7EQDMjm2He+3S63
	 I7y9VHldf8lIlIV5LpCl1iAaatcj1/niZAYpQqC0qYNVtMnTVL9x9DZg40h+XxNz8L
	 nsUNYTqWSB6qs8/Q1LXXhm4maQML85ylmetOeUj3NSWtQnPkZ59Iy0kcdC2o3Yma1q
	 wpSescVfFIgkGnS1PjPPv/8l4zjvC7MAliG5qIvhwASS/yc11Mn8mYVeT49nIXkNRt
	 salMWQeyjOTHsL92+pixX6BecFQe5q+8OIN1tfI5WqpsWFxZhFSbbk5fKAcQJ8nqD7
	 tKnCaWnagzhSA==
Date: Tue, 11 Aug 2026 10:36:11 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Teng Peisen <tengpeisen@huawei.com>, Wu Di <wudi234@huawei.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Chen Anwen <chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>,
	Zhang Min <zhangmin548@huawei.com>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>
Subject: Re: [PATCH net] hinic3: Fix SKB linearization mismatch and silent TX
 drops
Message-ID: <20260811093611.GA51943@horms.kernel.org>
References: <f742377e33f33541420c0ba741925180517b3a9f.1786091276.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f742377e33f33541420c0ba741925180517b3a9f.1786091276.git.tengpeisen@huawei.com>

On Mon, Aug 10, 2026 at 08:57:32AM +0800, Fan Gong wrote:
> Previously, hinic3_send_one_skb() cached the SKB fragment count before
> calling hinic3_tx_offload(). If hinic3_tx_csum() falls back to
> skb_checksum_help() for unsupported tunnel packets, the SKB may be
> linearized. Continuing to build the TX descriptor with the stale
> fragment count leads to a descriptor mismatch, which can trigge
> out-of-bounds DMA reads or IOMMU faults.
> 
> Furthermore, the old code ignored the return value of skb_checksum_help(),
> transmitting corrupted packets with incomplete checksums upon failure. It
> also failed to increment drop statistics across various TX error paths,
> causing packets to be dropped silently without notifying the user.
> 
> Fix this by:
> 1. Moving the hinic3_tx_offload() call before calculating 'num_sge' to
>    ensure the correct fragment count is used if the SKB is linearized.
> 2. Propagating skb_checksum_help() errors and returning
>    HINIC3_TX_OFFLOAD_INVALID to properly drop the skb.
> 3. Adding missing statistics increments (dropped, map_frag_err,
>    unknown_tunnel_pkt, skb_pad_err) across the TX error paths so these
>    events are correctly reflected in interface statistics.

Did part 3 go missing?
I'm not seeing it in the patch.

> 
> Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

Also, this seems to be v3 of this patch.
For reference, that should be noted in the subject like this:

Subject: [PATCH v3 net] ...
