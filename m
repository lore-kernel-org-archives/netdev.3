Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D56497B77
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160199; cv=none; b=Hey2C9i0zEEKS39OcimbiFH9+RHW2Mx8JH7DPgbawBq8mIBnbe1t96c/sl54AsalGoOk7DGVLjPE26Uj15U3wzNUtJFj0VCMBAqvbCFROkJnS2jo0v54lUXfS63wn+EXPnFpogaqxM+JBahZ/gdcQK+StpBUE29/aVr1OdJ0zUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160199; c=relaxed/simple;
	bh=PLpGa0xqGogXo/lsCeMPkcUMsMYjj9RhF8TNPBpQFdA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcbdikBijK22f3JRuYmI0iy1lZBNThbtAARggfmKHYvZPPqXRVO4sDPnBC7YcWGPbh3H0Db/maUCVHW5+C/5yBB3uDYy1xQn0w0xdYVSRcPFeTHo6efscdHreXxAUjE6NIxQeXGwGt+lFrFiKa5Uo7l7sdcbX5ITJKXdlnQg7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 881c3036b73b11f19a56ed5b684f684d-20260923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a26c5c47-06d9-4a7f-af2d-1890c95cafcc,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:d31e98d2dc5902b90057bdc7252be9fe,BulkI
	D:nil,BulkQuantity:0,SF:82|83|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 881c3036b73b11f19a56ed5b684f684d-20260923
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1920627597; Wed, 23 Sep 2026 18:42:53 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
Date: Wed, 23 Sep 2026 18:42:51 +0800
Message-Id: <20260923104251.1514090-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <arJev7h-_lEii1Z2@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Breno,

Not silly at all -- txgbe's approach is indeed cleaner, and you read it
right: wx_control_hw(wx, true) lives at the top of txgbe_up_complete()
(txgbe_main.c:160), so txgbe's open error paths never have to unwind
the bit.

For ngbe I kept the claim where the vendor put it (top of ngbe_open())
and added the missing rollback, because moving the claim into
ngbe_up_complete() changes the driver-firmware handshake timing: the
whole setup/configure window would then run while the NCSI/OOB
firmware still believes it owns the port. Whether ngbe's management
firmware tolerates that window is a firmware-contract question I
cannot answer from the code alone (txgbe is a different product line),
so Jiawen/Mengyuan are better placed to judge it. Deferring the claim
into ngbe_up_complete() would look like the cleaner long-term shape;
this patch only closes the existing inconsistency.

Thanks for the suggestion!

Zhang Yunfei
