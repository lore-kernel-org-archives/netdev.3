Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0E3B71C2
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466116; cv=none; b=LksQendQOVMXo+fCt6ZLkIBYapOkEkVE9x5bLRKZMo2esbeNOhHcMV99NLB51DRpK2D+aVWVAF+tIQuTx5xgkk5niRZLZBmshY+G+N7tP8Vz/HFaaKCHsEwzleSFvUGyCUfZakyda0dh3kMyvB2kzq8A0AaCgnmmazSC+xyu8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466116; c=relaxed/simple;
	bh=pXqYG4ehQ77DOQN7Ad3xMzIuGfYmhNA6au5HUR9v+uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGlTPmYWbQT5BkTUX20pfoSJ2ZUIE+4YOmrgw/SvH9ixEZmNkMkmnEr491cXVzf2EDSp/v/pfGLhNAZoHwB1wM/L8KiOqWKRADuN95OrnX2DZXDM4LAgVVQNQXpk71wtbhoKCWbkVapTMob0EiTzNblfRm/QNvV6EEZcZlVaFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QjDvxgr1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QjDvxgr1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RpC7UpvEikdFHrMxoFBqRs8gLudhopjObp4s6z13FEg=; b=Qj
	Dvxgr1SnQA8J7fCU7Gscmd102ArEGXa0VAxs2Af1JNl3T/+/20kzAdXVVg+pKMGlvjnu/Hzcpuaus
	q88h1E9/D5GqK17raFa5PNlCOJ8VmUlSdxGgM3/+3PqsU4O/l+srGUYRP2awaAIK4FZPYBgzsq+TW
	CPB5/7D6qUtznpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtpRU-00H7kG-Qc; Tue, 11 Aug 2026 18:35:08 +0200
Date: Tue, 11 Aug 2026 18:35:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 0/4] net: phy: dp83640: fix shared clock lifetime
 and probe error cleanup
Message-ID: <dea76ffc-4424-45e2-8871-7ef29fc31958@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <ansfeXGe8k3bwkW1@hoboy.vegasvil.org>
 <1cb3151b-3dac-4832-ac4a-b3f2b16006ae@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb3151b-3dac-4832-ac4a-b3f2b16006ae@linux.dev>

On Tue, Aug 11, 2026 at 10:34:17PM +0800, luoxuanqiang wrote:
> Hi Richard,
> 
> 在 2026/8/11 21:11, Richard Cochran 写道:
> > On Fri, Aug 07, 2026 at 03:07:25PM +0800, xuanqiang.luo@linux.dev wrote:
> > > From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> > > 
> > > The DP83640 driver shares one PTP clock between all PHYs on the same MII
> > > bus.
> > > 
> > > Its driver-local clock lookup and removal scheme can leak the shared clock
> > > on probe failure or free it while another probe is acquiring it.
> > Is this an actual problem that you have seen in the real world?
> > 
> > Thanks,
> > Richard
> 
> No, I have not observed this on real hardware.

Do you at least have the real hardware, and are testing your patches
on it?

   Andrew
