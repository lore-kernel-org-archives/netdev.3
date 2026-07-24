Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37302233926
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852941; cv=none; b=QLqk7FoGW9AmAa0CJvLvJ7d/DC8lNYeu/v67u7aFu0/4oigK4e6T4acoaYrUaLyg24Wawd7cSIkz+hDXRINvh/WG2JVs1LIWBbCHYT++xDWlye2/0UXTZJ79oLi3P9HQQcX5HHinJJJ2qts/fTSunlH/8xxurWleQKErW1akhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852941; c=relaxed/simple;
	bh=27K8zPeq9v6VIyhMyXhb9p9KdblK2AXvQHVlHUIx43Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnr1WcciYLKa3N3V8F15r4bxvA8GewGmphBaJeoYKNsnR9MKJUNKGQWjOGElZ0YZobCI6IlVi/b5sFexMAY9kML+mIm4WO2z1WRrtk2ozLToH/UV8un1PxhRJ1owQ0iUZhCrCVqc8V9RgKx+ss5ESqEVINqPuHDqvKD8bYOSroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4b1ITB+a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4b1ITB+a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=geXBml1DYdmzEIz1isJ8ZpANtIs20WIb9iqAd2kxfME=; b=4b
	1ITB+atYECD3/l4OIfIsSFxjURkBa42TKh6DjDhxYvq/xgrYk5N4b6PRhI4JoETKAaVc/JVEq715N
	URQ8I9FlU/ly6UOuTqa4p5Ap9wnIN6IZ7olzIP7txp8Van11RruknHSZkvfLG8VAz2wZJj7xGwCO3
	nijvW/xBkrdANp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wn3mO-00Du3o-O4; Fri, 24 Jul 2026 02:28:44 +0200
Date: Fri, 24 Jul 2026 02:28:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: danieller@nvidia.com, mkubecek@suse.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jbe@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
Message-ID: <0fe056aa-5725-44d1-934d-c5bf3ed3001d@lunn.ch>
References: <20260719090458.659332-1-olek2@wp.pl>
 <419c2df7-6a46-47da-b4eb-e1a2f34a43cd@lunn.ch>
 <d3665805-2084-432e-b438-4c0e5969ff80@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3665805-2084-432e-b438-4c0e5969ff80@wp.pl>

On Thu, Jul 23, 2026 at 11:10:18PM +0200, Aleksander Jan Bajkowski wrote:
> Hi Andrew,
> 
> On 19/07/2026 17:54, Andrew Lunn wrote:
> > On Sun, Jul 19, 2026 at 11:00:35AM +0200, Aleksander Jan Bajkowski wrote:
> > > SFP modules implement multiple options. Before the “json” option was
> > > introduced, all options were listed.
> > Hi Aleksander
> > 
> > This is a common theme here, the json option. Are the three patches
> > for things you noticed for devices you have, or have you analysed
> > those json patches and think you have found all the places it broke?
> 
> I think I’ve fixed all the broken places

Thanks for checking.

This is one place a unit test would be good. It would be nice to be
able to read the SFP data from a file, and then compare the ASCII
output with a static copy. Things disappearing would then cause a test
failure. Also, we have had issues with the generated JSON not actually
being compliment to the RFC specifying JSON. So maybe trying to import
the generated JSON using the python parser, or feed it to jq for
validation would be interesting.

Do you have any time to work on such tests?

   Andrew
