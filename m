Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD249F108;
	Tue,  6 Oct 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303696; cv=none; b=FM4t7MFABLnwl2n+JsNw7lIgEolyAa5L+C543Dy7Xh5zcrl5HDz/iouLobzhD/cNdpqmFahp7Og3J75PFftoK0XdwYQ6Pv6WVgAh15FePXDjx/PCuQjzNVkae2HZ31C4JLZeZ4njRboIxa/XJgSXWCxiI4bSJLdYtN0zAERp4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303696; c=relaxed/simple;
	bh=693IUDjndX7GadnO/aWlphRFDyDRsPymk/xPj55qnRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7btBhIgpGjawUp5hAnPrFVTbf+4Q9dnSc3NA8de9Sy7/pq30SqlXwOX1Z3JmLYEWeLXEAXONpT+T07tNoFZ+9PB1n8GImXf/3LrIBky1Ck1dVitQ7ePTRJI7hLnWJG5iK31ZJWawJTSbUqeLBEUrXv82boQE9Z1onlsaRTEtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6PbOla8K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6PbOla8K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i6XgGqmN5Ywv64aPQ9FLT+RpZTN2SKS+BV5irIYdTTs=; b=6PbOla8KS71IKYNruIDEIfOVHK
	v/uN+9JznO5/xGGmZGnumC5P8CTOaaz6IRDQNpvIzb3Pj3Vp13tA4jg2m/yxK9XLUmASWDofP4zKe
	EKyrTOqFbv/0kcZYxRMrQp9ww/r2PLdPyVoq4oUkDBD9k5FqLhguMow66Id0C5VgOBD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE7um-009IP6-Ug; Tue, 06 Oct 2026 18:21:16 +0200
Date: Tue, 6 Oct 2026 18:21:16 +0200
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
Subject: Re: [PATCH net-next v2 4/6] net: ftgmac100: Require phy-mode for
 AST2700
Message-ID: <3e296889-3a08-4511-8a91-26e86a7ea500@lunn.ch>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>

On Tue, Oct 06, 2026 at 03:20:42PM +0800, Jacky Chou wrote:
> The driver currently defaults to RGMII when the "phy-mode" property
> is missing from the device tree. This default is no longer valid for
> AST2700, which also supports RMII via FTGMAC100_QUIRK_RMII_ENABLE.
> 
> Make "phy-mode" a required property for AST2700 and fail probe with
> an error message if it is not specified, instead of silently
> defaulting to RGMII.

You need to update the DT binding, mark it as required for ast2700.

    Andrew

---
pw-bot: cr
