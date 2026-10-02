Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FB3233E8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971173; cv=none; b=nDkBb43rfzP33ERL26k4u3fFSJArSAqfERVuvviQdN/om1QWNrf9Je9Zj9pKF9mbOhaLEm+hl/LpqRyw8L53BXqWMkuS6BCQ6kSTvBP3Gq7xR10V6dLE52AZWcohC1jKQ8GLKIK3lKL0yWYCqkChmjfof+xWtDaAO/SqqTSmXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971173; c=relaxed/simple;
	bh=3OdEVxScpHrllIIN/EguMsc7RNdnqp1suwKOPgxjqA8=;
	h=From:Subject:Date:To:Cc:Message-ID:MIME-Version:Content-Type; b=lYKyFxfwaog3+NDNQg9i+HNgaD9dspOsZm59qynkRuvmI2CGQkNs8w28K0aEn2CRULYf0JTl+gAB9azd7m7SJ2FTMfPw8E+2HOLRWLAPAe/xz0f9HYZytADrboxIeWOC6HLkZXH1+0n4jefB/bFQej+PHK66Mv5X09+BRaflysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVbiC5zG; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVbiC5zG"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so195397a91.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790971171; x=1791575971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH0ugp3V+u5HMdILbaX9AjuCwaWC/yOAmbTdaJkJgPM=;
        b=RVbiC5zGC02rk3LGbH/Dgox+1rZ3x26TFbEbefRosSIM7V3vsp/5Yad73RFhfnPjHK
         /Js+RtxN5fB/KUSVQYj09L91OEquEWyd4HQe9M0FbU4spZRY8Tn9ZpthIZo41sqQgFHG
         y+D24koi0F8X1kAi8PaTcCUcI+aes++7ogre7jzlx45SyyYS2MGthcZDddiuSJ4MOWja
         raYhCKVW8SCx/q0bWr3UVt+PWgfbYMwp9es+/RLqXrf86UU3D9ChnPGhPr2SM5j1fh9x
         A7/+U2T4Tko9m8ndLdqnWiuR4h9UimAesfnBCBXAC46ejDYOMh5yf7vLTwyx4OCrYTC3
         5XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971171; x=1791575971;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LH0ugp3V+u5HMdILbaX9AjuCwaWC/yOAmbTdaJkJgPM=;
        b=CzdFYRE7vxUIvLubsAWOsEK3mR/9qfFxbW/ZaAP0rI55Q0DoX+kEVds/692fLvUys2
         x5d/FLSJJ+ObO31KRgZBguBsWSXcfGobwYky/cgXlwHpbvJ1W639mbDtk5poon2y2Ldb
         2o3ATKewC/3IA8Q9iMXMNPk8glkRWrNzEso5ikubDOD90m6NCnh+E3of3h4YXgnJvotO
         s7EHLuhdiVrCp/5A220842u4sceZsXCCN2elHJAsMcuZp1WvPPcUsYL1NJrmVnBs2r4W
         7Y4ggFv6coLa6gNRQDDXeuZA3rUcEy0xy/rcFRsJim8qThiOCozLE1Jt6qkADmccFGKm
         uKqw==
X-Gm-Message-State: AFq9FYJ4SZMf2qFt2lbW25UHXbxUD9GKXT1cpKfRZAfRusEI/XKsABM/
	Hz+UYwQB5btiwu0nOe8pidab7YuGQKlf7rmYtQ59XeNiVpPrauY0P7qhLgoU0sk85XI=
X-Gm-Gg: AYBFou3JE9/+GcN6OVQ/My8Dg5yQOvFA14yVrIBd0/NoLeuaqzQZaxUAgk1FwjpV3NE
	+h7GBFanD/ogr0Wgb4FZDagdhXfpANnmV86Vo2aJDLiHJpue4fgqdEtflHZxHGBCbB/IBK9hdXe
	U188FvGdiIk2Y8dSQIE1qJxC8Xm5Ml32i03h0x3Y0n5Nhn6BkXNVVynnsTlJHbO+OrJ0YA1e7rk
	zYF8oEzfO/29e+VdfmXoiGB5jCTN42vq6x601H0hJo91FTk8Tdd5I/m8gROOnVJP66lfgEw+RV6
	Z7yMVzDI9rcgeWHucNN5n/TQXnJshwXD30i4//82YcUEZQXsdgZZI8SA3Si4yso1bgDGRYuGEx7
	RZz5HXX3U51rLYlqkf1oYxqc+VAkVLB8cxsw3/Lbw/pG8+i0TC1QSc9EONWjrbY53QQdqdP7wsz
	gs/N+4L93tk6fS/maTIbCEY6mHBvSklmcN/27Hm/MzKmjeM0TL7tsOP/dKenB8jqKQp/+ryj7t9
	/Db9LGSlF7MC6U83u19yuk=
X-Received: by 2002:a17:90b:4c05:b0:3a2:b036:ed64 with SMTP id 98e67ed59e1d1-3a6cec6fc0cmr1917135a91.39.1790971171314;
        Fri, 02 Oct 2026 12:59:31 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6c8421fe4sm5419796a91.12.2026.10.02.12.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:59:30 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
Subject: [PATCH net] nfp: flower: remove merge entry when conntrack offload
 fails
Date: Fri, 02 Oct 2026 19:47:40 +0000
To: oss-drivers@corigine.com, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Wentao Jia <wentao.jia@corigine.com>, Changyul Lee <lcy8047@gmail.com>
Message-ID: <20261003.final049.214b9988b1e1f0a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

nfp_ct_do_nft_merge() inserts nft_m_entry into nft_merge_tb and
increments nft_merge_count before calling nfp_fl_ct_add_offload(). If
that call fails, the error path removes the entry from its lists and
frees it, but leaves the hash entry and count behind.

Remove the hash entry and undo the count increment before freeing
nft_m_entry.

Fixes: a87ceb3d42af ("nfp: flower: offload tc flows of multiple conntrack zones")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Compile-tested the affected object with x86_64 allmodconfig
and W=1 (GCC 13.3.0). Base: mainline 3b7cab693ba2bab63774bf5b988e8a61b2ef0f32.
No hardware testing or runtime failure reproduction was performed.

 drivers/net/ethernet/netronome/nfp/flower/conntrack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index c983e8b1799d..522ad555e8ec 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1260,6 +1260,10 @@ static int nfp_ct_do_nft_merge(struct nfp_fl_ct_zone_entry *zt,
 err_nft_ct_offload:
 	nfp_fl_ct_del_offload(zt->priv->app, nft_m_entry->tc_flower_cookie,
 			      nft_m_entry->netdev);
+	WARN_ON_ONCE(rhashtable_remove_fast(&zt->nft_merge_tb,
+					    &nft_m_entry->hash_node,
+					    nfp_nft_ct_merge_params));
+	zt->nft_merge_count--;
 err_nft_ct_merge_insert:
 	list_del(&nft_m_entry->tc_merge_list);
 	list_del(&nft_m_entry->nft_flow_list);
