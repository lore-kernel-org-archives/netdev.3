Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B64334A1;
	Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892176; cv=none; b=T7ckCR2gzk88wWyh2ukS720dXujFdq/OlIABXvh/xDr8QZYNuhzp951dGukkj3MO4bnQ9C6IDAzIYzq+MDvVKsmTt7p0S1vr6kOOsxtS7+54gv0ITNhClYY9kMGHEi/gmbpe6I8ct6IvjJB8fTPw/pdRN3U7iKuzjtnn3DxXO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892176; c=relaxed/simple;
	bh=LwZ0ho81G5yOP4rd8DAK6lMvo2taH7hpVW+nEwE1qAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xuuq2oAXB8g4mVfqwIcoHD6YoUgVZPnGY/5ZXk60xTIHmb/HthTSxjg9LdNKGnzrMcpC16n6ZKjsW3O9B//vWU0QN0UJnfJyruyAudRvf+UGKidJR/x8jqUAG6ShLiworf5XdmcjLfI4QU9CeBa700YGJTxLRNXIHtCYlstQwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6PKWnPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6PKWnPy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4622C19425;
	Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784892175;
	bh=LwZ0ho81G5yOP4rd8DAK6lMvo2taH7hpVW+nEwE1qAk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=N6PKWnPyc1Tl4uOGFo+gbwEgS4r3xS6FlwY9Bdv+Xky4ec85iVkXNxwcpFQT8UuHH
	 nRh0zpMG2kwF9DLwT1Yw1qYIdw8C/p1GFp7JmNWlP78uh87fgLSj90k50fpYArOHD1
	 YvTPBwtupXCmosQBXEVRc/CcHGSqWk5jJ7L0krs4kOLqlDZY/zRXZJTKkibA1S+uTE
	 BK0D88s2+9A12cyXhqlotF5MbdhtFTRHGj+2kxkT+5C2U6ZT2DptOUFJXyjk+RqFG3
	 +YaRJm5eVbdgQAN4ktE1ual8pUbvuQXBTBZMdHt3GSkXm4vLfSQx0Ejm+rVpP8JnRT
	 qt34E2B3SRtkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8DC531C9;
	Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 24 Jul 2026 06:22:55 -0500
Subject: [PATCH v3] nfc: fdp: bound the device-reported read length and fix
 an skb leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-b4-disp-e8ec6012-v3-1-3a6f3a2fee47@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ5AMBBFryKz1qRK2sZVxIJ2MBZIB5GIu2tZv
 p//3g2MgZChzm4IeBLTukQo8wzc1C0jCvKRQUmlpVGV6CvhiTeBFp2WhYqDtd506aAhalvAga4
 v2bQ/89HP6PbUged5ARSRbfV0AAAA
X-Change-ID: 20260724-b4-disp-e8ec6012-b488d7a20266
To: David Heidelberg <david@ixit.cz>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Robert Dolca <robert.dolca@intel.com>, oe-linux-nfc@lists.linux.dev, 
 Samuel Ortiz <sameo@linux.intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784892174; l=5020;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=UN9beZ97743kheaOb4gEzoQEnO7dJ2vHjdtJmNOgSvQ=;
 b=lPooyy+f44NYeHGMa32HB3RTRIP9/Z4d2K6NOcPWj9brqeslvRB+JwN9f58K+cObfCQRWLZgy
 HWtZJxQu9h0DUPB4cSvH/c9wM6w3kU4PuEjj5zNb6MxmVqb/BjYgLn6
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

fdp_nci_i2c_read() takes the next packet length from two device-supplied
bytes and never validates it. The value is a u16 used as the
i2c_master_recv() count into a 261-byte on-stack buffer: a malicious,
counterfeit or malfunctioning controller (or an i2c bus interposer) can
drive it far past the buffer for a stack out-of-bounds write that
clobbers the canary and return address, or below the minimum frame size
(directly, or by truncating the computed sum) so the header/LRC strip
and the next length read run past a short receive. Reject a length
outside [FDP_NCI_I2C_MIN_PAYLOAD, FDP_NCI_I2C_MAX_PAYLOAD], as a
corrupted packet already is, and force resynchronization.

The same loop allocates one data skb per iteration and assumes a length
packet followed by a data packet; a device that sends two data packets
in one call leaks the first skb when the second allocation overwrites
it. Free a previously allocated skb before allocating the next.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Cc: stable@vger.kernel.org
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3:
 - Rebase on current net; no code change since v2. Doruk Tan Ozturk
   independently found the same missing bound (0sec,
   https://lore.kernel.org/all/20260720132133.69635-1-doruk@0sec.ai) and
   noted there that this v2 is the more complete fix -- it also rejects the
   sub-minimum length Simon flagged and closes the skb leak. Reposting now
   that the driver has an active maintainer.
 v2: https://lore.kernel.org/all/20260616-b4-disp-b1f8ab4c-v2-1-2d1fe5955325@proton.me

v2:
 - Also reject next_read_size < FDP_NCI_I2C_MIN_PAYLOAD, not just
   > FDP_NCI_I2C_MAX_PAYLOAD (Simon Horman). The small value is reachable
   both directly (tmp[2] == 0 && tmp[3] < 2) and through the u16
   truncation of the computed sum (e.g. 0xff,0xff -> 65538 -> 2); a single
   range check on the stored value covers both, and also keeps the next
   length-field read from running on stale buffer bytes.
 - Fold in a fix for an skb leak in the same function (two data packets
   in one call overwrite and leak the first skb).
 v1: https://lore.kernel.org/all/20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me

Reproduced in-kernel on x86-64 (Linux 7.1.0-rc5, CONFIG_KASAN_STACK=y)
with a faithful port of the read loop, and at full device magnitude with
a userspace AddressSanitizer model:

  Stack OOB write
    A  no bound, next_read_size 281 -> 20 B past tmp[261]:
         BUG: KASAN: stack-out-of-bounds in i2c_master_recv...
         Write of size 281 ... This frame has 1 object: [48, 309) 'tmp'
    B  bounded to <= FDP_NCI_I2C_MAX_PAYLOAD:   no KASAN report
    C  well-formed (len 5):                     no KASAN report
    ASan model, full u16 next_read_size = 65535 -> 65274-byte
    stack-buffer-overflow WRITE on both -m32 and -m64; bounded build clean.

skb leak (slabinfo active-object delta over 20000 reads, two data
  packets each, measured after a slab shrink)
    without the fix:  skbuff_head_cache +20047, skbuff_small_head +20057
                      (one orphaned skb per call, unreclaimable)
    with the fix:     ~0
---
 drivers/nfc/fdp/i2c.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..f292e7f37456 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,9 +166,36 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count for the next packet
+			 * and as the data skb size. A value above the receive
+			 * buffer overflows tmp[]; one below the minimum frame
+			 * size runs the header/LRC strip and the length-field
+			 * read past a short receive. Either way the packet is
+			 * corrupt: drop it and force resynchronization.
+			 */
+			if (phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD ||
+			    phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
+			/*
+			 * Only one data packet is delivered per call; if the
+			 * device sends another, do not overwrite and leak the
+			 * skb allocated for the previous one.
+			 */
+			if (*skb) {
+				kfree_skb(*skb);
+				*skb = NULL;
+			}
+
 			*skb = alloc_skb(len, GFP_KERNEL);
 			if (*skb == NULL) {
 				r = -ENOMEM;

---
base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164
change-id: 20260724-b4-disp-e8ec6012-b488d7a20266

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


