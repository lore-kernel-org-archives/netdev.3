Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A348CD41
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333249; cv=none; b=RvEzIRVy/lwHtKFTydZcT247icDazbp/We2EyFe9DpvTquj14Sbd6gln6900NXAMUhYld4sWriBvYAPL1PWwibuHbVV8s3d7pxqgHRozipTXqk7QnXaTxVx5h+c2nzsi39VTLC9rLERDcCya+vf4cEL8Du1WOAROJCKn1TEkyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333249; c=relaxed/simple;
	bh=TODf29AaIVwknUlQebWFDJWUXj02Yjod9p+cVqtrakA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5qx6QwEMPR+Q4dNOvfuJo+ZHkm1e95wMbH5arjAu0zN9/Ll5f3s3suMeCUXpfiL01IP361R2aO8DRsL8voyyWaiJgiMtS/mSLmFKLLqjwpBpmYeAEi+F1P36S2N0Vy60rkatwn+sL4SwL3++zF/gPNGSwQj9eUbc6xOzznX6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=qRnLTUwb; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="qRnLTUwb"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so445616a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785333242; x=1785938042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m3faSqdqlKJRXLA5iPR6MqO+lqM+aEbI0ajSq0lE/8c=;
        b=qRnLTUwbtn3E6PjuNaJT6VNqObuTT0LhtI5WmIOLNBRCai0bxAfYFsDj6KQQbNdrRj
         I9eC/m/nm9DZ1Cv9LG+LSNX6Z+03EWNJftCdP8QP68HOiWGSW4pQhlohSktBmzIrbDX/
         eusGM26ALE7pufe1mVa3dupLW16wo8x27NYEI4Jl8qOltr5DTTYRZ4k/5z4LONbMH09D
         Mv99AU2/M6lK/GlkgEf27llEn3PQbsANXUAkqH49kNqETq/007QzP86TuMDAsHo9xl2K
         9R6Hlt5pzI05OL0GpRHX5BOEQsJii16BeWBT73ascXZvhc7SCx9VQl5dh2fsmF+M4PMH
         IEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333242; x=1785938042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3faSqdqlKJRXLA5iPR6MqO+lqM+aEbI0ajSq0lE/8c=;
        b=cDNdJJPPObLUutzMs1D+VUGmPj1y6WYeywEJeVGkxOHcL+vK9iwVX34MPYvoj/dfBk
         ovVHUyxlxRY6+NBfDs356KwagXtWQ3HuTbnEGakByopLkpy1TPJ/iE6t2M2LQlt5jpjP
         mMg8zve1fwd8l5UERoo3gHRPvX4ZiEdJVjqY7Kv33MEi1h/5jhGRF2F7FCgKbLo8ufb1
         bR64ifM0QVQhmBSg1dvn4HApQ2Qncb726xiNXWsaH1uoh1vS0vX4BE+DvPkJwcQKMvKY
         zyZmW8232VXppwp0f2Afzt8OfO8uJ2Qj5Gd39HG1IcSHwiBWbgS1briGOxEkoGCYou9K
         btdg==
X-Gm-Message-State: AOJu0YxruQNaxRJKDo7CpX5ixaCFg4qCBsevDgmT0XtHQL3tl/H/fARr
	I4zViL5/BiNrAS26IghjYwjQ97Cq+RzjKI3xMCKVezgHc0HF8TZwboVRHkRZMZ++PBrtR2T0hNF
	ffj8oCBcInji+mg==
X-Gm-Gg: AR+sD12v22GO+8N2ZkyfsM2/eTsreVhpqy1gJGW6G8yq96RAFu4ZqoLDWu9SnW2VeWJ
	fqL046V6Ky4MBq90zcI8KYz4sW7dvMowoYo5yp0GiYOBKSNGYN8+b9G8rVg+mu6IE8C+LJRUJtx
	XY9TvLDjZK/TLNpW2cWNLZPPIr7qejZqjaeRcZVU2TCr/Y/j2E1UZKMhBJrFq3XP64YrJ1E3PZX
	FeUNgfbJuQGGt2mryJQtMEe/sr0froYbEciPizmbrsIOe4uDt72L7a+cI2IPn24AiOGHPz4GeIO
	omilK7yKn5p6luNZu/z3yU+aaRD/sgeCaY9r5hVAdkUiLJYxNGOofFqPH0RMifhdqEWoRHiDHas
	fhKqBSfQR0lhtk/Yhqg3KrQ/XSAy7ZbIxOvnO8KUEXsbETHW4Y3e3lhAkkV44bRK5MfgOlHLqSF
	kAS/QXYSIzCG6ocsIjVVsec5vpvSStBlf7p0V/RRR8nlmNCJWO+chhuiRm4Ig6ANHioykIAIO2o
	iMg
X-Received: by 2002:a05:6a00:2d0c:b0:848:2f7a:2e5e with SMTP id d2e1a72fcca58-84e93427255mr7103127b3a.77.1785333242275;
        Wed, 29 Jul 2026 06:54:02 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00e7984sm1437643b3a.27.2026.07.29.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:54:01 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] net: openvswitch: reallocate update replies for mismatched IDs
Date: Wed, 29 Jul 2026 21:53:44 +0800
Message-ID: <c773b2726dda8d90eed6d42b2f9741810a7a46e1.1785288876.git.zhilinz@nebusec.ai>
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
changes in v3:
- Compare computed reply sizes instead of UFID contents.
- Inline the rare reallocation check and add spacing around the update checks.
- v2 Link: https://lore.kernel.org/all/71380bcfbf3aed9a6a8a9daeef6592fa5a4fb245.1785211788.git.zhilinz@nebusec.ai/

changes in v2:
- Preserve valid key/UFID mixed flow updates as requested by Ilya Maximets.
- Reallocate the echoed reply skb with the matched flow identifier before replacing actions.
- v1 Link: https://lore.kernel.org/all/fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai/

 net/openvswitch/datapath.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index eaf332b156d73..3007d75b42145 100644
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
@@ -1127,6 +1126,25 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				goto err_unlock_ovs;
 			}
 		}
+
+		if (unlikely(reply &&
+			     ovs_flow_cmd_msg_size(acts, &new_flow->id,
+						   ufid_flags) <
+			     ovs_flow_cmd_msg_size(acts, &flow->id,
+						   ufid_flags))) {
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
+
 		/* Update actions. */
 		old_acts = ovsl_dereference(flow->sf_acts);
 		rcu_assign_pointer(flow->sf_acts, acts);
-- 
2.43.0

