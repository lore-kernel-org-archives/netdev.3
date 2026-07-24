Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6347253B73;
	Fri, 24 Jul 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899340; cv=none; b=MM3NtWkSEoebNy+FRTKiWEbAdnS29qSeLOFj2cJIv1mUBOJ23qEjcrhecBu4CCmK4v6hAbAcgOsasDepyNt367IYGEGuWuJwbE51PTJp2zqWiAgHM7bqVGmqjNM/7jmlIlSFOPTQjV0RbFjuuSbHlUGNIC8lQGE2VWh4v3kyGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899340; c=relaxed/simple;
	bh=rrVAytx9RWXJ3Bddz6149l0+CSBEeggiijUyqHK2WPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0PxzMGeNmUC1Rw0wXWBNIDAWFvkiabr0/IK4FjTYRESV91DG+vEHpnjii6d2f+znDB81YQGBUnyRE8QNXCXSJa2/kj0ZFliCh36yJA2PC8Anawa8iNDubluaD5XgZjhOpGXES2o1HkjarMEhEVhH/uXDUyzfPqwY5rA4iDWGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bkS9LbAD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bkS9LbAD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=grjN4KqKfQWD229qFTacyoK1XeoskfGP5bOHrKO3lMo=; b=bkS9LbAD7GI9ysNIoxB0stW+HG
	7GXOTbFrG2ESmo6qojvDM469+Mlm/MMAU18BF0S1uK116Wr/Fy896P7Xpc+Jd0OOvObQkfeClloye
	wRfexTkW7D0hgvvp2OMK0uISzMSgtZFnuTsUhKuwgLygigH7b9cWKwCgwV7hpbuYD4ZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnFqs-00Dzr2-GM; Fri, 24 Jul 2026 15:22:10 +0200
Date: Fri, 24 Jul 2026 15:22:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/13] ax88179_178a: Fix endianness of pause
 watermark register
Message-ID: <72fe6220-925b-4cc0-bc6d-71bd6c77b31a@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-1-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-1-bdde4f905883@birger-koblitz.de>

On Fri, Jul 24, 2026 at 09:36:44AM +0200, Birger Koblitz wrote:
> The 16-bit pause watermark register is little endian as
> described in the ASIX 4.1.0 out-of-tree driver. Correct the
> register byte sequence but also swap the configuration values
> used in the code in order to keep the current behaviour.
> 
> The endianness is relevant for 16-bit writes to the register.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
