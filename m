Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E827262B
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716998; cv=none; b=hF71epkqAQegFYvhYKe643j/jTcRC7qf+R6U5KPDYEJHig6QSfYZoAozI+D9ebl+LcNdRwQFTRIT4G9sWLxjpCuwTKOXtqz/865bqAsx68Npz43XvqenJyUbWTVA1al3NEu19Iy2WAXd8x8qMWvqiSOGecu7+obbFuf7WYBejbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716998; c=relaxed/simple;
	bh=NEgRZTi/F3VisdQag3yj5uF528e4rPxDtR9tU7XeSoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mS/zCTB9WpE2BOYNLVWDFJPGIUyebr8DDfG6+tEp1CZxHPYekkZVeQa9gaI/dgCn7RaaaEmEOZhBMuOJuJ6vbWRh9v2V3yc9Hel3aY1WQiFjD+3qzm0gG7VQNORc1L58tlDHcUUyX4o+/9SlrYA/gzHLgOQn5gL6AE7ll5nqP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Kpn8hYI2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Kpn8hYI2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d004f135b1so27269245ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 17:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785716996; x=1786321796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgMK5SmIyPmdgTVlHflZu0Jvy4B4i4OS8zrQ8Z1YyeY=;
        b=Kpn8hYI2fKczrvwnty0KelG5gjyd8dcrnrYsD1sjIvYlhAk+ro3LIA34zCnfsJrv28
         IC2kF7MOePn/FvIUlXAAOT7bZDcnqChZGaIch1JH6pzAEd40fvJhCUHoAxvc6wbVAkV9
         k2LfXzTxXrvFonYNmJgtgL6iR9yMSaRluIQMUWI9ZIti7OsrTxBUKAjJSnAs1C0dTS2+
         yIvjQiOsmYRXptkBkehLaHO2ryFMBAulaD8FZfvinbl8q98vKsmRKpfZs0/oAztqaO4w
         zUulpf6reEclQChOW64ahCzKixphp2KTjiCPAP/NUgMWCm+GmvthCYAPhC49WaD5jnxo
         5cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785716996; x=1786321796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgMK5SmIyPmdgTVlHflZu0Jvy4B4i4OS8zrQ8Z1YyeY=;
        b=oGVIVbgpiB2iKJEYizEVv2SDevLaNAY02dxGcmqFJxtLmYhyE+yjmLpvLpgL2pnVz9
         88YwEIgyaajBd4SZIbyJBOI3l0kNUjgiMTmDGEoLEWm+Yz2Gu/G6NoS80DGsrAOiYf8d
         CPt/1kfiAvM1nguRR0HLWHsqO+y/Ha0ay4o8/IbQXpyjLqN+68hWGh6R7eZZ5tQYMA8/
         yOt2DJEWIs0a0TqNRlUxmo5Sgcj6qphPKM+dM+aHunqNMqUPMXd6luZn6tD7uA5JPRGr
         E5ZLmC3Rt7OK1KXoZp7tCx4ja/3TIfDNbuzJpwG9QjWiPoJwieZxqzMU4uDStFh4E+Nl
         LhlQ==
X-Gm-Message-State: AOJu0YzTdYjocUkVuikDnsob1REz8REC1mWUtbJ/rXr+WgD1OdKW+MH/
	ynaEYGSL3DZIdTfsugrwbMNwQ+zKavo6tSxaXCK7Teca4jX/68sIUKcFRED0JyXvuqg7rCHpPhD
	ahIyyjrd2S3RzpQ==
