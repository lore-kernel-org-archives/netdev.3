Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BE41CB5E
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965764; cv=none; b=nn1bno451L2SeF/ceYXs8O0MFNbhRylFWvgCm/UTX2DyeBnK/+080dfqmfQoWj3nSDp64rWoohsiiv9mvRmM0B0xLl0QK9WYePKr6ovbQV3KoEe2m++5k2oOHrlVe+W8GFrBY5HIGq64kt7U9w0WJ/1j9r1/Vh7idmzbd5WnGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965764; c=relaxed/simple;
	bh=ogGcDOG1SVS9gY0603tIYZGDKfXpYnc+f7C9UbaeK20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4zU4yvVkm/XTLj2tCdj1Dtf9GA1cSjgsXmAJWWNZMNVYrJIEZnoCALwK7cRxycts8y0jAeOU6af0Uufhah7f84iuYKqRcfXap3KO7IFmToEqbw11zfiYiaGJ5TrC1+ua5F0m1Kp9qson+lcyyhHJrD3lX39zxU6vuhebSek5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edJi67f1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edJi67f1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965763; x=1817501763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogGcDOG1SVS9gY0603tIYZGDKfXpYnc+f7C9UbaeK20=;
  b=edJi67f1r3uRRCMIkRW1quBhK7Iguv6EcN5eg7NNTrd1DE6PhJqlfJJa
   YxPJ7OkEOQkkqOcvO6OC7hKD4/XVdi6hffhHTj5UWhmZSBg0kQrmtz+oS
   CjOjeEXZKkNl048/Ex91vOIGaaQIEnCJLRtVc7CCyAgtia333k1xM7Uqs
   S/TtHCMqPE0JMciJkxrzAfuJlv2TfI71XpkHwhSmm+9EFu5A+0S8wUHx0
   6kFt6n+2aYVeDAE9GxJrivskgvm7R5kktjSEuGGCYa6GolvGfwqEqUgcL
   PqTZQb6cA1IIZvtmYOIMm4zPLM6QIYcrWsclhq+EGg5VCwNXM8ZPIf7Mz
   w==;
X-CSE-ConnectionGUID: yasm9oISTRSyLOfyvD/dzg==
X-CSE-MsgGUID: lyQuwZfDQ7OiAlb6ehi8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343634"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:54 -0700
X-CSE-ConnectionGUID: A9PQE4THT7ubML/n3ABIxA==
X-CSE-MsgGUID: ai5RurXpS+G8o+7JY/8UiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576164"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 13/15] i40e: Avoid repeating RX filter warning
Date: Wed,  5 Aug 2026 14:35:38 -0700
Message-ID: <20260805213541.2281287-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

When the i40e runs out of space for RX filters the driver switches to
promiscuous mode and warns that it has done so. In scenarios with a
large number of these filters this can generate a lot of warnings. For
example:

  $ dmesg -c > /dev/null
  $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid 1
  $ ip link set dev eth7 master br0
  $ bridge vlan add vid 1 dev eth7 pvid untagged self
  $ bridge vlan add vid 2-4094 dev eth7 tagged
  $ dmesg
  [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing overflow promiscuous on PF
  ...

Use test_and_set_bit() so that the warning is only issued when the
driver enables promiscuous mode and not on the addition of subsequent RX
filters.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 719f45b5cb40..abbc71e815ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2412,10 +2412,12 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 
 	if (fcnt != num_add) {
 		if (vsi->type == I40E_VSI_MAIN) {
-			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-			dev_warn(&vsi->back->pdev->dev,
-				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-				 libie_aq_str(aq_status), vsi_name);
+			if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC,
+					      vsi->state)) {
+				dev_warn(&vsi->back->pdev->dev,
+					 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
+					 libie_aq_str(aq_status), vsi_name);
+			}
 		} else if (vsi->type == I40E_VSI_SRIOV ||
 			   vsi->type == I40E_VSI_VMDQ1 ||
 			   vsi->type == I40E_VSI_VMDQ2) {
@@ -2465,10 +2467,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 	}
 
 	if (aq_ret) {
-		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
-		dev_warn(&vsi->back->pdev->dev,
-			 "Error %s, forcing overflow promiscuous on %s\n",
-			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
+			dev_warn(&vsi->back->pdev->dev,
+				 "Error %s, forcing overflow promiscuous on %s\n",
+				 libie_aq_str(hw->aq.asq_last_status), vsi_name);
+		}
 	}
 
 	return aq_ret;
-- 
2.47.1

