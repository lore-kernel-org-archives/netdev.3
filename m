Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453943;
	b=ocvJluS3WMBCowOTLp8xxspvFFUG4UwFGgf1SDDU0Xx1LFpbxLEHmV/izbMzCDCKldFu
	 pIfM4BUuVEkQbHuvwi6IKZZYVuDmD342iv+NRJnEUEuxekS3PKedJ2GOJ6syW9aDwXFDv
	 GMaSIjzxks7nQP3N36mhpnpdCRxKlupZUE3W5DWt2/LRir0bWTyE+mowKaK3jZ7ActGLb
	 ho6ffGKIctEKmmvJ1mdQoEIewkA/mnX44k2eXlvSN9BEBP+Tgo5io1fWmMxj5lNqwKJrY
	 QzPFzGC/HS3kLssNfyLVZ/bCV2kXdZzO0nF+E2dWuKv+T8FOvw9exutJLuyPQJdxB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453943;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:Date:
	 X-CM-SenderInfo;
	bh=41wfgGOVNMB+wGfHNY3WAPDxKPIZkBZs1k0Z1IHQb48=;
	b=wyT8FpDVk96CWsOjvq8RGJmalyRLgoDSd1L6w5LBi3t9aCTsL/kHCQVpBTuCogUPcc+F
	 9YDv9AjzgqznLloIbHcnb+PTZ60Nto+Z2ub7cglyQwq2dWLtlllnPbPAsHNDKSiGtnV9Q
	 oTerMf8IFOrO4XjXkCZStx4fW+ajqgtKSiF316girtLhcAEmfDn6a+xpYgx4W0vAhxPiN
	 Jaz85oTUFyoXgdsC949oy4cf1IZvlmfp1d5sb+ogVPmuNGuv2Lu8z65rxXGdsop08gOvr
	 hOeV/+K2pyJSc2SOLAF+c8o/mxA3cC5x6LNdEB6LSY/G9gDdP2x2FlXxQtowQhN5XlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43811606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43811606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from imini.taila1aac7.ts.net (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnf7WsMfVq0v7wAA--.17465S2;
	Thu, 12 Nov 2026 11:25:32 +0800 (CST)
From: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, netdev@vger.kernel.org,
 zhongyicheng241@mails.ucas.ac.cn
Subject: Re: [RFC net-next 1/2] octeontx2-af: reject an out of range MCAM
 counter on CN20K
In-Reply-To: <avUeBeQSLwNvjwRY@rkannoth-OptiPlex-7090>
References: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
 <179438966513.1752948.9405325090310502892@mails.ucas.ac.cn>
 <avUeBeQSLwNvjwRY@rkannoth-OptiPlex-7090>
Message-ID: <179445393225.2035819.12825104834461955299@mails.ucas.ac.cn>
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
X-CM-TRANSID:zQCowADnf7WsMfVq0v7wAA--.17465S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DGr15KFyxXF1DAFyDAwb_yoW3Wwb_AF
	98A3sxWw48Za4qqFs8Krn8uryfJF4a9as7A3y8ury7C3WDCFW3tr4kurn8CFy0q3y8Jrs3
	ZFnaqa4I9wnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJV
	WxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbjNt3UUUUU==
Date: Thu, 12 Nov 2026 11:25:32 +0800 (CST)
X-CM-SenderInfo: x2kr0wx1lfxvtqjskio6pdxz3voxutnvoduhdfq/

Thanks.  We looked at npc_mcam_verify_counter() and it cannot simply move
up.  On CN20K the ownership is recorded against the entry, in
entry2pfvf_map (rvu_npc.c:3190), not against the counter, and that helper
consults the counter view.

First, its ownership check reads cntr2pfvf_map.  That array is never filled
on this silicon, because the counter mailbox that would fill it returns
NPC_MCAM_INVALID_REQ (rvu_npc.c:3817), so the check would reject every
legitimate request.

Second, its bound uses counters.max (rvu_npc.c:2583), a counter count,
where cntr names an entry and should be bounded by the size of the entry
table.

We plan to correct the patch so the CN20K branch compares the caller
against entry2pfvf_map and bounds cntr by the entry table.

