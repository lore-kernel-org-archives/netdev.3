Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE639B48E
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854774; cv=none; b=rwc0/T0SZc1wa0syXqbz/uBDilwC+wm4MWql7AYP1B2Uz+2yg09eWLP0CjUz85eBMeFU08PU/p2S2l1X9JG6p6t5Yvaxd8qt096P14NIc9tjHRwYbsSALF4WOb6WgDWv+m9AzWy340rMW2sShtTbEkTU0T6WfHHSfnpf3gstoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854774; c=relaxed/simple;
	bh=Dtow7kJqEeyZW2h3uJ13cQiL5/BpRJhEJ70CB5MBkcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJ0/Sjn8YoCDkGO7ZnsGEpW9R/uIj38oQFbm1j7Sdx9k0lvhfLWiGulqU/W6/+0+fFetg9lhDkpbSV/epcquc0oo5rcarCppTiQB6gBWZHbdn/i/wi7VtItUBOC0gYUpsBADmaEZwLL1wxtjPX9mCAhMxI/AGCkURlp/l9uhDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLs/0Q8z; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLs/0Q8z"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1457404a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854764; x=1790459564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nH5MPo1KuhWG3KVnvfVUYVHgxolmH4XOxGLTnjREHd0=;
        b=eLs/0Q8z6SfyHeSw8jiJ/ddNXLoEa+hQw31KvqOxO09CWgSOgMmUjpkVIlHUsMY5yx
         JJEYhftovrKOgqKPHBFKmVG/MC6dj16IJP6SQvowC2Y+bNS88AesmEtOra8wHicSgMy5
         jIzCinovpOHLWzcHnYa3cr7Q6o+1eI4CX/yXBb/aZUyi5cBKfzxVLQOQLzG7XbEJpEL8
         1DCduwh0deLq/lZ7GOr6NdFpq1UQ/+0uF/Nal26hT/spwzFCW+h1hW9dc+OQoKu6PwtK
         s7gVVYvtstK1kxHJpBZiOpypPE+IsDUFFNh74o366fMYzEU4wZMtiaUjkw3hLuLhbQUp
         2KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854764; x=1790459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nH5MPo1KuhWG3KVnvfVUYVHgxolmH4XOxGLTnjREHd0=;
        b=UIosCPg9hgPi5W9wqLIlthIb3kN1vczmNZlFouea4UXb7pqu9FN90AfUtZR7VoaU+p
         wKfAu1umAMbbnBks6ovOyLtEo8PcOAXop01xaM43Mvodc6s4kAVxqiBMohmlfvdlADuN
         XqAX5XXRxBtDhcVaokk0AMO4m9OUDTsdcBQIOg2oul6ZJbSdZSpGkNfZTS/u99NjC+B6
         IAhF3EsJNm0CGFoPCsXVrlZzRyw75TjM2Lt7Ah7Dk0+nhoGbGXTKlypAvtpnpsajsIbu
         ZrXsOoHeh/8GPs4g/4fUuz0MP6JF6Lo7hEdyO/ozY56j6ClWI2H9QlToXvsrmzAPxQRj
         n8jg==
X-Gm-Message-State: AFuF++lOGFv8tD33pR/DSrJOJvamgsYtxn5T36veE/Rt8gMA0NcYp2vd
	5Q25Tydncb6mchTi9lcw9r8bh3htUcMBZKlgutgy/EUH8KxqR/+/6HU3
X-Gm-Gg: AYBFou3ErKW0oJ7Sdiu37cLtBeLG+wL61xrSO3feIbtea3jr4A0DWpLeShgVOW7Gyj+
	jxtQSQsTarz7vZ1wuomoDQAvQK1M086Bx6Z30gsnX4lOxHqKNdQxdB89gChcFvYizJjU5J3CWzB
	2HRQXiW4Ccvyy88nKoEcGWhPTACTpm3o1SjAhS5qanzlMDU7294BOLhrf57yEVO7ErwQrVN06Ca
	OxCAcv1OF607vTR9AnsjXMLGurye0LqPZ1dBf3dqfsbcBl+DsAryhRte1Iqkj29oNga78s/pdEd
	QNz3ixSem5L/rIBUltmBxFNhchMY9ni5gdJI1SigzhOYkRFcJ7q+ML181AB0pQ5MeyMn6ABueYw
	8rKrM50Y8y6oHaeO1vzg0YHuWpFqY/rSx9B9/BlBhQQqcU8F5aZ9EBq9aw87FM+4pXTAFzCrsFm
	O+cvVked0xPGYF/xgxMBuGDhfpcbVmhGmEI74OV5F1pFufPenouXUT5TBNP3R0d5W9djcj20XUv
	VyUZdN8nLkd2gDEKYeNM0IGYrG4Img7oE2v2n5mf5OVOjKiZxr5EcNqYlSMpwqUkYL/g9GNDEdd
	kjZsXuQB1A==
