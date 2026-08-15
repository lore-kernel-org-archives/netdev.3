Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEC2561A7;
	Sat, 15 Aug 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802235; cv=none; b=mO9SD6lKHRuEYLdi1jCfZnnqjkyNB1599CLHYWEyQUZF7wA0Gl+n/g0uitpIHbvdQVsls7o/XoPgab30CfsJzjE52vlu76YeEr1NgEYT2posVM3tuMlUKj3KUVrKOoUEi4cbv5aWXqA0hFpwCAfR3bbm4vlvpYG+QT9CYgNNEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802235; c=relaxed/simple;
	bh=QUfQXo0zNp+7ulCmKOxf92wLx8UuYdhxR10nqKuOodY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vDhxXEIkEEP2FRrV7XyeAGd7BWiTciljkzaIyTsvV30IDDe2C5pJT59x9Z5S5HBiw6O88WbO+UnG4pXTTMfAOxy0Slznqv16pLofDY+LnkRv86w/qm/edhkM1Slc9YG8SPq7NRD0voxbzrYuuAodfvKeg+J5pfnCpyGTROpzDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAB3p0EtcIBqbYHRBQ--.24051S2;
	Sat, 15 Aug 2026 21:57:01 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v3] ice: propagate ETH56G deskew poll failures
Date: Sat, 15 Aug 2026 21:57:00 +0800
Message-ID: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3p0EtcIBqbYHRBQ--.24051S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDCw43ZrWUWry7ur45KFg_yoWrCr18pF
	sakr9FyF1Fqw18XFWxJa1Iya15GanFyr4UGwsYyw1vyryUJFy5XF10yFyrt3WUKa4kC3W7
	ZFn7AF1xuFnrZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjTRCMKZDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ice_ptp_calc_deskew_eth56g() ignores the return value of
read_poll_timeout(). If register reads succeed but the DESKEW valid bit
never appears, the timeout is treated as success. If a register read fails,
the poll condition can also inspect deskew_i before a successful read and
continue polling instead of stopping on the hard error. The function then
returns an int error through its u32 deskew return type.

Return the deskew value through an output parameter. Stop polling when
either the read fails or the valid bit appears, then propagate the register
error or the poll timeout separately before calculating and applying the
deskew value.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260706144325.91320-1-pengpeng@iscas.ac.cn/
- capture and propagate the read_poll_timeout() result
- stop the poll immediately on a register read error
- initialize deskew_i before it is used by the poll condition
- do not carry the v2 Reviewed-by because the poll logic changed

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 42 ++++++++++++++++++----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8e5f97835954..76ee71400163 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1736,24 +1736,30 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
  * @ds: deskew multiplier
  * @rs: RS-FEC enabled
  * @spd: link speed
+ * @deskew: output parameter for the calculated deskew value
  *
- * Return: calculated deskew value
+ * Return: 0 on success, negative error code otherwise
  */
-static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
-				      bool rs, enum ice_eth56g_link_spd spd)
+static int ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
+				      bool rs, enum ice_eth56g_link_spd spd,
+				      u32 *deskew)
 {
-	u32 deskew_i, deskew_f;
-	int err;
+	u32 deskew_i = 0, deskew_f;
+	int err, ret;
 
-	if (!ds)
+	if (!ds) {
+		*deskew = 0;
 		return 0;
+	}
 
-	read_poll_timeout(ice_read_ptp_reg_eth56g, err,
-			  FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i), 500,
-			  50 * USEC_PER_MSEC, false, hw, port, PHY_REG_DESKEW_0,
-			  &deskew_i);
+	ret = read_poll_timeout(ice_read_ptp_reg_eth56g, err,
+				err || FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i),
+				500, 50 * USEC_PER_MSEC, false, hw, port,
+				PHY_REG_DESKEW_0, &deskew_i);
 	if (err)
 		return err;
+	if (ret)
+		return ret;
 
 	deskew_f = FIELD_GET(PHY_REG_DESKEW_0_RLEVEL_FRAC, deskew_i);
 	deskew_i = FIELD_GET(PHY_REG_DESKEW_0_RLEVEL, deskew_i);
@@ -1766,7 +1772,9 @@ static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
 	deskew_i = FIELD_PREP(ICE_ETH56G_MAC_CFG_RX_OFFSET_INT, deskew_i);
 	/* Shift 3 fractional bits to the end of the integer part */
 	deskew_f <<= ICE_ETH56G_MAC_CFG_FRAC_W - PHY_REG_DESKEW_0_RLEVEL_FRAC_W;
-	return mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+	*deskew = mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+
+	return 0;
 }
 
 /**
@@ -1789,6 +1797,7 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 {
 	u32 rx_offset, tx_offset, bs_ds;
 	bool onestep, sfd;
+	int err;
 
 	onestep = hw->ptp.phy.eth56g.onestep_ena;
 	sfd = hw->ptp.phy.eth56g.sfd_ena;
@@ -1805,11 +1814,16 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 	if (sfd)
 		rx_offset = add_u32_u32_fx(rx_offset, cfg->rx_offset.sfd);
 
-	if (spd < ICE_ETH56G_LNK_SPD_40G)
+	if (spd < ICE_ETH56G_LNK_SPD_40G) {
 		bs_ds = ice_ptp_calc_bitslip_eth56g(hw, port, bs_ds, fc, rs,
 						    spd);
-	else
-		bs_ds = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd);
+	} else {
+		err = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd,
+						 &bs_ds);
+		if (err)
+			return err;
+	}
+
 	rx_offset = add_u32_u32_fx(rx_offset, bs_ds);
 	rx_offset &= ICE_ETH56G_MAC_CFG_RX_OFFSET_INT |
 		     ICE_ETH56G_MAC_CFG_RX_OFFSET_FRAC;
-- 
2.50.1 (Apple Git-155)

