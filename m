Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2544E038;
	Fri, 16 Oct 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164836; cv=none; b=qXWSF6ELSlgpjHFB45zLZ4yHbFRlR0pRsWcveEp6nQ13RUR0A2sHhGjhxJwcxb2K3+EMDiZUzMETBJcY8XHzlN3GhmoYatv4fwjwUtQnLXWt/9sD01g4CeYhTmH6si/5qiktd2kama/d4m31ISIH0UtUxigJAzhHX1dJB2GeETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164836; c=relaxed/simple;
	bh=ACb/A/N/k+W2fc77OHdNuLp8hyZ6PJq/jWa8i1jpu5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0AQdmKSPWS2Dfr/+8iPURE1VpROMP7/4XPPtEbOiUCrKVpjJ3VN9X2WSnmMIyvbIJXZiUm/fzbL8doyTnT57Y9bB87AyTEPKbu2KB+ncj8N0KLUHQbfThAIe/kiIt8wsY1VEhwR7t6ru4+u/prCcvXmm7E2+xBWfHjir6hfC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p43ClLlA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p43ClLlA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Of12R2/s6Y32nqdMblu5w/EJ2U82C1Y9iZtrzWl2jI8=; b=p43ClLlAXvrwzZYF3VFMYYYtp1
	MulZNOFu+FXdeWWlGCXD15G2to0kiVJ91U8VBIEk9U+L+awogmOX6qOt9ZX6+nbAH+U4wJttS8DbH
	bddjkx5W0RQAGOeV2O3FMNrUIG/K84Czya4QJSRqHmSUgfDQgogBOAVFveqHT7lTHS8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHjwE-00BAjb-1Y; Fri, 16 Oct 2026 17:33:42 +0200
Date: Fri, 16 Oct 2026 17:33:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@kernel.org>, kernel@collabora.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 1/9] dt-bindings: net: mediatek-dwmac: fix
 unit in rx/tx delay property description
Message-ID: <08b7abcf-a738-4ad8-956d-a6205046151e@lunn.ch>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-1-25daf2bbcf35@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-1-25daf2bbcf35@collabora.com>

On Fri, Oct 16, 2026 at 12:31:05PM +0200, Louis-Alexis Eyraud wrote:
> The "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" descriptions say
> their values are in nanoseconds but their names with the "ps" suffix
> suggest it is picoseconds.
> They are in fact used in both driver and devicetree as picosecond.
> So, modify the two properties unit description to fix their unit.
> 
> Fixes: 150b6adda6b1 ("net: dt-bindings: dwmac: Convert mediatek-dwmac to DT schema")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Maybe this patch should be for net, not net-next. Documentation fixes
often are. Lets see what the Device Tree Maintainers say.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
