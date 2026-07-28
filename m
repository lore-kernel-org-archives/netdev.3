Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCA32B104
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213339; cv=none; b=C4KECo17k19QGhvOKsBC9iNj49bXGjd6YkQFssAuiNQHaokMnwOLHrXbMQzhetner33si9NUR7U7ieHP5RXTgQA6a5UusmtMOmDp57wqOBYXits40Cv69yDZsTEq8nkwt9PcTda9SsXpT9g7MH4Fs+unpxcH2qZTmTAR9c878Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213339; c=relaxed/simple;
	bh=5ck2uzxLvWbwnbM+Br3V7Zi+rYWf/afJxAxS4vPb7cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ek9+MmvOz67OWKggWeaWro6qKg9wenEfoY4CYxXijGgzSSV5N99PI04Zs1UUrud/UAtJtxweOj5hzCrvMwSz6YhdnHYGlnk7+yPf4kyJGzLQDDy0mnbHrSjwPy03uIWdbKey5eMlp80yC7G5fYfdvXvPvPuzOZPwdV+GoR26swE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rP6L00N1; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rP6L00N1"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cab1b0bb489so3302250a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785213338; x=1785818138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRaR+h6Sz/zPP3DxolpgV7C+l0gbk13KP1ViPu/iCPE=;
        b=rP6L00N1YHg6gnzF9X5EcqWMJ9FYPmD1RTaSn4giZ0kbQYPSA4Qgtfi5t99SBtqvb9
         M8Hr6vUnwdPEULTPzrHBx/cL6b753cH+Mt5FCPXQWczDAsdGrHpnYsNd0TMU/Xj2OVO+
         zvBZ01os7Az4Pr2E59kpUdm8B/PqqxsllrybpTuWqAB9VJoqSCVhRomlZb6DlZjKTsJJ
         INESQBk6k4s/j/oKuQB5lWmqmZr6j7SyHD5Xi7Id8tSx3HcayHIqME+qyPXqRqxE7QbS
         04P8pr/VlRp/CmuCpz/97p09CnxMNrcnACyMtGAeHV7Ddvw1pBq/8U21VLblxy8KZk2k
         bMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785213338; x=1785818138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRaR+h6Sz/zPP3DxolpgV7C+l0gbk13KP1ViPu/iCPE=;
        b=AtVzn6+JHQ/IY/hM53bazww7Bj7+DnrVl4fDj8srldPu1V+gMOoLpqAosBVXmM6yAB
         P/nV0+ALXXQfQXEJXKs8ACsTYcPGS5alpw2kycRrXExUSmwoMSsUfSnJRJTpbUuTKILU
         /LCwJv03Zp+qTRnOZzH/+7RKIJcQJukDq7IuYlHzIx0AkqnPm2DWzMOgvNz4H9UZBKs9
         nWE1dsl22D7cRyaOjazC0m6jHiPnuOE65XCrwqnnAKtBYysAUI7iFsYYQakpksUVFwix
         F6SJeg/M6+3Qux9B4R50GZAvfomNqPV/cxmXfmAeKlPU0kd/1CMvLxoTY7k3PVemqeRM
         ylhg==
X-Gm-Message-State: AOJu0YwXHsnfz1EOqlqlosj6hwtOIRqx7WD6xpPbMqZLeUyBguU9mVHI
	n6kirYPdhGdMoHcNyqPFeDKLV6sXyfBkGzRvDYxhDZj8EIPddn+McDXpH6MwcSk7zy33ElVUTQ+
	fVpoFpBjrHThv8Q==
X-Gm-Gg: AR+sD1028GQHF08NymUAem6mZZIR0dKsRcAoKetCCr/kT8RbegrQtrAZcjlIK2SrTnQ
	jYTVtzXytqIadu+06gv3lNpdGpIS/fuFqSaSHV7salM1qrCCfj2LUfUyK7+4zfIbrB48FsRKWl2
	S7zTeD8qS4vwT2DJo3N9MTuZJ3dIlTv2FtbW4ilsQWKzVzMtdyk9uyL+FS3xDDVOuFGfYcyPHJ0
	qrpUXQHigDQQmPnZspZ3bGHFvKcmd2ylIzEL97kQPlO+6pKf3biLnTJbYcqAqHwL/WB/7i7K0Vg
	e+NwS575//e5sflfHz71QtP5fMb7icVcAEkynj4ulq+7ZKrr97tHOd6Z/ByozcYu+fxQRMY8GM4
	lPxHJ6M2FQNEkqqS8/APDqfc4QH0s2oUFmxUljHcBiyNlbkh00KqfVJndHUs2WG2rqaxj5NO8bc
	U/K9QtG4qzrdQEhbZMMQ==
