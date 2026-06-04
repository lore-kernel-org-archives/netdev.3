Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D8199385;
	Thu,  4 Jun 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611596; cv=none; b=OTg7HJnXWk06npYmv8kiANGx7jyOjFB64j9vudts0n96Qb7Nvgjfx5kQSVZxMhR4QCUPfjTFDaus7WwHV4Q4tAtMkCVKTEk68jqAmmQEn9wrZ4f/HgcfQ2UCn/P1ROaVEriBsDKgMmonQZrYpZdT/LeLD8XqYpqxiOMKmufCp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611596; c=relaxed/simple;
	bh=RCezTokjlwEZb38ukZHBiPENnu+be0E+O+dGCmtFjjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbWL+O4WSXUd2+qHZtdDLf9vZO8f0ClPIFEc/qmzPw4hVPUi5Aj3b1iOBBZx7cnuqaKLZzbUn/+wkHxTQAlHoMmGqUamFw3FuD+FhEXVsRUWp4+agvMaQsY/8rAjgdFtF/T6WIZAgbeDC6uWjK1oiox2T/ZGwhE2SHGOwGMN1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KQxj3FQq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KQxj3FQq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=th5HwyM4KqToRorN7NKA7w5ePOpvufNbzkFA1UvDLjg=; b=KQxj3FQqusEcAM6iNIw3UYprw7
	uskHifgDPFxiim+hVOqvZHXhsFhgpQTp67bfW3Y7e+XDJ1DHMgwBpmrZ0NEOWE1xP4MIuHo6M+Loc
	acbdIdHZdz5CYa3HLlV5V8/nfPwBTEUEeYuOelz8Pf+agSU6vm3MvsSmtlCW5+MvD900=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGPa-006729-5J; Fri, 05 Jun 2026 00:19:38 +0200
Date: Fri, 5 Jun 2026 00:19:38 +0200
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
Subject: Re: [PATCH net-next v3 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Message-ID: <905f32c3-9638-46e4-8f52-1bc874f4e8b9@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-7-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-7-5debdb3173c4@analog.com>

> +/**
> + * oa_tc6_read_register_mms - function for reading a MAC-PHY register in a
> + * memory map other than 0.

Is MMS 0 somehow special? Does it not work if passed to this function?

I'm not suggesting all the current calls are replaced with this, just
that the documentation might be inaccurate?

> + * @tc6: oa_tc6 struct.
> + * @mms: Memory map selector for the register.
> + * @address: register address of the MAC-PHY to be read.
> + * @value: value read from the @address register address of the MAC-PHY.
> + *
> + * Return: 0 on success otherwise failed.

Isn't the "otherwise" actually an error code?

	Andrew
