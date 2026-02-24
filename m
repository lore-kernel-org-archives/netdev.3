Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EC1E5207;
	Tue, 24 Feb 2026 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901285; cv=none; b=W+GG/5Q556EojOlri62pAULJEj3esUjBD97hs60pLxrHERELEz0O0zqSUR3yV+DNjERWXTSkOwfYKDURST2DGzDsE5xZt3eXDA3ax4AtrC1GleoUqBX5QQjhddxMvdmT01flZTv1p0uBCxb2cJdNMOI1JVntTZkDr2mwd5bvIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901285; c=relaxed/simple;
	bh=14DTH9tX0vpkl6WnEHlzRd/AhE+cZ+QAOtYqoOECUZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvAfZ0uB/4MQFE1Bz8uMAPpA2B5Ljj26TGRBzocodbghSMV62efam9l8nDp8tOtrivV/+FpSp3jCJSGJa8TVPlcl7ZV/NawfMEIUVUOCVapMQGcYzR3l7OCKHAxNKDPBQBwyuODE/jb9EoXTWxqB4zqWE4dkXidWNoOl2zYoqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQHcF8N/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQHcF8N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFEFC116C6;
	Tue, 24 Feb 2026 02:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771901285;
	bh=14DTH9tX0vpkl6WnEHlzRd/AhE+cZ+QAOtYqoOECUZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQHcF8N/eNsQi1Nf1R+LGBSo1FaRXKrKZeZKewdNQSjmA92wsPqWaR3vdMi8q11p0
	 FkAgsGkYMohWNuPPQnJrakNXgiJXGCVYjl6r+ysY0B3aEsGdZ0MvnUCTyZ7RpmrPeo
	 kHgOy/xDFIvf5f+9Lpb4g6vWZwQNcFrboT/quMnQBxRYhAlg9bQ6+yRgjfoLymP4AP
	 lH/MVVQMo6geJBEtJaUx52VeZZyKGrfmQMxDE0MUZTl+LhabPA9+8Ht5QhI8+b8UC2
	 KgVJviIyzyLhKpD/919XBkWYIQ4BzljjPqp7/O8JDPOFLfAQQV93aNdnrPYyFXwN98
	 D//8iH5Yxb0Zg==
Date: Mon, 23 Feb 2026 18:48:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
 <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
 <vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
 <vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
 <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw-nuss: set
 irq_disabled after disabling RX IRQ
Message-ID: <20260223184803.739c17a7@kernel.org>
In-Reply-To: <20260220041431.372610-2-s-vadapalli@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-2-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 09:41:57 +0530 Siddharth Vadapalli wrote:
> The 'irq_disabled' variable indicates the current state of the RX IRQ and
> is used by the RX NAPI handler to determine whether the IRQ should be
> enabled.
> 
> Currently, 'irq_disabled' is set before actually disabling the IRQ by
> invoking disable_irq_nosync(). In an SMP environment, this leads to a race
> condition wherein the processor taking the interrupt sets 'irq_disabled'
> while another processor executing a previous instance of the RX NAPI
> handler sees 'irq_disabled' set and invokes enable_irq() before the RX IRQ
> is actually disabled by disable_irq_nosync(). This results in the following
> warning:
> 	Unbalanced enable for IRQ ...
> 
> Fix this by disabling the RX IRQ using disable_irq_nosync() before setting
> 'irq_disabled'.

I'm not sure this is enough. The IRQ enable/disable serves as barriers
so the ordering is sane. I think the problem is that there are multiple
paths for Rx which may schedule NAPI, not just the path from the IRQ
handler. If the state changes have to be atomic you need a lock.
