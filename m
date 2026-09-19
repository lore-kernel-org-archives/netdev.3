Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399F388E7E
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859091; cv=none; b=ra+9wCfhBItUPM6xuuBSb9nCWlOPS2aMpzSJcGGpxBdLM5E3tVGFGSsMAcu187HykHqHhcSeLPTdXe/NbmizXphxGmLQZZW9IOXjmKfY7sBfs3zkIfsFIGCELttwJOYmVCx2pX9w2+NSakUT9rpVmNcCDzSAHqRaPG0i2HnYv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859091; c=relaxed/simple;
	bh=o7eyzul9Ohto3SjJ1TjrNru05AlMn/q7uF2xYm0ObJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoGfwYaemabj4c4yZlWYDnjMHhxKkT74hhSvJyA19fVT4rR8mGDGFhv4h13F0L9eeaNeh3wxmooY+49Ehyx9Hq4AnD3E7OFoyZc/8Xgyt3p8jkyiJSCvNdPnJl3tjX1zr4efnk1PhUG+Nqjq8+5y1B6ODv4SRPhDWP8eK/zuVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QVHW8wIW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="QVHW8wIW"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1557516a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789859089; x=1790463889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jc3gDMyaBCto+VsuPbgbYFUXbxOxRWBOoYdGU5Q+cSQ=;
        b=QVHW8wIWPpBUDyd93nUxd9O+AN+yY58lACdLmRlKNnU5l4sFMJ3Ym4n/e+nik5r/o8
         jOSHmI1Qgh9HmI7MrzHCvvybAowhx+7Xfr58B8MvbemeoOLdfJNas0XYhPBUGRmqd0Zu
         DVVD2+bgAqkWa/nQ/sJm+gtL/SBKmCjO0EnTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789859089; x=1790463889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jc3gDMyaBCto+VsuPbgbYFUXbxOxRWBOoYdGU5Q+cSQ=;
        b=I1MdaKjmcSGHMIpEeaq8WafUIPkKHhVE6vMlVXYH6CjFpGzMR7NvGwgQ44rq80/yNI
         CFZdi/Is590ocSeBqLPNBIuyCierPlfUQVnFBDT76pDbjJfokOaH0/67Cqf9DA+xXOSB
         rmuVuq4CiQUNzuuIE23j+d+y+DuF5f9qOQ3w58FXH8vMF/vq3CFQmiW0M/6r0OoEE4AR
         B8fS6sXuDPFxPQJJ7kYvNBGD5JcYtGfZlAeaVh6Kr5bq96xGRIJvO+TDsl+njT6Tt/Td
         Pd8sDkyCc9fh9VQzgd5KoFjs7uLfZjYEtIwCe7YV3YV7Gh8ZS3Zavg4oH0uhg43SrC44
         r/Pw==
X-Forwarded-Encrypted: i=1; AKwUvBwFto9gev3NAs0nPYsDs+qhEXm9Iw415uQC5PZdeWaAA3qvZSZonxu+9rOFAva6mDw8uIejByI=@vger.kernel.org
X-Gm-Message-State: AFuF++n8PVGaW/+bneAaRXbP5SNLqpb5nHTFCYeL448NDB+gmdkwkh2L
	wpOMBH1/xznXkyLzNiL1Uv+4mDyNPDfivZcX+XMCERqw7wTtKfuML/7U/N8Y5oJXQw==
