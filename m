Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BD4A206C;
	Thu,  1 Oct 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842075; cv=none; b=RLc4ySDluWj3qJT65S20cbK3KjJpWKSWJAsLv++ZkrLqFN4FW40IBs99rJfQMaJaI9HF29Kq9mdU+rVjExsrQbXooUmbFPOTDx9ygQCHj8DSCsk+FUVDCzJEUEMGjqqyPp137oANtZVq9EHhyXSMuOc3y2sMQbzdINErHQvIqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842075; c=relaxed/simple;
	bh=Cj8+xx4a1cGnubfS45VM1VNE7TM98dnMfnI0AQ9vwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5OkK7PKvycWrh1sWgb9O1N1KBwB7UFDJx1Pm0wtdnixkFsz+uza7etemsJP+/JxuF62GCDbH1J4e2B8ADmudsr1ihXt8KjUqcd/xB8PIDb6R+9VsI3NB/MHC4LUQbZ7etG9tK7OaWPgD9wKCSYyuNbcHA9japE9dJc4HkqKOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbeGcI29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbeGcI29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734791F00898;
	Thu,  1 Oct 2026 08:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842074;
	bh=SS2mGHyUmwe0VmX0h8vluIHyfjQsXGUXCMbq0JhU3lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbeGcI29zuUSYAKStnXiypREtlH6js2GNQJXjVBCtm7Anbt+ppZoAuCmt/mP2v6iv
	 2rcRxQZEZVvrc2sB4fDDVk5JuFzsYe4/AUaaJz+BXvYvQNBNA8vzIekXHHubWbWFiY
	 6p0RSVKlRPkYBT+ZwHhLdsZ4Kn7fzgtymOAtpz81WU+4bKrgqm5OZrylOiI4MgrNce
	 Z17XjxgdZWeXHVamV5I9Io++nMbcq3BIr7VQULNiqTxEKHUgIQc7EOuQs14a666Cpl
	 3WUL/yrVoB08V4dLFZD/OGdfSNH/ryrDVWOS/mOf7t96e7ly0OtyuspZ0+tC0RnzfM
	 +OLzzE00dl8Hg==
Date: Thu, 1 Oct 2026 10:07:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Joseph Guo <qijian.guo@nxp.com>, 
	Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	Mehmet Fide <mehmet.fide@screeningeagle.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 02/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULL
 board variants
Message-ID: <20261001-pearl-skylark-of-bloom-6a6b40@quoll>
References: <cover.1790693249.git.stefano.r@variscite.com>
 <075691831d4da249672c3141ab16b9e856ee42da.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <075691831d4da249672c3141ab16b9e856ee42da.1790693249.git.stefano.r@variscite.com>

On Tue, Sep 29, 2026 at 05:17:29PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Document new VAR-SOM-6UL configurations on the already supported
> Concerto carrier while retaining its legacy compatible. Add
> VAR-SOM-6UL variants on Symphony and DART-6UL variants on
> VAR-6ULCustomBoard.
> 
> The new compatibles identify the SoM storage, wireless and audio
> options followed by the carrier, module and SoC compatibles.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

