Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287D4156EB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102091; cv=none; b=qKRVAK8KaMYNniAxP0RndlnD3Pr7yrX5HvQj74fVlyEel7Rgbxd2+RL9GeM3aNAWY7mnM8uMyYm/9FBOQmoF03VkqeaU+A+E0znEBzVKZEjWDk1x8sSWIt1/+lPhk5WSoQBY1cTm/JHuLsqSMDsIbjIs+nXcJHPYjn6YMlut16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102091; c=relaxed/simple;
	bh=6FHee7ZEU8wOo8tP7rKlTC65o3aKdPDn5LzLZBEl7lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pK5if9APeN+7s35Qym8TIv+nFbmsnD0/7i+1ZVBaSRa6/8490FRU5TG6w9+0cbkMHTa5P82QAW3RA/eD0zeATlfAKIz/6tWe3+NtZ3uZo2YL2prjR/G48YdfuRAAtqe4qEQzKWXhjolcCG3O+3CPzM/f2iyzmUhhTi/Qx3AwyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xs+WHhM+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xs+WHhM+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533797e72e8so4911281cf.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791102087; x=1791706887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FojYhi+zQ+i+QBoXzZQeQnkuw032To4ls7EFcWJhebg=;
        b=xs+WHhM+TlDiYhJTtkF+vlJ+aDauKMfUn9ekch+VusiqXv8g7kQtXu5OENj+9VeUSG
         xn40WHTLDC3wq8QQN9alh1pDh38y2Gq6nYBRzhNofJfdmIgYt+/btUj1T5Rjm9ASsb8S
         nUPmzYOcDDNwyIsGaZ+SyQ5I52SdSyj/eczgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102087; x=1791706887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FojYhi+zQ+i+QBoXzZQeQnkuw032To4ls7EFcWJhebg=;
        b=mkcXoQX5ITFBfYNT34/Af7MZcJ2Y7aizwkLzLyfUoeE54laq3o2gxUmBrBMyY4CQjo
         1iSgsf/BrfO5rNYAIgsapc5yqYOeRAeDE4bTVLHzGsCdxETDIY3NP7VGf5zRD5wjBku5
         SU6FWJwv3I1vMhLitHofj+cLOVeF7tKO0NkmfDuYGbTj5+nKoeywQyCK3ZD3Sc9QYD6I
         zRenNUL8XJI4smYylGDgRtbPhun1TW4dsEQHedfN2dBmKaR+iQzRG3zjAFWrjnPcDUDK
         uf5sPEoOOjJJqnUNaKewbHyG/Ow007zfjCLfpY+ClVq4YUudgPsI3yj79W0o6lMsXAWQ
         rO2w==
X-Gm-Message-State: AFuF++lHhvviIlZcDQYWwVgEtS5wod+cuR17gG1+Z0TVcwKsv4WGtSUb
	13FXn+9IYZ+nrR+tsr9RtdMU50hglrevkoYCbBzINwQjsQsDiRZ5s8bX16uqSIvqx876n+LZ7Bq
	ZPC0=
X-Gm-Gg: AYBFou33b3QfQSlfADuEJcuUY8+dBjiWDbCSH59kkNI/q71qBgxmt3xy3SFMdCeF0SA
	KZm11ob8VV0UPR6S1RINPLoegIW1c2UibXEEHfobzgyNkqKFxRxGAinQKqjRdvYEliAjQWydCtG
	jLYbVj3HnRk+ei2UsSkmuBsJS54dISqnuRReFUkW4YRu6Eph2AfLIhj74AYA+8ZEFZfJw+ej+u7
	Tn6Xsm8n32Un7s7jROR9ZUtt/XtPuCt7e1JXi5IlwGonZek0glNro3Qkof4GbytXz3e2eOIDz5j
	e8lqfrG+JZVzO9dkBhWiOd8FNqCXWtR5P12jBfDFrRrj8+q8TVSMWPo72AqZVzRbo+kli1b5ueo
	O1oZ8TSm9nXyY3jGQYKD+z7DHxKk21YUxbMB3EfofrO7aB0LS/lHfs+wcjdiyJyz//tF5kPFsmY
	iD3UDd0XPMjHRJ+35CuY8lJC1fEMcue48pi1lKOReLiJSG7ij7m6kwkbOA+yHmGNKPX5zqQ6E5T
	8vTXCqR8k8K2hzBL6+yn91IKOwRoWUsBErycSE2UuKA66iyA7O6GGP4w4z2
X-Received: by 2002:a05:622a:260f:b0:531:11ac:23d5 with SMTP id d75a77b69052e-53511b8e47amr73310381cf.7.1791102087219;
        Sun, 04 Oct 2026 01:21:27 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398836341sm68451271cf.2.2026.10.04.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:21:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	bpf@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] net/sched: cls_bpf: accept dev-bound programs on shared blocks
Date: Sun,  4 Oct 2026 04:21:22 -0400
Message-Id: <QDISC-PYC7.v1.20261003103747@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up to commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound
programs bound to a different device"), which derived the target device
from block->q:

	dev = block->q ? qdisc_dev(block->q) : NULL;

tcf_block_create() deliberately leaves block->q NULL for shared blocks, so
a device-bound program attached through a shared block is rejected with
-EINVAL even when it is bound to a netdev that owns the block.  The
offload path (cls_bpf_offload_cmd()) never consults block->q and drives
the per-device callbacks for shared blocks as before.

Accept the attach on a shared block when bpf_offload_dev_match() matches
every netdev bound to the block, and reject an empty block.  Every member
must match because the offload path broadcasts the program to every
callback registered on the block, so an any-member check would re-admit
the wrong-device attach on a mixed block.

Conditions to recreate the bug:
  - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
  - load a dev-bound SCHED_CLS program for netdevsim device B
    (prog_ifindex=B), pin it in bpffs
  - tc qdisc add dev B ingress_block 22 clsact
  - tc filter add block 22 ingress bpf da object-pinned <pin> skip_sw
  Unfixed, the filter add fails with -EINVAL ("Program is bound to a
  different device"); fixed, it succeeds.  Adding a second, independently
  backed netdevsim device to the same block makes the attach fail again.

Fixes: 120977e2c096deea4e866e4273be9220b957c29e ("net/sched: cls_bpf: reject dev-bound programs bound to a different device")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809094418.901607-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_bpf.c | 26 ++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 188cf0f949dd..fe3bf251a39b 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -392,9 +392,29 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (bpf_prog_is_dev_bound(fp->aux)) {
 		struct tcf_block *block = tp->chain->block;
 		struct net_device *dev;
-
-		dev = block->q ? qdisc_dev(block->q) : NULL;
-		if (!dev || !bpf_offload_dev_match(fp, dev)) {
+		unsigned long ifindex;
+		bool found = false;
+		bool match = false;
+
+		/* A shared block has no qdisc (block->q == NULL) but may
+		 * bind several netdevs; the program is offloaded to all of
+		 * them, so it must match all of them.
+		 */
+		if (!tcf_block_shared(block)) {
+			match = bpf_offload_dev_match(fp, qdisc_dev(tcf_block_q(block)));
+		} else {
+			xa_for_each(&block->ports, ifindex, dev) {
+				found = true;
+				if (!bpf_offload_dev_match(fp, dev)) {
+					match = false;
+					break;
+				}
+				match = true;
+			}
+			if (!found)
+				match = false;
+		}
+		if (!match) {
 			NL_SET_ERR_MSG(extack,
 				       "Program is bound to a different device");
 			bpf_prog_put(fp);
--
2.43.0
