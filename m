Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040B4B4056
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823486; cv=none; b=vAZEMWA1zKCLo5utZdI6CLh+BQe9jcf/nhTU/aUg74geS2C0juw7l/0c7tCGocLCBQgJHAbXJgGfbrEf430eiBTNmvO81crWjYNYwBJXNR0QTKwiGFtc6f3U21+ykkng7ZXT2A/YI1PAVdH6iwkAqMs7XGS0rGk+bCdQxr7mez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823486; c=relaxed/simple;
	bh=PNzCV9hPwNjNkKsDZsW+5abejAnYdpudy6D3Gu4mjoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9wrDQt8bJ2pFGEBFwi/VX8L/uveWc+4o3gl2CPWK/Ktrz2oI9hhh7YrzbOJQLidtWSNC8ts/llnCwcqDldSei/fzNnKf8G7omq2/s19idUR/WvnTy5/5GjBDuaaCcmHg5DxQu8Xme9g00R8ZMpjxiLK6D9JZKdOdJ03wgOkc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ApX9a17M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M9zzU0RA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApX9a17M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9zzU0RA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFei4j3782523
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=; b=ApX9a17MgDArd3zz
	IEIomvFkQPdFNEZXNs0jrcGizyMFUeVYF5lLWptmDLl/KpgiQOSxKV7kL/4U1TYy
	AmW1tc/2b0Wi/uciNkWXg9kAfBjMGrGiBjAI2xAd8eeaeEeeUOiYvhx8ovtORrXD
	Jho97VAk7gsoSqIDdOSEcqr/jOkCGozpykNCLSOsW/OB5qV2JdU5gxeL1ctrt9w6
	fCQa28y+eWoRtycqglvvfeaSXs545imSmPbpeQmrEaqCK9KEAETaoxNbzSYt/G1F
	nbIouPblNllnfcbOvdapMheFfjc/zuIxAo3U5YsNHzsqTbEEN7RBZbzcbyBzGVE7
	KRDq+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3jdre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so598547885a.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791823483; x=1792428283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=;
        b=M9zzU0RAFJETF1FoBMNP3aj6wxhyVCFQPMFVGIz1SrryrC94oqXUT21/330jtC2vGT
         VDEqiDEUUpbi6klSk6ZnTjfGs3vgIrhqvfT4lygs3EqIUX7ZJFn/3hqJp0+QeQoig6ui
         g/GI7Nh787rJ43lwmO6UxmOuEH9ZEpv2D/LrnE0JjltjR5CZvl2iNfBn0aDwmfXsO3as
         GIpJ2zD1s8RRAflTbsBfFOPalZvBvpRiZVHx5/oS13OJSxg1oIu8TBDvp3dXhghyaHHQ
         rfdKy+kyej6ESdGKBncyDTjpsaiHKWnekJJqX1APO/8VmGpBQf1MQKli4ttcZkgmfUr8
         NqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823483; x=1792428283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=;
        b=hwVGcO2+CLLO4ZXeVdHTl2ivMxEBTUyAVnBAwaB9M/o6nVYhV13ZJXTUjuBORepkGQ
         uYv0ECwjgowsVUcsk/9ytM7/75hniqECCZlEATs8nadDWrJsGpVlz2nXnpBxO1Fj0H+3
         HStgkQRNsRNF5AYc9faBd4KXAo9gkREVS5NPRB6pwSbqocBPpFCnpzVjnl2JTjYtNneo
         2N5mMaBRruRVU/L+/TMIx/ExQgCYmlC6HwRHwogvoOF6L2fTV5lfzpSGJgzcUajllO/+
         muh1gX90WCESDgUHz9CIJoZYjND7ChStupNUgAfuYQgNuUfGHnAzNIULVlPTBoGSK9RU
         s1oQ==
X-Gm-Message-State: AFq9FYJewRsFS02HnuLKRIoJiV+LsOpfwyQRbT7FJB2Z2tJiARvx/hjH
	o98YfkYZB97ykdpl0nJth5YEe0rvw4PdBTfnGZyynE80D+rKSpBJM3HJZkpIr0JRLxjfZId5YBX
	03seUgiwQzcxDYb879WHVKB19VMmBV6nYXS1THzCu7y+RDHdNgxo1PyeNWq3VuE2zLWsc7Q==
