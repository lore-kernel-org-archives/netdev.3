Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F983242B8;
	Wed, 12 Aug 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551889; cv=none; b=YMx6kqY57alwxRi0/cFtMmDUz54FbjgLGyG25bLHVaGBKO8NA1zirBqI2jctVF4BAbhRUDerIf/V8aQPkGfGupZmfZWbuDtQVyHwW8wkTRdyoDloBQSjwTPVhL9fTJ4mAbNQM53JlGkHBYOnmMh8/CkpzKlQXxqY4tbzodEBz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551889; c=relaxed/simple;
	bh=Sn0dsXQkcssb9VKP7BlJbZd8jE7fXnE+58sqQAZgtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeB70UUDXfzb0xOzzZ7ahpulaVJmUq+bwj/JxX5rzVdAxKoYeEE8Ep8lW5UfoVDcrG2XBevzxO3TEFzw6A58+rtrYi3Y3yF5TiNDFsnpxKX7qXh/qGWW7RHWW4mXqmdFunP3NCh8rATrPdrJgpAIFRQJ8yutoLQbeVGL8WDW54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IP0US4iq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IP0US4iq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RyZWpkhQR33tAnbvNrrh/rwLBd9Kc6IEPIDZNjj7Fms=; b=IP0US4iqEcczx3LsF6rlfbU9cl
	EpitVMUqtwfdU2PlN+Bm9tpqoOCFlFkmnqrkrW5BYJG1W0vfQPfq8XRV1tbJuj1DGT/vYW85xIxBS
	mgX57LFR+ZliTXB3gNfNcYgL7uoOXyj9wOr0XYpvrAy6bWUl1YBGrijRkyS6m+A8Ow6Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuBky-00HInP-Bc; Wed, 12 Aug 2026 18:24:44 +0200
Date: Wed, 12 Aug 2026 18:24:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kai Kuang <kuangkai@kylinos.cn>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, f.fainelli@gmail.com,
	linux-kernel@vger.kernel.org, kk47yx@gmail.com
Subject: Re: [PATCH net-next] net: dsa: drop explicit NULL comparisons
Message-ID: <9f6ca3f8-de62-4f31-bb6f-f8b431c80935@lunn.ch>
References: <20260812060644.210997-1-kuangkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060644.210997-1-kuangkai@kylinos.cn>

On Wed, Aug 12, 2026 at 02:06:44PM +0800, Kai Kuang wrote:
> Replace explicit NULL comparisons with the boolean form to follow
> the kernel coding style:
> 
>   dev->class != NULL  -> dev->class
>   user_dev == NULL    -> !user_dev
> 
> No functional changes intended.
> 
> Signed-off-by: Kai Kuang <kuangkai@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
