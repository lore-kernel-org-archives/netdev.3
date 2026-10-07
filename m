Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BC47DF8F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368992; cv=none; b=bPxs25q+VjZUFrp7iEIetCGNXUzzdPgBq+kNqNsRSihEWwAsxywzLrLfLZxExE1K5Zadq9y2jqwMhLB8SDsh7721UWNll9/ATRc81zzfXejsuIFngcJVOQ+rJ7A8KA14va9C09MjFAxqDlp+tEjw+umLeRVDgj+YpzLt7wYE9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368992; c=relaxed/simple;
	bh=7EnUNesC9aRqUrYEwr+EoJL++5bOslo4YJW4w4OYggE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ulw9qFoiW9lX0VmbDoMhlLnMcNIyUl9qOk+9l8VuqEK1XbktaSwHVxjAu+rIZoqnBUfW9LDpz/DkAgs6l2muerQgBsZHo94Dm5/clsFPYS3K5BReK0RNdwZ9En/2aQLTAQQZBMLkcSR+uOMLRpcdyocEDjeWXLdmk/gnxrAWd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=O9xYhvlo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="O9xYhvlo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5351748222cso30211901cf.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791368979; x=1791973779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKcmU4ZacZXdXUTN4jI2HamJkFmxBABSKshbBHASIgU=;
        b=O9xYhvloiIGlNWfG7iWOpijc6m3AaxvUV+T9YRI2zxpY1oHZDnLk6z3ubXG45AI/OZ
         gUA5cYr2j4dnPfczwxBI8hmwdv9HYVkZB7Ib5ykvDPP99D55Iojc2jyOQbVf9X+IwspA
         7Kzsqers5lChoNOZ1et/iR7jfgHTl6bQomSEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791368979; x=1791973779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKcmU4ZacZXdXUTN4jI2HamJkFmxBABSKshbBHASIgU=;
        b=dlQOXYVEfw9yepgwdo+MuR+xbd32fPo2fzZbyXfx8aBzzog7KjJJ8uaqxl8wl0ZnVx
         HxzWIaV1tSa9cm0h0WMrNOaFVbZpvVtOiw2eCsv/XKL7ACE1PmRqji4n+k0ID/0yLRLc
         urzu7PaPr1K4qBPSdtu3ZaotVrComuLcOahI54/FUt+NVi72XZzOV7D8FHHdwvwJr3l/
         8orKBn/0CUIFGJSxmq1tAjz9D1+NeP0MmAgzyojkihLaN4kzv4e9rFVHtwj9CoeO/9aS
         1g1yGbF8zI6qyffOonQ3pIs+1x0nM0Nbbc3Ks30WiDQgc2HmikI5McqASXh34gwDeIkc
         osCA==
X-Gm-Message-State: AFuF++kdWNaecITbTbcSK1C/gUIgM8Dq0waVn+tFAXOP3GjEkopLfTN6
	HhY6sf5hipfc3LZXC9n+k6/ABuURQ77pUpOhlXImFtsRDXyKX721M3eIH4v9CvmA8VaI7TPLbs3
	O4Vk=
X-Gm-Gg: AYBFou33Xzfo4eW1RrLAZjWK9VHlThWdTDr6UQ1it0gOruKjiGnx4ZPgiM5l/tZ3qZK
	ci6jCh1w/MXo0LoqZgyb0Z8fhm5BLHLVkJilZToAGQc8Jwrx4emI9um1jHtQqxrcTDj8M6e0UXa
	VxhfJ0kELYpl6XuBlid9aYp6Ql2Sa+zXgO87noMcWkkbp0I5skbfoT6TVEl79rsD4B0ZpbiXZEM
	vZOP7mdmo8uaNwzqjj8DprUE5RFi8H1YM26IQHRn4JIIlkhsFndkkSxavz86H9OCVessXN2BPCK
	elNFCB9eMU1N0Y4vQeIrMWBpRkrY9Xvai5XF0dq2svudsvT5BXqb1mOY587JB3nXa02n4MZDwHq
	p5ohozOf1qm8jyXbDzlG7GXJeL279QvBGPatr2lfc0mtXhri3YleA1JEmlU/floZIMLp2cJ12r5
	x3O9uOUMMsPDwLgnqm+MtXcrPq+L1I/O7lFe4krdNx4NPePmwp1DCe7Mkp7qy5LCGat8mDhfNNW
	MOWbheTQ5oujZ2oUgh5xlQZwlZomBXpS6OSaBhRIgeMFypaOCzqVrCWtyFS
