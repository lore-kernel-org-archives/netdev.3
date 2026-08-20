Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B5430789
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225602; cv=none; b=RYTshgWzaT1wxUraBtQKoFhLvVa/GNahBhlWs9eWGjnINNBO6yPS5Sjw3rwJ/VeYnWZpeJ4ZgkCiHqxEad6ZdRxBKiWsYOCKmsvt8k20pjNou+3vYqVtDNU+GVxRnVezasLnl9x/slgqzuB4V9vr4DV4g8oVYj1BDIf+aXx3lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225602; c=relaxed/simple;
	bh=W0+OJI7ppOypICFEJArgpOoJ8yYBiIv18hDuy0O7fnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiGad7mJuGEaNA/FjxVWgiypZla7UjQOhNkxXEs4iAuRAj9SBMbe/hSS6F41ja8OATDUTuApErCSgccOlpxwsonq+XbaY3j27RVipYiuqTSy/AIyTS3+QevequXCaqDKHX/3pOWxZp36EFRDIrZLgltxk57PuLsbp7i/yMhvOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DH7aI8Ry; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DH7aI8Ry"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D3981207C6;
	Thu, 20 Aug 2026 13:33:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45eIizjeY0Rt; Thu, 20 Aug 2026 13:33:10 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E5CEA2067A;
	Thu, 20 Aug 2026 13:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E5CEA2067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787225589;
	bh=bkVTcJiVgNeFpumVVV6MbBHxgoDpwm2ig6kIcDpsjYc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DH7aI8RyVKBBL/2cLSNzWhN9VHs/AfW968DqXudS77r6vYCqjP6JxP7U+MZInf/gT
	 LsVyXmtaN6ylby/e6c8LbUa6pcci0JGoGaaWFhrwoWDeV7TsU003g1+oMcORI1jgm6
	 BbcnJjTRXyZ09kXN8Q7yVkMsDEi42OB/jzFV2BPjx8xCKxxN8+no9HbCAE/nZnlZXN
	 URRIo8qw4zcmdcQ04huY0M89mYwXGXn8IcSNQd+kn/5bGrCkl3F9A4tjQ1dKYBoz/m
	 U0mmw1FNusaKC0J3bqn7C/fGifqFGyAqxr7RQHItOIKODdro1Gk+5HFAfNHD211Qf/
	 Pds4MEfMBy7vA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 20 Aug
 2026 13:33:09 +0200
Received: (nullmailer pid 1851110 invoked by uid 1000);
	Thu, 20 Aug 2026 11:33:08 -0000
Date: Thu, 20 Aug 2026 13:33:08 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/10] pull request (net): ipsec 2026-08-18
Message-ID: <aobl9LSwwUNOhMI5@secunet.com>
References: <20260818092920.653034-1-steffen.klassert@secunet.com>
 <7c5a9d55-a15b-4235-a308-cc6f65ce2de9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c5a9d55-a15b-4235-a308-cc6f65ce2de9@redhat.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

Hi Paolo,

On Thu, Aug 20, 2026 at 01:19:19PM +0200, Paolo Abeni wrote:
> Hi Steffen!
> 
> On 8/18/26 11:28 AM, Steffen Klassert wrote:
> > 1) xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
> >    Tighten the secpath-depth check so a full chain can't write
> >    past xvec[].
> > 
> > 2) Add and revert "esp: do not unref managed frag pages in esp_ssg_unref()"
> >    The patch does not fully fully resolve the issue, a corrected version
> >    will follow.
> > 
> > 3) xfrm: espintcp: fix UAF during close
> >    Synchronize espintcp close with the xfrm_trans_reinject work
> >    queue so the freed socket message isn't dereferenced again.
> > 
> > 4) xfrm: drop ESP-in-TCP packets with no ingress device
> >    Drop queued ESP-in-TCP records whose saved ingress device has
> >    gone away, avoiding a NULL device deref in the XFRM input path.
> > 
> > 5) xfrm: avoid lock inversion in nat keepalive work
> >    Split the NAT keepalive walk into a reference-collection phase
> >    and a per-state lock phase to break the AB-BA with state removal.
> >    This patch has some issues that are fixed with a followup patch.
> > 
> > 6) xfrm: Fix skb double-free in xfrm_dev_direct_output()
> >    Stop freeing the skb unconditionally in xfrm_dev_direct_output(),
> >    letting local_out()'s result indicate when ownership has moved on.
> > 
> > 7) xfrm: ah6: validate routing header segments_left
> >    Validate the segments_left/hdrlen invariant before rearranging
> >    the routing-header addresses, avoiding an OOB memmove on
> >    malformed HDRINCL packets.
> > 
> > 8) xfrm: fix xfrm_state_construct() auth-trunc leak
> >    Detect an already-attached auth-trunc allocation by the pointer
> >    rather than inferring it from the algorithm id, so a prior
> >    attach isn't overwritten and lost.
> > 
> > 9) xfrm: bound nat keepalive state collection
> >    Replace the per-state allocation in the NAT keepalive walk
> >    with a fixed-size batch that drains under BH-disabled locking
> >    and resumes from the cursor, bounding the worker's memory.
> > 
> > Please pull or let me know if there are problems.
> Sashiko has a few comments:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818092920.653034-1-steffen.klassert%40secunet.com
> 
> do you think they deserve a v2 or could be handled as follow-ups?

These are already addressed in the pull request. Patch 2 is reverted
and patch 5 has a followup fix (patch 10).

> 
> Also the fixes tag in patch 10/10 looks invalid. Possibly a rebase
> would be needed?

The fixes tag referes to a commit in the ipsec tee (patch 5),
so I think it is valid.

Steffen
