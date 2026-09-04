Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F9131E49
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486027; cv=none; b=jVW2d/5q+OvdSWU1hb5tCpEEc8dyO6d7NFEm+i+PEO+UlkRd4ogD1TITvk1OVmlO91l7KDL+fjcMzRemxNPnwT0+Fden1Maii/RrQjcJSClQkIVXNAjunxugsuHiq66Vir87xRF1fAw9hHhMORE+8r1qrd84l20g673V9s58qJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486027; c=relaxed/simple;
	bh=RWPQjgTjzR14E/Y+lCzq3FRim9vkxK8QSYISw4SHaGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVRHxj9CSDNFxPyYvspq6ShO2UY+dmd3LgkEVonT6FF+iGWnaA4LJd8bOOYyI3RBQ7QiRqIW+R7OAbsxBNvsMawiU7TBlL2/NNZlcTMXaP8pAWY+iHvYS/etNfDGnPWASnuZsteaKQBAqxIf4r+eif2uP0bZdhWcDNCELzled6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tOjYzUkk; arc=none smtp.client-ip=91.218.175.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOjYzUkk"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RWPQjgTjzR14E/Y+lCzq3FRim9vkxK8QSYISw4SHaGE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788486023; v=1; x=1789090823;
 b=tOjYzUkkPKDGxKgOq8SU5T5rBn09VBabaNDAya1wYI8WHWDzYIjuncgjMYDYEo/OZa5PVep6
 3HLsEdfhaGz/FwJlTLD9e30/zfICI2lOqEpVFpggXFwDLJkJaQNhyzO5zP/XRPLCij/XHhjIT1g
 D4rwWbId0gmo4Z/b/k665AWM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f3fc155831e2df21;
	Fri, 04 Sep 2026 01:40:23 +0000
X-Mizu-Trace-ID: f3fc155831e2df21
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 09:40:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <apohf2oFl63psEd4@fedora>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
 <fe5f07d4-775c-4fe1-a4e8-384dbc11d7e7@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5f07d4-775c-4fe1-a4e8-384dbc11d7e7@blackwall.org>

On Thu, Sep 03, 2026 at 02:53:29PM +0300, Nikolay Aleksandrov wrote:
> > Thank you for the fix, but it looks like it causes multiple KASAN
> > issues, see:
> > 
> >   - https://netdev.bots.linux.dev/flakes.html?ld-remote=virt-bonding-dbg
> > 
> >   -
> > https://netdev.bots.linux.dev/branch_deltas/net-next-2026-09-03--09-00.html
> > 
> > e.g.
> > 
> > 
> > https://lore.kernel.org/netdev/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn/raw
> > 
> > Cheers,
> > Matt
> 
> Waaait a second, it is moved after slave arr update, yes that would cause those.
> I missed it in the review, in my suggestion I specifically said it must be before
> the slave array update because it uses slave_cnt.
> 
> It must be moved up. :)
> 

Ah, I thought all the code between netdev_ops->ndo_bpf and
bond_xdp_set_features() are xdp stuff and missed the bond_update_slave_arr()
in the middle...

I need more careful when go though the code and do testing even with simplest
change.

Thanks
Hangbin
