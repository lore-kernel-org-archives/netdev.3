Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612372D73BC;
	Fri,  3 Jul 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110102; cv=none; b=h/46UuM380jAy/uJrNe1DUVGuwRx18fGiaBmv8vhp4qZ6DF9lWX3NSCcQUqBMMGnDrq3WcADO7HM4Eik0C9ucozOVd3wWSyPwCvSwTvVILZ00Kpmr3+5NFAuBz7UFg2wr7+ocGZcxQ9S7VEEmnoIZhzH7IyQrQRg+B4/2wFC3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110102; c=relaxed/simple;
	bh=lapjpzirvr1mj3dOhhdgBULRZqco5HaS7F69xFPVWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2deRa+dH/Z/KZRZK4MnC53zgK13OzuN6NFINQcdiSBdqNR4zBwtnneAJhCqg4ZhwIib1MYQeNmCTf9G2fL3BsF6292C4Lb3XM4ZoSTt6DU55sNXIsf1ak+HTKsgm3RzCGDIIfmDxec/2VdcWEC5YYL4QHup/BMdwnYzXO8xojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OgTjMOLU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OgTjMOLU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sYGLs/FMfUYrK4QspC+CbCTv6iX6xuYAnZSxHFWjuGk=; b=OgTjMOLUtlVsSZB4hpJ8iy2x1U
	azrgX4bQhuwhMfnfH6z4kDBib2Oun6mMqkyNYHNvWWxn/8wqyBa7KcwOkP/bre6OpSFSqZdDuxEsq
	nZDYidJ1ez/pJnRHC8/Mb2b4rrl6pc8Vmuk0Z1dvkCrTogy4bSV2Sh2WpybWbXePFwdg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfkO6-00AbKK-KQ; Fri, 03 Jul 2026 22:21:26 +0200
Date: Fri, 3 Jul 2026 22:21:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] r8169: add speed in private struct
Message-ID: <938dbcfd-08f9-43f7-b358-169c2c7f1e8e@lunn.ch>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
 <20260703092459.1124-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703092459.1124-2-javen_xu@realsil.com.cn>

On Fri, Jul 03, 2026 at 05:24:54PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds speed in private struct in order to decouple
> from phydev in the following patch supporting for phylink.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
