Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501289;
	b=bM9kn9lxlKRwDjD9vuX1wHNCaV+s77Dh1aXrwH74iDtNkqcpZPJaqVCad9R+gvXWhbqA
	 SLLoArsdCZpAyJzdaOZdqgz9Wli0S4S4NsTimqbO5FBMjqDBH0aRBYn0+kHZlpxU9StAl
	 OgQO5afuCQ0pQ4tiPbhBOWnERvPG4q8Xco0CvcneHeNJoEmYrn3aibQnMm6riKHBNLRbL
	 gvKAPmaPi9FUbr1LXi8w8qGSmHyWWEa/fvJKtUs/iVhxmgImJqJHUjw6DD5ddEg0flFxY
	 ZXV7YaI4oeQ46vV18s3OoNEYCnsITWcHoJE4IssDNdnRTs7RGt64/6uPTjEdIpSOgAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501289;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
	b=chTGnYndjBAs5Nz7h7/P1sdTywzMbpEsG1C42aJiNE6gX/QJyR5wW/49RCk0L9JT/z8E
	 g7OHtlx4Scj2ZpL7q2P9J71s6WjI+OuF2pt3VKt5ce5Sa+/I1IfqlE2v8zd53aCL4Dott
	 KiJNblHxs1c01Bh+7Ydq88gY2rBc/iNXBIpfTj0tR8AJvQYvjp1MD1sWiD6FWl5AHfLfA
	 skjYXJWMT5eqfgZqUF1DzwmX5su5FCeHeCzDGR34jWHq+oVIAhBSt1+ouA4r9sUlvjPjj
	 sjo1sQAe72mV2kuaoAgbMzBrCogJXCrgGK7+kXvZtYHzEZw1e/TSanzxIiF2R7+zo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMOTIcR+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O51bu1cv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1337606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1337606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMOTIcR+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O51bu1cv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZk8A3181044
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=; b=NMOTIcR+krVHn61y
	LKpFviS9NKCyKuBdi4dH0rTrbJmDpQtw5A+t44i3oCzYTZwzdBizBZSCozLNZ/Ad
	jRokNnn01vJwvhypnq/AL0Svphb4IPMfx06lfUbobQ6sIH/lUjiMfH9gFzIuQNsL
	7kTUBEDPo2dRHosoRAU5Q8oXZQt1olTF6nbq+WnY2IyCtekO839acQgsr5bnirlF
	lRhLjv5PwZvcLlUdwj/WXrkAY17QkZZ006V+h7WRCCegfRB+I9Clv9CX6iI2wLlY
	cCthBbfgF22SgnwsvTIB2f432HgYeYXPRRNHGhLxKNj9bnehicaOVBikJCJLinxN
	cDoU3w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j18ve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:47 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d2f2df81bbso3025971137.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501287; x=1795106087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
        b=O51bu1cvRcE20SVZ626zDHnPeLuwbqCKacL/b66t2ykRuBEkrYE6oKi8WFbH/NKobX
         yOhJN9ZMF+GcGJhdJJpmLiZIEsQSQg2cQBXOTRWsSZZOrDTC6+yq0jk5Pi+Q86z7zI0B
         ykTAfHYobC/rs2QlKAytkCeubiSmziuB7VflhmqqMOmpLh0JvW4qeSd/tWQzuiEpmLFq
         DLrQWF8s6tF+bwlpf6vTLKAl7JwoS99c2qkKo2YM8VOFd3GIzxg7bU3c7W173SJ/HHmE
         m5XEcH5EIKmBKTzYIndLtBTB/Z/wdTaBlGunOj3dbj+F5nU+uUBP1Thg95b5+nyRLlcj
         9Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501287; x=1795106087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
        b=drUU+jH1JFtvgSbRA0MJvNsV0Q9Lqg2ToZoUTfY1vdhfX8RotE7sxqmRd18L9AVaHQ
         8XBnLIsl4CnOWyB3DVXYIv3JJ+OnxiCFvOsBR75lck3U1lgCOWE5aNEmYJNPQVm+aGVW
         Xc9S28YhdkpHS4MD8aqLvH3jQ3hlYMs3pmDHx2hrSSH7CybA/RgYi1gaaoQrOqNprFWq
         nKYNmRoMpT6j5zAOKeloo9lMjFbg/FEo57mpX1mcKDqTCSkf2WIulo6GqTp7As0uqMTU
         bJEvyppj4g6N2uADjRW6lSPzsxzZ9cu6JI7IxAjVZ/iMtUKMlj9aIjy1QIHm/SAlby3t
         WnxA==
