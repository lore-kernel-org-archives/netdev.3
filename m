Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795D2D8385;
	Thu,  4 Jun 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612584; cv=none; b=vCCIEqgRBN1mF63mK13K41imbX95Z9NKCRdmynJ88DNY8wGPXiltwlh5l777GdBos0dkFmVGtJX92+Ej+L8X3EemLFVmjJ8s34bCVt89FzTEBHp6TJajDr6KVQRfNR/3zU7w7v8ntnA+ELN9i+5D1Z3wbmeb2nWmOcQNkEhysXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612584; c=relaxed/simple;
	bh=FASZAE8pLVKgSfcse/Ffyl8vQPYNS73BJL2Bwj7CI98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHIqw8rvjz64loAef3GwfyHYA0L7MmnplvwX5ekxp62wWoQcoGu1YlAkWO8WPn1VZnKAzGG6GgryPN85s2qvsYKexZnRDQkFQoI1bQaIoiOUyrQYUcZhaahjZp0eqWNsDwgEwpHOzpIHSxM/PuG3OmdOKuOfJKLeMTZw1iul3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TDsKoQNW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TDsKoQNW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8uaGBLq/GFMtTnS/E+NOEB+QPoQ9U+u85hXs+ixNIoo=; b=TDsKoQNWjRFgQUXr9cYhoYw+iS
	732B25+f9tq1Z62SUW/KAhheIBCoUOIYyqksrLdPg6aVJLSIy9GkPLCIXDZpeIYYbB2VFEpQsxsYw
	9G9J/U7aTFSvv/s6dtuoH0MHjsAQBL+YGdSfBOUYn2GcXrmYno02IJgDOFnmlbbQyChs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGfb-0067Av-W0; Fri, 05 Jun 2026 00:36:11 +0200
Date: Fri, 5 Jun 2026 00:36:11 +0200
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
Subject: Re: [PATCH net-next v3 13/13] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <1a530f22-9534-4e21-a55c-9ba160f782bb@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-13-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-13-5debdb3173c4@analog.com>

> +	ret = oa_tc6_write_register_mms(priv->tc6, OA_TC6_VEND_MMS1,
> +					ADIN1140_MAC_P1_LOOP_ADDR_REG, 0x0);

Looking at this, don't you think it is a bit odd writing a _MAC_
register to a _VEND_ MMS? Having consistent naming will help spot dumb
typos where you mix up registers and MMS's. It is an error i've made
in the past, and now try to make more obvious by using consistent
naming schemes.

    Andrew

