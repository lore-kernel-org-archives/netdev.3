Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889E43F4B7;
	Mon,  6 Jul 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330637; cv=none; b=cpr815QeTWIvPw5Zp5oErcOLe4f4YAH3tRIjKywgVLwc0AhQED/BKY0unaZG1pd2R8eb8i4IcQasc4DeGWEapcM6QbL8UtIeFIKZpqJX6kemGiin34UUwpcXvSk/r42jh5BiReaAQ4cf4tEVqGKTHYDS87G3Oi85NOyBoKEkPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330637; c=relaxed/simple;
	bh=LOhRgOu6/jzWJQSkmgyN3ITZ3cd4kesyN5c2Yg+91S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8IItw4HPvXFxuOYQOf3r9J5IQUimz85w7PCKm42+b3G0OSsuONhhsGMa6au0c5p29sNF9f9Ab1ORWzgFC/Q8GkiPO+sfeTxOm11Tzhjv6TiFGUlSkublO+shEzjxXo5+Q3ajh6R6OIRyoXf+4wN8i0G4AQfTFKkgPmGpEmtC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABH6NA+d0tqEKHxBA--.1322S2;
	Mon, 06 Jul 2026 17:37:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Manish Chopra <manishc@marvell.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netxen: validate unified ROM directory bounds
Date: Mon,  6 Jul 2026 17:37:02 +0800
Message-ID: <20260706093702.81687-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH6NA+d0tqEKHxBA--.1322S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWkJFy3Jr43Gr18WrW5Awb_yoWfZr4UpF
	W5CFy0gw13ZF42gw4xJF18tFZxuFWIqrn5Kayj934UKrZ3Kr1ktFyDJrWfKF93ZrZ09rn5
	Aayq9a13AF4xArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The unified ROM parser walks directory and data descriptor tables from
the firmware file. The existing checks compute table and data limits with
base + count * size or base + size before comparing with the firmware
size. Those calculations use fields from the firmware image and can wrap
before the comparison.

Add range helpers that validate tables and entries with division and
subtraction instead of overflowing additions. Pass the firmware size into
the directory lookup helper, validate each directory entry before reading
its type field, and validate bootloader, firmware and product-table
entries before their descriptor fields are used.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../ethernet/qlogic/netxen/netxen_nic_init.c  | 148 +++++++++++-------
 1 file changed, 90 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 8bc4e2b69569..5722c55fa0cc 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -561,20 +561,55 @@ int netxen_pinit_from_rom(struct netxen_adapter *adapter)
 	return 0;
 }
 
