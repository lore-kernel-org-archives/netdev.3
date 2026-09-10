Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5294A8A3C;
	Thu, 10 Sep 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064010; cv=none; b=B1pE0MohkpRbQv5hBptbs5DhmtW3z3DzPLJok/N1prsMgR4PAhQKkFi+rD/ZPeqimB7q2UpH77QBtYE8UmbExm2iWg5SR7Lo7NCiGG/CetiqYaX54lWklP5HPb5E+ee33IAtww8LKL0MczUiawujD8Tw0dzK2Qzb7rN//d0gf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064010; c=relaxed/simple;
	bh=IbmE9b9OB74FY/0QnStfNt5QpMw4tZTSd6BdfyhY2Cc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bisk0S1id41A7hmslYYRj4cZFzyEJoF7dEbLORXp2M6y68YHZPYjJc0nsEH9sQ+GuV66TgJ1qtzgqTt/e8vB6ApBXBxnJvGYcqpfxJin91RGknlZGa4Y0A2ybtB0ZE3rLoXAnK0rBJOjLp0WqaY6KBqsdpNzutksTV37mydbX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VI4/m9b8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VI4/m9b8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7980AA02B3;
	Thu, 10 Sep 2026 20:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789063999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/+pU6ZgQAiGZKGcKxP3SC863oMBmGRN04Vxg/9uCdkE=;
	b=VI4/m9b8+KveIb6M++Yu+/SnXHxT+c8vDBoisi18XKnjSogthyL85LHqFX8A7eHGZ9YLyO
	+hPN4bOayxcq4RyenVOcOtkHZZsZmxXAK7P9JvVqhFTUUUO7UVnRNsDMJYlsiPbP2CRRJp
	aWY5SCSt71jBcI8HXRBjyDlvehpSq17SX8799SCEujdBfBBWwEAGgC5/d8md8ekx8YKbxj
	xfCn3xXIFuESXtLdOIUDXkAw+nmkl3zfkltXhT+0w8glRqWiOfERpbmG+6ZSilUOPa0BYY
	YTFkIkpDS+je2IiDNtZH8FeYHBw57ta+6gQTUfW3jQ34eNhpDGUfyh1U6xy2Cw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:13:18 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v2 3/6] net: stmmac: selftests: Check the
 dev->features for S-TAG offload testing
In-Reply-To: <20260910151404.976753-4-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-4-maxime.chevallier@bootlin.com>
Message-ID: <cad778a3c7ad53119325ca091f879fc5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10.9.2026 17:14, Maxime Chevallier wrote:
> The S-TAG offload insertion incorrectly checks the dvlan (double vlan)
> DMA cap, which is different than S-TAG support. Use
> NETIF_F_HW_VLAN_STAG_TX to check if the feature is supported instead.
> 
> Note that this flag isn't set in stmmac yet, but contrary to ARP
> offload, this is a feature that has a chance to get there eventually so
> let's leave the selftest here for now. It'll report -EOPNOTSUPP in the
> meantime.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index a8280834185c..f3a533bc6bb6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -1405,7 +1405,7 @@ static int stmmac_test_vlanoff(struct stmmac_priv 
> *priv)
> 
>  static int stmmac_test_svlanoff(struct stmmac_priv *priv)
>  {
> -	if (!priv->dma_cap.dvlan)
> +	if (!(priv->dev->features & NETIF_F_HW_VLAN_STAG_TX))
>  		return -EOPNOTSUPP;
>  	return stmmac_test_vlanoff_common(priv, true);
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
