Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477906;
	b=dPK+SU6ZUtiIn26GSEpWxNLTY7+wWy8/8lrDHGj7SzYcp1ViJV40h6273HpHSULnM+kP
	 ZWsout2SA4Nys3akSyfJvTxuckwo+VFxZrirP8DYAcWyCZi7jzJHTz5o+RxFENeThN0kv
	 teBJC7L4UN6XqPnuCWgquUwdxWU9PeKg/CtMn3xA8N1SY5N9HnHXgfRKn1EnPxe24axQ5
	 REgNKwVFXbOG1vlrKFBsAwH9zv4PLH2nSeanp1JAjrldNulLWKhZKnbVOMjtjJYmytD0L
	 eZXEvA3wNjiqUZ5dytphF44tkjpRVOXdjLIruJSILjqA/4ArFNpk8JRdM2Clq6c+eDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
	b=yqia0B0/Khwj8LOhYKB/xQI5zdOx8+gNOn0gKYEEKxLOKbPGNdTGO24YV9SFMxSt+PPx
	 g4L5lmEGSDhiW8gX1QFmgePSvrN2P0ikrqssos3LVndF60q1le6Y/+7p7Vm72+k8PXNwq
	 suArV9tIpOi35+brIahhi0evovnlFbliWGjfR8PSAHvBNFeg4XjqN9CAsqAhvTY6PMk2r
	 LXt7kWNq6eY+dvK02O2JfdDbKbAHBdZEQC2KL90/4esqo5BWMuDGIOTHcy6K9stYb3FsJ
	 EnyleLrz6ynmR3RiS+CGBz7imAPQ7n5y0uFrTXjVE2ZKTaLtpe9FaGGnUFLZpe3tUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rbr4MBPx;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE8606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 20:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rbr4MBPx
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b55859245so27665646d6.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477904; x=1794082704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
        b=rbr4MBPxngkpyiwGZJX6PN/PpZGMkU9qxgaA89cikLMLolO+tzAGd3gNGPqkgDhjjf
         24LLjBlARVJHE2yWYzhpDVqXRAtSE17vJNiFztL8cn2RsBm9Z0J8SfhikzDR/bBWOOlS
         xfj9w8qbXnzAXeN1J78n4V3At6C1FDNeUWSHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477904; x=1794082704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjXANh4Je1ohhs7b/aSS5ds02n5wjkCqy6R0VDrXfC0=;
        b=kE0gn7V3d4IlhGNFX3vmK+EtGDGB4aE2m9swVO3N4a3bMhknB5rHRiHb0x3mblkVNL
         sbVWMTZsSlf8xzPdfHH+cNtnfGgcr+sebz0tgDiTKFo1hY8naMW1VYTHyRDQCJl+IObd
         eRAReWgyn6rnVJF1/ZFEEZ6Bddbi5hBtVI7HBsZvTmjhpXJD6R3UEjdqi59Pl/3lChed
         6M9suqSwcSSgeRcUxhScxY7HZ+9bz172dCUDvpN4UUTBvPxzrl+ooDzWvhOTV/K157Cp
         z3sw4O5MlSvJhU2yVi1gUSC1XWeV6sSZfIt985Ehl78iXyKjwzh/SzVTKr3S3NVDhw2a
         YzoQ==
X-Gm-Message-State: AFq9FYKpGYJ3Kp/XrN8SuXPqyjPS+1VQYJtbJwgolYNOH4ga036sDSIn
	pJL7EZWiuOEJHLqZzokgYflmBBF6PyLgCMnd1Kg9ILThoigBZkJ0toMwuERzYEsedoY4VAihyn1
	EjKs=
X-Gm-Gg: AYBFou2RzU6xwFRYD3ETC/vdu1boVg4biPVIFci5xJkEHdXYFpFniNJbiwvyotYlQkY
	1SjU+/LjEOjLRrGL/VnZ38sKI0v5cvlIsf0hUkluPzCqEws15n8/Jyr9FP/DL2CnM2SoVke8nk3
	r5/mVEaoWi9NSxDnpNj+KbF9zvZwCm4dZ/DXnR6v//eceeiIuvnRXvT2IjgQkAhRqFxaLNb+aqm
	+Y1TsyE2ke5b6d8UIwYt3ELKgGPtmNcS49mQNoaZxljXLeNyJDpAOAj4lPX39OTVWTZxbROY/FK
	XfbXGJ3hQFd9IRVjAHnImOl3Njz610EltQSOkxcObyCP4qM82gja5GcYaYj9zQhycejk+MI22s4
	mo9pOlTeuW2AyeL4b2Tj3+/JaXvqlz7reuo4624vgHTpIC2HF7lG4JbAeoDSeW0m0qCspkE4bm7
	NXQQQXboEUjSV32yA1FmvxFoCGlKxcFql7obMBbyQvILpYh5hcZQXgM2mG5wWd2/iXZhLgKUtoZ
	KqdEzIUCjwzR/kPUyAAYHwZ4Gwtk2QfLnZFAU241oxajBW4I1jxv7JEI1mz7TZekX+jJXD5elIJ
	F/5KW2ueTjoYdCL/8iDp3d9T9sQFSBEWeOG7VPNfMI3qW8pFafH/qb0DBrWGv0BVGXiIEe1vsQW
	1yy6O7a7W9Chfjgs=
X-Received: by 2002:ad4:5cc5:0:b0:91c:524:465d with SMTP id 6a1803df08f44-91ca4b33165mr97889176d6.9.1793477903732;
        Sat, 31 Oct 2026 13:18:23 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 0/3 repost2] net/sched: fix short-skb metadata and namespace boundaries
Date: Sat, 31 Oct 2026 16:18:17 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three independent boundary problems in net/sched.

1/3 act_ife: encode a configured zero metadata value.  ife_check_meta_u32()
reserves an 8-byte TLV for a configured zero value, but the encoder
returned without writing it, leaking stale skb headroom bytes.

2/3 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/3 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

Origins:

1/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/3: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The three patches are independent.  They target net and carry a stable
nomination.  They are sent together because they share the short-skb and
namespace-boundary review context.

Jamal Hadi Salim (3):
  net/sched: act_ife: encode a configured zero metadata value
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace

 net/sched/act_ife.c  | 13 +++++++------
 net/sched/sch_teql.c |  9 +++++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

repost2: the repost1 posting is withdrawn.  3/3 carried hunk context for
teql_qdisc_init() from before 8b2043279dae ("sch_teql: fix slaves_lock
IRQ deadlock"), so it did not apply to the current tree.  This posting is
rebased onto the current net tip; 1/3 and 2/3 are unchanged, and 3/3
takes the new lock context and is otherwise the same fix.

The series is now built and tested against the current net tip.
