Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850814252BF;
	Wed,  1 Jul 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934395; cv=none; b=CcOPCwhwutJNWg/8uxMwrCiLrbQPkNcy2by2y5/gE3DCdtOon9QRTsR3RjiZLkKDg65N4DeLpQATNktHwTfjcXrSa1UxiGObZENh+c/pQJox2NmS81GX/Zd5R9p9n3XTcOk3rIu7DmnhIunLGibUzd/iDFdzZvwpDjPre8w8eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934395; c=relaxed/simple;
	bh=VgWJ83UthhnAvdr5Eoj2uXpaRt7ZDKNwQ8no4cpjcqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH7iYlg3uBG2191prMMv7XeStmmEmJ+kRav5dqev6oVUyl370U7zpejvJSyYM8kJgAj6tJtmYVNs6NeQEuV2cTX5pnQiTbZb1rmFSpKwBccyTGarJvW4mgyRoPmeoUHxjo2x0/UbXCUKVe7DOOpKSpIkwMFQIAKmW/FYvvkICAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhLYFGI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhLYFGI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB78F1F00ACF;
	Wed,  1 Jul 2026 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934393;
	bh=y4PTITJeaNIkozE3meEc+/LOStBuvpZ1F0k6rTLYgIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MhLYFGI/EzKuP0AVdYS4aO1EMqKxNLXd2UtHw+U00joiFOhrJAEyjvIl0cvJ6T6Qg
	 fW5ng+J7F6CL6oYjPneYixOL0SNKMctoP/Q2wnskcH0qzocOhKL93CfIH1NJlFQvaI
	 E9Mfg4QqkMhtKDhW2CxtmLPxDJQvJ19SOn5+5NJUZ4xgajSqShtMk2Q40EUfwf2CGi
	 jeOK6uIld3FhNMt6Az2A5lj0hPSwl0M0Fpti4OPF49D9Nyq9bPYBXBvUmEeZoz2sF6
	 lgHBrjryZeYyqieAhnFf60lYg8NPtmjrFnD66oSKqaK6hF0Y+GgiBlCF3EsUG7zL2M
	 ekVorbgfO2pMg==
Date: Wed, 1 Jul 2026 14:33:11 -0500
From: Rob Herring <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
Message-ID: <20260701193311.GA1402559-robh@kernel.org>
References: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
 <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>

On Wed, Jul 01, 2026 at 03:11:07PM +0200, Louis-Alexis Eyraud wrote:
> Regroup the MT8188 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Note:
> The `#clock-cells` property is a required property for all compatibles
> declared in MT8188 clock and system clock dt-bindings but not in MT8186
> ones.
> To avoid ABI breakage, conditional blocks to check this requirement
> for MT8188 compatibles are added, rather than enforcing it for MT8186
> compatibles.

If the existing DTs are just wrong, then I would just make #clock-cells 
required. But please update the .dts files so the warnings don't grow.

The grouping I would do here is:

- clock controller only
- reset controller only
- both clock and reset controller

That should avoid any if/then schemas.

Rob
