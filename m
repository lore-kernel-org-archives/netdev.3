Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064633342C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861680; cv=none; b=PI7X6HRVpkAUTqBMNDOQ8hNwu+NhldPW16KV3bfn1PXYaA2jQQlGpnyfzc6WK5Z2DoBRDef9mJU5jtA0JZ5eNhjiJZo/t2o+UUZ6b/jXIo4/LDRrjMmDCaDUd1L3i/9u474R+ZXGTqpu+SOEnYTdTNuI4cxqnSYoO+vCTpRwhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861680; c=relaxed/simple;
	bh=AlWIf+LaKAnUBfHhAuzpjF2RXFEUF/fCpySf9vJFU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3uqYlvBR0QLfIM1TAL18HMJTjD49a+f13DYpyEA8rlzxfCzo5GRTRNNa5oKkWZJfcciAUW4/54FuCoKVdGyVBVQdM6FaDACMaqAoTi5Gg5faUwWvq6Uf/m0V3aBkYMp9XrjY7MiAi89gZmcB2KAwBCgz+A/FtodTPbSiVcrjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy+0x16K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy+0x16K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8F91F000E9;
	Fri, 19 Jun 2026 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861679;
	bh=gRRwy50K4JnGdt30eWE2lTF1ai/8iZTtgfay12HVjsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xy+0x16KZlwG5haPppjzskvBUiSoLb5G9gkeIbPo6nFvNOReDSO7RgJHtDvinTwQI
	 2QZ1c3ZoA6RtJzRy8Xp/nJSX1Zz8vdigEGLBnD3wq+2er7mojMW1KpckFtkeK3JRy4
	 XJt6hXfhR1TwV0fn/hMECuAcPGBlnDwPy/DZa6+fDGPqfEiKcPsp3YV+k12UxyQvtB
	 39lrenqCbPtUrYMJsmgVM2awBAoCvevmfa2A7LRUMS8IADDyVx2FPOgqbsoTxAgc/C
	 4qZJVOuAedeFXR2SMv1ud6AjUhF7QuntFk3tGk1dgfac2/5rRxCTcAme8qyV/RdrRm
	 dLg3W+yI4MMKA==
Date: Fri, 19 Jun 2026 10:34:35 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: airoha: Fix off-by-one in
 airoha_tc_remove_htb_queue()
Message-ID: <20260619093435.GU827683@horms.kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
 <20260618-airoha-qos-fixes-v1-1-37192652157f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-airoha-qos-fixes-v1-1-37192652157f@kernel.org>

On Thu, Jun 18, 2026 at 08:00:29AM +0200, Lorenzo Bianconi wrote:
> airoha_tc_htb_alloc_leaf_queue() computes the HTB QoS channel index
> as opt->classid % AIROHA_NUM_QOS_CHANNELS and stores it in qos_sq_bmap.
> However, airoha_tc_remove_htb_queue() clears the HTB configuration
> using queue + 1 as the channel index, causing an off-by-one error.
> Use queue directly as the QoS channel index to match the allocation
> logic.
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

