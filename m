Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283236;
	b=LS7/VHXNu0qe+5Iy0veqZrVtaepGbiaKBi5R+dIxtG9nstzCIpezoufwC/pxuF0DztfZ
	 oavopkGMjvzEB/Ofy34WIsb6q8rmgAE1y2vfGXU1KDxdg3oIiGTmnudkShGFCzdGARZIU
	 UEeh9+m5d1Em3Ip6IaUDFAPFserzkXhm9n99NT1IH2Wr61tymNcGyAsnKERFnDFzq1FYd
	 QFE8gw2PU9EGPzlEdPwvhdS32g89MXDBsLqns/KMr8NouaZ26lXbm4fRGig6YLBy2h+/u
	 sgD+s6urHnHbXmATVU45mTL105BMMhIvTmLt3fAKW+Q+oGdMmI7Z55OqtlrY93aisMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
	b=YnZpqp1GdVfdZzq+CjUJDfgWha0txrWb3tYLawN/Y9xCuTvn4k9KcTtlTQJlEFF77YxU
	 wwJ6/afCpDxGldO4ehtWFahht0gLnhIWtXzow55L7wpoP6n9IVOD7rnlzrfGFAgRrto4x
	 jiBmX25Fy5x1xuBCIh7Uz38YWq1odTj881RaI93LGVO559bBVmwxvQUcqGzip8aR7KJ8W
	 aG6LbWPn/J6v5IyqOcZO4sn8rPdQwGRU043b/QLCAI19wVxrspezN2PQ3DK+ygvNEdpJs
	 3nlSZ+F8WULgHNxfdrlYvJayNctJJU6AG84JJY7L07A5/e7yGt6oytd+Glvo0FRcJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4tltNeF;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3361606A32C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3361606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4tltNeF
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a8cc11ac42so837142c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283235; x=1793888035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
        b=f4tltNeFTKLnbUz5fjFCsuUFaUTE4hef8VkRvpIXiFKDI+Q+4y4RSyo2uDZaO4cFqS
         hsX2K4LGItbsDAeTgBApvLi7AwGt4HD6ojALeFIrXlX0nSvztfjEyqHA2IH89+Ky2F9p
         3tdARLW2Y/G2DTpZmFgXa2rTTRzRmZxzUl+1rFgB8sPVOHwlsCbm6jgfq0H2qb6c6R2d
         isdQ9G/JcfhnYNrIkmftITH3EeFMIqEdIxtTFBeuDq1KcowgrZMxo7fNCZ836RU/iIjO
         LOkkKQE7j4QvBAiK3GAFXIJF0cGfkHwvJRVTcZQD261r/+cI6bCH3IeFhnSTOwWtGpAo
         K8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283235; x=1793888035;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3r+oUtLtuj/VEdpEb4bPGrKTCpCHtCaw4EjdujKT3MA=;
        b=Am0orupgF1jaznpzHNxRscF4uAsmZtAE/6nX6G77NjZq+LQLO3FEPvzdCHNYJeswjj
         T/OmV2Q88FwN5yCr1XGSpkyXqTtRYzFkF58M7gBblfvWC61CJ/mIwR+0J9jfCaEDYF/l
         GlUVYgcMWsKQvIZFxzaULKuzIRgbW2o/1mTu64fjNhCVxqRp0C0g6oDf8fIInFq0UN0O
         2yWK4AMBbQnA3LJO3/hUbkCOkjpKIJNtJF7UwlMfh/6L45VFZ7dO8kxXSJPsJKe/zkp4
         vefi3ySCBvd2KTqyNQtckUcCSSiA590Ub+PmM85SOxjHBeIEPJsfnixmJNowaLqlE94s
         OK+w==
X-Forwarded-Encrypted: i=1; AKwUvBzUTgJYdN2jM4zPkpjQHdTjjeZiftX37ZdWPsfMidwcY20Vsbbn46ec+AM9zaOPpvlJASP2oDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2PpmIrd2GX4Pe9WmhYkxaF2/dvqW5KRu/TlQpWXieIAmBdV/9
	RFyQMi4KVPbmQJUsUd2FpBSvZA/mRDdkRlhxfYXGfuk+EkeqwhEZjhPq
