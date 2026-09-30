Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB4364931
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786443; cv=none; b=g81wLPsqNCNlpmSYkXEq1ASG0kQsZWD5fc2jZQYj/zC4B5dhVm4oqD7YYQ+9rFyolAOGKszSAaXRHk9As3n8LtsUJQL7vERRtdEqJHw8WJahrMEiwVMT/sVvfEu3L/DWZQi3uYHPpN573IQ9o3A/QY8QCTh3gjJyT9dpVuXsifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786443; c=relaxed/simple;
	bh=IGjKYCcj33wJ8f6hSu4GlUqk6V+8agpe53HSKiZNqmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPBbLRTiqQEiuk/IU4Dl2rbgowiESJ2kAfUya0reeJ7piXsRys86jTg4W/bT1z+2PBoUphoxf7vbrou+ompAZRw8JqSWJ+9XVBCLvxKPBKsdBKAsMN1E94QTHKZYWEy4/wVC7xySvsSpdEioW6VsfwYyPmGwoFFdhgNtLVlyk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2IHtmWO; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2IHtmWO"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc790c60953so1213660a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786440; x=1791391240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWp0mZm/dpV9j6Y/XOFxLUMhWESv+JE7A5/M2q1MLDU=;
        b=s2IHtmWOrjxcHC7VTQB5V5ytGNHG3JxXOcHTfKmBWPgCg2GZOuaUZcgSN4nLoMWnNs
         +nAsWORq+nYlTsGh9fxAdb9nW7p3z7UQcvyFUnU6nM+vqnh4FjqgoqjV5kq80eMBtQCS
         zVGWWG3d+xjqmdoWW5bnTikhXTmd/v2sj5HnCsPdaulQzNBr9y8nBhFfGdqnIseclEaJ
         UqgeWwxsIeYV/NeeTI8HL+5mNvpZtCZkoUMroR44VKgHxf1nATeJR8J6Oe9JjubutuXW
         gdm+vh/S4fqQqA1KyTvPqvMXKDj81N2BltfGNEcyesRRoE3NHYDRooRlTVdS+THYfPXX
         p7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786440; x=1791391240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWp0mZm/dpV9j6Y/XOFxLUMhWESv+JE7A5/M2q1MLDU=;
        b=VWZ3fsAVd0Ovhou1BSTK/58w6V2ICn3wdoI5MKq9cmOtx4z5WB0PxrD1o4Ae2aADVs
         atZf+6YKTq92f6jvZ+fwUcaCY2xnEjFRv5DTo75hrtQ/6+q0OI6iWSgZM6h2maSjdCrd
         iAB8OBsiPYeGpblu7/eBcwENJxcnJZ0BSofbowwP2cjMJPCK4I8+5ujvG3saNT2EmOzH
         lnrkpd2QbwZuIzyksC6yUl0/c555Vr56FpnjpCXfqkfNfjVyhzi1hGCH+lEVUZa49TQ3
         e7iPdIk4Cusnwx/6JXCNsQV7Jua7iR+J7id6d8dsQcX0e8YkpvvR6Rb6ZlMEC1eCXxy8
         EniQ==
X-Forwarded-Encrypted: i=1; AKwUvByoBa4bNzDbId28XFmVHMR5NGuVOkdZVn6xARqauUQ7yXHw2HaFodS85ZCh+VJpzMuKs3a4d9I=@vger.kernel.org
X-Gm-Message-State: AFuF++l/H1bJecDN3aznBwr/NI9t6HgM3aBrgHNt7fTHmMYKw+VggUy0
	af8AeC4C8PNwka5VTnpGpmYxVcDytn1MJ7MIcg6J5LBJzhhYxKeQauV4
X-Gm-Gg: AYBFou2U7a5gQa4NS1JjGRdOmEJEII4na4L+Mayxuu8v6XxOoha9C4ScLP3RDm3rkGM
	rQmEKq0+6D6/hNawLaSEBTUSceIm9awhqEeWkQmxqKefLyR4XmQA+MJXoc3H7HQKyVrCcYZSSUV
	VLvmnC4WGuL/uWiY3ow1wZe9RFJV4mHiRK9rY0RprCMXCsqx77H65x4Dc1PEU6M/eto1W/jd8/v
	Bq72MGI3QCvnQODlgT6kkFfekYBZ1dkeBheZ9ArjGvbgn8s/xdL4rjGt+/o1PM5CeZbjutapYpc
	UZsidoCXGBpFpZm/kNrzTCFnplkbAJ8RSd4t9NLM2n/4xMK+Z25HUc3TsVerujS9eJmi/IecLnJ
	wwb2VVDRygoYlrz81a1vTo03tXcJFZikhdj++vvh8/anUNG6gR63T0DkCrpKYeuBCT//c6qxCu7
	vqcWwntfGdNgLq5vUIs31qdxBLD4hh6ADbRzlgq+7XwDAD0DUtbBpPSViwULm3QqaSf4WXURDcw
	aYa8E9FdSEB1fTdQ9/b7r6pyA==
