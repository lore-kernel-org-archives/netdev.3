Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCB45D5D9;
	Thu, 10 Sep 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037717; cv=none; b=PKh4eb+hHsHgXjAOw2s3jz5jHG9e6N5fW5sZ6AgKnSx8b4YiHgqaMOek84Bk5VALYSu/0bVxxkTWPhnObN9EF8L3cAqFqFSoHvisH6nC3o3eJZkK2V+CZraX7cSWcw2q5zKv4pqJiE5i7Pg8I+E6WdiJRMDFEIhVq8eB81XC20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037717; c=relaxed/simple;
	bh=SYToPn8hMgIWzJHVd0/vB/XaoFYRH4qpk/JrZuBcZDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5oFXtcNOm9PFwc885BFAPBonoJWqiKHLjZtqhaDv68oVcCNxIGBzAFVta9DzrFivlqDRufgrg1uiBrrR5yDyQwDZMaMTO6svrzlPSSYi3ZJGj78N8uJjupJqQJixmbFDCjM3S1tU5ESPVKP8YGBbGnkXr+y0KleBqfvasyWaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzKdwTob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzKdwTob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DBC1F000FF;
	Thu, 10 Sep 2026 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037707;
	bh=k3y95bxLAFvgrNyCob/CXhQ0nzIPehv0odU98AOnHxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzKdwTobAZaNcb4z4zK32QVmVnd/h/QC5nwTosfoFsoajAQoDWYkQE41ERnw2kXib
	 HRPpViyHRg2chKUeQcxAMnZNoEbRnP0L6bJt9tv+2lkD7yNbRMBAlpsonzBjLJPEAR
	 BIhJwUbjmiuqa+RhZ1lvzmnCZy7Q8aK8z0C5txnxt77e3RLrTRB16c185/uUy8oE1l
	 QTd4aQ4gwQQy5ZFlXZ1Kf8QBG8jRZff9R2D7eU200Lh5z+C4mSIOwTtiXU2zygTkuX
	 KzYoYyLuougMv4jJc4FAnJ878qut5FEZHxU/RslEX3TK6qJATJXf1H3hvFK+ZGoyjb
	 mYsfLIHe0KQgg==
Date: Thu, 10 Sep 2026 11:55:04 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: davicom: Propagate wakeup IRQ errors
Message-ID: <20260910105504.GD40544@horms.kernel.org>
References: <20260909045738.16705-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909045738.16705-1-phucduc.bui@gmail.com>

On Wed, Sep 09, 2026 at 11:57:37AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The wakeup IRQ is optional, but errors from platform_get_irq_optional()
> are currently ignored. Propagate errors from the IRQ lookup, except
> -ENXIO which indicates that the optional IRQ is not available.
> 
> Found by manual code inspection.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Changes in v2:
>  - Add a Fixes: tag.
> Changes in v3:
>  - Remove the goto statements for the error paths in request_irq() 
>    and irq_set_irq_wake().
>  - Drop the Fixes: tag as this patch is intended for net-next.

Reviewed-by: Simon Horman <horms@kernel.org>

