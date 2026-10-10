Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F82F8E85
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666182; cv=none; b=i4ggnHPWEtBwl/beYjygN+c3Ns6yHTIr63AXwaw0MlcRzxI7Z9tKaS3RRY0GR/Mr9if4qvwt7KvnOb7aH/+HmdTdlWb4fzrqu0ZVIgPDuDpbUlsn9D+ZzLHxiAOqRwEzMxcGse9cNt6RwpOYPijNk3N2ZE3Mj7iwXACJRxku3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666182; c=relaxed/simple;
	bh=wDwpMO5bfAe2juj7XnYLO+oUSR0JSDrrz7wnSP6mO6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=corBxT/EZAvc6XZyVOwl1+ETNbua0G7kVoy3tDIFWtL5S7TO34+HR95tzy8SyWmuL4XvL+8Iw1HAPVc9CYez9soi5fm8azRE/QSGeRWDRhlFoz6GHnj5orU3v/Bk3LLmtw1SGABsWqqOyiop70sXTBazL5F8Esub441YVowpZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FRlis76N; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FRlis76N"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53512cd2f85so10791621cf.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666180; x=1792270980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PH2ZNztxpOnnAOmdxAya78mHgVtF5bOllPXI+YQjWm4=;
        b=FRlis76NAmqidXFhAi68DEp0YJeNUVyZ5Bbn/h9AGOKCfTAjpLA9AVChTjhSN4fV+m
         rAvNX22RYXCMHvR0zmShljjhB7kZBXbBTSi4Ayv+151IAvojiiSjJGFr9ntxJoPJPWAE
         pWc+L2JBMhgm+FKZDko8ptpGuQtJBu73unjH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666180; x=1792270980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PH2ZNztxpOnnAOmdxAya78mHgVtF5bOllPXI+YQjWm4=;
        b=zyfkuoBFI+7TneHXMH5mmEYb+3TX1cSxW6Gbnmp70Db8O8gm9VdW3aAunrI5O3PpoV
         LLCClF4AVcYO6VA9wjl2JXNmEGP008+C8qntCUGV7nQf6tiUpSrxqPgjOPYKYqticeEs
         UZaPYZbyijFR2u579dyHNSP9vBDSkGWDSyE38mqZ8PEmcZMm1m4zzKeqQZf6M2Nq4kbq
         uwOpeIlctBV3kHsFACXbVQJNDSKCyuiB5Esltz91Xs3EgN2lhh83DXStMP9R4jeamYz7
         7oW9qEhgyD9kfarJ0r98SPYqp+Dcet0a4arYdWd03BZifauPKugWKtYL8cP2itYwuOVT
         dVhQ==
X-Gm-Message-State: AFq9FYITJ6fYjUl6+P/3yVfpsdcs19AS3xtA0CUbPbd+t7Y0VSu0EMCB
	7uNNS8X2uozAQ2caaloVam4WX/Apty8DzxRGUCAFNoQ7s+hZaXeGmcD08QRx2QGgP4ffnvEvmj5
	Mu5U=
X-Gm-Gg: AYBFou0WFACMddEqy8v1A2VnETHAjTTedpaZ2VOUlRRFEwn97Q4HNG+zOi7weNcy7x2
	44B+jYQ3ZQfH55n7SAfNGMJNiKJsmY3/60QTaTwL2V/cmwuEW9kO+9JlPlbF6P6bsbUUyS/8cG7
	fNpR8Mp8woUFMmFcdRTJ5YVQhj9ZEIycJa6yepIxo+/RVKgWMl9NqovhLd81ZqPaY94xQlEk5bH
	JJq6/nDhmTIkUu3497CpibGOIOzdLutKsbNx0e4KCaVJTLaPPgGVL32n2NXtISdW65HHb9XzvNG
	pZAA0H8j97WZZ3qjGPT5T3W0d7WagghCfixGUGv1c2EeNgZPw4yuVzT/WfvmTz11Wo1+BwgvC5p
	XW2sFyJIT3+Zc+gyh8lK+zPkwLok+xWhfEEqFdLEAy+O4ktbaI7juRLSiUnBq2N4cL/LqqLO15k
	svKWWd4Hz1vNyMwBf9EYxO4hhzsBncvQ7xrhnqcLPA140MmFXMPJjsa5DCE2eYIMHhZluO9kuxD
	+VEUIyXX2s2Thnlpt0MbCz6/ckPWVr549WbR+FA9CzI
