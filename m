Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97233385A5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427665; cv=none; b=KlqqHlvgYKyUECghhL22TPiPlzZqu8W8CTCp5xE2Tu6cFVHriGnoZLEqvmWrEY6da1uw3WxZuNdBmIb3xN16sGVuQHKQ3fSn3dwmS6VxXIsAyOXPnRbIjlJf8SsqiM6GePdVZW71luaWG+Mas1luskSdZ29Tict+VIhBeuM1PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427665; c=relaxed/simple;
	bh=45pmiB7hOA0EAgm0ORNGEcRHx1hWKp/fNfvMp5mB2M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/c7a1Gq30bLHgROLUmONzQBVWf4KCBSaDqtcYc0foK/RmzNnzUU12Nm14W8knZOmP4uyVmbPpljqiah/rU5aAPZjx8+KsK0encITari1tK5QhLVpgRGQhvjFzpHef1oUSOF0EJ9CrtwpMi4bzGmjImZtC+Tbzn37OAm0uowSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+dZpqlt; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+dZpqlt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=45pmiB7hOA0EAgm0ORNGEcRHx1hWKp/fNfvMp5mB2M8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788427659; v=1; x=1789032459;
 b=b+dZpqltXIRKuqUIVc72QA6TP9Z69V9HECKOWRso1dyLiFLd31QdRXdbot/KPbL5tctMMef/
 ORgQZoWcSdT8NPv0AhrwrMItwNapMJdgKhSsUd/ndWT7o7DLNQD2E4i/VlTuhesBn2hpYZuHvwu
 dnOHkTNWGs359X2G+FsftK0Y=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed0af569cd94117b;
	Thu, 03 Sep 2026 09:27:39 +0000
X-Mizu-Trace-ID: ed0af569cd94117b
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 17:27:20 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <apk9eDWX069eRKCF@fedora>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <30c405c0-d17b-4107-a4f4-d2595c661892@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c405c0-d17b-4107-a4f4-d2595c661892@blackwall.org>

On Thu, Sep 03, 2026 at 11:18:32AM +0300, Nikolay Aleksandrov wrote:
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 947d92a669b6..f3290aee50d1 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >   		}
> >   	}
> > -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> >   	netdev_compute_master_upper_features(bond->dev, true);
> >   	bond_set_carrier(bond);
> > @@ -2339,6 +2338,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >   	bond_xdp_set_features(bond_dev);
> > +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> > +
> >   	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
> >   		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
> >   		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
> > 
> > ---
> > base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
> > change-id: 20260807-bond_slave_cnt-88e78c5f0ab9
> > 
> > Best regards,
> 
> Thanks, looks good to me. One minor nit if there's another version - mention
> also the WRITE_ONCE() in the commit message or better yet do it in a separate
> commit that properly annotates slave_cnt everywhere.

The WRITE_ONCE() change is made by Eric's recent fix
bc93419130bb ("net: bonding: annotate lockless writes with WRITE_ONCE()").

Do you mean add a comment for all the slave_cnt usage?

Thanks
Hangbin
