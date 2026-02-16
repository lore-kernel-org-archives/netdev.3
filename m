Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312521FF1B4;
	Mon, 16 Feb 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250939; cv=none; b=aRy8RjCQXMF5/cXyoGzm0BTFXEjGnAMhS0SHCPR7YUTA4jbiHBYYuuSZR4Mbty72VxsOgU9jBtnqgs94dpS06tSKk9KhynVVfmqUUt6ynsb4iPamRdzAlaNcLwz71KYnJ+SgoTvnFFf961634cSqTHkTRAqEQtTkLoySfFeoGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250939; c=relaxed/simple;
	bh=116cb+xgGbgoc9C8jCmlL+rj9u3xCBtRU9JNDUE26qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIIYcyXdrXPNc/aNefbPPRJs5hPToN2Jk+R5ukNO7dVOeZdA/ySNKooe3pIUjqDzFkSDLGVG7V/ddErcOjnG2B+mp8OKYUEU2TD2/ns26oojVtCBDpP++7dRZwgyJPsL8DxzWUXB7AJmBLu10NJXA4G73Tv8Ce7pOxywJAaoi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1yBmi4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1yBmi4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEB0C116C6;
	Mon, 16 Feb 2026 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771250938;
	bh=116cb+xgGbgoc9C8jCmlL+rj9u3xCBtRU9JNDUE26qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1yBmi4MJQtYsAey06aRlylVW0WIDNVtm/sXEP8NgoJbam8+HZ0nRA5//Dzz8RXvq
	 r3zo3njqA25D8Zgdk3HjkeBMWFkJozK3/1Is888H7v0hhMdaa3AQBKb81lYdBatJqC
	 /YPpRC3/+5F0BT4aIyk3zXstGDWx3afXRzhqBUxsAMhIGEA7fqX7whGBqzs5QyF271
	 mSyIJZOKirgohiUwAzmP0FUbWkzYD21MiGlzU3P+n3CJBTRAiCN/Jphxtp3+w5fCZV
	 ObOFXugdu/SBOMrGL2fRtCuPvz3I4HIAMq8uJfo6O7nO/WQbi+gNAzDjLsvDEbUz72
	 OVhBX6ZRFY3Pw==
Date: Mon, 16 Feb 2026 14:08:53 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net Patch] octeontx2-af: Fix default entries mcam entry action
Message-ID: <aZMk9VbY7XVIA24T@horms.kernel.org>
References: <20260216090338.1318976-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216090338.1318976-1-hkelam@marvell.com>

On Mon, Feb 16, 2026 at 02:33:38PM +0530, Hariprasad Kelam wrote:
> As per design, AF should update the default MCAM action only when
> mcam_index is -1. A bug in the previous patch caused default entries
> to be changed even when the request was not for them.
> 
> Fixes: 570ba37898ec ("octeontx2-af: Update RSS algorithm index")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
