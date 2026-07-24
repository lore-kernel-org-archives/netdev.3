Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82388456E07;
	Fri, 24 Jul 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921714; cv=none; b=mq5e7HSmzspurha2ZlparBetIJlu1sHu/jC2uAt4D6wsoIyNDNYxryjsio8A0al5BkIiDYJt9R5rjDLoA4rdG97JjMSP+8T5/iNPcyFtETnOz46AF/CU/FbM1ltLw4m8V+PPIxUrqpPvrwjEsbbmShcPHnZgl2nUny0DLAV8hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921714; c=relaxed/simple;
	bh=5YBzUpSZFSYh8/PRRzyi4lImzpFEmStW69jzAijxIBs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HUOnmjDwI4JuYFL7NDH05zZDIMwy5Em1WL0o0LtqEtiDhInAm1ALUk5ubIiZoW0C7b7wmknOBH5eiCbbxb6ovaBy4lSAARPS6g7Jnrt449o5ziNzo2EPx0gAEW6G1xqvLqN9iNmCCorJpxpO+HZjVFLw+wOarUEtPrVKtJURxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sU/dt5+8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sU/dt5+8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A61F2A6934;
	Fri, 24 Jul 2026 21:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784921705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b6UmVUQR6mK/vmrSCHX+yILLQIDIz+jhtqqtPoSUTFY=;
	b=sU/dt5+8Seo0xeq2GIpidkeaD+4iQHhMnzUiEHEM4Jx1MjjYk0TU1iuTwesTOre/7sxRy0
	nZsn3YuI1R+kSfi3zf3yZ+sRT4R9KvI3kOAulGJ0DCZRC/lLOfczi4wRnztOWInSqt/ccN
	rMjTC0/kOVKo3UVINzfzhBOJR0qTWxA3jtuHkV1neCbG2AKI/dQW//3dTrGwhkkLIm7t91
	5tYd2XF2tPvPX9jm4cnyKUoKUOKnUj3O+biFpd5+yYT4Z4z5KxSmZFr9OF1UJvTOu6jrX9
	RSKNj1B4vy3GxIulhre5Y2aHb+NwYhhZ8O5guIOErPT557j6QOasDr/qDQBzvA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 21:35:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 02/15] net: macb: unify device pointer naming
 convention
In-Reply-To: <20260724-macb-context-v5-2-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-2-569b1852bc7f@bootlin.com>
Message-ID: <e26883cb49b164660b3fb14cbaf780f4@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.7.2026 17:29, Théo Lebrun wrote:
> Here are all device pointer variable permutations inside MACB:
> 
>    struct device *dev;
>    struct net_device *dev;
>    struct net_device *ndev;
>    struct net_device *netdev;
>    struct pci_dev *pdev;              // inside macb_pci.c
>    struct phy_device *phy;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
>    struct platform_device *plat_dev;  // inside macb_pci.c
> 
> Unify to this convention:
> 
>    struct device *dev;
>    struct net_device *netdev;
>    struct pci_dev *pci;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
> 
> Ensure nothing slipped through using ctags tooling:
> 
> ⟩ ctags -o - --kinds-c='{local}{member}{parameter}' \
>     --fields='{typeref}' drivers/net/ethernet/cadence/* | \
>   awk -F"\t" '
>     $NF~/struct:.*(device|dev) / {print $NF, $1}' | \
>   sort -u
> typeref:struct:device * dev
> typeref:struct:in_device * idev        // ignored
> typeref:struct:net_device * netdev
> typeref:struct:pci_dev * pci
> typeref:struct:phy_device * phydev
> typeref:struct:platform_device * pdev
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
