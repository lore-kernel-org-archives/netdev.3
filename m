Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6840DFD7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100502; cv=none; b=ALtv5Civ3IL/KDygJlmjcVW/6b07m4lLH1hAawBXyR5Jhon71XKFDshy2ynsmf8vdKo6HctPjGO9y5nSkUwLhQISlExNxoEetgIJ0IKgq5laK1dQBukc6G7c7GkOPo2jgyuYZ9FUesvnhsToVMkxYrjXE8xEJNAkspwiB/Lt3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100502; c=relaxed/simple;
	bh=2K54XHtMd9gN3woCa+nMyomBLjQVPk/SnZmGOSzGazg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7WTlgcCoI2ezxpiSmVZqd9ePC6UM23z45G5NBK/C9x+vV9Sg/oqmLG0oGa6m1S7RMF4rSh9P5yLnwOGdkfbqFasmYYR9PAaCma/DDGTzkF9JmtSauiHaCKBt3DtyjrjAd1PkQCTxDWCfD2tYDVX5mb/4HXS0n9STRzEIFPEfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=g6A7B+W9; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="g6A7B+W9"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 24C06207B3;
	Wed, 10 Jun 2026 16:08:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJTvJ0N8_YBR; Wed, 10 Jun 2026 16:08:12 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 91A6A207B0;
	Wed, 10 Jun 2026 16:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 91A6A207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781100492;
	bh=hzhFqG+r6SWEWhPGUj5w/TUze4Nt1qP89oOTVNNMgXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=g6A7B+W9ERC8MyhXbWVdNunYpZV9T1864NufX7YITDKEtl36UDQolmzeowB3jtKSk
	 Sp4pKsJPEeqU6JTW7LrKaruMhdHqNjH+baaIoX2HSC8pn73tEZbeCmbt3EvfgC2zz0
	 VCg/wnEnA48+1qDC0CGICuGnTMjojYjqQXZjKWwdRSmEv96huE5y3x23J2cnHMtyg9
	 QsX76/B2tDALCv/anucCYsCee9zx+oCSuVjtpccM32CenLBCp4gEY8SbIpE9ELY4im
	 BfqSOQc70TgcVJSP49ZfkHuLAfF0ArlRT+xu2c+GH5/xIiya3utnZj1/lvVhhu9gEg
	 49g50AS16hRsg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 16:08:11 +0200
Received: (nullmailer pid 2563194 invoked by uid 1000);
	Wed, 10 Jun 2026 14:08:07 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/6] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Wed, 10 Jun 2026 16:07:40 +0200
Message-ID: <20260610140800.2562818-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610140800.2562818-1-steffen.klassert@secunet.com>
References: <20260610140800.2562818-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Takao Sato <takaosato1997@gmail.com>

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6c6bbc040517..62ba828632f1 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
 	       sizeof(fromi->frags[0]) * fromi->nr_frags);
 	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
 	fromi->nr_frags = 0;
 	from->data_len = 0;
 	from->len = 0;
-- 
2.43.0