X-Received: by 2002:a05:620a:44c1:b0:93e:6e59:ad16 with SMTP id af79cd13be357-93ebd1dfd74mr921864985a.29.1791666179722;
        Sat, 10 Oct 2026 14:02:59 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:02:58 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	horms@kernel.org,
	qmo@kernel.org,
	bpf@vger.kernel.org,
	jiri@resnulli.us,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	victor@mojatatu.com
Subject: [PATCH net v2 1/3] netdevsim: reject cls_bpf programs bound to another device
Date: Sat, 10 Oct 2026 17:02:48 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
nsim_bpf_setup_tc_block_cb() installs any device-bound SCHED_CLS program
without checking that its offload device matches the target netdev.  The
core cls_bpf attach path rejects a mismatching program, but a netdev that
joins a shared block later is replayed the stored filter by
cls_bpf_reoffload() before it is inserted into block->ports, so the
attach-time check cannot see it.  The driver callback is the
authoritative per-device acceptance boundary and must enforce the match
itself, as nfp already does in nfp_net_bpf_offload().

Without the check, replaying a device-bound program onto a different
bpf_offload_dev installs it into that device's netdevsim state, which
trips the WARN in nsim_bpf_uninit() (ns->bpf_offloaded set on a foreign
device) and can dereference a NULL prog->aux->offload in
nsim_prog_set_loaded().

The Fix:
Reject a device-bound program whose offload device does not match the
target netdev, with -EINVAL and an extack so the rejected replay is not
silent.  The check is intentionally narrower than nfp's: it fires only
for a dev-bound program, so nsim's bpf_tc_non_bound_accept mode (which
admits an unbound program onto the device) is unaffected.  Teardown is
never blocked: the guard is on the program being installed and an unbind
passes cls_bpf.prog = NULL.

Conditions to recreate the bug:
  - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
  - load and pin a dev-bound SCHED_CLS program for netdevsim device B
  - install the program on a shared block owned by B
  - add an independently backed netdevsim device C to that block; the
    bind replays the filter to C's callback, and C's
    ports/0/bpf_offloaded_id takes the B-bound program id.

The reported Sashiko review is at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809094418.901607-1-jhs@mojatatu.com

Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2 (v2 of an on-list patch; v1 posted 2026-10-04):

- Finding (nipa Sashiko High, v1) -- FIXED: the
  every-member predicate is enforced only at add/replace, but a netdev
  joining a shared block later is replayed the stored filter by
  cls_bpf_reoffload() before it is inserted into block->ports
  (tcf_block_offload_bind precedes the xa_insert).  Neither
  cls_bpf_reoffload() nor nsim_bpf_setup_tc_block_cb() checked
  bpf_offload_dev_match(), so the B-bound program was installed on the
  joining device (re-opening the 120977e2c096 mixed-block defect).
  Fixed by enforcing the device match in nsim_bpf_setup_tc_block_cb()
  (drivers/net/netdevsim/bpf.c), mirroring nfp.
- Style (gemini + nipa Low) -- FIXED: the shared-block comment opens with
  /* on its own line.
- The companion selftest exercises shared-block and late-join coverage,
  pinning both the all-members predicate and this callback's replay gate.
- Split the single v2 draft into [PATCH net v2 1/3] netdevsim,
  2/3 cls_bpf and 3/3 selftests, each with its own Fixes: and stable
  metadata.
---
 drivers/net/netdevsim/bpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 16aa88278398..a73ea8b07682 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -144,6 +144,18 @@ int nsim_bpf_setup_tc_block_cb(enum tc_setup_type type,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * A dev-bound program can be replayed here when a netdev joins a
+	 * shared block, after the core attach-time check has run; enforce
+	 * the device match as nfp does.
+	 */
+	if (prog && bpf_prog_is_dev_bound(prog->aux) &&
+	    !bpf_offload_dev_match(prog, ns->netdev)) {
+		NSIM_EA(cls_bpf->common.extack,
+			"program bound to a different device");
+		return -EINVAL;
+	}
+
 	if (cls_bpf->command != TC_CLSBPF_OFFLOAD)
 		return -EOPNOTSUPP;
 
-- 
2.43.0

