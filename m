Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572303F9A0E;
	Tue, 11 Aug 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467020; cv=none; b=qIQaoVnn0Y4DPr0nhcZYB10/D8a/UVA4/YsOfFgWIQMU7AjX0MEGK/yeLzDtkhWJK74FgN7u8AOQAOhiXEi6+q3Cgk9suZ73C4jC7zjz6cW+27cn0mov1qmGEauoqpqm3+0BHicphp9NKa9fARnactfbQiU0S3NGhA6s15de7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467020; c=relaxed/simple;
	bh=ucH8eor/BQmPbq7u+tdvqwOYo4KpP9aIXgy+a8/Ylys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAC2zDESSIBOiffZtffY5CtSAKRODZdej/6OCT/545UPX1dVqPBQARoyjGjiKHzIUpnAPVQKED42ZOcFQmW/gZhyduV9f7mgW5CnJlbV1z2S9QUueKfPNx9KTs+wOUJDV5mJm0OlakQQFiqXz/m9ulfHEJZL/wwc611NdZR4cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W/Kg3GG8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W/Kg3GG8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pa/xq65zYzfXuELw/850fdvoELCyB9BKdLBh1/QrnZo=; b=W/Kg3GG8IKA5pQAP/DgSAJDvN6
	ozM+p4QeIRIoh1zf8uh3JyWtcyKEfsoXnn/1h4xA6C3I/nKq9mBV/dAAFjcR/9pNTwtgNQ0xbX4My
	dBduNcwOzAnLZrHpIq0jNjes1Y+xAVfMICmsZwmtB02DL/NYecnbOWIZOha5UWGdc1r0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtpfz-00H7uZ-Sx; Tue, 11 Aug 2026 18:50:07 +0200
Date: Tue, 11 Aug 2026 18:50:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] dt-bindings: mfd: x-powers: Add AC200
Message-ID: <1302502e-34b7-44d8-8457-f2a9586a61a0@lunn.ch>
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
 <20260809-submit-acx00-of-dynamic-v1-v5-1-bfa1f8518b28@gmail.com>
 <ec826a71-bf33-44cc-80e0-dfc7e92ceb61@kernel.org>
 <CADvTj4r==rKP4ThVZog51MQ2AVDLZNFwrPH+uDLFV2wGZueAtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4r==rKP4ThVZog51MQ2AVDLZNFwrPH+uDLFV2wGZueAtQ@mail.gmail.com>

> > Bundling it together suggests this is somehow incomplete and later will
> > be finished, which is wrong by itself. How to fix it - decouple
> > dependencies.
> 
> Could you clarify whether you mean that the MFD and net changes
> should be sent as separate submissions, or that the driver
> interface should be redesigned so the net side has no dependency
> on the AC200 MFD provider?

There are two parts to this.

DT describes hardware. The hardware is fixed, so you should be able to
describe it. Ideally, the DT binding should not have an Linux
concepts, or driver concepts, since that is not hardware.

The second part is, the MFD driver should be merged via the MFD
tree. The networking code should be merged via the net-next tree. Each
patchset needs to build independently. It does not matter if they
don't run, probe fails, if run on their own. The different patchsets
will eventually meet up in linux-next, and get merged together in
-rc1, at which point they should function.

If you have any build time dependencies, you clearly need to state
them in 0/X patch of each patchset, and explain why the build time
dependency exists. Sometimes they are unavoidable. If that is true,
the different subsystem Maintainers need to work together. Sometimes
one subsystem Maintainer gives Acked-by:, and allows another subsystem
Maintainer to merge the patches. Sometimes one subsystem Maintainer
will produce a stable branch, with the other subsystem Maintainer
merges into their subsystem, resulting in the needed build time
dependencies being fulfilled. This requires Maintainers to work
together, so you need to make it clear in the commit message this is
needed. But ideally, you avoid this, subsystems are mostly
independent.

      Andrew
