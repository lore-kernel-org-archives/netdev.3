Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5E49D5B1;
	Wed,  7 Oct 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378384; cv=none; b=oJ/iYKJbrHT6kL2Eml2jv/imHzyamfG1m5h1yocnQacz6db/+INbQink9Qk6BsMOChx9ls+ekW/vgJbh80UnNWdfTp63ZoVrMostQ8fr9JrN+zatX2ikZ+qCKGce/HHGy+PKH/xgTfICZmuWBJqM2mSZ2YyKGnWMgepnNEG9dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378384; c=relaxed/simple;
	bh=4YJ9Fqv+a1prb8DIM4jaQKEQUeWO3GSzk37YSQ+zLO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRc6xb6vPPFUEkaYpDDTQzWh6po+J8EAQXl8C8paTTrez0kvGoFKOMZ7TGUF0+4+yocB84TimvDVnoIZ3KCmOWcN18nwEDY9FZbtli6YXNu34n+UBrddayeiRtxOaO+6NzumVDRqUKWC5khSI8wvQVOv+qxy8knGzllWHMbwBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vxCdmjaO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vxCdmjaO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dM8Ub3SEr1kn1ORAaVqDqRmpkV1kv8aYkI640BFSIsY=; b=vxCdmjaO7QZi+Fum3RHxWGGW/O
	f3nVrVz45O9O7GHhJuuD1yk6uNnxxTwSBzklwEg/niuUSTt0Ipxes2p8OYbLsTbhbWG2Z1ANWpMsH
	1JZ9L3YdexYCnlV9dajqVdpTLndChmSFUBehbecdg8sNwAbYViijrq6DaqpPNE7+LVPs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xERLO-009Scc-Ku; Wed, 07 Oct 2026 15:06:02 +0200
Date: Wed, 7 Oct 2026 15:06:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <ba762ae7-db95-41da-bb77-b72b85b68334@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-4-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007082627.63807-4-tanure@linux.com>

On Wed, Oct 07, 2026 at 09:26:23AM +0100, Lucas Tanure wrote:
> The T7 has the same ethernet glue as the G12A, but the controller
> reaches memory through a pipeline stage that this SoC inserts in the
> bus path. That stage has a gate of its own, which no other member of
> the family has, and nothing else in Linux claims it. It is therefore
> switched off as unused, and the port can then no longer finish a
> transfer.
> 
> Describing it needs a fourth clock, and the fourth clock of the
> existing list drives the timing adjustment logic, which the T7 never
> uses. So the T7 gets a list of its own with the gate in that place,
> under the name the SD and eMMC controllers already use.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index 90ef79161ab1..96118b4d1560 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -23,6 +23,7 @@ select:
>            - amlogic,meson-gxbb-dwmac
>            - amlogic,meson-axg-dwmac
>            - amlogic,meson-g12a-dwmac
> +          - amlogic,t7-dwmac

Since you are adding a new compatible, lets cleanly fix up the RGMII
delay mess for this compatible. Skip all the existing code touching
RGMII delays and add new code which is invoked when this compatible is
seen.

	Andrew
