Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA347A89D;
	Tue, 22 Sep 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077645; cv=none; b=QjjgymVbkQ+ZWfgwRhBsmWDe0gIzs87vuT6UDwgpPxcIpyl2m4JX1jiJCEypool+j4ILXbBvoRvWlqTz5YE80fSge/ROpY+lX+nPwzDTP+eWZt4o/NMwxslJf2IYCmhkyDJJ0kl/VIpjXIAu3lUsS3VFuOCPXUfNsrEqoB0V6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077645; c=relaxed/simple;
	bh=fDvABMmn2gF+dxKZ5yEeqCVmQLNzq2xUNYxqDoYBvyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwN+dDsLlCOsbNuCzC6TLK5PKZg/W5yvqbhn4+Ha41kzCeb+RtGCAl9gStG96mQ1pM7ojOaYfzyA3xVD3zefbhbEamlvVPHXFtcgLMlws473N2aKCR3OMtrp7kKujBHwgOk0wGyl657riN7a0Pvh9C9F6SQqWQGCU9COD/FL07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1Vgs6zbA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1Vgs6zbA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xwh0UeYuRKjonVg6AFJmOLkV18tksckswMbSauTQoJg=; b=1Vgs6zbAFKKdPhe8r/RTlnXpzz
	bAH3NnVJC1PFkcf1JTfFWUid/FVM5DpIvAi8qw1T9SmT/z0c1T2W4qyeHyVozIFL1h/3+7/TNRcMC
	vFH9X5uPExiLLOkFq7IBe2/9Sa7/IzrWiWq6Ej4g9HNV7M4UauId8YfhWkYJi+u/OkV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8yxv-006Zgb-QJ; Tue, 22 Sep 2026 13:47:15 +0200
Date: Tue, 22 Sep 2026 13:47:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: dsa: motorcomm: Split xMII and
 SERDES port masks
Message-ID: <2091d719-ae00-42ce-aba9-3aa7fb0ebb2f@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-3-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:49AM +0800, David Yang wrote:
> Replace external_mask with xmii_mask and serdes_mask, and advertise the
> interface modes it actually supports.
> 
> Also move struct yt921x_info into chip.h for future use.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