X-Received: by 2002:a05:6a00:813:b0:848:2f77:e2de with SMTP id d2e1a72fcca58-84e93380b96mr790430b3a.71.1785213337584;
        Mon, 27 Jul 2026 21:35:37 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6623294sm3893014a12.10.2026.07.27.21.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:35:37 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	dev@openvswitch.org,
	i.maximets@ovn.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	joestringer@nicira.com,
	pshelar@nicira.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2] net: openvswitch: reallocate update replies for mismatched IDs
Date: Tue, 28 Jul 2026 12:35:19 +0800
Message-ID: <71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_flow_cmd_new() preallocates the optional reply skb before it takes
ovs_mutex and before it knows which existing flow will be updated.

That is normally fine because the skb is sized from the request flow
identifier.  That identifier also becomes the inserted flow's identifier.
For updates, however, a request with a UFID may miss the UFID lookup and
then fall back to the flow key lookup.  That lookup can legitimately find
an existing key-identified flow.  UFIDs are optional and the flow key is
the primary identifier.

For echoed replies, ovs_flow_cmd_fill_info() writes the matched flow's
identifier, not the request identifier used for the preallocation.  A short
request UFID can therefore leave too little room for the key identifier.
The fill can then fail with -EMSGSIZE and hit the BUG_ON(error < 0) in the
update path.

Once the update target has been resolved, reallocate the reply skb with the
matched flow's identifier when it differs from the request identifier.  Do
this before replacing the actions so the request can still fail cleanly if
the rare extra allocation fails.

Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Preserve valid key/UFID mixed flow updates as requested by Ilya Maximets.
- Reallocate the echoed reply skb with the matched flow identifier before replacing actions.
- v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai/

 net/openvswitch/datapath.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index eaf332b156d73..18732337ea5d1 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -800,6 +800,16 @@ static bool should_fill_actions(uint32_t ufid_flags)
 	return !(ufid_flags & OVS_UFID_F_OMIT_ACTIONS);
 }
 
+static bool ovs_flow_id_mismatch(const struct sw_flow_id *a,
+				 const struct sw_flow_id *b)
+{
+	if (a->ufid_len != b->ufid_len)
+		return true;
+
+	return ovs_identifier_is_ufid(a) &&
+	       !!memcmp(a->ufid, b->ufid, a->ufid_len);
+}
+
 static size_t ovs_flow_cmd_msg_size(const struct sw_flow_actions *acts,
 				    const struct sw_flow_id *sfid,
 				    uint32_t ufid_flags)
@@ -1113,9 +1123,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 			error = -EEXIST;
 			goto err_unlock_ovs;
 		}
-		/* The flow identifier has to be the same for flow updates.
-		 * Look for any overlapping flow.
-		 */
+		/* Look for any overlapping flow. */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
 				flow = ovs_flow_tbl_lookup_exact(&dp->table,
@@ -1127,6 +1135,20 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				goto err_unlock_ovs;
 			}
 		}
+		if (unlikely(reply &&
+			     ovs_flow_id_mismatch(&new_flow->id, &flow->id))) {
+			struct sk_buff *new_reply;
+
+			new_reply = ovs_flow_cmd_alloc_info(acts, &flow->id,
+							    info, false,
+							    ufid_flags);
+			if (IS_ERR(new_reply)) {
+				error = PTR_ERR(new_reply);
+				goto err_unlock_ovs;
+			}
+			kfree_skb(reply);
+			reply = new_reply;
+		}
 		/* Update actions. */
 		old_acts = ovsl_dereference(flow->sf_acts);
 		rcu_assign_pointer(flow->sf_acts, acts);
-- 
2.43.0

