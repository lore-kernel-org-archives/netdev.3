Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BC189F43;
	Sun,  9 Aug 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313638; cv=none; b=KGb9ww9os6N2kQYsbHRS8E+FV7h5sGCNKi7GyNSWVBcsy7rh4HXIeEHT+53V0180D6tw2crXxwmacOjrvpSQWG68WxJNPknOd1t80fQ3kSgYDfkg3aHVFLwlwhX6HQe6Ks8FQn6/V00bqnphtnoorg5SdwoTvyHOzYFYURbItnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313638; c=relaxed/simple;
	bh=jSAxDpoSwVnH9k1vDcyjncz+XpU0O/S9VrZIzGFf6YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLln+llpB43lH2+MLG6fBcbq9VsAL75rTtNUZu9cD+wCfcbfzIC5Va5Eqocw/SigbdSYayDLZlLvBsy+xbvSzhMosEZZF0zkY8s/dAmKXdcxi4fMdAP34R1P3cXsi+FnNApNiyCONOcdUqEOpvWaFGYH+mg+USGHziXmIO8faXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ro0oIa+u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ro0oIa+u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X0MPD616GVY0pSuq8IuVS1hZWFWn0v9P4o/g72ShMBw=; b=ro0oIa+uFRieV26ajWlT6Rhvo5
	C3EXKvg3dF2tGW29HPYQ1p1oLmPpVmc6zK6dJoHRZovDb3uJkx//cwvKMwompAaulDd0LNV1NvdhI
	kDNu93oQZV+dUcVttonNkQFcTdZ0f0xuiGcgUlsfrO/35jLu8sbaWbpgITL6ihbjjTiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBm1-00GrLw-OW; Mon, 10 Aug 2026 00:13:41 +0200
Date: Mon, 10 Aug 2026 00:13:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 08/11] net: mdio: realtek-rtl9300: Check for
 C45 support during setup
Message-ID: <b0c92f66-859c-4b45-9b15-b001c216b423@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-9-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-9-markus.stockhausen@gmx.de>

On Fri, Aug 07, 2026 at 07:10:55PM +0200, Markus Stockhausen wrote:
> The to-be-merged RTL83xx devices have only 1G ports. Thus the MDIO
> bus always runs with C22 mode. For now it makes no sense to add
> those devices with C45 helpers that are not used at all. Add a
> consistency check in the mapping helper so that it aborts setup
> if devicetree defines a C45 PHY for a device that has no such
> read/write functions.

I know the concept of an MDIO bus is completely messed up with this
hardware, but C22 transactions and C45 transactions are a bus
concept.

ethernet-phy-ieee802.3-c45 is not about MDIO transactions, but C22 and
C45 address spaces. The PHY has its registers in the C22 address
space, or the C45 address space. A PHY with ethernet-phy-ieee802.3-c45
can use C22 bus transactions, C45 over C22, to access the C45 address
space.

So what you are testing is conceptually wrong. It might in practice
work because of the way the hardware is broken, but that does not make
it correct.

A PHY with ethernet-phy-ieee802.3-c45 should fail to enumerate, and
that should be obvious. So i don't think you need this.

	Andrew
