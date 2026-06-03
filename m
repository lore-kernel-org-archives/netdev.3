Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0091A0BF1;
	Wed,  3 Jun 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491335; cv=none; b=BtaqbOxywY+28x5BpIz6786sv45YdVZyArK7gxGjU3+KqFFTy01zYX3QiVsscbzFWkBcARUBWm+3rL6jxbkaUN7D8aTvn9KwPeyoFUHAjjfsU9oALhtqS5qWJVJVjq8cCSnAZijVfU+bIiPC7ZpP8JS4L1xK0I1t3r74yxqyFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491335; c=relaxed/simple;
	bh=G6k6nElzVlSohrj7Ypd/k/ztuxeVsCgtuuIksNySwj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfMZUcH6bYTjoLGvart+ggtv3xh0yTB9PHzvKBNAaUL7bEnpcT2e51rBciovo6AQ6/394tPHmD3uN3jws1T9QG+pIk7wv2RaBewrk2NBaENBj+4thyrnMz5W8kYho+qWZB9JJCBRiXz7dFnIHRodxn5Fva2O5Mu3HJHc1uWuAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eBBCtHPU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eBBCtHPU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8u2Jh7i+EE4SalPv1UXpLCcYjn0jkw/InxVLERVBTqU=; b=eBBCtHPU6fp9bSQhN9llsx9xWs
	mUThDgDiFOjj0LjhHHeV59b3LbLvjstqKXNnOGJCzV8bJHeuVPO5JccBOOBneW12XwhsQ4XePVdLh
	ccP0f9ysQp2hbKbmT/Bu0vdfSFNNTw+ax0cwwVKC16ILLE64qxv2r7AedmXcHmxKcGVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUl82-005sWW-90; Wed, 03 Jun 2026 14:55:26 +0200
Date: Wed, 3 Jun 2026 14:55:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] rndis_host: enable power management for
 Telit LE310X1
Message-ID: <6f52869d-da6a-4004-a35b-c27d9209d84a@lunn.ch>
References: <20260602090528.2544-1-shaoxul@foxmail.com>
 <tencent_B7686B84CD4B76D76BB912FA6367FAC2CA05@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B7686B84CD4B76D76BB912FA6367FAC2CA05@qq.com>

On Tue, Jun 02, 2026 at 05:05:28PM +0800, Shaoxu Liu wrote:
> Enable autosuspend support for Telit Cinterion LE310X1 RNDIS interface
> by selecting a driver_info variant with manage_power callback.
> 
> This keeps power management scoped to the new Telit ID only, and avoids
> changing behavior for all existing RNDIS devices.
> 
> Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
