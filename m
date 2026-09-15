Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF04BD7A6;
	Tue, 15 Sep 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495938; cv=none; b=Y1WIMcH5vgvvmjhMzXSoXG2sEvOHMRXuzaHLV4VFien/Pagpzx5Fb1YJv9vC56RrQqJ4838Rof2jFPMbYnudFB7T06w7ra5FgXTHxLOuXU66YkyZHDwXtIJrCVcfN9A3q1vHWHAxIjvQPT07i/kH+SO5nx8LO7ByZYTqSAZo2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495938; c=relaxed/simple;
	bh=XB/KEQCSAc1J4gUrX3IgKw9KbyOlNAsIQ7xYJOLJ2ho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7eawuMYNGVDMzOa/7R9k7gxpUQkwOcdABXvfCUBu9374NjTkbTdR/sbGwzmQHWLMFimpIZ7mFevx8HLrtykiXBQ760HN/njWkoexqP2X/aJVcvsdXA4P+Yy0aaC1Ut1AEkgA57QGAVb6K3MN0ifffd918RI4qC5aTR0oHOlR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f49LiwUc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhstI4lH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f49LiwUc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhstI4lH"
Message-ID: <a0adf8c0f108d8a4293604b1d446b8c9eeade987.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789495933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1HS1pYOm3wOjNHIO+4Joxh2Gs5wWkLGBOA0RtJQydQ=;
	b=f49LiwUcN2wlyanQPkBlTSYuN5rmdOrejHPC2Jmejx27YX+5hS5I/x99OyjDil8S7NpeMk
	3MzTeadsHmNMQSzMRmL1pbkDBJrdVW41c7gIXjD8e18S5T6oyhpceFkA57taTd1tpGzvsS
	BjXFTH5d8BKLA5rBbzSJHwqtqGdTWCFauK94TKi0xgNSgWXD1iWuu7KobUH+eB4GibtPsW
	Uz4CTWQfK1MWym7aJR0Ex0GFokbPFEgvd/haL6QruJfaycXviOsjXao/M46NFB3wFQ1kFI
	dhy5DbxbQbLAKNgbcEIr56enrCfDo1rrsdeVLGdn+itAIybIRjyPOcfyrYFR6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789495933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1HS1pYOm3wOjNHIO+4Joxh2Gs5wWkLGBOA0RtJQydQ=;
	b=bhstI4lHFVpXgoTQAAkmblf0vq4BrRKfQ9pnOQKoPDp3FjmLWVX8Z72RewoKhqvZikrb+/
	3zsu3L+1k3PH+AAQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Tue, 15 Sep 2026 20:12:07 +0200
In-Reply-To: <4dbeb7cd-d9b6-4e95-a586-800ea133c2a8@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
	 <178895594761.219967.4769482322073838475@kernel.org>
	 <c863e105257ae512d32e94b56ac081c41c4284f6.camel@linutronix.de>
	 <4dbeb7cd-d9b6-4e95-a586-800ea133c2a8@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 14:56 +0200, Andrew Lunn wrote:
> > > After an unbind or rmmod, does the core keep inserting SDSA source-po=
rt
> > > tags into every frame delivered to the CPU port, with the tagger that
> > > would strip them gone?  As described in the commit message, the same =
bits
> > > also keep the user ports in CPU-directed operation:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0"Enabling this tagging feature of the switch,=
 places all user ports
> > > =C2=A0=C2=A0=C2=A0=C2=A0into CPU-directed operation"
> > >=20
> > > so the switch would also stay locked out of normal port-to-port
> > > forwarding after the driver is removed.
> >=20
> > Yes, I had not considered this use case. The tagging state currently
> > remains enabled after unbind or shutdown. In v3, I will add a .teardown
> > callback that clears both SOCE_TAG_ALL_FRAMES_ENABLE and
> > SOCE_CUSTOM_RULES_TAGGING_ENABLE, returning the switch to an unmanaged
> > state.
>=20
> I would say the AI is wrong here. If you put the switch into unmanaged
> mode, and don't have anything performing spanning tree, your network
> could experience a broadcast storm and stop working. The .teardown
> should disable all the ports, leaving the network in a safe
> configuration.

This makes more sense. I see that other drivers use the .port_disable()
callback to deactivate the switch's ports in this case. I would prefer
to add this together with .port_enable(). This should be enough to have
a safe configuration for the network if the driver is unbound.

A global reset or deactivation would be nice for teardown, but there is
no such feature available. For the sake of completeness, I think it
would also be valid to reset the modified bits in teardown() as proposed
by AI.

By the way, there are two registers involved: One for port selection and
another for port control. I would rely on rtnl_lock() and avoid adding own
locking mechanisms since these registers are not used anywhere else.

>=20
> 	Andrew

Thanks,
Vasilij
