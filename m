Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A30EF95
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935081; cv=none; b=CYJM3ZuTiywVhheL2L511EXuh6nnqgbd6zxQAQCGVeoH6GWhAAiA2Jb4k3ClQQc0f4iFBupwnbj8BVx1Xwr9mLce8hMWrfhKO0Nb9GbIHt8k0ZG0CwXAt3CHT/8y84qw1u6QG3/oF4+dZOhfCeZs9Bda2phv1A0FjuiZ29/olbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935081; c=relaxed/simple;
	bh=TaaSl3x33kahK1GMwsF+YQXsmuPsVMv/Ht4a/oy6qyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYt3KgbOxD4Ocjobn7XPmgAt8Y8H9loWljM47J1+iMXu3l1lX5rKm64ZY4lFr77gKUMVN5mapVV/TWPnxCXggzLJ6uXs8sHDIEG/mk8ZK9+aDDZbPOK6MC2/iJa/6fszHy1fGybCVrU0lzraReTSIVRSdb1EiQzQJutvHKT1Hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkcCrvCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkcCrvCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7B71F000E9;
	Fri, 24 Jul 2026 23:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935080;
	bh=TXH2oHnfU6xZankPQ/88EvpjfWhOagbdW9wfZcTbPnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JkcCrvCsVNfqb4wofFLnXONMWwQyZXCXMJGkpkf7Yx3ebZhOp7nnzWnhhGC6ZJFRV
	 NDxtt1PC/dGnKzL9KTVjj64pfeMBmG2dZ+suUagkt6aCZ5w5xWD8ng9NzIPvDBC0+l
	 5YoAwPl7IVXyInSq/CoKbr+q1i/t6PPfn4VmpyIZCwBtCVKyZUAYN5fOa/lT7LG3BL
	 3hKMTf3iO64P7ZlFVvKVXjU6zE3Ihi4fKSkk7+lPm40JbJ0BqZPJrDDLwoktD5JmaD
	 pipS/8G77cNsXv8h15SLrkldNP8ooeFrOo6W7oZ4F+4oSpWwBrr3i4xiteOPDhulLB
	 3/c9T/aKt6ICA==
Date: Fri, 24 Jul 2026 16:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vimal Agrawal <avimalin@gmail.com>, kuniyu@google.com
Cc: pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
 vimal.agrawal@sophos.com
Subject: Re: [PATCH v4 net-next] net: neigh: avoid calling neigh_forced_gc
 on every alloc when table is full
Message-ID: <20260724161759.0d6998ce@kernel.org>
In-Reply-To: <20260721140911.2e12e60c@kernel.org>
References: <20260714133909.82424-1-vimal.agrawal@sophos.com>
	<20260715055311.90403-1-vimal.agrawal@sophos.com>
	<20260721140911.2e12e60c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 14:09:11 -0700 Jakub Kicinski wrote:
> On Wed, 15 Jul 2026 05:53:11 +0000 Vimal Agrawal wrote:
> > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
> > on every allocation attempt with no rate limiting. In workloads with mostly
> > active/reachable entries, the GC walk traverses a large portion of the
> > neighbour table without reclaiming entries, holding tbl->lock for an
> > extended period. This causes severe lock contention and allocation
> > latencies exceeding 16ms under sustained neighbour creation.
> > 
> > Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> > performed within the last 50 ms, but only when the table actually contains
> > NEIGH_FORCED_GC_LARGE_TABLE_THRESH (16384) or more entries. This avoids
> > repeated full table scans and lock acquisitions on the hot allocation path
> > while leaving tables with few entries completely unaffected regardless of
> > how gc_thresh3 is configured.  
> 
> Hi Kuniyuki, are you still unconvinced by this?

Looks like Kuniyuki is AFK, please repost this in a week (Aug 2nd?)
This patch is the oldest in our queue and it's getting close to 
the auto-discard threshold of 2 weeks.
