Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82D42AF9B
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716278; cv=none; b=mW5yZsafuizfy5cdj/zplLOPeFf5VGcTRMy32J1E09yrg96YkOLAthb3+UUQ74gmVv2Me78MjziZi83U5VcYzTzzw9c0dkXAOkQAx+vF04xXuOBDSmSRDapsvPBlyxT3L+GIEZgI3xXMEpjZwdCpHM5QwUSX4ErdwLj8TpwqFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716278; c=relaxed/simple;
	bh=OHC4i8iIvUryqdAQkvQGjMqEnKPxbkv1oQimsw343ro=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0+DyQekuRbWKf0PgM5wAIDLrswSCr1ORLOx7RsOttU/aFsw0GtQg6F8mKq/ikrnwBy1qolB6McyWZOht9LzvotDQAm3WXMgS8d+tZ9ueb2+U5kulQT2GG+dXaF5s5BIsRamLQrzepxtu0U0XzIjo0yYe62stWEighs1f+lMmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSQhetdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSQhetdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13061F0089C;
	Sun, 11 Oct 2026 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791716276;
	bh=zHj3vYduDcwipEKvmk8VdX0qQ2h4zS7ivust/TDlDZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SSQhetdMqGeIq29JwQ1GjJgFSqMV2bnvIJw+nPmZjc0YvgFCGciTFL3WZL0HbJV/o
	 AvrtE1AuT2prz5m8eDsB6VfIs+HRe76z5GGZKqHYiBUXi5MJduR0HJ8owjvpRczrPm
	 Noc94xBM45pxFKd9QHvFAPwfnvvhtvhAlzsDvIH9UeLshBBiwLvAVNT5ry3joAm1eR
	 4oYrUZyD3P7V6eeJ5WrOHPBY9H9kvhH27WtGuQnhF3ozJimbAjXWYE/LuD3ue0oZN4
	 nKWlPrC2AuG1+SScSFy6pgCS0RNpOCCr4VL3XYtFNRoer2Z48eUhrDHVUZmHsULlW0
	 ib00iAHqNWRSg==
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of
 scheduling entries
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, olteanv@gmail.com, vladimir.oltean@nxp.com, p@1g4.org,
 eadavis@qq.com, dcaratti@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org, sashiko-bot@kernel.org
Date: Sun, 11 Oct 2026 10:57:55 +0000
Message-ID: <179171627521.434549.2707902365679392275@kernel.org>
In-Reply-To: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With the 1024-entry cap, a single unprivileged RTM_GETACTION
  request can still make the kernel allocate about 1.3 MB of reply…
- [Medium] GATE_ENTRIES_MAX = 1024 still allows a single gate whose dump
  cannot fit in any netlink dump skb, so the silent 'tc actions ls'…
- [Low] The commit message calls the unbounded gate list 'bugs' and says
  it was 'demonstrated to be exploitable to create an OOM', but there is…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but batched
  action requests can carry several capped gates whose combined size…
- [Medium] This problem wasn't introduced by this patch, but the sja1105
  driver never checks the total number of hardware Schedule table…

--

net/sched: act_gate: cap the number of scheduling entries

This patch limits parse_gate_list() to 1024 TCA_GATE_ONE_ENTRY elements.
Longer lists are rejected with -E2BIG and an extack message. The value was
picked so that a fully dumped entry list still fits in one u16-length
TCA_GATE_ENTRY_LIST nest, and it matches the SJA1105 schedule table size.

> The bugs:
> 1. A single gate can make tcf_dump_walker() silently truncate
> "tc actions ls"
> 2. Lack of capping has been demonstrated to be exploitable to
> create an OOM through amplification of RTM_GETACTION replies.

[Severity: Low]
The commit message calls these bugs, but there is no Fixes: tag for the
commit that added act_gate:

a51c328df310 ("net: qos: introduce a gate control flow action")

Documentation/process/maintainer-netdev.rst says "for fixes the Fixes: tag
is required, regardless of the tree".

The commit message also says this is net-next hardening and should not be
backported, so leaving the tag out looks intentional.

Would a Fixes: tag together with "Cc: <stable+noautosel@kernel.org>" record
where the problem came from without triggering an automatic backport?

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 14801c604bd9..d8e8c2356bd5 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -18,6 +18,17 @@
>  
>  static struct tc_action_ops act_gate_ops;
>  
> +/* A netlink attribute records its total length, including the 4-byte
> + * header, in a u16 nla_len, so one nested attribute can describe at most
> + * 65532 bytes. tcf_gate_dump() emits each schedule entry as 36 bytes, or
> + * 40 with the gate-open flag, so 1024 entries serialize to 36868-40964
> + * bytes and still fit a single TCA_GATE_ENTRY_LIST nest, while 4096 would
> + * need ~144-160 KiB and cannot be represented. 1024 is also the schedule
> + * table capacity of SJA1105 (SJA1110 provides 4096). Cap the entry list
> + * at 1024.
> + */
> +#define GATE_ENTRIES_MAX	1024

[Severity: Medium]
This sizes the cap against the u16 nla_len of the nest. Should it also be
sized against the largest dump skb?

netlink_recvmsg() limits the dump buffer size:

net/netlink/af_netlink.c:netlink_recvmsg() {
    ...
	max_recvmsg_len = min_t(size_t, max_recvmsg_len,
				SKB_WITH_OVERHEAD(32768));
    ...
}

For RTM_GETACTION dumps, netlink_dump() allocates at most about 32.4 KB.
dumping_entry() emits 36 or 40 bytes per entry. A gate with more than about
810-900 entries therefore cannot be dumped, and the new cap still accepts
it.

