Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B8407576
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541712; cv=none; b=Ef0FUO/9yhDAfyrLGw8OYC/2x1PcQv6k39Q/FMvL8VMwZoAwWVPM/LcWX4Pm4a9HZ0DyJEaeo99g1TrGnnPf4pRoFfmGqyfqdx7SAmWb6UmCtqMjDqM1/j/0iKAh6qfQCK9B3F46yir/0SyuaxOfTcVWCPv2aOfOYEUdqKDihzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541712; c=relaxed/simple;
	bh=aEgAklpRBSGgQsxPlcirvNkNDm2LVAYJxxP9jXC/Wxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5U6gHdhVjbFJXb12FAp/VjGkr0QfZHtt/D5upgda/pNoMnmnQIO1IPeQNobw1+y8yG+QfANjA1ny/3T3TWXr6A8R3ZnIf6ni76tsoVMliaakvDFD56RSgu+yqMM96mIKlNhFZesAKO4YVWf+SmuEKfBj+mcVvcC1rwbK4HGodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wpN356hg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wpN356hg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1feUzV+qKxhM/bwZTbO91sNKEd6o+oGqSqcybnfFb7w=; b=wpN356hgfQ0aAux7PwYMbOnW8h
	SSnMbxaQiiEj9TkWzC8XlQGRbbndOaXcnX+GXXFQDIVS8sUb5SGA/iNr3NztkZc7wraEvlTL9Nicj
	/Dnj0h+RW5DMHmQkSmWZnDTi6xmg8MIy3DGjun5d+xySOq/Ay27r8wUrzqB05OEa75vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZANb-007pjm-PZ; Mon, 15 Jun 2026 18:41:43 +0200
Date: Mon, 15 Jun 2026 18:41:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Helge Deller <deller@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: e1000e: Report link down after "Detected Hardware Unit Hang" ?
Message-ID: <e78576e0-9b55-446f-9d10-da3b7aec9b31@lunn.ch>
References: <ai8hmGQmXQu64Ld3@carbonx1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai8hmGQmXQu64Ld3@carbonx1>

On Sun, Jun 14, 2026 at 11:48:08PM +0200, Helge Deller wrote:
> I'm regularily facing the known "eno1: Detected Hardware Unit Hang:"
> with my on-board intel e1000e NIC hardware.
> Since none of he various tips on the internet helped, I had the idea
> to setup a master/slave bond networking to fail over to another NIC when
> the Intel chip hangs.
> 
> Sadly this doesn't work as intended, because the link of the intel NIC 
> isn't reported "down", so the failover never happens, unless I manually
> start "ifconfig eno1 down".
> 
> My question: Shouldn't the intel NIC ideally report Link Down if we know
> it hangs? That way a fail-over should at least happen, right?
> 
> Below is a completely untested patch.
> Does it make sense that I try to test and/or develop such a patch, or
> are there things I miss?

If the interface is dead, then setting the carrier down makes a lot of
sense. One question i have is, what do you need to do to recover the
hardware? Will it correctly set the carrier up when you do the
recovery?

Also, just looking at your proposed change, it is not clear to me why
such an assignment will result in carrier down. It would be good to
explain it in the commit message.

	Andrew
