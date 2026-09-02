Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BA35B65D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313347; cv=none; b=ImQwuDZ3CP45wnWfjuYpQXMPFostOhiAOjt6LY++6hufgpioARZg9LXmw8GHB0u7N4Ywd5EvDDISRleMm7LmFtnQWAkwvI6DOcstD1IRJ46j2GC6I+1vPehsTp2lYcRqR2zqvrRJ2ZaNDqTMXqD9oySjLwzEqvHzpsrnoNxg7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313347; c=relaxed/simple;
	bh=UrEd/2ZEKDADGjKz7wC5/rkBM6iphqXlmZwW9203eBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAWjAys6HDQV3EDaEudhfCLEGiRIFCbGJ7j8wHVQlvHZg8aU37EtfrHREgkz12xLMb+0zYfHro66w7TMeN97G/zQfAz67GIilG/BRXMyMoxyzWOedjBXuZ52RIXL1n3oPvFj8glzPgmJwGCHm/T5lMvZUc37K4XHpHkQAxlaHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6qrARjW; arc=none smtp.client-ip=95.215.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6qrARjW"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UrEd/2ZEKDADGjKz7wC5/rkBM6iphqXlmZwW9203eBc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788313331; v=1; x=1788918131;
 b=O6qrARjWV+lPdMdzAxVLIuqVHRFQfuydP0qSdKtMX/Q/RS6HB9hLVumMkgq0qjfKB7gp92v6
 42c+EURhc8flIfDYPOavDntub+vJYmfDXD7gMefoM36IOdcb5R6k+jO5WhbZEBZc2E6leDDLXMa
 kXpEdj+BzxUuMG/Tj8rFjeXc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ccb6f8e438718b14;
	Wed, 02 Sep 2026 01:42:11 +0000
X-Mizu-Trace-ID: ccb6f8e438718b14
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 09:42:00 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	daniel@iogearbox.net, razor@blackwall.org, bobbyeshleman@meta.com,
	sdf@fomichev.me
Subject: Re: [PATCH net-next v2 2/3] netdev: avoid skipping objects on race
 with device disappearance
Message-ID: <apd-6C1lJDI0ZVNI@fedora>
References: <20260831164159.1124679-1-kuba@kernel.org>
 <20260831164159.1124679-3-kuba@kernel.org>
 <apaXopeQGUR-xku2@fedora>
 <20260901080234.522d1921@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901080234.522d1921@kernel.org>

On Tue, Sep 01, 2026 at 08:02:34AM -0700, Jakub Kicinski wrote:
> On Tue, 1 Sep 2026 17:15:14 +0800 Hangbin Liu wrote:
> > > @@ -312,11 +312,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > >  			err = -ENODEV;
> > >  		}
> > >  	} else {
> > > +		unsigned long start_ifindex = ctx->ifindex;  
> > 
> > The NETDEV_A_QUEUE_IFINDEX policy is u32. And all ifindex getting/setting
> > in 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
> > is u32. Why the ifindex is defined to unsigned long?
> 
> Off the top of my head - because it's am xarray iterator

Oh, thanks for the info. I find it.

#define for_each_netdev_dump(net, d, ifindex)                           \
	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,             \
			    ULONG_MAX, XA_PRESENT)); ifindex++)

Thanks
Hangbin