X-Gm-Gg: AYBFou17BC6NDCfdSHHK4/mxgf9zPrAj3GKAubnHzFjPotOwh2siPK2So60YJJa+sRk
	7ieiwdV2tiLOjldjA5vae6gx6ZdCl7Y46EtFrwkTMJ1YN4gDQ1Zise496w5o4R9HF+5KIdjCM8T
	7lNG6C1B35dkWsswW1WPC2x7fWJhP/6wEo7Ex8d/ybmIWVgpBDa/OzQgC8ZNsz+i5VpQEz7jjB1
	E6UgVstPJ2wEeTpB2euVPfL0PriQ7RurO9HfKI2y0t9gIsRPIOT4+By0Zl4JYHQZky35zOSCq8T
	RtyHsMlVbeSIZ3BvYnAmJ0m62ShYc6yWzXuuVw0J/gVtiM1uzkxMn6Aex4Mw4PNwWLcjJqKwX/m
	aSphMNJK++eikpl2VACky3o4EKHgndXF9cGkgNOg0O3ma/xSo4xRsPjdmZngW9cbecgGIJAlH2R
	FoHhgs6HFbw1tFBJzfbTBxMU9r2W0HKozdJdpdJZnHp5DOyrpHHQjO/aziFejNQUT2OabKIn8BO
	aVjwI+WYkhWB8+SDfiPIUGT0h9CaB0Q0IHM4JJ3wKOOH0cbOJmkvIOhWvENYC6kqJQJnbp3trPw
	WM+j1rj1XKD0AeLE+Hl/eJNN64ZJBbsMDC77W/iIMFZtRHCAAHHBNQ==
X-Received: by 2002:a05:7022:6b96:b0:19a:51da:f54f with SMTP id a92af1059eb24-1a6cd498fffmr10891624c88.14.1793283219708;
        Thu, 29 Oct 2026 07:13:39 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:38 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To:
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net] net: bridge: mcast: validate the source limit before replace
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314075.648427.9644307795980106759@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

br_mdb_replace_group_srcs() marks every existing source for deletion and
then re-adds the sources named by the NLM_F_REPLACE request.  The add loop
checks PG_SRC_ENT_LIMIT before allocating each new source; if the
transient source count reaches the limit, br_mdb_add_group_srcs() unwinds
by deleting every source it processed, including the pre-existing sources
it just refreshed.  The error path only clears BR_SGRP_F_DELETE and
cannot restore those sources or their (S,G) entries.

A replace with E existing sources and N distinct request sources not
already in the group fails at the limit if and only if E + N exceeds
PG_SRC_ENT_LIMIT.  The rejected request currently leaves the group with
one fewer source and removes that source's (S,G) entry:

  before: (*,G) star_srcs=31, S present, (S,G) present
  after rejected replace: star_srcs=30, S and (S,G) removed

Count those new sources and reject the request with -ENOSPC before any
source is marked deleted or added, so a rejected replace changes no
state.  Valid replaces, including ones that transiently reach the limit,
keep the same behavior.  Other add-loop failure paths are unchanged.

Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_mdb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0adcd15..f5b9df4 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -925,6 +925,24 @@ err_del_group_srcs:
 	return err;
 }
 
+static bool br_mdb_src_addr_is_same(const struct br_ip *a,
+				    const struct br_ip *b)
+{
+	if (a->proto != b->proto)
+		return false;
+
+	switch (a->proto) {
+	case htons(ETH_P_IP):
+		return a->src.ip4 == b->src.ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		return ipv6_addr_equal(&a->src.ip6, &b->src.ip6);
+#endif
+	}
+
+	return false;
+}
+
 static int br_mdb_replace_group_srcs(const struct br_mdb_config *cfg,
 				     struct net_bridge_port_group *pg,
 				     struct net_bridge_mcast *brmctx,
@@ -932,7 +950,38 @@ static int br_mdb_replace_group_srcs(const struct br_mdb_config *cfg,
 {
 	struct net_bridge_group_src *ent;
 	struct hlist_node *tmp;
-	int err;
+	unsigned int num_new = 0;
+	int i, j, err;
+
+	/* Sources that already exist in the port group are refreshed, not
+	 * added, so only the request sources that are not in the group yet
+	 * consume a new entry.  All request sources are added before the
+	 * sources that are not part of the request are pruned, so the
+	 * transient source count can exceed PG_SRC_ENT_LIMIT even when the
+	 * resulting source list fits in it.  br_mdb_add_group_srcs() would
+	 * then fail with -ENOSPC and its unwind would delete every source it
+	 * processed, including the pre-existing ones it just refreshed,
+	 * which the error path below cannot restore.  Detect this case
+	 * upfront so that a rejected NLM_F_REPLACE changes no state.
+	 */
+	for (i = 0; i < cfg->num_src_entries; i++) {
+		struct br_ip *addr = &cfg->src_entries[i].addr;
+
+		if (br_multicast_find_group_src(pg, addr))
+			continue;
+
+		for (j = 0; j < i; j++)
+			if (br_mdb_src_addr_is_same(addr,
+						    &cfg->src_entries[j].addr))
+				break;
+		if (j == i)
+			num_new++;
+	}
+
+	if (pg->src_ents + num_new > PG_SRC_ENT_LIMIT) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to add new source entry");
+		return -ENOSPC;
+	}
 
 	hlist_for_each_entry(ent, &pg->src_list, node)
 		ent->flags |= BR_SGRP_F_DELETE;
-- 
2.34.1

