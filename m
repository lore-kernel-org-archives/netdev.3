Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071939;
	b=hTVy8bb2GB1FnnsOgw7wLdjvpGZhT63BiHb1oUhq2BAvZC2wc6wWOd6nFesfN6Ugs+Nt
	 de1OvJlzTzeK+xZpKOgKw7NgJk+ei/pa+NIJ9KnXfRnr3DoXM5rakBNO7BvVEgViftvrh
	 Wh4Vui4EqykMgFt08Jn+AAnXnpqfE1vTPVpvXux8CAVwWmJDk+S3G2jOgHc+VLQv01EN5
	 xz+PZJ+3LLzOWqwuST42ufE7c+IWDJgkY+2Kbt3e2FspDfQ6rGhnz1XbBFI8U/Y7w/hSn
	 EX14Hw/DkpJuu8GshrxbVaHlDKdrTbx1AXLCztMw6KG8g5NNHJ+beV6iv316Ty3w2eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071939;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=i0EgZ8Yfz6pkJgZyBs7peXGWo7SB2ASDmUP9uK36Nkc=;
	b=DSSm0WtjL46nXUgUigOGIvS8VOhMXUDUYwddmBs7jZwL13V2mMP8wKo2u75KXrB8TbEh
	 ute6mUnX2KTigLV/dL1pDcN9PRR9hrjFwDcLWdIeekZmN1gGJlZnvk8Vsw/ovqsJAq1cp
	 U0YZx2hBYYjPS1RoTnNai+GF8I5c2IfTFTnjtIzx3smeNW256JX+Xq3BkNPk0iPjoerHq
	 RGPWD83kyJBjVYAghH9QwqtBBaE6TrUO+MheXGyFtQg+uM4Jrg18AwcZ9ic4G3OvgRLh4
	 StUZA05Omhkn7PxIZIonWhRsJ09OooOVWHCIbRNIyDdoIsITnn9eFYmXAodldnup5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Gq1btOFo;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AA606A326;
	Sat,  7 Nov 2026 17:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Gq1btOFo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i0EgZ8Yfz6pkJgZyBs7peXGWo7SB2ASDmUP9uK36Nkc=; b=Gq1btOFogxZ3JAy+dQDbg26wlB
	P4bQGUgB2a+jtc4PnytTFq0/eazN5150TCQziTlD3fvBGA5TjUe1Sj+Yh2FPbzDZrlL/ajSaE6crr
	6U35BgNWDPEoBvzTVHBLtAgb5TqhRrynQJc+Gzb066o1jFkdEZebnJshQauvHk6VpdJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPk3x-00Ez6p-Gm; Sat, 07 Nov 2026 18:18:45 +0100
Date: Sat, 7 Nov 2026 18:18:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: me@marleb.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: realtek: return MDIO read
 errors from hwmon
Message-ID: <2bb14f43-2c96-4d6c-9dca-fd8d7b2a37f0@lunn.ch>
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
 <20261107-realtek-hwmon-tz-v2-2-6b9a69d44470@marleb.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-realtek-hwmon-tz-v2-2-6b9a69d44470@marleb.org>

On Sat, Nov 07, 2026 at 06:00:46PM +0100, Hleb Shauchenka via B4 Relay wrote:
> From: Hleb Shauchenka <me@marleb.org>
> 
> rtl822x_hwmon_read() masks or shifts the value returned by
> phy_read_mmd() without checking it and returns success, so a failed
> MDIO read is reported as a temperature: -EIO reads as -2.5 C and
> -ETIMEDOUT as -55 C.
> 
> Return the error instead. Once the sensor feeds a thermal zone, the
> thermal core then keeps its previous state rather than acting on a
> bogus reading.
> 
> The problem was found by an AI review of the previous posting, and
> this patch was prepared with AI assistance (Claude Opus 5.5). It is
> build-tested only: I could not provoke a failed MDIO read on hardware.
> 
> Fixes: 33700ca45b7d ("net: phy: realtek: add hwmon support for temp sensor on RTL822x")

Fixes are not wanted when targeting net-next.

You need to decide, is this a bug which bothers people, so should be
for net, have a Fixes, tag and Cc: stable. Or it is a problem which
nobody cares about, so can be in net-next as just normal development
work.


    Andrew

---
pw-bot: cr
