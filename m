Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4238F64E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881692; cv=none; b=LqMchmaS0jRnIMnv0sjhGPILWC/tvx/GIP5ZJmWSI40Ho9VstYihj76sgxCHo3rXLF7m4z8uSyo23nAbSqwUdCcAJ+PqutrKB9TsK6sxXrqQKVhlWsQksfyK56/WdQ8WUxjHHZcaafgxgTTRfOImirF6yJmjoj79OkYKXGk59VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881692; c=relaxed/simple;
	bh=kWMsLLVBREsarMr/IgAfeUUPUVL0sQRizoUswwnHv64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxnRjRc7sWuOQIkI53Iw2whLivpQgLQooasn6BdAdBc6K0AH1uUJzo309YPmM6/PaBTAK/amYfOop2cjQBkVyq3R2Jxqcl/OvAyOISLZJ5wkbs4G7aWXZ5k9i4DmeSOlZrReCEFWQprFjJ/gHxUhuyrL0LAfyE2hwqvFbrXByms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gR8r7eCE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gR8r7eCE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53397325663so28474431cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791881690; x=1792486490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kg+0nqUNXSQgxNL5RCC0Vm/uiIJrrSby7SdwI9XD5YY=;
        b=gR8r7eCEo3GJ/zJZPA9pnWfITKLOn60jlbpkDcSMqx1fZqIxcehQwsmK4eXbd/fXbp
         v6RglJqNV+I+K6MkNGS3JZ9wbtpAORo9DlXVPxRhxI7RSEbZX9K0qdaO78A8eW8W0ulz
         zL8KlMa8BFzVY8iJv3PH4JhkaKoyizyM884JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881690; x=1792486490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kg+0nqUNXSQgxNL5RCC0Vm/uiIJrrSby7SdwI9XD5YY=;
        b=Q+tifrqlT3rtrnOOCvItM71EDwL01c+NXlVWWWJRGOjOubzkU1p5ilM6LvOzug9x4J
         WGNlLBLyKjCAoQ2i3f5cdHIRHsc/n2YOQuKB/GP51YZNDxKCRe3vHj4R6OZlNL2pbdpr
         KaoerRkDhhryofG/f013G7nmK4nCv34IwzOcX+FElpReD6/HM6m3n+f54WNvS1POsur9
         RiqxQrba22Hb869Gwy+jjbIaG3J7v6FTFSpDdZQ1pOaIvj6jn8e+1MHEQlmvhTBrusOP
         Ee/TapMZeacPNa7DuKW+27ERlpxodG1w91YyFFA/VpnRtFh8kB69pHq5+tklVNQBfRDD
         kuFg==
X-Gm-Message-State: AFq9FYI15pkFhv1C0Z7kWTrAvjgdiJz1Be9Gt/kn0Zv+9TyHkVUfdHtk
	UbG+b01iqfuVxop6Tmo05kdX7xZQ0nB4JQ0YQbU3u+qAtxpccxbFb5uQN9IOLy9JTZS+sOdWPxS
	kI70=
X-Gm-Gg: AYBFou0rDVfIjNbWMV600uAks7BFZfmC7sstmtqeB5QNYzCQ8ssHFc4zx2g7hOma1tZ
	T48usKmKTjZKH0M8pBZhP0C5oNFn0aGLtMszhG02BkLYqm6ZoaUAXLF7mmEe+uHpG/npnYBvgKp
	Lv7JkCsfxr57AspIylBB93Y6HXQVy7HBl9bErXOI7QJwFARjaG9qol0ILKjU8ZvQFUl1LFwkMST
	Fw7Hwb6YtlZx0zKERp4H5lOFzClKEMn3yZwoxYoYZoe/UQ0e2AH4l7dU7/ImFBO7GwLTNIw0Uha
	L+i/E6Zq/iwPrGeq/SG5E+gMWDQo5VHYlPJUvrUBdk3tdkziUZronW42CuOZFDFDm8VgQf95Vjg
	0oga25wPEOaIeVtrrEo/tGKsiKzRLOxOrwcLVHJ5TRH6KPMIx7HxDTvovSSE/eYAUZWt/mrChYH
	J/2vyTHvfIB8SKBEnbKd0SFT5Hox6Hfq2gKEhG7vu2XUp+NCaznV2Mog6jrMfsZD2uCU8DLsYOE
	6L5ZhH/6qmJLfJXdyckrJTIpt4COLX4biTFl8imCJzb
