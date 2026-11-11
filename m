Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389671;
	b=MhU+MYohvPfq84CQpcvh/KA9DDJ7zHi/QlJzSH0DH7GngI6kF04sAPaTbhcdbQ7z45es
	 cXoppv07MykdsHzts/P9f63wHLr2n5BYgi/e5R4R6AzgnUs1Ewobw5VvDJcOItlN2aJAX
	 uZ+jQMD51vOii1OQOWG98dRrgwJDNGLxQBWXq2unlKTIwX4ryhoZwfc3Nw3MN3AbSDnUn
	 jsg7N82lhgFux9zQJP/3JzahgYBAQSsg+xSquopoeRKPFduZraF8vrI+MsjuX6CknsfJX
	 PwMLS/jqJFc1eRgA9rDJrgdrFBlomjbKyNmdTpYCbrDa0jVRbcUODNDKb6IPfYSEkgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389671;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Q/b6rP4yM88vfIcAA0N28iqXNSq2RwK8XB4c9bZlLRU=;
	b=RbljX6j1NafJxRVvAWZCaRf+OgXZW4phSeKEtJZxfBP+Y50oC+4jF/DpcmQU4RRbXTg0
	 uiRlj/Vfrt/SSEposDlJjPu9iP7ymVYDaxphsImSxM47gHBFKjOPXKA+H2gAP+Zw9O8to
	 wbfZ1nHZckcpSnE/nhpNKEQZqKvURP3s9OytpqH+RuT77ilsU5VAUN+A3rr0BCJTfyd+F
	 PIgEXkzZF8WPfF8pQ1U5eTY7L+ip2bIQPnY0LxGDLEvsmcIhKB+hzCd53drjvK8EoC7Bv
	 I97KKSXmFkK0kV3/zSg1Kjrwun7l+NS0bgvWzpGAe8LTQcIIwglkAL/MiTaiQaCPgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38438606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38438606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from imini.taila1aac7.ts.net (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHZbqhNvRq183fAA--.7089S4;
	Wed, 11 Nov 2026 17:34:25 +0800 (CST)
From: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org
Subject: [RFC net-next 2/2] octeontx2-af: cn20k: do not phys_to_virt() the
 mailbox base
Date: Wed, 11 Nov 2026 09:34:25 -0000
Message-ID: <179438966513.1752948.11370387748541356912@mails.ucas.ac.cn>
In-Reply-To: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
References: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAAHZbqhNvRq183fAA--.7089S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww13trW8Zw1rtw1rZrWUJwb_yoW8uF17pr
	4Syry7uF47XF4jgFWDAFyrZrs0van7XFnakryjkan0k3ZIqF1jyrWDGayUuF1jyFWfWFWa
	va15Aa43CFs8Ca7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
	jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	2U73DUUUU
X-CM-SenderInfo: x2kr0wx1lfxvtqjskio6pdxz3voxutnvoduhdfq/

qmem_alloc() stores the kernel virtual address returned by
otx2_dma_alloc_coherent() in ->base and the DMA address in ->iova, so ->base
is already addressable.  cn20k_rvu_get_mbox_regions() passes it through
phys_to_virt() before handing it to otx2_mbox_regions_init(), which then
dereferences the result as a pointer, and on arm64 phys_to_virt() subtracts
PHYS_OFFSET and adds PAGE_OFFSET, so a virtual address goes in and something
outside the linear map comes out.

Use ->base directly, since the memory the AF wants is the RAM it allocated.
If ->base is meant to hold a physical address on this path then the
assignment in qmem_alloc() is what should change instead, and we would like
to know which of the two is intended.

Fixes: f8909d3dd554 ("octeontx2-af: CN20K mbox implementation for AF's VF")
Signed-off-by: Yicheng Zhong <zhongyicheng2025@iscas.ac.cn>
Signed-off-by: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index 01f32adac59..6908d7ff7fb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -240,7 +240,7 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			if (!test_bit(region, pf_bmap))
 				continue;
 
-			bar = (u64)phys_to_virt((u64)rvu->ng_rvu->vf_mbox_addr->base);
+			bar = (u64)rvu->ng_rvu->vf_mbox_addr->base;
 			bar += region * MBOX_SIZE;
 			mbox_addr[region] = (void *)bar;
 
@@ -254,7 +254,7 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 		if (!test_bit(region, pf_bmap))
 			continue;
 
-		bar = (u64)phys_to_virt((u64)rvu->ng_rvu->pf_mbox_addr->base);
+		bar = (u64)rvu->ng_rvu->pf_mbox_addr->base;
 		bar += region * MBOX_SIZE;
 
 		mbox_addr[region] = (void *)bar;
-- 
2.43.0

