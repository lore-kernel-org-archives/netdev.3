Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF64495AEF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455736; cv=none; b=jK3bwc3hEwErPK4sWSL3srXh5qhHyEVIW0OOzSOSQAEJJnAFeOfRflSKdplVyA3pmbJ1/6KiMeIV8kpLKUz7qjeo3GRHqrnxK9mRZutaZ1qnBLCSG56CH/+4Xbxp+eJpD25COsxZwkwm7dEItVvKOpImYMAOrTtE3o/0F3psyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455736; c=relaxed/simple;
	bh=o6DS2ln/5GoB7E5jqrrYuvJrBt6Q8o6EMGcFxIwWBoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ha3D6HB4F6xRdrCJXeBQMD9wNT5EJHx6teqgAFt+5XVL1yjooMksxqODzrUHDWK90ir7mnvKmPuZCVLaU6PwTxYKyU51qYQ9o+fRzmxxWF1Eh+zzOIjwPuuxUJzuc9Ny7/bVQcpzdOfe/BLP2zGHDaS5SwEr2as9IL3d78gygeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next 2/4] net/sched/sch_cake: reduce parent backlog
 when clearing a tin
In-Reply-To: <QDISC-5RTM.v1.20261007130704-3@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
 <QDISC-5RTM.v1.20261007130704-3@mojatatu.com>
Date: Thu, 08 Oct 2026 12:19:43 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8733ugtry8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> CAKE has purged unused tins on DiffServ reconfiguration since commit
> 83f8fd69af4f ("sch_cake: Add DiffServ handling") without propagating the
> resulting backlog reduction to classful parents. The issue was noticed
> while reviewing 7cbfb180945c, but predates that change.
>
> cake_clear_tin() drops every packet from a tin with
> kfree_skb_reason() but never calls qdisc_tree_reduce_backlog(), so a
> CAKE qdisc under a classful parent (e.g. HTB) leaves the dropped packets
> in the parent qdisc's and class's qlen/backlog accounting forever. The
> normal dequeue path does reduce the parent; only the live reconfigure
> purge misses it.
>
> Tins are cleared from cake_reset() and, on reconfigure, from
> cake_configure_rates(). The qdisc core already owns the parent delta for
> the reset path: qdisc_purge_queue() snapshots qlen/backlog, runs
> qdisc_reset(), then reduces the tree, so propagating the reduction from
> cake_clear_tin() itself would subtract the same backlog twice. Snapshot
> CAKE's qlen/backlog around only the reconfiguration purge in
> cake_configure_rates() and reduce the parent once afterwards, matching
> the delta pattern already used by cake_enqueue().
>
> Conditions to recreate the bug: put CAKE (diffserv8) under an HTB class,
> flood DSCP-classified traffic into a high tin so it backlogs, then change
> CAKE to diffserv3. The HTB parent keeps the purged packets in its qlen
> and backlog; a kernel with the fix shows the parent at the leaf's backlog
> (426b/5p) instead of retaining the purged packets.
>
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmai=
l.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmai=
l.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
