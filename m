Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4B3A5E88
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943355; cv=none; b=W5d2ozTNg77X+JC4vMxU1ffqEaQAfEgPibneW+su7NFzwGlil1HB5b9Mt4koA2psnPKh/BVpJ7rV4+j2wOXHa9UPiQf9gICFRyQLe89o2U2WXJ6YWrqhSnfHqDoe4HUaQl6e/+b7lGlZNNjYsv91ATX4KNADMsqeLaiRM/GQJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943355; c=relaxed/simple;
	bh=kr4bcxC/dJNL/p9YnDZFXA1SkXrSGQVEM/mRsdYVN08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghxo51Pe8KQIGup6BUttZH3w8GkZQhuwmw1RrLA2RFYsmc3ZfG7RJhDj+spb1neghPlxTcCad1FPMffkLzcDzppbTmTAMVgcI0dmpyEWcx1gLPmjIChOcdnQgvi4qKY4pyWTNYxyZD++FMOV4axlDPBOF57DOz4ZBRm0CmudjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rAtKKDui; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rAtKKDui"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a7PRHhd25zJ9fx+ykVI+yclz/Tlnz81LDvMfvcCb4mc=; b=rAtKKDuiBdLEh0uFWgNQule/2u
	p05BlRPnzNFUWpKlbU39EjiUjUkLQ++vjmd7xXYVwLIvkEThYH7swr5lT9uxzG5ejDRIO+8SxKLCd
	gIx+emqWrUowMxqhn4hNPYOWfzZqNf0xvA3RuMlj2L4RMTyIdWGVexGukY2RG5qSVDEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wf30n-00AFZv-0C; Thu, 02 Jul 2026 00:02:29 +0200
Date: Thu, 2 Jul 2026 00:02:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Cc: "Das, Shubham" <shubham.das@intel.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>

On Wed, Jul 01, 2026 at 09:38:08PM +0000, Srinivasan, Vijay wrote:
> Hi Andrew,
> I think there is a disconnect here.

Which proves my point. The specification is not sufficient if you have
to keep correcting me.

The kAPI should be understandable by somebody who has a general
networking background. Please write a specification with that
assumption in mind. Don't assume the reader is a test engineer who has
used PRBS for half his life. Assume it is a brand new test engineer
who is hearing PRBS for the first time. That is what most engineers on
the netdev list are. Me included.

    Andrew