When this happens, tcf_dump_walker() trims the action and returns without
an error:

net/sched/act_api.c:tcf_dump_walker() {
    ...
		if (err < 0) {
			index--;
			nlmsg_trim(skb, nest);
			goto done;
		}
    ...
}

If the gate is the first action in the skb, n_i is 0. tc_dump_action()
then returns a skb->len of 0, and netlink_dump() sends NLMSG_DONE with
success. If earlier actions fit, the next callback restarts at the gate's
index and ends the same way.

The result is that the gate and every later action in the IDR are missing
from "tc actions ls", and userspace gets no error.

The commit message lists this truncation first under "The bugs:". The
Caveat Emptor section then says the cap does not prevent it.

Should the cap be small enough that a single gate fits in a dump skb? If
not, should the commit message stop listing this truncation as something
the cap fixes?

[Severity: Medium]
This isn't a bug introduced by this patch, but the cap is based on the
SJA1105 schedule table size. Does the sja1105 driver check the total number
of Schedule table entries against the device capacity anywhere?

The cap only limits a single action. sja1105_vl_gate() copies num_entries
with no limit:

drivers/net/dsa/sja1105/sja1105_vl.c:sja1105_vl_gate() {
    ...
	rule->vl.num_entries = num_entries;
    ...
}

sja1105_init_scheduling() adds the taprio and gate entry counts together.
It then sets the table size without checking max_entry_count:

drivers/net/dsa/sja1105/sja1105_tas.c:sja1105_init_scheduling() {
    ...
	table->entry_count = num_entries;
    ...
}

sja1105_static_config_check_valid() does not reject an oversized Schedule
table either.

On SJA1105, the entry point address and subscheind[] fields are 10 bits
wide, so sja1105_packing() cannot encode schedule indices of 1024 or more.
A 1024-entry gate plus a taprio schedule or a second offloaded gate rule
would overflow the shared table.

The commit message already notes that these are shared total capacities
and that the driver has no entry cap check. Is a separate driver fix
planned?

[ ... ]

> @@ -277,6 +288,14 @@ static int parse_gate_list(struct nlattr *list_attr,
>  			continue;
>  		}
>  
> +		if (i >= GATE_ENTRIES_MAX) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "Too many schedule entries, at most %u are supported",
> +					   GATE_ENTRIES_MAX);
> +			err = -E2BIG;
> +			goto release_list;
> +		}
> +

[Severity: Medium]
This limits each gate to about 41 KB of fill size. Does it also limit the
size of an RTM_GETACTION reply? The commit message says:

  While this patch fixes the binding of per-action storage and the dump
  amplification

RTM_GETACTION skips the capability check in tc_ctl_action():

net/sched/act_api.c:tc_ctl_action() {
    ...
	if ((n->nlmsg_type != RTM_GETACTION) &&
	    !netlink_capable(skb, CAP_NET_ADMIN))
		return -EPERM;
    ...
}

tca_action_gd() accepts up to TCA_ACT_MAX_PRIO (32) TCA_ACT_TAB entries.
All of them can name the same gate index, because tcf_action_get_1() takes
another reference without checking for duplicates. For each entry it does:

	attr_size += tcf_action_fill_size(act);

tcf_gate_get_fill_size() budgets 40 bytes per entry. With one 1024-entry
gate in the netns, 32 copies add up to about 1.3 MB, and tcf_get_notify()
allocates that much:

	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);

Once the total is above U16_MAX, tca_get_fill() always fails here:

	if (nla_nest_end_safe(skb, nest) < 0)
		goto out_nlmsg_trim;

and the skb is freed.

This does not lead to OOM. The doit runs under rtnl, so these allocations
are serialized and freed immediately.

Still, an unprivileged request of a few hundred bytes can repeatedly force
an order-9 GFP_KERNEL allocation while rtnl is held, and the buffer is
always discarded.

Could tca_action_gd()/tcf_get_notify() reject an attr_size larger than a
u16 TCA_ACT_TAB nest can hold, before calling alloc_skb()?

[Severity: Medium]
This is a pre-existing issue, but one capped gate takes about 41 KB in a
dump. Two of them in one batched request therefore exceed the u16
TCA_ACT_TAB nest in tca_get_fill():

	if (nla_nest_end_safe(skb, nest) < 0)
		goto out_nlmsg_trim;

For RTM_NEWACTION, tcf_action_add() has already installed the actions by
the time tcf_add_notify() fails. The caller gets -EINVAL even though the
actions were installed:

	ret = tcf_add_notify(net, n, actions, portid, attr_size, extack);

For RTM_DELACTION, tcf_del_notify() returns before tcf_action_delete() is
called, so nothing is deleted:

		skb = tcf_del_notify_msg(net, n, actions, portid, attr_size,
					 extack);
		if (IS_ERR(skb))
			return PTR_ERR(skb);

A batched RTM_GETACTION fails too.

The add and delete failures only happen when rtnl_notify_needed() is true,
i.e. there is an RTNLGRP_TC listener or NLM_F_ECHO is set. Whether they
occur depends on whether something like tc monitor is running.

The previous patch in this series, "net/sched: act_gate: reject oversized
dumps instead of wrapping them", turned the earlier wrapped length into
these failures and left the add-side -EINVAL for later. It fixed the filter
delete path, but tcf_del_notify() still blocks action deletes.

Is a follow-up planned for the action delete path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.20261007062551%40mojatatu.com
