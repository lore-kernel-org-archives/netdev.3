Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CD3793D5;
	Mon, 21 Sep 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023452; cv=none; b=Q6eMA4vL+CQWeauSEjj6wd1WqmvfpwusXeTjEhOfx6C1dzc0sX8e73G1fH6H+WoTrJ3hYrReii8xo66T++Yg2vNWssjehC5nPjbReEZa57/tSf8E7XLXWCbYWNW3KkpZ6Xo3MBDIWuYpf58701szS9YpkYw+Usp9ZfounNGuLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023452; c=relaxed/simple;
	bh=8c+jErfj+uBNwgnYJNUzugDspvwBBvrUO8alXzftTSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC0Y9P8JRGBX9c1cVtNIg1ywmGVdnVcx4KEWmBO9eRqzfLjs/6fMHMxcc39HfQEobuYFugYk9VXt1BSrMftfNv2TlIcFy7xgEkyVIQrlxWqBWU8gYScZzmoZKeKpdHBlQfnDyyjMI3MnidaMUUexCcu/zF/i2ST+egHxuCepRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASIU3ya9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASIU3ya9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BABE1F000FF;
	Mon, 21 Sep 2026 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023451;
	bh=2G4T0MAWfyxwtdo4bQIzxWIk9EaFzA8n4tVd4B6WzeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ASIU3ya9AEqjh0TgaUFHTneshyOF8JcyNqC6qjhRySf+P4e1oLzWTERmhhS4TA9Qy
	 S1c6KSAEbHoTp+V0PNCA2K0aQLqjp5vZU6TlG87HDkHN7w2kMHKX0uycI5RmMTxkF8
	 cYi4/moQoOzVByogBDPqkRoKweQUrgje6uHCpA57c7znu6veEA04uBhRHpj7cA/0Dm
	 4GQEMw9PkFlWjVW3K6lmM+DpJgKZ2s3/A4nyZhBU0IqrYuUDFWTQi1zYdL5ke3Rm6G
	 4MyFxZBWDJzQHzwEdYFlGe+tk7eoHXjM2AUw6/d5lA6KxRA6udR/8+Y2qxHkyXIf8b
	 jnUzOI5r3o8ew==
Date: Mon, 21 Sep 2026 13:44:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v22 4/9] mfd: an8855: Add support for Airoha
 AN8855 Switch
Message-ID: <20260921134410.13a7173c@kernel.org>
In-Reply-To: <20260915123812.14747-5-ansuelsmth@gmail.com>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
	<20260915123812.14747-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Sep 2026 14:38:01 +0200 Christian Marangi wrote:
> Add support for Airoha AN8855 Switch that provide support for a DSA
> switch and a NVMEM provider.
>=20
> Also make use of the mdio-regmap driver and register a regmap for each
> internal PHY of the switch.
> This is needed to handle the double usage of the PHYs as both PHY and
> Switch accessor.

GCC spews warnings:

drivers/mfd/airoha-an8855.c: In function =E2=80=98an8855_mdio_register=E2=
=80=99:
drivers/mfd/airoha-an8855.c:438:48: warning: =E2=80=98-phy=E2=80=99 directi=
ve output may be truncated writing 4 bytes into a region of size between 1 =
and 61 [-Wformat-truncation=3D]
  438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus->=
id, addr);
      |                                                ^~~~
In function =E2=80=98an8855_phy_bus_register=E2=80=99,
    inlined from =E2=80=98an8855_mdio_register=E2=80=99 at ../drivers/mfd/a=
iroha-an8855.c:469:9:
drivers/mfd/airoha-an8855.c:438:45: note: using the range [-2147483648, 214=
7483647] for directive argument
  438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus->=
id, addr);
      |                                             ^~~~~~~~~~
drivers/mfd/airoha-an8855.c:438:9: note: =E2=80=98snprintf=E2=80=99 output =
between 6 and 76 bytes into a destination of size 61
  438 |         snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%d", priv->bus->=
id, addr);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~

