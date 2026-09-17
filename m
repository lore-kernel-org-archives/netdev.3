Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30B241695
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603471; cv=none; b=Xp3NWThZuucDkq4gb2aJr33+s8va4HV+Wt+iktRVeKQjRmQul8IrKdJRXkK0/+Q4/T5NiZjJ9a6bZ9+nFNPV7H2r+1cvjcPo55qlchYO+UZPf2h+mWdt1hygOBVStEjqTd0PLl8Sq8yfR1BE/WwGXY2oCTK8yMBR4ho3tWOWzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603471; c=relaxed/simple;
	bh=u+Pj9pAUO+X/Q5ZeaMXfQFiHU7lBn6HFNovfYG1HJK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzK5xj2EDImDaxI495z3+AdE58FAWcmV+Z2YRvZyP98cgJeuYMxiXn94k6glKKq18jBEXcoZm6OVBttD7cG6387AjGaV1tSXQJC2b/nZlRUjJn+TtuCi2yGe15SH/g6Zvxusssp4i32DHs0WTEcLyeTKuqvyJoLhgohSwsA9XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UezgMlCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UezgMlCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EA41F000FF;
	Thu, 17 Sep 2026 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603466;
	bh=uKCjDp4N3RVLkymTVGUJWi/SrSNuAOXqqL/lrQlUK5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UezgMlCD161dqhmY8HCDjHql6/uC4gQ8+YaxKQHAk6ZsFkJRL0Oq9AUFqbpeeeEXx
	 uN+CKbsiUVkskAsp6Ao6uE4p8gXH/ZhbMp0uJzrTTxZApMF39clwkdb/cHTBO5Iumn
	 IDXaBxlcAwGhSuuEpy0S7m7+75XUxKrjK2kus8nYr3Kyl7iY7iewr6m0bwNcTOZlL8
	 CXMTzRH6w/li634F0FvoTQAACOhLeH7+yTiSri/hNtd9Dg0Q2S9icB+iPp/Qw0+5pY
	 kaI8jFrrMLpEIbFMrQICvlnDIYZo9C9XDFv5leOjrso+CDFUCjssC/Ze7DQwPrRXTk
	 4xeoZsN36jmsA==
Date: Wed, 16 Sep 2026 17:04:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org, Yuan Tan <yuantan098@gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
Message-ID: <20260916170425.1c7a7cbe@kernel.org>
In-Reply-To: <CAM0EoMmiw_kVnK4RjTT_dkquw0YLSB5VgO_7EoV2WT_pQXbCYw@mail.gmail.com>
References: <20260911133146.3440982-1-victor@mojatatu.com>
	<20260914191108.55a1a4f1@kernel.org>
	<CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
	<20260915085304.775a829a@kernel.org>
	<CAM0EoMmiw_kVnK4RjTT_dkquw0YLSB5VgO_7EoV2WT_pQXbCYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 06:34:57 -0400 Jamal Hadi Salim wrote:
> > IMO any attack from containers / user ns is hardening. If it leads
> > to a crash we take it via net _because it's a crash_ not because
> > user ns can trigger it.
> >  
> 
> Ok - will review the pending ones with this in mind.
> 
> FWIW, here are the rules we have been using:
> 
> It is net if: Regression (worked before, broke) or always-triggerable
> crash/UAF/leak/lockup
> This specific bug could potentially cause a soft lockup but it wasnt
> consistently...
> 
> It goes to net-next if:
> a) Never worked (adds a cap, validation, accounting, or enforcement
> that never existed, e.g. memcg-class)
> b) Doc/comment
> c) tests - although the exception we currently make is if we create a
> tdc test for a net patch then it goes to net just dont cc stable on
> it.
> 
> > > Since we have a few similar "grey" issues in our pending queue - so
> > > where's the line for net/net-next?  
>  [...]  
> 
> Given the flood, here are the priority rules we are using:
> 1) submit net before net-next
> 2) All bugs must be reproducible by our (semi-automated) system
> (hybris). I dont even look at issues unless they are reproducible
> (hence my nagging "do you have a PoC?" ;->)
> 3) Assign a priority to each bug and submit the highest priority ones
> first. The priorities are assigned as follows:
> - base (reproduced, ACCURATE) +1
> - Crash (oops/panic/NULL-deref/OOM/corruption) +2
> - UAF +2
> - Lockup (soft lockup/livelock/infinite loop) +1
> - leak +1
> - simple-trigger (plain tc/tdc, no special PoC) +1
> - privilege required: (root) +1 / (unshare -Urn) +2

nice system :)
no distinction between control path-trigger an packet trigger?

> The priority is capped at 9. So a priority 9 with net gets immediate attention.
> A priority 9 that requires root permission is not as important as
> priority 9 that requires cap_net_admin (-urn)
> Yuan has a taxonomy as well; he calls these L1 and L2 when we pull the
> reports from his system.
> There is an exception: Priority 10. These are assigned to bugs which
> require no root/cap_net_admin and other UPEs
> 
> We also capture all "pre-existing bugs" and address them when the
> pending queue is empty. Most of these end up being a waste after fixes
> go in.

