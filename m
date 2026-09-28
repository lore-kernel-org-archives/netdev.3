Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510F374A08
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578544; cv=none; b=VJJ1RCrmaYS8w+G64/30BgXijn+F8pAPMcYYs435nYfulrqGqON3RQkrMJff045k4p3NngmBBoPx2xyDTKXcE85k29kRC4eP9bmC/lvWHPxUh+FYhSSx0iBSgL9ggmnyJRE+8wtEXB84DNRFgwi+Lb6CNgpSYp6lC06QG/NKg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578544; c=relaxed/simple;
	bh=crpdjgnacTcafKdeQAx/uvrSIqrEny1qWVpRnFT9OXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcprN6Jnl3CIXso8h5J5LADeQKmqU2ul+uialziDDZlE1gXxgSMMNc315ex/OJ4Aljdn+PtvwURuKPnI1xsOQP/Up65DwuvmeHcjgn4G9yKfNexIcye7g6pSJeNzrnH71GBvCShh808Z3kPB26wRMbyaQMQI41xOpfOgRDbO6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHmgeQo6; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHmgeQo6"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=crpdjgnacTcafKdeQAx/uvrSIqrEny1qWVpRnFT9OXs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790578540; v=1; x=1791183340;
 b=cHmgeQo6E7dgi/PEqE43JBtHl46EO1fIa9YGnV6fE+z0Z9OjDiMdrPA6RtbEfcOyxAIFlKrd
 e5igr4sSU5lxpQpwdiIQcD/MG4v0t5vLDPJRKTnFIJLZhqVxCo75pRmYR4XJqYQMHpn7YWYA3Hd
 aHtqiQ7Sbd75GT/yeqEtMGeU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3a8bc4591c927e34;
	Mon, 28 Sep 2026 06:55:40 +0000
X-Mizu-Trace-ID: 3a8bc4591c927e34
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 14:55:50 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Ido Schimmel <idosch@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	kerneljasonxing@gmail.com, netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com, ja@ssi.bg
Subject: Re: [PATCH net] ipvs: fix infinite loop with ipvlan L3 from
 unconditional ipvs_property clear
Message-ID: <20260928065550.GA620427@pc>
References: <20260924063312.1194019-1-chenguang.zhao@linux.dev>
 <20260925124242.GA112355@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925124242.GA112355@shredder>

On Fri, Sep 25, 2026 at 03:42:42PM +0300, Ido Schimmel wrote:
> On Thu, Sep 24, 2026 at 02:33:12PM +0800, Chenguang Zhao wrote:
> > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > 
> > Commit de2c211868b9 ("ipvs: Always clear ipvs_property flag in
> > skb_scrub_packet()") moved ipvs_reset() before the xnet check, making
> > the call unconditional. The intent was to fix a bpf_redirect case where
> > stale ipvs_property on an skb re-entering the RX path caused the SNAT
> > hook to be skipped. However the change is too broad: when IPVS NAT
> > sits above an ipvlan L3 interface in the same netns, the following
> > loop happens:
> > 
> >   LOCAL_OUT -> IPVS DNAT (sets ipvs_property=1) -> dst_output -> ipvlan
> >     -> skb_scrub_packet() -> ipvs_reset() clears the flag
> >     -> ipvlan_process_v4_outbound() -> ip_local_out() -> LOCAL_OUT
> >     -> IPVS sees ipvs_property=0, processes again -> infinite recursion
> > 
> > syzbot reported this as a stack overflow on a KASAN kernel where each
> > level burns ~3.3 KB of stack and XMIT_RECURSION_LIMIT falls short. On
> > non-KASAN kernels the dead-loop detector catches it and prints "Dead
> > loop on virtual device", but traffic is still broken.
> > 
> > Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> > Reported-by: syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2b120190d9e54ad8c65d
> > Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> 1. You need to copy IPVS maintainers on patches related to IPVS. Added
> Julian.

Thanks, will add Julian to CC in v2.
> 
> 2. Does it reproduce with commit 7f1de03e3103 ("net: reduce
> XMIT_RECURSION_LIMIT under KASAN") in net-next?

The dead loop itself still reproduces — dmesg shows "Dead loop on virtual device" for
every connection, and IPVS InPkts keeps climbing. But the stack overflow crash does not
reproduce with 7f1de03e3103 on KASAN, since the lower recursion limit catches the loop
before the stack blows up. So 7f1de03e3103 turns the panic into a packet drop,
which is expected, but doesn't fix the underlying issue (ipvs_property being cleared
unconditionally in skb_scrub_packet).

Thanks
Chenguang
