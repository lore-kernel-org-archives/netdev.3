Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226002;
	b=GqS3cWlPs8M4+MZiEIftbEtojBcSY90RgtIO23TxjL6i8q6FnNPCuFCb3tHDLThAHdHF
	 VOrhf7xBZ0GmyLZfxQsSH2JC0XS48Rgu/ti78htH1vTIRvicvwgX8Dc2AdNAo0G+uFS7u
	 tGegOxS2X1i1pcuPexnUgjC0pQVM109jlFbhVsx00qheTUxfp4f+b7agqjD/OfFhnpmbH
	 4Asueo/5EqNWP/56GdIUqgdZW9k/uF1U67cx0pl9unpIGvUploPVFRJOcs2vRoMZQHINM
	 IYFhzMPTvIkscuvH8zcbBKH18RMTP3mxnO72PDhskHwDtKMxpYmjY6m8/+hZ1B+Gp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226002;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=dsn9lzxkmL9tDmJQzeHWFvkXsP2Re0j6GSR5rnnpTJo=;
	b=BFCa0DXWZP0h3z8f7xOYSJzCG6cKyBm1pYquBmViRsdHxSPRk5ScVkgbjJv00g1XeQR0
	 W8m4SpgwGa5qruZ+VaFbBpdXAAmagTfF7mw4B9mheaFYvlHd+W86TTintXB1CpTpNcgMi
	 JoMA7bL3IMHidTlq9MIuILiWP/pTBeLEVxEqHHO+qyjOjXWMlMJJak4etT+155a0XilFN
	 vAY5xw/1hDz1xJ/DfjZvgCnrcFwtsjlTsi2CNwT99dOhQZCdHlw9vwffzJPiWGESOxrfa
	 Rapa7UUoafei2ToBqNZaMtiVTnv1PYMfAYZlIvhjDrEV7gptF+pTuaRT9OGpZv4SGZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA45606A321;
	Mon,  9 Nov 2026 12:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA45606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fff19b22dc3511f19a56ed5b684f684d-20261109
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fff65bc1-1838-4afa-b309-89729647d0e7,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:fff65bc1-1838-4afa-b309-89729647d0e7,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:1aca65a05f6e0835b90bb375317ee4ba,BulkI
	D:261028205648ZJS9BQFX,BulkQuantity:2,SF:17|19|66|78|81|82|102|127|153|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:1|-100,IP:-2|1,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_IBB,TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,
	TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fff19b22dc3511f19a56ed5b684f684d-20261109
X-User: kuangkai@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <kuangkai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 34375348; Mon, 09 Nov 2026 20:06:31 +0800
From: Kai Kuang <kuangkai@kylinos.cn>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	kuangkai@kylinos.cn
Subject: [PATCH net-next 0/2] net: dsa: user: minor cleanups
Date: Mon,  9 Nov 2026 20:06:05 +0800
Message-Id: <20261109120607.344544-1-kuangkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f69cabe3-d835-4fb6-b654-d0e172bde743@lunn.ch>
References: <f69cabe3-d835-4fb6-b654-d0e172bde743@lunn.ch>
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

Two small, self-contained cleanups in the DSA user port code, targeted
at net-next:

Patch 1: use u32/u8/u64 in the ->get_strings() and
->get_ethtool_stats() implementations to match the ethtool_ops method
prototypes in include/linux/ethtool.h.

Patch 2: document the plain wmb() in the LAG DSA conduit migration
path. The barrier orders the dp->cpu_dp stores before the new
lag_dev->dsa_ptr is published to the concurrent RX path readers.

Neither patch changes behavior. Reposting now that net-next has
re-opened, as previously requested during the merge window; the patches
are unchanged.

Kai Kuang (2):
  net: dsa: user: use kernel types in ethtool callbacks
  net: dsa: user: document the write memory barrier on LAG conduit
    migration

 net/dsa/user.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
