Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D097345ED8
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859087; cv=none; b=XLqH+PUxlGV33TZOZDQGHGbP1W86SBU7dThUlBPTmji3dYTbjb6GWLanHQCofQmrlwbDxpkZX3W8CicC92++FyjHXWqL+k+EiVh97mT5asRnm0wvkzjEoOUmr8yNfYgP5mvOgfeyPX5h2lyRhCEtmhObqsX6Jb4qIEA0QrDqvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859087; c=relaxed/simple;
	bh=nBanjkjcG/wDoAb+v74CuGW/tXZbYRxXEOkv5OKObHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0t+2nvFviqaRLFdtp0dHhpzPcaVeOofvJBMKd8pDa4THO7m2LiOO3aR+JRqPXzz+MFuMNrelZKFN+RVOJHcicxL+Xv1iv7ipVddBbrXl3tmQyIvBbsYVRRceOpcj7wxVtY0OFyoADsU2iPJAMdJr69THfRlgNBx+P5Vc9cnPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YzTJRW6W; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YzTJRW6W"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so286196a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789859085; x=1790463885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jiqVo6e3n16UvaR+X0mgkt0I5vYupJ5RzA/vaa7zqCg=;
        b=YzTJRW6Wwxib5+gFuImysbsz7yKTEEda8zje/oBMf095hYT1Bu9kGgNwPZXqmICp8x
         O2riITcv/UUzuYbEGbuAd9vOPfyiFtMH77MnkTRceITip7kOKxWDZGycYAaw1qGB01MK
         ipJ8aVhZ1FTeV2Nhr4+w4DyKTSb4kILvA8lto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859085; x=1790463885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jiqVo6e3n16UvaR+X0mgkt0I5vYupJ5RzA/vaa7zqCg=;
        b=rcoxVO+4vT1h9BuFhCOz490I1ZponXWyZ37TTjG8B7VLByq8+Yn+kq5mixgMJrisUI
         Tc5cEBCXlF+im6R1nzjHub8pPCLIUDOWa9Er0mRwThRD7kGgZu9xr6ocaavhSQksupXY
         UmhzrOBPNn+zw/FsVQQ5M+Zz+ICdjCEoqNhUrtam7wLUvQgSj2N0+YPLLI2oX93kwQOV
         9gz67Yx24ULCTQLJIqKwlEazc9nu835+tsFiPKijhftGZvpnCfhqPbWBsMZ4yCnc4YdU
         kcZpZ6xGcB8QAcJlPY3Ebxj6TWOBB30j/iOWPG21Cth+co25+9qwxjDqHScbejZTI+5X
         VDlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWXfrcpeyDIj7bX6w52qVeAeNqye5zgxc68RCFF7K/W4x+eilrA0qVBse+5pw3qmgo0oaO7Pc=@vger.kernel.org
X-Gm-Message-State: AFuF++np7gJVa+D0SsqIRRZfIz5HGO5Zm61dSqBmp0RXynbyg2IwsKVA
	WGIlFPdWnZoAzHJiDYkOb3t2pKCJ0j80mFGF38l/1Rc/GC6OScgzhwbKOygcmSIpdQ==
X-Gm-Gg: AYBFou3mCHQCsdUW5MlGBc+EQYa/vTNQLnMZzw5cC+BnyNU+eznKqxPuuUNYJcbLIvP
	4DkTf62SxBGciXKxiaM8C+KbBMFSR7Q1W1Itw6RddSpfz8bYwi+Boz6AUVDL7+Zy8+5VnQTCJz7
	OegfxehGp+ZG2Psf/ZYC20QNtaq0GOd0Vv+62DQu5790N7GVciBf9nZ4RZnqO8p/1niyrudICwE
	UQQWOKLHwwDL3sOVmyW2XN9fE0ueQsZG30l9/rJ5H3+uAo45yBASp1L51+WZp7wKix7tJUs/lLn
	dDpSyIBo/g/Pl9Ct6muLX7JWL3QQtxUWL+wdGJEnuWUK8Iyp1R3WvIo1UUKq/FnVs+tIrL2xDum
	9C3G3VhMEz7lHzJd5y5VBWwUdgctajGcrm6xNfhPO84QxB6zCNK4V/ieDCkTJ3QYjnW/Jl5yDWh
	sJnBwuesUZL+iRgv1KDkW/k6przbp9mPoAO53Vfe4uSuCEzd3c1Yr2X+8LBccru7b2DJWLxCP1i
	CXB
X-Received: by 2002:a17:90b:3b85:b0:39e:4c7f:7305 with SMTP id 98e67ed59e1d1-39e5504d3d9mr10932214a91.28.1789859085448;
        Sat, 19 Sep 2026 16:04:45 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm8804599c88.3.2026.09.19.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:04:45 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	hybris@mojatatu.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 2/3] net/sched: add get_fill_size() to the five actions that lack one
Date: Sat, 19 Sep 2026 20:04:28 -0300
Message-ID: <QDISC-RYTB.v1.20260918093205@mojatatu.com.2>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
References: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

act_simple, act_mpls, act_nat, act_skbmod and act_connmark each have a
tcf_*_dump but no .get_fill_size callback, so tcf_action_fill_size
budgets only the shared attributes and omits the per-action
TCA_*_PARMS and option bytes the dump emits.

