Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A3411664;
	Mon, 20 Jul 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549684; cv=none; b=VE4bj2S3xJjtVYldzb14ttJxVeuraXbdQQX71ANXDVpRPRXp8H8nQfxXkWuerhHCbJinBEFGjiBrADSsqUXgI3Mm7UBxHM3vz5jECl0XkZ15rNNeJ0gIUEPEkGyD2cYiGGAw5J8ZWHxPNNgzcSubaaxnIeb6nuWDDgqBwfNCmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549684; c=relaxed/simple;
	bh=iLrle4giz8m4bOqg6ICmy58fjUXUpBDQ+cjJi+dvRxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udwPFyCM9O+8Molcq+DbwcnAbdrcj2/DAYEuE3CSYKb9VStp1oG7G5y0QYo5RcsrzjmhBMcwhlOkgAaeC6mQROOdhBLZujmrgT7/CqFc8cUtGUjjklm5UM0A+fvzwTnwxfvBZ7Tx3SimQl1EKM1gjALwoBC5+S9xHWL/JugUR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vG25X5Q6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vG25X5Q6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8CVhZNdyF22dbNibFclxDn2Vd7F+9/KtRj7HWP07lHQ=; b=vG25X5Q6VKWcG3SFC3rQ2+a2a2
	TNIL0H4wbRhjMUQ1IyWzC3mvf00w6KtX3F0A4WJRN8ylXQNhNXksGeE5qUNTNGrQDZc5gC2oLKE8a
	Qkk+CfaXGwAWKsA2t1dggmDkEJHGkS51fMkH9EmD39aVWrSY7dq03NnuNGmv5FK43aSbMSvqWNU3O
	OfeCXH0TygJU//DbrnF0UzZ/Mgx3Koy6jtQI43Yzyc2pRMvZOWvBXSQphU+4ku9k4nxnZPj38a+5z
	3aNsmtACBPXU8hYg4U/VX7iqmcFx4xVzMi5vOScnkH39mxT9q+l+fiskULYqAIHugffWtOzQSHSae
	Tr2ju3gA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlmtC-001Qaa-0d;
	Mon, 20 Jul 2026 12:14:30 +0000
Date: Mon, 20 Jul 2026 05:14:25 -0700
From: Breno Leitao <leitao@debian.org>
To: kr494167@gmail.com
Cc: ioana.ciornei@nxp.com, vladimir.oltean@nxp.com, vkoul@kernel.org, 
	neil.armstrong@linaro.org, netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: fsl-lynx-10g: propagate PCVT enable errors
Message-ID: <al4Q92DRsHIl_Lfr@gmail.com>
References: <20260720101906.80584-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720101906.80584-1-kr494167@gmail.com>
X-Debian-User: leitao

On Mon, Jul 20, 2026 at 03:49:06PM +0530, kr494167@gmail.com wrote:
> Propagate the error and leave the previous lane mode intact so the caller
> can handle the failed reconfiguration.

Do you need to undo these operations that were done to the lane earlier?

        lynx_10g_lane_change_proto_conf(lane, lane_mode);
        lynx_10g_lane_remap_pll(lane, lane_mode);

--breno
