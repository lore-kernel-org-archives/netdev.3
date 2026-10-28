Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154053;
	b=Q5YIqUYY5JRivdAI51h/iHdw/4IGe3ZGT2H8gabbOCeEgiHDSEG+KGY6pcYrc3X1uZVv
	 mxDRr2ILUxsPYF2r8FO4rdiZZKnOxq99FKWJPz2LLDT4mrQLbLcNYGwrd6hGE7Rtjm+GP
	 Hniw8gkiyFErdqtKGCJ6cZx9YG/z23jV/1IA9uXKMN+VQVNim5T3hbG7waiS2X1sa1B9x
	 YNqyYK3Z9hEexVjRMdx5hAHlNT5M/bWJIt5vBebFp7DKkGlsY0Atsb0IFeDyIUeQZcX/S
	 3zFIy4HqiLFWdE9Oy+W2lGB4hL9mUmGtF5MEsTM+vtfD//Qj/z0jlQGhwI4d4RzllDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154053;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fR07HzCYiHUWXoygEK4KE/KCkYYrHs4rlMJZsk/rRdk=;
	b=Uja//Kn1J4b7Yq1N0dkGYqteJE3DR2eZlBkMR3KDrE7wNMPhCpo0kuahVjOy+ddlIyzr
	 oE5HynzJzAa+EMNt6SYBaCPsoBMfpxXKgaWaRAIvAc9xcoQUPmZDhYTRKyapLqJr8ZsCi
	 VHgWSUi5tahAI6ruzgsIdFKZZoA02Qy11477RCmfxxndqCzVLmUOsrSto4ym45voCtiWb
	 GBquI/R7cSn60kufG9LZD0hTZiY5dc0vyNzjgsSbz6cjkqfIXoiSDTjO4sgXnVEU5CeBS
	 dRP04WA3TwQyYNLbWORNACDB8dC158+8IhUrID5gKW6/qPZ9XnRyBW0iX5m/Gt/eWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Q4dEGGKV;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3845606A31A;
	Wed, 28 Oct 2026 02:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3845606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Q4dEGGKV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fR07HzCYiHUWXoygEK4KE/KCkYYrHs4rlMJZsk/rRdk=; b=Q4dEGGKVey53CbOf9pJ4D+Qgeu
	+LuZKwfaRnJ/Mnxr3h9OLDa1i9BLVJvt1ZYkxMn4nXsO66nFT0/3fxs9bITdm4hIg2Dj2haphPyBx
	0PvrEXVIKaXT1C0Up8iWyweRQ9dbZ5v9QVACNXM05HfQreaS5mLiWv4esqheyvYDgqqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLtHG-00D2pX-Ip; Wed, 28 Oct 2026 03:20:34 +0100
Date: Wed, 28 Oct 2026 03:20:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 5/7] net: dsa: mediatek: support MDIO switch
 downstream of MMIO switch
Message-ID: <f6fe9c7a-5617-475b-babe-da24cda815cc@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-6-cjd@cjdns.fr>
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
In-Reply-To: <20261028011317.1557238-6-cjd@cjdns.fr>

On Wed, Oct 28, 2026 at 01:13:15AM +0000, Caleb James DeLisle wrote:
> The MT7530 / MT7531 can connect via either MDIO or MMIO. In MMIO mode
> the switch provides its own MDIO bus which connects to its integrated
> PHYs, but also can be connected to other things, such as another
> switch.
> 
> If the MDIO bus contains another switch, then the upstream switch
> will register but it will not setup the DSA tree because the
> downstream switch is missing. Without the complete DSA tree,
> mt753x_setup() will not be called on the switch and therefore
> mt7530_setup_mdio() is never called so the downstream switch never
> registers.
> 
> Update mt7530_setup_mdio() so that it can be called multiple times,
> export the symbol, and call it again after dsa_register_switch()
> from mt7988_probe().

I would suggest just moving it to probe. Don't also have it in setup.
KISS.

	Andrew
