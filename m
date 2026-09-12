Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D31E5724
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173059; cv=none; b=FUj2hiEnFFwTwF+GT7IdeyS7PVhYmifpEDK39yVr5AZ0v6av9C15FejSMi3gp/2L4OEDN0AUM4RRK8SyBcJR/SKppt+bJuz3hfPWLiiTahilpevDMwWc0UhI4tG7m74wbPDbGgR8+p7ViWYLTr2vKza7AX26sNesbAds6SX4zGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173059; c=relaxed/simple;
	bh=wS1tsR5JfG5jPUa1KxbtmwtdForuksVWUYtfpiplmm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILJ9G3jWBg313mKCBN00Nvz5rahvN9VySw44Vyr7qEtwJyUzEBojjicBNYSleeb/sjumDmdfzg5GOsOjJOjyf3zCqwqB86+Dynx+1qBkD5ek7rR3i3DAmhmeAQ4ltHmiSw02/1kfHhFmuyWm/O/Y+MCm2DMBCVv3qE0pNweh778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4VdqUBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4VdqUBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316CA1F000FF;
	Sat, 12 Sep 2026 00:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789173057;
	bh=KOJzgDl5ud6JD/2lr4ewFYrJIHT3FVX2Anj6rjeeQPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f4VdqUBdI/Wuw4dmc8JyL4K5Ri58VsPWguu1YOzZGeQ8ErPAUH0lAV/4NiLq2UZ0X
	 g1g8ipbijK0SdBvj2bBagrEFcREr835PJntp7qqunnmfWa0zHKXmeGCTHc+gaxz/cQ
	 ZazBRve3MdN1tLcHb8QNV4mAwPN7MfuUjayknXgY+lgJ85W0FfNNH7f4D22c1FjN/2
	 1498HUuq6BoVxKAgvuHg+Q3cQ9P1D0yKe3GPoLianaOm9wQgtj7SKUEPpOL+CyOlVR
	 O9wVVCBefKRxsj4LvGX8AuecmCDG7VVcqENsez4eo+I8hNN26YE7EP2nl9pR1K5S34
	 GWruOcTW5f5pA==
Date: Fri, 11 Sep 2026 17:30:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net 0/4] neighbour: Small fixes for
 RTM_{GET,SET}NEIGHTBL.
Message-ID: <20260911173056.44ec06e0@kernel.org>
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
References: <20260909233143.2401847-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 23:31:22 +0000 Kuniyuki Iwashima wrote:
> While working on the follow-up suggested here,
> 
>   https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

Conflict resolution with net-next:

diff --cc net/core/neighbour.c
index 27602bcbeb69,7448320f7ad5..000000000000
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@@ -2659,9 -2620,15 +2669,12 @@@ static int neightbl_dump_info(struct sk
                                       NLM_F_MULTI) < 0)
                        break;
  
-               nidx = 0;
-               p = list_next_entry(&tbl->parms, list);
-               list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
+               default_skip = 1;
+ 
+               list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 -                      if (!net_eq(neigh_parms_net(p), net))
 -                              continue;
 -
+                       if (!p->dev || p->dev == blackhole_netdev)
+                               continue;
+ 
                        if (nidx < neigh_skip)
                                goto next;
  
?
