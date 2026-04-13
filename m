Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0B3B389D
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073794; cv=none; b=Y82KjLXypvuSMAIW8xqSDsiHpN93I7QdxHdYQBE6lX8lniri1mTtp1ajPXHJQehh1QhAOd002lSvU3y4q5nP1OYoUUAt8a9FuQ/7vF0CrG5Qx/eOZpMMffeRbC/KSbCNHN2+KEUvc98G4UncUJ7m6wK1GQkTYCNzPCkEC5W2zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073794; c=relaxed/simple;
	bh=5nwOb9o1180MZoL7BFbgSSRdTtYeFhNtX+t2/tmdQ5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzjdfUuOKBKIkHmRMBjr56sRCBiCbgLfJZ3bvQ5zvqH+6WuQuh9uI/QlDjLEjL9fXq0VxglqSe5Vv9lO429WJYmVe+NUHkvyDzH5uqptLl9Oxbt97iQPWHYd+WRL1PPnUuvV4XF0j1Wp6pbK8l1UWxsEY0BPeliMTQeB0ZIJpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Dudu Lu <phx0fer@gmail.com>
Subject: Re: [PATCH] net/sched: sch_cake: fix NAT destination port not being
 updated in cake_update_flowkeys
In-Reply-To: <20260413084715.70169-1-phx0fer@gmail.com>
References: <20260413084715.70169-1-phx0fer@gmail.com>
Date: Mon, 13 Apr 2026 11:41:37 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874ilfdwoe.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dudu Lu <phx0fer@gmail.com> writes:

> cake_update_flowkeys() is supposed to update the flow dissector keys
> with the NAT-translated addresses and ports from conntrack, so that
> CAKE's per-flow fairness correctly identifies post-NAT flows as
> belonging to the same connection.
>
> For the source port, this works correctly:
>     keys->ports.src =3D port;  /* writes conntrack port into keys */
>
> But for the destination port, the assignment is reversed:
>     port =3D keys->ports.dst;  /* reads FROM keys into local var =E2=80=
=94 no-op */

Huh, what a silly mistake - nice find!

> This means the NAT destination port is never updated in the flow keys.
> As a result, when multiple connections are NATed to the same destination
> (same IP + same port), CAKE treats them as separate flows because the
> original (pre-NAT) destination ports differ. This completely defeats
> CAKE's NAT-aware flow isolation when using the "nat" mode.
>
> The vulnerability was introduced in commit b0c19ed6088a ("sch_cake: Take =
advantage
> of skb->hash where appropriate")

Calling it a "vulnerability" seems perhaps a tad hyperbolic. Care to
elaborate on what you mean here?

-Toke
