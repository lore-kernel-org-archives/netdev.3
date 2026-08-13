Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235653D5C12;
	Thu, 13 Aug 2026 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614834; cv=none; b=sqGlDcuJkQj95Ir7rbcTj42e1KaEIrptNyj749WrHQ0KLh50AXHXC/10cvCNnvdOQ9PYy9J385QHUhRAiKYHJi8DfasdOZgc0E3UG6PF9XAxdGTlGOwLz6aOLzKSyASIvkDiXtOgf257UqgaowFDBCAslacUce259c8HdE7UoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614834; c=relaxed/simple;
	bh=ERkzY3XKRtOcgcjvoUldK5iT4qh/eP245eOV2fHJkD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKAk+tcCuKoJjE210dt9CEuYd2oDaS2kbVyvVJpPMI0w7r7Tj5Dtjl+4RSxfmBQvqzmQjbffQDFy8V8lbyFmG6F2juS+z6+o7Fik4ctEHn9yzlXZXu+OIJiiaVGK01nC6y+mcNWdDaMQVXgXtD5gLK46yJatMnPw+9s5bxpfJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx1JP6NM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx1JP6NM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF0D1F00A3A;
	Thu, 13 Aug 2026 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614832;
	bh=TkseypEzImRBrRzDJilNZepBrSFi084HZ1yLzXcIWeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qx1JP6NMpMy4Jx0QNf0LOsQekAR8GODiRq89TX0z1rVotr30r9AHh9AqS/uxPDwsQ
	 PbVQRTiFMiqYYsaKcQihSGIWqucsfgunLkObLDWorGLKpiOtI75/wJDc4hxPISvAaH
	 q8HCqiG3YEd7p4Q+5L6U0iw371hgk+3ka97zSeQd6ICyKAm9R3snYW7m/1O3+/Ck0o
	 bRJlbkRDOnPnB4OQpFFgE1J4lN7TDXNZClxSmhsM0gvd2QhORG5AzIhqq9F9cFD+OB
	 7/IeVPNZR8X5ZwWVT93/cRN2ziDc1wYombmpO2GoP67I2XoF6kfytqkSPCmwWL7HLn
	 0SZZnLFjVXsOA==
Date: Thu, 13 Aug 2026 11:53:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Matthias Kaehlcke <mka@chromium.org>, Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: usb: microchip,usb2514: document the
 USB4604 hub
Message-ID: <20260813-visionary-fiery-saluki-ef86b5@quoll>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
 <20260810-msm8974-onboard-usb-v1-4-08a805768328@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-msm8974-onboard-usb-v1-4-08a805768328@oss.qualcomm.com>

On Mon, Aug 10, 2026 at 03:42:35AM +0300, Dmitry Baryshkov wrote:
> The SMSC/Microchip USB4604 HSIC hub on the APQ8074 Dragonboard has its
> RESET_N pin wired to a PMIC GPIO. On this board the hub SMBus
> configuration interface is not usable (the bus pull-ups are referenced
> to 1.8V while the hub samples the strap against its 3.3V rail), so the
> hub runs in standalone mode and only needs its reset released, which
> has to be described in DT.
> 
> Document the USB4604 device ID (0424:4604, the ID used when the
> upstream port operates in HSIC mode) in the onboard hub schema.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

