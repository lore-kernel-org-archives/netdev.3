Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA503630B3
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171154; cv=none; b=FiY7Xkz3Gn0VHZPUVA9zgDlCfg9qdnDvOqgMSaIMSgm4JWNHfy+8H2y9Q5qx1XJ6WbWJlSmo1PlAC+Mb68oiJbNjyl3g0QpSvNL+JSS0PjgoKRGGrUkVn1/trrFEVOg9zYkezwrKgodK1vqjlLmcHGv2k1i63ujkSTRPQm9+7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171154; c=relaxed/simple;
	bh=28mYL3Lpwu3cxNp3BKf5OFpErl2QysMYNAuhyXksd64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWQdLB8Wp8EQEAHKQvpC4S4HMQGR8pd0M7w7vtu3vRqopBWD6nuccLAwrzXtYCOGJgcV3RpP1p8FSiLImLmTYe73Xo7XaVdgvRnz+01dfomnKIdltnXPGPqnTX5Dyuv2kQN2cN+Hy1YmWiwnRCLEWEmYQxwr6afikMRmx1uduto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N84Pfh72; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N84Pfh72"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1968609a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171152; x=1785775952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbY2FkB7Qtb5HREQNBKS0RYAbr/BIveiHku6ZtStcWw=;
        b=N84Pfh72i9ADT4a5rReG+j04AEY1mBY3mBtI6IBDw7bghrpUewLn0GqgcDDymBDzIA
         Czm9mRD+zRadrRjuRJ2FWQQJVviJGyeyWxmkL8+mQJyNhi4/cWVcfJgpJApsnvyd3ace
         X5sSvFg5VREJ0ao7JSmCCyfBTQ8ycYwIZ3MOO5jRBcqGEfUtRK5zwsl1HV0HO66w0cAB
         Xic7ga+1AgUK6RZN95llJA3dcL9w0mBIuwT+J8/9UCTo3anItkKdEe891a/SW1NGi1Zb
         1Y5pg5+FZ7vImY4AnxwFcGtZI1/kML4KQlkL7avAQ9BiZ7ehb6IjKdkGqhNmOYtltPG2
         aLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171152; x=1785775952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbY2FkB7Qtb5HREQNBKS0RYAbr/BIveiHku6ZtStcWw=;
        b=rbHu1gpR+fUkIsRDWNStz+R9RAp6SwM3Z0DuMoQ2U10BT7DTpVlekhzsKQf6mwz7pc
         zJuww58mQjZI9oaiARr+zyrMKor1+P7uqp6jphUDFHFWQA/4T6hhzzKTdWXZ/JqEByDn
         sFx3BfYv5a6sCJHJg9A+VevCryPjvRCqpjivL3T0uMbaZbVP9/fj6BodZy6V18bD9qOX
         rhsLL/IUSlXK/CxAR8vW+YMbU5qem9Xml/1U8pZ02Iwx/YjTLXnbTCEoaChvV04Nc6ym
         P5AJYg+JJoC4h53ptpAXgfDzMXVnPVGu1Fd5o6IHwLm/Ij3xgJHfffK7Oourf93LPBOM
         I2Og==
X-Gm-Message-State: AOJu0YxaRuRT70xKDdL6gK1mg58E9wgDFz9MefvfAKl0B5O7ngGmeM2o
	okVxQC2E1A94Fp4N/VcFQW8KJQ6Yi80LO9+3ntMpTsZ2f3AhBzYR14NEkrO1iq6yDmM=
X-Gm-Gg: AR+sD12HdHv4QlFdbB0BRK7Y27KrFwYlmY2s68EzQnqVzCF7ZZ65B6D7pdZQo0K37ga
	7273q7h2lEeWYnamLdum4fBSmS7k+Cd1ut+z5P+83oeG4ATte38hhSxmHd+wcMqTmeY13Kyn5ZE
	QMjHP4DYwtpkuTxVVGqHypQBjUU/yL9FUQi/4EAtKTQa5CX4RnnAnIedbjD/VE1kiqglW0xMAQP
	7XFcga6XKVXn9HFcmEBzEy3xOfCR1TkL5ni8Zv4nJsnLKrd1Z7d8H3laHmtAv0Gb3GdSCjz5o4z
	LpJrb8FRE7hP+AQIlEzT+3TvckDNqL0XNiRoaRK074ar61MTPgVdhbQdVPV/pCmATYnmYyPS68G
	dd6PDYctPnq/+X2x8kbw7xH+VJRCggWWN+U2H+H21mzC7CKB2NQNY27TX/RIPhhYWOPvTLu9jdw
	fwFsjxnY5u6OQdV8lmqBui
X-Received: by 2002:a17:90b:4a48:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-38f64bdff11mr47629a91.9.1785171152335;
        Mon, 27 Jul 2026 09:52:32 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412acd7sm108735a91.6.2026.07.27.09.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:52:32 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	joestringer@nicira.com,
	pshelar@nicira.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: openvswitch: reject mismatched flow IDs
Date: Tue, 28 Jul 2026 00:52:21 +0800
Message-ID: <fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784881178.git.zhilinz@nebusec.ai>
References: <cover.1784881178.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

ovs_flow_cmd_new() looks for a duplicate flow before deciding whether the
request should insert a new flow or update an existing one.  When the new
request carries a UFID, the function first looks up the UFID, but falls
back to a key lookup if the UFID is not found.

That fallback can find a flow which is identified by a different UFID, or
by its key.  The update path then replaces that flow's actions even
though the request identified a different flow.  If the caller asked for
an echoed notification, the reply skb was already sized from the request
identifier, but ovs_flow_cmd_fill_info() serializes the matched flow's
identifier.  A short request UFID can therefore make the fill fail with
-EMSGSIZE and hit the BUG_ON() in the update path.

Track whether the matched flow was found by the same identifier as the
request, and reject updates where the identifier does not match.  This
keeps OVS_FLOW_CMD_NEW from retargeting a different flow and avoids
building a reply for an identifier that the skb was not sized for.

Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/openvswitch/datapath.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index eaf332b156d73..1637420f854d5 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1010,6 +1010,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	u32 ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);
 	int error;
 	bool log = !a[OVS_FLOW_ATTR_PROBE];
+	bool id_match = false;
 
 	/* Must have key and actions. */
 	error = -EINVAL;
@@ -1075,10 +1076,17 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* Check if this is a duplicate flow */
-	if (ovs_identifier_is_ufid(&new_flow->id))
+	if (ovs_identifier_is_ufid(&new_flow->id)) {
 		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &new_flow->id);
-	if (!flow)
+		if (flow)
+			id_match = true;
+	}
+	if (!flow) {
 		flow = ovs_flow_tbl_lookup(&dp->table, key);
+		if (flow)
+			id_match = ovs_identifier_is_key(&new_flow->id) &&
+				   ovs_identifier_is_key(&flow->id);
+	}
 	if (likely(!flow)) {
 		rcu_assign_pointer(new_flow->sf_acts, acts);
 
@@ -1113,9 +1121,12 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 			error = -EEXIST;
 			goto err_unlock_ovs;
 		}
-		/* The flow identifier has to be the same for flow updates.
-		 * Look for any overlapping flow.
-		 */
+		/* The flow identifier has to be the same for flow updates. */
+		if (unlikely(!id_match)) {
+			error = -ENOENT;
+			goto err_unlock_ovs;
+		}
+		/* Look for any overlapping flow. */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
 				flow = ovs_flow_tbl_lookup_exact(&dp->table,
-- 
2.43.0
