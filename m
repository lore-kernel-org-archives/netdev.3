Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FB3B0589;
	Thu,  8 Oct 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479589; cv=none; b=O4vxcxmuMXR10LQW7Za4a0TGWHuedxaIHUyS6MTFyc3R/5SoiIRXsccztRXoFuLiNjymzGrBToe2ZvDWW36+OxwycAsjYu9O5JCpzBOB0ZfUQ6uAZLxe4GShc4tB/eRS42DkU4gdh3RVrN6GzMxsN3JiegpOT+HDPfWxzdrZiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479589; c=relaxed/simple;
	bh=8Yf/XyMJzFg7n3z2XL1IPOKC+UGir4d1kaUlkkwNpOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLrAsfB/PP9dTlSgZsVZf1JRZDXCggo68r+J+0ESrKwGItPFt1JNgiA57AAqLKaIuJGz6yCTPG6wCvqn33igxk529UlNEC7R6o7TVpszV57BOTmRZ9MxJ/24tUb13fNA6LcoVGb5mM2p3sZCLhVAtvTkdot6u042oOAZIH4vpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id 487A120F08;
	Thu,  8 Oct 2026 17:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id uOLzj1buIJml; Thu,  8 Oct 2026 17:12:39 +0000 (UTC)
Received: from [IPV6:2001:99a:adc:6a00::8be] (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id CD2E21FD45;
	Thu,  8 Oct 2026 17:12:38 +0000 (UTC)
Message-ID: <2562030d-2508-4131-a27f-fe161961f627@lemmela.net>
Date: Thu, 8 Oct 2026 20:12:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: realtek: support unaligned
 RTL8224 PHY packages
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, daniel@makrotopia.org,
 javen_xu@realsil.com.cn, vladimir.oltean@nxp.com, olek2@wp.pl,
 o.rempel@pengutronix.de, ih@simonwunderlich.de, amadeus@jmu.edu.cn,
 jan@3e8.eu, f.fainelli@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mensi@mensi.ch
References: <20261005201540.913977-3-oskari@lemmela.net>
 <179144751562.434549.8240253139319713521@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Oskari_Lemmel=C3=A4?= <oskari@lemmela.net>
In-Reply-To: <179144751562.434549.8240253139319713521@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/8/26 11:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The RTL8224 text added to realtek,rtl82xx.yaml (preceding
>    commit "dt-bindings: net: realtek,rtl82xx: document RTL8224 packages")…
> - [Low] The new RTL8224 package example in realtek,rtl82xx.yaml
>    (preceding commit "dt-bindings: net: realtek,rtl82xx: document RTL8224…
> 
> --
> 
The aligned-address fallback is retained for existing device trees
without package nodes. Without an explicit package description, the
driver cannot reliably distinguish aligned and unaligned layouts from
individual PHY addresses.

Would clarifying that a package node is required for unaligned RTL8224
layouts be sufficient to address the medium finding, while preserving
the fallback for existing aligned layouts?

For the schema-coverage concern, would adding a dedicated RTL8224
package binding with a compatible such as "realtek,rtl8224-package"
be the preferred approach? This could follow the QCA807x package-binding
pattern and provide explicit validation of the package and child PHYs.

I would appreciate maintainer guidance before preparing v3.
