Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58C45041C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774912; cv=none; b=XbtcV3ALF+54EvzG1bc5nxA4JTWlbauPgxDZbdpvND9n2C8VzwCMRYDWhJOx8enrG1nOC0HObszLCsQBNn8mSg1fJnIr70Df8SeowcjLM083ogFtLVePLGKihWRDROCyXDtBojCJyMGPz+sl/fTyQcnMBXYk3oDLEVGExELfosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774912; c=relaxed/simple;
	bh=i9d4Vftsku4C4hRtse/HfWlFXzHBBI2yaNFsrVGvuRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8hPL6joPS756nB0UAfXo+BVGm5avyOrT0YVaMgja4A9h9KuZOfaI7Ud7tlvlfz7ErhpNj2/GdsNKBJGL+Y8xjadAbixY9sCHYJRfempq6jfO9JkDoU4jW0BpntkiA9bkiaxurbzScVC1P6AA54lw0WGOoY19Igp/8FLWe/bEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYb/6dud; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYb/6dud"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4402090a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774909; x=1789379709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
        b=rYb/6dudsrjrCPnaXEiTRGPURgOsyipjYS8AN4udPKKPeit3KmvHYceI71Jvt+YNHR
         t9xMDNoEZgqz0TvN6PLNz5D9HYAobf/K2ftJr6OIIekQkQM4d0aFl6JXXW4e1wd2xRc4
         0oTHWIHp1e1CRRgkZwvwwFSN/28wIu0+krLDvqDjJRh8u00WdOdprw24xHPiBJ2WuNnf
         V3/HXpkUGKcJYt0qzzFjjr2slUihOaxFydNHBkqpBtCPXe3GrLvb040EE05GHdAaXJhn
         tNb1r6CYPNsDNGImbnQt8C2NyJsFCdXM6ckTgwRu55/F0n8chbnUN6eybm2/h28YDiUD
         a4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774909; x=1789379709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
        b=fvVdOu+LA91pmuP6DxHh4+5s2Ngs4ykJ0CHmSaFpCSfBDd6ixOPqh2vr5jdNBaTlTp
         z/IiAtGj8EmRS6yYP6Py9ffZLIgW2pbCEvntAs9MpjCh/mc2/u3ivLZnuDlQP9p3t34w
         EkDI41o5GbOuNAJgq1ZR1AL2PhtSMaeLVxq8lD0IPLogzU6F9k4k8zgnCt4VbZUShNNS
         bL1fW4skbQ/rIyTX+6Ckn3glIGxLSWE9hGlghEujvTZsGfr48KQ3ifwPWyhjtIKsxi0p
         O0kvFIyEDA0iLPVhKOnJHJ+3OVP5jxkhtaliXFEn+dhlP9LLx+qeo6G5w8vtnfPI/acA
         9ZZQ==
X-Gm-Message-State: AFuF++leMFZ0bWSTIvbY3PAZL7Hwr7huPTIi2wzzrghkXfZIn3/EqOIS
	PXcdjdXCiq+YHgdqSSOaM3JujBTJ7vARnB9uvDXpcTfICRrCIuIbbs2d
X-Gm-Gg: AYBFou0MHhgYKn+Mp/nWpxVGTqPN3Wz9PyuSQ1V8zyXjwS5CNZ/sY95yb3UJZsM14QB
	HYkeAovf8YkFBuLOY+Neyh2p43Jg39uoB+VKSJKdR83l0Q7hWES3WvtVHJuzTbEWn29J+yzZdyt
	J4V7vcuVBBt4PDDq+oBsVHb3UIyu/C2HdS4Nib6DgA1KlIp6DFeFiHj85pqAJ81Ey4kiSfdAr9o
	iIpV5GfD9SMi7OK9kc3F7ckp04ITMOSMyAimpFeCgd43yYyc6hTp+vG3r2ENtOsmVBJEsx83ggo
	o0dy3ji1lfydMP7MVgaiKqXbNqhdbgs5jyipyD4QwQ3nMya4z6ZgzYEWVZRMXfZ65XJ8LSn9xai
	9feX3iUivyZ+YH8cykr0GnpVJcAt5V1XskaNqBkV5eFy3t1xd8nAvT3YE0Ce3W6x9MR9RKTRZj4
	KA+QSESvyBYaGTVOzQB9mvPoYOygIUo1Dv+Z2eZX0Rt5hjc5DB4jeXt5Sf7YLNjH8oSBfGuwNeg
	LUy0F0gXGP16a8=
X-Received: by 2002:a17:90b:3803:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-39b25eef036mr31016094a91.0.1788774903375;
        Mon, 07 Sep 2026 02:55:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:55:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Date: Mon,  7 Sep 2026 15:24:44 +0530
Message-ID: <20260907095446.27290-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 drivers/net/ethernet/intel/ice/ice.h       | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..e5f940d324dc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
  * ice_is_dual - Check if given config is multi-NAC
  * @hw: pointer to HW structure
  *
- * Return: true if the device is running in mutli-NAC (Network
+ * Return: true if the device is running in multi-NAC (Network
  * Acceleration Complex) configuration variant, false otherwise
  * (always false for non-E825 devices).
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..fe47ec0ba809 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
  *
  * Features that need fixing:
  *	Cannot simultaneously enable CTAG and STAG stripping and/or insertion.
- *	These are mutually exlusive as the VSI context cannot support multiple
+ *	These are mutually exclusive as the VSI context cannot support multiple
  *	VLAN ethertypes simultaneously for stripping and/or insertion. If this
  *	is not done, then default to clearing the requested STAG offload
  *	settings.
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..9ef1aa66fa2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
  * is correct etc. Then disable old mapping (MSI-X and queues registers), change
  * MSI-X and queues, rebuild VSI and enable new mapping.
  *
- * If it is possible (driver not binded to VF) try to remap also other VFs to
+ * If it is possible (driver not bound to VF) try to remap also other VFs to
  * linearize irqs register usage.
  */
 int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
