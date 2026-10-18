Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D64AA025;
	Sun, 18 Oct 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339938; cv=none; b=syWKBbAdslrVQ+Vgzu9L+co6lTStgDAL+bf44ERavoG0UtrqIAoYo9w7Hg70rC7PlHsYvdc0wO6E0zoZYZU3xcCRnjDBsh/Gk5yxmw+0E+9bV79yO491tRYOXnT2e8X8pFMpjW47qdN8luGzihRt2f0VO8AfqA2S2RvQxVjh8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339938; c=relaxed/simple;
	bh=j+P34OTgRZmyJBliuSowTodnxOQYeoFxtRANKObsnzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHo2kOc0GZ7ZjUNs2WibRolhX2NCMPtMpFXmGax42YUEUBqXVlCWFv59cwgKkorXKN1LWR1TjieX4zP6fgGbwJ5efmHh6TXsy/akfx20zYW9FQjgza88VT48Y9azcL3x9V/m1fggXMYXGdN3Kb/DrOP116xA7cO8tcWfER6i6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cX53IbJ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cX53IbJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aKaWml01mI+Gac7c/T+2YdJumeAC/8G1FF4GRIudMDE=; b=cX53IbJ93YP8MCcW1XFZCuRY38
	NYAcBVL0khdLDU/HL+NCIjwTuaGAXZqzZajNQOPBRAcq2Sjp2+hzgCelSL3H+LabdgLXSiC014SOb
	ZeaQYWSIzEotQU0KYge7e3OwD5q78IbDNCTNJBW8IeCoY80qCy0cgRf7OIefJOPEReAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xITUV-00BVUj-Jw; Sun, 18 Oct 2026 18:12:07 +0200
Date: Sun, 18 Oct 2026 18:12:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: Re: [PATCH net v3 0/2] net: usb: lan78xx: do not use uninitialized
 data after short reads
Message-ID: <f9856a85-199c-424d-a100-ad21af6b9236@lunn.ch>
References: <20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg>

> Changes in v3:
> - add the missing Signed-off-by; no other changes

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Maybe also get your LLM to read it as well, so when you ask it to
review your patches, it points out you have not waited 24 hours.

    Andrew

---
pw-bot: cr
