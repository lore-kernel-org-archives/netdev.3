Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3812472A2;
	Wed, 24 Jun 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316080; cv=none; b=eXErbxNooOehQcCnOy2uWwqI0QGwzPwjUJC4QB8g5KbzZ7Qf977i6aoC+9wi3nqmigCV38lGZLgWMea23rmE2bQ00l2Fag2F0VNKKP/rB/bC5V5cbY+UhIgxHIgxH6XUSbaNqBdDoSyvmKkPYjTZHMJncaCh/mO0lWmY4lhokQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316080; c=relaxed/simple;
	bh=7J2J/dLnlRj4aSjmO5v7bgI3Ux75gRq7GNoMbOqMS/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBG738nP2FEcrw7FaB/rOd3lRAYPRC/kmzoZAJwsn89g/xFlxBZDifS1kpJlnvGrtQmJ8LNMbyZelAlSra4FmKih8NkjbFJ/8L3wpLnOilA73RoLkOMdCa92keZoQJSJOo9pBEu2h+u2iFiW4sZHZcPjO6ACt7KiGX/AYYA7K94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N5zaSFjY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N5zaSFjY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t+KAQaFyheAN8Ki0OI+yBZfJ8T98Ct8ygzCe9SARqCg=; b=N5zaSFjY4oSHxOBsCCqa+LLd40
	fZFYNT7CYhx1TgytoRFGpKgdUgLqhQyH1gAJI+RFSM6z9Vpj52dqvdx2FszQuyKBPM0Qfp9K534WF
	SUtZSDbBcmGM/fgGBS90CnS4K5p7L6ey4Vsa+WHqIUQn2RSJaOagsmH9NufV6UaSP600=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcPpM-0096zD-Jc; Wed, 24 Jun 2026 17:47:48 +0200
Date: Wed, 24 Jun 2026 17:47:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: renesas,ether: Drop example
 "ethernet-phy-ieee802.3-c22" fallback
Message-ID: <7272ced5-c5eb-46cc-acd8-168b694d526a@lunn.ch>
References: <20260624150250.131966-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624150250.131966-2-robh@kernel.org>

On Wed, Jun 24, 2026 at 10:02:50AM -0500, Rob Herring (Arm) wrote:
> Fix the Micrel PHY in the example which shouldn't have the
> fallback "ethernet-phy-ieee802.3-c22" compatible:
> 
> Documentation/devicetree/bindings/net/renesas,ether.example.dtb: ethernet-phy@1 \
>   (ethernet-phy-id0022.1537): compatible: ['ethernet-phy-id0022.1537', 'ethernet-phy-ieee802.3-c22'] is too long
>         from schema $id: http://devicetree.org/schemas/net/micrel.yaml
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Fixes: 37a2fce09001 ("dt-bindings: sh_eth convert bindings to json-schema")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
