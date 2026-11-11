Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389671;
	b=rJDc+/XTfDb/sto8Bxo0HDhcTeqvrJTLnTyOtI91RXGt1YD2NYQgicXv8c0Y2Dl7NDx8
	 XN4xWgC1IeZYrOcO7YQwq5Ntop9+Mp9HMqYOj640Cwn83usoUBNymBIX+GYE89ilfhggm
	 923CZQ1HL8DhkRw97HU/l2w/Tqcz3Ui0o1f5GKaStbLO0JYT3uuM0fjfIPpDJKBFsxdQU
	 2+1kxJwrJP6h5Q/E15/ncAd1f7LNSev53tnglVplyuXlmfWT0ocWiSVVLmxDM/8Yuf7T+
	 8fvuZx9wOWpWU1iey+D3U8QliIYlKWCC7lOAam3koD2lMQa+6ubwDCjyU7ks0GyP0IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389671;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=HJGwxaWDGmRmOnT4rUcqo289jZ3CK7URRyj+Uuhv5eU=;
	b=bAydciASgewQH8EM/U5GUdeWOoNhoEV1/pl2a39BEziEIXSsrVpRmNX+n3bTgN6b3Eaa
	 2JxsshdLNgSmeWtCsme+xtuiE+fYQjAsrlO5qGZJSr2o1Tlq4ViUv2wEyUzWgVhqMrbY3
	 Ew4VJbEODcCRtXWmKp7yudIm/7ueCvM8Jv/h+EwW8LB926k58UD9ILAOwd+SVWeSg19WN
	 QfMs5TiVKAOumApCIyB6WFitxuRC4FHun/K63qbTIT3oh+HDWwxuMAKUK+3K442CSsTGf
	 MBEV0GzmC9GZf016y9Qa7fRu730c65d7hv5b/35D5wl7nNX5X74nYP36Jdqw1xFKl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38525606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38525606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from imini.taila1aac7.ts.net (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHZbqhNvRq183fAA--.7089S2;
	Wed, 11 Nov 2026 17:34:25 +0800 (CST)
From: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>
To: Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org
Subject:
 [RFC net-next 0/2] octeontx2-af: fix CN20K counter bounds and mailbox base
Date: Wed, 11 Nov 2026 09:34:25 -0000
Message-ID: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
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
X-CM-TRANSID:zQCowAAHZbqhNvRq183fAA--.7089S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry8CrWkKF18uF4DWr4DJwb_yoWkXFg_C3
	9rZFW7Cw45C3WfAa1ayrsrZ34DCFW8uFWIvrs7WrWUKrWUAFW5ArykGrZYvr4xuan3Zrsr
	ArWrWryfu34a9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
	80aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY
	62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7V
	C2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x02
	62kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jbZ2-UUUUU=
X-CM-SenderInfo: x2kr0wx1lfxvtqjskio6pdxz3voxutnvoduhdfq/

Two fixes in the CN20K paths of octeontx2-af.

The first bounds the counter argument of the MCAM counter handler before it
is turned into a bank and a register offset.  With a counter past the table
the bank selects a bank that does not exist and the offset leaves the NPC
block.

The second removes a phys_to_virt() from a pointer that is already a kernel
virtual address, which otherwise takes probe out of the linear map on arm64.

Both were found by reading the driver and were exercised in a QEMU model of
CN20K silicon, not on hardware, which is why they are RFC.  A longer report
covering other findings in the same handlers went to the maintainers and the
security team separately and is not part of this series.

Yicheng Zhong (2):
  octeontx2-af: reject an out of range MCAM counter on CN20K
  octeontx2-af: cn20k: do not phys_to_virt() the mailbox base

 .../net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c    | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c        | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.43.0

