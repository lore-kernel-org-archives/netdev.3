Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D33B2FCA;
	Sat, 17 Oct 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258790; cv=none; b=ecK5aY0YMuoLRGEMekn2EzpwwbLHv2OJNYnP2Pqwaxzz7JGocDEMKL7wa/2VFNXM/CpQbi87CFml8qP9Fhl/s5EBY8iTLuZ7zaboVaGTSM8SDukZFXMforGV1CDQcCnqtWVRB+PWQQlVKIIzpDdbRL4w1dYIFQtbRpAUs2rToJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258790; c=relaxed/simple;
	bh=BKW9ieMLcQJ9Ko3+eSZK8W4qLz2GntiOycxJB1eDVUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDZnuyrAgvAe/ZQ4mddLvyOR01udMlKKPn940uaSwWR83jIWYIr8C2ZPmhpsIxMLccx7jBtzKXyrUxDc77nzEbc54OAfCWBlqbnOSo61xDhQzQNFP2TcE54da7sFUwrqJUN58XXkuGTrNMKOcMOyASKlUlB/6/A5/+ZSATvasC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E0hKo2Fy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E0hKo2Fy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/3wyvCgF7xvp0uGxR/dqJ+LvnFcAl8T7SfLqaAeJ9Rc=; b=E0hKo2Fyr9kBeq4dGcwbVc5YSE
	6briuCcRfeFiHCB07U89czZciGFAhsWpSB1M4TKmpxHfdWuk8n8L+nfoafbdM6OMCNY/SHwozuKSy
	h/m2jy1RCJ8aYzFoWZa7i6nheTrzusNZflefORJuyWhQ+ywTHMAXbM0iJSLwMEnFiAhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xI8NR-00BMvD-PW; Sat, 17 Oct 2026 19:39:25 +0200
Date: Sat, 17 Oct 2026 19:39:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <84dec379-cfcf-4b95-95a7-e86b312c52ac@lunn.ch>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
 <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
 <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>

> The clock would be way too fast, on MX95 that would be over 33 MHz.

O.K. I've run systems at ~ 12Mhz. The steps where quiet big, and it
was unreliable at the next possible speed. I guess you start needing
careful design, balanced lines, termination etc for really high speed.

	Andrew
