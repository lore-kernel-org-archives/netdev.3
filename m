Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FE34A76A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281438; cv=none; b=nbroIl3edrpvTTw1hilBfTLKBiPJhZ4RpTUi6ApJacqfoLwbCDzjHd7F+CM4VoOUQbhFSf/VCGpPkgfYTynspoJdowl1Cd5ZlDjXRc4RRJMJCiPpexYteIJOdcGuyxkjuvyPkAse2PBc9TsR7Idfeq67bvxB6FzEyeVFyPv/0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281438; c=relaxed/simple;
	bh=hpKVzP1DmRoecduP8bI/ozE8B53XIPIzxHhqQTgfrkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0oGzFSkgR+M+gsZ9ORQVj4Hu/ByQHgYn25mGdRbNir9QDx/CnXZm4IujTTDrk6mQhjo+HTGRaAVY3lc5YQhXz94W2O6GzMJBD2x3T+tAfRYjwbTygpjIU1ZIMW4azMlVXDP+AfivlxX0JHQw0xWFXl7J265y+E5Bt2HYO2Ic6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=qHbkn/Xh; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="qHbkn/Xh"
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6158oWoE095645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 17:50:33 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=vzZSPwzsQrlN833+ulO08E4OEkrP3Y5ctEKzjtV2B+Q=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770281433; v=1;
        b=qHbkn/Xhh5GCW3lqtt3BFNbRWW2diSTeAbyG65f/JYW0cpqRPrvOWQfIqoP9ADEk
         xtXMlputaR8IBEMaPyQ0yZJS7/cnJHY0v/edvAP9nO+3zE2eEhmcHODVYMGjkG6o
         hOxhNtQeP+1MQ1JClMAJp6inMhph9FdxS0ta3QbbNTkCrV5+W7G+wtXlKziqqdih
         OMhQjz2d+pysDFsaqGqaCMDLCLV92fMGb/ORDuKBtbCPTYHWOZ+E1rsgreVjGWLz
         vZeYjkDgLCDRfP6YcbveoWH891MTrgHKjZwMdp3WJ6L70qdtww0XJLENEkgj1QTK
         XA8ezhbJ8QIZURItM1FPZA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] igc: fix null pointer dereference in igc_eeprom_test() on NVM-less devices
Date: Thu,  5 Feb 2026 08:50:26 +0000
Message-ID: <20260205085030.60080-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On devices without NVM, hw->nvm.ops.validate is set to NULL, therefore
functions that perform EEPROM-related operations such as
igc_ethtool_set_eeprom() and igc_probe() check for NVM presence in
advance. However igc_eeprom_test() unconditionally calls
hw->nvm.ops.validate(), potentially causing a null pointer dereference.

NVM-less devices may not be common but possible, so add NULL check
before calling hw->nvm.ops.validate().

Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..973d26a5a6c9 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -158,7 +158,7 @@ bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	if (hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
+	if (hw->nvm.ops.validate && hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
 		*data = 1;
 		return false;
 	}
-- 
2.51.0

