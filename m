Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8A3E49D3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922222; cv=none; b=Bi98Ogyrrz1QnFxA1VOAcOnS9HcPu8dm27PeFc/dbRezErmdR7sOTqPRK+axWJg+jOyNFccXikVCIitJ2AbDQVvlRC5tguVuc7jPUnIkZG8L3/2tGfCsWJbvqOiKP+PKpkKnqn+MCKBGgmiQ2dcz54AckOYI2nM6H52gT+da/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922222; c=relaxed/simple;
	bh=R1qfl28bcTRyuDqlwIrb2wgtj2lT6TY1+KX0CgMB/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ava9r97LF+2tjwZWKmxmv7dpp/RPPQHw3ulY18n/sWokEQbuwVEEQqB1pNCgx2+Fel6AwrSEdd8IHy+aRxfidVGkn/IcB00lwfF1I3vBZmnclP58WmZTlANij4BhH91kAecd1ZLHGZrlznwpzsfEq+X9PSpmHFwk7Xs+Q5GyYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3WUSmPv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3WUSmPv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84830c774a0so796006b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922220; x=1786527020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WIhXQgLhZ2pzW8mmQzoIH14CUe2+pfWcLRhH7gstZkc=;
        b=M3WUSmPvAZ5mx72m44pPSL3vLyZTNH8ydaWbbFcwcLzZ+fXeZl8QsgyEvZk65ZpU+9
         GdA0tS6WgU9QX5lI/nJpjCtcIlI2d1BB75e7PHf0byscva75Oc+IuCNslmVnOGA7cAv3
         U3Y18WcZckmKEAYwUZpMbbdfyqPcupW89vAoxKESBa/zjM/7IkkiOzSU1ihlbo25CMBT
         8P5dxapL3BnCGJqiNQURnRzD4y+v9EPLIEJQLLQ70t2qktCztHg4A3suNTRmyhRNoh8K
         9FXgV52IF95n1V1T4wk2WI2u+VJLeMtkKm7y5wQ3sBpLSuFJPpoQjFuSVxuYZt7IuaT7
         x/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922220; x=1786527020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIhXQgLhZ2pzW8mmQzoIH14CUe2+pfWcLRhH7gstZkc=;
        b=iD98uKnWKCunBsbZBXOPw0MkIIw8X+1TSwgSxFFHjR4DbrpMY7zSVh+XZ0jVwGi/9Q
         d+luOX6fzq0NrrkcjeKKfmwG+qTpeco0SfkHxnCu3NcXaHAWDu9U4GcmUCRDki+Xa7wO
         ws70c4hXhwmD37Amae1i26gM3NPF7H4KrmT4oFDwy/lqVkYiKmIuZeGeStVY024ocNFY
         Wjkuiy4i5B0QO4V3KX9cl7MCx/u2B07IRQ2YX91p2AjRRfJc/HudjXxkfVEfBuCwIO1y
         ahb/5s5X5C8k4lMMTajvT6na3Xh7gPnLLOkSWoVUmcqTfWLFEu+wTXbT/NhXC1qSC501
         Z/+w==
X-Forwarded-Encrypted: i=1; AHgh+RrrUdzdQZBKwaPAT++T9zXVEgBUqpUvxTzL1LGCPtd9sxcneauX4AgibcvEWEUx+hSk17in7zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8BBoEihe4IMbl/5HsgRdVoMWBX62UtuKYgoE2wUGpDDgAY3u
	LlVIJbC0k5FxOfT8sw3TbBwrz4ocTefq1SSgiSSjhWa+gXgSJ500JEKK
X-Gm-Gg: AR+sD10zqAd3Jua5vGigdiGjrX4V6QHsfArOcuiTW1LrP/+gIMJXBrp33OYPy2GJ1RD
	85ZLGuDvcYrUWewbEORfgN2EY2BJYwNRj1l/cWTE1lEPs/02Qw1U8HKIsNqJePPQ6s0MT6Oa/3P
	m6K5wtBUEstHSlIDjj+v9WE9NRiBFfsMy4zl2F8cVGrWt544iwFCoI0CDWFt/479mWYF5YD7Rz6
	vOAeXiTmfMqB32l4INxQmd3Mz0kk+EuPnYBDv7SXptf0k8DAQmwGyrYV2lKs5PFNtgIkyexEV7K
	HoEeYhP8RCpj0Xly0Dkp7oMyntjQ34TJ1MLK+EK6c0JJABY2GK0UvBy3gKPP3mgLkGnAXVhgXil
	xflGySuOEC9YlH2UYn+9xt+FYYQnLCdiZAElRQIs74tAz7cMWn58350HKeQ6Vfs0Dd7JPSPGbTo
	PhMqDRS2iuOjTkXI8xUSGRR8tqXsVwFdwrTq1p3lolCXcP8ETZVRpwLUMLJcILaAw0DS/i/wXO3
	sUoJi036sNWBD3rU5Te7rv4HlPvpQ==
