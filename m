Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044C40DB38
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272963; cv=none; b=iBD9waYmdNF1zNFk5zz3bgPZfVT8ynr00xA9c4PXgpcwrcClxqtcGOVgDvdxEi4zVIn65AfiOMcVLCKsPQn9lmGRRB7zj8nl8kV0FriAV2WmUjgD8SSqM09A/Zk7PP5t9cSaHtuUEtNhbG3AcbXkQtBwXKbcAfNE6tHKWxc/lQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272963; c=relaxed/simple;
	bh=9IdD75rL1U/pv5RiN+5ug46nv4JY6re4E9IyDWJll0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tn4hF9YvnV7NaFw/7sipK+PeMSPbVd/TSfJvwd5iBTUcluX+mK0DLew31Zv2rJCUXdMLhemyGsVbLOhnLXTvppjBIgVny362CJC39U4dbfjQK7enD95a4bAEDGjX5XgBqSXzj19vlH28wK2LHrAKSz2WjTuYmgW9llFyBTAlDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/yYSdAv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/yYSdAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272962; x=1816808962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9IdD75rL1U/pv5RiN+5ug46nv4JY6re4E9IyDWJll0s=;
  b=c/yYSdAvuOt8UEiyGf/rsQzQK43w1iXIcbpoWOrLBTVQrd523KwoVpwa
   ZqZ0FKxXVaHyZVZQM0Z5q4UV0fFIRLpbkH+bdbXWVjZCa1kJj+B1JPXIu
   LRhE/LkuI7Yl3EXZhrsJ9XVQt4LV/h8sdAMEOFvLAUABJuKKhqbiBv+qk
   10igPv89AA0ROM8C6BdbpMddi0Mifn9EUABMgZh714gyxTf84hypRr6W2
   RLRKErnhx/yb2L2y0eAH0PlGtvny9gL6eT925PaGD7RpY5K973oOZeXHc
   ipD633txl3dJPvCxgmjeUNSFYJC1D2Go7PArkO84+Q8brIag9TtnL6cpV
   g==;
X-CSE-ConnectionGUID: C2nRoySfQIyTDxMMKqPppQ==
X-CSE-MsgGUID: s8RJrqlQTfmyc4SKHyCVsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85884997"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85884997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: qm3NotPuQMW+DcQOuy8AIQ==
X-CSE-MsgGUID: +iUCf+MYRViPNLmxA51hEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558940"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 01/10] idpf: bound interrupt-vector register fill to the allocated array
Date: Tue, 28 Jul 2026 14:08:58 -0700
Message-ID: <20260728210909.3042004-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

idpf_get_reg_intr_vecs() fills the caller-allocated reg_vals[] array from
the VIRTCHNL2_OP_ALLOC_VECTORS reply in adapter->req_vec_chunks, bounding
its inner loop only by the per-chunk num_vectors. The array is sized
separately: idpf_intr_reg_init() allocates
kzalloc_objs(struct idpf_vec_regs, total_vecs) from
caps.num_allocated_vectors and only checks the returned count after the
fill. The sum of per-chunk num_vectors is never reconciled against
total_vecs, so a reply with a small num_allocated_vectors but chunks
summing higher writes past the end of reg_vals[].

Impact: a control plane (a PF or hypervisor device model) that returns a
VIRTCHNL2_OP_ALLOC_VECTORS reply whose per-chunk num_vectors sum exceeds
num_allocated_vectors writes struct idpf_vec_regs entries past the end of
the reg_vals kmalloc allocation (KASAN slab-out-of-bounds write).

Bound the fill loop to the array capacity passed in by the callers,
mirroring the sibling idpf_vport_get_q_reg(). The existing
num_regs < num_vecs check then rejects an undersized reply without the
out-of-bounds write happening first.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c      | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 1a0c71c95ef1..4079a787657f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -87,7 +87,7 @@ static int idpf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index a07d7e808ca9..6726084f6cfa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -86,7 +86,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index dc5ad784f456..8bd6cca64c9b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1318,11 +1318,12 @@ idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
  * idpf_get_reg_intr_vecs - Get vector queue register offset
  * @adapter: adapter structure to get the vector chunks
  * @reg_vals: Register offsets to store in
+ * @num_vecs: number of entries the @reg_vals array can hold
  *
  * Return: number of registers that got populated
  */
 int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals)
+			   struct idpf_vec_regs *reg_vals, int num_vecs)
 {
 	struct virtchnl2_vector_chunks *chunks;
 	struct idpf_vec_regs reg_val;
@@ -1346,7 +1347,7 @@ int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
 		dynctl_reg_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
 		itrn_reg_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
 
-		for (i = 0; i < num_vec; i++) {
+		for (i = 0; i < num_vec && num_regs < num_vecs; i++) {
 			reg_vals[num_regs].dyn_ctl_reg = reg_val.dyn_ctl_reg;
 			reg_vals[num_regs].itrn_reg = reg_val.itrn_reg;
 			reg_vals[num_regs].itrn_index_spacing =
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1b..9b1c9c86f6ea 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -104,7 +104,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter);
 void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 
 int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals);
+			   struct idpf_vec_regs *reg_vals, int num_vecs);
 int idpf_queue_reg_init(struct idpf_vport *vport,
 			struct idpf_q_vec_rsrc *rsrc,
 			struct idpf_queue_id_reg_info *chunks);
-- 
2.47.1

