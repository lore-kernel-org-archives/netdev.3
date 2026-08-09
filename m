Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BE2E401;
	Sun,  9 Aug 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786311860; cv=none; b=YcKQuQxyvYBKnLngONCoj3HFROg11WvBXgjFfoys0lfjK++PjuNuksChGXndLGYHq+nMGsNGddD/kXhWh0UsXbKs/h3AOL49SkZ2MyRNeFvlWfGYZsZE49BZ8mE8z0WUWxtS/en/+3pJ7UkX01wyeEmwGQ/C0MPx/aQIdPmorXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786311860; c=relaxed/simple;
	bh=gzjT9UBYK3Qb0WlwxBrBokZuuNAsUatmJboqEYgn5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST38FCd7lGF/t69xTuBb2ZjBdE+/Z0pBRu0K8HnBDmipUUIxdI02R3ChgtTnE6lBnr6RT2lFDbQX6ka1GO7BXpzLKi+MihMlAkz9QEHMvRKaD/8cZ6kztq27O8X2HmvHUHEaj0b1oefu3FkbCPT5K0bU5kbenCKEkeYO2kQRy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0PEV7cXE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0PEV7cXE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GnNSppwp7aAQczBRsxyJMoo7IxXc7M4zm2p4Xx16BHY=; b=0PEV7cXEOuonQjKnx/J4mEbqK+
	J0epv4CKOqXikiLcv7s+uqJJceFAz/QobApBALkPAA33Ss+3qMaxWekkOA2x6w2LlR8esrfbDjk3z
	on4b5W0gKAeV1XK3wkw8AufL+SwBNzWxXcNI3ANCfOY8k7UwRMTQPytNcl/9LoZqcWpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBJK-00GrFt-RY; Sun, 09 Aug 2026 23:44:02 +0200
Date: Sun, 9 Aug 2026 23:44:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 03/11] net: phy: add
 (*notify_phy_attach/detach)() hooks to struct mii_bus
Message-ID: <c3f81245-90fd-4660-83f9-1b09f9da6279@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-4-markus.stockhausen@gmx.de>

> Worth to notice: As of now phy_detach() is not 100% LIFO symmetric
> to phy_attach_direct(). E.g. sysfs links are torn down before
> suspend while being created before resume. Without reordering of the
> detach function the above mentioned notifier placement is the best
> possible symmetric implementation. For this
> 
> - Relocate code from phy_detach() into phy_detach_internal(). This
>   naming was selected to avoid confusion with "unlocked" helper that
>   usually start with two underscores.

Please could you make this code move a patch of its one. No changes,
just a move.

That makes it easier to review the actual change of calling the
notifier.

We might want to consider the LIFO issue, and add further patches to
sort this out, if it helps with what you are doing here.

    Andrew

---
pw-bot: cr
