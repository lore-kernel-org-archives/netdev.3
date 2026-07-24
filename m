Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC831F99B;
	Fri, 24 Jul 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910327; cv=none; b=JC+np5TknjE+c3kU0Y3IpjV+Cj2LrMADdRXQuvNFo0JkN2gtQ19I1eCYSKAtEswoG5/js3eEZZiqhKhsNhoCuRnpznjXHkQldj+YoyVLjSbN3c60bjzT1YkN30rAXB8hKA7l+8ws1UTdsjlO7WA/IIL5QLbg0+QYXSZ8r01nG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910327; c=relaxed/simple;
	bh=/39QV29LbiVZX3deS3dkq6/roKwb2eVYM8zSapSTVVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2LcptgUePOsYIUkRGiFc1ICaSNoAI/50xL7LYTG+ecoaZesz5wCKu6R4+uT4s6/cDxQPNlibWgaoj8le6pdb1AkGcRzS4mzU98YAk5PCZR0FN+ap22sHZTv0NyNrabBZJbRYZydtPM+G6Jl9MmQF91Ds2I9KPd94d6CMl2QIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SdExFaGL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SdExFaGL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NutiNOveeMBIDdTSTRLZVs7gVyr7xfHQSvj24HbpnWE=; b=SdExFaGLnJaQiC3WoV0Suso1YW
	k3VmfGlbck3syacABiBo4vIcijZ56Qeji1tliDRcBjImsOzj+znSMhSryhN8IvIjVdbnf+Yj3JGVp
	qkw7oYUfx7y/LgA2wTbZYalOrWX9EdzaKJC3ulWRj/L0KbVEgI/Fdj7oVQA/a0wdPj0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnIi6-00E1bQ-MT; Fri, 24 Jul 2026 18:25:18 +0200
Date: Fri, 24 Jul 2026 18:25:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
Message-ID: <958d44c6-0902-44b6-b861-ec501ed3ae7a@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
 <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
 <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>
 <6042ea40-376c-43d9-97ab-13243b946a50@lunn.ch>
 <6a1935b9-dd81-447d-8a38-74d9c19be653@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1935b9-dd81-447d-8a38-74d9c19be653@birger-koblitz.de>

> Well, only the new devices use phylink, so it is not converting the existing
> chips.

O.K. I suggested you split the existing driver into two, a library of
code moving frames around, and then the glue to probe and use mii. You
can then add a new glue driver using phylink for the new devices.

I think it is a bad idea of have both phylink and mii for the same
device.

	Andrew
