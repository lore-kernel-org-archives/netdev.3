Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586688;
	b=5gU8ge0BHHJs4fidUo9DDuNxOoh3+4z3IJEjFvdkDjnChOOJdEQMZ71d3q8XKzZYGoUC
	 A6yPitYOuJzJ93ytAOqIdtHYaqBZbwU8TKPBUDf5YYAphL/RroKXoO4QNgxjNdQjw36rS
	 xAp2L464xuqwTCK/+hs40rrNJ18+fZjXqKO4iOoN9OIzgQh9svchUQo3jT+PHVTLGByz/
	 4wWegp0vGLT3VAAc31/ybIKVpR9Rb7Irki2WS09ewwKMJZxrs0uBSx8ylsQgZuP/Oe5d+
	 5WMdgGE34nBMrqzY412UpWhNj34+4sDgdevIMPMRttrKIYf4tDOAZKguCibW8/suoHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586688;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NbUxAF4+fhGaTwU6SyGGMBBPCIGMBSiSpExMIJK1rcE=;
	b=vOmbzvRIt6xE9VBXcxiJW36NlY6pTt3yjFFLQZu3Ej/0xfle2jsv/Jvqy/nNOGJXjJwJ
	 XZGtMty/8aMd/EzZla7ZBnwjFDOWHkOniw1o5mqCCyiV/WTZgfGJ5MbHVn1Ix1VvtcJOC
	 6pPnwdRjwA0jWW5+y639kLxaMUet8dSrxYoVeAjpZAhjKE1t79K2uicQzHyY/6cDqSiIB
	 kIVCY5ABQxsPgx6c/BVkeYfoYslTOD+VR3E9RRgQefzeTJhSLLyomBVChLONelsVk8DQ8
	 vOYs2CkpKgf2Hg58XTSeqofFOgKVj9ozHfj+cC4QeuXypLjjXhggD98spo0cRPxKvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YuDfAoht;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9D606A31D;
	Wed, 21 Oct 2026 12:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=YuDfAoht
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NbUxAF4+fhGaTwU6SyGGMBBPCIGMBSiSpExMIJK1rcE=; b=YuDfAoht/p9qIU3gcRDo1zQNIE
	ZJewm00U8PJGJBWrNWIxjpN84vJBt1FRbw7fyx0Ar2B1AJmeukQ9k+kZNYws/CB1pu3y14Pmpu53S
	JvCAhGDlO+aArpYaGHTFVQ2Vc84oPDyfJEKxJr8DQJZV5AnBdWVmupbXFYHvV3A/NdZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJVg9-00C5Go-1v; Wed, 21 Oct 2026 14:44:25 +0200
Date: Wed, 21 Oct 2026 14:44:25 +0200
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
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Message-ID: <838136c0-5f4c-4ed9-a0dc-d05ff338582e@lunn.ch>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-2-25daf2bbcf35@collabora.com>
 <b4950f82-0163-4482-9799-a5e3c6eb5964@lunn.ch>
 <c53928fbb9da11b0f32a84592742e6a26e1aed32.camel@collabora.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53928fbb9da11b0f32a84592742e6a26e1aed32.camel@collabora.com>

On Wed, Oct 21, 2026 at 11:43:39AM +0200, Louis-Alexis Eyraud wrote:
> Hi Andrew,
> 
> On Fri, 2026-10-16 at 17:40 +0200, Andrew Lunn wrote:
> > > Finally, update "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps"
> > > property
> > > description to add MT8189 RX/TX delay stage divider values, as they
> > > differ from existing supported SoC.
> > 
> > These should be mark deprecated and the standard rx-internal-delay-ps
> > and tx-internal-delay-ps used in there place for new devices.
> > 
> I agree, it makes sense to use them to describe the RGMII internal
> delay configurations rather than the two existing vendor properties
> (mediatek,rx-delay-ps and mediatek,tx-delay-ps), and deprecate them, by
> adding a deprecated flag and the comments you've suggested. It would
> also need an additional patch for the driver to handle them (while
> keeping backward compatibility).
> 
> But what is bothering me is these two vendor properties description
> says they can be used in MII and RMII phy mode cases. The driver uses
> them indeed also to fine tune the RX/TX_CLK (in MII) or the REF_CLK (in
> RMII) configuration.
> rx/tx-internal-delay-ps properties are limited to RGMII only ([1]).
> So they can not substitute them as it and with their description it
> would wrong to use them for MII/RMII.
> 
> At the moment, in the upstream devicetrees, there is no "mediatek,rx-
> delay-ps" use and the "mediatek,tx-delay-ps" use are very few and only
> for RGMII phy modes (either rgmii-rxid or rmgii-id), so no MII/RMII
> real use cases.
> 
> So, how to proceed then to make these bindings right?
> Use rx/tx-internal-delay-ps properties for RGMII and mediatek,rx/tx-
> delay-ps for MII/RMII or do you see another solution ?

If you say "mediatek,rx-delay-ps" is not actually used, then it is not
an issue. As for "mediatek,tx-delay-ps", i would probably ignore it
until somebody actually requires it for MII or RMII. At that point, we
can add specific properties for MII and RMII, and not mix them up with
RGMII delays.

      Andrew

