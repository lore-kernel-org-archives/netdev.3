Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10433C5536
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549734; cv=none; b=AxCqSCDybkiJAluk+ThtHoFedJ8XXfODLrhKgEGi8QlAU+/iPuueLUd/SIEBnUm3NtbGOFJHcPOdubGd0DYzXoo3Ga9uv9iuV1aBuofpq6Sf/otO1QAteNLXno55gHVRS7dv/Q7tOrMzP4hw3ys2Lcsj6by/Fynhi/tNVxhB1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549734; c=relaxed/simple;
	bh=rus392oG64W3U8pCUgeucCaqhwpStv6oKHIC9aozULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzGLCHvwnRMEsB7Qiww+YGLrsPdkv4/NEyU49eWphl+yYE/txjl8hRNxD5az72n9vJuJ/xLV2CBTeNfCWDXQWYrNCRBvSm4Yhidtlrq1Eax0UCS1MZD2jNmHP0UwQOcbG6pQWa/eOzUbuz/nYlfMX68nPXGGKV1SuvA7UDLHc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MulhZhti; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MulhZhti"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RRLyBns6/n6HROyoVKQzfnysm+y2RbKdcW+sYmJA28U=; b=MulhZhtiZv+pK/GXZawID9/6XX
	E1D5q/ifeLiSoSFs46KFEpzOuT05vDUh58rMgt48mmifxTyZIjTUhYX7chpC96R+e0YrI8tZt8XM8
	VPcXHtDkdiveER/44G2G2uZ0Nr8/QruiALxpIMrtLwd/rWGHam6dbwXOTlgqURpzjOHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAxmF-007aNw-9g; Mon, 28 Sep 2026 00:55:23 +0200
Date: Mon, 28 Sep 2026 00:55:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddaraju DH <siddaraju.dh@intel.com>
Cc: netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Shubham Das <shubham.das@intel.com>,
	Susheela M Doddagoudar <susheela.m.doddagoudar@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob E Keller <jacob.e.keller@intel.com>,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Anjali Singhai <singhai.anjali55@gmail.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	David Laight <david.laight.linux@gmail.com>,
	Eric Joyner <eric.joyner@amd.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next] net: ethtool: add BaseC2C medium & AUI C2C
 link modes
Message-ID: <e02c7a87-675f-42e9-b57c-87ba96c09262@lunn.ch>
References: <20260927223656.2528362-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927223656.2528362-1-siddaraju.dh@intel.com>

On Mon, Sep 28, 2026 at 04:06:56AM +0530, Siddaraju DH wrote:
> IEEE 802.3 defines a family of chip-to-chip (C2C) Attachment Unit
> Interfaces (AUI) and SFF-8418 defines the 10 Gb/s SFI equivalent. These
> are electrical interfaces between two ICs on the same board, with a
> fully specified lane count, signalling rate and modulation.

You should always include a users of new APIs.

>  include/uapi/linux/ethtool.h | 11 +++++++++++

This is especially true for UAPIs. It can be hard to fix them once
they get merged.

Please submit this as a patch in a patchset containing its user.

    Andrew

---
pw-bot: cr
