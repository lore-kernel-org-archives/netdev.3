Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F24AFE25
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383021; cv=none; b=Ncq5mkWTuqksNYWHU8lQx8cIaKhP5iRgectzRZyz5xYTB8V77+E42EzqVE9w0WndWUG9n9ymwMtluiZOHLvAmCM3mTTrqwiZHcgKxdkOs4iVq6dbG414F/rYSTu1uGbav838R0exL5lew74F8v2vR9580+s2NZ/qJKcjr67dKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383021; c=relaxed/simple;
	bh=oYXoLrdTkTd0h40+YUgpg1Qo8zbefCTY0JHGfDFS4c4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0ZTYOyrBzt/4mMfkvE3JU5Rl6SI+Gtu6G6U+uI+V2lEcmPAEZSZ+bmVC6+ex5eZH5228FKOaV2PnOF5ggenmnig4NpGqWNT/ayFn7kzXABJRDNSY3AFpjKK5STkd2ijaivgxO1zFo7F2lAr7HT4CR+bbGuGsc5qS1C3w0KgN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=WjI4GP59; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="WjI4GP59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791382996; x=1791642196;
	bh=d5FGahR9PvKzLDMtnQjDw7usLNYzSs3HujkuIcflyxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WjI4GP59dbx9vQkK1MmCqJsi1RriQGm6E1DGFgJFQ77G5Ka1X5iDLbwDPDtPuCfKy
	 PHa28N0C6RzN1NNqllen177E2/yRI8RaHjuC1Df9ngpHuTttjQMGcxVr6zBS75mSgL
	 O0jtnuLTB69F/W1bxyA2Yq9EQMFkNYpjOFJ0HismHagkE4tIrwhSATcZLOVNGKkbwz
	 t0beeDnKfmHjRVKiid3uftk+xmWjXTZ0UsvxT/7bt368A0FiYHi+YOSdi5ybWUs9cT
	 U4MBbL4xg8tA85mlKLFQQfQiFn8oaa6Su3z6LJ7zImMkJ/accAE/vlPRMqGNQzG6vu
	 3mNHKGECKGJSw==
Date: Wed, 07 Oct 2026 14:23:10 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Edward Adam Davis <eadavis@qq.com>, Davide Caratti <dcaratti@redhat.com>, dsahern@kernel.org, stephen@networkplumber.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of scheduling entries
Message-ID: <zR5nw2jDMQyPpLOwFEjqH163vEcob8SUKgVslSD8tVjZRwXoPHJlj-dC55-C5KVsAvHn5wh8GnilJVH1C7KedPw0dsy4oZlbOTew01T7qbo=@1g4.org>
In-Reply-To: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551@mojatatu.com> <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 04e3fa0abcb5dfb4a277103e21d547b96ee97c13
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 7th, 2026 at 5:29 AM, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:

