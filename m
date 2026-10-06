Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0E4A0148;
	Tue,  6 Oct 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303761; cv=none; b=dXGcvLY7TNpEZ0Ke9eAGykFCtGgFN1kcebyj/rbOZTIaCcgOQJDuC4IF1C+jNMtrJjKJ7O+3mQECWRfEs57wGZqhLjlBGZ3CUcWOYtSWnk0e5/8vcF7ZyUHJ3vJZRQxCQxBnUoP4/guEYuPJmCnGG4KOCqq9ObFTrVacc33GMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303761; c=relaxed/simple;
	bh=zwdlM9mYLWiXKgxdorfU2tvLt76yOgS9pj6Z1fc2K8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVwvW9Ga34/vghhrVx1nhiRcz5QRL8jpPzmRLNxVovz8biq/DboVv9/EebjCxyapA8G4YgiV3WvxGtf6Y164CxKCOIlkuLBSVey5+X7v0uNzPbnuJ449YnJ1hiOB0yq0g5d1zP+liXm2S/ybj610CDKbcFq9TbotLQmhYQjNdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=io5Vrcex; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="io5Vrcex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iVpjNVuw6yuuQV0ozXPyk2bja1hxYcxxeaUxuVF7gGA=; b=io5VrcexvaWR6jAz7EK/6PJihX
	iGIEAwpoRo1q/EzgVoL138wGBViP5WuL0+LKR0dbqmKgk+yi9rhfe+iYmZc+wpcEMiYbnxCsrFEv3
	8oxohb/HB6BAgI6V9oMnECn616PJ5d+nFLL+tIKQc1DpGR7yoHBd83IgI7KbdZIWGD9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE7vv-009IRC-Pv; Tue, 06 Oct 2026 18:22:27 +0200
Date: Tue, 6 Oct 2026 18:22:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: ftgmac100: Add AST2700 compatible
 support
Message-ID: <68425269-7e99-47a0-82a9-f12bf8835def@lunn.ch>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-2-36de51fb8066@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-support_ast2700-v2-2-36de51fb8066@aspeedtech.com>

On Tue, Oct 06, 2026 at 03:20:40PM +0800, Jacky Chou wrote:
> Add match data for the Aspeed AST2700 FTGMAC100 controller and wire
> its compatible string into the OF match table. This lets AST2700 device
> tree nodes bind to the ftgmac100 driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
