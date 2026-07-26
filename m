Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38B3FFD
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101317; cv=none; b=fpj8bz0KDXXLQjCc/1OoG8L+zBqd4/3u0MxsmJJmu7DdUQctv8ZOeEhu+TyjLNCp6VLdzNvkXiXeHVJ+J621ehVOY85vCXAosXB1IsAnLOFtpSuwg9cnsOVlN7Mm2t+3EFubdbB5vh8cnNO9DJzW0yPJQd7orEmiJr1dUUvlhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101317; c=relaxed/simple;
	bh=Zq4dt2Pq1oxSkYGRwJoMJ4gy3sib+RU3ABnRuC3dLhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc10ykajuADtso5czxfm1tXp12KAqQBw9bUQ0WuwAqkCSmtOZ8zC8iZhXpntMkC6BdQ73I4WCpUMvybHPJ8Ao/XRw1uQbhm2uhPL+HQom6uI3Cg6paEm9vC9Q7uWIhIO9s4Htm2irbu3084CDHgGNOvMIj6jJl5YHmImcTCKP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hSwhR9sA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hSwhR9sA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jyx4DpGjtk4pwbQpOvEAqvlhBX2YW9nbFGgDjDmBLDA=; b=hSwhR9sANE8j+mM3qmNxfJXuGI
	OXpu0KNL9O8TPuiovcM6sZEyyQ7vKT47e3wZVrt673dGkwqrKSkWiG3snZBLZ+yQm1vfVWlAJ2Kio
	7lIeYhygjagZqWoRS1VHeurmb9aSHTpJDLWS8KUW2KZGLfd1XRZPUA8JiWx0nRF79SOk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo6OU-00EL0z-H6; Sun, 26 Jul 2026 23:28:22 +0200
Date: Sun, 26 Jul 2026 23:28:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, dietz23838@hs-ansbach.de, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Message-ID: <baa3f76d-ef8d-43bd-b72d-d9b67e33a738@lunn.ch>
References: <4e09a943-d116-452f-93f3-93fb363b09f5@lunn.ch>
 <20260726190920.744842-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726190920.744842-1-simon.dietz@plantwatch.de>

On Sun, Jul 26, 2026 at 09:09:20PM +0200, Simon Dietz wrote:
> > This then leads me to thinking about having two nodes, one on each
> > end, with an Ethernet link between them. Ethernet, or any cable based
> > medium, has different semantics. A broadcast is received by all.
> > There is no point rebroadcasting on the same interface.
> 
> That's a good point.
> 
> > But what about the fixed infrastructure? How often do you see nodes
> > along some sort of linear structure, connected together by cable?
> 
> I think there is a use case for fixed infrastructure, e.g. to advertise
> road works or closed lanes. I can't remember that there is a use case,
> where nodes of a linear structure are connected together by cable.
> 
> > Or a row of blind corners which is known for accidents, you
> > could put fixed infrastructure along the way and cable them together,
> > so the vehicles can "see" around the corners?
> 
> I think the most canonical way to implement this would be to use
> 'repeater' nodes (e.g. traffic lights, electronical highway signs),
> which forward these warnings via topologically scoped broadcast wide
> enough. But I do not see anything in the standard(s) that would forbid
> such a connected by cable bunch of nodes approach.

Or a GSM link, or even GSM-R, etc.

At minimum, the architecture work being done now should consider
it. I'm not saying we need to implement it, but we should have an idea
how it would be implemented, and ensure what is implemented now will
not block it, but make a good building block for multi interface
heterogeneous router node.

	Andrew
