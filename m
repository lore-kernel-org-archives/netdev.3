Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F34C8FE6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271886; cv=none; b=FJdRXdBHQ4ubmwijloSfORc8gK7Vb2Wat4k/nlCWo36VioDiawSrKk6Fg4btGVIlpcY0ncnEs1Cf8CJEyCVFEP47s/3aODEnrdClr/t/s9ESLFxlxtTzbDbkoNGbeqnpBJN64BJhEP3RtkYIvTVisrDsdzouZJ0+Ruxk3tQBkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271886; c=relaxed/simple;
	bh=X9s3Sgeg+Qz0CBFuoc06D8CjvCY8qzDKaEoRAYjmcpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emixa4HEaXr9X1hVJOMPqCSdBAPXG5jeWSFkUHR18V3r9DKtdT2xiGEYodtu4fBRVgu5Qgh6pItOuY6jk2ubM+/bWhnup2amOdRT5UlknaqIt+x6dpAVane5m6ogBcTLpi7Cu/NTJy7VTtBwqSAh9qRhSuIjmv8Sio5fambyn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAddMsfA; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAddMsfA"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-48f0056ef38so213324fac.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271882; x=1790876682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nf39wGs2BpcRYOj5iRc1ngLTSaY62SScC50mxJXgkk=;
        b=tAddMsfAAU1PPSw2FJQfGPBb6Odv8qU2IKRwBjYnrPB0HnuQSHGIFmXGFcmg0mOXfE
         Lj9erZWNm1FweaStbmSK/flb2iww+b99ydbn6LxUBQ2EutWHbHmQtpfWrwqkE5XfjdEv
         h047eG/FIiYj7C5Z7I/Nyx1+PRu+/eFlhU0wB7A6ynDkBEsIV7FoovsW5R/jBrbHJcgL
         1VmBQyiDbJpsthEqGLgVCxP9ACEgkmqkQ5aBxWe46E8Rd6xU0y38x9WHJi2hPpliUkbW
         2boKDXlzJa5SOWq6rElGvDWg1KmFdyjwYJhku/NAD0Gct9ZW8EoseK7oeisVbdlfn5+B
         alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271882; x=1790876682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nf39wGs2BpcRYOj5iRc1ngLTSaY62SScC50mxJXgkk=;
        b=iieDqYHYmvsHMD80VZlBq6823sbNVRr5V8RbG1sgW9kcsO1I3vSsgJvofpbE3aaYcC
         +sdDCIefXEAtSjZ34tyC1wxJWU8P+0zgLSV9QPJ2dRLkf5NBfuiGpkrj2QkQx/E/iFlo
         q8MfMvLSmdzo3BiCyzS6BIlpl/gpcWx5E13bnenkyUofngAOnBGArwrVn4gpCtW0lZrx
         XlcX+ROfQj4X5MzyytQR+03E9Gv8DGHR7pmrAC6ZY0zCuTkenwOWZASfwD7hT4ixN+uy
         paRLzH/tpu6YJkYADj6UmcH70XO11KEz5MrVQcGyKYhFYVdGf2PNCqBpqMMDfyxtIhtv
         gVdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR+vd9938qoUBf9ujrhVWFkIbQEO8tD8rUWiM3YRY+q7tL3IRZ4saLnLU2ba5stY81RP35OsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mRKLbLIhcJCX5Re1iVjLMdtgLA+TeiS27cTcKFieYbgMI8g3f9
	oIUD86h/PDffHMik+f6px1VgLhFJtZlOG7yhY0HyM5wjzfbKV3Kvldps
X-Gm-Gg: AYBFou2XK6Lfg55KKK81HiJYL14QlgS8dqnF6XnFOFsYIf6qSSP/9t7ei+iZ2gHH7Lc
	RR2mF1ENJsYhzouT2TWXLeZpuyIobrFJg/QtnsktejbwMq7e/aRhB06d0J8Jcuyu0gFrnsXUGDw
	V+Gv/kY9ig3eb0Nl+frcDTz9afY660V5syn1RV0UMvk/oztSSZtityxLQPDh8KzYxKkIBswqa9R
	TaWt6tVfyZdqBWuWCF9BJrWTYiJvM+iUcJvMrxvxjhsxLECMQHxHo5EoUXwLDMHjNSWlqXoeSAW
	mwQUCLm4lRMLr5xcMWfi8wETfw1b4705kxucTF+U2Wc3bBoc5uxmsMuoSp4EDBBP8nOLOH+5qU0
	4Tuh+z128N3XXM+fn68oI0gRSUAHb/inwW3xnTO0puYHL3B9CENkeC4hU0AXpT43VI4pfVFhWLd
	qfJwd/CS6RyGfUoV/SkBD5Ql7aBODS/vuhF5/ElnzzUIgCqwJROYVbORRlMk7qjW19Embl+OED+
	oQwz9ONfOY0c7KPweiEHm+1HMxku4OOvalUJaW6b5e2cFhtHvwyCeQ/89QVNZgZiFTLe4Y7kde7
	qFS9+WLRsybS/6mdIDCYDJRzL4HGbxMX5v04ZDN6V12/AU2PHtFmrcu9//DVG7MHfuO85dHdmXJ
	LEdSgwWKLDjR/C56q7kchwg==
X-Received: by 2002:a05:6871:3a27:b0:479:a30d:60e5 with SMTP id 586e51a60fabf-491e91f05e0mr3134003fac.37.1790271882396;
        Thu, 24 Sep 2026 10:44:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:34 -0600
Subject: [PATCH net v3 04/10] net: stmmac: leave the datapath running for
 normal-size MTU changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-4-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Changing an MTU at or below ETH_DATA_LEN does not change the receive
buffer size or the MAC receive limit when the previous MTU was also in
that range. Do not release and reopen the datapath for those changes.

Besides avoiding unnecessary hardware resets and their failure paths,
this keeps live AF_XDP pool bindings intact. Preparing replacement rings
before stopping the old rings otherwise binds the pool to a temporary
RXQ and consumes fill-ring entries while its current RXQ is still active.
XDP already rejects jumbo MTUs, so all supported live XDP MTU changes can
use this path without preparing replacement rings.

Keep jumbo transitions on the existing reinitialization path for now.
The later ownership and rollback changes address that path separately.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 43a6154fcf6d..f7e91ae21448 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6223,7 +6223,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

-- 
2.53.0

