Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98403D093A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881689; cv=none; b=P/byLwq2LoNd1xxBqwdJ+qokGasmi3Qazw4DK2hyvOv88sgpC7SJCxRJGXu2RIMNThTDRXjCLb8lv1wRnxASWOuNIUpgnO14zb0p4mxj2bzfDXV651YjJe9L72yUHoSXb2EtQTO5RSNH25DJ7kw4ghQjZUCojMPRgOR7/wNfCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881689; c=relaxed/simple;
	bh=ogpzvCe8tdvQ3HxSzTBJIBToLYEonrwZ1kRRrSy3dl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkHce0OFW6/6hlBWPrSsyVQW0MpCRUc+MT2s7Mrh9iFJwXDrNFFeSc1t4UpGAjzwm4ySJFwByO6sCfXGmAsu6DTHfGM46+GVeJrhIs8R57qDAI+iEW8GPfRHIynF0mvXYKCcMROonvKZgbOHnaGYFQWWd2aEhz43kdC1lolAJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sfKLQLrY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sfKLQLrY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535d60d850cso14626941cf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881686; x=1792486486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PoYGMU9yvDO/DJ89LXFBA7t9dEnCI4azlkm4Ko70zug=;
        b=sfKLQLrYirFoeRfbFfOwF1X31LnOeuMdIXyqkR98lX/FNoRXc9MB8jEqIogrAlv562
         XsWqPwopKV5E78WI+xkKBUIy5SqafDABQ5CAA1Ps4vVpEcHLo2fnTTs5h/SNlOB8BIiV
         8rvEVUx9/U6IGLxluRq/9jzmGvETYPuyNtlIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881686; x=1792486486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PoYGMU9yvDO/DJ89LXFBA7t9dEnCI4azlkm4Ko70zug=;
        b=Iq9FMoqk45h8McFQ3+v+V9NJcz8NlFvDHrDbzNT08vZ45rMjM67bx9aq9RIB5+1iJA
         tLsL7dz4LYuyEE5OmV1VcCuYmc7TKZNalVvBdrCzQTtd7f8mmhgFQ/wKfiI/IOEvcc/Q
         YbXH4GqOjZyow8SWld580SEzUSW+HYkQlR+Pjf5u9uGMlH+T724Q8T39VlNuMNPbZWJ/
         0eSwICnq4rDn+HvHR/TMTNHIVSGPlsQPx3KTXwZWFJKqgY1pO5rLAwCamUNAJmnqDaxh
         z46GxKkmFp3uSAseBiv4n34JoJHbYe95OGCiGhQwlZ52t0+hCqUTG5NBPdrXLsxQwjIL
         lHwQ==
X-Gm-Message-State: AFq9FYLReeP+TZIx1iYWgHPP3GJYNZqoGTNZMUx8Wkl2RjtkYq0lCv0c
	I0XDfBNm8/Xj+QJLTrrjU23Uu5cRct72ZA8jsLK4uFid19DPa3zFbiDVngDlXkuOc2QNp2gLgaY
	wz3Q=
X-Gm-Gg: AYBFou15jDXqKa4zwWQtoJFPyQu5Q1A3ijn6/q71siYRcB1mjjOObFqDMpgOFs16qM5
	s9lYHfKwumSkVxnzD5bhI8F9mpJbE5heK+tl84T/Ap4t2qWeaTjcR7V1AID0CBP7CkAwCMlhFp1
	eqgcNeedg7UkvC/a4FkBYl/3iWaIdNLBYrYhlVwJVaemkszUJkryj+sthFvl5bsSV2qykSN/8ch
	n0Kj0Pp/NLVPoJ+eSVhPEwvN57n4nybYiZ7GyLkmMcrttnBAavXazMaB25gy+XYXQH9hstzuuhA
	wOPQyLle+tdkrFDCBnL+llwGCxU/lEtAnIMPCxKc9Af8Mna5XSTVh99xQtydv3vV7ykbuvXJGmw
	Ac+ElZmPGsM32NZYu3bJVRrem9RuqXIgNjMmugjrE6Ajnc2UAmGvazYIq5IoAxYesku+q33xSv9
	Ita1aQJBBT2WwhLhLEJv1s5HsDxkyCc/8g4Z3f8QiVhrejpxa4scNLQawFyS4B1WU2u1XVnreip
	9lAWD+8//f8Tgm6J7qtYQfq368S5ZlrbYzMGZaTpmDo
X-Received: by 2002:a05:622a:1a92:b0:535:17c4:62b3 with SMTP id d75a77b69052e-535a60e6400mr146827171cf.11.1791881686270;
        Tue, 13 Oct 2026 01:54:46 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:45 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paul Moses <p@1g4.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next v3 3/5] net/sched: act_gate: cap the number of scheduling entries
Date: Tue, 13 Oct 2026 04:54:29 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_gate_list() accepts _any number_ of TCA_GATE_ONE_ENTRY elements.
The only bound/cap is the enclosing nlattr u16 nla_len (~5460
minimal 12-byte entries). Each entry is a separate GFP_ATOMIC
allocation, and the dump of a large list grows one action's reply well
past NLMSG_GOODSIZE.

