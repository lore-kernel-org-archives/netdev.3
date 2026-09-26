Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F7EADC;
	Sat, 26 Sep 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442061; cv=none; b=NLlrreIPTuWqzZX7Bv6XCYOT7q9lSpdR0vmxrRooUlEl21gA0pMY49hcNEP12pMlzRNHiBOxsLnIIC0P0FwQ1Q+hfTKOkt278TlC7kFiewCXSelgyeTMEo7pTVe6kGGre9ci5boq8WQuDsNhAzjTA0QLbx78SgWg9Qt+vmPlbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442061; c=relaxed/simple;
	bh=8FgZfDPpjkf6bbwxCeZs2e2dLIUhpIr76vxtH25bPYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjbiuS8cOxGSq1BMKRRq3xMd6kW84/L4xMHiBEij+sdKzgPwUV5Cl84gTj8MhfoZ3k/weJK/BuIhWCEgkwFslIev5iNbiIIbgOltqjtQUlWcgl7ImJaRYe3DnISqDgBoKGc3AmQKkxHkp/VSbGWVU0JZCb181+juc1cpAGi4WTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INHKfACK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INHKfACK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C40C1F000FF;
	Sat, 26 Sep 2026 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790442059;
	bh=p4JhTjyg99Gobtfk4fGvMdfACYeXq+Caoau7JljtG68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=INHKfACK4NKnlXMNUQMGsdDaMhEvmeOs5R9+HC4KisdwSnUuZxIkV+o2EXzyntedK
	 FiZWKYszchYFqA7kDfySouMVXG1hqqaZbiuCM5HlgzEm1pGAEmub5cjf4iIZ8AfWz7
	 eyuwRKVb+pbSNoLO+7tkfBgRICGKyJaTccviyiKoZrsrMNB8BZejzPFHeCH6OZuoqF
	 I+e1SMD+Xy28Wpz9D03vTLo1kgHV6VEA46itauAEGeWtEWzdsEoEXYtKKVq783LjSe
	 O+6LaXJCsVS6XNB9Y3ckZNDjPlfkt2fn4VvZx42pQr2dyDs94d6D81yQ5qbIFqgqDC
	 mYFoaW4yCUOAw==
Date: Sat, 26 Sep 2026 18:00:54 +0100
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kaifeng Wang <kaifengw@google.com>,
	Dong Chenchen <dongchenchen2@huawei.com>
Subject: Re: [PATCH net v1] net: page_pool: fix use-after-free in
 page_pool_recycle_ring_bulk()
Message-ID: <20260926170054.GZ13925@horms.kernel.org>
References: <20260925144127.1445667-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925144127.1445667-1-almasrymina@google.com>

On Fri, Sep 25, 2026 at 02:41:11PM +0000, Mina Almasry wrote:
> With CONFIG_PAGE_POOL_STATS=y, page_pool_recycle_ring_bulk() updates
> the recycle stats after dropping the producer lock. If it just recycled
> the last inflight netmems of a pool being destroyed, page_pool_release()
> can pass its producer-lock barrier and free the pool before
> recycle_stat_add() runs.
> 
> Commit fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
> moved this stat update after the unlock. Commit 271683bb2cf32
> ("page_pool: Fix use-after-free in page_pool_recycle_in_ring") later
> added the barrier, but only fixed page_pool_recycle_in_ring(). Move
> the update back under the lock.
> 
> Fixes: fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
> Link: https://lore.kernel.org/r/179028939171.2160803.706522228583664641@kernel.org
> Cc: Kaifeng Wang <kaifengw@google.com>
> Cc: Dong Chenchen <dongchenchen2@huawei.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

