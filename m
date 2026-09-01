Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920736A364
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244784; cv=none; b=eGjsDgReTa1ZNVjEE3nNL1yi9xepIOtrPcByeQV6r4oxjXbL6zkNJoVI0iqSV8mU1HlDohnEgkuAuT+T+rI0HT/YyxBtOTBNPtJ+8d0nCv1uQYLv5r08camq1/+BRkYNJ6BAPVRoy5Brs4rtd0S4+024B1sqKaxlnspl/PrmYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244784; c=relaxed/simple;
	bh=UlxOvMx+BJjXlWAsY90c5aG2SmKl/u1Iin1ylg6VcAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW/ZpKe7IxV4afaqeXORP9QgW4M61af+c+2WyvdfVcaLf17gCJHNRdZv40iKIst9MzDiiq/ZLBa6YK/D5gnvF8REjCtkd+FABpRZCFZgu32SWslm9csJaJ5LzLr19uhXyBx5hxGXWMusdwafM9CKIYPpQn3aYDYmsRnQNYe83W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eXO+iR4A; arc=none smtp.client-ip=91.218.175.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eXO+iR4A"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UlxOvMx+BJjXlWAsY90c5aG2SmKl/u1Iin1ylg6VcAs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788244780; v=1; x=1788849580;
 b=eXO+iR4AhZ1uM2FcdFCfQxvsRVsamaD6JFcL555EFV8EgEo46T3UVdW16ef0amcXkSCF2RU6
 YNM0pfVQt9ra/GzbDie1xsH1+1nadFvWnk8g4OtEyw3xxHXvCyMq52QPkVHg6mYQckp2uWJixMX
 DLMKliCLE/nKXABudoJdAyKQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9cc35a6bd1e36787;
	Tue, 01 Sep 2026 06:39:40 +0000
X-Mizu-Trace-ID: 9cc35a6bd1e36787
X-Migadu-Flow: FLOW_OUT
Date: Tue, 1 Sep 2026 14:39:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next 1/2] netdevsim: add link speed support
Message-ID: <apZzJDVtENpAluhT@fedora>
References: <20260831-nsim_speed-v1-0-7a651ee65738@kylinos.cn>
 <20260831-nsim_speed-v1-1-7a651ee65738@kylinos.cn>
 <53215678-05bb-4191-b5ff-aa236b16a96a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53215678-05bb-4191-b5ff-aa236b16a96a@lunn.ch>

On Mon, Aug 31, 2026 at 02:16:46PM +0200, Andrew Lunn wrote:
> >  static void nsim_ethtool_ring_init(struct netdevsim *ns)
> > @@ -250,12 +276,16 @@ void nsim_ethtool_init(struct netdevsim *ns)
> >  	ns->ethtool.fec.active_fec = ETHTOOL_FEC_NONE;
> >  
> >  	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
> > +	ns->ethtool.duplex = DUPLEX_FULL;
> > +	ns->ethtool.speed = SPEED_5000;
> >  
> >  	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
> >  	ns->ethtool_ddir = ethtool;
> >  
> >  	debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
> >  	debugfs_create_u32("set_err", 0600, ethtool, &ns->ethtool.set_err);
> > +	debugfs_create_u32("speed", 0600, ethtool, &ns->ethtool.speed);
> > +	debugfs_create_u8("duplex", 0600, ethtool, &ns->ethtool.duplex);
> 
> debugfs_create_bool() ?

I'm not sure if anyone want to set nsim duplex to unknown for testing.
Do you think that we should disable this behavior?

Thanks
Hangbin
