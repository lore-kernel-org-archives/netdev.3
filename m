Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2B3CF694
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189276; cv=none; b=dW/4jeruMRW5bpxtk8mJFuRTqL0IhcSvatawUzrjo+tLHKBHHGd8eAEEnoobsvqnAY0hEXFetURz8u0btxdstgjt7UCAwsJkTymbdAy4tNzYqyCN1msyoeaUcIQoH2RJCvzUehuH1oX8XsOBRAIFOdN5rwFEFAcUtm4k2B5gtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189276; c=relaxed/simple;
	bh=aXQSwTEOV2lUIff8KtTWe6jgC43LzU9NrcUCKEYZeqs=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=RNJ0K49tWhq9AfXP978KqNTxBqssBOmiXMaTyOuO7kb+MT5GtfpiF5zzVtPSmmodFhoQRhtJKRF5IcnonBETcZd0zkYTz9OmozDiHsMoExDO663fj1u9lgsex3FBEPDbEXGvBeTqfGOADqSTs1TkELPAwVP1ABFLW67URhu1rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XSMv4YoH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XSMv4YoH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 94AD01A1020;
	Thu, 16 Jul 2026 08:07:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D58C602B8;
	Thu, 16 Jul 2026 08:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 609EE11BD3CB8;
	Thu, 16 Jul 2026 10:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784189268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=/46Btl2Rh5lKCqcaJYcHAAwZrOW7gvtqkxDmWYrpYoQ=;
	b=XSMv4YoHq+3cGkW2BRD6zGXq+xwACQB4lJtH509zjtTi6fn6AFGLegUUAz6LM6LmwunS6L
	KBmFrjkNVNJXZnBm79sLW1YhLHoKrc2yOGCF+F6XT89N8pujIOseik4Zas3gVHDtZ6jyYF
	KdO5z2SbX660zW0aBrVN5BixHDutBdA4bGbgIvh/GaXBxbroHa659K0cPVV+W3u8KpXxnj
	FlSdUd7DHTE48GOk65TrDBlLomA7sM0GxYVyvHEiyPT5BYRji5/3Fs+r3whz6l+hHt1/h6
	7iVpXY09+GVgky7giz17XfXsWvHp5/3hhrzFhFvDY8ci6XUZMme/Ju39jCAcQA==
Message-ID: <ef8fe714-5ad9-4f98-96fa-d8468beecd38@bootlin.com>
Date: Thu, 16 Jul 2026 10:07:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, "Das, Shubham"
 <shubham.das@intel.com>, Alexander H Duyck <alexander.duyck@gmail.com>,
 "lee@trager.us" <lee@trager.us>, "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
 "niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Susheela Doddagoudar <susheelavin@gmail.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Loopback, PRBS and link topo enumeration
Cc: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This week is the Netdev Conference in Rome, and at this occasion, we've
had a small chat with Oleksij Rempel, Björn Töpel and Alexander Duyck
about the ongoing efforts for PRBS and Loopback support, that I'd like
to summarize so that people who didn't attend can jump-in on the topic.

This topic has also been brought-up at the Netconf conference, which
Jakub summarized well during the Netdev event.

There's a good discussion going on about the PRBS topic lead by folks at
Intel here [1], I don't want to hijack or replace this discussion, as it's
on a good track to define a uAPI for PRBS setups.

[1] : https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com/

The topic we discussed was about expressing as part of the uAPI the location
of the PRBS and loopback configuration in the components of a NIC.

Loopback in particular, and to some extent PRBS, can be configured in
different blocks of an Ethernet interface, and it would be best if we had
an ability to:

 - List the different components of an interface down to the 802.3 level :
   PCS, PMA, PMD, RS, etc.
   
 - List the capabilities of these blocks :
   - Loopback ability: local, remote, none, both
   - PRBS ability: availability, supported algorithms
   - Any other stats, pkt gen, etc. that we could use at a low-level
   
 - List the "packages" (maybe "domain" or "component" is a better name ?) and
   their interconnections :
   - Are these PCS/PMA/PMD grouped into the same HW block i.e. an ethernet PHY,
     a MAC-side block, some SerDes (in the Generic PHY sense) driven by
     linux or firmware, etc.
     
  - List the lanes available
     
A proposed approach would be to decompose this into separate ethnl commands :

 - A set of commands to report the HW layout to the user :
  ethtool --interface-capabilities ?
  
  it would return a list of the above mentionned blocks, packages, as well
  as an identifier for each block, something like what Björn has proposed for
  loopback [2] :

[2] : https://lore.kernel.org/netdev/20260325145022.2607545-4-bjorn@kernel.org/

"  
Each loopback point is described by a nested entry attribute
containing:

 - component  where in the path (MAC, PHY, MODULE)
 - name       subsystem label, e.g. "cmis-host" or "cmis-media"
 - id         optional instance selector (e.g. PHY id, port id)
 - depth      ordering index within a component (0 = first/only)
 - supported  bitmask of supported directions
 - direction  LOCAL, REMOTE, or 0 (disabled)  
"

We'd remove the "direction" part, but "component" is same as "domain",
name could be an enum instead (PMA / PMD / RS / FEC / PCS ?) or we keep
it as a string, id should be renamed "component_id", and we would return
an extra 'id', unique per entry, that we would use for the actual
PRBS/Loopback command, here as the 'block' parameter.

   
   ethtool --set-loopback eth0 block <XXX> type local
   
   ethtool --phy-test eth0 block <XXX> lane 0 tx-pattern prbs7
   
In terms of kAPI, this would go as an ethtool ops to the MAC, that would
then dispact enumeration to phylink, phylib, the local firmware, the generic
phy (with a new API for that), etc. Oleksij mentionned that we'll have to
also deal with DSA at some point, to configure loopback on the switch-side of
the conduit.
 
 (Extra idea that wasn't discussed, adding it as I'm writing :)
Or we could have the netdev/phy/phy_device/phylink/sfp register their
components to the phy_link_topology struct that we would extend, that way
we would only to the block enumeration at netdev bringup.
 
As you can see, we didn't really discuss the actual 'how' for PRBS /
loopback feature, but rather the 'where do we configure this' part.


  Another approach was mentionned, that is to do all that outside of net,
as a dedicated "diag" framework where each component (generic PHY, phy_device,
mac, etc.) would register prbs/loopback/etc as new devices in a new diag
framework, a bit like hwmon, and the control knobs would be in sysfs or
directly in "/dev".

We however may face complex issues having to sync the netdev
state with the ongoing diag, i.e. making sure the netdev becomes unavailable
when we have a diag in progress, and that may be hard to do.

Björn's work on loopback IMO is a good starting point for the topo enumeration,
I don't think this impacts much the ongoing PRBS discussions as you're on 
a good track defining the uAPI :)

Thanks everyone,

Maxime
