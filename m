Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F233C9456;
	Mon, 20 Jul 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579416; cv=none; b=dOMeuV3X3jwxG18UxW5s9N8IReToGUTN9VFBTwBzvwcKkvpt2dIGEwSln+qc4Uk9yG6Gly2WJ1fA6o8g+57EjBWZG2miJKVY+6ES1uUk793pitHJjVbAEm3t6ZWNKomLbwJ3aoNXkzlEmyr/AVkdSlVMwPtvkWl6bGK6lxVefU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579416; c=relaxed/simple;
	bh=GztZ3fCvDXuZZdxV7YuaNRewopMNr9xqFVie0tqPaSk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hJGHyGfY2QM68x4XZ7jOXxqyPYkDQHwEi+AafkOEKrME1Onxr3qlIIVBNxfIWqmBn64UNsxSnslj/AN8pmOTb29IKgou3b75L346PrXv2jgfv5evx2ufb0PibxuoA17MqJbljDpyk4ADkCSokkQQRCxJEy9h1V+LDCOBj3DHVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
Date: Mon, 20 Jul 2026 22:30:09 +0200
From: =?ISO-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
To: =?ISO-8859-1?Q?Jonas_K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
CC: cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mike Pham <mikepham4321@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net/sched=3A_sch=5Fcake=3A_ski?=
 =?US-ASCII?Q?p_clearing_unused_tins_during_rate_adjustment?=
