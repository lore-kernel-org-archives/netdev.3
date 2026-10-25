Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951565;
	b=L6Zm/KiS96lX+SYg/97d+ngPWU6+1cPwCct+6SbrpZz0zVUwdZkTI8OkuL5WkAc52rh0
	 5zBiOY95EUNJ4C/PlChtzL+YuhLYhIGbsgSi/zwaEBW2oPl+jBxHLD4M+h0ZjVYqIpV1Q
	 Yt8HSqqiMLco9zc4coI2cLDfVvRbCFUJy8ATs8EO/YgSoA0BeTawGtjCyqy9oLhu3BrXf
	 Lc0aoau51morHf+ab06o8T+LRNR5BQxYodpWumtR3f/LEbyatvYn0LMcLFNbWz9FaFMdW
	 eXVqk6KCBkuJ+O20qPP4d/oWdPYZzNK75+C69624a1H96i0hn0uNNbxUFFy7rRu5MbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951565;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R2yYVJDURVHL4Zlc8jvwqtXNq1Igf+EOAe737wS2Idw=;
	b=zd0eXjcwTw5k9aaaD7SXdEHDsQwUPVj0j6R3AKE9qysAVyyJi/GrGp5QFgCNSHyl0W8s
	 epSuvQFk0rrKSryJbmKoVlSkGDNyL5Yprstthu8LIHAHU3iHovZAV2upvZIbOewzgq7dU
	 92EupGBkM4Qc0svgKAg3ipbvxV5oWCaCR79sgLJggqeKJrgFlk+0LeqWoUTH5NRLtMAfM
	 W1ay+Za/6t6ywWJ6qRv2XWU5sToeoDr3BevpDGCD/zx+5hOXRemJ81umKxl9at0ymZ0xh
	 P07WkljzNhDqVSeXvb9s9bAc1pqvL5vmGWSDNCTi5c7oRswgTrKtQbEFvE/26sjI16Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfMtlRl9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C345606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfMtlRl9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFAA1F01825;
	Sun, 25 Oct 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951565;
	bh=R2yYVJDURVHL4Zlc8jvwqtXNq1Igf+EOAe737wS2Idw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gfMtlRl9w/0gFR8XgTeKTGAkeRoMvWyYM4Zqlef2x2OCgXA8d35w5G3A5mDn8np5K
	 ubD003C3nQ2jCwZK2q4L/AkN6NhbSzS2SO2u+E6pOBcw3ZUh01nSZwTFax+RMYshn/
	 R+N8xZsrFPZCnqskng0Ua2snyhyCYINnoV46I1+7ASDJR5sizJGTelN+DyoXPaBFwo
	 DhpViHW5J4el4VoAHPBbxfK2kk5b6crHVwzr0bty91TqRm0KcCXSNjekUUkQO/3c7v
	 iDvXLcVyUPsIOu6GJyetea/G75wkK2/0mdY42GmjIGUtE9yLYs+3kyOleC64GWbgMH
	 IgS2knFRgOdcQ==
Subject: Re: [PATCH net] net/sched: fq_codel: read flowchain under the qdisc
 lock in fq_codel_walk
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc:
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 18:06:04 +0000
Message-ID: <179295156423.3134.7093016539842568455@kernel.org>
In-Reply-To: <20261021155705.69457-1-phx0fer@gmail.com>
References: <20261021155705.69457-1-phx0fer@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] fq_codel_walk() (net/sched/sch_fq_codel.c:741-759) now takes
  sch_tree_lock()/sch_tree_unlock(), i.e. spin_lock_bh on the root qdisc…

--

net/sched: fq_codel: read flowchain under the qdisc lock in fq_codel_walk

This patch takes the qdisc root lock around the list_empty() check on each
flow's flowchain in fq_codel_walk(). The commit message gives the reason:
the RTM_GETTCLASS dump runs under rtnl_lock, while enqueue and dequeue
change the same list under the root qdisc lock.

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index e6c87a32950f9..789fdc6551a6a 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -739,7 +739,18 @@ static void fq_codel_walk(struct Qdisc *sch, struct qdisc_walker *arg)
>  		return;
>  
>  	for (i = 0; i < q->flows_cnt; i++) {
> -		if (list_empty(&q->flows[i].flowchain)) {
> +		bool empty;
> +
> +		/* flowchain is spliced by the datapath (fq_codel_enqueue/
> +		 * fq_codel_dequeue) under the qdisc root lock.  This walker
> +		 * runs under rtnl_lock, which does not exclude those writers,
> +		 * so read the membership under the same lock they use.
> +		 */
> +		sch_tree_lock(sch);
> +		empty = list_empty(&q->flows[i].flowchain);
> +		sch_tree_unlock(sch);

[Severity: High]
Could this slow down the transmit fast path for every packet on the
interface?

With this change, fq_codel_walk() does a spin_lock_bh() and unlock on the
root qdisc lock once for every flow index. That includes empty flows and
flows the dump is going to skip. flows_cnt defaults to 1024, and
fq_codel_change() allows up to 65536.

A multi-part dump also walks again from index 0 on each continuation.
tc_dump_tclass_qdisc() does this:

net/sched/sch_api.c:tc_dump_tclass_qdisc() {
    ...
	arg.w.skip = cb->args[1];
	arg.w.count = 0;
	q->ops->cl_ops->walk(q, &arg.w);
    ...
}

and the skip only happens inside tc_qdisc_stats_dump(), after the walker
has already taken and dropped the lock for that index:

include/net/pkt_sched.h:tc_qdisc_stats_dump() {
	if (arg->count >= arg->skip && arg->fn(sch, cl, arg) < 0) {
    ...
}

So each dump chunk locks every earlier flow again, which comes to roughly
flows_cnt times the number of chunks. fq_codel_enqueue() and
fq_codel_dequeue() take the same lock for every packet, so every one of
these acquisitions competes with them.

RTM_GETTCLASS is registered as a GET handler, so it does not need
CAP_NET_ADMIN. Any local user can send it in a loop, from many CPUs at
the same time:

rtnetlink_rcv_msg()->tc_dump_tclass()->tc_dump_tclass_root()->
    tc_dump_tclass_qdisc()->fq_codel_walk()

This seems to go against the earlier design. Commit edb09eb17ed8 ("net:
sched: do not acquire qdisc spinlock in qdisc/class stats dump") removed
root-lock use from the dump path. It noted that dumps "also slow down the
fast path (queue/dequeue packets) by 10 % to 20 % in some cases". Commit
f83e07b29246 ("net/sched: sch_fq_codel: annotate data-races from
fq_codel_dump_class_stats()") then annotated the lockless reads with
READ_ONCE()/WRITE_ONCE(). Since then, fq_codel_dump_class_stats() takes
the lock only when a flow has queued skbs:

net/sched/sch_fq_codel.c:fq_codel_dump_class_stats() {
    ...
		if (READ_ONCE(flow->head)) {
			sch_tree_lock(sch);
    ...
}

The lock also does not seem to make the result any more accurate. It is
dropped before empty is used, so the answer can be stale by the time the
loop acts on it, just as it could before.

The commit message says the race is benign ("a stale "empty" answer only
makes the dump skip a class"). Would annotating it be enough, along the
lines of f83e07b29246? For example, data_race(list_empty(...)) in
fq_codel_walk(), or WRITE_ONCE() on the writer side. That would avoid
adding locking to the dump path.

> +
> +		if (empty) {
>  			arg->count++;
>  			continue;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155705.69457-1-phx0fer%40gmail.com
