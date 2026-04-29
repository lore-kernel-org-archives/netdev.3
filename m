Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC67318ED7;
	Wed, 29 Apr 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470881; cv=none; b=dImRA6x1ubvZ+wZw8Twt0rmugF5HYSspycxXSDxo1ULjPVy7UflxJiFDJW3hbpI66/elNRt6w6cU+l8L8CG1IDqUdUUdGvP66QV+Zo7mI7X3Rj4JUlyOUiphZ5f7/H4Uv7X9wOGM8xI3gz3fmp63LAiT8bLifYFK98Bu30Z+aC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470881; c=relaxed/simple;
	bh=O4bgBETT1z3t80wIJE8g7HZaPoA/Uc7S4BtPBGHP3cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=genf1iYkhnvdX/5+prHq7JCNmClH3wGnQI0mdY20M0WmyKzOsWQnVGMhMeCaWrUSv1A5gFUrLI/SDHc3fD/PNcr0/43G23V18zGWVNqqoyxa/Vtzf2cnSnONLYwhoI5Ran5uf6KmSBMgKyN8g9r077DxeJ/JQb036SWC8TuIyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t0BofWe8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t0BofWe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gurPl95Y8RA5wA7irk9s78NB3frlHqKbcjg55mzKfUA=; b=t0BofWe8krNNC7K618DRbDgmUv
	O93lEP5QLOb/dKcTwFUQIDNynOFWoRXLPvaSgaNNdg3y2hkyGzjpxh9HTInwCB4PpubKH1YuZNssw
	SGMRor4ow6OKqCLBYiQccw/yVd6q08QuYaZPsOaTRacAcMK+9/xvwRhDM2Kz4WnxOTY8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wI5Mw-000XWe-V3; Wed, 29 Apr 2026 15:54:26 +0200
Date: Wed, 29 Apr 2026 15:54:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <aadaf747-12fe-40dd-90f4-7f170b68c8f2@lunn.ch>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
 <20260428172810.175077-2-mike.marciniszyn@gmail.com>
 <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
 <afHfFj0CkBUIQxRT@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afHfFj0CkBUIQxRT@PF5YBGDS.localdomain>

On Wed, Apr 29, 2026 at 06:36:06AM -0400, Mike Marciniszyn wrote:
> On Tue, Apr 28, 2026 at 08:11:30PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 28, 2026 at 01:28:07PM -0400, mike.marciniszyn@gmail.com wrote:
> > > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> > >
> > > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
> > > Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> >
> > Please don't mix fixed and going development work in one
> > patchset. They should be applied to different trees, etc.
> >
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> >
> >     Andrew
> >
> 
> So I'm guessing I need to send the bug fix to net instead of net-next
> and reissue the patch series?

Correct.

You also have access to some good mentors within Meta, maybe reach out
to them and do internal reviews before posting to netdev?

> BTW, the review notes that the patch wasn't sent to you
> (https://netdev-ctrl.bots.linux.dev/logs/build/1087030/14544928/cc_maintainers/)
> but that is because there are two addresses for you:
> 
> grep Lunn MAINTAINERS
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew+netdev@lunn.ch> <----
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Andrew Lunn <andrew@lunn.ch>
> 
> That seems to foil my scripting.  Is MAINTAINERS wrong?

No. The +netdev helps procmail separate traffic between run of the
mill netdev deluge, and email specifically for me, so they go into
different mailboxes.

	  Andrew
