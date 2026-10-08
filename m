Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35E493D55
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455736; cv=none; b=jyXe8NqAeW14VKBcAj/j4lEy6n4hlH29uWdmZ9FL/0WOG4MmnFRv3rW6DvCuFfWNomlzDg07XKIM4B70fN1rhcNFHxTo22/0eSjzCJFYZthp0BvzsD7Xj18Fsn+0hdktFhuzWBJrSAqH2br2OoPuSeEQUl5sbRtRwBDorCQY2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455736; c=relaxed/simple;
	bh=bmGdstZsiUz+QfeJDZHgi4CCN6F/UOQwhg0U7UXmOrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXst2dWxL8aGKPRBGlgNHlc3olcWCJmNKxoAslA4XZZZBgcQAmfaIdfPXF491V0s4Ii7yJmmVXcX9m31Dbup5EBi2JAUAkAPBe3jVWJUtd3Eu4/J4wb0QLrZblvCEK82JY2ZsgogDrlCek/WLffw2cswrG1+zmZUMO+YC+K72oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, cake@lists.bufferbloat.net
Subject: Re: [PATCH net-next 4/4] net/sched/sch_cake: drop dead
 nla_nest_end() error check
In-Reply-To: <QDISC-5RTM.v1.20261007130704-5@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
 <QDISC-5RTM.v1.20261007130704-5@mojatatu.com>
Date: Thu, 08 Oct 2026 12:24:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v77csd5q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> cake_dump_class_stats() closes the TCA_STATS_APP nest with
>
> 	if (nla_nest_end(d->skb, stats) < 0)
> 		return -1;
>
> nla_nest_end() never returns a negative value: it has a single
> `return skb->len;` and no error path (that is why the overflow-aware
> nla_nest_end_safe() helper was later added). The '< 0' test can never
> be true, so the 'return -1' is unreachable dead code.
>
> Drop the check and close the nest with the bare statement, matching the
> sibling cake nests in the same file.
>
> This issue was discovered while fixing a bug on the gate action, see:
> https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
>
> Conditions to recreate the bug:
> - not runtime observable: the issue is found by inspection.
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
