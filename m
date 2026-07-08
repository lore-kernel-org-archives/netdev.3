Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBC3E00AE;
	Wed,  8 Jul 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540988; cv=none; b=pyWQ2XQraelDhE1uXGBQA+yyF4rHLAbBVHG+M4WngC7DVC+HkYbRbf2wxIwpStmVj4SdY+8lxR6C6qLOgjyQs6iqMzS2PUgW5DV3901MqPLu6gur6pRAWkOKhJ9GnBtQIuyFh08UmEAr//T9JyDzckMOIt39DrFmgt8OwJKDdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540988; c=relaxed/simple;
	bh=mMc7Sy3UXMVQjE6ovDIRpQKVkvzh5XB/7Thy80an8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS7SUmC+8ikY3GOL1BgkAuBGb87l3DTG5CHCIbr+hHP1rcosZMPLynikXyM7O8ObVHYjYaM+lzjqKKvlQqk/Z4rqLL7pE3MaJbO3Ry2/uzx1lJEDlJU0fUABzuuBp8Xq1P7sjlPEJIeIUqeMQ00nODP9V2aJleU+3xkNmxnRUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1whYU0-000000000o6-31wx;
	Wed, 08 Jul 2026 20:03:01 +0000
Date: Wed, 8 Jul 2026 22:02:39 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <ak6s363rweBPZhQZ@makrotopia.org>
References: <ak0KOrM5E2_sPIHf@makrotopia.org>
 <42792433-a95c-431f-ba0c-dc0644dcbdb5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42792433-a95c-431f-ba0c-dc0644dcbdb5@lunn.ch>

On Wed, Jul 08, 2026 at 07:27:21PM +0200, Andrew Lunn wrote:
> > + * The flash process takes approximately 15 minutes. Progress is
> > + * reported via devlink status notifications. After a successful (or
> > + * failed) flash the driver reprobes the device automatically.
> 
> Have you tested the failed use case?
> 
> I assume if the firmware in the flash is invalid, the bootloader does
> not boot it, and it remains in the bootloader waiting for another
> attempt. Does this DSA driver still load, so devlink can be used to
> try again?

No. Without a running the firmware the driver doesn't probe and only
a special rescue tool allows to recover the hardware.
Having the DSA driver detect the presence of the switch stuck in
mcuboot mode and probe without registering any user or CPU ports
also isn't straight forward.
