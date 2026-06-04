Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E74DB561;
	Thu,  4 Jun 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609191; cv=none; b=sv4cX18bbcFzxAW7gWBCGUkvvwsSvugqoFQkgdhQKoPTsfVSoqVOVI1jsE+7i7jsyA373QQFODRjWjDUCPCWDJ33CYI4wEm6RBaK1LDvwk3MNsuzoFPMkgr+k3x+oXRtlu0Kk8wnh0pqTKNDduHAkXvu2FIns6F0vJPMQt6ZjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609191; c=relaxed/simple;
	bh=v4b4f/wB79/XDJbn6l/Dz0Yses3F8K3aed7k28/X5tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTlIPDCf2qePG7c8lM9jOpjQE0JhVWw+tRLxz82JNDVphKu93EM5Pnc6KaJdWudSmKDvB5yguZ7aH/ITBo7UG8Qk5GhJPMaLr7d69jpZZFEsOIQvo3sNygqc4MdaP3bpT/iFl9nA0oQm7414GoTVWNEm9wkuzY7PvD/FNzhmG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK0RKrnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK0RKrnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A911F00893;
	Thu,  4 Jun 2026 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609189;
	bh=jhsV30bt9Mil1+UFvEiSYEfI3pmcZ8Ymi6Uc7gbVH5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EK0RKrnVSXaFae022UPMT29/rWDPJUms+IBYJrhMlY4JK8VSQmgiTMAKxJ8mhRn0W
	 Iu3cnjwrPmDo7Einz4J1TYTUj0e/SqVvEY47uOdjvfotNTrVajJl1yKEDBh+S0BBH7
	 BXTKLKUxUb4taeBawhFuQnb83I+N4NSBLs/f6zV6Uz7IZyutmOAO0d123CDEzAbsuO
	 2uEihZAX9UADhrMpPEg/oMpsAZI2uZcJeBwtjuWUqFsMaqsAoBpCb12/pT5ypZl7SJ
	 RFIqeCxcn7xpjRcuOW5EDN1ec7WDSiiQIaEL/u+NUSegiBGEVTotI6V+7r/km+dc8L
	 02FlrDYQwjTmg==
Date: Thu, 4 Jun 2026 16:39:48 -0500
From: Rob Herring <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: ethernet-phy: move clocks
 property to invidivual PHY bindings
Message-ID: <20260604213948.GA1223636-robh@kernel.org>
References: <20260602-ipq5018-gephy-clocks-v2-0-65a1f1d881f3@outlook.com>
 <20260602-ipq5018-gephy-clocks-v2-1-65a1f1d881f3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ipq5018-gephy-clocks-v2-1-65a1f1d881f3@outlook.com>

On Tue, Jun 02, 2026 at 10:50:37AM +0400, George Moussalem wrote:
> Move the clock property and restriction from the ethernet-phy.yaml file
> to the individual PHY binding files. This allows each PHY to manage its
> own clock requirements.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Commit 350b7a258f20 introduced the clocks property with a restriction to
> maximum 1 to the main ethernet-phy.yaml binding for Realtek to add an
> optional external clock source. This is restrictive to all PHY bindings,
> as some PHYs may require more than 1 clock such as the IPQ5018 PHY which
> requires 2 clocks (for RX and TX).
> 
> There are three other PHY drivers that require clock management:
> - Micrel: requires 1 optional clock and the micrel.yaml file already
> accomodates for the clock property.

It does? Where?

> - SMSC: requires an optional clock and the legacy bindings file
> (smsc-lan87xx.txt) already accomodates for the clock property.
> - BCM7xxx: requires an optional clock. I could not find a bindings file
> for this PHY family.

Because it only uses what is defined in ethernet-phy.yaml. The only way 
to enforce 1 clock in this case is split ethernet-phy.yaml into common 
properties (removing the 'select') and a 'generic' phy schema that 
selects nodes with name 'ethernet-phy' and also have no 'compatible' 
property. Not sure if that's really worth doing. We generally try to 
require compatible for any new phys, but that's only if they try to add 
something to ethernet-phy.yaml so we see it.

The simple solution is you need to keep 'clocks' and make it 1-2 
clocks. It's been how many years until we needed 2 clocks? So probably 
some time before needing more if ever.

Rob
