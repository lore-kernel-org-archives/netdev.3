Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCF36CE1D;
	Tue, 17 Feb 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343816; cv=none; b=CFsulEy3FLb93MorlgyzOg3UgvD4weoVuDFj41ts7t2X+26UesdfOZDYOKv+qNnvqM+Di/DJ6QYXEbl8/CXL7gQqa6nfwsyg5ovTj//Jc5KrpXQ5la6G+IJbANgNoZzHY0HvLjcNhxvcXN/XHn5DZgxml7TcT3ncO6VjpcDdk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343816; c=relaxed/simple;
	bh=7+TGvRQAiI1DAmzxWZhzWWIdXayc11uZG3pTEpoajDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTihWf1R0Ea4m+Q142CAXYjiSXl3K//wldkPbp6OjfWp6c9fZGXgT7nNLOKIvI0eTYJR9j4l6FvFMVoz++ynDbInpC748m9qmQ1CiOqF5P/COAXckRnwmIAXlPiErOCSqDTHGA3dbAaoLr+RoFTBWNd4aGR6BKKPAYu8FnLO+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6ngiJHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6ngiJHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659BC19421;
	Tue, 17 Feb 2026 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771343816;
	bh=7+TGvRQAiI1DAmzxWZhzWWIdXayc11uZG3pTEpoajDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6ngiJHDq1HMbHMe1WBFfP6vsWajhWHUPHeghprJsUw96LSXMNYQeCxiANWGEEhvY
	 8SU5ov/yJvYY/c4Y0O/GVB3wKqO4RVxbwOCutKNji2C4V+RuTm2NnTtayJkZMpi03R
	 woKSgx4aK+JLA7+KEbegSpKaL1wTvxCJnFoyidfIljud6ij+IH6wgvVXOik2+qAVIz
	 znA7wBwpSdZxfMrNpc6C+yEjNTwfncGwwtBW1OKGdM40H0/hloQ2LC35VHmcfbHtKp
	 IfAbDQjNg2jTCRhBMkWx2HYj/oqJu593rmVfLCFcigCyXV/wvaQ1CIpP/EAMRtwE3g
	 SL65Vy5EqkTNg==
Date: Tue, 17 Feb 2026 15:56:52 +0000
From: Simon Horman <horms@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net] bnge: Fix typo
Message-ID: <aZSPxEDPhyEVzAr_@horms.kernel.org>
References: <20260216140235.3764145-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216140235.3764145-1-vikas.gupta@broadcom.com>

On Mon, Feb 16, 2026 at 07:32:35PM +0530, Vikas Gupta wrote:
> Fix the HWRM command type and use the appropriate command to reserve
> the resources.
> 
> Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>

Hi,

I think this patch could do with a little more explanation.
It's not clear to me, at least: what the difference is between
HWRM_FUNC_QCFG and HWRM_FUNC_CFG; and why only one of
the instances added by the cited patch needs updating.

...
