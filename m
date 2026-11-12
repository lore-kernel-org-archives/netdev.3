Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501291;
	b=gLcQ8T4Rb2+eA3uFJtzuXzcKQntYD4oaAa+/J7fLWUrIVdmFxCU07NV4Mfpqd5mpSZAU
	 hZTOV8xu41eU48QoNghpGkJ/aChTEibjxh/a/68tk7leKu/uWpYGuloJfDk/T+YggFM5K
	 /ajMtpMFghL/uXdtkUteNifcHi3yrIzbiPOMPM5dPQlJ08ZQi/spzkncQ/5aZXqQ9PiV/
	 gGZUG7YqFfF1WwZHEvCi+XTgQZ5b3zqKn0G73uA+JKbMznUFIAzZhUtxLgJ/Jt9vCQ/Bi
	 wOnLvQMUvRVeaPwvoYLfce5dSB6lv5EiwMnBAQKiG6AVO+9+bC0ZlRyfH7s5Xi/0ALg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
	b=47QR36yZ9pKcQAgTET+acSAVGAV+jsrfg97sMiFjnkllm63fl5fRK4PE38F7Q6MBxnCl
	 vXOzvCFn/qyNnE6M8bfqhi0cMK7ProSYvaWK4dU7MlsTSu9QqsnsX8WdLJziXtT8Aa+iA
	 lwgKmg+d9ssXUr/ZrLzB6OlKb4fNdt1UF34TwrGMqgiTlpuWuPU9fp7V8VRhPQ++bVPGn
	 vrYMjKnPIsc89omltHnVQrrUrGt2CbzM1au51XYUQt1kL7wEHZLQyE0N+WySvQFs+J9bQ
	 AkpUd1/K1HvaZqHHXRMKVYVhvH5AE0MbiADo6jPIEHIphrpip/6g9SQUoB91qs3ZTJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bBa2kNd7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3Cpm4mz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4E606A8B9
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F4E606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bBa2kNd7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3Cpm4mz
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZYe71159695
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=; b=bBa2kNd729GySv3f
	ujDeXzgP9zdEdp9CTYtaUN0QvEV5xnCkbv4J+oRRySrzSOk2TvH3EikCq3IGENgx
	fMZ8vV+qZfn0OJWOX4eQCZOvWya+5H8Vh3yvul1Wy/SK34RZj7FXdW8I0yyrzkY2
	JYDUGPXrny1avnMGLT51P3VlO5hvjXCe6n9FtfErmTAYXlQ5tKObPYkQ22TLK3gR
	KSYzGjhN+iRBS/kzHlyVexi2EDMKzSb5B2ndSXdYd2mR9wMKuW/hz9mOjMrQH9bl
	yaKrs5lUR5AYrhXFy2J93yp/AdH+H5+hwOzmej+ftjKCHvav8ap6alxKT7PXja/W
	KrcOzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a09xh0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-945b0154705so683596685a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501289; x=1795106089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
        b=F3Cpm4mzIeoElVrJuzIs9XsKGbWkqwMFhWPCpy8rxs+luODQE6tzQje9gpuWOy+d7j
         rZslCMNn21vDtTRRzfJAzd8oaYq2NuWMawzL36izu8hpyuwdD+jUDaB+EXVXUTZE9zap
         RoBXkZk4AxOpp535uwo0abZ56FSf4h6GvFAgJevfUZAdh9s/Hzs9at8xNvlp9QbDlOps
         tkgSz8fHFt+Z8quGe4zQ58H87yJNwIr+JXt/+FgiIopNCzj3R2JRy1MvvphZFLvrT5um
         ED5nDTHFhseBhLK/eY3yb1r1ColGsDtZ4ZHN/hMwBQQHKkPNpK/Q4/ctwephYJup4xbx
         j2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501289; x=1795106089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
        b=UKUul0PqUINkvMyU1x0ZUv007rAxyaVrdhcLU/eSXZMv5di7sjM0fn8n8V3KkZR6Jj
         k27qTAs9O5TbBWXMC360/ynzYjftv7t5aNMORE3B4ktJIBCk7W/ZHwZUN2baJq3kTi8Z
         eKy/BBsDc25/hKK7oxK4YoIF7FWN6aYep4obqeHN14j26X/SMRzqvIgqBDvOmQ28WC8b
         FVv4KhD1yEhikMiEFqJeJLW5liYY9gh4H3zYM1MHlXjh8dbgcUAtQY0gX5jmDnrVbyST
         bqBHtHShHzupbEvGCqORvhbW7h7uzJok0P6bis2js2al9vAVVfPU0PGzy1n/LHnfoNHe
         U6mg==
X-Gm-Message-State: APuU4Z821zqm7APXPWtI2qVXf+UY8LvBoPM0eLp8YKLR24beLlU+fSzd
	F5PSOtO7Bo85VKQMI14TcTQdADgDEcFVQUFsfM4eJRv5CeggJetegUzmeaXdi6awrxQV+xgi7LN
	hD5YvOUFIS4AX9Xw4P8MJydWCLQO+YauC/p/pUkk8Vgbza9oh3RYxaMdxhnw=