X-Gm-Message-State: APuU4Z/tJGMOYCot7NTeU+BDqatueIBh4PzgazUms/N5ylHP6pJoyCDr
	ZUFwzimPog09qiXj/N0CJb1tPXbSu5EgVoscPXBkmVKeonIeDdlWtx6+BQrwSs3lEo2t0acHsM/
	G7d8XxBsC6EFMSrN1ZJnVnAWTojUW/m+6R2bKNm7VpbV4m6qKTEZNiTZPXdA=
X-Gm-Gg: AYBFou0Ncd7HEMVEFCv7444nOuxqdQOefwNOhzEn4XBixyIjgxZQlWCMTHxJ0TRRSL8
	wWHyI9o4ZLcxTiDlM9DhRQ4ib9/m+ygKt1bp6ttBA4Ktv/XP/MY1kafx/3lAbDrBg+z5fJtzioc
	kklXm+TxXqXXKJlAwTaRBfN2uPyHKVU0FkmN710++HBqY+6GBbihqt++5Vt9Ji7v1Kcp4ZOrgnA
	EGMYujbWzRbxhO3yN0fdlBEAbUEMiezLfRsdesWpw0auldHt3J8+uABMWTFZCMXuNhtoDU9sZdP
	EyHf2VNU34TfVv6mSU+Aeytvdb+n/051zhQGgPLg6oajIA15baM3tap0y6/HwjuhfY2HsdoDG08
	pX+iuQF/+R1nCHqumu/bULCnjDX+S6S2vcGRdAhyNBhUdGQPrZjFkPaeOQeTpplU=
X-Received: by 2002:a05:6102:6051:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d5061fc3c3mr2720234137.31.1794501286921;
        Thu, 12 Nov 2026 08:34:46 -0800 (PST)
X-Received: by 2002:a05:6102:6051:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d5061fc3c3mr2720208137.31.1794501286355;
        Thu, 12 Nov 2026 08:34:46 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm130165f8f.35.2026.11.12.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:45 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:11 +0100
Subject: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail()
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
Message-Id: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfXzlquCmFSnVQq
 FBcKHfidATm5xaZe50M6DjBNdXL/e3cNeWhKJc7Nfa5W/zGEL6v49PcHY6fNJNSLEiBK5fkmVHH
 ZoSpQL2Iu1OsRQ0+4NiOwWVBcUsbeQU=
X-Proofpoint-ORIG-GUID: UKe1HVkpJzdJRRKXE5q2dMxCj1MQLarN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX2dfTvLYsclz8
 MczWmljE9mN9gKQ6ZIENZOS5UxXHwvXozYwCshzIciMd7ECH8nk3kzmgP6+7JnZcuT9gze1eIPQ
 fgKOQnkSve/wSIDJIwg2iAJJC5ysuzkNlaJsaVUh49H4LABTyiSMQy7a0vjxfNfLRpyHvBrxx+7
 6X5fEiZqr5OIxwW73HNnwlzTvhrDAdIE7nCU3LMwHYRMylxzC1k/1sarqVkJwWybYZmFGTrR43x
 ZiI97ShkEsFOXKKLpPATO5syCAQ2wAr635Mnr2SXSqYW6QyzzcTdQk1VROYW7+DIcjCskZEpIar
 UGUqjtXO9gYe4E7GwnW+T8VNG+U295DZ9BWpOqaE4EndWANBAxdoh9UIZtAucvkonCoZM0VqShp
 HaLXSw5YRYhedCMzR5oTv/ZdzWz5Br9FGiN3816+PrLTXI+RN0oL9U9esfLiIr7sU6fctgoIQQs
 oAvXhGZh8PwC77QjccQ==
X-Proofpoint-GUID: UKe1HVkpJzdJRRKXE5q2dMxCj1MQLarN
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af5eaa7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7V0IxQAAFVITDsu0YkUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065

Move the XDP tail-shrink logic out of bpf_xdp_adjust_tail() into
net/core/xdp.c so it can be shared with drivers. The frag helpers
(bpf_xdp_shrink_data_zc(), bpf_xdp_shrink_data() and
bpf_xdp_frags_shrink_tail()) move along with it; the latter two are
renamed to xdp_buff_shrink_data() and xdp_frags_shrink_tail().

Add xdp_buff_shrink_tail(), which handles the linear case too and is
exported with EXPORT_SYMBOL_GPL() for driver use. Unlike
bpf_xdp_adjust_tail(), it takes the number of bytes to remove as a
positive value; bpf_xdp_adjust_tail() keeps its signed offset ABI and
passes -offset for the shrink case. Negative offsets are rejected.

bpf_xdp_pull_data() keeps using the frag helper under its new name.
Behavior for valid offsets is unchanged.