X-Received: by 2002:a17:90b:2649:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-39e54dce754mr12273981a91.14.1789854764308;
        Sat, 19 Sep 2026 14:52:44 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02900f84fsm4226219a91.2.2026.09.19.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:44 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists and zero tail in cipso_v4_delopt()
Date: Sat, 19 Sep 2026 21:52:43 +0000
Message-ID: <20260919215243.3472150-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three bugs in NetLabel CIPSOv4 handling:

1. In netlbl_cipsov4_add_std(), an empty NLBL_CIPSOV4_A_MLSLVLLST or
   NLBL_CIPSOV4_A_MLSCATLST leaves local_size or cipso_size at 0, causing
   kcalloc(0, ...) to return ZERO_SIZE_PTR (0x10), which bypasses NULL
   checks and installs ZERO_SIZE_PTR arrays into cipso_v4_doi_list. Reject
   0-sized level or category tables before allocation.
2. In netlbl_cipsov4_remove_cb(), also inspect NETLBL_NLTYPE_ADDRSELECT
   entries so IPv4 address-selected domain mappings referencing a removed
   CIPSOv4 DOI are properly cleaned up.
3. In cipso_v4_delopt(), zero the trailing cipso_len bytes with IPOPT_END
   after memmove() and pass opt->opt.optlen - cipso_len to
   cipso_v4_get_actual_opt_len() so stale tail bytes are not re-parsed.

Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integration")
Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly in SELinux")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a..4ac1a4965abe 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2025,9 +2025,11 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
+		memset(&opt->opt.__data[opt->opt.optlen - cipso_len],
+		       IPOPT_END, cipso_len);
 
 		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
-							 opt->opt.optlen);
+							 opt->opt.optlen - cipso_len);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index b080e666523f..9bb28236b8fe 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -185,6 +185,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
 					break;
 				}
 		}
+	if (doi_def->map.std->lvl.local_size == 0 ||
+	    doi_def->map.std->lvl.cipso_size == 0)
+		goto add_std_failure;
 	doi_def->map.std->lvl.local = kcalloc(doi_def->map.std->lvl.local_size,
 					      sizeof(u32),
 					      GFP_KERNEL | __GFP_NOWARN);
@@ -260,6 +263,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *info,
 						break;
 					}
 			}
+		if (doi_def->map.std->cat.local_size == 0 ||
+		    doi_def->map.std->cat.cipso_size == 0)
+			goto add_std_failure;
 		doi_def->map.std->cat.local = kcalloc(
 					      doi_def->map.std->cat.local_size,
 					      sizeof(u32),
@@ -680,10 +686,21 @@ static int netlbl_cipsov4_listall(struct sk_buff *skb,
 static int netlbl_cipsov4_remove_cb(struct netlbl_dom_map *entry, void *arg)
 {
 	struct netlbl_domhsh_walk_arg *cb_arg = arg;
+	struct netlbl_af4list *iter4;
+	struct netlbl_domaddr4_map *map4;
 
 	if (entry->def.type == NETLBL_NLTYPE_CIPSOV4 &&
 	    entry->def.cipso->doi == cb_arg->doi)
 		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
+	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
+		netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->list4) {
+			map4 = netlbl_domhsh_addr4_entry(iter4);
+			if (map4->def.type == NETLBL_NLTYPE_CIPSOV4 &&
+			    map4->def.cipso->doi == cb_arg->doi)
+				return netlbl_domhsh_remove_entry(entry,
+							cb_arg->audit_info);
+		}
+	}
 
 	return 0;
 }
