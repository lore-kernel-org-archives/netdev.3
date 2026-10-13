Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B562F7EE6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881691; cv=none; b=UDj4HS5z5+erO+G9lu7T0DVz+mwPQdvK1owG7rTmVWsMc7WhXm0di//nLlnXjG9XpkEF6vznuawvwoPYwA7GSALYACP8CcinFOIWI8hLAUeoDPi0iKulot1kZF1xxwEn5tH+jiQvB8tXhFSskVQadtJ22j5FBFqqpJXSqC3+Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881691; c=relaxed/simple;
	bh=BUQP99I6COQgxdNBY9SRuY5W6lqRFJ1ambxQaFQ6ylQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FG2OBZ/fACDhNHrRWGowjJ4XihWGMLPAGrSOlnYjdRcye7vMTUbF4nmZxiCxYjPExgHSAfAOMukhGANdBa/gf/qz0iYb5dsn5eNRLbsC4jxQ0SQrLCtZzjI4+22xnpz15cKGVNR3uu00EMZh2pHIPgOgFyMZSYHA+iyl4Ii6GMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mFyE8+02; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mFyE8+02"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535179e995bso35697681cf.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881688; x=1792486488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fogdjvQjRRbSys6oW3hujB8iji53XchTMd8D+4uZ66A=;
        b=mFyE8+02Vd/Fz3MYdYT/P5qUsqbcMHw4Bwc5sd0TRc15hKt8OCYkB5f+ldCv4z6q9l
         tgvPhr6MKU1gzlPxg0LUtev0WmcI0oBcOo+P8sljhrMv54qFEgQXyZTYz6cVd3lDjlVJ
         idmlhT8kB+u7xGCTMtfhACTaeVKFJtu6BTRKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881688; x=1792486488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fogdjvQjRRbSys6oW3hujB8iji53XchTMd8D+4uZ66A=;
        b=WdHPasuHN/82eiduu9vDfXMSgq1sV4DDVgPV4qJMNr7k0o84wsBD+pp1cj0ghNgmDF
         sghcWOfQioehlDNixoA043S/HPHAqjeLbeuhAJg8wGw8LdO+VyKkAIpBSWButi7T7nAp
         T5QSHWg+6xsdEZoqMvgrRAKzZxhlzsVjP5R5TZbhf/JVBASyL0W6NCTAkCs/aZSFCtMT
         B5z7THyPDauxTt3B8qHzxBwlmvw3zlJC+P0R58sBp8xE8jacG5Miwf9Ho5mfMmIljD4f
         2eOiGRtwLoU+Uguq77I4v6XOYiOBwlahFpSJGbIIIqSUGxRzltFh7e97jkK7aFb3Cdda
         oMjg==
X-Gm-Message-State: AFq9FYKt/9XIBbjA0fwvHpINpvih4MAWmRFOkfJ1LozNUbQh3zLyi0O2
	WzxObSlQLqwmST5EztuVsyMZY+q5olUtU31zbePpLUkLyH7VRRK1UNCBnz60y5Lb4tzCmcgQZLn
	0zpo=
X-Gm-Gg: AYBFou0x1exgywUWglm5OUBO0R3lQfi1u86XI16yDZ6JX+NeXFoulMye2YVi+KW3gVv
	AKaVP0eU2NP4nRMsT1MyBtZxkSUj4KWAAWMqeWPw7TkoiOanu6JqwugXvRAr6epPlSZw6pkjN+6
	upuJqgP73z1DpmJR+EQvwIHRG4joKysyYoYHLICmXnaS+YFRbULXOajFHX1ql0ZPnXp/hYVI+V2
	qh6kQkwKl/uU+iz161elNt0u8B6CcQ1cMV/0lq6lvNXp5sFdRNMTr3Bn34NW+aB94JSNK+F/OqS
	CWIBwSc2HLWQPqgkYKNKgM0Wh43gjhwfk7byHPZ3nem9basypiKDcmA6ABQH5E5kUfU4QyfKmzH
	VxTaIjMCAIHZ6d8lYfXr9hVlkhq9edvfMqt589oLIAnMcq+LzCLAbjaZh50jfyVZ8KJch9YxHeh
	SJ/+/Nknk/44l55aLTvq93EIzaIhDhw430gtOURngCl5bhJ2iLZ8TotcEFLdu7hH8gCAAHYIsKG
	NWqro2vU4k0hhEqTg7Xpsy+QvBmkCA1oODLuVJ2BYWz
