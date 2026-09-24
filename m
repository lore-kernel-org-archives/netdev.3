Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FF40BCC2
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252337; cv=none; b=RABhKCjafeAdLjbrdjZjQ2w3wm6meHh9GloCUdY6lFk0WjC8k49saa841gwFw1Cp/FQEqdkuYTa2VduyZ7xfyH49adWg4ru4U51UZ7iZbNUi56zV4ZFA/l4Vg/j49enqS1VuSjN3Fj00qVYE5Ktw3Mt/Fp1OPeHLwGnnp2YDgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252337; c=relaxed/simple;
	bh=r6xTkVcBtG2GbnncVAFpPrHQ35sSsx6sGtwnGz+Iz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6EtKJGyhUE51fN2JvRBqKBVBm6COsi4CU2p19/HL22yhifDXwLqVcP23wKrzNBR/voMzzkshlj3B0N8pLX8tgSyWLYRqhSH6FtbYMD629WUzWV5AdYtrYguY8pZtTxtgvbserg0Jt2hF97WXOA7MdOMGGrOsbb5fZSDGsXn+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ns1NFVpf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ns1NFVpf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-912431d946cso6229016d6.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790252334; x=1790857134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmaeWywR1Hqkr2skYxuhciXOKcGLeDQxbIygjuGwII0=;
        b=Ns1NFVpfyd7n1KdYeOeh7plXI8koMoK8853qbCtzQ8DDNuKIhEP2bGlZeU9BF8zpRb
         wFvbDiTE89WFSJpSpmD8FePIoJEjmZPcBt9RjAL3yMFYKu8EEwM4Tah3VeX2hnKvb/Rk
         ZtXCcLjBLj70HZYhKSPzMMb6lICU0sa0lCIt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252334; x=1790857134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmaeWywR1Hqkr2skYxuhciXOKcGLeDQxbIygjuGwII0=;
        b=hzeUzH5Gj+/ioF5quF3ilRE69oXLjDlNuyuzoYUFsn86d2AFlasyRO4trTyfaCnF83
         78O/ky6fyv3bYoUvkwpJsRU6aqE+fMxSLnU42/Uu6dsK4Akuca3LTSqXgmhwhcGMaHCq
         HvqCLNVGzI8KW7z41jNaEjkB9ruaIx9k4FDJ7Ca2gBXIrMbn9eYxcMmkSZ6aCgq+VY26
         JKPqT56seub0759hdzKX6mKCJJRI9JkWcGNyMJ8iwLdEW/9FNoZ6KoDaxSfrVefeaWkd
         DEPcBBLwCueJd6dBjerJj6ycVo41UgUWcQqHjtxm1NK3ep8ELoCmOrvI9FaX8ezm1kzp
         cQKw==
X-Gm-Message-State: AFuF++mnBbptCQFG01H/ZZ8AgCx8JnrBqWWxBPjloTr3MkCjY1Zt+MRl
	cexh045V41zTAYCeimngUmnuJjBXrfQ99knu/coHmAluetlAGcq7wQwbI6nO52+j2mMvFfE7U/B
	W2b9nYw==
X-Gm-Gg: AYBFou2hKq++Q9P0pzRc+AKd3VBL4A7tnc7O//xm+xaiBNXqjZze6bx4MQPP1qlLt4v
	6KXtlGQ9dmZPkfvdav7EBmqa0Tbj8DZH1wytWWH1qR8msqFwGyfhzr2nl45CzZwd08AqVYmo++c
	9Nne+fGGbk76unfjwbjtsGLIcxmKIY0dXZhgU6ZyNmZJI185sVdpCuYiQfVbrbSs0aNCnLTsnd8
	RTGka8TZoeW+LgYM5vPxl9jBaesUVAUvhWu7/NL5op0YThyGry1eKT7aykWYDodtfuMop6J+hqI
	tJbfh9IcWdBfQ+tuM0tVaqPZRdgnaXzTjC+g4uoM7h4xk3OwkDWj0lkEycgV0O80XKK+e3/aNnB
	sG/qhHXQxCHI6wYjPfHVwiteFsMWUAPPzjMYuXmxhq6+826r/NmySPkHs4Y4psD/OAB6QCCpYBx
	mu7XvA/65Kmxy2Je4odY1amCY6iu7VK5jCYaZUs8vfBX/93KGiql5yBFaRNppJPiizYPO/Dg4gl
	AFams3Q0CRckENtz5SGZ/RHG1cb1Yie1HpP6MB9qWOTlg3MZQ==
