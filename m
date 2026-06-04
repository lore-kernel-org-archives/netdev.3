Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8B3BBFBA;
	Thu,  4 Jun 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611285; cv=none; b=WosJATjzalXqInloxCVBBLMKjYZ5GMLeC1NLu+NLQJN6hWej6S7OIJlTf9vn44ce1L+zhsw28K+NEtnh8vl6M16eWOmT+7FCrdlcX2IHVNHL5nD8Gof9+1U6RFB+Lt6DJ7WnWTmSjJciPzV44VL6okh8dO32ku6pnYy7s5aFU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611285; c=relaxed/simple;
	bh=DJU3WwzHM/t/1TtfWso8Gs5DRfFWh4auZXPnHcgEJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3+2qvLouogg2ZNfW05yMblLblAy9CoLmTk5DAvAfICIEMwZ6eWn3L1BlgaG9mmwKa4ixHImkydV80zTJkr331214qLojNnr/7XPbgFHhyvjMvfa5fwoL4e9SWS7FasWpTmDWvlKbfLb3zbmWWKUhmG01X0a5omY6GNK9CtW6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1r3AjNxb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1r3AjNxb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oRqeObDIRluq87BQIlCpukh5tm+v+E13HSYTiQxf2BM=; b=1r3AjNxbviNojUCDosy9nyHGQk
	xvJQAs6y57I4dZoxse7BR4dcX42Mq8xODbhc9PbCUkjoYXcRCDYYEGEe9LC0UoCye20bRjTZBscoM
	MgiQWFro1NNpFu1QKK0l8xupm4rJWyp12JSX5PuQrW34eI8eLPpcW8VJzGNcV9XGwOI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGKa-0066zP-NU; Fri, 05 Jun 2026 00:14:28 +0200
Date: Fri, 5 Jun 2026 00:14:28 +0200
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
Subject: Re: [PATCH net-next v3 06/13] net: ethernet: oa_tc6: Add the OA_TC6_
 prefix to standard registers
Message-ID: <3016abe2-f9ee-48c4-be48-c6c34dbdce7e@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-6-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-6-5debdb3173c4@analog.com>

On Thu, Jun 04, 2026 at 07:32:51PM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The OA TC6 standard registers are currently exported in a header file.
> Add the OA_TC6_ prefix to the register address and subfield mask macros
> to avoid future naming conflicts.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