X-Gm-Gg: AYBFou0SQ5jHuqPp7nKkLvRfUksfoZ7nHHi377Gve4+yCB9Sb/n8rhm0zQjVCj+b6yA
	5rO18AxBzY9TGEIfN/PZ9T7cWn8fUl3sptafoeQz9w2SbfEup/8T1ezsb4pw3s93BD9YKPV8drg
	lNppbUL7XirpCswueUvD2juFztrbFacDnqxX6+ftLKNysA6iyuAc5SeKmFA7xdvMm/71XddSXi5
	Bmkct9gPnYqXP3q6mJSDy0iDWDdBghTxB/ksuLKJZZ1vd/SA78kmaw0mlYdzoW3saoRaY4ZJmBd
	q4UFG0/QkqCugj5wmh07uviC69oIaGOB9SOYuiJNjbNxKzkJQJrtbuew6T2QJlCV+Z9ZomNeykr
	hPpui7H4cJrxHfh7ihmNOonjmQ549Mr7+poy8WISaj6D6hlkJFbmaMfgFhJQflhk=
X-Received: by 2002:a05:620a:808d:b0:939:b099:d52f with SMTP id af79cd13be357-947afff4569mr974885485a.20.1794501288905;
        Thu, 12 Nov 2026 08:34:48 -0800 (PST)
X-Received: by 2002:a05:620a:808d:b0:939:b099:d52f with SMTP id af79cd13be357-947afff4569mr974877585a.20.1794501288257;
        Thu, 12 Nov 2026 08:34:48 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0d7esm197476f8f.12.2026.11.12.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:47 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:12 +0100
Subject: [PATCH net-next v10 3/4] net: xdp: add __xdp_return_buff() helper
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
Message-Id: <20261112-stmmac-rx-mb-v10-3-d3d04b65c6bc@oss.qualcomm.com>
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
X-Proofpoint-GUID: L1gGc2UgDDizgrGmET5299J4065yW7jh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX2X2u9QT1Ikvi
 2wX7sjTBjSPZxksNA3a+TzfMtuawAi5dAi5gEjws9I1aOUIAShmq68x4TYTQ0jlg/c6nLs2p//n
 Kh60j8c/whKTwIQAAQS2G0l2VSDZz8LLWzpTdqeo27BkJe6GUFSquMpUei52KdWvVzD/k7WSBI7
 042PcZW5Rgx1FUHLWV5WJvFFbPIiq+TRzA+oJLlLj1kE2+yjvMNyxxKH+1zoBI7rnnTrXsCVV+7
 FlrI9epN+IoJnv61ntDkJbKE7PrhY6/cTL0/y+CydGXNpnB7lb+MHSs1zpZGk6SaXBS1gSEILXV
 zqBva7J+dzUm+aO3F61Rrbz+OBv4ROblLZwsPEa6eS3zdp1SWusxzkhRmPb2b7IoXubQ7rY1xKX
 32VerYNUA8iNUeEaUK1sxEnRrmgzpFVexReb+8KsjzdJp4n0kKBb264XAIVwPzbBjatrGS5GNIj
 cUlNGO5d8hTfYdSkMYQ==
X-Proofpoint-ORIG-GUID: L1gGc2UgDDizgrGmET5299J4065yW7jh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX5DRQD09C4elz
 pi8cag6u+S9MfUjLRRGCIDoWbAqa9SEHrdeuaIAZWKa14Usu+9ZEuR1G6lAUP9MyKhUpvVwV1YS
 kbuyhxJqbKmFHvABkY1SgXOc40Kb6dg=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5eaa9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=EPvaxb3vtNQ3FCvCQEgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065

xdp_return_buff() always releases the fragments and the head with
napi_direct = true, which is only valid when the caller runs in the NAPI
context that owns the page pool. Drivers also need to release an
xdp_buff while tearing down or resetting a queue, where NAPI is not
running and direct recycling must be disabled.

Split the implementation into __xdp_return_buff(), which takes the
napi_direct argument and is exported for drivers, and keep
xdp_return_buff() as an inline wrapper that passes true, preserving the
behavior of the existing callers.

This lets stmmac use the common helper with napi_direct = false on the
teardown paths.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h | 7 ++++++-
 net/core/xdp.c    | 9 +++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 1ec49f7a9d7a..fc6c350dca31 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -472,7 +472,12 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
-void xdp_return_buff(struct xdp_buff *xdp);
+void __xdp_return_buff(struct xdp_buff *xdp, bool napi_direct);
+static inline void xdp_return_buff(struct xdp_buff *xdp)
+{
+	__xdp_return_buff(xdp, true);
+}
+
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 7c98dbc2a770..bb8e157bf0a7 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -546,7 +546,7 @@ void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_return_frag);
 
-void xdp_return_buff(struct xdp_buff *xdp)
+void __xdp_return_buff(struct xdp_buff *xdp, bool napi_direct)
 {
 	struct skb_shared_info *sinfo;
 
@@ -556,12 +556,13 @@ void xdp_return_buff(struct xdp_buff *xdp)
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	for (u32 i = 0; i < sinfo->nr_frags; i++)
 		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
-			     xdp->rxq->mem.type, true, xdp);
+			     xdp->rxq->mem.type, napi_direct, xdp);
 
 out:
-	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
+	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type,
+		     napi_direct, xdp);
 }
-EXPORT_SYMBOL_GPL(xdp_return_buff);
+EXPORT_SYMBOL_GPL(__xdp_return_buff);
 
 void xdp_attachment_setup(struct xdp_attachment_info *info,
 			  struct netdev_bpf *bpf)

-- 
2.56.0

