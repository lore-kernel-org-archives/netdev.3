Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96330AD0A;
	Mon,  6 Apr 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486163; cv=none; b=i6M2ScwJ45nD/JzdzMZJm2gsU2wLoo2zK9HvVcOV19sw12uOyxTKFJqdDdR9eYBDBo7oraova0X0qo2R1g1vHsM/7PJU9trTvaFu2YoDPoZyjZfIhZ/V94cO6NDDg+Zsg2TygrZW0FnQwRRwc5564E0P9f8tDaR9yfaO5qF/O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486163; c=relaxed/simple;
	bh=4rpYByPeeYcaSW7ZxR+eD39aYFN4cZWB5b+3na+8NHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv6eCyVpRvs1A5ZnuwV8R5Gl7WmkUAxJWBOA4/QwqlXpylfugPL7KN+oISN1ZEXEknqVE8A+Dyyz0PX3ztve4Cq3R1dxGDz/rALdFFFBJKoZ0GbisvUqbXAA6yPZlkVmNLp5A57SvOU6hXVedv45MIfY7qWeFYs8XUAzhdWSxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFDEERGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFDEERGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8773C4CEF7;
	Mon,  6 Apr 2026 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486163;
	bh=4rpYByPeeYcaSW7ZxR+eD39aYFN4cZWB5b+3na+8NHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFDEERGEyDBH3lXboAg5Ozy0INoP73Ra/gyaBcn8VVXvER6BoU7cw6RZ4u+s5xqxy
	 EpZNsQjV9yqIWz3Yab3WvoF0qHvFoXkvy/FU3nCG8GX/DqOwvZIAaBgj8FEtCOYiaJ
	 p5S8eFp2bYsLvaHwDPi/qTHyLYyqzIwiOfxxZQjO+/zb/7xiqFFIb6FtklBJ9JWAGt
	 B9PMSaUAXwN7V5imvTzuUDtcaEcm/gHfyVBjM3hvk0rgV41fGOj8Qv9usLJPgPfQFI
	 2EHO4pepX0l50+wflL+HASmI2TKYO5QCmhWBRpQrNRHBQsaF46NX1x+k9bSrYjtKpv
	 mT9HqIEsQzwuw==
Date: Mon, 6 Apr 2026 15:35:59 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
Message-ID: <20260406143559.GF395680@kernel.org>
References: <20260403084402.4105936-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403084402.4105936-1-yuehaibing@huawei.com>

On Fri, Apr 03, 2026 at 04:44:02PM +0800, Yue Haibing wrote:
> The variable ret is initialized to 0 when it is defined
> and is not modified before copy_to_user().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

