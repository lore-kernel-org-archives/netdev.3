Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6645D91B;
	Fri,  9 Oct 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566276; cv=none; b=tc8jKigF1M2kqoTlDlEkrk/uBUpgM6YIL7Pf7k9WXU7Bm8NPpj7+mZlgqa3ukPdVKjuHtTiTK3hl7R7Z+I2JlSBud7V4PntrBP8ug8O8fQkVEJs9jCHdy/+thCHRyWpaK02ATQiwKorqQaPMBTGIq5l0Gog2PketHGBlh2pFZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566276; c=relaxed/simple;
	bh=xDuEzE742Kv+kPEfTNF+nO4eq6SiJRHO7SSx68BKNSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f21hc3zM+/fqz1xt+iELAZ6aCut+Ya5rMxgSp9oukNy/McrpaQ+mHwDHpZyaLmGGFKIUS8Y2FqIcutxC1h6ZGKdwv4oOHBsLhR2TPZJ+fr0lWGGOCd8AxwRgHOXH0j23tku1Sg+s1OOGUwws/qMPdK4r0e7HZBakYw0QJeiCIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id F17512040A;
	Fri,  9 Oct 2026 17:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id mo--IBtwX5Mz; Fri,  9 Oct 2026 17:17:43 +0000 (UTC)
Received: from [IPV6:2001:99a:adc:6a00::8be] (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id C96B01FD49;
	Fri,  9 Oct 2026 17:17:42 +0000 (UTC)
Message-ID: <6d10c3a2-f235-4259-a3a8-53e2a1203d54@lemmela.net>
Date: Fri, 9 Oct 2026 20:17:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: realtek: support unaligned
 RTL8224 PHY packages
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, daniel@makrotopia.org, javen_xu@realsil.com.cn,
 vladimir.oltean@nxp.com, olek2@wp.pl, o.rempel@pengutronix.de,
 ih@simonwunderlich.de, amadeus@jmu.edu.cn, jan@3e8.eu, f.fainelli@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mensi@mensi.ch
References: <20261005201540.913977-3-oskari@lemmela.net>
 <179144751562.434549.8240253139319713521@kernel.org>
 <2562030d-2508-4131-a27f-fe161961f627@lemmela.net>
 <3e5adea3-72e9-41e4-bd59-3aabb9835e07@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Oskari_Lemmel=C3=A4?= <oskari@lemmela.net>
In-Reply-To: <3e5adea3-72e9-41e4-bd59-3aabb9835e07@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 21:02, Andrew Lunn wrote:
>>
>> Would clarifying that a package node is required for unaligned RTL8224
>> layouts be sufficient to address the medium finding, while preserving
>> the fallback for existing aligned layouts?
> 
> Probably. This is the AI being a bit picky.
> 
>>
>> For the schema-coverage concern, would adding a dedicated RTL8224
>> package binding with a compatible such as "realtek,rtl8224-package"
>> be the preferred approach? This could follow the QCA807x package-binding
>> pattern and provide explicit validation of the package and child PHYs.
> 
> A dedicated realtek,rtl8224-package binding probably does make
> sense. You need some documentation anyway.
> 
Thanks, Andrew. A dedicated RTL8224 package binding seems a clearer
approach. I would retain the aligned-address fallback for existing
device trees and explicitly document that unaligned layouts require
a package node.