X-Received: by 2002:a05:6a20:3949:b0:3de:3d35:c646 with SMTP id adf61e73a8af0-3de9e01da33mr1932270637.4.1790786440522;
        Wed, 30 Sep 2026 09:40:40 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([120.235.123.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e54a4121sm168735a12.20.2026.09.30.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:40:39 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v3 2/2] bpf: reject incompatible protocol changes
Date: Thu,  1 Oct 2026 00:40:20 +0800
Message-ID: <20260930164020.41006-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930164020.41006-1-shlomojune6@gmail.com>
References: <20260930164020.41006-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb assigned to a socket by bpf_sk_assign() can later have its L3
protocol changed by bpf_skb_change_proto() or bpf_skb_adjust_room().
Without revalidation, this bypasses the assignment-time family check.

Reject incompatible protocol changes before modifying the skb, including L3
encapsulation and decapsulation. Reuse the assignment family predicate and
preserve the socket assignment when the change is rejected.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Assisted-by: LLM
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes since v2:
- Check compatibility before changing the skb, preserving the socket
  assignment instead of calling skb_orphan().
- Cover L3 encapsulation and decapsulation in bpf_skb_adjust_room(), as well
  as bpf_skb_change_proto().

Changes since v1:
- Revalidate prefetched sockets after bpf_skb_change_proto() changes the
  packet protocol, closing a bypass of assignment-time validation.
- Preserve compatible dual-stack assignments and release incompatible
  assignments through their existing skb destructor.
- Split the fix into two patches and target the BPF fixes tree.

v2:
https://lore.kernel.org/netdev/20260911172313.64009-2-shlomojune6@gmail.com/

v1:
https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gmail.com/
---
 include/uapi/linux/bpf.h       | 10 ++++++++++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5d8f5e2c8db38..d1897ee13a66c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2659,6 +2659,11 @@ union bpf_attr {
  * 		checked and segments are recalculated by the GSO/GRO engine.
  * 		The size for GSO target is adapted as well.
  *
+ *		If the skb was assigned to a socket by **bpf_sk_assign** and
+ *		the requested protocol is incompatible with that socket, the
+ *		helper returns **-EAFNOSUPPORT** before translating the packet.
+ *		The skb assignment is preserved.
+ *
  * 		All values for *flags* are reserved for future usage, and must
  * 		be left at zero.
  *
@@ -3067,6 +3072,11 @@ union bpf_attr {
  *		removed from the packet. This handles cases where all tunnel
  *		layers have been decapsulated.
  *
+ *		If an L3 encapsulation or decapsulation would produce a
+ *		protocol incompatible with a socket assigned by
+ *		**bpf_sk_assign**, the helper returns **-EAFNOSUPPORT** before
+ *		changing the packet. The skb assignment is preserved.
+ *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
  * 		previously done by the verifier are invalidated and must be
diff --git a/net/core/filter.c b/net/core/filter.c
index 5f64065523584..09816da113554 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3549,6 +3549,12 @@ static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
 	return bpf_sk_assign_family_ok_proto(sk, skb_protocol(skb, true));
 }
 
+static bool bpf_skb_proto_change_sk_ok(struct sk_buff *skb, __be16 proto)
+{
+	return !skb_sk_is_prefetched(skb) ||
+	       bpf_sk_assign_family_ok_proto(skb->sk, proto);
+}
+
 BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	   u64, flags)
 {
@@ -3556,6 +3562,12 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 
 	if (unlikely(flags))
 		return -EINVAL;
+	if (((skb->protocol == htons(ETH_P_IP) &&
+	      proto == htons(ETH_P_IPV6)) ||
+	     (skb->protocol == htons(ETH_P_IPV6) &&
+	      proto == htons(ETH_P_IP))) &&
+	    !bpf_skb_proto_change_sk_ok(skb, proto))
+		return -EAFNOSUPPORT;
 
 	/* General idea is that this helper does the basic groundwork
 	 * needed for changing the protocol, and eBPF program fills the
@@ -3699,6 +3711,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (inner_mac_len > len_diff)
 			return -EINVAL;
 		inner_trans = skb->transport_header;
+
+		if (!bpf_skb_proto_change_sk_ok(skb,
+						flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 ?
+						htons(ETH_P_IPV6) : htons(ETH_P_IP)))
+			return -EAFNOSUPPORT;
 	}
 
 	ret = bpf_skb_net_hdr_push(skb, off, len_diff);
@@ -3786,6 +3803,12 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	if (decap &&
+	    !bpf_skb_proto_change_sk_ok(skb,
+					flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6 ?
+					htons(ETH_P_IPV6) : htons(ETH_P_IP)))
+		return -EAFNOSUPPORT;
+
 	ret = skb_unclone(skb, GFP_ATOMIC);
 	if (unlikely(ret < 0))
 		return ret;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5d8f5e2c8db38..d1897ee13a66c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2659,6 +2659,11 @@ union bpf_attr {
  * 		checked and segments are recalculated by the GSO/GRO engine.
  * 		The size for GSO target is adapted as well.
  *
+ *		If the skb was assigned to a socket by **bpf_sk_assign** and
+ *		the requested protocol is incompatible with that socket, the
+ *		helper returns **-EAFNOSUPPORT** before translating the packet.
+ *		The skb assignment is preserved.
+ *
  * 		All values for *flags* are reserved for future usage, and must
  * 		be left at zero.
  *
@@ -3067,6 +3072,11 @@ union bpf_attr {
  *		removed from the packet. This handles cases where all tunnel
  *		layers have been decapsulated.
  *
+ *		If an L3 encapsulation or decapsulation would produce a
+ *		protocol incompatible with a socket assigned by
+ *		**bpf_sk_assign**, the helper returns **-EAFNOSUPPORT** before
+ *		changing the packet. The skb assignment is preserved.
+ *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
  * 		previously done by the verifier are invalidated and must be
-- 
2.43.0
