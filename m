Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3147DFB4;
	Thu,  2 Jul 2026 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002943; cv=none; b=MSZdHTBHONPLceqzy/NNHvtnZvXZB0JztpYRQ95s0irCSFCcoI/eKMhK+S/yekLH5jku2KQ/cRYf+BnNLuyTtPEUQrxRjJJAltiE4JpUhHFfKRBX3aQDoha3CyPIYvCfc9MCdQhkacUQaMPevto4L3SCjsYdomdTAVvzEmNDYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002943; c=relaxed/simple;
	bh=OChXG95dXklADOHWHO2RUZcCF9PIoKQeA5FlqfWEq6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBAfFKtVONFqdchCnUpt0q1YJxI/jA+180Wvkk44hXor1Z4C7SxWeYOyP74AVpa9aLvvc2+3k9mC62yo/Opg1++jkYvDJ9mcSgyglD+6Xo98tqmUuGw9e73o3xd/c6xG/hB8shZ4TiR4OiHeSNa/zny/xbKCkjvntzIvmIGb75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEQ4xkni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEQ4xkni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9276F1F000E9;
	Thu,  2 Jul 2026 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783002941;
	bh=wH9rv6AxNmdVYoJg0T3cBY47n1twfT656Q2yRzOY/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mEQ4xknizAwN9m9BBuGqodJtOesHR1ePpcgaFcVl6YLkUgpkmhQNwKJYORN0RL5aF
	 Zap7xy7QCA5EX2jc+RjnYkBghVkLQf0NjvYHMD4tLjcHgYHcH8XBZ+HsZOAjvFrxmh
	 A/TqLdLqF5kjtdjg7m4aGrJMbqzRP9MlAgaskdofaJoNtgjsRuB5ABSs6Xx0x9Jzko
	 DMSkjzLGGfKy4hDC9e7AjonGgU4uifZFcqqvZwprngUIFYE9iWHd4LTH6JGEUGLNIQ
	 h6QrGBZQ/H80taGOJwizJrsrEzSuVqY0v9sjHpJnOe+cO/eIpPsxu73DhapD9oPms5
	 2khvfGU+SZc5w==
Date: Thu, 2 Jul 2026 17:35:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] bnx2x: use kzalloc() to allocate mac filtering list
Message-ID: <akZ3NuRLZ4YjFGGv@kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-1-58776615db6e@kernel.org>
 <02237688-9532-4fd0-8494-a7bb524ca4f2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02237688-9532-4fd0-8494-a7bb524ca4f2@intel.com>

On Thu, Jul 02, 2026 at 03:52:13PM +0200, Przemek Kitszel wrote:
> 
> > @@ -2713,8 +2714,7 @@ static int bnx2x_mcast_enqueue_cmd(struct bnx2x *bp,
> >   				total_elems = BNX2X_MCAST_BINS_NUM;
> >   		}
> >   		while (total_elems > 0) {
> > -			elem_group = (struct bnx2x_mcast_elem_group *)
> > -				     __get_free_page(GFP_ATOMIC | __GFP_ZERO);
> > +			elem_group = kzalloc(PAGE_SIZE, GFP_ATOMIC);
> 
> what is the current rule of thumb for kzalloc vs kvzalloc size under
> GFP_ATOMIC?

kvzalloc() with GFP_ATOMIC is kzalloc():

	/*
	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
	 * so the given set of flags has to be compatible.
	 */
	if ((flags & GFP_KERNEL) != GFP_KERNEL)
		return kmalloc_node(size, flags, node);

so it's only physically contiguous allocations.

 
> >   			if (!elem_group) {
> >   				bnx2x_free_groups(&new_cmd->group_head);
> >   				kfree(new_cmd);
> > 
> 

-- 
Sincerely yours,
Mike.
