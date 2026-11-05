Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920463;
	b=VIIoVRABreMpisDOFvymfWVrGRtjLlfBfXlrJi1aBMUqaUM3TmCxBFOb2hCXpjX4QY93
	 Biyeo5X3uYJj3gtuMGd1RL0pBfHZ3TVS1D78v7YwAVdigI0g6VXnYwcCwgC2LMW77NAfo
	 xzJF0H9ExSNpMWuBr2E4IEl0MnZPCN6kt9EKALh2fzivaQU6atcsc3YYAvl1EPR/uZH5a
	 3Wpf6vq3BtfY+6VAFxYmlCfYt36E2JXBaLjlLsLOwXH70H6eMKSynGcqxRTiT8OMhmVMP
	 8GQHurob4cc31dYHRxWGPde8PDENZxTbrMDi3BC7GI4ggMIGcn/ToxggS6t8lvkGSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/Jd0PA3ZQtl80LdCM2qOuOMwv75gekRWvfPbCbyLuKQ=;
	b=XZAmWeQMbWjz4Co5aDMb7Cu6tPI2WrET4zh5QN4dnJUeaZOW8uz8e/gWJ5UwFzoTyMNN
	 pzV+SXDdTAc6W/lhkrhcvI25SPORLvUi9c6tyFRQ8Fc+6YrlW+r/Ge3rireyVe3Iui7xm
	 1tMavGXa/NV+RiyJ1NX7sGTSGIyG3h5Zdbml8qo9s8/+aYa6HTE3Vrf0tgUKMNulrS5sF
	 Yfbj8WWA6OM78a5t4OsYAncEMIkV9BR48pb6jMXGO4abxv7OZbPU8WSA62tWuEJ0NaxZ/
	 Vx415fQXKw83F1B7bhxHEPD1fbmeBOfoxzjVyBWsL/zpe3R4fkLDidscfuiRyjsD6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iW5CLI/H";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE164606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE164606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iW5CLI/H
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b29049d80dso1225b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 15:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793920462; x=1794525262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Jd0PA3ZQtl80LdCM2qOuOMwv75gekRWvfPbCbyLuKQ=;
        b=iW5CLI/HGouFfECuUHv3NqRUkfTa84kur5CJa4/4a/qiDcm1Z3dqdRmihBuk8P3mWr
         V1lbmYBFlYLbgPTlTrtGXLTCyVTeiaejkhgfYHlNJvS8iRkKJjNkQ4CGCsKWH8ChcJEF
         ERlSpDm6bbHL8j3Y6FdSp9TlnLMeV/pqStGat/HAKTAde56kkE3N8RqDr2xKS8CfBdlp
         PtMM5kbrgvGQ1a4qDaFJQYNy+/HDgmWafOy/RWWpYFCHGlR/U8Ou0qYUQY4Gs+a+Q7Et
         dqX1ALEcaYxONAIP9QeKdeM5Z3fWhG10XKhEDTAGHJ62U9yK6nMsMsZ6UePIYugB699h
         B2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920462; x=1794525262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Jd0PA3ZQtl80LdCM2qOuOMwv75gekRWvfPbCbyLuKQ=;
        b=1pfEiu+dFlQXrJjighKSzZqyLEjpsiZIdEoCIoSK6X4fgRe4TMyySdlA1g/Mg6sPQ0
         ApdSyDNvSglxAMBZkGe0iLGTNHllbal0Z/yQJM70PSRv+suGobJveSu5AH/SJiVTCeE8
         91nE78dORjuimnfIxuBdsTMjQr85uTAxLAFUC+CBdw8rXQETOCTEMc29J+FVisIaY/yc
         IlDjKddz2TlmyS6E5iR37XgfVdjLtSPpBmmz+3Yk3EXmrMWPJA2TQ1CjDaccKqhxvWSx
         UiaVQQrWfWfZ/LjeN4xro2N8o2jrdPlpY3/dBV7xZ84Wy/mGpWYi2fDc92Scb1OcAC2q
         Jq0w==
X-Gm-Message-State: APuU4Z/lEIl0Qhc1kIG254DsNR/sEfCKVdFLbNVb+e3TusS3sAaNms3p
	xl9stAUQwGNG+U24RNK3xSMUx3to/Z64bZFi2vRMky2Q4yo4GLG3mOyzwQmtWg==
X-Gm-Gg: AYBFou382lh/P9iV8jRlm8XXVhUx9ieIfBLSXQvIlBDIalKUmZdefHVlQPmJ3j5XEuO
	yino/MiFVA+hH0kr5N9i1M7HVRvnqfKYVnu270w+GkH3ev0k8UykPub8V+R90BXm7Onh9r7q+77
	NeudgodpgA1pYvJ4/hcKFsEhXDKiFMZgTN/Wqubu5g9zstvTMcyJCHBJAjvn+/N81FovtYC7Ww4
	2GshjGG3ODUoJox7Qe9rDfHZ8j7PaivT8kiXueN/JxiyemFMqFZ/ixpexjCCc3Nm/3NAB6JI/Ws
	nrvhoTnTUe9iN+c12dgPRssInLPLELTOuSE5eaVkB7Xbi2WMZukWh5y3IxMzK2lVaQE3ccUtI0F
	OHCOYRYSPVkXf0sus4XQwzDQsmB+oISGzqJ3rNiBse71h+KqvJemEBQ1AlIhaUicOxe+6G6bWY6
	/9pB3k6WxNBDrW0aIRuQDMfE6zQAwyBidesmCyH9atwDAGFauTe7IJ7rIf0doPGWP6l8U+1XuaT
	gis1yHgOphmDnu4mau9re6Xnre3b2ig8x/FT+wkMGS2LcRxO+yU5CwFsHKuEEH3tBQNozNjD5uf
	mT4+3NoJoBNCLmDwklvSAvd5lJomL5786koP+jtfBsM6Nk9UzH3LnGvoqAqomQK50d8/sKcZNJp
	hrluNiwuiO+yWxrjPN6vRkb4CNkiJ7z9bE93R/IDkktcLV8xlD+db4rw+yzR9qIgoy1fN6Tx9qn
	/3Kg==
X-Received: by 2002:a05:6a21:644c:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3ebb275c5b6mr1016971637.10.1793920462121;
        Thu, 05 Nov 2026 15:14:22 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a73c99sm14382a12.20.2026.11.05.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:14:20 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: fix MR0 write in emac_rx_enable()
Date: Thu,  5 Nov 2026 15:14:17 -0800
Message-ID: <20261105231417.119930-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When an asynchronous RX disable is still in progress, emac_rx_enable()
waits for MR0[RXI] with

	while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n)

which assigns only the RXI bit to r, as & binds tighter than =. The
following write of r | EMAC_MR0_RXE then clears every other MR0 bit,
including TXE, and TX stays stopped until the watchdog resets the EMAC.

This path is taken when RX is restarted after an RX descriptor error.

Tested on a Cisco Meraki MX60.

Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 640618c0a09e..b676b286e339 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -249,7 +249,7 @@ static void emac_rx_enable(struct emac_instance *dev)
 		if (unlikely(!(r & EMAC_MR0_RXI))) {
 			/* Wait if previous async disable is still in progress */
 			int n = dev->stop_timeout;
-			while (!(r = in_be32(&p->mr0) & EMAC_MR0_RXI) && n) {
+			while (!((r = in_be32(&p->mr0)) & EMAC_MR0_RXI) && n) {
 				udelay(1);
 				--n;
 			}
-- 
2.56.0

