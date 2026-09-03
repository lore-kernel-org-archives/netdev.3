Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCF449991;
	Thu,  3 Sep 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431353; cv=none; b=cjf9r1AxHawAYE5kNqWnfjRhcgTLqtEthrKkU8u2r57YKliwBiPKMq3kcpoTGbe4Khl89yRmUObjQ+LnQhugO/poV5t/3ZWqtvX2EUnalvbg4PwuoX4j1DhtA83U0jxv8hfnCZrShHW69YFDyJhV7OvhkOJDKCoSHcJMDYA0rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431353; c=relaxed/simple;
	bh=zfcVxb/vU6PCvEnajX+5SwGX6yzzfmTqK7qsn4xHsss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwVj8MtZhjJDCIy+fKtZTmozzVs/MXuaI4S5WVzKoQzbll86iIjFaetz+X4Df//ZJX92S4C8JfnMKIJBrcIaGofXDGjtxm8wEs/pg40oc8NFYKF8hZfNsNtFgs8TzsMTN206p6bpDwyBW4KoEwhV8TuMQXrNxaTwR/uRWDZRNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7RTGYyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7RTGYyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0CC1F00A3A;
	Thu,  3 Sep 2026 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431341;
	bh=frJAIPpeGwRFxP+0jX8ONW3cNlVaiDQu0/Mi5qIBwC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j7RTGYyUKfCWcrNNAShaZ9bN61a2OXxzwmkk9IggRqDxd2KfaHlgzvc+yU3spxgf+
	 2ZkQBEdR+zyns0VyzuMYjOWJBG0vJR3S1fbzBk/DP0S1o6t8BF/eHH1vRsYA/fFW6K
	 s9W6Jg4D1GezK8vurJG+z41EFOwotty1CSIe2dvkBQxMr5ZPZIFxLjCtsXNTXTgBRH
	 zZUOJMc2ftsSOunkr+FBIpKT0UDhsEQuWE8llCp8Qd2dKIEWsWazcNJjHEzogZZsgp
	 dPTB5v02GnzLiBRvmx7u+VxoOrFOPCORN9FklbDDVYX52xZmfmEUGiHeLScjIWuE5J
	 B1n3qzeg2IZ8g==
Date: Thu, 3 Sep 2026 11:28:57 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yang Zi <2959243019@qq.com>, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, kees@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: avoid sleeping allocation under
 octeon_devices_lock
Message-ID: <20260903102857.GK396647@horms.kernel.org>
References: <tencent_6653AA61B6BB17B8D845A89977D199C08C06@qq.com>
 <20260902155423.GG396647@horms.kernel.org>
 <20260902175808.095e3cd4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902175808.095e3cd4@kernel.org>

On Wed, Sep 02, 2026 at 05:58:08PM -0700, Jakub Kicinski wrote:
> On Wed, 2 Sep 2026 16:54:23 +0100 Simon Horman wrote:
> > On Tue, Aug 25, 2026 at 04:50:55PM +0800, Yang Zi wrote:
> > > octeon_allocate_device() holds the spinlock octeon_devices_lock while
> > > calling octeon_allocate_device_mem(), which uses vzalloc(). vzalloc()
> > > can sleep, so this is a "scheduling while atomic" bug that can trigger a
> > > sleeping-in-atomic warning (or deadlock on a preemptible kernel).
> > > 
> > > The memory allocation does not touch octeon_device[], octeon_device_count
> > > or the free-slot search, so it does not need the lock. Move the
> > > octeon_allocate_device_mem() call ahead of the lock: allocate the device
> > > memory first, then take the lock only to find a free slot and register
> > > the new device in the octeon_device[] array. If no slot is available
> > > (all MAX_OCTEON_DEVICES slots in use), free the freshly allocated memory
> > > and return NULL as before.
> > > 
> > > The lock therefore continues to protect exactly the data it documents:
> > > the octeon_device[] array and octeon_device_count.
> > > 
> > > Signed-off-by: Yang Zi <2959243019@qq.com>  
> > 
> > This patch has been marked as Not Applicable in patchwork.
> > I assume that is because it doesn't apply.
> > Which I believe, in turn, is because it is whitespace mangled:
> > the tabs appear to have been substituted for combinations
> > of spaces and non-breaking spaces.
> > 
> > Please consider updating the way that you send patches -
> > e.g. using b4 or a different mail server - and reposting.
> 
> Also we should consider deleting liquidio instead of fixing it?
> It's _stupendously_ buggy, and Orphaned.

No objection from my side.
