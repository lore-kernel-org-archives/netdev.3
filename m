Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DA19CCF7;
	Wed,  8 Apr 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640615; cv=none; b=VQTA4NDcDQNBQT3H1Z+VChatm7NGqNWiW4xg8T5QSnQktsEPgLuJz14P3E+VPDMR/Ht2eS+QhWomBU8SRI4v3FeH5GN0q6ZkvITmFiIaCCYiJ44Pdi49uoiHDRBfq+SvNxD6DMTJU9tqNMo/5LZfkMYiBxXArRWCepyKi9sxrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640615; c=relaxed/simple;
	bh=IlhjxjdPXvr+PTXcRTRspzg2If3RH+XNDXz5bdoe7wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeMXEo2dNboKwIgAOXBVDwIzppfsVKYJpfGqIGURjF1myJ0wa1o+9hbd9VOOFqCbFXDEbVlXieEFZynvHcK5g7L3KJRUtDCgUmoW1Z7X+MCJXQ53gAQPSEoDliwRrct6O3Yl16DqZxOipmN9WqTuT4H+LRmqc2UfoPEsu3RvY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aj+R5Hq4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aj+R5Hq4"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 85012201D5;
	Wed,  8 Apr 2026 11:30:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfd65NMbL36T; Wed,  8 Apr 2026 11:30:12 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EE126207A4;
	Wed,  8 Apr 2026 11:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EE126207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775640612;
	bh=WSVSzlPK7gCp5BxaLEMvdfsViw+64KTIylJyXJ3WmN0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=aj+R5Hq4KucUtsI8+eE/V+4bsG2DrpS2DQmos/SbJ4loZzDFK/BsmLN00XiFlaoIk
	 aw2UoqysNel8oQy5/KHUi01OOlYZLQEVvZRic6mUpUcBrh34mqA2/Xs7UTkpAryTX/
	 +J7uPFWKdNS7QawD2oHFdLJGzkFd6s4xTLyCdpXs1XXuVVqkHJeokk0zL9irTzJX4b
	 uEkruK9vvRzHObQL8/1+hyvrgTz1oIzpmn2cl4JgxZ5iu4+qfjPQhwjNDyfYYna4qH
	 dKx9jj8rfElBDmQmtG88tqDmfupLwBvMQqL/YekhbItaY+Le8sXBBuYbPxdshzVJG5
	 WCP1aZO1X87VQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:30:11 +0200
Received: (nullmailer pid 66073 invoked by uid 1000);
	Wed, 08 Apr 2026 09:30:10 -0000
Date: Wed, 8 Apr 2026 11:30:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <adYgIr5vlORzWqi7@secunet.com>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
 <2026040634-deodorant-shakiness-a64e@gregkh>
 <20260406103851.59a200fc@kernel.org>
 <2026040745-crafter-awkward-8901@gregkh>
 <20260407181211.5419f2cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407181211.5419f2cc@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Apr 07, 2026 at 06:12:11PM -0700, Jakub Kicinski wrote:
> On Tue, 7 Apr 2026 07:51:15 +0200 Greg Kroah-Hartman wrote:
> > > > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > > > alignment for some reason...
> > > > 
> > > > Want me to do that?  I don't have a way to test any of this, I just
> > > > found it using some static code analysis tools that looked at holes in
> > > > structures.  
> > > 
> > > Do you have any more Netlink leaks in the queue? If you do let's do it,
> > > if you don't we can wait until the next victi^w patch to arrive.  
> > 
> > I do not have any more, sorry.  So is it worth it for just these 2?
> > Your call :)
> 
> These are fine. I would have applied but I think Steffen will take them
> via the ipsec tree first (LMK if that's not the plan, Steffen)

Both patches are now applied to the ipsec tree. Thanks a lot!
