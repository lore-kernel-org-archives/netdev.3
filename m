Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBE3B1008;
	Wed,  8 Jul 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506941; cv=none; b=lY5yZOLhh47Hn97POCdbdEq5X3X8o2YsmuY4yLZPqcq7lF7LYXM76Eflsm++DXBAdZkNalIHDjOfVMbbAyzyl1g7DFS8Gct+1kmb/8MTntrfbPnX8icKMtgyMihVWxJaYg222SVRmh8RDUuVci7pEJnKAWVPM4Gwa08ifrgCwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506941; c=relaxed/simple;
	bh=oEs05xUIOBZQyRYKYTv/Tgy7jEQuapabIja6jUkC0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsKQjQgvxi95vkiOSHlTZ1iFJJtw54ybDZ67cUIZ/5F/LZO3vDpvP+a1cLVQR21CBswGZDxXdg7M5cJnadqlA/f5qAcrktPREBQLbpXnir+COyaK3O4GW+thYFfw6aSXrsXLO3dMcouJmLUudNFUwsi0tQDHzLBeH30x+nkMXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9zEglhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9zEglhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D21F000E9;
	Wed,  8 Jul 2026 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506930;
	bh=dXoRTVr/PLJDIiXgP4eMdvkkjVQwAoZz5S4KRKABypE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9zEglhkTLZG1Fbu87O/HB6/qelCBlamYIYqHOO0ZYfuQTgo8Fn28Nlced57oi6rw
	 E7AshxOdTU+whbcaXowmW81T6uS1DwkuNkDGCHjLkPz/3nbEIijv3C5jztMdpLuFXY
	 AWgY0ukCaEdI0kKCrWpq3zuDcRSheVhKYAPxFybWqoUoe3LENKu3GgIVu/xduVD7+w
	 7btb3ZX7zem9YPa9cp+lg5VcdgI9AHjaqMZmCDjxQFla9Q6XUXxCDnjRoVuqhzoQpy
	 NwOM4MqlO+9wVLuhdDbDKgrlR+4NNRSa80CeHyDrcHKPq4WbEIr++F050yi3vnXoJV
	 Lnb2evE6FIgyA==
Date: Wed, 8 Jul 2026 11:35:25 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <20260708103525.GJ1364329@horms.kernel.org>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org>
 <ak0SYEOvw6K_8C_w@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0SYEOvw6K_8C_w@chamomile>

On Tue, Jul 07, 2026 at 04:51:12PM +0200, Pablo Neira Ayuso wrote:
> Hi Simon,
> 
> On Tue, Jul 07, 2026 at 03:28:20PM +0100, Simon Horman wrote:
> > On Wed, Jul 01, 2026 at 08:39:25PM +0800, Runyu Xiao wrote:
> > > The GTP PDP lookup helpers are shared by RCU-protected data and report
> > > paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
> > > helpers walk RCU hlists, but they do not currently pass the RTNL
> > > condition for the control-path lookups.
> > > 
> > > Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
> > > RCU-reader callers remain valid because the RCU-list macros also accept
> > > an active RCU read-side section; the added condition only documents the
> > > non-RCU protection already used by RTNL control paths.
> > > 
> > > This was found by our static analysis tool and then manually reviewed
> > > against the current tree. The dynamic triage evidence is a
> > > target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> > > to documenting the existing protection contract.
> > > 
> > > This is a lockdep annotation cleanup. It does not change PDP lifetime or
> > > hash updates.
> > > 
> > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > There is an AI-generated review of this patch available on sashko.dev.
> > While I don't believe that the issues raised there should impede progress
> > of this patch you may want to look into them as possible follow-up.
> 
> This patch refers to the rtnl_lock, but it is the genetlink mutex that
> protects updates on the PDP context list.
> 
> Then, from packet path, rcu lookups are performed.
> 
> I think this patch is not correct.

Hi Pablo,

Of course you are correct.
Sorry for not realising this earlier.
