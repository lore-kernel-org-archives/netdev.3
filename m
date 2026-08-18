Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23638339B3D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047957; cv=none; b=A7pEYsL5vNJOz8txGGgyiJ0QfVr1yZDhjcYfZAErxzj0kgU8YDrF8RBdWrpWkLfNkMbPbPAhZd9Mtjh6Y/ypVOkE4oBKCa76O4xFL5/d0QrMDCWf5yDHvgJHHRNAKsKG56h/ofSb37sA8aK3Qz71lks4gxuyU6YSQW4R4NJwgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047957; c=relaxed/simple;
	bh=8FmqkiNc2tTtsd+/e1EC+bv5OjhsZ6e0ExrsPbkllpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmC2SGPWCt23VCaOI95MbzV3Io8b4tKB9rTdMPP3WLybLV4v4D1UBe8NaDkaEIHRTITw2mgHYpo67hudnLtVbDK9ZkQSpL50HeOBE051lQ4IHESn+qmu5PCaKOv65RWSGsRLq0nXIn8bOvkFvxnNlwqxvJRy0pXl9iDub32GU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s9ZGydk1; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s9ZGydk1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8FmqkiNc2tTtsd+/e1EC+bv5OjhsZ6e0ExrsPbkllpk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787047952; v=1; x=1787652752;
 b=s9ZGydk1tUEfnwAmDfq8GEvCJ4LhzB+nII426kQxTvmVkPRY5D8yibeQ/fD8a0DIPixulcEH
 5/mirus4bcJ0IC5ARmOsoVPaPSlS4XxOKeUwqmyb+NYURuCH7W80zXF6DR1QZH+XwEtsNHUgdvg
 ry2mmo/J6Co20USVctQ3LecY=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id ab48bee77aecfd87;
	Tue, 18 Aug 2026 10:12:32 +0000
X-Migadu-Flow: FLOW_OUT
Date: Tue, 18 Aug 2026 18:12:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <aoQwCj9AXNI1qfsu@fedora>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>

On Sat, Aug 15, 2026 at 07:23:35PM +0200, Oliver Hartkopp wrote:
> 
> 
> On 15.08.26 18:00, Stephen Hemminger wrote:
> > On Sat, 15 Aug 2026 17:39:38 +0200
> > Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > 
> > > +static inline bool netdev_has_ml_priv(struct net_device *dev)
> > > +{
> > > +	return (dev->ml_priv != NULL);
> > > +}
> > > +
> > 
> > Minor suggestion: use const and drop unneeded parens
> > 
> > static inline bool netdev_has_ml_priv(const struct net_device *dev)
> > {
> > 	return dev->ml_priv != NULL;
> > }
> > 
> > 
> 
> Good point!
> 
> Will wait for some more feedback before sending a v2.

Hi Oliver,

Sashiko gives some feed back[1], would you please check it?

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815153938.187073-1-socketcan%40hartkopp.net

Thanks
Hangbin
