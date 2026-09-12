Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE93446AD;
	Sat, 12 Sep 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789217027; cv=none; b=Kj6ZEndHSHAMLesja3aJXRJIuegko3wVS2gQGIhZkMgTZwLhBS+g2snh1JsLkbc9R+dEtBqBNemx2Aqaec9tWmSCGBuYB3KEt4brWenu2Kzcl2fNK0uOM3fK4usOy3Ygi3cMB2yy56pkyBRjYA0PrXaCnNwJN7CqmzZkyqRzM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789217027; c=relaxed/simple;
	bh=Qx+fUKVt2xcgM4AXqeWo30ZvJHZ5oUe4mgCMZs2Ib4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9nP5d3JSUDBC8JAuNS1Ddfc99/Qgn5OFyQDgKwTO9ZtRtbZlnBB1G+neuKpo/zOasEPMifMZ+bVploBn1yBpj1/Dd0NKDedzKpzzEaEwI0esi0dSoPTvR8pjZ3a5dCgqhLVZgX99jMWw2R0GD0ezQoydXlVQoapLc+QoRMD7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xs/Q4DQs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xs/Q4DQs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Qx+fUKVt2xcgM4AXqeWo30ZvJHZ5oUe4mgCMZs2Ib4I=; b=xs/Q4DQsfVQAYnSajVZ9VPl5M/
	CO8s9jx0rE3iJiDwjN4CSU4eNZTQ5nWtNV5y6UynVokfabqNdfHdPb+YFFGuNDkmj12KY6kxC0nBD
	S8rkU+0f0LxMVAKcOnMjA6J6truz5dYt2ROSz/+ezYIPvXglplaIzEmcvi3pdgQyclzycHv9/ftaa
	tBd3de4pBPecLX34DTgaCYyTqh0c97URXySXHV9piVTcY1RHtpbNsWUXs8O023ynHxYzvru0nk6d1
	iJpsP0jJtjACtGNtxtqQ7u1lPpGZ8YnCFEsS4HIEFrSLLmbvea0bongXyNdVnlxmIG5bYEtROfayp
	EDc4CK9A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 ricardo@pardini.net
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
Subject:
 Re: [PATCH v5 1/7] dt-bindings: net: add Realtek RTL8125 PCIe Ethernet
Date: Sat, 12 Sep 2026 14:43:28 +0200
Message-ID: <1971659.CQOukoFCf9@phil>
In-Reply-To:
 <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-1-c1b9e5f10cd6@pardini.net>
References:
 <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
 <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-1-c1b9e5f10cd6@pardini.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 10. September 2026, 22:07:51 Mitteleurop=C3=A4ische Sommerze=
it schrieb Ricardo Pardini via B4 Relay:
> From: Ricardo Pardini <ricardo@pardini.net>
>=20
> Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
> controller. As a PCIe device, its "pci10ec,8125" compatible is the
> Open Firmware spelling auto-derived from its PCI-SIG vendor/device IDs
> and is already covered by the generic dtschema pci-device.yaml. The
> compatible itself therefore needs no binding to be valid.
>=20
> A dedicated binding is needed because board DTs describe these
> soldered function nodes in order to attach ethernet-controller
> properties to them: a placeholder local-mac-address that the bootloader
> fills in today, and potentially nvmem-cells, phy-handle, etc. in the
> future. This binding references ethernet-controller.yaml so those
> properties are validated on the RTL8125 PCI function nodes.
>=20
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>

this needs to go through the network tree I think and their processes
are heavily automated, so this should be sent separately.

Heiko


