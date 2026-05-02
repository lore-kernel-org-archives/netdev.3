Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080064A8D;
	Sat,  2 May 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730134; cv=none; b=caHUigvSCT1Ylu2te7wnvApwUNDeXUIUFqFkIiM0FPPUjUw0qoQOjNSdz7ivsdp3znNN+FhjKRPyUlZ6ATcKNoLRskbQR2tqnxMlqsJMGNReQBMcGLl/ZsGQi7KBNCYzxKWKbuDTXwB1jO60h/Nxf2rQ030cbrZWM9lcs9dQBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730134; c=relaxed/simple;
	bh=t9oBGeGcUO/9i3aC5oytnqhloqSO4iH7pgfI3Ba2AF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCYk3TVuoq42z4JKHf4NZgmNm9FnBJIsLDi3padnW/wpZqnfAQvWS1k3ApLkBEkZYZ4KGLh/3hmxZKVMuCSTixYGNg7mun3VrZJeA15fIrnMFNEHGRQ4toByxAJ3BPhTc7MPE1onAnFwE+N1CXVWDivsJ3VDtO/z5Dh2FxuX6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SQ7VTlsD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SQ7VTlsD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9MC3V3WbftNVQMDQppdCT6g39DNecez+4SOTQ/7N3tI=; b=SQ7VTlsDhhcbAd1wvQCfLhMxSR
	PFUSK+OYA9tkDbtgp/KUYNG/fvsreMdvu4y3pdsQxFeGedWzTB6AXK/XlUCceEZ/rEc3LoBwNO5eD
	hbbkP6h6SiogPPoVkaaKsiSGRiDtp0hG7WGt0APPvfLtjP81cXGWMqnYkdVzzekgt9JQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJAoU-0011Qe-Lj; Sat, 02 May 2026 15:55:22 +0200
Date: Sat, 2 May 2026 15:55:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.eckerman.ext@ericsson.com
Subject: Re: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes
 functions
Message-ID: <beb7aba4-d704-4112-a29d-0382c31e0c2f@lunn.ch>
References: <8f2a1956-5cd9-4267-8035-b81024148a9d@lunn.ch>
 <20260502092552.2217977-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502092552.2217977-1-fidan.aliyeva.ext@ericsson.com>

On Sat, May 02, 2026 at 11:25:52AM +0200, Fidan Aliyeva wrote:
> > > I wanted to make those functions generic and not introduce new 
> > > functions other than 6321_serdes_get_lane. However, those functions 
> > > cannot be generalised the obvious way because they run with reg_lock 
> > > already taken which would cause deadlock in mv88e6352_serdes_get_lane function.
> > 
> > Ah, the scratch register. None of the other serdes_get_lane() functions need to read a register. O.K.
> > 
> > So we don't expect the scratch register to change at runtime do we?
> > 
> > Nope, the value in it is read during reset. After that, it does not matter what happens to the pin, the value in the scratch register is fixed. So maybe read it during mv88e6xxx_setup_port() and store the value in struct mv88e6xxx_port?
> 
> Hi again. Thank you for your feedback. I can make the proposed change. But
> I do not have the functional specification for 6352 to refer the change
> to, neither do I have access to a 6352 to be able to test the change on.
> Do you have the functional specification document of the switch, maybe?

I have a 6352 board i can test with. It does not have any fibre ports,
but i can test it does not deadlock, or give an error message about
the lock not being held.

  Andrew
