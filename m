Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D919F135;
	Thu, 29 Jan 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691563; cv=none; b=nBbxmfVOobeIBdSxWQSF8OnqLpueAdHQkqLShNew+kmihBSctzVHNhFhob6rhiDbWXm7p19bhCIR1Q5eBiqbr8+kYSI2VekeLaJQKDBSbP7CkA0Wkjzju2CTYj3/IkS+9m22LiZn/kLnUGuNt/RZUP/aAmkniLn/0WEAaxMpAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691563; c=relaxed/simple;
	bh=oSZPaLcjK0DJK4c/oRcbBRrktXJEgY6brvhmdnpaE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGBdwkO7WypF2GqciAdpZEHHklQeQXAH8ILnr3K+Z1CcKasXjFoqXiwsiip5RlaHl+PaCba68+V/0jNQy0P568yduLJg0jOBvBQt+ooboPpEXezBU5QYPu+ExQGofh1VTrNidiwVl7dPnlqY6YdbMFab3LMzVlThRqy4oAklvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he6GzI9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he6GzI9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E85C4CEF7;
	Thu, 29 Jan 2026 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769691562;
	bh=oSZPaLcjK0DJK4c/oRcbBRrktXJEgY6brvhmdnpaE5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he6GzI9XNL/sUz8kcBTQVvi2rhZZ+iTZkYlKnzTfj52lRPa+okPe1qBezIfmvhQl3
	 rSg68PVxY4G2UyIVIWG1Fl7lQN3SSqGFFopPgoTvAJS02bceU0XEJt3Nr3g8894GG/
	 EYgjLmnJnod+gZIxjOGByhPcy2NNylOueZYZ4vuIVvrqbPS9fB3Bnmz9JNNvnvwA6z
	 +VBgrM0zonHjkdispj9yE/GQQVuDo4aQ3fuTvZ631GxLS41bUA55gBTPwViAol3vNS
	 +HNM5rX7zW8BAAqH5F6ZrDUJ+OJvOIO0A1dnWsBXs7jcY5Gsy4QczZ6vWd3B18fMDf
	 WHdBCVAGPPxeA==
Date: Thu, 29 Jan 2026 12:59:17 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Alexandre Cassen <acassen@corp.free.fr>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net] xfrm: skip templates check for packet offload tunnel
 mode
Message-ID: <aXtZpSuGT1WPNwWO@horms.kernel.org>
References: <1769518163-125874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1769518163-125874-1-git-send-email-tariqt@nvidia.com>

On Tue, Jan 27, 2026 at 02:49:23PM +0200, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In packet offload, hardware is responsible to check templates. The
> result of its operation is forwarded through secpath by relevant
> drivers. That secpath is actually removed in __xfrm_policy_check2().
> 
> In case packet is forwarded, this secpath is reset in RX, but pushed
> again to TX where policy is rechecked again against dummy secpath
> in xfrm_policy_ok().
> 
> Such situation causes to unexpected XfrmInTmplMismatch increase.
> 
> As a solution, simply skip template mismatch check.
> 
> Fixes: 600258d555f0 ("xfrm: delete intermediate secpath entry in packet offload mode")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

