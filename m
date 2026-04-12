Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54997239E75;
	Sun, 12 Apr 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775953515; cv=none; b=Hct5y29Cn3xC5l1CU2iD7aN0B7N59Gz/fQRZXC1RMfeDFfVq4G+XSzCq/PQdB85J9tHJIC04WLAyG2iAIG7VdsxO031FEi22BzPAhqkpGflUDnNbq2xC+wycXb4sMb05HMbCi1Ma2Bp94+qwfyZUK8PAFteHj1n1u+jtywAOiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775953515; c=relaxed/simple;
	bh=jC+7wE8oC9xbk+dHMqt+gP24pzKu1oVB11qgrU0Vvww=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=IiTpPwS1MSb6oaAp1j2uuj54EaJOzEt5AbnNsfEfYWu6YF8S2O70pO6JyoihxB8quuEMxioQG5g7OZlFmnbDXE8AF5SZpWPo+EhxPRCWWp8Oo9GDWT96ac67dSuy7PFFOIV+0RoY8hKRV6tB8XQTYBVH1ARFDjAqkplwpcHPkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRMDwjlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRMDwjlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E5C116C6;
	Sun, 12 Apr 2026 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775953515;
	bh=jC+7wE8oC9xbk+dHMqt+gP24pzKu1oVB11qgrU0Vvww=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GRMDwjlmc60AlAZfLY/n5TPWlzxmJnp5nk31S9gkaQ8taO/cSeBIaOy4C4D4fSzxu
	 Wzes7GaYSdbwURm0gVNSDIvQtPoSTaccIi2+kMUoP65SAskZ4JUy1kRj8z+AiAL9+G
	 7EAN9CYiy2/DHGka7a3cjNDm45WnjGHOltNc/+1+pWZkPTe6O9uh0B5Gfkq7j9sFWv
	 X6yj8WwLc5COS7w2So+ItoUKMtr692KlRd/bHOUPkaxyeNF6rVm2Nb5XXjkCKbrSJG
	 PRAV8TFHaYU2mCt61YeFun2FVk0q5qkSnWS6xqYzbq6/K6bU7umUFA5Le/ZloMdA/h
	 +ROCp761w1DhA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c6dbf9b3-3ca0-434b-ad3a-71fe602ab809@gmail.com>
References: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com> <c6dbf9b3-3ca0-434b-ad3a-71fe602ab809@gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] net: phy: make mdio_device.c part of libphy
From: Stephen Boyd <sboyd@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>
Date: Sat, 11 Apr 2026 17:25:12 -0700
Message-ID: <177595351299.5403.14005254929672297956@lazor>
User-Agent: alot/0.12

Quoting Heiner Kallweit (2026-03-09 10:03:31)
> This patch
> - makes mdio_device.c part of libphy
> - makes mdio_device_(un)register_reset() static
> - moves mdiobus_(un)register_device() from mdio_bus.c to mdio_device.c,
>   stops exporting both functions and makes them private to phylib
>=20
> This further decouples the MDIO consumer functionality from libphy.
>=20
> Note: This makes MDIO driver registration part of phylib, therefore
>       adjust Kconfig dependencies where needed.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
