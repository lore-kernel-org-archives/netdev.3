Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8348CD75;
	Fri, 14 Aug 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727255; cv=none; b=gg9bd8ykMEnzi1lx1/slvm+QI7pZjjDmtDk6jJAwpp2Rx1J3lABm+sMbjon0ZbQ/4uvjmWRk5E2pj5ikefKsd2UNdKmO98d71rvW4gwIiRd1BDg85gGCH1+amJAzCKFYAfbTmakYCyTMWDEYrzZltFANBxXER/09mIRBSA6BiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727255; c=relaxed/simple;
	bh=BXc/C0HzX+fMymLmh/BhTiXUNiEY4gLhRKgEfP8aRTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubwNnWLaQtDq9l8AFRIlhtPhr+P0IZn2QggjBsOcj6GPq/SBROoS0ylgKtk76aAcYek816Sa2PvQ44ISJHVIaTSpQH7C8F9CtqnwFfZJECSLoSGQJUBe3SFKc93B2c2U1CN/PPjRNTopy9P/UupyAe8EA0SO4BCce4VBP9j/Z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdTO9E9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdTO9E9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCA71F000E9;
	Fri, 14 Aug 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727253;
	bh=r4ORb1DTeujizYKfiNHsE+kRrkZApO8XZpN5qX2IIi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VdTO9E9ALaY+S+QvHD1nuGWFFx0Nxko28ptLYR/aA6sFT3e903K7xBJopr08IduG7
	 pWULYT+7HWN5WPya6pw0UurvKOogO9F7LvFiis3UJ/pKHshAgs7GHOki+auxGZxCqF
	 iLVfMaVmnKrkk8x4b8V3wlUzFYd6OjjOfWktj3hAgSdnikaSEciFS9VYzgJpC02QRh
	 FzW9MvnzMaPCrdQiiF7fFy0f7dNG3OOy9VPH4eJftLnG2o+w43CCsfvtKgSrkR+7YA
	 nDdqqmf0ZywnB5YV2qqd8k4EL2uNixoGHvqkovGbjZSy79cF6+A9Vltv7QP7rPLICe
	 p6xNoGXjGr9rw==
Date: Fri, 14 Aug 2026 10:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@meta.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Wei Wang
 <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wei Wang <weibunny@fb.com>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on
 netdev psp_dev
Message-ID: <20260814100732.542308e1@kernel.org>
In-Reply-To: <CADe0Y=sQ0e=snxJBd6kBz08eYR4BrX_9Xbr=XEHGVcXzybfQow@mail.gmail.com>
References: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
	<522517bd-869c-442d-81c8-c0236563a925@gmail.com>
	<CADe0Y=sQ0e=snxJBd6kBz08eYR4BrX_9Xbr=XEHGVcXzybfQow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 13:37:23 -0700 Wei Wang wrote:
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202608080910.l9KvOH7O-lkp@intel.com/
> > > Signed-off-by: Wei Wang <weibunny@fb.com>  
> > Commits targeting the net tree need a fixes tag.  
> 
> This is a sparse warning fix, my understanding is that it's not a
> functional fix and therefore should not use a Fixes tag. Please let me
> know if my understanding is wrong.

I mentioned "no Fixes tag needed" in internal review, I should have 
been more clear that this implies net-next, sorry. 

No need to repost - we'll route it to net-next when applying.
