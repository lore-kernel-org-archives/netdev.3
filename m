Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531E36215F;
	Fri, 16 Oct 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184548; cv=none; b=LBm1k3tWU/yN/CkvAa8V4ZdPLSzj60iTqcB/hoLguadt81sGw/hPrk1u0ttBhwU8Ae+lpMWS+g8bq8RtTPYUTNoBlxQc17l6xJ2l/mOYyJ+2LpYW9fKMAApmpnhG5AvmUddYjXPMFhMuBWO1XJ2QgZ6q0ggdShRe0yb8XXNxUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184548; c=relaxed/simple;
	bh=BsB5dVBBbTUqF1SgLFU07VClvGySbZppOTm8ooenev8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6/gimy0ulgG61rJXdZY0miGDkqKJ/wikaqSFsrXE2jexCbZ0tjUEtyVLuyZh+2koW0aVsM4iovf9hW5m/kVjyt4SXlp6DH7QAk7gMZ8WQ0NaXVgC80UG8YyJHwZmCVKvod+eu6VWYv9k0wZ6jsQmu4UzQuEGP76GWGZxujkOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4kZXtyNZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4kZXtyNZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Zd+3BcJq9wM1lwqpTFXrmASNhXTBOIJ3TZjQBUIVa0=; b=4kZXtyNZ6FBLVI+lvThyNL2EWi
	141iNllT9KOx+xRJyv7D3YCrZ8g8olRUqvkO0QxTTvEk/k7lfSnVNv7akoN0Gz1M6RfRfj9edn2Bp
	+PAb8BQ23fEes5QI7bSGlGMJdgHN2qNSzwPKStWpaVvJFf8ORNeknKmFirmkBb0pxNPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHp49-00BDzz-Uq; Fri, 16 Oct 2026 23:02:13 +0200
Date: Fri, 16 Oct 2026 23:02:13 +0200
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
Subject: Re: [PATCH net-next v3 4/6] net: ftgmac100: Require phy-mode for
 AST2700
Message-ID: <8087213a-8cb2-41cd-a6f0-16da1e49bf6c@lunn.ch>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
 <20261015-support_ast2700-v3-4-8d7999171ac4@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-support_ast2700-v3-4-8d7999171ac4@aspeedtech.com>

On Thu, Oct 15, 2026 at 02:46:56PM +0800, Jacky Chou wrote:
> The driver currently defaults to RGMII when the "phy-mode" property
> is missing from the device tree. This default is no longer valid for
> AST2700, which also supports RMII via FTGMAC100_QUIRK_RMII_ENABLE.
> 
> Make "phy-mode" a required property for AST2700 and fail probe with
> an error message if it is not specified, instead of silently
> defaulting to RGMII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
