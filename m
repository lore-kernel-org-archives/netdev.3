Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693C4BEE36;
	Sat, 12 Sep 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176911; cv=none; b=ETIcQmOlBa1SvMHyT2suhVe8JP5QcaHAIt2te6MPXc1uLms88ldZCoMD1K89Ko27OuO02ELf+o8zvXv3JpORchqjZ/XkUL6uPaV3K0S2s0ZYdkEYXEnn6QE4HTL9KR4f993z6ogkhZ5ADdHNjn6oBHSmQUU4HOAtS0fFBs0WP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176911; c=relaxed/simple;
	bh=GQrpXj/EoHiq0d7y4bhq7ebIOFeO6urL2IUBWZQToHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L75E5cSFuEMqCDRHpwzo0/+falKUD+mkQerJxXHkVclYBfUSI+2V3bJsjLiACcIUUgFnbaCWdzPwD0QC6vOnNPsLe1qi8QzUu2ykFvjMRTxcK7C6oPFXNkvclgOaWdUIySBrmpGP3X/7vz5PuXLMMmi389SAdcP2Rf4qvhvsTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oLXTLqak; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oLXTLqak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o7
	8Hqq6g/lBoilGmoy0z1ftAj0h9kvkoIITlXb/oArQ=; b=oLXTLqak803ESVHVfL
	y6pGU8lgTI2EFLofFcZRV0vIm8PIQhsuB9rfx95OZ97ZOLl8t7PH1Hn3U6X0Y4xZ
	rjebZb7KjWysXSMRKIk2Iq34s6P7DBl5Xq33xVGhOtRQNpObeQhSBPPxN6wgo8NS
	RiIV4b6zmwfAZDYFOXxMIsxhc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n3IMrKRqxdEPBA--.2642S2;
	Sat, 12 Sep 2026 09:34:04 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
Date: Sat, 12 Sep 2026 09:34:03 +0800
Message-Id: <20260912013403.2818191-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n3IMrKRqxdEPBA--.2642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8Ww4rKryfZryUKFy8Xwb_yoW8trWfpF
	4rWF93AF4kXr4rurn2vw48XFWY93WIqrZ8K3ySvws5uw10yr1qgFyUK3W0kry8urWfXryS
	qFsF9w43Ja13J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQzxyGqkrAzCRgAA32

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_aci_send_cmd() backs up the indirect command buffer so that it can
be restored before an EBUSY retry, but the backup only copies the very
first byte of it:

    buf_cpy = kmalloc(buf_size, GFP_KERNEL);
    ...
    *buf_cpy = *(u8 *)buf;

while the restore path copies the full buffer back out of it:

    if (buf)
        memcpy(buf, buf_cpy, buf_size);

So every retry hands the firmware a buffer whose content, apart from the
first byte, is uninitialized slab memory, and on a read command the
caller's buffer is overwritten with that garbage when the retry finally
gives up. The buffer of a read command is an output buffer, so the caller
does not initialize it either.

Use kmemdup() to copy the whole buffer, exactly like the equivalent
ice_sq_send_cmd() already does.

Also skip the backup when buf_size is 0. kmalloc(0) returns
ZERO_SIZE_PTR and the single byte store above would write to it, and
restore based on buf_cpy instead of buf so that this case never passes
ZERO_SIZE_PTR to memcpy().

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 4d8ae5b56145..5dd88ee7ea58 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -214,11 +214,10 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
 
 	is_cmd_for_retry = ixgbe_should_retry_aci_send_cmd_execute(opcode);
 	if (is_cmd_for_retry) {
-		if (buf) {
-			buf_cpy = kmalloc(buf_size, GFP_KERNEL);
+		if (buf && buf_size) {
+			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
 			if (!buf_cpy)
 				return -ENOMEM;
-			*buf_cpy = *(u8 *)buf;
 		}
 		desc_cpy = *desc;
 	}
@@ -234,7 +233,7 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
 		    last_status != LIBIE_AQ_RC_EBUSY)
 			break;
 
-		if (buf)
+		if (buf_cpy)
 			memcpy(buf, buf_cpy, buf_size);
 		*desc = desc_cpy;
 
-- 
2.25.1