The bugs:
1. A single gate can make tcf_dump_walker() silently truncate
"tc actions ls" ("net/sched: act_api: report an oversized action dump
instead of silently truncating it" makes such an action report -EMSGSIZE
instead of dropping the rest of the list).
2. Lack of capping pins memory for as long as the action lives: the
largest representable minimal list is roughly 5460 entries, each a
separate GFP_ATOMIC allocation, with a per-entry offload array on top in
full offload. The held-reply RTM_GETACTION amplification demonstrated in
the original posting of this series (Link below) is a generic netlink
property this cap does not remove; the bound added here is the install-side
pin.

So we need to provide an upper bound cap of TCA_GATE_ONE_ENTRY elements.

Some context:
The gate action offloads through FLOW_ACTION_GATE. The offload
interface passes the priority, base time, cycle time, cycle-time
extension, the complete entry count and an array holding each entry's
gate state, interval, IPV and maximum-octet value. The in-tree SJA1105
DSA driver forwards that complete list to sja1105_vl_gate() without any
entry cap check, and composes every supplied entry into the hardware
schedule table.

Act gate challenges:
SJA1105 and SJA1110 are two device families in the one sja1105 driver.
They expose different schedule-table capacities: SJA1105 provides up to
1024 schedule entries and SJA1110 up to 4096. These are total table
capacities shared with other schedules, so they are upper bounds, not a
guaranteed per-action budget. Software gate actions with _a lot more_
entries install and serialize today, so a low cap would reject working
configurations and would look like a UAPI breakage; but an infinite size
of entries is a bogus choice; a 65-entry configuration was verified
during this work to install and dump well-formed.

Netlink Challenges:
Netlink attributes record their total size, including the four-byte
header, in a 16-bit nla_len, so a nested attribute can describe at most
65532 bytes. A minimal accepted input entry is 12 bytes, which puts the
max we can fit at roughly 5460 entries; a dumped entry occupies 36 bytes,
or 40 bytes when it carries the gate-open flag.
1024 entries therefore serialize to 36868-40964 bytes, which fits
inside one nested attribute, while a 4096-entry schedule would need
roughly 144-160 KiB which _cannot fit_ at the moment due to the 16bit
length.

Note: This represents challenges primarily with netlink.

The Cap:
Cap the list at 1024 entries. This value is based on the existing
SJA1105 schedule-table capacity and preserves the verified 65-entry
configuration while providing a substantial headroom, and keeps the
complete gate list inside the current 16-bit TLV format. It
deliberately declines to expose SJA1110's 1025-4096 range through
an interface that cannot serialize it, and deliberately rejects
software-only schedules above 1024.

Why 1024 despite the dump budget:
1024 is a SJA1105 schedule-table capacity, not a dump-budget value. The
kernel clamps a dump skb to SKB_WITH_OVERHEAD(32768), so only ~800-890
entries of this list fit "tc actions ls"; the top of the admitted band
therefore installs but is not listed. That is accepted deliberately:
a unicast RTM_GETACTION reply is pre-sized from the action's advertised
size (budgeted per entry since the parent fix), so "tc actions get"
enumerates the whole band, and "net/sched: act_api: report an oversized
action dump instead of silently truncating it" makes the list view fail
loudly with -EMSGSIZE and an extack rather than silently truncating. A
filter whose action list contains such a gate also stops "tc filter show"
for that chain with -EMSGSIZE (loud), through tc_dump_tfilter()'s
no-progress path.

This is an operational cap on a configuration the uAPI accepted before,
so it is net-next hardening; if we made this a stable backport then
it would start rejecting gate configurations that install today (even
though those settings would be totally bogus).

Conditions to recreate the bug:
CAP_NET_ADMIN with CONFIG_NET_ACT_GATE=y. Install a gate
action with 1025 or more minimal TCA_GATE_ONE_ENTRY elements over a raw
netlink RTM_NEWACTION request. The cap rejects the list with -E2BIG and
an extack naming the limit; 1024 entries install and an indexed
RTM_GETACTION returns a well-formed reply.

Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_gate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 14801c604bd9..711cf2443540 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -18,6 +18,13 @@
 
 static struct tc_action_ops act_gate_ops;
 
+/* A nested attribute's u16 nla_len caps it at 65532 bytes. tcf_gate_dump()
+ * emits each entry as 36 bytes (40 with the gate-open flag), so 4096 entries
+ * would need ~144-160 KiB and cannot be represented. 1024 matches the
+ * SJA1105 schedule-table capacity (SJA1110 provides 4096).
+ */
+#define GATE_ENTRIES_MAX	1024U
+
 static ktime_t gate_get_time(struct tcf_gate *gact)
 {
 	ktime_t mono = ktime_get();
@@ -277,6 +284,14 @@ static int parse_gate_list(struct nlattr *list_attr,
 			continue;
 		}
 
+		if (i >= GATE_ENTRIES_MAX) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Too many schedule entries, at most %u are supported",
+					   GATE_ENTRIES_MAX);
+			err = -E2BIG;
+			goto release_list;
+		}
+
 		entry = kzalloc_obj(*entry, GFP_ATOMIC);
 		if (!entry) {
 			NL_SET_ERR_MSG(extack, "Not enough memory for entry");
-- 
2.43.0

