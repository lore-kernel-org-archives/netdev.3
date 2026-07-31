Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822C2D9EED;
	Fri, 31 Jul 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460394; cv=none; b=QUXszDWKiwOPC2frUlX1joJAdhbjNANc6tWITxQ3ZmwjRwutmwaJLrhTlK0SEgCMwt2Ro1oI/q6ahbnl8Jc3iNWlidvq8cGC6FYViyr0L/uHoYNWTpEOhItwHEVxFiulNzESp+pCWb+dV5M9Pn0qlaXFWxJbayXdvzcBOe2byiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460394; c=relaxed/simple;
	bh=CE6IOI3Quzj896XpnUKA4zZtBLQGuZgw4J3TFCNKAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCjGS5JUA0NdnchlwbSmkiEV8pAHAildwZKKuMuXg2AnDbfJxp7NPM/kNpwBRMY+98eAEqUysil3Gi28HQ7jzYYz0MQLfHL6t7/71FKbVen95h9+1WRiu4OyCxrpePBdkP2Tv5Y6QZ49uKOLSGyNupNZp3fvUVP6ePIWt4SaIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqc4gQuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqc4gQuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF3B1F000E9;
	Fri, 31 Jul 2026 01:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460392;
	bh=fXaUMf0zF/5/SPQo1QC30JbpmHSlPuY+L1FVuNEI1uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qqc4gQuveecgPE0dRIT711f/nXZDFkWvcOcG6wI56oPkPqcFCoFIoHCCne2OV/cn/
	 gzlKNMDrU5/OYDtJHDyu9TY1A8pYBArqZzzxD4Ztk1t+fyPb1fcdY3p7Wj1IvzaJvl
	 uHDRc2vf9ozRvRFq9F5TmWI0D7XoXyu0rxR+IteIBqgolkalrAP0oOyRF6bRq4wp2o
	 puBYjwLyfwlhtxr9gWxaeSzrZFkML5/58uLvzzmlUekkAN2iPlF4lf1QAe6+YyS/CP
	 Qukjh7A/fCNd92txYQ+uTC8SDu0EDOpqu+cA32DXweQk/YyPIRswCim1IsKAfkalec
	 VGEZuRwpeiBWQ==
Date: Thu, 30 Jul 2026 18:13:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v22 net-next 02/12] net/nebula-matrix: add core driver
 architecture and HW layer initialization
Message-ID: <20260730181311.660d9392@kernel.org>
In-Reply-To: <20260723040110.91410-3-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
	<20260723040110.91410-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:00:54 +0800 illusion.wang wrote:
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_dbg(dev, "Configure DMA 64 bit mask failed, err = %d\n",
> +			err);
> +		dma_32_err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (dma_32_err) {

Read the documentation for the DMA API, dma_set_mask_and_coherent()
is guaranteed to succeed in some cases..
