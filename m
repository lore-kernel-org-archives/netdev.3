Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42362F659F;
	Wed,  4 Mar 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772584749; cv=none; b=afkoDKDE348reUd2r+MTQ/6J1iizUJlsSdnBi5tzxDRD0YkFV5s4y1PCA91FF8GKf+KkOgADsTfNkHyED84FFkm5h96vJelPYX5wV4GcylXWqGX3WUr/ZZPcWp8k01p8mhJsYZ+BG0crn3MLPmC9y6GjEqA9GFTDv1YPi1ZAYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772584749; c=relaxed/simple;
	bh=XfEFP0ePAMl9RzwdsncvUUKsnGIj/z2blRaooWlL5Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIeF2TJUmMC8VA1+cPYdo1jfhw+5bsCl3xHBuHxrqifDYfmc2ERqt3uqg8zRW4l47hvZGdGIfq8ykXowBmFA4Mg8HrwgUYCIxOyfaHu+pLakeR7DQKrAaPFxmQOQ6njWJ9A4T2lbbkhNvYUA4Bqz4MV+hs5rVNxi9sG50uM77gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiNKQDh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiNKQDh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46106C2BC9E;
	Wed,  4 Mar 2026 00:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772584748;
	bh=XfEFP0ePAMl9RzwdsncvUUKsnGIj/z2blRaooWlL5Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eiNKQDh0fZuPPjKMDEPIuS+QqGtWQgilLKQuAg75AM6L5IAQdrKv+e1v5OSDMiS4V
	 NjFXdg18P/JfxObT4XLpKOC+eq9uXsLq+X00iASe0P9aXIRKGY5wQ9cHFXAKSyhn9J
	 q4LU5cBLdUrCEsfPD7VOUKlVDz7qTX4vpDZuJI0bxvIwc3rJFsN7KgEx1GA8RjNTcU
	 MICIu13V5phbG0+fx/tDxJNXIIa1AKchlj8SKp5GZgY07BfNCLA3B7BCtKmpCLSy/p
	 Q7sM5stjqY41kVanYgSyZQnNiX6Scq4tGR4NTv+fdcInFHFVvpcgOLlqtpJw9zxzph
	 bekkRLrZY7Xgg==
Date: Tue, 3 Mar 2026 16:39:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, wens@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
Message-ID: <20260303163906.187d57a4@kernel.org>
In-Reply-To: <20260303061711.895-1-lizhi2@eswincomputing.com>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
	<20260303061711.895-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  3 Mar 2026 14:17:08 +0800 lizhi2@eswincomputing.com wrote:
>  .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 180 +++++++++++++-----
>  1 file changed, 137 insertions(+), 43 deletions(-)

../drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:290:33: error: assig=
nment to =E2=80=98void (*)(void *, phy_interface_t,  int,  unsigned int)=E2=
=80=99 from incompatible pointer type =E2=80=98void (*)(void *, int,  unsig=
ned int)=E2=80=99 [-Wincompatible-pointer-types]
  290 |         plat_dat->fix_mac_speed =3D eic7700_dwmac_fix_speed;
      |                                 ^
../drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:129:13: note: =E2=80=
=98eic7700_dwmac_fix_speed=E2=80=99 declared here
  129 | static void eic7700_dwmac_fix_speed(void *priv, int speed, unsigned=
 int mode)
      |             ^~~~~~~~~~~~~~~~~~~~~~~
--=20
pw-bot: cr
