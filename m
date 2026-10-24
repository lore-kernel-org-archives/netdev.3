Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856536;
	b=4C58+QtjzizEQELm+wCp8YlUdkx+LvmKkpO4ZIGGRI1fUaZ7CdNXZEbN1m1wHt1bD2pb
	 Nr3iSXrfWEbt4MjLx0dgvVnvUkPlVcPYSHIvymI+PwTJLylIBJFl8gGSSRdTIf6V51vFX
	 CMqc4yNBIWg2E7oEiYIf2Ihnu70rQn2bz4zoqzXR3t0Ag4kgwRxuig2ceXleSkwafqeDF
	 wxm5AXMydy5z7Wc2Zs3DMggOzUFAJOeAvLhiUtLrNV+vTFg4WjjMfrPA/7uFtHpLceIpz
	 /TUfX6D+znljy1tt+sCufuj4/afu5r6nw7peDqtESI215co0mBWek3HxcECZTD3N/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vjEeye3G0zd8caK/nKeFaZ6nAZ8lGBdWDRGnP6Iv4Rk=;
	b=sl9sC9iWQsFQz1f45iumDLLIPJhdN0zaKEYgnVfBCNcYkweo0NYB8a+sREjTqKSu1a2B
	 FjpMur1o4ox3wvjWBp7u74/pqJtHdgRqulcBxNGu7gO/0IxGZPavULe8M9/talfwa5X6e
	 nFZSPsGb2cxaGE25yzR02XGE2p+IhceNKy9KYOK+AQmqBJ7KadihX9chgEeic/Nx/vuLR
	 cEXWYEWg3VsUtHbXvhZSFUraARsqvdbRdbrv45sq9Z7kM3Ctv77IFKsSAwX6BgZfucJ+g
	 eZh/kk9t3mlNFRmmegMWcecr8ftq/518v3I8Uik8wr1Ohn6k+ILn7lMvdoe5MN+yp+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p1wELQ+o;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC16606A323
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEC16606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p1wELQ+o
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3386923eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792856535; x=1793461335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjEeye3G0zd8caK/nKeFaZ6nAZ8lGBdWDRGnP6Iv4Rk=;
        b=p1wELQ+orMTpRswwM/ZFz0l/PQum7SYe5fMWmghobxe8OJfJ36isFVuGAi3JSPs7Ok
         uXKGICH8ql8O9uUNuU426L5tX14TwQTKfRta7EP9cbTapnLomRgdPDaRmUWGolJ3YxQS
         hMY6LzlVH5sFHkAADPtO1ZhbQbzC4OiiUn3RSOHX+XavV5C9yCwEakRzOLXgbFDqgNHf
         YDlGTgwkg9ci8ztGSyKkHjF7pwjFbfCJKUhWv2581RJ5RuTNTq5qiJbDHT76AtAz+uqN
         7w3g0B19n3hnkrvKUtfDBdu24fZotplO1BRbGnLDVRpADxZYEi8QguCP1Y3r/2e2+r60
         7EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856535; x=1793461335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjEeye3G0zd8caK/nKeFaZ6nAZ8lGBdWDRGnP6Iv4Rk=;
        b=RVV5FRFBkOHNBnRlrVG2K6flqYu03eGgbe1ftcCChf2albDYS+jlUn3q/6upXyv7Qc
         OFb5KmzNzC+iqz2E6a6apYq/u8VcJikx1sL64Lv8L4m2ZV5f2m6IW+sLu1mr9t8iPTwO
         VB4vLUa/miAd8ANM+JJS5l36mFTNRGIjoiaSSfEbhHbwCiFKIsOtwB2zm5+FHmWNmAjF
         ABIK+lZNH3MAAlffGvxmM5eYtl1NQYTZgT3xJB2ZRD/36x/9vaIb/5N5uobhKm0mGa5W
         Z3wkPmEF9/NmZ/oPf6PAmY8prOMrQdKZKFIkj8gBlKYAjllsbYkpkmAtWgnXTrfrlY37
         Y92Q==
X-Gm-Message-State: AFq9FYKwJqX80v6dcynydZwZNlXfg8Fql7ivipF6gM9P1prO0gRprA/K
	+qd5S1ZJfXK30cvBMoUmUNHYycsYzMeV1Vx2Uafzx4wEKJe2K8W7V1wmKNRQPBSM
