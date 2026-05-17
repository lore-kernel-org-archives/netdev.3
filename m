Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9A1E4BE;
	Sun, 17 May 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021115; cv=none; b=PN5JXxgMtwAe99oBpK2GCkJ99r/qdnbxsuEMJS39/eeG7wCrkzCQBGG0E7A8fzVc52GhGCDNi05QpGXv5yk4ZNwoRzA+Bmxkcm+cE+0l8FwvKr5BuSsogkJVy81sYWd9sydghhTeAgDkafYBbF9oHiQrN2XB1+YU+H2RACWosb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021115; c=relaxed/simple;
	bh=uLnvxPmB1vR2antoKrfknQILK7swuBkofIzFC/Emij0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZaYL0W6/+HOIzhLuAyCdoIW9Fb+mN1V4/UvWB9U8KDMYvwb+8sJMlw3r7Db0M8KnMBZvjjoDFF8yTHV9+f2Cz50GIqBDtERkhRwXVcakRG8x53st9vpvUNRprr7+DU0bO2rU1qcBzHiOMTv0NH1CkcthI37qfpn5sJnPMYyAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chiHlQHm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chiHlQHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2750BC2BCB0;
	Sun, 17 May 2026 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779021114;
	bh=uLnvxPmB1vR2antoKrfknQILK7swuBkofIzFC/Emij0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chiHlQHm8mBHrRh8qil1W2YPVniO/U4VyH4zMiJitFcnum8OvVIHJZv1ZsAebZBe2
	 iXNqf7L8QcDDNOFCCFfjTpKptVFT0ZSDCWztxriGsVMxOJ7j24frjUCzlMEyTHi6s3
	 v29MmAOa40QK/duR6EjnlmxRfr0OA6AI//sAWdyVsTabAdV1QH8YFdUFzp7lR+kbB9
	 jFwGEwQtOYkVu45xy0utNv2wN7yHVYZcS71D6IRlYKX84q2Q0UunOdNM4rNxYk0aqd
	 2WXxSra6DpI0VfZZVKv73s2m62eOZ+9/Blz5VRBdUi4u3xbV0lru7iV4Tgyd4EpXVh
	 ExqFvgwjqGvew==
Date: Sun, 17 May 2026 13:31:50 +0100
From: Simon Horman <horms@kernel.org>
To: Kartik Nair <contact.kartikn@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
Subject: Re: [PATCH] net/llc: fix UBSAN array-index-out-of-bounds in
 llc_conn_state_process
Message-ID: <20260517123150.GC98116@horms.kernel.org>
References: <20260515174904.28575-1-contact.kartikn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515174904.28575-1-contact.kartikn@gmail.com>

On Fri, May 15, 2026 at 11:19:04PM +0530, Kartik Nair wrote:
> When a timer fires while the socket is owned by a user, the timer event
> is deferred to the backlog via __sk_add_backlog(). By the time the
> backlog drains, llc->state may have been set to LLC_CONN_OUT_OF_SVC (0)
> by socket teardown. llc_conn_state_process() then calls llc_conn_service()
> which computes llc_offset_table[state - 1] = llc_offset_table[-1],
> triggering UBSAN array-index-out-of-bounds.
> 
> llc_process_tmr_ev() already guards against LLC_CONN_OUT_OF_SVC for the
> direct path, but this guard is bypassed when sock_owned_by_user() is true
> and the event is queued to the backlog. By the time the backlog drains,
> teardown may have set state to 0.
> 
> The direct path already handles this case, so the same check belongs
> in the consumer too.
> 
> Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
> Signed-off-by: Kartik Nair <contact.kartikn@gmail.com>

I notice that a similar patch was posted here:

- [PATCH net 1/1] llc: conn: drop out-of-service state in llc_conn_service
  https://lore.kernel.org/netdev/5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu/

And I wonder if it would make sense to consolidate discussion there.