X-Received: by 2002:a05:622a:1e0a:b0:533:3228:74ad with SMTP id d75a77b69052e-5359fae5d3amr194005271cf.34.1791881687829;
        Tue, 13 Oct 2026 01:54:47 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:47 -0700 (PDT)
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
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH net-next v3 4/5] net/sched: sch_taprio: cap the number of schedule entries
Date: Tue, 13 Oct 2026 04:54:30 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813-4@mojatatu.com>
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

parse_sched_list() accepts _any number_ of TCA_TAPRIO_SCHED_ENTRY
elements. The only bound is the enclosing nlattr u16 nla_len. A minimal
accepted entry is 12 bytes (the entry nest plus
TCA_TAPRIO_SCHED_ENTRY_INTERVAL), so that u16 admits roughly 5460
entries - protocol-bounded amplification, not truly unbounded, but far
past any hardware schedule.

The bug:
Each entry is a separate sched_entry allocation (368 bytes, rounded up
to the kmalloc-512 bucket) and, in full offload, is also composed into a
per-entry offload array, so the largest representable minimal list pins
roughly 2.7 MiB for the lifetime of the schedule.

Some context:
The schedule list is not dumped the way the gate action list is: a
taprio dump is bounded by the carrying skb (the 32K dump skb, and
NLMSG_GOODSIZE for notify and unicast get), which keeps the plain
nla_nest_end() closes from ever seeing a wrapped length. But the
input-side amplification is the same class as the act_gate entry list,
and the offload interface composes every supplied entry into the
hardware schedule table without a capacity check.

The top of the accepted band cannot be read back: a schedule above
roughly 900 entries does not fit the 32K dump skb, so "tc qdisc show"
fails loudly with -EMSGSIZE for it (as the action-dump patch does). The
pre-existing silent gaps - no change notification above about 100
entries, and no unicast get reply - are tracked separately.

The Cap:
Cap the list at 1024 entries. This matches the SJA1105 schedule-table
capacity (SJA1110 provides 4096) and the act_gate entry cap, and keeps
the list inside the current 16-bit TLV format.

This is an operational cap on a configuration the uAPI accepted before,
so it is net-next hardening; a stable backport would start rejecting
taprio configurations that install today.

Conditions to recreate the bug:
CAP_NET_ADMIN with CONFIG_NET_SCH_TAPRIO=y. Install a taprio qdisc with
more than 1024 minimal TCA_TAPRIO_SCHED_ENTRY elements over a raw
netlink RTM_NEWQDISC request. The cap rejects the list with -E2BIG and
an extack naming the limit; 1024 entries install.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_taprio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39ac5b97aa3a..8e7fb6d0fc00 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -49,6 +49,13 @@ static struct static_key_false taprio_have_working_mqprio;
  */
 #define TAPRIO_PICOS_PER_BYTE_MIN 17
 
+/* Each entry is a separate 368-byte sched_entry and, in full offload, is
+ * also composed into a per-entry offload array. The u16 nla_len admits
+ * roughly 5460 minimal 12-byte entries, pinning ~2 MiB; 1024 matches the
+ * SJA1105 schedule-table capacity (SJA1110 provides 4096) and the act_gate cap.
+ */
+#define TAPRIO_ENTRIES_MAX	1024U
+
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
 	 * respective traffic class gate closes
@@ -1105,6 +1112,13 @@ static int parse_sched_list(struct taprio_sched *q, struct nlattr *list,
 			continue;
 		}
 
+		if (i >= TAPRIO_ENTRIES_MAX) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Too many schedule entries, at most %u are supported",
+					   TAPRIO_ENTRIES_MAX);
+			return -E2BIG;
+		}
+
 		entry = kzalloc_obj(*entry);
 		if (!entry) {
 			NL_SET_ERR_MSG(extack, "Not enough memory for entry");
-- 
2.43.0

