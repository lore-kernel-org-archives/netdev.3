Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276D42902E;
	Fri, 31 Jul 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507576; cv=none; b=fQ6Og6opD5bQKyUzkOg68OuTGJHuctelLC0Kg58fWqWFa7cdlRqNkaQdDEfoTCayKLu1LMbQO0D+BTX93bcbP1mZAzMwMSKVWBBWNC7CmitaJKxG3j2KHtMwYKo7/H7L1wTyRBRII9pAUrptLXfBBYgb3GwoUDlH8L2lFg2Z5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507576; c=relaxed/simple;
	bh=FW3GVl2KrQAaWnVDxE749UsbkFFRvKHl1f3RCmAtCqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClfF1AJqvf0lZzQnqV3/ukwQanSS5UO/uc3aTjBI8KkmoRG5Wk0AgtKct5yDWioobh7WFdXp0HvShaffoXPZS0YPvGC9P9BMk7geI1edrodCUTvpmvgtmos5rRo59QyE+B1pfrp/ERqI6xEf82ooDQ/o0iRbicQnmXJ/0lM3btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAC3wT_brmxqABhKAg--.22001S2;
	Fri, 31 Jul 2026 22:19:08 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Elad Nachman <enachman@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH net v2] net: prestera: validate firmware header length
Date: Fri, 31 Jul 2026 22:19:06 +0800
Message-ID: <20260731141500.1-prestera-v2-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wT_brmxqABhKAg--.22001S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3Ww45GryrCFW5ZF1rtFb_yoWkKrXE9r
	n7uFn3Gay5GFsI9a17Kr43AryakryDuFn5uw42y398Gr1kWa12qr18CF4fJF1DWrW5Xr9x
	Gryxtr4fA345KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

prestera_fw_hdr_parse() reads the firmware header before checking
that the firmware image contains that header.

Reject images shorter than struct prestera_fw_header before decoding the
magic and version fields.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260706092602.79240-1-pengpeng@iscas.ac.cn/
- target the net tree in the Subject as requested by Andrew Lunn
- rebase onto the current tree

 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 2989a77e3b42..1ad0e62a8433 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -684,6 +684,9 @@ static int prestera_fw_hdr_parse(struct prestera_fw *fw)
 	struct prestera_fw_header *hdr;
 	u32 magic;
 
+	if (fw->bin->size < sizeof(*hdr))
+		return -EINVAL;
+
 	hdr = (struct prestera_fw_header *)fw->bin->data;
 
 	magic = be32_to_cpu(hdr->magic_number);
-- 
2.50.1

