Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792D582B8D;
	Wed,  9 Sep 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971212; cv=none; b=NI6VQ30FexE3OeVx0Bzf38FJ60qSB2pt8tt0qAMk7F4gELehgGA3SAsFRuvJwhGxyCOCpgdtU5ZQT+l2q6v5zS/2LxkxeVOATJSlQU+q6kfj21NRTo7QQyDC4fDuU7rYBAmZSd6EuELeSKZbIwlFYuYXd9LXnR76HVZjgOanoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971212; c=relaxed/simple;
	bh=dDsAdRjf3J+qEjODaSBRponUlR/JCUjwm3jz2vQePxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxIGjoC1sdrYP44gT6bpfVmZ4wDicAflyehF8ydDrvoWBaaDcEXi25OtWFWX6ieXERXI8zpKKNDZUA+2vvNDuvVWAnilVAn4eySUFIMco8IU2XWRJQlFb8nPA6+Xfy2w/Nzbn09J4wfWqMI39D0dKva9iO9RImMgGwBAdDHciA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRF2wjgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRF2wjgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AE01F00893;
	Wed,  9 Sep 2026 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971211;
	bh=GTQwmf9vw9fU9/7tf71N4P11nNyVn9slLycnGW5pH34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRF2wjglAZupjNRH+EP5fiGrAiX9/GFjvfqFBV0ACr367nQ1NAkCxHjQ30Krt+7br
	 nepBtMtKuJ5I3NUZEVEnFrzGEPhx8jrP1FwdZHV07rkP1ZiXp/95BEB2UwEOW3Hsm6
	 38kkcLjsPBK7lWCUvjEmKeJW+O3oPfgkcnW0GuNfkjSCt5Qi3ylTJezTh/FNkrY15c
	 JR0rPc/cNZLR7xuMkYRFhkRNLsTVIU4SaJoljLTvcL0HpEVoaD+1nvA0nWi5rYzUuO
	 HO17ZSs0ScjCw9x5W/BL8qQcFuUXbNau545mOH70mpH6sdNApM8b60DDleFlBeadDy
	 FvemsrHsXA7Bg==
Date: Wed, 9 Sep 2026 17:26:47 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net-next] octeontx2: collapse consecutive blank lines in
 source files
Message-ID: <20260909162647.GI40544@horms.kernel.org>
References: <20260908061113.246837-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908061113.246837-1-rkannoth@marvell.com>

On Tue, Sep 08, 2026 at 11:41:13AM +0530, Ratheesh Kannoth wrote:
> Remove extra blank lines across the octeontx2 driver source.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

As there are many non-trivial changes coming from you for this driver
I think we can treat this as a clean-up in the context of that ongoing
work.

Reviewed-by: Simon Horman <horms@kernel.org>
