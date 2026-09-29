Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213D347BC6;
	Tue, 29 Sep 2026 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646225; cv=none; b=QupCuLH6dYAp4AAOVnrj5EkVSM3oUN9YJJ1Np7DS+fUMCnNP9LI7pmMuXLnD6tbjswZIn9t09wlvDrQUwS3/jFwFV6LuGl/cone7NpQtFDDe3hHVTPb/0xsLAC/NsS6RCTSGCYvn5heSYrlilOwttqdq7iXnFI0T/v3evTCV+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646225; c=relaxed/simple;
	bh=ld3iXYqDW4M8pnmEg/C+t5BLBPkDC7wJiVxZRuIP0q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GC/KiiRxvsfjvt/zaqxVhlUCN4tJQp97c4yIvycxygx1UzTktT6j9yGpDUhibZMOFU86C3WtW5/opf3PgOZCWz9pMOZYhAvUbsi/yfkcuv+9MlXUTnxCKFwGKDVjvsVd5i1U6+J0A8y/X2yg0f7Pf8KXzyhsa/vPlNVzyxUKfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtwKUCxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtwKUCxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A971F000FF;
	Tue, 29 Sep 2026 01:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646221;
	bh=qCOyJgXNLn4t6nhstSaqAU+H6h/KyoanWz7Z/fkjkeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GtwKUCxjF2f/7J+ewptb3vuiKbKxstD5UOcWeWZ7msCi3LRBagExeaRtSjqLfZ3UU
	 nejRYh9257MRajfAaatS73+nHM/8GUULvg9ca8uPYi/PD1jZrQzXuwlV9kmoXCZJ4x
	 WYbM9kgCxQJeQvuzNGNKZ9zSy5jwhCVp0DwR/f6sKvnj1Sz0sPJDIkic/eyO2wU4pY
	 ZPlfOpEClKQZFQDndrFWstVNfA+GxQwz+X7kTvLcN/U3Plg/qBqy4W2AxwhMXyviM+
	 iDWNWJgjeZgfk0ulgpRlPKmUot4OCURk5Uj4ez7g2Ck1a8MiCQL6bDBbvBl5Pa/c8P
	 Gt2c0fu+Dhrwg==
Date: Mon, 28 Sep 2026 18:43:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Message-ID: <20260928184340.51da489c@kernel.org>
In-Reply-To: <179047973223.2160803.17475492528833274893@kernel.org>
References: <20260923021823.46649-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<179047973223.2160803.17475492528833274893@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Sep 2026 03:28:52 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] socfpga_agilex5_tsn_gmac_setup_plat_dat() rewrites every RGMII
>   variant (rgmii, rgmii-id, rgmii-rxid, rgmii-txid) to=E2=80=A6

Since Andrew acked I'm assuming this is false positive..

> - [Medium] The DT binding's allOf conditional was not updated for the new
>   compatible.

but from the info in the commit msg this looks legit.
--=20
pw-bot: cr

