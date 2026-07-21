Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25B3F8896;
	Tue, 21 Jul 2026 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616930; cv=none; b=kEb978EVtezXtD9L9JW69I/P9apDFHtJaC+FBlEVVIpkdgBXxtuItmJWofQAc0erHkLjwWTsSmvw8qVWUORo5iElBIroeAh1r7tXDDxA8b7J7miruqV6JhOmpp+DghErkn3JQWmiY2DybGmBx5IbB8MuSaMhdNlu6509zZeMPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616930; c=relaxed/simple;
	bh=FVg7IJymBwkNmSIMsOJBLrx2HJiDdOkYPbsqa0MNu00=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kmeIIrGzYXvEQ9iWkLzdDd+vXJquEUfHHtvm+rh4duPH7npnbFuccFnyzaOWPy3odd0+OoGA8+OoJpmrhmmFhAI9dlRa2LCON9zWWwEuZyxErBxmKM4vNVAaTvT0p+4MLgR+Hoi/YLmrzs6riJ1mwiiHdjDr4McmjJ+AG8oK7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
Date: Tue, 21 Jul 2026 08:55:23 +0200
From: =?ISO-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
To: =?ISO-8859-1?Q?Jonas_K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
CC: cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mike Pham <mikepham4321@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2=5D_net/sched=3A_sch=5Fcake=3A_s?=
 =?US-ASCII?Q?kip_clearing_unused_tins_during_rate_adjustment?=
In-Reply-To: <20260720-sch_cake-skip-clearing-tins-v2-1-e6a8b0275c73@tu-berlin.de>
References: <20260720-sch_cake-skip-clearing-tins-v2-1-e6a8b0275c73@tu-berlin.de>
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <D8203772-A5C3-480E-88E5-52098FA91AAB@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 July 2026 23=2E14=2E52 CEST, "Jonas K=C3=B6ppeler" <j=2Ekoeppeler@tu=
-berlin=2Ede> wrote:
>When cake_configure_rates() is called from the dequeue path with
>rate_adjust=3Dtrue, it only needs to update the rate parameters=2E The
>loop that clears the unused tins is both unnecessary and harmful in
>this path:
>
> - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
>   actively used by cake_dequeue(), corrupting the dequeue state=2E
> - iterating over the unused tins and their internal queues to purge
>   packets adds needless overhead to the hot path=2E
>
>Skip the entire loop when rate_adjust is set, as neither
>cake_clear_tin() nor the mtu_time update are needed when only the
>rate changes=2E
>
>The clearing loop runs on every rate adjustment from the dequeue path,
>clearing (max_tins - cur_tins) tins each time, so the cost grows the
>fewer tins the configured mode actually uses=2E Testing cake_mq over veth
>(8 rx/tx queues, 2 Gbit limit) with flent's [1] rrul and tcp_nup tests an=
d
>32 TCP upstreams shows a large drop in loaded latency and a throughput
>gain, restoring behaviour to pre-15c2715a5264 levels:
>
>  +------------+------+------+-------+-------+---------+
>  | kernel     | mode | test |  base |  load |    tput |
>  |            |      |      |  (ms) |  (ms) |  (Mbit) |
>  +------------+------+------+-------+-------+---------+
>  | net-next   | be   | rrul | 0=2E810 | 11=2E78 | 1469=2E67 |
>  | net-next   | be   | nup  | 0=2E637 | 85=2E71 | 1243=2E15 |
>  | net-next   | ds3  | rrul | 0=2E397 | 15=2E28 | 1770=2E06 |
>  | net-next   | ds3  | nup  | 0=2E351 | 15=2E98 | 1799=2E39 |
>  +------------+------+------+-------+-------+---------+
>  | patched    | be   | rrul | 0=2E092 |  0=2E56 | 1873=2E40 |
>  | patched    | be   | nup  | 0=2E109 |  1=2E82 | 1869=2E12 |
>  | patched    | ds3  | rrul | 0=2E097 |  0=2E98 | 1866=2E10 |
>  | patched    | ds3  | nup  | 0=2E101 |  0=2E51 | 1861=2E79 |
>  +------------+------+------+-------+-------+---------+
>
>The same trend holds on real hardware (IPQ8074A, 4 rx/tx queues,
>OpenWrt): in besteffort mode the tcp_nup loaded latency drops from
>~470 ms to ~4 ms=2E
>
>[1] https://flent=2Eorg
>
>Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustment =
for diffserv config")
>Signed-off-by: Jonas K=C3=B6ppeler <j=2Ekoeppeler@tu-berlin=2Ede>
>Tested-by: Mike Pham <mikepham4321@gmail=2Ecom>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke=2Edk>
