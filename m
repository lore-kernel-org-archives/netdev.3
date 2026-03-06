Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0937475B;
	Fri,  6 Mar 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818529; cv=none; b=Athi2eXJ3NOsJev+KIGHPwDHcfe4eHecUQMmOYIJCdPsqhOxUguYtQFkjR3rHN8ROv79XgX97KrI03KHoX67MiOe7rC2CioDTBEOoqVZsMigSf2zVNvZvES/+irKPCGHJzN44M30rZzl88q1DSafWJ0i7nPwefykXZrPp49FKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818529; c=relaxed/simple;
	bh=b0nz60gqa0A2bobFRuBO7QvFUiyPIQywBVkhY3IqHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg4y0wlsK+tt/xNcCpz1HzameEzjiuOQbeUCJUCBziZW/I5FiXWANIMg9uJO5AvQBoYc9B9mXg2Vx433CRciefAm4hOpk+0SdYBpO54uPzazWNC7rmjW13a+hZy30n0HP7ovQQHfU5YzWGx9TSeUVuu60BGyj5BT4ZLYB+Kwqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jf2+ryql; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jf2+ryql"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nSav4Taj7FeSAbA4PAMmEMckkxxksEcAn0hDjSYjp6E=; b=Jf2+ryqlMTWeK20RlmAy6tGwLQ
	vW2j2Z8GlmgJlHGlz9vqr3K2Bt8oBeZDzQ/cQVruxftpI4NYZDl5XReVDvjt2ZvsdpoLJsiyrRTyU
	CCAXtwKkaePDQI9qcKx4erO+LGDDO7VHeiwQNUz7LkYBDjfWpN3ZC3ykD/Qw+3XUHzJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyZ55-00AW6k-3S; Fri, 06 Mar 2026 18:35:19 +0100
Date: Fri, 6 Mar 2026 18:35:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mvneta: fix NVMEM mac address
Message-ID: <b0f7d9ed-2df6-48f3-904f-d256f1ec881d@lunn.ch>
References: <20260305224643.14524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305224643.14524-1-rosenp@gmail.com>

On Thu, Mar 05, 2026 at 02:46:43PM -0800, Rosen Penev wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
