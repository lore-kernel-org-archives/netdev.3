Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2E46F48F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583072; cv=none; b=Q20V9xdeOIDt1hc7PqB95zs1GjKOPRKbPyDi5OY0p9X2KtmJc5fL7c9ClRA4pHVqtl7JIcDE0QuHETti1YWIwSipoKBiYuK+C7kdzwXdz0PmckxVrtfx2Oidtmf+yrcieo+9yoMHzajR6tcbpweoxeIjd9+erOWY61TTVxcCIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583072; c=relaxed/simple;
	bh=pMI41QYJxbMc54+IsFqH0QgDw1A4UmTrboK/fdZGcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hh1H45hzFQkmZd+avLYa8s78xEXCX5kjkUBVBwskVGp1i91IDgiLsQnx0vCXmr4H5lTCX/QEJbijTyNRZnW+SNmEvIEAvekHH8gfYjpJQ5HXerjD4n9oXIKRXZIe8rELei3uyRfNPv8KDRI/aPMy1FMgwRKD3Q4BVPWXK3m30Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Ov/6MWCb; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Ov/6MWCb"
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 1DE66213E4;
	Mon, 28 Sep 2026 11:10:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=Lqn5X9lPXYu5TW/Is9kmTXn7SeAFiyHE/K8hQjwfw0U=; b=Ov/6MWCbsKzL
	NEBbikmeYEbKZMnrc4f3nV++PipKkRYHGTN1SudiMD9UsSoMzWNdG51x89GCGO5/
	JM5IyF1wLTw0jhmaGaES8OZh0KkrkLi3fPZl6tXM+xSXf/LeXFr8lHFl2YH1mpbX
	mfEqjfHDR9IDwgtiOYFSuhjyTDvrRPJN7GgvG8h/dMvas9IaihWtqY8FbxNTDetv
	xyZdlaOFDfgCR3OGS8ON9MwJdK7Wu3CWVB2t3fQm4HYFVOizDloh9uU8nWzKRoTW
	SElkPhajhp+qogAR7GWThUlBZGyEY7eS3cx/DHZtSlZNFim6yLZd7Qt60eEdH64H
	9fiuomxSmZnmXWZe2ohHxDfT0PEaEIiiDu6gaekdffv2WspPCW6BFsuzon4iELPX
	PaVeJsX9mz0s0N5ic84cXlhy9j7sTB3CJDQhJYbs36TNDeJOw3jaGvrMfyZkSatP
	QP4TuJNBAu4ITY576P7aMF3pOS7XhO5JCJ9lkCeTcOVE6xvJPURcLeZX9bEN5x4K
	MjdRKpFzPQa1Wai+pVSo24V/2rnVcr7VwhfakffC0YAgUjGzzsLOm+yoJUDZ3RwB
	IQlOYUG6EzMvTyAKMtTEXEaLZ85qwhsFeBlqKUiYMO38sNeV6MtJ2nHLuvcRIoD6
	ck9Y0woD14SOf+Bnkck2ZyfN9F2G4Yc=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Mon, 28 Sep 2026 11:10:55 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 4AF3460BB9;
	Mon, 28 Sep 2026 11:10:58 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 68S8AsH1022001;
	Mon, 28 Sep 2026 11:10:55 +0300
Date: Mon, 28 Sep 2026 11:10:54 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
cc: Ido Schimmel <idosch@nvidia.com>, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        dsahern@kernel.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
        Chenguang Zhao <zhaochenguang@kylinos.cn>,
        syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipvs: fix infinite loop with ipvlan L3 from
 unconditional ipvs_property clear
In-Reply-To: <20260928065550.GA620427@pc>
Message-ID: <8609d29f-750d-ef73-8df4-3ebf540b0892@ssi.bg>
References: <20260924063312.1194019-1-chenguang.zhao@linux.dev> <20260925124242.GA112355@shredder> <20260928065550.GA620427@pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1057209553-1790583056=:6942"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1057209553-1790583056=:6942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Mon, 28 Sep 2026, Chenguang Zhao wrote:

> On Fri, Sep 25, 2026 at 03:42:42PM +0300, Ido Schimmel wrote:
> > On Thu, Sep 24, 2026 at 02:33:12PM +0800, Chenguang Zhao wrote:
> > > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > > 
> > > Commit de2c211868b9 ("ipvs: Always clear ipvs_property flag in
> > > skb_scrub_packet()") moved ipvs_reset() before the xnet check, making
> > > the call unconditional. The intent was to fix a bpf_redirect case where
> > > stale ipvs_property on an skb re-entering the RX path caused the SNAT
> > > hook to be skipped. However the change is too broad: when IPVS NAT
> > > sits above an ipvlan L3 interface in the same netns, the following
> > > loop happens:
> > > 
> > >   LOCAL_OUT -> IPVS DNAT (sets ipvs_property=1) -> dst_output -> ipvlan
> > >     -> skb_scrub_packet() -> ipvs_reset() clears the flag
> > >     -> ipvlan_process_v4_outbound() -> ip_local_out() -> LOCAL_OUT
> > >     -> IPVS sees ipvs_property=0, processes again -> infinite recursion
> > > 
> > > syzbot reported this as a stack overflow on a KASAN kernel where each
> > > level burns ~3.3 KB of stack and XMIT_RECURSION_LIMIT falls short. On
> > > non-KASAN kernels the dead-loop detector catches it and prints "Dead
> > > loop on virtual device", but traffic is still broken.
> > > 
> > > Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> > > Reported-by: syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=2b120190d9e54ad8c65d
> > > Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > 
> > 1. You need to copy IPVS maintainers on patches related to IPVS. Added
> > Julian.
> 
> Thanks, will add Julian to CC in v2.

	I saw it the first time, not needed. But I was busy
with other changes, sorry for that. May be the packet scrubing
needs 3 states, not just 2. But as this is not my area I have
to dig more. SCRUB_REROUTE/SCRUB_TUNNEL (xdev=false, no ipvs_reset)
used by IPVLAN L3, SCRUB_FORWARD (xdev=false, ipvs_reset) used
by bpf_redirect in same netns, SCRUB_NET (xdev=true). But there
are many call sites to check. The problem is to know how far
a packet can reach without reset.

	Another option is to add new skb_scrub_packet_XXX() for the
needed sites, I'm not sure. But adding IPVS code in the IP layer
does not look nice.

> > 
> > 2. Does it reproduce with commit 7f1de03e3103 ("net: reduce
> > XMIT_RECURSION_LIMIT under KASAN") in net-next?
> 
> The dead loop itself still reproduces — dmesg shows "Dead loop on virtual device" for
> every connection, and IPVS InPkts keeps climbing. But the stack overflow crash does not
> reproduce with 7f1de03e3103 on KASAN, since the lower recursion limit catches the loop
> before the stack blows up. So 7f1de03e3103 turns the panic into a packet drop,
> which is expected, but doesn't fix the underlying issue (ipvs_property being cleared
> unconditionally in skb_scrub_packet).
> 
> Thanks
> Chenguang

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1057209553-1790583056=:6942--

