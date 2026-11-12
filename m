Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501287;
	b=4hwbkWouz+o/zhG2OeNMXfRiXAyZbmQNb8w8FHoWxYyt76kNL926h1vSvamz4hNgWcB1
	 z73PqaW9bQSDDXEXBkdXQQaxOrIZLsdTujYoqCRisLrckwErUd5TYTHdifT7CxOYom36H
	 vOc9N3ZMHyeLXlC3MWtiXiOk7+KNWviFN7SlZAWJPvyKQ+EoulzdnF76vdTfSSNc3CjTM
	 LAAnJWvEBEgZNzhOifBcf0jNr+CQ1hDTG/j0lkSNrg2/mcEATkbhRuw9AORDZmzkMeNRi
	 +td1dSyE7r9iU8Jp0ONoamIPkmDb9L/cpVEq7nrwboJIVKOwiKk+mh1KL9lVd642hVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
	b=Twv++Bgjm7y6pFqH06G6EqPcuCc6Y3EATN0lUjxSwqeZHnbfuxta8mHpOeaMWmNWwGgO
	 1rBx6iIkMsFrWhmmt/gibRZB0RsAtqNRgJl/SVNLDXTMMQzUs5lyeUxT/KT3zl1OkflOW
	 gDSM97v0sngApNIiHe4HIZXsV3IH96uwU28l3J0lnoJs69GDuBHW4Psj/VFB7FqiRuQe9
	 dmdd+40Ltn8cvBtngMY9thgrWAzzHv6wWJKtjkoaPfFnu5BfKVvPIVXAQc1G0ddNhMrGu
	 hb5t78YkmzXMA2JsLCqbrSzU9ckpiiF6v90sTKtShDvPaGEiQrAVBzpSjMQ2spsex1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQCB+TdO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dAJz6Srn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2ED606A8A0
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2ED606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQCB+TdO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dAJz6Srn
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZNXd2293189
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=; b=jQCB+TdO9HvPNp0E
	q4v5lmgSswC2h7Spqpk5ruzI5e4LHB9uJjkwMFCcEekKUZyej6K1sOnPBVrJzHNC
	c2ojSkGPNzD6Ep/qyZwDewP3Ulat34rgrq1Da9rBXKXU/D4XW5LwK1eMlZbOLbgs
	MlXShAKJySgUCE4/75lDBSJhHeN/dIteMelt+ZLF84kp4gGFmhdHYSe4odw+BegI
	XPJNDUudYqk0t6iOpWnVZCAvC+lzWBRlDoGo3wz9ueyY1yscyL1Cg21K2BF2B8wR
	ufqThHxLq1KlLrk/t15NyfCLJY4fhYvRcX6tcASNu7T6bleqldQnIGLreSe0FMy5
	RIykYQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs01b2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:45 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso13250241.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501285; x=1795106085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
        b=dAJz6SrnxJI6qh1WWjsuH8CiOeWsiG8sDVamOnklBO35qCal5FElbRjKL7LEeyDBez
         7/tDBfNPkw+8yB+9zSB0rgeOIBzgnzDfxKQ1adBf693M50MToBfeliX24GNAJB351iUm
         QQ+WEeLxJKuwRo+gDYOe/vL5HRDii6ln7KeD55tFAZG7JZHPxVwEILX2BE0rvkOXYERr
         BDF2wfFR3h9yxQom92cBUbQrcfWFKHuidryokB6fBT4Nsm8FREwE3GUhfZi3RpS6GQZq
         g1nEvpPa+xgLqT1fh/mNeS0YLO6oY/iBT3gQpM97iqoc4vpZIlhgxLK+BKNRPTMAPMTf
         ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501285; x=1795106085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
        b=KLbFEm4cQoINTj/C0t4iQVPc+h3WEAkzah2lsa2M0Eh5+ljOJxdP533C9IBEatP1Ge
         Unh1awjy2YUabTy013zRIPYXxDpCQtsfSuXOuR4eNnvafUji5fQDB+BNdiQKgEqC3Kzf
         C6bSxF0MJQweNqc3dHKhBx7IN1GZCg5v1SZkHO9UwSohVb2ggYBPU2LJwgntOE15WAvV
         PR71UkopCQKphV1Xd3uNlXb/t3cFjAvLecYIxgAtG8UNzHLgiYI0CC7+MvP1XjKf9GDN
         8/BAg7Vj4Xlqp+gWHCRB7pTJeuMDrQ9NJvD23+ORUhjAWIoO65TvY8P5rT7pSnaf7ZsZ
         ZktQ==
X-Gm-Message-State: APuU4Z/DgoPcedRYY15NqnmtAKUH4HQcjwUpbrGDD+ebtdMlWyxB5DoP
	tv3l+bBfxsci8bzQ3hKMb4MIu+hCXKmT7W+aJq3swTEj4B7WORTL/azVckl1UZp70S9EhBROOng
	EUi4lcfh9ArOEF3VNRmLWacMVdC+733pOiOt0/sIUod2p2YOHyFsS8cz1wi4=
