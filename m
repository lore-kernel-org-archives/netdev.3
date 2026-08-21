Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F652CA6F
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276789; cv=none; b=DEQigWsBQTc4I7GalJ+5Ad+799OxzpS+kpo3r6pGSPvVid8b4Zi0ceyaSgczdG7YddYcnw6/Hdkfl8VeJqpQFO435LwJmfV69Y+7DndTorCBk7vgdw3EFVOEl4GOZ6Di2MCqwPxBUE9IMgrm88Yxb6JGNbPqmTEF64nnrE+nI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276789; c=relaxed/simple;
	bh=jKd+yWtRDlRd1AT3zOBu/embSJE1Eo1+9tvjgC8VeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWz6KxDlAX9vVfeKxLL3Yq96ZHh+z0xB3eQjqohE8LSN3Mbf4vrvakJbNEAaS+Dfqllh+s6vDLxUyXw70uWT3bIqVJhXZ2RyxDmAV8HJzGhMss/Hcws09oPblgieuQcLuqeZIKQub7uToJ3iRUsyUHxW/1eAOzyKsMFg51jnlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uaBDSvXu; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uaBDSvXu"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jKd+yWtRDlRd1AT3zOBu/embSJE1Eo1+9tvjgC8VeJE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787276785; v=1; x=1787881585;
 b=uaBDSvXu0LHt5jdXMPY61KI9CCCqeYLxj0t09ydmqAGI89GbVpVXDtpeCtFlG2weG8U3XNIQ
 8X3AnF8UILGYDVXBh1NCistxEDCFwqjcD1r3vepQP7mtbZIzKOPBcbB/fr/IeBRWa1u0kiS8OlM
 dSjI53ad0vEZQ+B/OOVsNvJI=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.152)
	by smtp.migadu.com with ESMTPS id 00e634a9b509dad3;
	Fri, 21 Aug 2026 01:46:25 +0000
X-Mizu-Trace-ID: 00e634a9b509dad3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 09:46:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>,
	Aswin Karuvally <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <aoet6aHyJI5lGNOX@fedora>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
 <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
 <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
 <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net>

Hi Oliver,
On Thu, Aug 20, 2026 at 01:06:18PM +0200, Oliver Hartkopp wrote:
> Hi Alexandra,
> > > How would bonding modify dev->ml_priv?
> > 
> > Could you give more information about this?
> > I hope there is no issue for qeth_l2. There we use and rely on dev->ml_priv.
> > 
> 
> I did some more investigation on all this.
> 
> There are 5 drivers that are using ml_priv:
> 
> - qeth
> - ctcm
> - cxgb2
> - i596
> - wilc1000
> 
> where qeth and i596 are using it to store a single pointer which can also be
> done by adding this pointer to their netdev_priv structure.
> 
> wilc1000 assigns ml_priv and never reads from it (development leftover).
> 
> Only cxgb2 and ctcm use it in a more complex way that would make it tricky
> to move its functionality into netdev_priv without having real hardware on
> the desk.
> 
> Either team and bonding do not fiddle with ml_priv on their own. But they
> make assumptions that best fit to ethernet devices where they don't care
> about nor copy any ml_priv pointers.
> 
> This caused a problem on CAN devices that were not created by the CAN driver
> infrastructure (creating proper ml_priv content). When TUN/TAP set the
> dev->type of an ethernet device to ARPHRD_CAN the CAN ml_priv is NULL (not
> initialized).

I don't know why a user change the tun/tap dev->type to CAN. Can they work
together? If it's a miss config, I think we can just leave it since we already
block CAN slave.

> 
> Long story short:
> 
> The ml_priv assignment in wilc100 can be removed.
> For ethernet devices like the qeth there's no problem AFAICS.
> But I would think about making use of netdev_priv() there:

[...]

> 
> The final question (which is not really a ml_priv issue) is how to tell
> team/bonding which netdevices are not capable to be used by them. To cover
> e.g. your ctcm driver using ARPHRD_SLIP.
> 
> The current check (bond_dev->type != slave_dev->type) would allow to join
> two type-identical interfaces, which was at least not a good idea for CAN.
> For that reason we already check (slave_dev->type == ARPHRD_CAN) there.
> Other dev->types might follow.
> 
> Not sure if collecting a bunch of ARPHRD values is the right approach or
> whether team/bonding should check required features and settings (like IFF
> flags, e.g. IFF_ARP or specific address length)?

Bond supports none arp devices. It also supports infiniband devices. So we
can't check it with IFF_ARP or address length.

From my perspective, we can keep the existing check as it only causes issues
with CAN devices. We can work out a better solution if more incompatible
devices are found under bond/team.

Thanks
Hangbin
