Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2664A3D56;
	Tue,  8 Sep 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857323; cv=none; b=aznf9SprkyyYMgbTAzNdImyOtw/08irLBehXlrZl64wj3CEjAig+IG/jvkHd2ATpVSHKwa4iPrZ6b5LMIozz4e39IwJzXxJ4xITdBp0nLaF7oClancKOPDmtYeBykMOs0RMcV9GXuyjlF6zWUohEsbYhejihZPy3pwGc2BVcA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857323; c=relaxed/simple;
	bh=bYvP2DxiLXlKNYl9ERUm3FHiwvNriV3KEBqCigB3NCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQGsWhevu5C8dJTdr5idZizfTGrgN1myD5PHiW+nGPj8Oj1a+0yOV8VZ22uMfMDCPSvX+BWbo2nXxBaWUPjIcMa28Ex6JxsUfL7mey3XG0IykmgQFvuRxYyYu37k2gF9E+Jk7tblwrDiNYnHEQBbiIWCMoiRifNLrnvhp5G2KaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmhLukiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmhLukiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E511F00A3A;
	Tue,  8 Sep 2026 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857311;
	bh=N9IoDXuvD4+ASEVIuJznIT1sajD8w/vtQTCZkAyayLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BmhLukiKsZ17x+IkcGiL7jonMokaj+iWtsDhS790ZhFFqzgzazGEDXuQd6lFcdtj2
	 NFJDUAnhrKc7Ddlo+vZYilbJxq2ExdvPS1iVUIDfb1L3bOIX8c12FCFaPiorZMc92l
	 S3KQzGrpCRlXC2uO+BEWolnInsbR/Rhzlpz3xdmh4GaQOIcVUuFQSMAf9jggoQ747j
	 vPRiCwhDWV5o02EMvWcqjqYT5pi9THCEzeWrCVIenuU28iKQ18fSwEnzvg2h/p/qVE
	 33PPQnetI5nrUIQflZBllFcudYq9BZOVE+NGD6SFS5DiIjqMmZmAoYqZpzDUfYVrd/
	 An3m6elyCyBXg==
Date: Tue, 8 Sep 2026 09:48:26 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] net: xilinx: axienet: Propagate errors
 from optional IRQ lookup
Message-ID: <20260908084826.GL40544@horms.kernel.org>
References: <20260903073252.339250-1-phucduc.bui@gmail.com>
 <20260903073252.339250-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903073252.339250-2-phucduc.bui@gmail.com>

On Thu, Sep 03, 2026 at 02:32:50PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available, while other errors should be propagated.
> 
> Propagate all error codes returned by platform_get_irq_optional() other
> than -ENXIO.
> 
> Another call to platform_get_irq_optional() in the same function already
> handles the return value this way. Apply the same error handling to this
> call site for consistency.
> 
> Fixes: d6349e3e14c7 ("net: axienet: Mark eth_irq as optional")
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

