Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF712949E0;
	Tue, 14 Apr 2026 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185084; cv=none; b=kmD9CmPaBbViv3rx0sD4siqF5lvfP9xOcVbjUtRqucu1MOGMYp+39qr3U/ImmMJXbG66xdKuW2n2BMgZHySrnWlEaAYyGniXOltTyvIdGktMXf+igInR41LmDAcob1+j8p7/HVDUfocUb6v5jQrfrSSWeKyvLpe0dVXhZO1WABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185084; c=relaxed/simple;
	bh=JHHZyb2azwc6UMLJsUH6MvpF11bh5FdFdSawhVoZ7qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6VamhHNlUYQIR0nFwBvYEb9rbWiVLkI06Y2KsLmoR0ODVL7HvrznD/XfmXzkH91N1Ke0lptgCwEqKw2JvSIY82DKgNP9i+fH81fI3MaKd44hhpMXBPKAS12DS07J2HnTbC/BG5xQqPQhwzg28+0d8ezpPyqr79uqbGqJHO0QEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jg1JabnE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jg1JabnE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3a0DWUaoW/JnQkGYGDLAFuXtJNUitULf7loQyMk66lE=; b=Jg1JabnESm66jdatAdoWAMVbtA
	sEY/2zVnDTmwex5xzg+DQybfLyEI8h8Lbt8BS3n12WxfGo9AYC2DgqC7Y2viak/wTiZUEruLM0JUJ
	6JyDECQaaJd3DIn88Dm7184vMKx3kmxlDDhTMzCxnePLVfH5T4xa9FKJ8bvncXjfwnfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCgsS-00G4so-AK; Tue, 14 Apr 2026 18:44:40 +0200
Date: Tue, 14 Apr 2026 18:44:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: fix kernel-doc function name for
 pse_control_find_by_id()
Message-ID: <7c20e672-c169-4d38-a617-84f9ad3fb5c2@lunn.ch>
References: <20260414150948.744618-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414150948.744618-1-kory.maincent@bootlin.com>

On Tue, Apr 14, 2026 at 05:09:47PM +0200, Kory Maincent wrote:
> The kernel-doc comment header incorrectly referenced the function
> name pse_control_find_net_by_id() instead of the actual function name
> pse_control_find_by_id(). Correct the function name in the documentation
> to match the implementation.
> 
> Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
