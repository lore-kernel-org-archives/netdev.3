Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A623AA50B;
	Thu,  8 Oct 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478674; cv=none; b=BMAq82xKtu13Mo8zV4qfKlTsG9CPos45csGzOP/FZzgbMO4HcSu/DhJq1HFOaTzviAb1FTo3IcLfbl9l75qkMufP3bNNIvqybyePpEK8E7B/xt+EvZPzy1I6P2yRsXlCKWlHKlK4xoMla/ijz6e0h9I42EdjjcawcndTzfeCmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478674; c=relaxed/simple;
	bh=65W8bVXEFfUVVEOTAReICiMPx62ogE+OTYA+qPe/42g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmCMtmzDPNgLlB9wZhgZHInz7FsV5WcwuJrwmOccq399E1x6l7vKiHKltY1y2VY8pefqa4ZfXe7XXhi4uZWLiJl0E0eUt/4+pOm6JOo5j6u5LQXFjRGQZcsoiYG50AokJtdrHnHFzvDqwb9jCpAujsdnq9Ysbyb2J+MuTQpgSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q9eGzOhf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q9eGzOhf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zSdIfKglShzc96qu4q3wbOxbF0gODaNavH1GU0rIb/c=; b=q9eGzOhf2LatYjX9C0oKw/P3a1
	OGQ4KzxSCAjEB4+hb1IwIUSSCAxX83O9PQLWOc5tBkeCbVzXiy9R1uf0UwLqCvd3Fc8Gi4rJKfywG
	UPOVToTgocZVuHEuw8K1Ok2JnhqlXtrQ0nuF/JFE7yPFVQSZoPPj/Ku3W08A+tiwMB3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xErR2-009f81-Iw; Thu, 08 Oct 2026 18:57:36 +0200
Date: Thu, 8 Oct 2026 18:57:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm7xxx: preserve __phy_write() error in
 write_mmd()
Message-ID: <d1d617c4-8d9b-473d-9f45-037278a5368c@lunn.ch>
References: <20261008164240.2694229-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008164240.2694229-1-vulab@iscas.ac.cn>

On Fri, Oct 09, 2026 at 12:42:40AM +0800, Haotian Zhang wrote:
> bcm7xxx_28nm_ephy_write_mmd() jumps to reset_shadow_mode when the write of
> the shadow register address fails and then returns the value of the
> __phy_set_clr_bits() cleanup call, overwriting the negative error code from
> __phy_write(). Since __phy_set_clr_bits() returns the positive register
> value on success, the failure is reported to phy_write_mmd() as a success.
> The write of the shadow register value is also unchecked the same way.
> 
> Keep the negative error code in ret and return it after the shadow mode
> reset, and check the shadow register value write, matching the read_mmd()
> counterpart.

Probably not worth the churn. MDIO operation don't fail. It is a big
shift register which just clocks the bits out on the MDIO line. There
is no checksum, there is no checking if the device responded, nothing.

The only time i've seen an MDIO bus fail is because the driver for it
was fatally broken resulting in all operations failing. And we would
not of got this far if the bus driver was FUBAR.

Please work on fixing issues which bother people, not theoretical
issues which never happen.

    Andrew

---
pw-bot: cr
