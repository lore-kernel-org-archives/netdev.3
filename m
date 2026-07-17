Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB983ECBE2
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304684; cv=none; b=BWpAv+lN9BUvejLCG3nTvKQroQJXVcNIt8YB932xqdnBawQT4or7RdiVNfafrkwPyFW3+RWFIrBi6+HwVPH+PwRW8rSXhsAhvfRCNSf+K9eI7bYur4tTqGf9+X9nQJlwIPk+o6alsrN3CMbvKEDBWlFU4of4qOQp+RbBA0Gbgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304684; c=relaxed/simple;
	bh=peNtOothV7RxDm36Sa/i9YVtL1jXGbd4LyWz/eoQPng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEF/8Jkpk060BuU7acDq05yQlfJQaN4F5ZOtB6dLXxuQ8S6nssnrxQgDoVMhwIwmPiqbjFkYqwrlZEyLe0aALZdFarfSQiSz9u+dPyHWCcG8IS2ClA4mvlO/v2fTPuXr3Fez5ltL3n6Tdd4iQ5q1XwE71kruXvCRrz3IZ+LyMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yBwVyppP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yBwVyppP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z6OfRQrbv0SMW5LjJ565bDwFjF5VPXia9Qll/HFleZk=; b=yBwVyppPsU/KNL+g4xuya7TGqs
	Ak05+eGjrf3XruSssp3KYs6ZCxaS0Vzplsw8nbFbpk9X1bJKu63qhZTfVdkotZhaK+IVb7rKlaLpa
	dIvJx+mBGNk7FlxpbTHCoR/Vc6UHyn/Q25S43oXOUpTvP7+FzLrmzAGw9bl3iyMblQmY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkl9X-00Cpvd-7Q; Fri, 17 Jul 2026 18:11:07 +0200
Date: Fri, 17 Jul 2026 18:11:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: sxgbe: fix null pointer dereference in probe
 error path
Message-ID: <cadaddd4-54f0-480f-901c-76e46957759a@lunn.ch>
References: <20260717091423.1557737-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717091423.1557737-1-chenguang.zhao@linux.dev>

On Fri, Jul 17, 2026 at 05:14:23PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> The platform drvdata is not set until all IRQs have been mapped, so the
> local net_device pointer is NULL when IRQ mapping fails. Remove the device
> allocated by sxgbe_drv_probe() through priv instead.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
