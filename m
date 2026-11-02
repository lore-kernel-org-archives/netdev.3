Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619972;
	b=OOEj8PfDXhQ42HlhJZl94GtO9TNgBgSL/11G54WkYukwACyw2mQPRf1Wpr6FxlFML4aX
	 TSWxIReIlwDl5eIIU+eO50DCprspyfWrx9lt6ehd1scIkI3zZF8l+wdPHsByEaToLpDlC
	 uEZGaWIdQJn/cvhad00tcKcNZ+TaeyZLSEjUGL1P0t8wh+ddE/ZrBpSFrRIPht5Wmj/6y
	 taDgvCygE4jMgfUa9s/jwg/PFP++dn/O1ld14vszekxxvILuKG2G2DW8lXaHjVqRqAXlw
	 XN7t7cSZS+PIFZmGTF8R2vJ0recr3ZO5ZajqHn8Civvpd1Y0oWM8DnweMzcpq2Jdv/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
	b=W9moCjzxElGsw0zMRtSKQz1uQbLQZyDQLcJJN0NEbPBvG/Zsf45hb39ahXWZUGzlBfEy
	 /V+dHX12eK5FaTxa4V+C2VfKC080N1nSeJdzMw3No7UWFQPM3Axf1+JF+hdhYyHBNMAH8
	 VrbivGHnTcCvFlQU0ZelU40ZdaU5zRAZPNAaUV59DmU2Q7fK18u8ypaGQSjvhZWcUwKCL
	 fXGq5HPKSry3J/1Gr22Si5Y/UXNGGF9Df5fVYdc0dj5tp9e9dOTBnVPviI/ac6sy7N/FA
	 1Sjpkaa63GTEDE8S8sxhX2xkbsSDbEhtw6lpbUYuhTz7tTYU1elMYyOvvlDPkJfMeKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzRFsO30;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGyTdP6z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D7606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1D7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzRFsO30;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGyTdP6z
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A6FB213998
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 11:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m3mBrDhbcxfP3/IX04+tIZ
	dgrJqn6b7HrBefYlPYicA=; b=NzRFsO30Ryp9ALm26cRedN2hD28g2VBAkl866F
	8VzIQpnPZMzEVt7Ijibk1rjcbOIuPySzM/gdjLFyx7NUSKdIEfWXk1wmFYjFynfu
	aPha00nh6SUYaJPCv/WT9627trx5tOb8jPnHj/AeB1seLN026eQ1ywwirBQX9lni
	cfam4I3tS4lIFsdpPXrwPhAH/WGHbxEr4+0kzJ1JRJsvtCpsrqBWo9u5+Q4bvn3C
	4lEyJhCqhy86onOWq1IJ6K3k3AhpKrdTkpOqHz9X4ld0dzhsDSUjrlyhBk6PeHBL
	qLcrrATrWyqoh3Zgf5kPy9xiBpSiAy2aiiTf34Lc2T0oGdBQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1sdsx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:46:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c15deb3794so569943137.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793619970; x=1794224770; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
        b=cGyTdP6zmU73zQZtJ4LkaKykCOA9iOx7jd2yJKhvxN/I/wbjpAfFRt5HQ52MrJJvtd
         IrlOLD9FdqNIeoNEoA4mE8TUD825Nb/qnXjy1x+xI160MdCqx9/Jcb8wtc4fNdbkPHLt
         IG/RCc60YYGuT6DbRF6h9cYPEY72uHEvgsaQY4jAu+9n2YuRk2SEqDkq6X/iZpUvfN6J
         3V+hXkBrN4FgKCiF+TUrIWWD0HegiRCOaoZcs05wc5GBSamyT3hW80Hpk/7gk4aT+tfa
         dAym02EkLsKf/IQZ7voFrfvB3TQyAPItCNACvZd87+ixapUu2SVve+Yw7S3xFM7/wi9G
         8eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619970; x=1794224770;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
        b=NZO68DFSPeOf98kYti+sInbctzx4V+uzdx58I+5c4ufBMievsoJbh8vamqsCbjI58B
         NvO6ISnlh5WTEOXCt7eo0PpAxSTmJ45utFGOkRWBjvCEX4jSXS4L6RQReI84Vh1IGu0y
         e9mRtjSACWmhsJeUUQoH52KBZCmcDltXYBrOKb4Eni04fKWf1eA0ozfExbsqgQLfPPDk
         INkQj2Aqmcdy3GLaEbBtRJGZ6MIE91Y/0OSOVf49sDd7piNxw84qFn5V0ogLgI8X4BOG
         1Tbevu4Z4STyYEMxpL2eOOwA4xlAjl1V0eLS/A/BsKIWezZfr2i13iY+dwxE5e553Ndh
         uLLw==
X-Gm-Message-State: APuU4Z89qj8rpow2/pIIKgyIg8Rk09PdS+0ybr7OB4IfeizLjDroeLGR
	xJZtWLJIFalAUZDQPEDTHS4SIYpgGRkt52vuhyD2Fafn79sIZh5kYu4adWfbzRiARt81+sW9lF5
	m0AnxgW+BI46rQZA3RhGpjLf2PCrXMPK1+b/bdeuYUH+yF5IiXAYdmqBdN6o=
