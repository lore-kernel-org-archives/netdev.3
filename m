Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A75221E4;
	Fri, 18 Sep 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760785; cv=none; b=FjCrR6DZvvNZUq5JH2K0kh09KNR0gQjYXDayVfFXAiRyZQYBKOBW2ViRGySpFBhp1xepuBq3PySLDgHWlKf70eEKrHVwHoVTxFVZzk/g5QWdIGzb4GsqmFhJ86QHRLqAtHP8KTLRxzaCT9ZskpfwqYK9Nmxg89QZDG4AqX5mnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760785; c=relaxed/simple;
	bh=f0JU1pyxHZVmz6TgK6400JtLaWcqGYzGch+FcIDdcKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG9U7wUspVStgBsLY6410QCm36s95BBXjrwbElNMliyTfN3VZxmauwu7xvIHMYcEQ78XOL+ytxzPlbpAH0Ru6aDFpyniViNmvGHigmyCYQcKEGz/3j4jr0mJpb6nUqaYGpzzIQ57XTQ3iFtrhj7pSyGeB3UsJRGWIBcKff5JtgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCgqvQSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCgqvQSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136491F000FF;
	Fri, 18 Sep 2026 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760783;
	bh=0xKONjRtCurc8WbnVsXxctUnGulmYkSraLp8ZuykmOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCgqvQSgcziEjU4PZtqtEprTy6iKuFyOEE9BW3tqy44D9VL04HVsRwqvwKmKyGPZE
	 NwXHSur8WSM1IPdNOmQP+APLeUJ1RgNieNoT1ANmj/YhATUjVAcPfRgrYZM7TZM+N+
	 bMcfMFu0SMYn3hjJ7O9KN5RVCaf7IcpOhjjBsP+dzV3ywNB7ghaQOrg8gutdNiu1k0
	 3CNauiux7L+ru4TiIBlqXV3+OrXmwOHNXonb0u4a1KKeHVKyatPX6HGHjJif/WeWei
	 deOCnWZK7ivR8UQYr8Q9r/ovO/8j6VpqEaUN+qwysGhODUQPRDPqCsR7gIx3J3phz2
	 s2ZawkkrqOC2g==
Date: Fri, 18 Sep 2026 14:46:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ricardo Pardini <ricardo@pardini.net>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, nic_swsd@realtek.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: net: add Realtek RTL8125 PCIe
 Ethernet
Message-ID: <178976078089.1640411.4176382061491076376.robh@kernel.org>
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
 <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-1-c1b9e5f10cd6@pardini.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-1-c1b9e5f10cd6@pardini.net>


On Thu, 10 Sep 2026 22:07:51 +0200, Ricardo Pardini wrote:
> Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
> controller. As a PCIe device, its "pci10ec,8125" compatible is the
> Open Firmware spelling auto-derived from its PCI-SIG vendor/device IDs
> and is already covered by the generic dtschema pci-device.yaml. The
> compatible itself therefore needs no binding to be valid.
> 
> A dedicated binding is needed because board DTs describe these
> soldered function nodes in order to attach ethernet-controller
> properties to them: a placeholder local-mac-address that the bootloader
> fills in today, and potentially nvmem-cells, phy-handle, etc. in the
> future. This binding references ethernet-controller.yaml so those
> properties are validated on the RTL8125 PCI function nodes.
> 
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---
>  .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