X-Gm-Gg: AYBFou0Nkp4DxWMrbc9XqKuTzIJ+3mw1AYW4XiUMrgZbuBIoK+TvNkM+IuR/wnIvs2u
	oiwRWh+g/VOd8jRlHKv+bL/vpy1YTaV7kONT2GWWFloue5zQCMUdstTDiIyR2qI1Lm/9j93Isq/
	IS84GV/DzczLgkmsrPeevvE5mbfTR45HP+WujnntExi/xrJTlg6tuNBDUfK997HOZ+s/mwylqtD
	GEHkD/zhL/Q0Es/P2OZ/0gGvnGyUiz/X+V70bratmryJ3o8xd31YSm6Oncsf0NnLLUUr1tc+yem
	EV8U2bLoi0tCiNaO+caIeCMTcEVTh+//siIjMNOHH02vTxMTh+l1aU5gCzSrXnTX0DswfjcITy/
	uwE2C8Szvm770UfKaHwBUSHK5G3poC3ekdk6IJzdK3AQvVKeCVCg5+MPX4G1Ya93O/AXr8d07HB
	rAGKwaJQ6xYihfXy3HQZ8hNGoYCX9iktvGIVtoXOIVwzPdtvqnviPdFL74XALhtRmkJZ4+atx+G
	f9D1hLnEIg0iiLi87S9ySr3a/LxiXJG0Ni5stSRNmpluCcALlHL7/lfwA==
X-Received: by 2002:a05:693c:8381:10b0:351:dbc:b663 with SMTP id 5a478bee46e88-369e863b90emr3837046eec.31.1792856534783;
        Sat, 24 Oct 2026 08:42:14 -0700 (PDT)
Received: from plex ([2406:6d00:a27c:4200:aab8:e0ff:fe02:33c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm7766450eec.18.2026.10.24.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:42:14 -0700 (PDT)
From: Chris Scott <gilroyscott1970@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pawlik.dan@gmail.com,
	zhengping.zhang@airoha.com,
	Chris Scott <gilroyscott1970@gmail.com>
Subject: [RFC net-next 2/3] net: airoha: npu: attach a coherent pool in the NPU window
Date: Sun, 25 Oct 2026 01:41:49 +1000
Message-ID: <20261024154150.45733-3-gilroyscott1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024154150.45733-1-gilroyscott1970@gmail.com>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN7581 NPU can only address host DRAM at 0x80000000-0xbfffffff;
higher addresses alias the lower 1 GiB. The coherent buffers allocated
on the NPU device are all shared with the NPU: since mt76 uses the NPU
device as dma_dev, these are the NPU TX/RX descriptor rings, the HW-RRO
ba_bitmap/addr_elem/msdu_pg/session buffers and the NPU TXD buffers.
On a 2 GiB board nothing keeps them below 0xc0000000; they normally
land there only because of early-boot allocation order. With low DRAM
reserved away on W1700K the SoC hangs right after mt7996 firmware load.

If the NPU node has an optional "dma" reserved-memory region, attach it
as the device coherent pool so all of these come from the window. The
next patch moves the mailbox buffers to coherent memory as well.

Unlike a restricted-dma-pool this leaves streaming mappings alone.
Packet buffers are passed through to the WiFi DMA engine: on W1700K
with 96% of TX skbs and ~20% of RX page_pool buffers above 0xc0000000,
host-path traffic and sha256 file round-trips stay intact, at the same
throughput as without a pool, whereas a restricted-dma-pool (swiotlb
bouncing) costs ~22% of host-path TX.

A device coherent pool has no fallback once full; mt76 and the mailbox
use ~10.7 MiB with MT7996, so the DT region should be 16 MiB.

This patch was written with the help of Claude (Anthropic, claude-
opus-5-5).

Link: https://lore.kernel.org/r/atCRsquzA1UxSpCc@mediatek.com
Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
Signed-off-by: Chris Scott <gilroyscott1970@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4d3195eb00..069fd60680 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -693,6 +693,11 @@ static const struct regmap_config regmap_config = {
 	.disable_locking	= true,
 };
 
+static void airoha_npu_rmem_release(void *data)
+{
+	of_reserved_mem_device_release(data);
+}
+
 static int airoha_npu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -776,6 +781,19 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (of_property_match_string(dev->of_node, "memory-region-names",
+				     "dma") >= 0) {
+		err = of_reserved_mem_device_init_by_name(dev, dev->of_node,
+							  "dma");
+		if (err)
+			return err;
+
+		err = devm_add_action_or_reset(dev, airoha_npu_rmem_release,
+					       dev);
+		if (err)
+			return err;
+	}
+
 	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
 		return err;
-- 
2.53.0