X-Gm-Gg: AYBFou3EMbNMqYTCStKGTVQm8j647Q0Plb924YHGVj2dxLT1twjqlXNQ3CR187iWoIe
	DccE8chwTqom7oQRE4GQiPHKQsbSsE7ka8DtwmM5GnWhz7mwvL81wKiQApdsVd1aQxZH7IN3hMm
	QRQaRwkK2zzPQW4lK7DeaA7o6v6qOt+k6Wrgh5exGR7E84V82QUTQN4JAjl+m/I3UCjYJ3Prcmg
	8tQ4W3FooqFt4Ma7INUaMW75/4xc6qC7AvHSziMRVvAfcTJRJzw2ffSefvWy3wvkKpjLLuydVJl
	CayWa/n8cv1kd6m3MGunMaaB5Ygx8AcqfVu4FgN2bUtJK4ishHXa8VwyQ2esZDSBSOQYSjsILmq
	GW52x1zDUIN60+R4Iriw1XeX7+COuXCke76dtyL7ELVOcz63W59urVW2BT7Rwf0Y=
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr3718022137.34.1793619969975;
        Mon, 02 Nov 2026 03:46:09 -0800 (PST)
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr3718012137.34.1793619969394;
        Mon, 02 Nov 2026 03:46:09 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm19226037f8f.18.2026.11.02.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:46:08 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 12:46:04 +0100
Subject: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBN0FoFdJUImm2oWmqhEEN09a
 fkW/z9QOAsXGLsHMl9S5IwNpu/AHxR3VrI2A2ocjNGoSg2BvAtMlVZyKblE9VDam8WitYzbAi1
 OmTe5//EEkSvM7/sB+NAYDm0AAAA=
X-Change-ID: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: yfXT-HlCBKlgjLJ7VwlYERPNJVgxtals
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae87803 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hfst0zn1j2-VxDRcdEQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX1xrQhxP1Az+x
 Z5hkMykKJTEs0Nh2808Dm+u/fKj9rdQCBoY8Jgi9uzOXpKru/rnLktx9LmJ3FEgXZxW3+3SjJxW
 Jn5MoY/eigEqcplN8RQIuwwEMmie8SE/UzLmzUvAJam/nH9mdGAstM3PSlxHhyDAP+uPYv07pAo
 BeAfM/BVB6FKa/hjWlzvQRu0QOqdic+RfR5isVFBgJeDSG0rxbRhaedhflX9Dz6Bl/2lbxq/UwH
 +E7PfUm90XIiosYzEb2mCVtLTu0/H3VxNJlzmmzCs+USEQg/6xB/Hb4DXuxBRdFUWs4FkTjs04T
 nqXKosM7mKyxoFdI3BIoiOZzANQH8sgJk7im9OJgJVTwc9H8I9d5ydRzKIhR81tBtcP1zczv5G4
 98jvnIIDAL8/07JWPf1tXLt2A6qqJS+Fb0M28EcpIql9xPk1rTnXGr/TlvFf+8SfpgttJyE82B5
 cFBhEgLCSCdXgN6nN4A==
X-Proofpoint-GUID: yfXT-HlCBKlgjLJ7VwlYERPNJVgxtals
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX6iBe0QkFx6lo
 pvth/1si94b6a5b3BQybB98TLaWzshaAJLn7Zwn/Iwkw6ay7GGfkY2ghMjCfdQnk0dPq61Uembi
 DrPcOUYnTHg6sI8FKJNliQTgZXrVKqc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046

stmmac_rx() initializes the XDP buffer with the metadata area valid, so
an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
it in [xdp->data_meta, xdp->data), for example to export the RX hardware
timestamp obtained from the metadata kfunc. When such a frame is passed
to the stack, the skb is built in place around the same page with
napi_build_skb(), but skb_metadata_set() is never called.

napi_build_skb() clears skb_shared_info up to dataref, which includes
meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then see
an empty metadata range even though the bytes are present in the skb
headroom. The AF_XDP zero-copy path already records the length in
stmmac_construct_skb_zc().

Record the metadata length after reserving the headroom and adding the
frame data. No copy is needed because the skb is built over the buffer the
XDP program wrote to. With the length recorded, the software VLAN
stripping path can move the metadata together with the MAC header, as it
already does for zero-copy frames.

Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive pkt")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b038472b9817..f97f6dc08789 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6012,7 +6012,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		if (!skb) {
-			unsigned int head_pad_len;
+			unsigned int metasize;
 
 			/* XDP program may expand or reduce tail */
 			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
@@ -6029,10 +6029,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 
 			/* XDP program may adjust header */
-			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
-			skb_reserve(skb, head_pad_len);
+			skb_reserve(skb,
+				    ctx.xdp.data - ctx.xdp.data_hard_start);
 			skb_put(skb, buf1_len);
 			skb_mark_for_recycle(skb);
+
+			metasize = ctx.xdp.data - ctx.xdp.data_meta;
+			if (metasize)
+				skb_metadata_set(skb, metasize);
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,

---
base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
change-id: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

