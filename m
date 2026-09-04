Received: from mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF887372662
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487310; cv=none; b=r+4z94MhddYbO/iYF09tEfeYCy08CgPZPenz9wTlJD3U8VMLeKfEVMWrUciNia4G009yVeB8Z6V9Pm9sEze2mNowIxvANqVgsGDBOxaLJVlI2SQZKRPgiZwg9DrKavtC0BKLtICfSsJ8682GHLYzpihNK83gNyZOO375j5BWkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487310; c=relaxed/simple;
	bh=fNh9RgrHAXXnQGU7Q/Rv1SxLKLnlNBCGiUgvLPYYYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU7ZX32d02oRNXQoPJbsajBBmgm2GjZnmlRtsX+Iyerlu62OD0BzZNyNjwF/yl5YezZ7+M2nAQK3QGTg+BbWB89Gw89tgyco6j2gdSSL0I0B4W/1eRQRvvvdTgH8lv+fmORs81o4qLEcOBao+65DLZ3n9TsK23d74LS5+AEeUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNl8bBHe; arc=none smtp.client-ip=91.218.175.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNl8bBHe"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fNh9RgrHAXXnQGU7Q/Rv1SxLKLnlNBCGiUgvLPYYYhs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788487306; v=1; x=1789092106;
 b=NNl8bBHeAwNTGp8UxtZ7M0SBdFf7hCArfu6O12vpnpGosND2LztuHp01pWIcHRSWEiEa/E5y
 ze+pSAKvNpKJYbCJNAoJqqI4662PAiTpogvC/JEwy3abAe7KDy1U7LwS5tXVByOPXItAU02xXC9
 uIffxoj6QTn32zKvgIhQe6I4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 482c9cbf7bf4a191;
	Fri, 04 Sep 2026 02:01:46 +0000
X-Mizu-Trace-ID: 482c9cbf7bf4a191
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 10:01:35 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <apomf_zIZM8DaMai@fedora>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
 <20260903092258.67ea7b65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903092258.67ea7b65@kernel.org>

On Thu, Sep 03, 2026 at 09:22:58AM -0700, Jakub Kicinski wrote:
> On Thu, 3 Sep 2026 12:38:14 +0200 Matthieu Baerts wrote:
> > On 03/09/2026 10:10, Hangbin Liu wrote:
> > > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > > 
> > > When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> > > already incremented. If XDP setup subsequently fails, the error paths
> > > jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> > > 
> > > This causes slave_cnt to drift upward on each failed enslaving attempt,
> > > which would lead to unbalanced traffic distribution with round-robin
> > > mode.
> > > 
> > > Fix it by moving the slave_cnt increasement after XDP setup.  
> > Thank you for the fix, but it looks like it causes multiple KASAN
> > issues, see:
> > 
> >  - https://netdev.bots.linux.dev/flakes.html?ld-remote=virt-bonding-dbg
> 
> Hangbin, this is at least the 3rd time in a week when kernel selftests
> find issues in patches you posted. It's really time for you to run
> these tests locally.

Yes, you are right. I need to setup local NIPA ASAP. And I will not post
patch before run all related tests on debug kernel.

Sincerely sorry for the trouble this has caused you.

Regards
Hangbin
