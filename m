Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F52E2DD2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012326; cv=none; b=p3ypcLgrpH45dJn8STmt2wDGUn4ONbQjVJtCpHQaBcn2uIFofCawnc2CajZjzTW+95AYDVNt5eYLNi94RSeKZqsimsJaFCQInt29TJQSkGusnO+mQiTpM7iZL1j/Q+PG/CjnucgXGsndpqFr6OoPHEbJzc6kwFwDsmzgAZUa3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012326; c=relaxed/simple;
	bh=of+IMlpL/ueIYjyYjfkeQwS01D5npHn3fFrdzcOeoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSXVnu85GbrXEnu8i9niah9dIIXh4pXW1eBD4rt0HENxDSnSGAWO6exA+aTzAzNNLW+DOAA81vt6BCOzKB4/RjyipNxKgey44oVjN3nfARMd14AgT/OS6H04pMObNogHbkTDdgTmMJa7cYEE7EtmFGlJ97whEITBNJ7ZAZWLLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qZtCO5ww; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qZtCO5ww"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4kYkWk7jJTX5/rLh389qM70iGgCvsYRDdhOQSw+Cpp0=; b=qZtCO5wwC9pY2Ql3t2EyCjzQgF
	8lR3jDAW7r6hzfu2tMvRoFDDig4k3Vrrk/Ma0kxpM4oJ9jvwe2TXuqddbmhGRxbHafNVm7G9ydUS/
	MwNU/7cWO/ygSLFZls86N/eLRYnqwCUa2/YWWLsLaxojco36tOGXjV1dinzqjj2J4N0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfKx1-00APCb-Ik; Thu, 02 Jul 2026 19:11:47 +0200
Date: Thu, 2 Jul 2026 19:11:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddaraju DH <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	netdev@vger.kernel.org, Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <e9349915-df99-4d93-bb2b-f17686266a38@lunn.ch>
References: <20260702145326.1024800-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702145326.1024800-1-siddaraju.dh@intel.com>

On Thu, Jul 02, 2026 at 08:23:26PM +0530, Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> This change follows the conversation from netdev mail thread with
> subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"

Please add a link to lore, it makes it a lot easier to get to the
discussion.

Link: https://lore.kernel.org/r/[Message-ID]

    Andrew

---
pw-bot: cr
 
