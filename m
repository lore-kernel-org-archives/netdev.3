Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9C3B2FCE;
	Sun, 10 May 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433838; cv=none; b=s69gE1xvibez5GjHVS6rcYIv+BhArXHFMFG9Q1pyCvJoU3eBFi9L9gj8vro+amUJnrQ31nBHJekrGrI9exd7CZd7DwjodZNW5NApmW0qk6mHienQGmz2nM0U3b5P7pZNw8uXzeo+FxHN8AT4vv7hFF0Iewgr7DhEeV9rLf7thu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433838; c=relaxed/simple;
	bh=QoVU76Cp0NVeUsf1JdZme8c40qs7HpiOp/24ZpvsO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hgq4dhuddHqd2fqo+6nPOawkYLv6KwyEBvW7b9ppfa2tULmzQfue4n1uGJY8BxWBWF2tWx7LU2xZ1hsgHWlVfbTBcr4DUUpXA9QGxSOdvXba9R9qWN35tOWrDZHaIUDfYkDXLKMJLz29jGlFDfV9d/FLJ60sZ4fcmYdOxj7emho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3zjhobr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3zjhobr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED70C2BCB8;
	Sun, 10 May 2026 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433837;
	bh=QoVU76Cp0NVeUsf1JdZme8c40qs7HpiOp/24ZpvsO9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3zjhobr0p0caeMJq7kgKzz5Dt7+ZmgQeGmbBtivyNKSNcDHUObRCk1DbwAEPSm/0
	 VRHsbVdCCGF9g/6m44cEWuQd/N17rIS70zg5kjXcFOU4/YKEi4Bjlc62GbcyHeV5sO
	 fjpgpIRURAVsM/zPB2Mtn/EzQfCu1wUmdl/sHVHb+fg+8Dx9apb5b3HXLgdz4Pylab
	 maJuzsZIraHYFVVRdN1lgfhP8D5UoiSHh4GODh10M09AIG0KpZ8UvUVqPbyc9/6j3U
	 xJHt0uiXVAW+lr9uz1sr3SZjOf7xJr6Cn9Ri2AVqUhjXnIbSTlWJqMLejvqWzqrvLy
	 BIVeyGK6CFF8g==
Date: Sun, 10 May 2026 10:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <20260510102356.1e41ac6d@kernel.org>
In-Reply-To: <agC6z1FeEN6jMjyk@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
	<20260510084520.476745b5@kernel.org>
	<agC256wVYa4Gnvy1@v4bel>
	<20260510100310.230b15ed@kernel.org>
	<agC6z1FeEN6jMjyk@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 02:05:19 +0900 Hyunwoo Kim wrote:
> On Sun, May 10, 2026 at 10:03:10AM -0700, Jakub Kicinski wrote:
> > On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:  
> > > On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:  
> > > I was testing a patch based on skb_ensure_writable() but it seems v3
> > > has just been merged to mainline...
> > > 
> > > What would be the best way to proceed?  
> > 
> > Depends on the tree. Where was it merged?  
> 
> That's the torvalds tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71

Send an incremental patch on top of that, pls
