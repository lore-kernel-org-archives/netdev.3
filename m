Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EA381B1B;
	Sun, 29 Mar 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814050; cv=none; b=p8DsoMaDcfofCrn3Qw8JzzffREMBPng2mau2VO/rz9hkbY+NTwYO8Ac4rOukih/XWp8qtjtURAduP6ClASqBbT981ILcZCk7SMoYSW400plzBOlDGpKj+XfsXqZ/A4/iVv5L62ZJEdLaBuwGwH3DJ+nl0NH34diNK+zpigua8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814050; c=relaxed/simple;
	bh=oHWmLO7hpG/tSIMZNHc75M7sqdhD4jk2tjHgD6UkR2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKxVbuYW1YJ4tsm6ITc6z4TCbHqiBSgj22zpnssn8Hc/vPYDB/oEgZSQQs4tO7r1arLgJ23YisdcfSjPbYKEFssUsBQVU908OXyOQdRUx3ia5XG0wYliNUxc02KZX5qQnqGzfyfhMQXVfhESi9+rmtpuv2/ce8UamdHs8B5F7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=de2C7uk8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="de2C7uk8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qt2b37De0bTt4TsZUgyzO7dbmNZ4ma8tZa9TBKTgNLA=; b=de2C7uk8WG+72Y6A3kEC4Levh/
	0FHdQcxTPKFk4L4fqS1Njxe0U4FePBpgkfyHr6hHEJA0KEUC03c9HYb2utVg/e1WnpkigMjk7Pn61
	bBVPMxYs7LEYySV/rrxlrrE2yf7ugPniSIgLHPV8uNz0jTVOrUN7UjcS4+hrdl/MtSh36UKB43GyY
	Wko2Kb6E7u408WxUT/7n/slyRjkKG18J567rrKP5GWZYqgRPsfqY+O8/CSV6jQL4d7vQvwH6bR5eO
	m/oqqoyZx5ik/8adwYjKMlaHeWtJOVpTcZlX9EM3+0NqehYdJfftMrur8NrzZLDxsS33XiBetRcjI
	VJNs0F3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42700)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6wCt-000000008Dm-0mAC;
	Sun, 29 Mar 2026 20:53:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6wCq-0000000020e-3WG8;
	Sun, 29 Mar 2026 20:53:56 +0100
Date: Sun, 29 Mar 2026 20:53:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: sfp: add quirk for ZOERAX SFP-2.5G-T
Message-ID: <acmDVM8yK2aygvs0@shell.armlinux.org.uk>
References: <20260329191304.720160-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329191304.720160-1-jan@3e8.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 29, 2026 at 09:11:11PM +0200, Jan Hoffmann wrote:
> This is a 2.5G copper module which appears to be based on a Motorcomm
> YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
> (I2C address 0x56 provides only read-only C22 access, and Rollball is
> also not working).
> 
> The module does not report the correct extended compliance code for
> 2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:
> 
>   Identifier          : 0x03 (SFP)
>   Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>   Connector           : 0x07 (LC)
>   Transceiver codes   : 0x00 0x01 0x00 0x00 0x40 0x40 0x04 0x00 0x00
>   Transceiver type    : FC: Multimode, 50um (M5)
>   Encoding            : 0x05 (SONET Scrambled)
>   BR Nominal          : 2500MBd
> 
> Despite this, the kernel still enables the correct 2500Base-X interface
> mode. However, for the module to actually work, it is also necessary to
> disable inband auto-negotiation.
> 
> Enable the existing "sfp_quirk_oem_2_5g" for this module, which handles
> that and also sets the bit for 2500Base-T link mode.
> 
> Signed-off-by: Jan Hoffmann <jan@3e8.eu>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