This lets stmmac use the common helper to strip the Ethernet FCS from
the xdp_buff it accumulates for a multi-descriptor frame.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h |  3 ++
 net/core/filter.c | 83 +++-----------------------------------------------
 net/core/xdp.c    | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 79 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 3a25307e1d67..1ec49f7a9d7a 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -403,6 +403,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset);
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail);
 
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
diff --git a/net/core/filter.c b/net/core/filter.c
index 9b8d5191c4ba..5ea45dfce7a2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-					       bool tail, bool release)
-{
-	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
-					  xsk_buff_get_head(xdp);
-
-	if (release) {
-		xsk_buff_del_frag(zc_frag);
-	} else {
-		if (tail)
-			zc_frag->data_end -= shrink;
-		else
-			zc_frag->data += shrink;
-	}
-
-	return zc_frag;
-}
-
-static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink, bool tail)
-{
-	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
-	bool release = skb_frag_size(frag) == shrink;
-	netmem_ref netmem = skb_frag_netmem(frag);
-	struct xdp_buff *zc_frag = NULL;
-
-	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		netmem = 0;
-		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
-	}
-
-	if (release) {
-		__xdp_return(netmem, mem_type, false, zc_frag);
-	} else {
-		if (!tail)
-			skb_frag_off_add(frag, shrink);
-		skb_frag_size_sub(frag, shrink);
-	}
-
-	return release;
-}
-
-static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i, n_frags_free = 0, len_free = 0;
-
-	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
-		return -EINVAL;
-
-	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
-		skb_frag_t *frag = &sinfo->frags[i];
-		int shrink = min_t(int, offset, skb_frag_size(frag));
-
-		len_free += shrink;
-		offset -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
-			n_frags_free++;
-	}
-	sinfo->nr_frags -= n_frags_free;
-	sinfo->xdp_frags_size -= len_free;
-
-	if (unlikely(!sinfo->nr_frags)) {
-		xdp_buff_clear_frags_flag(xdp);
-		xdp_buff_clear_frag_pfmemalloc(xdp);
-		xdp->data_end -= offset;
-	}
-
-	return 0;
-}
-
 BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 {
 	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
 	void *data_end = xdp->data_end + offset;
 
-	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
-		if (offset < 0)
-			return bpf_xdp_frags_shrink_tail(xdp, -offset);
+	if (offset < 0)
+		return xdp_buff_shrink_tail(xdp, -offset);
 
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
 		return bpf_xdp_frags_increase_tail(xdp, offset);
-	}
 
 	/* Notice that xdp_data_hard_end have reserved some tailroom */
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
 
-	if (unlikely(data_end < xdp->data + ETH_HLEN))
-		return -EINVAL;
-
 	/* Clear memory area on grow, can contain uninit kernel memory */
 	if (offset > 0)
 		memset(xdp->data_end, 0, offset);
@@ -12839,7 +12764,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 		xdp->data_end += shrink;
 		sinfo->xdp_frags_size -= shrink;
 		delta -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+		if (xdp_buff_shrink_data(xdp, frag, shrink, false))
 			n_frags_free++;
 	}
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 470bf90d93ef..7c98dbc2a770 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
 
+static struct xdp_buff *xdp_buff_shrink_data_zc(struct xdp_buff *xdp,
+						int shrink, bool tail,
+						bool release)
+{
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
+
+	if (release) {
+		xsk_buff_del_frag(zc_frag);
+	} else {
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
+	}
+
+	return zc_frag;
+}
+
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail)
+{
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
+	bool release = skb_frag_size(frag) == shrink;
+	netmem_ref netmem = skb_frag_netmem(frag);
+	struct xdp_buff *zc_frag = NULL;
+
+	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
+		netmem = 0;
+		zc_frag = xdp_buff_shrink_data_zc(xdp, shrink, tail, release);
+	}
+
+	if (release) {
+		__xdp_return(netmem, mem_type, false, zc_frag);
+	} else {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
+	return release;
+}
+
+static int xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, n_frags_free = 0, len_free = 0;
+
+	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int shrink = min_t(int, offset, skb_frag_size(frag));
+
+		len_free += shrink;
+		offset -= shrink;
+		if (xdp_buff_shrink_data(xdp, frag, shrink, true))
+			n_frags_free++;
+	}
+	sinfo->nr_frags -= n_frags_free;
+	sinfo->xdp_frags_size -= len_free;
+
+	if (unlikely(!sinfo->nr_frags)) {
+		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
+		xdp->data_end -= offset;
+	}
+
+	return 0;
+}
+
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	void *data_end = xdp->data_end - offset;
+
+	if (unlikely(offset < 0))
+		return -EINVAL;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
+		return xdp_frags_shrink_tail(xdp, offset);
+
+	if (unlikely(data_end < xdp->data + ETH_HLEN))
+		return -EINVAL;
+
+	xdp->data_end = data_end;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xdp_buff_shrink_tail);
+
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to

-- 
2.56.0

