Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958993;
	b=sBriIcfffThIIGyCruFqhmZWGOW4SRmPjVc/S980tFolSrjOe2iFoew0R1bZhYYgseWn
	 OJe7UDtoaETgnbtz8ZkAmzAxaoB6ztCYPEBU6vF/DqR8/Z1ogHc0zsEJ+nq6YYb6jaiMi
	 eTTF5FuhrPJIgt0p4ooKaRHJu8XV0LEvZs2Str9bPWf+c53jK7XNPb1v0HMjmRINPetat
	 w09RFT9sVG1H0HDFx68e5Y946iFAUVm6/lzeLvCkaDWgCudRAt7HnOXJtzvTKrIPejZzw
	 ky9q3pIoUmk1YGYrUXmcOcwkRTFoup+9Oew29+634Y15plq+Q4rP0xHZVgTklLZFSSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958993;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p4X9nuP6o1sozZLarhxMvxYA/A7FXv7bB7EJQ813gtI=;
	b=cpCwzALTSpNC1qHI5r2dds6HJucFTfZn9vFKY3iRNvpXWoyXAta7XyrDmOHglDBDE0OK
	 oJmIPY9+Sy9qWL6nuJZ3Z+LcINZn8iAc8+2qdxmZQ1tiJi78Fp6NlKmFaqqspLoJfb3ss
	 LnX8KgR4MO1PDirxCwARlmYcBH9t2dgqQizLxRKDBLa5iGMw56JAKaK6frVFhDoRU4YO3
	 wHYbXnumgQXcciG2wUruKq5ale2AwWCqGwbwetj7kqCLm3GGIxSzoXruZMl/V+RqIWIzo
	 mD+iWIwV5RABNRx2bfUE//KSZooupi8BPbOJFS/S3HcH4s0eDjP7ezkwHhRKkhYMiKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=hW+M13Ay;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC42A606A330;
	Fri,  6 Nov 2026 09:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC42A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=hW+M13Ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=hW+M13Ay8YZkujMbRUInHccf5kp+F8emucIp9FflfFLfxnlLZwP6jZJa92gUc84s02ETTDgrPEEcb
	 V+sqXyLCOIbU7ROKi8H0YmtuFQ3JA8pjX97r3VXxRu9aUkyTjghTW9XPpv8A86idW20Cm9ersAiWi9
	 aSvHXaBNrCKBNo9Y=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeda44bf73-7d991;
	Fri, 06 Nov 2026 17:56:29 +0800 (CST)
X-RM-TRANSID:2ee66aeda44bf73-7d991
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeda44ca67-1bcff;
	Fri, 06 Nov 2026 17:56:28 +0800 (CST)
X-RM-TRANSID:2ee36aeda44ca67-1bcff
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH net-next] liquidio: enlarge the interrupt name buffer
Date: Fri,  6 Nov 2026 17:51:14 +0800
Message-ID: <20261106095114.3564335-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

The PF and VF interrupt names are assembled as "LiquidIO%u-pf%u-rxtx-%u"
and "LiquidIO%u-vf%u-rxtx-%u" into INTRNAMSIZ (32-byte) slots.  Three
full-range %u do not fit, which gcc reports in a W=1 build:

  drivers/net/ethernet/cavium/liquidio/lio_core.c:1119:76: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 13 [-Wformat-truncation=]
  drivers/net/ethernet/cavium/liquidio/lio_core.c:1124:76: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 13 [-Wformat-truncation=]

Enlarge INTRNAMSIZ to 64 bytes.  queue_irq_names is allocated with
kcalloc(num_interrupts, INTRNAMSIZ) and the auxiliary name with
kzalloc(INTRNAMSIZ), so both follow the new size.

Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/net/ethernet/cavium/liquidio/liquidio_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/liquidio_common.h b/drivers/net/ethernet/cavium/liquidio/liquidio_common.h
index 4da90757c..131e39299 100644
--- a/drivers/net/ethernet/cavium/liquidio/liquidio_common.h
+++ b/drivers/net/ethernet/cavium/liquidio/liquidio_common.h
@@ -102,7 +102,7 @@ enum octeon_tag_type {
 
 #define BYTES_PER_DHLEN_UNIT        8
 #define MAX_REG_CNT                 2000000U
-#define INTRNAMSIZ                  32
+#define INTRNAMSIZ                  64
 #define IRQ_NAME_OFF(i)             ((i) * INTRNAMSIZ)
 #define MAX_IOQ_INTERRUPTS_PER_PF   (64 * 2)
 #define MAX_IOQ_INTERRUPTS_PER_VF   (8 * 2)
-- 
2.43.0