X-Gm-Gg: AYBFou3RBvjud4eFkc99ZYLP8C9E2OtWBQoDco3yd4C7oNPPUwW8kF/UuinbrtcxzlM
	r9IjJ5nfDimabTHXFSp6n5/+uoor7A3/dy2VkV2v+W40Vnuyba/8c+Fcu8sgzubl8nei6n7ICjs
	U8AbLpOTv8vzSSkggQLrUkGQhndkfFq6Jn5feDWn0T09PMScX3qutxejQc980A2M+ebKawFFfNV
	gp68LYIqrZxKmJL7ossoZzUZpEISj9SBewm3J1aDPBwcLQuAEl0lktqBi4isP4GdwFOYoULwdvo
	qWwqpqFf5bysrKrrQ4eLvh/gwNJWaTs3YCFj6wXrg8KNR/w8L09vIWfcrJFn30aDixRq64/Ufo4
	AhTdvdNvIazi/+PJmas7gTDnwhwTbNMgLrx5ktXDYIN4QNvW+FVgDupuFt7YkOG6BBbO8YUuCY3
	ew7CBYvL+xJm1l6OeR7G8t7RFL/pio8AOXu2PHvIk2g6DBTVTLN8Tpc5FQlt7nBCkIBGqvvOLZ6
	fhH
X-Received: by 2002:a17:90b:4cc3:b0:39e:6a7f:eeee with SMTP id 98e67ed59e1d1-39e6a7ff08amr6657476a91.19.1789859088893;
        Sat, 19 Sep 2026 16:04:48 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm8804599c88.3.2026.09.19.16.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:04:48 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net/sched: act_api: budget TCA_ROOT_EXT_WARN_MSG in notify skbs
Date: Sat, 19 Sep 2026 20:04:29 -0300
Message-ID: <QDISC-RYTB.v1.20260918093205@mojatatu.com.3>
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

tca_get_fill may emit TCA_ROOT_EXT_WARN_MSG from extack->_msg.
The string is whatever NL_SET_ERR_MSG and friends stored, so its
length is bounded only by the caller, and nothing in the budget that
tcf_add_notify_msg and tcf_del_notify_msg hand to alloc_skb
accounts for it. The notify skb can therefore be sized smaller than
what tca_get_fill goes on to write into it.

The attribute reaches a successful add because tcf_action_init keeps
going when an action that is not skip_sw fails to offload:

	err = tcf_action_offload_add(act, extack);
	if (tc_act_skip_sw(act->tcfa_flags) && err)
		goto err;

The action is created while extack->_msg still holds the offload
diagnostic, and tcf_add_notify echoes it back. A pedit action with mixed
key commands (one SET and one ADD) takes that path: the non-bind
tcf_pedit_offload_act_setup sets "Unsupported pedit command offload" and
returns -EOPNOTSUPP.

In practice, no underbudgeting has been observed because of this, and the
gap is not easy to reach given some other spots account for more than
necessary. However, for correctness, budget the attribute so the size
handed to alloc_skb covers what tca_get_fill can write.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_api.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3f653721c45f..db06ddcf6ae6 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -475,6 +475,15 @@ static size_t tcf_action_full_attrs_size(size_t sz)
 		+ sz;
 }
 
+/* tca_get_fill() may append TCA_ROOT_EXT_WARN_MSG from extack->_msg */
+static size_t tcf_action_warn_attr_size(const struct netlink_ext_ack *extack)
+{
+	if (unlikely(extack && extack->_msg))
+		return nla_total_size(strlen(extack->_msg) + 1);
+
+	return 0;
+}
+
 static size_t tcf_action_fill_size(const struct tc_action *act)
 {
 	size_t sz = tcf_action_shared_attrs_size(act);
@@ -1980,7 +1989,8 @@ static struct sk_buff *tcf_del_notify_msg(struct net *net, struct nlmsghdr *n,
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
+	skb = alloc_skb(max(attr_size + tcf_action_warn_attr_size(extack),
+			    NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return ERR_PTR(-ENOBUFS);
 
@@ -2078,7 +2088,8 @@ static struct sk_buff *tcf_add_notify_msg(struct net *net, struct nlmsghdr *n,
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
+	skb = alloc_skb(max(attr_size + tcf_action_warn_attr_size(extack),
+			    NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return ERR_PTR(-ENOBUFS);
 
-- 
2.55.0