-static struct uni_table_desc *nx_get_table_desc(const u8 *unirom, int section)
+#define NX_UNI_DIR_TYPE_OFF		8
+#define NX_UNI_DIR_ENTRY_MIN_SIZE \
+	((NX_UNI_DIR_TYPE_OFF + 1) * sizeof(u32))
+#define NX_UNI_PRODUCT_ENTRY_MIN_SIZE \
+	((NX_UNI_FIRMWARE_IDX_OFF + 1) * sizeof(u32))
+
+static bool netxen_rom_range_valid(size_t size, u32 off, u32 len)
+{
+	return off <= size && len <= size - off;
+}
+
+static bool netxen_rom_table_valid(size_t size, u32 off, u32 n, u32 esz)
+{
+	if (off > size)
+		return false;
+	if (!esz)
+		return n == 0;
+
+	return n <= (size - off) / esz;
+}
+
+static bool netxen_rom_entry_valid(size_t size, u32 off, u32 esz, u32 idx)
+{
+	if (!esz || off > size)
+		return false;
+
+	return idx < (size - off) / esz;
+}
+
+static struct uni_table_desc *
+nx_get_table_desc(const u8 *unirom, size_t fw_size, int section)
 {
-	uint32_t i;
 	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
-	__le32 entries = cpu_to_le32(directory->num_entries);
+	u32 entries = cpu_to_le32(directory->num_entries);
+	u32 entry_size = cpu_to_le32(directory->entry_size);
+	u32 findex = cpu_to_le32(directory->findex);
+	u32 i;
 
-	for (i = 0; i < entries; i++) {
+	if (entry_size < NX_UNI_DIR_ENTRY_MIN_SIZE ||
+	    !netxen_rom_table_valid(fw_size, findex, entries, entry_size))
+		return NULL;
 
-		__le32 offs = cpu_to_le32(directory->findex) +
-				(i * cpu_to_le32(directory->entry_size));
-		__le32 tab_type = cpu_to_le32(*((u32 *)&unirom[offs] + 8));
+	for (i = 0; i < entries; i++) {
+		size_t offs = findex + (size_t)i * entry_size;
+		u32 tab_type = cpu_to_le32(*((u32 *)&unirom[offs] +
+						NX_UNI_DIR_TYPE_OFF));
 
 		if (tab_type == section)
-			return (struct uni_table_desc *) &unirom[offs];
+			return (struct uni_table_desc *)&unirom[offs];
 	}
 
 	return NULL;
@@ -586,20 +621,18 @@ static int
 netxen_nic_validate_header(struct netxen_adapter *adapter)
 {
 	const u8 *unirom = adapter->fw->data;
-	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
+	struct uni_table_desc *directory = (struct uni_table_desc *)&unirom[0];
 	u32 fw_file_size = adapter->fw->size;
-	u32 tab_size;
-	__le32 entries;
-	__le32 entry_size;
+	u32 entries, entry_size, findex;
 
 	if (fw_file_size < QLCNIC_FILEHEADER_SIZE)
 		return -EINVAL;
 
 	entries = cpu_to_le32(directory->num_entries);
 	entry_size = cpu_to_le32(directory->entry_size);
-	tab_size = cpu_to_le32(directory->findex) + (entries * entry_size);
+	findex = cpu_to_le32(directory->findex);
 
-	if (fw_file_size < tab_size)
+	if (!netxen_rom_table_valid(fw_file_size, findex, entries, entry_size))
 		return -EINVAL;
 
 	return 0;
@@ -611,30 +644,30 @@ netxen_nic_validate_bootld(struct netxen_adapter *adapter)
 	struct uni_table_desc *tab_desc;
 	struct uni_data_desc *descr;
 	const u8 *unirom = adapter->fw->data;
-	__le32 idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
-				NX_UNI_BOOTLD_IDX_OFF));
-	u32 offs;
-	u32 tab_size;
-	u32 data_size;
+	u32 data_len, data_off, entry_size, findex, idx;
+	u32 section = NX_UNI_DIR_SECT_BOOTLD;
+	size_t offs;
 
-	tab_desc = nx_get_table_desc(unirom, NX_UNI_DIR_SECT_BOOTLD);
+	idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
+			     NX_UNI_BOOTLD_IDX_OFF));
+	tab_desc = nx_get_table_desc(unirom, adapter->fw->size, section);
 
 	if (!tab_desc)
 		return -EINVAL;
 
-	tab_size = cpu_to_le32(tab_desc->findex) +
-			(cpu_to_le32(tab_desc->entry_size) * (idx + 1));
-
-	if (adapter->fw->size < tab_size)
+	entry_size = cpu_to_le32(tab_desc->entry_size);
+	findex = cpu_to_le32(tab_desc->findex);
+	if (entry_size < sizeof(*descr) ||
+	    !netxen_rom_entry_valid(adapter->fw->size, findex, entry_size,
+				     idx))
 		return -EINVAL;
 
-	offs = cpu_to_le32(tab_desc->findex) +
-		(cpu_to_le32(tab_desc->entry_size) * (idx));
+	offs = findex + (size_t)entry_size * idx;
 	descr = (struct uni_data_desc *)&unirom[offs];
+	data_off = cpu_to_le32(descr->findex);
+	data_len = cpu_to_le32(descr->size);
 
-	data_size = cpu_to_le32(descr->findex) + cpu_to_le32(descr->size);
-
-	if (adapter->fw->size < data_size)
+	if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
 		return -EINVAL;
 
 	return 0;
@@ -646,29 +679,30 @@ netxen_nic_validate_fw(struct netxen_adapter *adapter)
 	struct uni_table_desc *tab_desc;
 	struct uni_data_desc *descr;
 	const u8 *unirom = adapter->fw->data;
-	__le32 idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
-				NX_UNI_FIRMWARE_IDX_OFF));
-	u32 offs;
-	u32 tab_size;
-	u32 data_size;
+	u32 data_len, data_off, entry_size, findex, idx;
+	u32 section = NX_UNI_DIR_SECT_FW;
+	size_t offs;
 