X-Received: by 2002:ac8:5986:0:b0:535:70b4:9d8d with SMTP id d75a77b69052e-535755e8cefmr26297081cf.63.1791368979171;
        Wed, 07 Oct 2026 03:29:39 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357209e26csm16986311cf.8.2026.10.07.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:29:38 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paul Moses <p@1g4.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Davide Caratti <dcaratti@redhat.com>,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 2/2] net/sched: act_gate: cap the number of scheduling entries
Date: Wed,  7 Oct 2026 06:29:31 -0400
Message-Id: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
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
"tc actions ls"
2. Lack of capping has been demonstrated to be exploitable to
create an OOM through amplification of RTM_GETACTION replies.

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
of entries is a bogus choice; 65 entries is the boundary configuration
verified during this work.

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

Note, Note: This represents challenges primarily with netlink.

The Cap:
Cap the list at 1024 entries. This value is based on the existing
SJA1105 schedule-table capacity and preserves the verified 65-entry
configuration while providing a substantial headroom, and keeps the
complete gate list inside the current 16-bit TLV format. It
deliberately declines to expose SJA1110's 1025-4096 range through
an interface that cannot serialize it, and deliberately rejects
software-only schedules above 1024.

This is an operational cap on a configuration the uAPI accepted before,
so it is net-next hardening; if we made this a stable backport then
it would start rejecting gate configurations that install today (even
though those settings would be totally bogus).

Caveat Emptor:
While this patch fixes the binding of per-action storage and the dump
amplification; it does not by itself fix tcf_dump_walker() truncation
whose skb is smaller than the reply for such an action (for example the
kernel clamps a dump skb via netlink_recvmsg()/netlink_dump() to
SKB_WITH_OVERHEAD(32768), so "tc actions ls" is already truncated below
the 1024 this cap admits, and you cannot dump the top of the range
without changing iproute2 code)
It also does not remove generic netlink receive-queue amplification.
A companion iproute2 change can enumerate actions with a terse dump and
then fetch each one with an indexed RTM_GETACTION.

Conditions to recreate the bug:
Cap net admin with CONFIG_NET_ACT_GATE=y. Install a gate
action with 1025 or more minimal TCA_GATE_ONE_ENTRY elements over a raw
netlink RTM_NEWACTION request. The cap rejects the list with -E2BIG and
an extack naming the limit; 1024 entries install and an indexed
RTM_GETACTION returns a well-formed reply.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_gate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 14801c604bd9..d8e8c2356bd5 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -18,6 +18,17 @@
 
 static struct tc_action_ops act_gate_ops;
 
+/* A netlink attribute records its total length, including the 4-byte
+ * header, in a u16 nla_len, so one nested attribute can describe at most
+ * 65532 bytes. tcf_gate_dump() emits each schedule entry as 36 bytes, or
+ * 40 with the gate-open flag, so 1024 entries serialize to 36868-40964
+ * bytes and still fit a single TCA_GATE_ENTRY_LIST nest, while 4096 would
+ * need ~144-160 KiB and cannot be represented. 1024 is also the schedule
+ * table capacity of SJA1105 (SJA1110 provides 4096). Cap the entry list
+ * at 1024.
+ */
+#define GATE_ENTRIES_MAX	1024
+
 static ktime_t gate_get_time(struct tcf_gate *gact)
 {
 	ktime_t mono = ktime_get();
@@ -277,6 +288,14 @@ static int parse_gate_list(struct nlattr *list_attr,
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