X-Gm-Gg: AYBFou2L2cW5VXAodOz+EWkLAsj1T+K9dbupcALGVWD1TkAMAbRpBJbB4lD0aONUDa3
	i7qFTcUGXfAywzysgpe1hP1ZyfoN2tP2v580JMiRk7U+gDYLgY0TOLtnqKxjjJYtiR/HgchaoXQ
	MkMpmi5GSh9LR3jrum0gBYE7FiRBf57R+oQxMk+bqhj4+1pNwThnllwRYtL9BP9zOtfH92IyKtZ
	cZAoB6Ph/iPvTzqICKOIsgnHt2yKOykXTS1xfXx2UePdwow6hmqtpPXeUpsq/1a5+/V8W9Qytm/
	0Qnuw9OJQ+2vVwyJnSDP2npRMouNdq67JekTii6ItBAQ2sv7pR42LsK5fcQBonqzcymUTuCkMpn
	UFYxwHAASX/BGr1sjhL7vajlT81OrRKXXJtqKF95XL9moUZYrSzZX4RQmFkOGp+Q=
X-Received: by 2002:a05:6102:2928:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7d5061e6d3bmr2487598137.34.1794501285234;
        Thu, 12 Nov 2026 08:34:45 -0800 (PST)
X-Received: by 2002:a05:6102:2928:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7d5061e6d3bmr2487585137.34.1794501284694;
        Thu, 12 Nov 2026 08:34:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm144499035e9.1.2026.11.12.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:43 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:10 +0100
Subject: [PATCH net-next v10 1/4] net: xdp: add __xdp_build_skb_from_buff()
 helper
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
Message-Id: <20261112-stmmac-rx-mb-v10-1-d3d04b65c6bc@oss.qualcomm.com>
References: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
In-Reply-To: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfXyrpAV4lQ3/qC
 +xzMRDgqPVstib+BDTDh8Qga8vQtjV2fG21DAlEZva8Fg1uXclwA4Zd+DJfaapE7rmL4aJuywrJ
 JPMA0+A0uzZcKVMJ2piSY8/zuA9yxg3b5zSN1UPXzjA7EBQ2DkDl06HSRpoyZ4z2HESalo9n4by
 36crDjd8RK2KPqu97RjzW6heDwuwNlX7FCWn0iUXxNObaKNO3AR7ii13qIvTHK6xA0JD8e1gz3J
 WMKRzR/EUZyMDEU/SVwlyNHM4Ph2IU5NEd8jYYP422ywEkyzOMhVYXWp4l/HRQiNVyhmIgh2lEc
 DMpkY0yKaq0ufFL2SyV4S/2SWwIzNO94zaEwkvVDYCO6bezmcCG43LYVO4P31VC48AnrfO3+yde
 WoNz6ht6wkfoPxJcQatZMRoeDbUilyp7NK6XUpmrFWzJrEclcjdhK/wrrtBg2UR2oh5Qg2rlN3j
 KY0TVIeLGIBQf5ptkfw==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5eaa5 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ksGhbug9fU3i8ddnHjYA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX7AM4vHogb5Ic
 vi9wepC22iwrgpDFblVmYgcAX2a7coKzIPO2+3DQS5QpMjt+PM+XI1VZP/o+yhL9rTci+bt9j/a
 IWnz95CEJRh5qBhzAbOaRvSwQdbvRWo=
X-Proofpoint-GUID: l-D2nzXofvOZ7wjWlvLIjF7Sa-YyMkGs
X-Proofpoint-ORIG-GUID: l-D2nzXofvOZ7wjWlvLIjF7Sa-YyMkGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065

xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
builds, which consumes the Ethernet header and advances skb->data.
Drivers that still need to process the L2 header before protocol parsing
therefore cannot use the helper.

stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
the tag at skb->data and shifts the MAC addresses, so it has to run
before eth_type_trans().

Split the implementation into __xdp_build_skb_from_buff(), which builds
the skb (including the recycle mark, the Rx queue index and the frags
info) but leaves protocol parsing to the caller, and make
xdp_build_skb_from_buff() an inline wrapper that still calls
eth_type_trans() as before. There is no functional change for existing
users; a follow-up patch will let stmmac use the underscore variant.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h | 17 ++++++++++++++++-
 net/core/xdp.c    | 11 +++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..3a25307e1d67 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -379,7 +379,22 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+static inline
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	struct sk_buff *skb;
+
+	skb = __xdp_build_skb_from_buff(xdp);
+	if (!skb)
+		return NULL;
+
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..470bf90d93ef 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -620,17 +620,18 @@ void xdp_warn(const char *msg, const char *func, const int line)
 EXPORT_SYMBOL_GPL(xdp_warn);
 
 /**
- * xdp_build_skb_from_buff - create an skb from &xdp_buff
+ * __xdp_build_skb_from_buff - create an skb from &xdp_buff
  * @xdp: &xdp_buff to convert to an skb
  *
  * Perform common operations to create a new skb to pass up the stack from
  * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
  * skb data pointers and offsets, set the recycle bit if the buff is
- * PP-backed, Rx queue index, protocol and update frags info.
+ * PP-backed, record the Rx queue index and update frags info. Protocol
+ * parsing is left to the caller.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	const struct skb_shared_info *sinfo;
@@ -667,11 +668,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 					  tsize, xdp_buff_get_skb_flags(xdp));
 	}
 
-	skb->protocol = eth_type_trans(skb, rxq->dev);
-
 	return skb;
 }
-EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
+EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
 
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb

-- 
2.56.0