Add a callback to each, sized from the attributes its dump emits. Size
every optional attribute unconditionally: reading the current flags to
size it conditionally would race a concurrent replace, which can flip
the attributes between sizing and dumping.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_connmark.c |  6 ++++++
 net/sched/act_mpls.c     | 11 +++++++++++
 net/sched/act_nat.c      |  6 ++++++
 net/sched/act_simple.c   |  7 +++++++
 net/sched/act_skbmod.c   |  9 +++++++++
 5 files changed, 39 insertions(+)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index c634af5edfcd..0b6ac6be60d2 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -236,12 +236,18 @@ static void tcf_connmark_cleanup(struct tc_action *a)
 		kfree_rcu(parms, rcu);
 }
 
+static size_t tcf_connmark_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_connmark)); /* TCA_CONNMARK_PARMS */
+}
+
 static struct tc_action_ops act_connmark_ops = {
 	.kind		=	"connmark",
 	.id		=	TCA_ID_CONNMARK,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_connmark_act,
 	.dump		=	tcf_connmark_dump,
+	.get_fill_size	=	tcf_connmark_get_fill_size,
 	.init		=	tcf_connmark_init,
 	.cleanup	=	tcf_connmark_cleanup,
 	.size		=	sizeof(struct tcf_connmark_info),
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..aa56521b7179 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -438,12 +438,23 @@ static int tcf_mpls_offload_act_setup(struct tc_action *act, void *entry_data,
 	return 0;
 }
 
+static size_t tcf_mpls_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_mpls)) /* TCA_MPLS_PARMS */
+		+ nla_total_size(sizeof(u32)) /* TCA_MPLS_LABEL */
+		+ nla_total_size(sizeof(u8)) /* TCA_MPLS_TC */
+		+ nla_total_size(sizeof(u8)) /* TCA_MPLS_TTL */
+		+ nla_total_size(sizeof(u8)) /* TCA_MPLS_BOS */
+		+ nla_total_size(sizeof(u16)); /* TCA_MPLS_PROTO */
+}
+
 static struct tc_action_ops act_mpls_ops = {
 	.kind		=	"mpls",
 	.id		=	TCA_ID_MPLS,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_mpls_act,
 	.dump		=	tcf_mpls_dump,
+	.get_fill_size	=	tcf_mpls_get_fill_size,
 	.init		=	tcf_mpls_init,
 	.cleanup	=	tcf_mpls_cleanup,
 	.offload_act_setup =	tcf_mpls_offload_act_setup,
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..a201979ac7cf 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -313,12 +313,18 @@ static void tcf_nat_cleanup(struct tc_action *a)
 		kfree_rcu(parms, rcu);
 }
 
+static size_t tcf_nat_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_nat)); /* TCA_NAT_PARMS */
+}
+
 static struct tc_action_ops act_nat_ops = {
 	.kind		=	"nat",
 	.id		=	TCA_ID_NAT,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_nat_act,
 	.dump		=	tcf_nat_dump,
+	.get_fill_size	=	tcf_nat_get_fill_size,
 	.init		=	tcf_nat_init,
 	.cleanup	=	tcf_nat_cleanup,
 	.size		=	sizeof(struct tcf_nat),
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 8e69a919b4fe..80e5084b4dbd 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -79,6 +79,12 @@ static int reset_policy(struct tc_action *a, const struct nlattr *defdata,
 	return 0;
 }
 
+static size_t tcf_simp_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_defact)) /* TCA_DEF_PARMS */
+		+ nla_total_size(SIMP_MAX_DATA); /* TCA_DEF_DATA */
+}
+
 static const struct nla_policy simple_policy[TCA_DEF_MAX + 1] = {
 	[TCA_DEF_PARMS]	= { .len = sizeof(struct tc_defact) },
 	[TCA_DEF_DATA]	= { .type = NLA_STRING, .len = SIMP_MAX_DATA },
@@ -204,6 +210,7 @@ static struct tc_action_ops act_simp_ops = {
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_simp_act,
 	.dump		=	tcf_simp_dump,
+	.get_fill_size	=	tcf_simp_get_fill_size,
 	.cleanup	=	tcf_simp_release,
 	.init		=	tcf_simp_init,
 	.size		=	sizeof(struct tcf_defact),
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 7579cf1e0ff3..09e9dcf58253 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -279,12 +279,21 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 	return -1;
 }
 
+static size_t tcf_skbmod_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_skbmod)) /* TCA_SKBMOD_PARMS */
+		+ nla_total_size(ETH_ALEN) /* TCA_SKBMOD_DMAC */
+		+ nla_total_size(ETH_ALEN) /* TCA_SKBMOD_SMAC */
+		+ nla_total_size(sizeof(u16)); /* TCA_SKBMOD_ETYPE */
+}
+
 static struct tc_action_ops act_skbmod_ops = {
 	.kind		=	"skbmod",
 	.id		=	TCA_ACT_SKBMOD,
 	.owner		=	THIS_MODULE,
 	.act		=	tcf_skbmod_act,
 	.dump		=	tcf_skbmod_dump,
+	.get_fill_size	=	tcf_skbmod_get_fill_size,
 	.init		=	tcf_skbmod_init,
 	.cleanup	=	tcf_skbmod_cleanup,
 	.size		=	sizeof(struct tcf_skbmod),
-- 
2.43.0

