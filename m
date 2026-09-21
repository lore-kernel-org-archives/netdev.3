Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFF4FDA6B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016576; cv=none; b=Tf4wB7E12pkQ/PYxGtMBZk7cGMiTG/SL16MzWzqb3tu6fEJl/Fu+maAacWyzSAU/cajGRbakqPj5IOFZdHvUIsiHa6wsVBqxAqiH/VC6ZzShH06WJ0CJ/6Qet1PUGdIucnG0k7+6mnS2cO8F1LmE28+hhlnODNY0K22WoFaHfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016576; c=relaxed/simple;
	bh=Mg5HmfygBKDbDNJcYzHq9nB7SaGONldoL2Zz6p08uPI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=LcPIMOZFOtBMO1MHO6GmaiYQ/mTdVLYTyZIjYxige7PrYwffcmwiR6FE37FLFFhQFiClfimsogRBLLZaHR2qvy13xmgVebfOXOt1gkRLFwwcSlCkfLRcC+i0KkTnZH6U2sXVnDg/LhBCwED29pm0VAorMq79++aAyPFllKsaT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRPr254G; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRPr254G"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so23239885ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016574; x=1790621374; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
        b=kRPr254G7nJJ+AqRqLty0mhdWYM1Po54Ff9h8IpHt+N4xFnt/5WEzg4FAFh8ykbFWt
         wXoFd9McXM8WdDM+w7ljCAYhT0lQXY76zn+iViTahSreJv61L+RB0SWAb2/ZOBLzLo/X
         LUWZYodntZaPtuyrJU/qbTAkxs0s6zEURwF3BTv+yZwdDe8XgCAwAty22bcv7rHVupOd
         vbaC1uQIVGWWrXGqvTFALEjdLnm1w5WOHIJ7gezo1dEur0trpvSqe7seZD2Wub65UK4d
         7CArmCO22FMQbUBaH/CNSgCCyj74IcWFuFjly9lddILiXK8PKYGFMfyLnsOrOV1dAmnl
         Xq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016574; x=1790621374;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
        b=jpyBf5XF9KHZB+oCEvuvhnb/9G4pU0iWRIlZHWbUts7sgd1ulemcF1ipMO/L5Q4ZKt
         h7tDzybdN2nIjagR15gRErIkE2Vl4EFQ+dZDmCOFJ4b2R2Wt35A5WhaOfMzozq1o5svS
         UtxObHUxRB9nv/WyXCntEtUTQ2uK+xCA1kguZodiSCX3m1W2IwxxLptLHQznH+tUzVcA
         k1yaFsTj2NdYjgIqwtXNsdzRB7/EzXkxGwySeWQv7Qv+pRXqZ/r0H4vsnmxA+6iOvaLX
         +Sy2KNQ9vlf3sm5PyoaUoLBjeROmOq9hAOeA5tJkkDkuPJb18CD8IQa2nGcz918vBMsG
         H6QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf8OjxSbCAystHQpxveCThsSPEmrbzERya/5uQNh3kGGrv37OtSH1u+VnR6wHbMCAtBNPSNrA=@vger.kernel.org
X-Gm-Message-State: AFuF++kJw61dFyZXwMR5ILc+DVMhlZ301eWEy/BMwbEmnUddTa2sbliX
	JArIi1MzBB9oxDPyOC/4Yph0u74R3adyDm0fhJiWU0w/CvQyuhrvKm2y
X-Gm-Gg: AYBFou1GcaChbHun0qZXMUaLViTBpjAwZsaZCmby16+Q2DPCxgELshbk463RKdEclTJ
	ohAu+tP2PvCT2xcKJe/GuNa6Wu+zoWse1Nq6kIvDZLPMsFFotYe2LniSerEhi9ob73EEVoZ7tKu
	yuZU70E6+PF+2cMTKyAtKVBMubjdeuoB9ul7YkATGa4zFqpc4UJzupE9V8xvW6ipfXZoHkDkY57
	aS4Ri7N8pf98Xhk0Z6/eFOM2s4jQqdFSzqngwVP4q28Vs3fPLkWthRUGIme2FZlFxaybET9aURL
	NdEZ/T6lYsOVYeK/akgyz6YzIVDjTrE5RRref/8VF7l5t07BoMCXLgNLbQqL38YADenjP67RkwR
	TvMIBhRuwwt9gzk3kPe30T1RZ/DzawAw0Cmh3/hgOQ0773A5PHd9geHv7scMbGxbYSu1elWLWzQ
	HAZ4rFdvqXWJfSbGzAFgmnshIGvbSetF43NcyPFpGgdp5iGu1hyxSR/YzGO3yMJgjTdBW76SxLy
	/j8a9NtBjsEDjmhmlIEUsE=
X-Received: by 2002:a17:90b:4fcf:b0:39e:6a7e:ee17 with SMTP id 98e67ed59e1d1-39e6a7eef23mr11586799a91.35.1790016573955;
        Mon, 21 Sep 2026 11:49:33 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5adc1sm8579800a91.0.2026.09.21.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:49:31 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
    Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
    netdev@vger.kernel.org,
    Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH net] ice: initialize the SF number XArray for allocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:49:28 +0900
Message-ID: <179001656821.91284.11640142428321627272.idr-bug-50@gmail.com>

When a devlink port creation request omits the SF number,
ice_reserve_sf_num() uses xa_alloc() to choose one. However, ice_init_pf()
initializes sf_nums with xa_init(), so the XArray does not track free
entries. __xa_alloc() warns and returns -EINVAL, preventing automatic
SF number allocation.

Initialize sf_nums with XA_FLAGS_ALLOC. This also preserves the explicit
SF number path: xa_insert() with a NULL entry reserves the supplied
number, and xa_alloc() skips that reservation.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.

The ice_main.o and devlink/port.o objects compiled with x86 allmodconfig
and W=1. I have not tested SF creation on ICE hardware.

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482..f56c2b748 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3996,7 +3996,7 @@ int ice_init_pf(struct ice_pf *pf)
 		ice_mbx_init_snapshot(&pf->hw);
 
 	xa_init(&pf->dyn_ports);
-	xa_init(&pf->sf_nums);
+	xa_init_flags(&pf->sf_nums, XA_FLAGS_ALLOC);
 
 	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
 	pf->avail_rxqs = bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
