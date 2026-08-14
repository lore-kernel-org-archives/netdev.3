Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516222D4C3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731278; cv=none; b=h/5OT8Sg8E+W49E18ZfP/8BVRpBJVIVNwGIGz+CNuEKCdZBNnPrv12wo7crnSvbE8lfgkqmi9djQ0fT74l8z4H6BJiX18O1jiCWo+9AorLhDvOwTVVm2aZVcuz8dnPn/ZlNMQhFg6b7bJbJ7Ehz1sulfDUfYKvaCij+CSHQrUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731278; c=relaxed/simple;
	bh=539GFekKso4IzH4GQgDQR7Hemf53nvVWDPkzrRB/HbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP1K+tilcddvC3ZHEnwuj6Z3Q7+Y9fk0vIQtV4g0Ynq5+AT5RyYRaSMuf5tKMTMYW4qpqLy7XzelqdwgC6h4pQCp2jPjYb2tHKOlgh72PLYezMZWV0/ipj4zYO+wEPPiufodSaaeCQl74t5FUY1eqq7LsyOVjyrQRimgEKV3qwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1cZhFKj/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1cZhFKj/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dlEancBZZ/DpiUYoTFT2xqkCRRtzml5jJ8R0d9o2Dzw=; b=1cZhFKj/oiuYEQ1Mjy7rUVZhCb
	ldn1CpEbC5sAf9APOUNFOoraY1HJeOsedGSuhoA0QsaIn162Ndd2Z5Rf9ogmuzRG+pWmezlnf1aPh
	PqulMvyG28/1aeyd8bdj6YP/9zLXFBBPsMatWx7UxoUqG9Y1dDIsJynLNAB/NYZHxzC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuwQL-0001Ch-5f; Fri, 14 Aug 2026 20:14:33 +0200
Date: Fri, 14 Aug 2026 20:14:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jonas.jensen@gmail.com
Subject: Re: [PATCH] net: moxa: dispose IRQ mappings on probe failure and
 device removal
Message-ID: <6ef3e59c-1fd6-4c75-aa1e-f94825a97cf0@lunn.ch>
References: <20260814175404.1616-1-diegomancera.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814175404.1616-1-diegomancera.dev@gmail.com>

On Fri, Aug 14, 2026 at 11:54:03AM -0600, Diego Fernando Mancera Gomez wrote:
> moxart_mac_probe() maps the interrupt with irq_of_parse_and_map()

Since this is not a devm_ API call, please do the cleanup the old
way.

    Andrew

---
pw-bot: cr