X-Received: by 2002:a05:6214:1bc6:b0:912:35b7:8a9a with SMTP id 6a1803df08f44-91421f03ed7mr18489976d6.20.1790252333506;
        Thu, 24 Sep 2026 05:18:53 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e2c6c90sm15211926d6.45.2026.09.24.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:18:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
Date: Thu, 24 Sep 2026 08:18:41 -0400
Message-Id: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
removed the unconditional memset of the erspan_metadata mask in
fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
(v2), then matches every ERSPAN packet's values instead of exact-matching.

Default the match fields on the no-mask path the same way the with-mask
branches default them: v1 index to 0xff, v2 dir and hwid to their
exact-match masks. The union cannot just be memset to 0xff -- that would
re-mask the overlapping timestamp/sgt bytes of the v2 header that the
commit deliberately left to 0.

A mask and a key that declare different ERSPAN versions describe different
union layouts, so the mask would silently wildcard the key's matched
fields. Reject that combination. Have fl_set_erspan_opt() report the
parsed key's version back through a u8 pointer so the mask pass uses it
without re-reading the union.

This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
validate mask pointer after nla_next()").

Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
match mask is zero (wildcard) instead of exact for the supplied fields.
For the mismatch case, pair a v1 key with a v2 mask (or vice versa) and
observe the request is accepted with a mask of the other version.

Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025123.62758-1-ljp1205831794@gmail.com
Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794@gmail.com/
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/179003833955.2160803.1077681716391858800@kernel.org/
Suggested-by: Xin Long <lucien.xin@gmail.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Scope the key's version default to the no-mask path only. v1 assigned
  the key's version to the mask unconditionally, which changed the
  with-mask parse path for a mask nest that declared no version (nipa M1).
- Reject a mask whose declared version differs from the key's; the two
  versions index different union layouts, so the mismatch silently
  wildcarded the key's matched fields (nipa M2).
- Set the key's parsed version through a u8 pointer argument rather than
  re-reading it from the union at the call site (Xin Long).

 net/sched/cls_flower.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1cefea571efd..0c4beff18d68 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 
 static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			     int depth, int option_len,
-			     struct netlink_ext_ack *extack)
+			     struct netlink_ext_ack *extack, u8 *key_ver)
 {
 	struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
 	struct erspan_metadata *md;
 	int err;
 
 	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
-	md->version = 1;
 
-	if (!depth)
+	if (!depth) {
+		/* No mask attribute supplied: exact-match every field the
+		 * key set, keyed off the key's own version so the v2 dir/hwid
+		 * bytes are masked without touching the overlapping
+		 * timestamp/sgt bytes of the union (see 292207809486).
+		 */
+		md->version = *key_ver;
+		if (md->version == 1) {
+			memset(&md->u.index, 0xff, sizeof(md->u.index));
+		} else if (md->version == 2) {
+			md->u.md2.dir = 1;
+			set_hwid(&md->u.md2, 0xff);
+		}
 		return sizeof(*md);
+	}
 
 	if (nla_type(nla) != TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
 		NL_SET_ERR_MSG(extack, "Non-erspan option type for mask");
@@ -1387,6 +1399,22 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 
 	if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER])
 		md->version = nla_get_u8(tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER]);
+	else
+		md->version = 1;
+
+	/* The key and mask must describe the same union layout: the
+	 * per-version default below only exact-matches the fields of its own
+	 * version, so a mask version that differs from the key's would
+	 * silently wildcard the key's matched fields.  A mask without a
+	 * version keeps the historical v1 default.
+	 */
+	if (option_len && md->version != *key_ver) {
+		NL_SET_ERR_MSG(extack, "Tunnel key erspan option ver mismatch");
+		return -EINVAL;
+	}
+
+	if (!option_len)
+		*key_ver = md->version;
 
 	if (md->version == 1) {
 		if (!option_len && !tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
@@ -1509,6 +1537,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 {
 	const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk = NULL;
 	int err, option_len, key_depth, msk_depth = 0;
+	u8 key_ver = 1;
 
 	err = nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OPTS],
 					     TCA_FLOWER_KEY_ENC_OPTS_MAX,
@@ -1607,7 +1636,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			key->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_key, key,
 						       key_depth, option_len,
-						       extack);
+						       extack, &key_ver);
 			if (option_len < 0)
 				return option_len;
 
@@ -1618,7 +1647,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			mask->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_msk, mask,
 						       msk_depth, option_len,
-						       extack);
+						       extack, &key_ver);
 			if (option_len < 0)
 				return option_len;
 
-- 
2.43.0