X-Received: by 2002:a05:6a00:1310:b0:84e:216d:7e52 with SMTP id d2e1a72fcca58-84f2e03175emr5807527b3a.14.1785922220040;
        Wed, 05 Aug 2026 02:30:20 -0700 (PDT)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e50a00dsm603445b3a.48.2026.08.05.02.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 02:30:19 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
X-Google-Original-From: Aohan Mei <henrymei@tencent.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	corvus@tencent.com,
	henrymei@tencent.com,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: cls_api: fix tp_created race losing existing tcf_proto
Date: Wed,  5 Aug 2026 17:29:57 +0800
Message-ID: <20260805093012.95155-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc_new_tfilter() attaches a filter to a chain. When no
tcf_proto (tp) exists for the given (protocol, prio), it creates one
with tcf_proto_create(), marks tp_created so the error path can clean
it up, and inserts it with tcf_chain_tp_insert_unique().

However, tcf_proto_create() can sleep, opening a race window in which a
concurrent thread may insert a tp with the same (protocol, prio). In
that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
*existing* tp, but tp_created is never reset. If the request then fails
(e.g. kind mismatch), the errout path calls
tcf_chain_tp_delete_empty() on a tp this thread never created. For
classifiers without a delete_empty callback (all but cls_flower),
tcf_proto_check_delete() removes the tp unconditionally: a live tp and
all its filters are silently lost while the owner's change() still
reports success. The race is reachable because cls_flower on
ingress/clsact qdiscs runs without rtnl_lock and can interleave with
rtnl_lock-holding classifiers such as u32.

Fix this by making tcf_chain_tp_insert_unique() report through a new
"inserted" out-parameter whether tp_new was actually inserted, and
gate the errout delete_empty call on it instead of tp_created.
tp_created itself must stay set on this path: the chain reference was
consumed by the destroyed tp_new, and errout_tp relies on tp_created
to decide whether to tcf_chain_put(), so resetting it would underflow
the chain refcount.

Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 net/sched/cls_api.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index fee4524ad..9ceb2b538 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 						    struct tcf_proto *tp_new,
 						    u32 protocol, u32 prio,
-						    bool rtnl_held)
+						    bool rtnl_held,
+						    bool *inserted)
 {
 	struct tcf_chain_info chain_info;
 	struct tcf_proto *tp;
@@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 	if (tcf_proto_exists_destroying(chain, tp_new)) {
 		mutex_unlock(&chain->filter_chain_lock);
 		tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
+		*inserted = false;
 		return ERR_PTR(-EAGAIN);
 	}
 
@@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 		tp_new = ERR_PTR(err);
 	}
 
+	/* Tell the caller whether tp_new was actually inserted, or an
+	 * already existing tp is being returned instead.
+	 */
+	*inserted = !tp && !err;
+
 	return tp_new;
 }
 
@@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	void *fh;
 	int err;
 	int tp_created;
+	bool tp_inserted;
 	bool rtnl_held = false;
 	u32 flags;
 
 replay:
 	tp_created = 0;
+	tp_inserted = false;
 
 	err = nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
 				     rtm_tca_policy, extack);
@@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 		tp_created = 1;
 		tp = tcf_chain_tp_insert_unique(chain, tp_new, protocol, prio,
-						rtnl_held);
+						rtnl_held, &tp_inserted);
 		if (IS_ERR(tp)) {
 			err = PTR_ERR(tp);
 			goto errout_tp;
@@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 errout:
-	if (err && tp_created)
+	/* Only delete a tp that we actually inserted ourselves. When
+	 * tcf_chain_tp_insert_unique() raced with a concurrent insertion
+	 * it returns the existing tp; tp_created must stay set then (the
+	 * chain reference was consumed by the destroyed tp_new), but the
+	 * existing tp must not be deleted.
+	 */
+	if (err && tp_inserted)
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
-- 
2.50.1 (Apple Git-155)

