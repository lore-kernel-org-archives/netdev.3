Received: from linode.cmadams.net (linode.cmadams.net [45.33.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCB3C6611
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.75.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916439; cv=none; b=gsR6/DxPbD0qQGbWHe6gmQbzbWETRS8iz6U/c8UU/vxqTub/GmacL3pZjwpMgMeV/NebiU+O1zGZ+iZaptPgUbKvEZO18V4M5aQvjSULg8ZPAkXNEr125dPVapfpyrK0OAGW6davoFMAUZILyYg00AVBjkz/KOjUXn4drxw9kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916439; c=relaxed/simple;
	bh=fFgXvX91shjT46LgT24NDLGKyFLIO9OYKbQX843VeKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMVDgVm1JmkDkMeJuverWGzo3z5Uj9fhcK5TPG4sGeZYi+66tE3lIp40hQOm7DJWygjR6Q4UPy3OMUzNSVZ4F+ry6rGC73XdiuSS81oPdVrN+AI2vGiDNddq2JboVvekIMA1JoVzMGu2EO7Zx1gJdNiJ1j+8guU7M946Kie413A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net; spf=pass smtp.mailfrom=cmadams.net; dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b=Ut2/Eomk; arc=none smtp.client-ip=45.33.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmadams.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b="Ut2/Eomk"
Received: from localhost (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gQj6F301Lz6vkp;
	Wed, 27 May 2026 16:13:57 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cmadams.net; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received; s=20220404; t=
	1779916436; x=1780780437; bh=fFgXvX91shjT46LgT24NDLGKyFLIO9OYKbQ
	X843VeKk=; b=Ut2/EomkxuteuIE0Th0rISVJvZUW8dfKi6m9uszHFA/YAtEARDx
	VtjWMiloVtyDw0uE7IFnmDjycFNo3eVRr4yfNgzIHppxFDDY4jBQ00AZGD+x7eQA
	GbYNKvcGls6ohVhnZYnIB7yvvyCT3cFR7mLKDunpknotmOZvEZWI401AN1StvDdw
	wszkT6SsJFxzBzlPTNL1jAEFHBy4fDpIQk9muDvJIcGGiCMHtGZJLHRDv7qB81tq
	c3owOxESl2Hbd3BOaYNk8zOvaSHTPMMepFkQ7BumpWqJXGcnrDuw+481GCK4uoPE
	rIIo7B4njNuPD3ZGLlO28luecRn1UpbWLpw==
X-Virus-Scanned: amavisd-new at cmadams.net
Received: from linode.cmadams.net ([127.0.0.1])
 by localhost (linode.cmadams.net [127.0.0.1]) (amavisd-new, port 10031)
 with ESMTP id fjomEDCIQTD5; Wed, 27 May 2026 16:13:56 -0500 (CDT)
Received: from cmadams.net (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gQj6D4JRSz6sQd;
	Wed, 27 May 2026 16:13:56 -0500 (CDT)
Date: Wed, 27 May 2026 16:13:56 -0500
From: Chris Adams <linux@cmadams.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ido Schimmel <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260527211356.GA16443@cmadams.net>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ido Schimmel <idosch@idosch.org>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org>
 <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526183122.348e44e7@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Once upon a time, Jakub Kicinski <kuba@kernel.org> said:
> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:
> > > Hi! Adding more people to CC. Do you know if you upgraded from 6.18 
> > > or 6.19?  
> > 
> > It was 6.19 to 7.0.
> > 
> > > Would you be able to try testing with some commits reverted?
> > > On a quick look the candidates would be:
> > > 
> > > cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")  
> > 
> > It's this one.
> 
> Phew, the second one was mine :)
> 
> > I figured out that it happens after stopping a VM (and I usually
> > start/stop a VM for a bit in the morning, which is why it happened more
> > than once).  So I set up a VM with a nested VM, running up-to-date
> > Fedora 44, and then was able to bisect pretty easily, and it landed on
> > this commit.
> > 
> > Fedora is using NetworkManager, and IIRC NM does some part of privacy
> > address management (right?).  NM didn't change, so maybe this commit is
> > confusing something in NM?
> 
> Sounds plausible, pretty sure we knew this commit was risky to begin
> with, but we had no direct proof that it'd break real life users.
> 
> Revert is the right course of action here. Would you be willing/able
> to send the revert with your problem description and a Fixes tag
> pointing to the reverted commit?

So... I'm not very git-fluent and haven't submitted a kernel patch in
many years, so really am not sure of the necessary/proper steps.
-- 
Chris Adams <linux@cmadams.net>
