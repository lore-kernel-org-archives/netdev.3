Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A030D418
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583528; cv=none; b=elsDn48MILAns8KoJxkwofhAcd4MWLqUL4XIQAKZJ9Q3stBcpe4EfbdEtf1vr6JkFVtETpVVTWr1k728zgpksN6iBI4C5H48Hip6TAqcSBsQhjlWY/JUezReMdvvEh5qmIk9GQjKLF7z8hEezMsdAar3CZrbkxrbopzeMnbAUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583528; c=relaxed/simple;
	bh=kmX//yY22ltsPj8ErGwTI/4OMCj6FvyTxQgwFX2hais=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggwmTXc1J+nUfU/3dR6RJhyoI/RKLk8K0mnHSXtyV4oQ1FSSKR38bNLN+IBxVBrqWFn9Qebv5FVBWkWPzmL6ph9hgxD7ogf42RR5RM0dMCZ1JYKrc+EYUIBH22KUZjwpU6STxJPhpygkDScpklPKWY8g/auixJn8GxgsVB7HNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=i+Dc3Qnx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="i+Dc3Qnx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1401005a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785583526; x=1786188326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=32NZgRNlEbT3guIjD5/RDgNkUshJ4zqsmgaTUWXVuEU=;
        b=i+Dc3Qnx2cH39XJBz/C5RDKmmHrGXLm/ctc0XQpgyn9sdZFaP5H/GGAhtRgdiJTPLc
         uV8JfL0osFCa6uphU6i58GbkBR5qAASttRbPoMM1StaTrb9PlbRcikhYflq8PhnO+lO8
         sOmHJsqSEw/XK6KH3alaQrtTe4SSO/XCVJZpzElhhGqA9HwPtxjSK2fJPfYJpX6W+9z5
         aoSyxQxwpg9ZoWIoAO3x87xgx5N6RJ/fsreyjY8PW1yTbpnhMdjV8fVvpaphuh1qUSE7
         7GJniwGf4EQD7l/vWUsEEi0Bl1blBBGcbYLTyyhE65lLL/aa7czGTaMHlYZ8iy4NmExN
         EBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785583526; x=1786188326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32NZgRNlEbT3guIjD5/RDgNkUshJ4zqsmgaTUWXVuEU=;
        b=ZSxH4kA/iovV5oa9PVdwuTDel9C5gSkWpU+sqD1iM5iQ7TOUtoMe4pRoN1syDQy+d/
         vosFJa8plUbdkPSq6ev9whZoLnrgn9jpLgfxA5WBj/XXE4ZXLPA6j3JTOJNnGaWY4+gL
         VWB6/vEGa5uWTkuDYf1o9HC5dwcnv1ogJiWGQ6ooxQd181AyrsE23v3rKPR9Qn7cPtsD
         P4XPCza9heSA/+JM3EldTflABNyXN3FcxoAz4aNvztMCQsPEQ4I5n8fBLBrGI9XEQoVl
         Felx++TmQyvlPVN1Y8GczT7Io4fZU+4VgW0GMFwqOzenmbJ87+ASZTcYT7KZ8iMnnm0c
         UqeQ==
X-Gm-Message-State: AOJu0Yxc0aOKX62nsXDAd1GWcUJL6QXsgCDgKT9CKN73NnJ86maZGktZ
	HJ4CCvKOSkPX08tGPdF4p+ajTITNg3eLFO8fNBWXr1cnuz5JG0Q+IIYl3zTDgt9gUvS+YujiVNS
	L9XyPzdHi7z5A6A==
X-Gm-Gg: AR+sD102MsjaE0Xn7Iz9q05y4tNBFMdp30MMfLgEpJY8He9QNbxHICUhUNmRQkcvK1C
	V0GwBUWtPWLmcEnuWxVj0ZNvYtKSqyK4ojblz8A1cIk6hxQne+2hw8ii+kd/lyV8BktWIsjUmBU
	0DmJ8ub1yesy/OmSPyuh1Ce7+l2s6GattX3gD0YeKNECR5NszEigxp305UoPjOqMbDxz7B9KDEi
	5q/w8a0wS2S2VRu6QRCYgpyw94XcBPdr7/KOImx8l9///Crz7fTiZUMH/Z3A2MKKG0x8iCTxE2z
	14EkNSKIV7eOXNUbUzigW+ans+UBkWAS6aqwVnWxt4yEnIxDyVlY3VCmiSDCnfut7CW4A254bQK
	DcNgWBPkyvt20RGIttiBRLM2498GFbjOMAja4Sy90jp0PwxvChTCF0w2wYnKU84Kks+LXBN2SbV
	crAvwzcF8Qy//hLkcKcF0QxqudkIH6UkKFSmr4eD6B1TjnDCc4DhmR/IEgrjPfjmRwRT6N44ktH
	YzNh4jjdKsm
X-Received: by 2002:a17:90b:5605:b0:387:e0db:bc23 with SMTP id 98e67ed59e1d1-38fbc50f6c1mr2974477a91.35.1785583526103;
        Sat, 01 Aug 2026 04:25:26 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2e0f409sm1837885a91.4.2026.08.01.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:25:25 -0700 (PDT)
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
Subject: [PATCH net v4 1/1] net: openvswitch: reallocate update replies for mismatched IDs
Date: Sat,  1 Aug 2026 19:25:11 +0800
Message-ID: <3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai>
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

 net/openvswitch/datapath.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index eaf332b156d73..d73d729176e1f 100644
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
@@ -1127,6 +1126,29 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				goto err_unlock_ovs;
 			}
 		}
+
+		if (unlikely(reply)) {
+			size_t current, desired;
+
+			current = ovs_flow_cmd_msg_size(acts, &new_flow->id,
+							ufid_flags);
+			desired = ovs_flow_cmd_msg_size(acts, &flow->id,
+							ufid_flags);
+			if (current < desired) {
+				struct sk_buff *resized;
+
+				resized = ovs_flow_cmd_alloc_info(acts, &flow->id,
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
