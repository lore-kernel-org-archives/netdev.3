Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44119223323;
	Tue, 30 Jun 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857529; cv=none; b=IltLjzHrT/5hD6YrC+/l4+TPG8a/eeygAdaQfuHp2Xw6ganotbMijWKHI8595n7rygvGx6ckan75ZW73hD6G1SvbU8mlHyqUEgYg2dCh0UhOaFXetHHDsY8ikKFBeBq9zzPjxIHjW5MHK09bGLC151cfbHwStbWcvyOYw+pM74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857529; c=relaxed/simple;
	bh=764TYUv9rAPQcm9u7JJ11Lzxy16ES1SQ5XOF7V3Mc6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbX/6Z0PtLqOAaV9XfbVJbh4xYpaljEyRwP3HYM0k0G5dD8zTQybWDdtdyzVMhsNhXggF7JmAKSiTVAWZAqUbTvGWDK4aGnCDP3vqOIUQgTLxmf43AxKuAyMsamowmovkI55i08nDYIfS1OWRTMz5gYF3qSAjfcNPvb78YzJ84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xWucbo8M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xWucbo8M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=phJHGX/mP+wiO0Z1rkzC87QW6LGBNR+mPIfq3lUU7cU=; b=xWucbo8MpdKyG5SF/PMz7kwigL
	Y1Jq/htQ+Kg8cQV6w1bDfHWF4yYHbjF/dIl5IE7ExMR1WWP2HRwTjeMjbpYYSpGFaEkPN5sh1LfA3
	D4EmG6d+1ZR3vuXSKiUZ+oH/WAH5BmX87JThxXB2kFArr412lKe1ZVqXum/3azatJps4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weggU-00A3Fx-9d; Wed, 01 Jul 2026 00:12:02 +0200
Date: Wed, 1 Jul 2026 00:12:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: dsa: motorcomm: Split SMI module
Message-ID: <af929930-99a6-44a5-96f9-408b517145d1@lunn.ch>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
 <20260629183137.541341-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629183137.541341-3-mmyangfl@gmail.com>

On Tue, Jun 30, 2026 at 02:31:33AM +0800, David Yang wrote:
> SMI operations are going to be used across different modules.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
