Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07543E5ED1;
	Mon,  6 Jul 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330459; cv=none; b=KhQL9JSQ0evbO8OY/qXgEG3SVwsZBxcxaWOzsH0vl+jtu8I7rTYXJaUwrhL3jKbr1pLf84DRF8Ao4OYPk56JTwDEuEdMj+Cko648LalJ/Bju/UCU+tYEksPoZ34E0Ggx8u/G/+10l+CVL1bquxtbIF3EpTwfdkOiLzESFQ+bF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330459; c=relaxed/simple;
	bh=jJM8EHcPKmodcduUHQf+XPYE8Gcu0XLeUc3KfcWOBOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gpj3uXUmuEypWTvG7NTcPDpAEt9Co0wQBi4tzBTJA9ym2zyIRloMH5LsTTj4BDDCyPQsOdNPIukfyp+HtVz5BYHdGyocKZocLjEsfO9vKFKPRI5E4DI/hks2li79wX+EJ5zp09QJcso/WAZHRcPiWjzXZQyCMjmQvV3vQgGaOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAD3mNGNdktqhIvxBA--.35187S2;
	Mon, 06 Jul 2026 17:34:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Sudarsana Kalluru <skalluru@marvell.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: bnx2x: validate firmware section bounds without overflow
Date: Mon,  6 Jul 2026 17:34:03 +0800
Message-ID: <20260706093403.81017-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3mNGNdktqhIvxBA--.35187S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF15Cr4fWr47JFy7tF17trb_yoW8ury3pa
	1DGFW3Gr47GF13Cw40qa1DZF9Yk393J3yDGFyUCa95Z34Syw1kGas0kay2gr1UGrWkAw1a
	gFn8AanxuFn0vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The firmware loader validates each section with offset + length before it
uses section offsets to read data from the firmware image. Both fields are
32-bit values from the firmware header, so the addition can wrap before it
is compared with the firmware size.

Validate sections as offset <= size and length <= size - offset instead.
Also require the firmware version section to contain the four bytes that
bnx2x_check_firmware() reads later.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 208a894d6190..c756a639e6ee 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13258,6 +13258,11 @@ static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
 	return rc;
 }
 
+static bool bnx2x_fw_section_valid(size_t fw_size, u32 offset, u32 len)
+{
+	return offset <= fw_size && len <= fw_size - offset;
+}
+
 static int bnx2x_check_firmware(struct bnx2x *bp)
 {
 	const struct firmware *firmware = bp->firmware;
@@ -13281,7 +13286,7 @@ static int bnx2x_check_firmware(struct bnx2x *bp)
 	for (i = 0; i < sizeof(*fw_hdr) / sizeof(*sections); i++) {
 		offset = be32_to_cpu(sections[i].offset);
 		len = be32_to_cpu(sections[i].len);
-		if (offset + len > firmware->size) {
+		if (!bnx2x_fw_section_valid(firmware->size, offset, len)) {
 			BNX2X_ERR("Section %d length is out of bounds\n", i);
 			return -EINVAL;
 		}
@@ -13300,6 +13305,11 @@ static int bnx2x_check_firmware(struct bnx2x *bp)
 	}
 
 	/* Check FW version */
+	if (be32_to_cpu(fw_hdr->fw_version.len) < 4) {
+		BNX2X_ERR("FW version section is too small\n");
+		return -EINVAL;
+	}
+
 	offset = be32_to_cpu(fw_hdr->fw_version.offset);
 	fw_ver = firmware->data + offset;
 	if (fw_ver[0] != bp->fw_major || fw_ver[1] != bp->fw_minor ||
-- 
2.43.0