-	tab_desc = nx_get_table_desc(unirom, NX_UNI_DIR_SECT_FW);
+	idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
+			     NX_UNI_FIRMWARE_IDX_OFF));
+	tab_desc = nx_get_table_desc(unirom, adapter->fw->size, section);
 
 	if (!tab_desc)
 		return -EINVAL;
 
-	tab_size = cpu_to_le32(tab_desc->findex) +
-			(cpu_to_le32(tab_desc->entry_size) * (idx + 1));
-
-	if (adapter->fw->size < tab_size)
+	entry_size = cpu_to_le32(tab_desc->entry_size);
+	findex = cpu_to_le32(tab_desc->findex);
+	if (entry_size < sizeof(*descr) ||
+	    !netxen_rom_entry_valid(adapter->fw->size, findex, entry_size,
+				     idx))
 		return -EINVAL;
 
-	offs = cpu_to_le32(tab_desc->findex) +
-		(cpu_to_le32(tab_desc->entry_size) * (idx));
+	offs = findex + (size_t)entry_size * idx;
 	descr = (struct uni_data_desc *)&unirom[offs];
-	data_size = cpu_to_le32(descr->findex) + cpu_to_le32(descr->size);
+	data_off = cpu_to_le32(descr->findex);
+	data_len = cpu_to_le32(descr->size);
 
-	if (adapter->fw->size < data_size)
+	if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
 		return -EINVAL;
 
 	return 0;
@@ -682,39 +716,37 @@ netxen_nic_validate_product_offs(struct netxen_adapter *adapter)
 	const u8 *unirom = adapter->fw->data;
 	int mn_present = (NX_IS_REVISION_P2(adapter->ahw.revision_id)) ?
 			1 : netxen_p3_has_mn(adapter);
-	__le32 entries;
-	__le32 entry_size;
-	u32 tab_size;
-	u32 i;
+	u32 entries, entry_size, findex, i;
+	u32 section = NX_UNI_DIR_SECT_PRODUCT_TBL;
 
-	ptab_descr = nx_get_table_desc(unirom, NX_UNI_DIR_SECT_PRODUCT_TBL);
+	ptab_descr = nx_get_table_desc(unirom, adapter->fw->size, section);
 	if (ptab_descr == NULL)
 		return -EINVAL;
 
 	entries = cpu_to_le32(ptab_descr->num_entries);
 	entry_size = cpu_to_le32(ptab_descr->entry_size);
-	tab_size = cpu_to_le32(ptab_descr->findex) + (entries * entry_size);
-
-	if (adapter->fw->size < tab_size)
+	findex = cpu_to_le32(ptab_descr->findex);
+	if (entry_size < NX_UNI_PRODUCT_ENTRY_MIN_SIZE ||
+	    !netxen_rom_table_valid(adapter->fw->size, findex, entries,
+				     entry_size))
 		return -EINVAL;
 
 nomn:
 	for (i = 0; i < entries; i++) {
-
-		__le32 flags, file_chiprev, offs;
+		size_t offs;
+		__le32 flags, file_chiprev;
 		u8 chiprev = adapter->ahw.revision_id;
 		uint32_t flagbit;
 
-		offs = cpu_to_le32(ptab_descr->findex) +
-				(i * cpu_to_le32(ptab_descr->entry_size));
+		offs = findex + (size_t)i * entry_size;
 		flags = cpu_to_le32(*((int *)&unirom[offs] + NX_UNI_FLAGS_OFF));
 		file_chiprev = cpu_to_le32(*((int *)&unirom[offs] +
-							NX_UNI_CHIP_REV_OFF));
+						    NX_UNI_CHIP_REV_OFF));
 
 		flagbit = mn_present ? 1 : 2;
 
 		if ((chiprev == file_chiprev) &&
-					((1ULL << flagbit) & flags)) {
+		    ((1ULL << flagbit) & flags)) {
 			adapter->file_prd_off = offs;
 			return 0;
 		}
@@ -767,7 +799,7 @@ static struct uni_data_desc *nx_get_data_desc(struct netxen_adapter *adapter,
 	struct uni_table_desc *tab_desc;
 	__le32 offs;
 
-	tab_desc = nx_get_table_desc(unirom, section);
+	tab_desc = nx_get_table_desc(unirom, adapter->fw->size, section);
 
 	if (tab_desc == NULL)
 		return NULL;
-- 
2.43.0

