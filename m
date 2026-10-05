Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342347AF57
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202715; cv=none; b=NeFOlFcoFBAdEzJ84usSNprNjFbQ2ffBxka9K62besE2l+aiUTwIIVT/c05sE0g+LUZVojgGNnx3PeNvtHXVwpIFIYzPfFVMe3VeUd1bMf55iEPKGm/1DNrKQ845dnyLcmsugjUekPavXUA21JHS8ITiJqHoEKA6jT6TJ5ZrHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202715; c=relaxed/simple;
	bh=YeuUasXs+6xt7daRBb8mSHnS9/zyWR2dsiVqHatSlXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQ3BJpDKE56DlIs48T9aDALLe5mS9WQZJ/lNkG9zqP4aZGV+0k8HWVwY1hUCLht6Y0tyQo6TOPu/26W36/v8UXH0IuTZ+rPeyOoFIgHbFUXmKnho18JY9unao3M9mhXMxVI+zOC6BCDGIqHFhCJbGwEIEDCgYVJSsSixVnLakQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gUu0pHqG; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUu0pHqG"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e4985211ecso3331455ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202714; x=1791807514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T0Lp2TEBCmYO9pyb+VFPjyIlyK9zV+FfIYIe/n06RwY=;
        b=04EUMcFuuFtIFTvKXeQoYeM3xrygpAKlt0sYXSvlblbViDub92t9OlLW+MOFqLDeSu
         Gp+KA3jjkWw0vVsWfG/6O+pI04X2Imj0thLpIkuSUJB2ZW2kJRkY2I6KnrPdqVOTIivw
         V8r3UfaykkBAk1/4fkaJH6g7+7geLNhtgskgkabi6yKfiDXFolonS+jh1e0KAnvZuPuJ
         kHGzu0y7mNBP2Gl+1uVJMJrvD1sP8l8k3byjOo8aM086rjtSRkKt8pdoG32uJpi6tas2
         WwEeNnk+fi68iCQp+SW8tTILkmn9dgC7KLhUpOWtUvzKGCgA7P2eW6SBo+EBnujSWd22
         KrGg==
X-Gm-Message-State: AFuF++k1qO3s57BU/DudAbOSkc+94g+bgyCVhQLZsDlhTUewFwjJzKxb
	ix3NWgDMjsuktXJdkdDswR8W57jF/g8FTwl3qgxG2/jlRTHAKMRFC6seY3acuXkBZclMyw31Fb9
	iTBL8YyJmvTLmKjuXmCE8NgRSLqWyHilUJHVO4g2yROshCbjKbAqEvpDOiC9xY8nnq+vJkwnWkC
	6pIR5bKABSYw0+2lfjo6HHg3pqkFz0/3YDH41GzWkFOAa5CqFEhmkUFQwA3UYxLVB+Z727LziyX
	KtVIM4rr8wcjXxvcA==
X-Gm-Gg: AYBFou3U9mvscHC5CeTdzxE43/YVsw5lt992y2X64vce9/yREpG0A4YA+AkZd1HTFph
	BmN9ho5BBpFMEibN1zC2Jb+jeVYoH17ct3Iz80x8aBe+7+F1KWDPTOo90io/hipbeoqxEMjDhj+
	D/+ryiYFG3w66ZHIxZl3AfI4C8z5Dky3vOodZ4NR9zg7zf+JhTnMeOl7FwQbBl7o0hIIMGr2UUz
	9NypcqwPuhh/2A/rlEDagFJxWFFu0311TFX6v4t3+df2rM7dDJdgiOrmgc/qUVKzzXO2ZpFMlok
	ll8Ena9j9dUuBXdHxlfZ34bkrrGQdeqKTSeQcSUFGijWAaeanzTCRehFYWaIIf7CvDFdT/BI8FE
	s4hPm3VOmDTEha+s1q5zrwFAugcCsBE1sHhHKq8ok3Dxr942mAnGml9hfBvvRP/y3QaBEOFGZU2
	99MnSqtgQxtkFcTh2x+SckP6GDKTue8PUCOS6NYY++DASw
X-Received: by 2002:a05:6a21:62ca:b0:3dd:a006:ed94 with SMTP id adf61e73a8af0-3e0bd13e98cmr10711876637.42.1791202714149;
        Mon, 05 Oct 2026 05:18:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ccb7429e540sm1643935a12.6.2026.10.05.05.18.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:18:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34ef5fd7934so4794861eec.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791202712; x=1791807512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0Lp2TEBCmYO9pyb+VFPjyIlyK9zV+FfIYIe/n06RwY=;
        b=gUu0pHqGxR1WQojj0s3RdFtG6rXaURi1FqirgaJwJnHiL9+q0LHTRVEiBfVjrZZhTB
         lCpNKNQfd4UBzfJrwAamT2YtR6rc6caQO8MD/rQLfLo1MYAulkzIIBAFt+fW7R3AXQ8A
         kLyG9wvmsX6eVVSyOocHlJfkZk4PPXhfqIiFU=
X-Received: by 2002:a05:693c:8952:20b0:351:207d:bff4 with SMTP id 5a478bee46e88-351207dc13amr6603688eec.4.1791202711663;
        Mon, 05 Oct 2026 05:18:31 -0700 (PDT)
X-Received: by 2002:a05:693c:8952:20b0:351:207d:bff4 with SMTP id 5a478bee46e88-351207dc13amr6603650eec.4.1791202710909;
        Mon, 05 Oct 2026 05:18:30 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm25687542eec.25.2026.10.05.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:18:30 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net 0/4] bnge: Fix error-path and IRQ setup bugs in probe/open
Date: Mon,  5 Oct 2026 17:47:00 +0530
Message-ID: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Four independent fixes for existing bugs in the bnge driver's probe/open
path:

 [1/4] Unwind bnge_alloc_core() incrementally to avoid a NULL deref when an
       allocation fails.
 [2/4] Require aux_msix + min vectors so nq_nr_rings cannot end up 0.
 [3/4] Treat an irq_set_affinity_hint() failure as a warning, not an open
       failure.
 [4/4] Clear bd->netdev when bnge_netdev_alloc() fails so it does not
       point at a freed net_device.

Bhargava Marreddy (4):
  bnge: fix NULL deref in bnge_alloc_core() on failure
  bnge: require NQ vectors beyond aux reservation
  bnge: do not fail open if IRQ affinity hint fails
  bnge: clear bd->netdev on allocation failure

 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 51 +++++++++++++------
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  2 +-
 2 files changed, 37 insertions(+), 16 deletions(-)

-- 
2.47.3

