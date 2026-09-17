Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152614DD3BC;
	Thu, 17 Sep 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647312; cv=none; b=DioVsQvwsBBwbKxlbOMNWBDs7bawh88nJCQgleSVpputYuQkBKG8H+ns9oQg43B1RWMZHYuEfLOCUpeXUdanl4kLywsq7aGMoFs/fY7f4cyj2gf7He3EBkJ5UMl6mwXMcg1+OVxVEfoW0owurvUDCNKi0W1y5BjTjG36svp9vVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647312; c=relaxed/simple;
	bh=XZGVavnwaFL0It63Xx6jKVVAXf2pxMq/hrcN/eiWIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA6ANL3EgELxxdOYSYeQ+B32jWzI2DZGNxJBq54GWTAgvScmZwPbTGTY18ScQhRpo42waiVY3VEW6V2/NnSmGR3Kbl5wuVV6jEDitudQ7cbKlAK8Wld20z0ANYV83Sd5bMgLb+mXEXSg0+pwXkjn2HeMPa7FPjWa+3iearjVQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A40Jocuh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A40Jocuh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=69XMdN05x83+KNeu44KdHInjfy0GjHMnzRBTJOl1JbA=; b=A40Jocuhhsc58MitCusEkAQYmG
	QdH8/ZdXYbgKLv61Vh4siRjg6pxfFAw0YeNqHxx7uN0aeRNLyk0PV6gqhW7xN0026e1K0bGGRKPpV
	3Q1PJXz0FyE4wMGFJtBMq5TuW31nAV4iA4MmJ7tQQmWWHz8PNI+lwN0l+Zax+TUGDcoY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7B0V-005fVv-RN; Thu, 17 Sep 2026 14:14:27 +0200
Date: Thu, 17 Sep 2026 14:14:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
Message-ID: <0845552d-158b-4c46-b984-c0ea18237eed@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
 <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
 <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
 <cc15edcbf76e8e70c89dd5ef5d838c3a@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc15edcbf76e8e70c89dd5ef5d838c3a@inf.ufrgs.br>

> Right now, firmware application failures are ignored, so the device
> can keep going even if applying the firmware fails. The TODO also
> specifically says to release the firmware on failure, which seems to
> imply that continuing without it was the intended behavior, and that
> releasing it was mainly meant to prevent retrying the same failed
> firmware application later.
> 
> Making firmware application failures fatal also creates a state problem.

I don't know this driver in detail, but fatal errors generally don't
cause state problem. The probe method fails, so the device is
destroyed. Is firmware download not performed in probe?

This driver does support a number of different devices. How many do
you have for testing? If you artificially cause firmware download to
fail, is the device usable?

	   Andrew
