Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E05111B9;
	Tue,  8 Sep 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863551; cv=none; b=WVP2883NarKyxP/qZsmMqgYBQ4d33Ap/tJIlgFniHTc+udnn44kjNiB1Kk/VPJD4wSk9bDGG4zDIWfffctfsY9ROw12InkM1I/6AuHXBbx+EWPQ9kAUciSp0WSKpEvkRaitNvmMXjmnCcu/3v5d1X19ffsDxm6TM50QCz9y8ffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863551; c=relaxed/simple;
	bh=bmA06sImOOe1EDWPZAWmq2UY6jPxcPbKWJNup0/4at8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUeKdkauTlyMVMLPvrMWro7zqeElWx3N2Nqp/Sahxx2EVfKnsmNCWndYdI9TVjYoqmwPzYFs4H6JswhJb0RlBHdZniALOwivGlyMH24x5L+D+LRCUGfn59TXU8dSde6pvrCfon1u4ltV6wj74yT+/V9xGTzVNaoq4I6Ow99PBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 92415b26ab7011f19a56ed5b684f684d-20260908
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5da9aa34-66f4-4b68-9d52-2b3842994f01,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.19,REQID:5da9aa34-66f4-4b68-9d52-2b3842994f01,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:7db8b62,CLOUDID:ceb75901a2ce11b5654635ee8b23aa6e,BulkI
	D:260908183224U6YVZQ46,BulkQuantity:0,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92415b26ab7011f19a56ed5b684f684d-20260908
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1793997322; Tue, 08 Sep 2026 18:32:20 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: rkannoth@marvell.com
Cc: 13667453960@163.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	gakula@marvell.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sbhatta@marvell.com,
	sgoutham@marvell.com,
	yijiangshan@kylinos.cn
Subject: Re: Re: [PATCH net-next] octeontx2-af: consolidate RVU AFVF device id definitions
Date: Tue,  8 Sep 2026 18:31:50 +0800
Message-Id: <20260908103150.737161-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ap_apjF8eI1ADnOF@rkannoth-OptiPlex-7090>
References: <ap_apjF8eI1ADnOF@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ratheesh,

Yes.  The patch was compile-tested against net-next with
CONFIG_OCTEONTX2_AF=y, and I also verified that no other users of
RVU_LBK_VF_DEVID were missed.

Thanks for the review and the Ack.

Jiangshan