X-Received: by 2002:ac8:5d4f:0:b0:535:f200:156e with SMTP id d75a77b69052e-535f2005a95mr8552111cf.60.1791881689756;
        Tue, 13 Oct 2026 01:54:49 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm97763401cf.11.2026.10.13.01.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:54:48 -0700 (PDT)
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
	Paul Moses <p@1g4.org>
Subject: [PATCH net-next v3 5/5] net/sched: act_api: report an oversized action dump instead of silently truncating it
Date: Tue, 13 Oct 2026 04:54:31 -0400
Message-Id: <QDISC-H19Z.v3.r0.20261012193813-5@mojatatu.com>
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

The issue:
tcf_dump_walker() trims the half-built nest and returns the number of
actions dumped so far as soon as one action does not fit. When the action
at the current index cannot be serialized even into an *empty* dump skb,
that count is zero, so tc_dump_action() returns skb->len (zero) and
netlink sends NLMSG_DONE with no error: "tc actions ls" silently drops
that action and every action after it.

That case is reachable inside the gate entry cap this series adds: a gate
entry serializes to 36 bytes (40 with the gate-open flag) while a dump skb
is clamped to SKB_WITH_OVERHEAD(32768) by netlink_recvmsg()/netlink_dump(),
so the top of the range the cap admits installs but cannot be dumped -
and, before this change, fails silently.

The Fix:
tcf_dump_walker() already has to distinguish the two cases: a walk that
filled the skb before completing the current action must keep returning a
positive count so netlink retries that action in a fresh skb, while an
action that cannot be serialized even into an empty skb must return
-EMSGSIZE. So return n_i when anything was dumped and -EMSGSIZE (with an
extack) when nothing was, and let tc_dump_action() propagate the walker's
error code instead of overwriting it with skb->len. That mirrors
tc_dump_tfilter(), which returns the walker error when a retry made no
progress (if (skb->len == 0 && err) return err;), and tc_dump_chain()
carries the same idiom. This is netlink's documented contract: -EMSGSIZE
with data in the skb means "more to dump", -EMSGSIZE with an empty skb is
delivered to user space.

Context note:
The shared nla_put_failure label stamps -EMSGSIZE for any inner
tcf_action_dump_1()/terse failure, not only a size failure, consistent
with how every other nla_put_failure label in the file reports; the
-EMSGSIZE the action dump now returns is therefore not a strict size
assertion.

The cap stays a memory bound; this only makes an action the cap admits but
the dump buffer cannot carry fail loudly instead of silently truncating
the list. This is a long-standing silent failure, not a regression, so it
is net-next hardening.

Reported-by: Paul Moses <p@1g4.org>
Closes: https://lore.kernel.org/netdev/vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org/
Suggested-by: Paul Moses <p@1g4.org>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 949cbc4523a9..55d553713bd3 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -599,18 +599,13 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 		tcf_action_update_hw_stats(p);
 
 		nest = nla_nest_start_noflag(skb, n_i);
-		if (!nest) {
-			index--;
+		if (!nest)
 			goto nla_put_failure;
-		}
 		err = (act_flags & TCA_ACT_FLAG_TERSE_DUMP) ?
 			tcf_action_dump_terse(skb, p, true) :
 			tcf_action_dump_1(skb, p, 0, 0);
-		if (err < 0) {
-			index--;
-			nlmsg_trim(skb, nest);
-			goto done;
-		}
+		if (err < 0)
+			goto nla_put_failure;
 		nla_nest_end(skb, nest);
 		n_i++;
 		if (!(act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON) &&
@@ -626,10 +621,21 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 		if (act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON)
 			cb->args[1] = n_i;
 	}
-	return n_i;
+
+	/* A positive count means the skb filled up before this action was
+	 * complete, so netlink retries it in a fresh skb. An action that
+	 * does not fit even in an empty dump skb (nothing dumped) must be
+	 * reported as -EMSGSIZE by netlink instead of ending the dump.
+	 */
+	return n_i ?: err;
 
 nla_put_failure:
+	index--;
 	nla_nest_cancel(skb, nest);
+	err = -EMSGSIZE;
+	if (!n_i)
+		NL_SET_ERR_MSG(cb->extack,
+			       "TC action is too large for the dump buffer");
 	goto done;
 }
 
@@ -2345,7 +2351,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 out_module_put:
 	module_put(a_o->owner);
 	nlmsg_trim(skb, b);
-	return skb->len;
+	return ret;
 }
 
 static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __initconst = {
-- 
2.43.0