> parse_gate_list() accepts _any number_ of TCA_GATE_ONE_ENTRY elements.
> The only bound/cap is the enclosing nlattr u16 nla_len (~5460
> minimal 12-byte entries). Each entry is a separate GFP_ATOMIC
> allocation, and the dump of a large list grows one action's reply well
> past NLMSG_GOODSIZE.
>=20
> The bugs:
> 1. A single gate can make tcf_dump_walker() silently truncate
> "tc actions ls"
> 2. Lack of capping has been demonstrated to be exploitable to
> create an OOM through amplification of RTM_GETACTION replies.
>=20
> So we need to provide an upper bound cap of TCA_GATE_ONE_ENTRY elements.
>=20
> Some context:
> The gate action offloads through FLOW_ACTION_GATE. The offload
> interface passes the priority, base time, cycle time, cycle-time
> extension, the complete entry count and an array holding each entry's
> gate state, interval, IPV and maximum-octet value. The in-tree SJA1105
> DSA driver forwards that complete list to sja1105_vl_gate() without any
> entry cap check, and composes every supplied entry into the hardware
> schedule table.
>=20
> Act gate challenges:
> SJA1105 and SJA1110 are two device families in the one sja1105 driver.
> They expose different schedule-table capacities: SJA1105 provides up to
> 1024 schedule entries and SJA1110 up to 4096. These are total table
> capacities shared with other schedules, so they are upper bounds, not a
> guaranteed per-action budget. Software gate actions with _a lot more_
> entries install and serialize today, so a low cap would reject working
> configurations and would look like a UAPI breakage; but an infinite size
> of entries is a bogus choice; 65 entries is the boundary configuration
> verified during this work.
>=20
> Netlink Challenges:
> Netlink attributes record their total size, including the four-byte
> header, in a 16-bit nla_len, so a nested attribute can describe at most
> 65532 bytes. A minimal accepted input entry is 12 bytes, which puts the
> max we can fit at roughly 5460 entries; a dumped entry occupies 36 bytes,
> or 40 bytes when it carries the gate-open flag.
> 1024 entries therefore serialize to 36868-40964 bytes, which fits
> inside one nested attribute, while a 4096-entry schedule would need
> roughly 144-160 KiB which _cannot fit_ at the moment due to the 16bit
> length.
>=20
> Note, Note: This represents challenges primarily with netlink.
>=20
> The Cap:
> Cap the list at 1024 entries. This value is based on the existing
> SJA1105 schedule-table capacity and preserves the verified 65-entry
> configuration while providing a substantial headroom, and keeps the
> complete gate list inside the current 16-bit TLV format. It
> deliberately declines to expose SJA1110's 1025-4096 range through
> an interface that cannot serialize it, and deliberately rejects
> software-only schedules above 1024.
>=20
> This is an operational cap on a configuration the uAPI accepted before,
> so it is net-next hardening; if we made this a stable backport then
> it would start rejecting gate configurations that install today (even
> though those settings would be totally bogus).
>=20
> Caveat Emptor:
> While this patch fixes the binding of per-action storage and the dump
> amplification; it does not by itself fix tcf_dump_walker() truncation
> whose skb is smaller than the reply for such an action (for example the
> kernel clamps a dump skb via netlink_recvmsg()/netlink_dump() to
> SKB_WITH_OVERHEAD(32768), so "tc actions ls" is already truncated below
> the 1024 this cap admits, and you cannot dump the top of the range
> without changing iproute2 code)
> It also does not remove generic netlink receive-queue amplification.
> A companion iproute2 change can enumerate actions with a terse dump and
> then fetch each one with an indexed RTM_GETACTION.
>=20
> Conditions to recreate the bug:
> Cap net admin with CONFIG_NET_ACT_GATE=3Dy. Install a gate
> action with 1025 or more minimal TCA_GATE_ONE_ENTRY elements over a raw
> netlink RTM_NEWACTION request. The cap rejects the list with -E2BIG and
> an extack naming the limit; 1024 entries install and an indexed
> RTM_GETACTION returns a well-formed reply.
>=20
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_gate.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 14801c604bd9..d8e8c2356bd5 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -18,6 +18,17 @@
>=20
>  static struct tc_action_ops act_gate_ops;
>=20
> +/* A netlink attribute records its total length, including the 4-byte
> + * header, in a u16 nla_len, so one nested attribute can describe at mos=
t
> + * 65532 bytes. tcf_gate_dump() emits each schedule entry as 36 bytes, o=
r
> + * 40 with the gate-open flag, so 1024 entries serialize to 36868-40964
> + * bytes and still fit a single TCA_GATE_ENTRY_LIST nest, while 4096 wou=
ld
> + * need ~144-160 KiB and cannot be represented. 1024 is also the schedul=
e
> + * table capacity of SJA1105 (SJA1110 provides 4096). Cap the entry list
> + * at 1024.
> + */
> +#define GATE_ENTRIES_MAX=091024
> +
>  static ktime_t gate_get_time(struct tcf_gate *gact)
>  {
>  =09ktime_t mono =3D ktime_get();
> @@ -277,6 +288,14 @@ static int parse_gate_list(struct nlattr *list_attr,
>  =09=09=09continue;
>  =09=09}
>=20
> +=09=09if (i >=3D GATE_ENTRIES_MAX) {
> +=09=09=09NL_SET_ERR_MSG_FMT(extack,
> +=09=09=09=09=09   "Too many schedule entries, at most %u are supported",
> +=09=09=09=09=09   GATE_ENTRIES_MAX);
> +=09=09=09err =3D -E2BIG;
> +=09=09=09goto release_list;
> +=09=09}
> +
>  =09=09entry =3D kzalloc_obj(*entry, GFP_ATOMIC);
>  =09=09if (!entry) {
>  =09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
> --
> 2.43.0
>=20
>=20

If I remember correctly, act_gate was/is not fully taking into account how =
much size it actually
needs for dumps. Has this been fixed or worked around already? Sorry, I'd b=
een meaning to swing=20
back to this. I'll try to get caught up today.

https://lore.kernel.org/stable/20260130134220.305757-1-p@1g4.org/

Thanks,
Paul
