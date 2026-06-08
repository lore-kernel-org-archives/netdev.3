Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0CF3101D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902613; cv=none; b=b9WfyeLAZObncR82LzCkyI/NWrSguDXGAN086DaYMk/Pu6GmzcrcpTQ7P+xPNPA7N+IIT66jxfOuUTGyaIRVtENDeXizczNhLoO44f5O3uekvKYZBLuT3FZmJT147oa16sp9vVpd87coj1r3FOsNb2OxcQdvpAJ8v6CpGf/IuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902613; c=relaxed/simple;
	bh=YFKArg1umaXnXIGnxXL4S/B58HY+3pT5M5b+rNHc5uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnEx9bzd1115UQI87S1ipBc1CzkMF2PItx4Hi/TMZXnQ1gGkjvPpuWhRdHTPxc3nCsY9kv1lLa37uAcAOadjmwhsWcsNjGSFiaOeRXLDvLyNcFBVDQMwxXnZTdSfinrtD9L30boLahwdCUokqHXjWC/coxf37tfyGNHo6uOOlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1780902543t621014f6
X-QQ-Originating-IP: Iv5ScAM3wvmVdZlz1dNhxkDqoEudTlvYocDPjNqL994=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:09:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1869345008062573721
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: txgbe: initialize PHY interface to 0
Date: Mon,  8 Jun 2026 15:08:42 +0800
Message-Id: <20260608070842.36504-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260608070842.36504-1-jiawenwu@trustnetic.com>
References: <20260608070842.36504-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nvs1B4DXFZmrcI4VUhru6HwvjY3eoynncCFEEg466gYXdoGS+9xHJ5QS
	eHB72yrKwJ5FUulzsQELe2F7T34/S1M1Taf50JKYu17gqYBmPywP5fXsEmFPY9BzijHlht4
	8hOM43DUoFK7OigNP+wYwNlG1iLlTpvcmLqkoWqttRSko5dud09v0c3+CRbWoPa+dPpOUeN
	3BAK37ZuRxukkSea33sqpyumpbQk9DgPcsJih1fv6u9/3ZKM9mJJO5l8O4d9ZGydzWA9ngD
	UNEwW38ODayyYM0ZtRRo+skzdm8+478XlhNbkC9tNHc76dL2WBNXm9Kj8yWyw1xDWLq1Aek
	NIb1bNaIEwi6zPISV20kjUwqgTTDLczVMyk+3BJo39/u3VvAkJeYrBHna7wwfma8GCFr5Ok
	muZsU1HxeqKtl9SEgI2HPWUZFIxAjmmMttM6ZONGR070U6PxeeqnJODnJFdUM06NrCOaarc
	xJoGqe8cWlVEIzX88BNXT27v7ro7dEXFahVoXJDJHVSPkSfrYaoj5KWHeLOgfvfakhFKILG
	2XZAwcgjaDx5ktYV4R3EcJMpvBzL89yo1hwf73sVxxZ0ChjaQa7jouNY6HRdmyfzQQPbLfk
	IqvhyFLmG8nHdwyGPNmLjdo/6hude6XKG4lX6wsYkEk89kGMDSiHpB5zWurP3IWs71DHUEL
	XIlEs9HQ564y13e38vigQx1NZQu9jyHko+iI4ECdfNDLeG/RYRfkXod1+fo9pvW3UK45Anp
	AehDdaZgStFy1zX88LfbbakwX0Do/QV1SxBBJsZR2WxdzB8kJW50YYaRG+yLCYwQYm1XRZX
	ampkITYvXVtkDMsdg9278iT09IklHD4julpwCFZJMLCbu67++IjPIxjIAkNReD85rhLZ6wx
	mZXZqlU9vrJ8YaFmd4dzqXp4FfRea2U0kOXBCnUglCYYxry8X6Z7Yf6jl4pAT/jVn9ITvdP
	3L6brJwiNWmH7xS/UfnmOUCPCkJMQl9m3PwZTm5W8i8bR0C20d/GxxTdzs3VhK0MseJZ+ME
	RW80akulSZOp+2NDEzvkQ//P/PNS8kL8rINrBmo7HbP0UA4CQx5FzB1TomR9tqFnteqkZ5C
	ZemP1MTHPmAAPdqZ7dAUpZJtTzqcTqcVOu6BSVjTcJh
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

DECLARE_PHY_INTERFACE_MASK() does not guarantee zeroed contents. Add a
new macro DECLARE_PHY_INTERFACE_MASK_ZERO(), make the stack variable to
be zeroed before setting supported interfaces.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index bdac654a2364..8fc32df8e49a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -204,7 +204,7 @@ int txgbe_set_phy_link(struct wx *wx)
 static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
 	if (id->cable_tech & TXGBE_SFF_DA_PASSIVE_CABLE) {
@@ -271,7 +271,7 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
 	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 6b05f32b4a01..877234e3fdc2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -315,6 +315,9 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev);
 
+#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
+	unsigned long name[PHY_INTERFACE_MODE_MAX] = { 0, }
+
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
-- 
2.51.0

