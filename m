Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14B37AA94
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879310; cv=none; b=gsFFoChMQloT3TYyrcsQUKdd+pQ9wf0UhnInBQ9pv1YdYGGGqU73ESQ/m+N5WcTb3PfaNox8vDvarodmbGPJv+GJ/kzz0U1UZeojLad3FKOPAEuyHmueHwQaDUcfzMcJzVKLcP39Vl6L0JvepztY4NZXrrZ2F9ZeLl2O8nA8HWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879310; c=relaxed/simple;
	bh=r42ZsyadleQTtIc94n1MjmuA+isQUHSG2kaSAj79bgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JH0QBelo9C2t6FW42pB4e0GwC+gOR+6t4Kb7PNsZMlYF5hCYUMw4Ihxd2B+QJ/IGL1nNBD6M5UB0qV/LDxIBTBml7RLf2jkIlbQt3OBs/rOAESBRppuDmUjl33dwbbFsDZQxp3dw64vaMGuaYxNnbkbMk6LtG6EWHXzrHYjW64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1784879228t8dc00160
X-QQ-Originating-IP: G9t+N0wCxV8iMfiSjPRp809URlSxn8R5X+ZiOskeP40=
Received: from w-MS-7E16.trustnetic.com ( [115.227.112.172])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 15:47:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16318405119025710960
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix FDIR ATR queue mismatch for software VLAN packets
Date: Fri, 24 Jul 2026 15:46:57 +0800
Message-ID: <0879DA38A8E32701+20260724074657.10773-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NyLW0J/PDRHl1c1tuztL1JUzJrY+Kf7zextEDEJel5MD6JUDKmtWIgq1
	QHT0mR6kPzZiufO/dde0OhrNc1jaMx83heZMku/12cD24n3P9gnRntmuFrsGSoX+SVxXxxQ
	gDZjszQLfCf/iwV4nP5o6Un3kZgv7s0FN/kV0V0lpvuvFV8A1GlUD84IxbyqazOU/zj/JVj
	VCtddlanx3GKUG+gs6RkLU0QePaL5Sh78xxelaltkTTvMRcVSlNkUFgsAjK6tQVB/T2jj/N
	OEfVafD7Ey4K3HItkQw/QKm/ACXFfZIGopbsz+06NRh06B22vndbEUWdq6p7yuVLp8xPXf6
	wms4a66LDI/Ae6DanhX5sale4dRbUzKhP2A3yGrCFKlbaTwYnQYLF6JTy2JG5to8yvWikoe
	h70HqQ9lADiJLiEwmB+s4tFrtGmBK31Vkus2RNvL+igYcKYdyTestOaRUZcOzuEWlYtt/Jn
	r8deg99TBkeuazJugrk291QGFwjCoZFliVdDslrAzZaLvbyeHpld8JNDxdTTtUQucwxb5yx
	omQ8ul6MYoyGv/6654uEj4YvDgvyxi39gwwwbiT0WagGtRAoMxmXHq2hjFYZ/IFV63+02nP
	SYav5XMx2Yn/3gR+tPTzJ3fKcliy5fWXX9hUCWGCEfx4MlAshrvsBynXmli2SOnAl+tQYY/
	L3LcCWopEfTazqdE0UugspnYY/AHu3ehhpPDb/LZuFsBJGmUzyHJClPq9tlMv0ph73k+6CU
	SKKXt+UDkA+DkTKfDqvNRalH9DwZJlIkadh+DPS3bedR8oSC2YkRG7KwVp/thVycRkUdKE4
	9xcugEuZKydbpyNe0PpRkjP8vhXTOPfcOGhPrfBoKIhXUPyCGPP+rbnfKnp9x/oTc4HQ22t
	zWaxBNv7g4SiMUM6MdJGE5ZfSuDP5hS2B5EEfJZas5EdWGw95jgf/eZzsP2cZUhRuRebVZU
	LZbLWn6JUlJxe/rpV/eXLpppygMvGvdEHLwJKvXvDS73Ln0ghSHqpNWeyfgfsOvTFiacply
	SdnyOC4+a9LbLw3LXFI1bjyYLXVIDSV07sRiiLuQUkmLcQ6RjmGBWEhSrjS6pl6UhEpS6nP
	mgC2aWEMmDD
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

When TX VLAN hardware offload is disabled, VLAN tags are embedded in
the packet payload (software VLAN). Previously, the driver failed to
set the WX_TX_FLAGS_SW_VLAN flag for these packets during transmission.

This missing flag caused the txgbe FDIR ATR logic to fall through to the
default hash calculation path. This resulted in asymmetric hash values
for Tx and Rx flows, preventing return packets from being steered to the
same queue as the transmit packets.

Fix this by detecting software VLANs via eth_type_vlan(skb->protocol)
and setting WX_TX_FLAGS_SW_VLAN. This ensures the ATR feature selects
the correct hashing algorithm to maintain Tx/Rx queue symmetry.

Fixes: b501d261a5b3 ("net: txgbe: add FDIR ATR support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 814d88d2aee4..5d99e870de5e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1606,6 +1606,8 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 	if (skb_vlan_tag_present(skb)) {
 		tx_flags |= skb_vlan_tag_get(skb) << WX_TX_FLAGS_VLAN_SHIFT;
 		tx_flags |= WX_TX_FLAGS_HW_VLAN;
+	} else if (eth_type_vlan(skb->protocol)) {
+		tx_flags |= WX_TX_FLAGS_SW_VLAN;
 	}
 
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-- 
2.51.0

