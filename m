Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88113A258;
	Thu, 28 May 2026 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935633; cv=none; b=WflDq/I4S1PgF+RKQcy+w7qZS8jQYpNAE6ShBAA7lr8LOd7HV8yZ5gq5YwQMdM62pNbQS9ts1o4Sds1/xD/aofeiOiqZ+c7YzHkMJu6gBuBbWw10YR8pmn7m71P11lfuKmNeEz6ba1aUiXIuOwyEoC9B3DI7V2cyqxMaXCwWdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935633; c=relaxed/simple;
	bh=kb2/Yj8883Ry0KYJftKeqRkMC7S0d7pUj9UIOFkR/NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klIBU3UBx8+fY3yBCpc514p+2Ih2Jq4v0XuxzMd1yGFaO6WXFVRzKrBMniNWRl+ORCL3k44hVoUu9ssC+OYSaI6jA9qfRh2S4qqAqgcM9BDBY68vj+8134pDlboNkqUVIdG+d7G3dInsdvcy8DqXCNFy7uqn/8XgoA2tBl4Feyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t0DTNX1u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t0DTNX1u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IWaVCqIYqMerJX6G7YPSl9UYzPzmFnwijFcFs2+b3h8=; b=t0DTNX1uKeug/pymB+vqLhEwKy
	4IUviC46SvhK7oQGRer0ZZCZ6WzLjWHGhKk5DcN8344KH0X7fXJ/eX/YUNQdiCbFGH3DcQ0A9ddhi
	ZUkxYBlgyGBBjyfX04kJuu/E6bS/PT4q3t6JFR2IyZQDXF5v+5EDp5FtpGey3PzX3LNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQZ3-004qOw-U8; Thu, 28 May 2026 04:33:41 +0200
Date: Thu, 28 May 2026 04:33:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] net: phy: microchip-t1s: use generic
 C45 MMD access helpers
Message-ID: <9ce89e42-8858-4a37-b153-930de0260ae0@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-8-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-8-37e5c8d4e0a0@analog.com>

On Wed, May 27, 2026 at 12:51:53AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Replace the driver specific lan865x_phy_read_mmd() and
> lan865x_phy_write_mmd() with the shared genphy_read_mmd_c45() and
> genphy_write_mmd_c45() helpers.
> 
> No functional change.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
