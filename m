Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324134BA42;
	Wed, 22 Jul 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728051; cv=none; b=HjkXRnAnSOlxhr+PFiApOvu2PdyRj0dLmEOfmkoo3FqVoNg9Y7mOi9pi2/VZlB3oFt/ponixQOVf+zroFdlGWiFOq9SX8yvXtuIGmJdEaNhTVBUe2GyRRRvKrDMIc8Wy2H04SzfkXhwczLbxQSX6Ez5VPJKN4skf8Zlp5VwyDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728051; c=relaxed/simple;
	bh=nhMwPVQ3SL1P5B8amaj7l33JPXgnPVwSFdWGx/UXRcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbL3UERVhu3PD4Q4fx1HdWYXhH/jiu7wWjN45/QUBjs+8pt4wrfvWZlEiwpG3T4IOYvvsK6B5iRPI0U7Xh/gCbMLm4BA3rAd03cAsOaLBvxaEyULBrJO1kh88oSt0Olswkk+Sp4pjrz/E8Sjd7FWh2WVlVBVcwSPU7JTtWKSGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1enyVVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1enyVVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6351F000E9;
	Wed, 22 Jul 2026 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728049;
	bh=49qvcRRZ626N6zGK98Gh4i1hyq7SNREm2hjYO0qsT7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d1enyVVZAyfBxRjkxnaGDkkV9vzFN8CTZETH65n9sNHF+hLFCih0VgjpkhJqILCY7
	 /XQsGMznPwO2thFQSs5xRSWqdO5e10rVOTBqXQ0T6YWFukhuwf94mIj+1iK98eR3Al
	 t/P2hvLTvqGln1NwaX3LBkqEig1UnVOKzTs5RtGGEnN9hi4sxo9s0+OMmWunThb1du
	 fOmeCM2N63pjtJdaQ2FMXNZHJQFgFlygDAlksEoWcEvOWHZwMMEArnGmEDo2dvwaIB
	 vfY7DOZDuCBgVmg16tiMQbrndMl9rlgmh6TSLHNu2dyNGI8vnrY0tvTO/HIQKqTM8U
	 nmV7xsTD9fbxw==
Date: Wed, 22 Jul 2026 14:47:25 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sbhatta@marvell.com, sgoutham@marvell.com,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net] octeontx2-vf: set TC flower flag on MCAM entry
 allocation
Message-ID: <20260722134725.GC418547@horms.kernel.org>
References: <20260715052007.2099851-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715052007.2099851-1-rkannoth@marvell.com>

On Wed, Jul 15, 2026 at 10:50:07AM +0530, Ratheesh Kannoth wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> When MCAM entries are allocated for a VF netdev via the devlink
> mcam_count parameter, only OTX2_FLAG_NTUPLE_SUPPORT was set. That
> enabled ethtool ntuple filters but not tc flower offload. Also set
> OTX2_FLAG_TC_FLOWER_SUPPORT when entries are successfully allocated.
> 
> Fixes: 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>
