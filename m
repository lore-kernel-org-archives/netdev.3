Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E914E8E1C;
	Thu, 17 Sep 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646177; cv=none; b=GBzvusFZPXzw/fcDtXg9RWYLzCbFDdqxGOT2LwVEDTIO3d4QCMYYob3XIeevJEDZF/sPb3bwrag3b9iv6PJnFpF1Z0IOR2/gdVOspShxD03wDhhfVJ9ug+F99nOGAeEbfFkrd5MjDWtctCS+zgJAeBbFA24oyYU53TI0TJVxUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646177; c=relaxed/simple;
	bh=086HMkcWcRLtLvQyvCIw3g8fr4CUnor51uD9oXQzAg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BO90LW5XstusnA1Iq9buf13+UlkWJGPIlkp+QJjjIOPelmI2pV3qHpUUB62yz8myHZjrg3q/n3cNqhTaLVOeNuxcgoj/CwLkUEQL3jlpb9TLEmGS3HH1rN3QgiW7lsURVW0kCxMnBuqzxZTFBZAuPxP6DYxchMgB3PnWe/aWfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Tjy9jsK6; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Tjy9jsK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s9
	qKYNc97ZRCTEGg6bKz2qHXyTBZBA/5/Nj/f2XJWcM=; b=Tjy9jsK6QghTSUSg0P
	Z9aBHdRrDdEclmthhsRT9MieFmSmpbLxwcM4cQe63JpazbuvyhzUDWQKB90YPuCy
	EOEeXSA/a71JW4evSOjIZrjQObWcXhud2rMx7rfhyYHF3D8heMLzl+SJP0sdrO0I
	D2RDpgItVplLWuBu7p+EWa9rg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCXHLgB1atquGrBHw--.64446S2;
	Thu, 17 Sep 2026 19:54:42 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI command buffer backup on retry
Date: Thu, 17 Sep 2026 19:54:39 +0800
Message-Id: <20260917115439.1323766-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCXHLgB1atquGrBHw--.64446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7XrWrurW3ArW8JrW5Wrg_yoW5Jr4DpF
	WruryfAFs5XFW09r97XayUXFWY93W0qrW5KrWSvan5ur18Ar4qvFyUtFy0ka48urWIqF1a
	qFZFkw4fC3WDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlPfdUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAL60Wqr1QLJeQAA3b

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_aci_send_cmd() saves only the first byte of the caller's buffer
before an EBUSY retry, using kmalloc() plus a single-byte store. When
retries are exhausted, the caller's output buffer is filled with
uninitialized slab bytes, because only the first byte was saved before
the retry. The firmware itself does not see this data, since the
retryable opcodes do not set LIBIE_AQ_FLAG_RD, but the caller still
receives garbage in its output buffer.

Replace the kmalloc() plus single-byte store with kmemdup() so the whole
indirect command buffer is saved before an EBUSY retry, skip the backup
when buf_size is 0, and key the restore off buf_cpy instead of buf,
exactly like ice_sq_send_cmd_retry() already does.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
V1: https://lore.kernel.org/all/20260912013403.2818191-1-xiaolinkui@126.com/

V2:
- reword the impact description: the firmware does not see the
  uninitialized slab bytes, only the caller's output buffer does, since
  the retryable opcodes do not set LIBIE_AQ_FLAG_RD (Sashiko)
- fix the ice function reference: the kmemdup()-based backup lives in
  ice_sq_send_cmd_retry(), not ice_sq_send_cmd() (Sashiko)

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

