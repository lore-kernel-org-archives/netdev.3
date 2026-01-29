Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC28934F;
	Thu, 29 Jan 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704609; cv=none; b=czAevvwlZhGfOL31z9V3D3+FtjZG98T2xgnywtAY4XSPffQfTA+OVIEovHKW0VVGRajCCVs1tHUOh999eVQ2ibsP4Qo4eDmBgbC6uE/2c5S21ZVRdlE+zJ94zxUkQ7awSdmcDWbywwTmp5ov3KfEu88oTlGu+rDt8EeuhujtUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704609; c=relaxed/simple;
	bh=j7clNA0P0ppadRc+5o2lyO9sIBharxomFEA2q8V3Kf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdap1HCKMYQcQe2Q3UY6Yoz1vZkGeUVjMv1LrC74e/sD0b+dRUUmLKgxLnWuFFHXfaxOI3rdycGK9HQXl/f+g+Tg8eL8ZPYpE9VrziEMoy5amM4xHhFfYmnuREJoh5LKkxnrbWUmZ26lJABoSI5QSXMKuZ/VvPr7wuN+GHry9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaJFS/Sx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaJFS/Sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B2C4CEF7;
	Thu, 29 Jan 2026 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704609;
	bh=j7clNA0P0ppadRc+5o2lyO9sIBharxomFEA2q8V3Kf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaJFS/SxgM/RQFV6geLuGYu2xOfZ7Z92aE0/YtqpQ6RikpW9mNeGRZBQK9bCBgfre
	 KJsn+2FJpObVBb4FBoIMMZ8ASL7Ls0nmXljSfsM8QeJpJodpCVhRHNURm7v41vW/hx
	 alpB+NIt+aruDKhm23mggQM4dsDA05Evbtu1i/K/X/FfK8JjUHwSfASDSZSMjhylSc
	 nOLP20HMLPQzxOJv0WghVSmv4ObqqHwU94xpb/2u2EN/wi/aVCZH1OEVck4xtnXDWV
	 0kJbYeNrU6boPlGoMz64wNifZgE3+dveCNSYfdBhJunQIUdhEeeBDeVErb7fP+lnpR
	 P19bhiv8WBbfQ==
Date: Thu, 29 Jan 2026 16:36:44 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v2] octeontx2-pf: cn10k/cn20k: Update count_eot
 in NPA_LF_AURA_BATCH_FREE0
Message-ID: <aXuMnNl3B0rcXeor@horms.kernel.org>
References: <20260128022448.4402-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128022448.4402-1-gakula@marvell.com>

On Wed, Jan 28, 2026 at 07:54:48AM +0530, Geetha sowjanya wrote:
> This patch updates the count_eot calculation for CN20K devices. 
> Where the count_eot feild extended to 2 bits, while maintaining
> CN10K compatibility where only bit 0 is used.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> v1-v2: Fix size value based on count_eot

Reviewed-by: Simon Horman <horms@kernel.org>

