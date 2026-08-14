Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566926A1A4;
	Fri, 14 Aug 2026 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668272; cv=none; b=nNqezWJ5GrJ/uBpObdTq2qXAIPd4FPUm1myS1WVk/90dic2MSa9vslY0nn4McgZHCd9FvvjdoMQVhJInV+5kIuQEzuH0ptgRayAsV3wS/hR/rVwIiPgFX99RZklpJOwAGwbZppsU2njaYWkc0+AuxfkvKRGtuQMdEDXfEGtAllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668272; c=relaxed/simple;
	bh=LhVlxNN3jvA/l5gpfa9/ZaNbEbKfUkv8Yc9IYae/Y/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEUhfObP2cjzXVacdk3KIXuJqJHnVpTrTIscBVa+SRj/KfnwQd+2OzxItTE1v6JC9JvAI20rSC4h/MPDBDKzGCNkEfeyuJZeQgo65hTbNx9xtkFOtKGlRy+3iI2EX6mxekEMJQEvOlRQV5IToz2LKDYK/70n+0MhDKWt8V89Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4qgzIeLB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4qgzIeLB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wUZxdmhlCblRJR1IqF9OBxvODhE3LY7hit+LlMALFso=; b=4qgzIeLB5mNwp/DSDHAqA/+z7Z
	ZIwCSgJOhLhP2HTpGw+iAMWgPIJUpooAzuOzGkMgl2i3QS6qG1y7E/0ssF+c9J0a1zyIomZUTLYic
	hPCjpYrT6Tt/WecvNb+FRRTyhp9IqhabOaMpCW7gXY+bvwUfz3Ou+RpBW/fLCD7HmvyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wug1r-00HVrL-CV; Fri, 14 Aug 2026 02:44:11 +0200
Date: Fri, 14 Aug 2026 02:44:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ruoyu Wang <ruoyuw560@gmail.com>, netdev@vger.kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Message-ID: <0ad34e55-8f3f-4847-a885-854ad62afc9f@lunn.ch>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
 <4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>
 <9ee8e417-e626-45c3-8c4d-cd605123ff37@lunn.ch>
 <an4pYO_Co20iITY4@penguin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an4pYO_Co20iITY4@penguin>

On Thu, Aug 13, 2026 at 11:30:24PM +0300, Nikolay Aleksandrov wrote:
> On Thu, Aug 13, 2026 at 10:25:13PM +0200, Andrew Lunn wrote:
> > > By the way you haven't CCed the Fixes commit author (me).
> > 
> > Hi Nikolay
> > 
> > ./scripts/get_maintainer.pl drivers/net/bonding/bond_netlink.c
> > Jay Vosburgh <jv@jvosburgh.net> (maintainer:BONDING DRIVER)
> > Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
> > "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> > Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> > Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> > Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> > netdev@vger.kernel.org (open list:BONDING DRIVER)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > You are not listed. Maybe you can submit a patch to MAINTAINERS?
> > 
> >     Andrew
> 
> I didn't mean it as a maintainer, it is customary and good practice
> to email the author of the commit that introduced the regression,
> that is all I was trying to say.

Interesting:

scripts/get_maintainer.pl --help
usage: scripts/get_maintainer.pl [options] patchfile
       scripts/get_maintainer.pl [options] -f file|directory
version: 0.26

MAINTAINER field selection options:
  --email => print email address(es) if any
...
    --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))

So it should of done it, if it was run on the patch, rather than the
file.

I wounder what "b4 prep --auto-to-cc" does?

  Andrew
