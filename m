Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676953EAC9E;
	Wed, 22 Apr 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864447; cv=none; b=MtN5pn2Q5j9OMqkT++UxZt9MFbh1ghGe5qJXWaRhLDkjUIDuKWIFz1cDzbjR2CYd1YPXRnyG6DaXkMtivm3XHf+3uL//kauMsdIfUZ6djoNZqAVcsOD7ApZtxsSzPHAGPL/RlnstlhV/oF8ESbBjUraadKdk2P/vjZjBmtnw2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864447; c=relaxed/simple;
	bh=UAB8ew6M1c8iaKe1esw1FMMRUKB/6o7RwuwKu9bwzBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmt/ZZzvBoepH7ziH0mY2InbzzSSplQFMOylQrLx/rzFZ0EkgDqexVeQ55Gt0Z4nY8niPtNKepK9fyND1BWmH4AeUZdYfImZ7Bxhh0MuYLl3KM7jZWE+pElCBFqS6jt+xbPGUY8W1Q5zd22j95lZF3EVKtsVgFNvvptvNZK6WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Mml/GuL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Mml/GuL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CUHnSisp2kcYkSoP1xx2XQwlkh4hdcNpQIBttcFUKgA=; b=4Mml/GuLFA5XsLCSZrj+zW/Gsr
	h1S04ZOEiGXlmsUw7fjqxgGRFNdblXPn/co23sNxp4SsndEO51smHVPRbvepMIoRIbJaVN/6o4PF+
	v5n/yOeAQEnfF5D8pZQ+g3ynkmdFRo3AWhIlzmyhtnGSei/jtFqV0USPG7I5UxA+o5Mk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFXbe-00H2Il-DQ; Wed, 22 Apr 2026 15:27:06 +0200
Date: Wed, 22 Apr 2026 15:27:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2 0/3] Add motorcomm 8531s set ds func and 8522 driver
Message-ID: <eea18d2f-5294-40e4-9ea1-87aa55f8ea28@lunn.ch>
References: <20260422083255.29692-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422083255.29692-1-minda.chen@starfivetech.com>

On Wed, Apr 22, 2026 at 04:32:52PM +0800, Minda Chen wrote:
> This patch is for Starfive JHB100 EVB board. JHB100  contain
> 1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
> interface connect with YT8531s Ethernet PHY. RMII interface connect
> with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
> patch 3 is RMII is for RMII interface.
> 
> JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
> Managent Controller). Similar with Aspeed 27x0.
> 
> The JHB100 minimal system upstream is in progress:
> https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

Please take a read of sections 1.3 and 1.4 of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
