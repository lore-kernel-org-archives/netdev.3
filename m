Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC328A3FA;
	Tue, 16 Jun 2026 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643660; cv=none; b=u6Hk0e1ad2Jo+2hRSC1DDNVJ+srFnq0RRTfrqCqXxOnyUp7g7N9s0DNMJWVlxv9Kc9HUirJ8N0JsIKvIVgvlQmsmdDWIIg88/VPQNfPn0eeOJMimP+gqudhm7vxxpb2jdcSS4H5Zc0ioaJfRNPnUBcGxeVF+mSrESOu1Zsg61ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643660; c=relaxed/simple;
	bh=WsoujMZrT9SaiHwQY0Ibg4au2nX+hLKzfLC+G7CHlVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqm88mQ86BWCXKHdHYgC8EsE3T9wrEgxiYW3S77OrF/pGYxByfBGBOreFI0dDzzKAK6/9w78EbZsuGS7MMnzVYjbHB19RVQLOUhgXFiw4KbSjgTkdoHUqmRoo4PBZhqXCk5ELMauww62i5DTU93OrypQF2I0P1jZBcR0/onqX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=tnn5G4KV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6+561Cj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="tnn5G4KV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6+561Cj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F0BB140014B;
	Tue, 16 Jun 2026 17:00:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 16 Jun 2026 17:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781643657; x=
	1781730057; bh=7OCmBpm14YGh/RsHx8JtMtdaVhHc1rhuAXLFNR688Ls=; b=t
	nn5G4KV2AemekWneeYwAap6PtV10MvWDvB9cBfn12OJheab73MO8+neGem5vlLvB
	nDniv9zV4ER/o0qEr+/ZLivwi5ybqt90+5WX3+U6ftgzK1BS//f8rxB7cFVMr5mV
	fI2QsG3y1VdKYb2L284IuPC4eHBGPo+UyLvyHx99IHQCOhRSPd/IpaD0M8ensdpc
	cU4xoDfq6w9F9Tt8BRY6fq7eP/jke/umaoPg6grmk7lUN+oGTVev2xtkYkfQwoLi
	4Vj9o9J5yk7aKfoowpHw1pVse/sZHALvSqdnfEEO7GGb8r3NyvShvEnNoisDaTda
	farFkV/b112TGa6Q9IxXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781643657; x=1781730057; bh=7OCmBpm14YGh/RsHx8JtMtdaVhHc1rhuAXL
	FNR688Ls=; b=k6+561CjBK2Vh9BHJUAZXuoxhkEAfxxa9lLlpFxKFb5GNZymj8F
	QluUib2jI8mN3frFVNUuUPf07lKYMpP+DGHZ7w9CW7QytaPhHFTkiT1gTMGRvwhx
	jmOZ2X2qe36FATkyAmbawJO2/gUdd70G9Pr+IpUYHNOGanGOHZMA1LwTfqQRB+gg
	ma1QNshz3HGf+4J7AycxgJ5253W54Q5UiETkYhFQJLdnVmO1CuGIYjEovhhwMOE7
	bRKEp/8eTT7hOXTb8FEtIK7EklxZOQOcrpwJYfkJntypd6seTEWIE9jDlcxbINVZ
	hX9QDv8ZHllqtYH4x0VOjay++Bjz5wTz5VA==
X-ME-Sender: <xms:iLkxatFR824kVmKyNli2inOrkjS-FWqRlQ2PMWmlCVytbWZ6dviLqg>
    <xme:iLkxaoUTylwYO844lilucS0v9oxfsITbH8-q9uccC2SwlQAcwCit9whGkvWrO-gGg
    lfCywAh70TDJ9Zz6fYv4dXWnqXRSK-Jjbs32w7760rzDSe01TMkdw>
X-ME-Received: <xmr:iLkxap828PcRwAfzaTOplekAnXQ-aFWMyFB6LD0zUz4IdI-YmZIR91iZ2ZBCqIV__72cWmJcnurIkQVv8rooW_w>
X-ME-Proxy-Cause: dmFkZTEu80uHfl9AJZCbHRhjyd5Nj29+YGxPuRk4OAYpFusrsU5S0ETpHDtlh12bB+99D9
    bsESsUIomHC4f/vZ1Z3GqU071/4xLcm/pzs1/NrprCXfJzxh8WAwPZ/Mr0BxYx8NZSC4lN
    jMdNoS2beNF2BCIQJRS9Y48Y15fETUym59Sy/Vwv0Uu1k4OrtTWdk+FNjaVLWefCfp+jxL
    DJ8ed+SQujYFNfuZ4VooQuR/LYZqphR0KYBmhZcNNPdidqVEXWU8xH5mno/VU2jZEh+6KE
    9tR+8vVJRPvA3E0lItMudb0yMZsQNyuGD6ifsda1TJc14x7LY+46tLJlbbMz41jLngcHi7
    NXdK1L/1NsZyMB/y7B+P2opnW8SwtgHZYfc1c9FmJyWzKiGTXGnZhEkCbt/lPY6uJ77XJ8
    2Rwme12M+YUZeE0f8arWOgFaUMU3pqScPvOD1e2C5wvqyOrumKIrFnL6/IEQ937wjCtI2p
    /njdqjEFATbSaQOrb0StrtfK8Oz/2Ca5wxH1TDg+bU6nci+vjjPxfCmT+pcraBDKMhGkyL
    t4rpM0DT4XS+w8Gj4gw+Nx7KlMV0MECEC9aL/u4tcCwaYZl6g+UZf1H3T0G/CRMkRjcnb6
    ONBEzdEOK9Crfxakyp457lAYMi4FU9W5IDc/rUgk95Tr3LZk7nONE9oFDklA
X-ME-Proxy: <xmx:iLkxal4sYGELSN9eASoOYtDp_omMvQVsum5hQRbKKIN_CPa-YuY1tw>
    <xmx:iLkxaika8tFG5eKZ7JcQgX-zdjtSbPXRchCkBmVoUKwKWZMUofxMLQ>
    <xmx:iLkxaoF_2vUHxOKcXJNQkNiI9VdgSYY7ef9sJpcMPi_GVLtMgxRvHg>
    <xmx:iLkxap9z0FxhXd1lWSKdmjPbtWQ6lft4DffIX2tOheZ__cAqG3ki5A>
    <xmx:ibkxagD5DAlN1ieS1RrNG9CqglBagajJxqFWjRbkp42X0H9Vp67gWwmd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 17:00:56 -0400 (EDT)
Date: Tue, 16 Jun 2026 23:00:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <ajG5hg9oJvyxPplG@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
 <ajFpejsl1ukTbG96@krikkit>
 <20260616082816.4dd0f035@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616082816.4dd0f035@kernel.org>

2026-06-16, 08:28:16 -0700, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 17:19:22 +0200 Sabrina Dubroca wrote:
> > I suspect err==0, and sock_error() consumed sk_err in between (the
> > alternative would be err > 0).
> > 
> > Something like this?
> 
> Makes sense, but what's eating sk_err?

The 2 remaining sock_error() in tls_rx_rec_wait()? [1]

> Don't we depend on it being set
> to avoid further state transitions once we hit a crypto error?

I kind of thought so too.

> I thought that's why we don't consume sk_err in recvmsg and sendmsg in
> the first place (we are not calling sock_error() anywhere)

Umm...
[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/tls/tls_sw.c#n1095

-- 
Sabrina
