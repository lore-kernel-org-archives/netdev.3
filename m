Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486748;
	b=vvJHhv2jQE2EVLxL51rzb5Qsfmjyx5cnC2EtSVIvKEuVOtNf34/kuyDDrkUZFy5OCIWd
	 6xbUgPH9M8Wg984jIdecffk3KoS3j/fovgCTDcvP54VXmhHoRa8161cq/elUhfq3772t9
	 1yc/KXTfGvne5gAjsQUvM0OWl3t+11wqAIN4c44rcpLvJHDtu1PwQsniNGxuWgB/gGPls
	 8E7l/cwYckFbB/vqMU7jpVCKoqjKOTXUZUA7k0QGE3AooFi5SROqXQA1Mb4qX4iRmj+Uw
	 fZ4QzBcIr6PBIUBTINprtcRw5DR74RqYCL9Ax02ZOHjAsnVMb8kZFbuM0/pysAraHQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=DlRQrLuCp1pQiPvoZuE03RamHxP4GUYs64HC5pBSfnk=;
	b=KyEPl4RdWe/gFZtB9AYaMHTOpT8FGLMmyBavphYb55e8QNhJqsCtIUHK0uG14onu7rJt
	 MRozm6jxHmsTeNTUYtq19BEp0pQRYrSw53PPf7OjKgEUFMXikbbeiIMeziQ9K0x/4fxZg
	 aB41R4AnSoPqtvLB1Xo8A0PY9tAYSl+eR0OE4k82YJkriP0XkfpMReB7QLW/Nb74UuWRI
	 v8JCGjADcC4sEaJmfUy6JDa2+3SuHlkDew0Of4WfBLUCd6KeCu6sPcMnJpVdzmc0HxtuZ
	 r2y6AxUU+T6x7LuxPKFmB9+uOk7zuCbIQ0StVpsFZ5ClXB0uFf5We/nNVojyK8wfX0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=XT0Yt2yT;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13B606A31A;
	Tue, 20 Oct 2026 08:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA13B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=XT0Yt2yT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792486746; x=1824022746;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=FIHdx2fBc52egtG9sz56x/Sle9+Dbim4lb5RV7ZqdVc=;
  b=XT0Yt2yTHNqI/TW4Y6Sq4Hw/ljhGoKVlWEvA9XRq5SP9M0GX3/HTn0Jj
   bkT3H2FE+sOq6NUOIDndgn8mOABRADCgBs3DBW+WJPDIJrXRmokaQEwYD
   guCS/j2TmFElPnmmpuDitg5aSJIaBqHWw1PQLvurzPYEsVF/7+I0VHEzx
   0oTPwjaaCWSXg9Gi49RQCegR1hRq4I9i9eiUe8LRdg5upRcjkRwNUeOVD
   u+yHQsZph5IVwmsACV+WExjdmMtGtYXOb+qbIqRVj7fPGhkpx/oV0dsu5
   VLEg94LSf4q8Rlknrsa1mhzu9/FajBZTJwSeAR2qHlZRlikW/pYR5mIG1
   Q==;
X-CSE-ConnectionGUID: o8FD05qDQcuAdhvUGHh3Fw==
X-CSE-MsgGUID: BZp+t77KTViALDwbfgmOQw==
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="75728452"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:59:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 20 Oct 2026 01:59:06 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Oct 2026 01:59:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 20 Oct 2026 10:58:58 +0200
Subject: [PATCH net] net: sparx5/lan969x: do not clobber the PSFP cycle
 timer update period
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-sparx5-psfp-cycle-timer-v1-1-00f2908f096a@microchip.com>
X-B4-Tracking: v=1; b=H4sIAFEt12oC/x3MwQqDMAyA4VeRnBdICg70VcYOXU23wOxKIkMR3
 93i8Tv8/w4upuIwdjuY/NX1Vxr41kH6xPIW1KkZAoU7Ew/oNdraY/VcMW3pK7joLIaJQh4ivVi
 IodXVJOt6nR9QZIHncZxKD/5JbgAAAA==
X-Change-ID: 20261019-sparx5-psfp-cycle-timer-c02f9a0b1e01
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon Horman
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_psfp_init() enables the periodic stream gate cycle timer update,
which keeps the cycle start time of each stream gate within one cycle
time of the current time. SG_CT_CLKS sets the update period, in system
clock cycles.

Before this patch, the update is enabled with a full register write of
SG_CT_UPDATE_ENA only, which also sets SG_CT_CLKS to zero. That is below
the documented minimum, the number of stream gates (1024 on sparx5 and
256 on lan969x).

Write both fields, and set the period to the recommended 10 us,
computed from the core clock since it differs per target (6250 cycles
at 625 MHz, 3280 at 328 MHz).

Found by an AI code review agent, and confirmed on lan969x and sparx5
by reading the register back as 0x80000000.

Fixes: e116b19db202 ("net: microchip: sparx5: initialize PSFP")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 83b37f95ee46..fa19a48f941d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -322,6 +322,7 @@ void sparx5_psfp_init(struct sparx5 *sparx5)
 {
 	const struct sparx5_ops *ops = sparx5->data->ops;
 	const struct sparx5_sdlb_group *group;
+	u32 sg_ct_clks;
 	int i;
 
 	for (i = 0; i < sparx5->data->consts->n_lb_groups; i++) {
@@ -330,7 +331,14 @@ void sparx5_psfp_init(struct sparx5 *sparx5)
 				       group->min_burst, group->frame_size, i);
 	}
 
-	spx5_wr(ANA_AC_SG_CYCLETIME_UPDATE_PERIOD_SG_CT_UPDATE_ENA_SET(1),
+	/* Poll the stream gate cycle start times every 10 us. The core clock
+	 * period is in picoseconds.
+	 */
+	sg_ct_clks = 10 * NSEC_PER_USEC * PSEC_PER_NSEC /
+		     sparx5_clk_period(sparx5->coreclock);
+
+	spx5_wr(ANA_AC_SG_CYCLETIME_UPDATE_PERIOD_SG_CT_CLKS_SET(sg_ct_clks) |
+		ANA_AC_SG_CYCLETIME_UPDATE_PERIOD_SG_CT_UPDATE_ENA_SET(1),
 		sparx5, ANA_AC_SG_CYCLETIME_UPDATE_PERIOD);
 
 	spx5_rmw(ANA_L2_FWD_CFG_ISDX_LOOKUP_ENA_SET(1),

---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-sparx5-psfp-cycle-timer-c02f9a0b1e01

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

