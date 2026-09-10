Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5B403EB3
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027420; cv=none; b=JSS8nQSlCnOSoIkKtZM7UQIiCUhpN5dYQBSNdV5kZ5De13W/9Z03S+vHfhYTfP0Tg5lKf43o+mrZgo9W7ejtQJNRYzWwov40Joj1ekHQgmeBb/2oPL4IlS2ZGL3FLOXxk3QQtvBJSrUGLFCdM1utSJTnK1AUgPHLSzwXTHnmRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027420; c=relaxed/simple;
	bh=AGw4rQ49iP7cOprlqT8vMHsOeJvucRCZgwwiygXGa8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p38BjxF6SZpeHVhmCjlBgXMasIOhYkCkJKbHp+aNkNm58lL4zcOOwTXf2qNdZxmInIFhMuXuSetADwshw6ET5ylMcsQNZIygKzZiIUZWorMq6pukP6dtJ01BE7L1Y9O+m5vfBbhmJ7C91MjhOS7OVRyeb/wjzuZuXLq2SB+Yfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZdcHhIi; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZdcHhIi"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AGw4rQ49iP7cOprlqT8vMHsOeJvucRCZgwwiygXGa8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789027402; v=1; x=1789632202;
 b=NZdcHhIiukJll8dOKi3BuwWX1sqNb0hg+p/taxO2cXw5NbDnMJ2DokqBXIakwMBJyZhs5/kI
 mLts01y9igNlJK7s//de9OHUXnDLanRTHLz4BsDdjpqH7D+j1A7LSqjtzcMnzF2QLn2hZtU0s8y
 Ffkm0pg3Ffp0QjRoaI2YENE4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1eaf42e24f230a03;
	Thu, 10 Sep 2026 08:03:22 +0000
X-Mizu-Trace-ID: 1eaf42e24f230a03
X-Migadu-Flow: FLOW_OUT
Date: Thu, 10 Sep 2026 16:03:07 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: David Dai <zdai@linux.ibm.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pradeeps@linux.ibm.com
Subject: Re: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave
 failover, rekey failed
Message-ID: <aqJkO4-49YtW4NxF@fedora>
References: <20260903220123.475685-1-zdai@linux.ibm.com>
 <apphLbjfmRYknVNh@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apphLbjfmRYknVNh@fedora>

On Fri, Sep 04, 2026 at 02:11:57PM +0800, Hangbin Liu wrote:
> On Thu, Sep 03, 2026 at 05:01:23PM -0500, David Dai wrote:
> > Create a bonding device (i.e. bond0) in active-backup mode, 2 slaves.
> > Active slave: offload capable interface (i.e. eth1), primary interface.
> > Backup slave: non-offload capable interface(i.e. eth2).
> > Configure strongswan service swantl.conf child SA "hw_offload = crypto"
> > Start strongswan service
> > IPSec Crytpo Offload is enabled on top of bond0. i.e. 
> > ip xfrm state |grep offload
> >         crypto offload parameters: dev bond0 dir out mode crypto
> > 	crypto offload parameters: dev bond0 dir in mode crypto
> > 
> > Active slave eth1 takes adavantage of IPSec Crypto Offload capability. 
> > 
> > If active slave eth1 is down for any reason (i.e. eth1 link down):
> > ip link set down dev eth1
> > non-offload capable interface eth2 failover to becomes active slave. 
> > The existing SAs can continue use software IPsec after failover.
> > Traffic still keeps going properly.
> > 
> > However if eth1 link had not recovered yet, strongswan service does
> > new child SA rekey, or uses swanctl command to do new child SA rekey, 
> > it will fail because active slave eth2 doesn't support crypto offload.
> > In bond_ipsec_add_sa routine, it returns -EINVAL now, which is 
> > treated as fatal error by xfrm_dev_state_add routine in kernel xfrm.
> > 
> > To make the non-offload active slave survive the child SA rekey, need 
> > to make bond_ipsec_add_sa routine returns -EOPNOTSUPP instead when 
> > active slave doesn't support IPsec Crypto offload, the xfrm will 
> > gracefully fallback to create new SA using Software IPsec. 
> > Network traffic can keep going.
> > 
> > After offload capable interface eth1 link is up, becomes active slave,
> > next time strongswan child SA rekey will create a new SA which enables
> > crypto offload again.
> > 
> > This way, network traffic is never interrupted, always keeps going.
> > 
> > Signed-off-by: David Dai <zdai@linux.ibm.com>
> > Tested-by: David Dai <zdai@linux.ibm.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index ef9eb0c53c66..79fc892dab07 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
> >  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> >  	    netif_is_bond_master(real_dev)) {
> >  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
> > -		err = -EINVAL;
> > +		err = -EOPNOTSUPP;
> >  		goto out;
> >  	}
> >  
> > -- 
> > 2.55.0
> > 
> 
> The patch looks good to me. I am just not sure whether we should shorten
> the description. Let's wait for others' opinions.
> 

BTW, please add

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")

if there is a next version.
