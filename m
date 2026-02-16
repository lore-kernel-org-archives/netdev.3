Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2BD2AF1D;
	Mon, 16 Feb 2026 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771209279; cv=none; b=gseeSYqR3wqh/fYwtQuJzk/M3UDz6oL5dYXkE8aZdApdOkeFrup1dyNw/ihVfWM3dSfgyQ6xOBlklKZ7t79TxTb24fyw1hepcYPyG+c2WHJiRc3AFWAv2Dj5F1/rALPI7kUfsSxKWqyDObkuXvdavFnjVFl8cGEGMX7agQKjbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771209279; c=relaxed/simple;
	bh=ivmlccJ9w4GYileQMBuvApFM33kwfBcVtrknfbZLI9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM+Jc7bs7EmqrzmDWVIo7tQj5udwplTmgu9AkztMVqcrifZl4Y3P2uCwaxUyoglHxjaUdSLHdtgRnsl+itDdFfOxN03g9Qeguebv0JPIc85gLT3W54tDUardJONfZqiWH+UVwP6cg3m1zHDwtHOS7ZpCNIXwTsnyz/LOoVgWLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=28/+TqQz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="28/+TqQz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OA3FqU37nQj5gvVOm6JffhwHBJyjidIL/8v/rSFyARA=; b=28/+TqQzk+4KasJKkudSbBIRkz
	5halP3uuHvT9sn9SlPIJd61QybOHHEUYOw89FKBZtXmrCP/6haDYJyQv0aVCeN6BkkIxx0ROy40ik
	vQs1ihAGqBZHHF7TWFkQ94O19kuJ5s0sF1EoMQD0AQZ/hHQrJTEgxck9nw26Z9hdbTic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vroRQ-007RiF-9j; Mon, 16 Feb 2026 03:34:28 +0100
Date: Mon, 16 Feb 2026 03:34:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: cedric.jehasse@luminex.be
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Message-ID: <179960d4-7963-41b6-8c1d-a09376fb0d60@lunn.ch>
References: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>

On Fri, Feb 13, 2026 at 01:48:00PM +0100, Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> This patch adds partial Ternary Content Addressable Memory (TCAM) for
> the mv88e6390 and mv88e6393 family of switches.

Have you looked at other generations of switches? The TCAM has been
around a while. We need a clear understanding of what is generic, and
what is specific to the mv88e6390 and mv88e6393. You can then pick the
appropriate function names. Anything which is specific to these two
devices needs to use the prefix mv88e6390 and mv88e6393. Anything
which is generic to all switches with a TCAN can use the prefix
mv88e6xxx. The 6320, 6341, 6352 families have a TCAM, so we need the
naming to reflect if there is anything specific to a family, so
somebody can later add TCAM support for the other families without
having to rename things.

       Andrew