X-Gm-Gg: AR+sD13roSWRhep/NcDAga/JfUK/wqKreza+/U8YQmR7im4BAsA+XTVloDXTIzAYFLN
	taQseR2DU+0rGLtpXR6itBvglCxz3xWdal7IvcdICGlsgRf6Mzd+EaarmwEH/a3TIuPYR4zWpYw
	LSO/9XSOTDxELrU0nN+cnOkBPWRqoRl+Gzeq8EIVEHX4tOTEru1c6wcwh5Cd3a45v/Axt333H1p
	NEh+/VUKr5L7w8D5AwELyFFM3gD9hkPy7uTHa8Y1/NGnaXWnVEGFeufrqdD6+MKLSAgMAS38DN9
	avgnia4e9ZCzxMmOejDB7kL9irnqzqSIm1R5KuW2tcRCoQm4j5IW8oo7lkJgjBrRy77hmEELmDb
	B10NDdNNOuQX2ZP3SPSJC5b7mJi2uNF2ay5oHtJNqUb3STSoloVS5AKF6xXa9E34R3gcZ8rWjQA
	u7jXXX5um5C7kt9f7+uDXE6wOJ5FV/sXxXifh3zkN9/tXw5TK9ilMJeOh9NcA51J3xOkL3w7ed8
	Q==
X-Received: by 2002:a17:903:3510:b0:2ce:b096:e50b with SMTP id d9443c01a7336-2d0524b4428mr81322715ad.47.1785716995729;
        Sun, 02 Aug 2026 17:29:55 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1594b0sm29378145ad.71.2026.08.02.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:29:54 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	dev@openvswitch.org,
	i.maximets@ovn.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v5 1/1] net: openvswitch: reallocate update replies for mismatched IDs
Date: Mon,  3 Aug 2026 08:29:36 +0800
Message-ID: <f7bbd3c30ce81a39156e226b3872d73abed21d2f.1785644623.git.zhilinz@nebusec.ai>
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

Once the update target has been resolved, reallocate the reply skb if the
matched flow needs a larger reply than the request identifier allowed.  Do
this before replacing the actions so the request can still fail cleanly if
the rare extra allocation fails.

Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v5:
- Rename current and desired to cur and req to avoid the kernel current macro.
- Split the ovs_flow_cmd_alloc_info() call so no added line exceeds 80 columns.
- v4 Link: https://lore.kernel.org/all/3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai/

changes in v4:
- Split the reply size comparison into current and desired variables as
  requested by Ilya Maximets.
- v3 Link: https://lore.kernel.org/all/c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai/

changes in v3:
- Compare computed reply sizes instead of UFID contents.
- Inline the rare reallocation check and add spacing around the update checks.
- v2 Link: https://lore.kernel.org/all/71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai/

changes in v2:
- Preserve valid key/UFID mixed flow updates as requested by Ilya Maximets.
- Reallocate the echoed reply skb with the matched flow identifier before replacing actions.
- v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai/

 net/openvswitch/datapath.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index eaf332b156d73..ae69b2cabab9e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1113,9 +1113,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 			error = -EEXIST;
 			goto err_unlock_ovs;
 		}
-		/* The flow identifier has to be the same for flow updates.
-		 * Look for any overlapping flow.
-		 */
+
+		/* Look for any overlapping flow. */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
 				flow = ovs_flow_tbl_lookup_exact(&dp->table,
@@ -1127,6 +1126,30 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				goto err_unlock_ovs;
 			}
 		}
+
+		if (unlikely(reply)) {
+			size_t cur, req;
+
+			cur = ovs_flow_cmd_msg_size(acts, &new_flow->id,
+						    ufid_flags);
+			req = ovs_flow_cmd_msg_size(acts, &flow->id,
+						    ufid_flags);
+			if (cur < req) {
+				struct sk_buff *resized;
+
+				resized = ovs_flow_cmd_alloc_info(acts,
+								  &flow->id,
+								  info, false,
+								  ufid_flags);
+				if (IS_ERR(resized)) {
+					error = PTR_ERR(resized);
+					goto err_unlock_ovs;
+				}
+				kfree_skb(reply);
+				reply = resized;
+			}
+		}
+
 		/* Update actions. */
 		old_acts = ovsl_dereference(flow->sf_acts);
 		rcu_assign_pointer(flow->sf_acts, acts);
-- 
2.43.0
