Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB113B7A3;
	Mon,  6 Jul 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329921; cv=none; b=HP5yM+sve1FeL9f+5WvaPkb17hF6EuePhTHNPFQh2k5+8ljp6o/7fZ1m2npQXqQBnMWR8O3f6ZxMO0ulWghXXDAcZiJwZreAkIblgKZMt+cw0WeJdj5hiNQTUhNUZn4fdAJHo65LxUrNzaQ+hRYbvzFoHH0K90O76aAPB5xpFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329921; c=relaxed/simple;
	bh=u94H4sAGOniwUpZClYk8o6VW9VC7ZamnKnhb5tQIFLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsUR54TYTANP1HQQsy0qWWSuG9QM7hzRrVQ/GoHwGGy914Wn8tQQF+Wy0blZugdtyFw4q9SAGF1Bj7DSSZ87petMsUkFwo0/N50luqZqrX/POCUXwjxKLDGWze/WFhUtKCBhD2GOo4nlI4xKxAnW0xAtKA52mXVysQsDCs786YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACHK9RudEtqxUvxBA--.35001S2;
	Mon, 06 Jul 2026 17:25:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ixgbe: validate E610 PFA TLV bounds
Date: Mon,  6 Jul 2026 17:25:00 +0800
Message-ID: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHK9RudEtqxUvxBA--.35001S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw15Gry8Kw17JF18KryxGrg_yoW8JF18pF
	48Ga4fWr45XrW3WF4xXw4rZFZxuayI9r4fWF9ayw4rAF4q9rWUCanxKa47tw1UAr4UWr1S
	vF15Aws5A3WfXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
EEPROM.

Stop parsing malformed TLVs whose header or declared value length would
exceed the PFA boundary.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 4d8ae5b56145..03e88bdf5a43 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 	while (next_tlv < pfa_end_ptr) {
 		u16 tlv_sub_module_type, tlv_len;
 
+		if (pfa_end_ptr - next_tlv < 2)
+			break;
+
 		/* Read TLV type */
 		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
 					     &tlv_sub_module_type);
@@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 		/* Check next TLV, i.e. current TLV pointer + length + 2 words
 		 * (for current TLV's type and length).
 		 */
+		if (tlv_len > pfa_end_ptr - next_tlv - 2)
+			break;
+
 		next_tlv = next_tlv + tlv_len + 2;
 	}
 	/* Module does not exist */
-- 
2.43.0

