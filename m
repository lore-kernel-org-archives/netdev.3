Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779538D69D;
	Tue, 28 Jul 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257164; cv=none; b=k+cy/q1a3PVMpWFBxjacyPTnqT2Ri0de20bdUyj0/VKiVT/Z/WkU2KQu2k1r1a+o33XWaksMPGEz98JiMhTykzU8r8aWPdmaE/xEuuxKek4ssAqOtEVgnlwGaFk10a0RdKVyE1QeXgLngSBU1ezd6BkHxOKjgVQzRcTsXAW9Q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257164; c=relaxed/simple;
	bh=kYOATFnd17dpBs93D2tmGmIxKZXugasPpMq0lxUWhuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=La5xgWmtWOmsPVMe24ZPjyXQIUNGgyewUfD1wx1NH442hzA0ooe5xFAiuAvVnWX9Dl0JL4R4mbj8js3rW5m+ks+bjrzO4Q5k6veSrVq0xQRp03HpA5J4jQBo8U/MWF0v+0GjvfUwK+yXu5KQE/T52sKg6fUNHLAwiUu8Gp5Wg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euPXe1qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euPXe1qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD33F1F000E9;
	Tue, 28 Jul 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257163;
	bh=5YquGza/cLv9jRtqUD6fE1uft0QIGSBzIoxlMUsTw/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euPXe1qxzMgKnZvo6/O1eacihmJaYqyJdC5NwyKeEnNmGbxwVbH8zsV7Y0tM1yQwF
	 JMzFgsUNb7vGB/ja8rVmTUKrHFU6e69gSIKByGbinTXhttURagPZ420B/mPv3/70Wx
	 ESMnyIDq1/lmWKo6zsQVTiOgORdgfoTgHrEewqp8J30N/DRGbIYMKJkVRU7VCEu5sh
	 VA+sh0VGvrKdYJUNyz0MksI4Bi86ijpshDqLhG9h4Z3KdMxiMllhbHFuvY/+hA4csf
	 1C1a0jPHEITfQjnwWGbos2ujh5kxxcLR8vIfA2P+d/xMbcsnt49b/l6KaVeljglFGM
	 5GEVmPJf+M8iw==
Date: Tue, 28 Jul 2026 09:46:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v5 net-next 9/9] octeontx2: switch: add TC flow offload
 path for switch flows
Message-ID: <20260728094601.1208e390@kernel.org>
In-Reply-To: <amhXHG6etEUc9IYi@rkannoth-OptiPlex-7090>
References: <20260724094018.3213907-1-rkannoth@marvell.com>
	<20260724094018.3213907-10-rkannoth@marvell.com>
	<20260727135059.6e0c8fdd@kernel.org>
	<amhXHG6etEUc9IYi@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 12:45:40 +0530 Ratheesh Kannoth wrote:
> On 2026-07-28 at 02:20:59, Jakub Kicinski (kuba@kernel.org) wrote:
> > On Fri, 24 Jul 2026 15:10:18 +0530 Ratheesh Kannoth wrote:  
> > > Register an ingress flow-table offload callback that translates TC
> > > flower rules into fl_tuple state, resolves ingress and egress
> > > pcifunc via FIB for accelerated ports, and notifies the RVU AF over
> > > the PF mailbox.  The AF forwards flow updates to switchdev and
> > > keeps per-cookie packet counters in sync using NPC MCAM multi-stats
> > > when the switch requests SWDEV2AF refresh.  
> >
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35: warning: incorrect type in argument 1 (different address spaces)
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    expected void volatile [noderef] __iomem *addr
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    got void *hwbase
> > --
> > pw-bot: cr  
> otx2_pf.c is not modified in this patch. Could you please help me understand why this warning
>  is popping up for this patch ?

Not sure, the builds in NIPA are incremental so it's possible that 
a race or some IDK random sun particle caused make to rebuild it.
Maybe you could send a quick little series to clean up all the W=1 C=1
warnings in this driver on modern compilers? Then such randomness will
not matter. Looks like there is only a handful of warnings.
