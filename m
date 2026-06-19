Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBD283C93;
	Fri, 19 Jun 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858772; cv=none; b=K7fVPC0bVAs07NlXpS50Suq0qwwEazJLmtbYd+nwJYw5oXNqE2UOulF/vYVJeqSIxt7sHL/jkGb350eR6f8jK+Dyp/QfpBz+5XnfMk3KYGyb7Qhl9u+oawnJ3aMvRdJPACb1MimYhrXCQFaP0l6rUyiouU86tfaUik7NqJh8+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858772; c=relaxed/simple;
	bh=KY1C47P+ZXHfNpSp+CFuixpqLfghr1Idy5h/B6LXxGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGwCiHG2p/1WpJFtgQn4Wk3R+oN0NBxHoMJVorYWMCGqQff1ToUye5JsMvK6rvif+1YofeYmtayqMegUjqIR5dLxA5AuB+sBHWE+OSNSwcAGEaULu17SZSKJSkyxXTDH8UffwIdozgQKaCE4Zac+fnZ4K0p0RgXR7Afayu/JKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liUthXPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liUthXPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E411F000E9;
	Fri, 19 Jun 2026 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858771;
	bh=Q3jUDrpfpTl+7emDvowW0x2rQb/5MzXpy1kl2YHYIoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liUthXPeGpnysTDtwuQHY2k6+Mk+U/6R+yJCmxpAGg/kHa9LUl2mclaIA5FNK0Gi/
	 zXfDBwRce4qBfJ2sZOrbvUD3bLPrjNAbbW8iGh2w+93UifSMSRcrunVzNKaWrp+CBS
	 Jpac10a2yRO3lFDX9AzakdObbI2z8Qbe0+69yCo28CjvEYuau32vy/dvi1bkYNIOvk
	 5H9uXx+BFEiXvVOVcMcWqBNmq93T3Hhy+rwI+XOqk1fVp0pdmYJ8zrsVJdjeonsAO8
	 MU9NpiFnIBl6Zaq+xMNJ16+rASvOVmNQtHOJ6VZC+aQYZ0FD4qg4x6A5S8zCEMsoTO
	 iYgj89T+9u5/g==
Date: Fri, 19 Jun 2026 09:46:06 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, rkannoth@marvell.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v3] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260619084606.GS827683@horms.kernel.org>
References: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>

On Wed, Jun 17, 2026 at 09:10:53PM +0530, Subbaraya Sundeep wrote:
> NIX maximum number of LFs can be set via devlink command
> but that can be done before assigning any LFs to a PF/VF.
> The condition used to check whether any LFs are assigned is
> incorrect. This patch fixes that condition.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3 changes:
> 	None, updated changelog
> v2 changes:
> 	Fixed AI review by updating error message
> 	Updated comment to mention modifying NIXLFs has to be done prior
> 	to attaching NIXLFs to any PFs/VFs.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>