X-Gm-Gg: AYBFou1gnk5LjYbd1yP5Fd94RNoJqBmafNE6ewwH2Hh+BmYtyHs200UiIqX1k89UCip
	5pcAPFx97I4ozxOp0oPFkhwhZr4ArhjHe2eZYeC8qrO7CjBpY6HsWQuh7ddt/QiWArQa77yln60
	mCXGrWogR1NMwSqFAsIv93wuEqEwls6XzH8VTZLYq/rtAgAxSYaC75irapX4s6V+06SYYuLrPN4
	I1vyO77w42Kc4h4mWto0Od9kVwqu0kD6QTkfWsvGPWsTqa4OhTfCjojEba6TrHotqr6otj5XRTU
	JOOIrvoz7sO4pFF7tqDc4/rQvc7ZXqIafkyb/z2lYG+VdbKxeyQ1RBspeiGQfh158EWx6kkbTh+
	Rclx6SXEiAesmiQ==
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id af79cd13be357-93ec12d0818mr1145454085a.79.1791823482757;
        Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id af79cd13be357-93ec12d0818mr1145449385a.79.1791823482159;
        Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa21sm424502f8f.9.2026.10.12.09.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:44:41 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:44:24 +0200
Subject: [PATCH net-next v6 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX7j6SMOSJQX3L
 06XPXngi0Hg9t8nkovK0VsYUI39J1j5apftLOAGHRQ7fodpx3Oru8BKuvcz8iQ072BXc4wo2rw1
 duJqqVeYHHLYCCji7vS8InvpsTDG5iRRAJL6efEgYndgt1haV4bes4mTbISl7tb+lqNPtr65II2
 THzSvlA+h9KiYHewlNWnzkp4m15uJc7v/C7pyAr4RzdgSEkjOlWEQYwxKQbsNB+iPwyL1CFALXI
 +I4+mYblHwBNWRhTE2KrSq5mcrFDBA+ta1vMHnkr2WB+RoOJYymTVn+G6qXm1wPTlbBYvVN7JLA
 lqd8DyBQZHdhTCrZrqZbvpw51kFLCO3c2lbGIkGQaBAA644navxIYKg4MBCB2dgp3qIBag+Sool
 9xPlw5FVAoNQSvEwP8UO4mQAC84XKBQ1nzKVxeNHUeGMOrscByxQQHrEMtuxWpOrpCgS6lEK6rV
 Mcbc0FfkgsPBPB5CxyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXxrMpdsuLdR2O
 OhRYx0muhH1B0+73VLiXL2rjyNitkY4+FtywTiJSwt9X1A6p5MnaBxZH2EaiImQLnmztAln9Okb
 9Mgw0m/ksSd1rMDXvkF7Kr6iQPh90c0=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd0e7b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=lO1k50BjLTqofN_Ss1gA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: CMG0CLdkfy_LsPzrvlhqhqPV54X9yb3a
X-Proofpoint-GUID: CMG0CLdkfy_LsPzrvlhqhqPV54X9yb3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120066

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                rx_dropped++;
                error = 1;
                dirty++;
                goto read_again;
        }

The non-last descriptors are freed and dropped, but the frame is not
marked as errored. When the poll reaches the last descriptor of the
same frame, error is still 0, so the fragment is handled as a complete
frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
or converted for XDP_TX. The tail starts in the middle of the original
payload at a predictable offset and, parsed as a fresh frame (len == 0),
stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
though the DMA engine only wrote the tail remainder into that buffer, so
the reads extend past the received bytes and can reach beyond the end of
the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
when the interface MTU is left at 1500.

Set error when the 1:1 mapping check drops a descriptor, so the
remaining descriptors of the frame - including the last one - are
drained and released with xsk_buff_free() instead of being processed as
a new frame. Account every freed buffer with dirty and count the
dropped frame once in the poll budget / rx_pkt_n, and once in
rx_dropped.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f66b796f7725..426bb68c9bbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5701,18 +5701,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(status == discard_frame) && !error) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
+			xsk_buff_free(buf->xdp);
+			buf->xdp = NULL;
+			dirty++;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
 			count++;
 			continue;
 		}
@@ -5721,8 +5724,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 

-- 
2.56.0