In-Reply-To: <431c1b00-1fd3-41e1-8e8e-9cc1738ae387@tu-berlin.de>
References: <20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de> <87wluuj9ue.fsf@toke.dk> <431c1b00-1fd3-41e1-8e8e-9cc1738ae387@tu-berlin.de>
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <2E1DC220-4CC0-4F46-A042-6B09535EC373@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18 July 2026 17=2E06=2E28 CEST, "Jonas K=C3=B6ppeler" <j=2Ekoeppeler@tu=
-berlin=2Ede> wrote:
>On 7/17/26 10:31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jonas K=C3=B6ppeler <j=2Ekoeppeler@tu-berlin=2Ede> writes:
>>=20
>>> When cake_configure_rates() is called from the dequeue path with
>>> rate_adjust=3Dtrue, it only needs to update the rate parameters=2E The
>>> loop that clears the unused tins is both unnecessary and harmful in
>>> this path:
>>>=20
>>>   - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
>>>     actively used by cake_dequeue(), corrupting the dequeue state=2E
>>>   - iterating over the unused tins and their internal queues to purge
>>>     packets adds needless overhead to the hot path=2E
>>>=20
>>> Skip the entire loop when rate_adjust is set, as neither
>>> cake_clear_tin() nor the mtu_time update are needed when only the
>>> rate changes=2E
>>>=20
>>> Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustme=
nt for diffserv config")
>>> Signed-off-by: Jonas K=C3=B6ppeler <j=2Ekoeppeler@tu-berlin=2Ede>
>>> Tested-by: Mike Pham <mikepham4321@gmail=2Ecom>
>>=20
>> Do you have any performance numbers to show the impact of this?
>Yes, the table below shows results from a test setup using vng with
>2 network namespaces, with cake/cake_mq attached in one of them:
>
>    ns1 -> cake/cake_mq -> ns2
>
>- veth devices are configured with 8 rx/tx queues=2E
>- cake/cake_mq is configured with a 2 Gbit rate limit=2E
>- Running flent's rrul and tcp_nup tests with 32 TCP upstreams:
>
>legend: qdisc mq =3D cake_mq; mode be =3D besteffort, ds3 =3D diffserv3
>        test nup =3D tcp_nup; base/load =3D idle/loaded RTT (ms); tput =
=3D Mbit/s
>
>+---------------------+-------+------+------+-------+-------+---------+
>| kernel              | qdisc | mode | test |  base |  load |    tput |
>+---------------------+-------+------+------+-------+-------+---------+
>| net-next            | cake  | be   | rrul | 0=2E075 |  4=2E76 | 1473=2E=
69 |
>| net-next            | cake  | be   | nup  | 0=2E078 |  6=2E23 | 1550=2E=
79 |
>| net-next            | cake  | ds3  | rrul | 0=2E063 |  5=2E81 | 1526=2E=
75 |
>| net-next            | cake  | ds3  | nup  | 0=2E046 |  6=2E09 | 1761=2E=
45 |
>+---------------------+-------+------+------+-------+-------+---------+
>| net-next            | mq    | be   | rrul | 0=2E810 | 11=2E78 | 1469=2E=
67 |
>| net-next            | mq    | be   | nup  | 0=2E637 | 85=2E71 | 1243=2E=
15 |
>| net-next            | mq    | ds3  | rrul | 0=2E397 | 15=2E28 | 1770=2E=
06 |
>| net-next            | mq    | ds3  | nup  | 0=2E351 | 15=2E98 | 1799=2E=
39 |
>+---------------------+-------+------+------+-------+-------+---------+
>| this patch          | mq    | be   | rrul | 0=2E092 |  0=2E56 | 1873=2E=
40 |
>| this patch          | mq    | be   | nup  | 0=2E109 |  1=2E82 | 1869=2E=
12 |
>| this patch          | mq    | ds3  | rrul | 0=2E097 |  0=2E98 | 1866=2E=
10 |
>| this patch          | mq    | ds3  | nup  | 0=2E101 |  0=2E51 | 1861=2E=
79 |
>+---------------------+-------+------+------+-------+-------+---------+
>| before 15c2715a5264 | mq    | be   | rrul | 0=2E073 |  0=2E30 | 1895=2E=
45 |
>| before 15c2715a5264 | mq    | be   | nup  | 0=2E076 |  0=2E49 | 1905=2E=
57 |
>| before 15c2715a5264 | mq    | ds3  | rrul | 0=2E069 |  0=2E31 | 1896=2E=
59 |
>| before 15c2715a5264 | mq    | ds3  | nup  | 0=2E058 |  0=2E86 | 1884=2E=
01 |
>+---------------------+-------+------+------+-------+-------+---------+
>
>Not only is p99 latency drastically reduced -- nearly matching
>pre-15c2715a5264 results -- but on current upstream cake_mq,
>throughput also increases as a cake mode uses more tins=2E This points
>directly to cake_clear_tin() during reconfig as the cause, since it
>clears (max_tins - cur_tins) tins each time=2E So the fewer tins the
>current mode uses, the more get cleared on every reconfig=2E
>
>Mike ran also some test on OpenWrt, on an IPQ8074A with 4 rx/tx
>queues, and saw similar trends=2E cake_mq is configured with a 2=2E2 Gbit
>rate limit=2E
>
>Unfortunately, we only have data for 128 TCP upstreams on net-next,
>and 64 TCP upstreams for 'this patch'=2E
>
>+---------------------+-------+------+------+---------+----------+
>| kernel              | qdisc | mode | test |    load |     tput |
>+---------------------+-------+------+------+---------+----------+
>| net-next            | mq    | be   | nup  |  468=2E50 |    50=2E90 |
>| net-next            | mq    | ds3  | nup  |  355=2E22 |    98=2E21 |
>| net-next            | mq    | ds4  | nup  |  268=2E28 |   255=2E84 |
>| net-next            | mq    | ds8  | nup  |    7=2E48 |  2023=2E66 |
>+---------------------+-------+------+------+---------+----------+
>| this patch          | mq    | be   | nup  |    4=2E24 |   944=2E35 |
>| this patch          | mq    | ds3  | nup  |    4=2E27 |   937=2E75 |
>| this patch          | mq    | ds4  | nup  |    4=2E24 |   936=2E97 |
>| this patch          | mq    | ds8  | nup  |    4=2E32 |   927=2E89 |
>+---------------------+-------+------+------+---------+----------+
>
>This again shows the same trend: throughput increases and latency
>drops as cake_mq is configured with more tins=2E We're still looking
>into why net-next+ds8 reaches close to 2 Gbit/s, while this patch
>tops out around 928 Mbit/s=2E
>
>That said, this patch doesn't solve every issue yet, but it does
>remove the regression introduced by commit 15c2715a5264
>("net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv
>config")=2E
>
>We're continuing to look into further improvements=2E Let us know if
>you'd like to see additional tests :)

Cool! Could you please respin the patch with this data in the commit messa=
ge?

Doesn't have to be all of it, but some indication of the benefit would be =
good to have on hand for future reference :)

-Toke
