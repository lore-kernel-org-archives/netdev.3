Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1BC425873
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965765; cv=none; b=eE574aZGTvkjnQGRi7rLEWouKXNgJUs9MtQZl27ePKqpb2nVcVKqavCNE8iAM/GZC4EZDO5PfRCb8o/hZtlu4WZzZtaJu5/Xes5hcsFBWhxJaggn9NepxbkmAPFMr3CDsZFcbp+lMHg+Ki+2yF92hNZj7zve1uKzQC5omOz3lBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965765; c=relaxed/simple;
	bh=OoYLorxG3EsbwK3FAcPvGsjn7rBgsAnbNxmThzLHJbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS9zVzrtVQERcGOBvupBzPmzQH2wcV+hkA8QmGkmEaFGa2so3cNpan4Un8GTJ1Ty9Q2sgIH77suRh4AMKl72WiZ5C5SQM/AcK0KRhqogLhbl4EcGHkkdmcFYNU2V1gL3Tg88Apv+NhCOXgxoJ8geoD9knqv/CuknJsfCEXqqTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mffonLXO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mffonLXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965763; x=1817501763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoYLorxG3EsbwK3FAcPvGsjn7rBgsAnbNxmThzLHJbU=;
  b=mffonLXOHss5LgmszvYxumxtueKbzD0ohKCtTJc0YSEiq7Ell2Rf3Mex
   oeG1xP0L9XMsNS6Ab9loJaS+IJGULZN6vYJyIw7p9/MhHMPBygFJJjNjC
   Qfpg+apfdB3t2qtkyFv2jkt51SdB2k+JAh7wGngNhqfSoPf4Pf9ZBpwsk
   RmmqVIBry8fY7nAdO1B9B1cXAIAnSfagg0Tb16Gpp2ruTarNca3y27YCr
   ZRPFoIc+DQ5k150Nc6RcyWolYb6SmVAFZFFdX1TLjQ8k529MbvqH5lLYt
   PtzCu2wL/Ek6LYXR4ph4W6WYtwfs+0gUImtSxiQjbVf3nNyl20g425Fk/
   g==;
X-CSE-ConnectionGUID: +/n3PPHnSWiIu83/JumCeA==
X-CSE-MsgGUID: OEPI4hn4TouskGRjmodebA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343640"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343640"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:54 -0700
X-CSE-ConnectionGUID: DoDQZtJTT+yi14a07HMvVw==
X-CSE-MsgGUID: mSvXtG1eQFWCdpfDoXvgWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576167"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
	anthony.l.nguyen@intel.com,
	allen.lan@intel.com,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: [PATCH net-next 14/15] igc: Support ACPI-based MAC pass-through
Date: Wed,  5 Aug 2026 14:35:39 -0700
Message-ID: <20260805213541.2281287-15-anthony.l.nguyen@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Some systems implement a system MAC address object in the ACPI table,
using either \\_SB.AMAC or \\MACA object names. This system MAC address,
when enabled, is intended to override the permanent MAC address of the
network controller.

Implement lookup of the relevant ACPI object names and use them to
initialize the MAC address.

On systems where the feature is disabled or unsupported, the ACPI objects
do not exist or do not contain a valid Ethernet MAC, causing a fallback
to the existing MAC address initialization path.

Assisted-by: GitHub-Copilot:claude-opus-4.7
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 64 ++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 21d2fe38a41a..424c12c0394a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -11,6 +11,8 @@
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/acpi.h>
+#include <linux/hex.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
 
@@ -7105,6 +7107,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static bool igc_get_acpi_mac_passthru(u8 *mac)
+{
+	static const struct {
+		const char *name;
+		acpi_object_type type;
+		u32 length;
+	} sources[] = {
+		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
+		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
+	};
+	struct acpi_buffer buffer;
+	union acpi_object *obj;
+	bool mac_found = false;
+	acpi_status status;
+	u8 buf[ETH_ALEN];
+	int i;
+
+	if (!IS_ENABLED(CONFIG_ACPI))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+
+		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
+					      NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		obj = buffer.pointer;
+		if (!obj || obj->type != sources[i].type ||
+		    obj->string.length != sources[i].length)
+			goto free_obj;
+
+		if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
+		    obj->string.pointer[21] != '#')
+			goto free_obj;
+
+		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
+		    !is_valid_ether_addr(buf))
+			goto free_obj;
+
+		ether_addr_copy(mac, buf);
+		mac_found = true;
+free_obj:
+		kfree(obj);
+	}
+
+	return mac_found;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7268,9 +7321,16 @@ static int igc_probe(struct pci_dev *pdev,
 	}
 
 	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
-		/* copy the MAC address out of the NVM */
-		if (hw->mac.ops.read_mac_addr(hw))
+		/* Look for a system-provided MAC in the ACPI table before
+		 * falling back to reading the address from the NVM.
+		 */
+		if (igc_get_acpi_mac_passthru(hw->mac.addr)) {
+			netdev->addr_assign_type = NET_ADDR_STOLEN;
+			dev_info(&pdev->dev, "Using ACPI pass-through MAC addr %pM\n",
+				 hw->mac.addr);
+		} else if (hw->mac.ops.read_mac_addr(hw)) {
 			dev_err(&pdev->dev, "NVM Read Error\n");
+		}
 	}
 
 	eth_hw_addr_set(netdev, hw->mac.addr);
-- 
2.47.1

