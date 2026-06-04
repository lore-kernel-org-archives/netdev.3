Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6025228D;
	Thu,  4 Jun 2026 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615305; cv=none; b=QsdaVHvOlkxQZIzazA2eu6/or/jSIAkFDHpMuPLdR2eHr5EjvO/zsLjr+CGZVt9JqABq3nIVUUg2h2aNRsxFS/A2OLe7vax4CKkydy+octtk2fKWoYp1SzIZdCZ6x184GoYncPFy/quLp7ZweWOeiFGIJNzw3OYWCURPxOVZpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615305; c=relaxed/simple;
	bh=DNn/vtLYpIYTgOpXW91wgrzsJtSwAgf8LEb/VhCHV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxnFLzr3c6UClpmG6zloLFFF0TAJAwG2aKBnMwQXXXN6L2SXoAQANE1xRbsOLQebDnwo8/X3OCQosbeU+nB/ejZIYFXrZMg7BW14K2r2IRit4SZD0LfKNPmSqx5p0eWA5qvpKksPtzeWJ5z+rQ5vUiIC/N2MDfmiZiH/ti/yI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gst5iL50; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gst5iL50"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q1FL1hGctmdWIxgu8RucdggA7YfEHVMHB+Zw3f/cFxY=; b=gs
	t5iL50sEPVcP8hhNXiKocRciN8sKmqRhvO8WLmh/nCiCi9xZHg0r6tUAj9qoyC8UxLOWi/mRKazVM
	/Hznf0I5Dsjg7jtt6xsbueSVbMqsjCF3LJ08yNN2+zDfwCJMuA06QtpO0qNqWFcioXyqkqqVfCFis
	edAzAqfq3DgdI3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVHNS-0067X7-So; Fri, 05 Jun 2026 01:21:30 +0200
Date: Fri, 5 Jun 2026 01:21:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, cedric.jehasse@luminex.be,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb
 pcp app
Message-ID: <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>

On Fri, Jun 05, 2026 at 08:51:56AM +1000, Luke Howard wrote:
> Hi Cedric,
> 
> > On 4 Jun 2026, at 10:01 pm, Cedric Jehasse <cedric.jehasse@gmail.com> wrote:
> > 
> > On Thu, Jun 04, 2026 at 08:37:17PM +1000, Luke Howard wrote:
> >> I still need to find a similarly natural way to expose the switch’s AVB capabilities / 802.1Qat admission control. Perhaps there is none and it will need to remain a local patch.
> > 
> > There's a devlink port param command. I've been wondering if this could be used
> > to set a port's AvbMode. However:
> > * at the moment there are no drivers supporting this.
> >  eg. devlink_nl_port_param_set_doit and other return this isn't supported
> > * i don't know if AvbMode is a valid use for devlink port param, and if it
> >  would get accepted
> 
> mv88e6xxx already exposes the ATU_hash driver-specific devlink parameter, so there is a precedent which augurs well.
> 
> A per-port AVB mode devlink could configure:
> 
> - AVB mode to enhanced
> - iso ptrs to number of enabled ports * N (currently we use N=64)
> - enabling interpreting AVB_NRL entries as AVB with G1_ATU_CTL_MAC_AVB

I don't know enough about AVB, so this might not apply here....

What does the pure software version of AVB look like? Is there a need
to configure these parameters? If not, why not? If there is, what API
is currently used?

Ideally, the user should not need to know if some functionality has
been accelerated by offloading it to hardware. They just configure it
using the standard Linux model of the feature.

	Andrew
