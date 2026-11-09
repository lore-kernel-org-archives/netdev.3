Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268668;
	b=4d5ZB/y0CqIOlIerGcZKRCZCFmDXmlvV0qAZBIeM+YM/2NclbfE97KxTFt4TQyAsOZ26
	 lVZhLeNK7XGHaiJTuBotT+PsythrlGy35h8+6ZD3cURB5AojkO3Bt0MnUSZZOS+UE8EiU
	 jT5UMR0R0FYXErYox9u1XaQMYPvfIMmNMe+ZuEEBRRNidhe94IK/mPnZvhfLXMGd1NbKL
	 ybG5sPnljgVEmeqPVFqgIPhumNBEFiwGSMbTho5YJSfhDN86GVsmhuZrdqPpYFBm53IUT
	 P3siJmZdWEWkUhxpjGQ/4FPny7eOhHARpLA5DYTJzKsre3vCk4NwJZ6HBw5hCRxJOLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268668;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info;
	bh=cimnvGigDWEyOo+61uT7xFkJt8u24jnLPRGaORm103U=;
	b=fmoHBZP90nvrH8+7vuZ3/CBvb+X/SmmC465rvlllKX6kAUSx3nGIRlYE+P5itRy84tTI
	 KSw3BjkUmYNPq9OJwZfVd8IxrMWxYQt8OIjuP+H7RtF5b3cwgU3sJNZUR/j1ALl4W5yrn
	 VlkWFiIYgdwD1CYHi3Gz57KPVnWY7DdXO40+9lfq1pHdsoU0crE6yv7QKx+eiplzzRLik
	 E81TZSVQLgaHRC0rOKdVZ78jxh9alA7J6eUUweuk4YCI94/d3mNXHRthXaf+eQyp4jdpq
	 xT0jSpXNo91GF5zTOcIlgK3pkOZTH4hgy9khYzrJI9wDPaXTbNzOL6OhtI0VrzsuW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Z7bcA6TO;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C860A2618
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9C860A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Z7bcA6TO
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EGpuX1202634;
	Mon, 9 Nov 2026 23:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=cimnvGigDWEyOo+61uT7xFkJt8u24
	jnLPRGaORm103U=; b=Z7bcA6TOSBJGc42W/FIM9Mmnk2hrsDWAhG/8IAOjSPRRZ
	z4atMqoradQBzeJaqli9XCEkMoHv6+J/T4MBGMudZUC3crY/zEWk88v2uFvbEEve
	jgNu4K1fw+uSd3Kyk+cl+dJo/Vzco/ttYgFIR9NeeZhpVOFdSUcD3TVLjttqQntG
	54+jsTcfGRw+lPhC+/lB07wxGMx8DXc4vU1xncbZarg7PMELrtKRSegNSte2nPbd
	z4aMH35MtCQub0C4wUsL/oXPYq41Gvj1mbEYCwdv+Etcr3DL4FtxfwtXPBWd0Ox0
	iX8m9qlCPG9oa3t3Tgo2/7dSQbPPWZcaEpPtodQOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsv1bba65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 09 Nov 2026 23:57:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9L8HcH1051726;
	Mon, 9 Nov 2026 23:57:31 GMT
Received: from fajita-build.osdevelopmeniad.oraclevcn.com (fajita-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hun8b57qd-1;
	Mon, 09 Nov 2026 23:57:31 +0000 (GMT)
From: Mark Nicholson <mark.j.nicholson@oracle.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de
Subject: [PATCH] myri10ge: correct uninitialized variable use
Date: Mon,  9 Nov 2026 15:57:30 -0800
Message-ID: <20261109235730.2519016-1-mark.j.nicholson@oracle.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090095
X-Proofpoint-GUID: jXAG5dkqMM0ugfsZ2S5LcSBBTXSkaCYh
X-Authority-Analysis: v=2.4 cv=Y8NtIReN c=1 sm=1 tr=0 ts=6af25deb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=CV3ta1bklrtZyIU92IoA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NSBTYWx0ZWRfX6kAF/ddtozGH
 D/EVbmeEFjRtjq6xVTwqGNY5bnaCTdYagTvbgTfQ6dd6enrlNj/lUgP/jZs8k7atdFmxEeYWYLB
 sZnYcMuHmIDiNmNMiFZL8h0tmauMGGH+X5UjH0B8MwLhmmdm94h1eDQ1WkB450GmKhCtZH3FZzM
 JeRwMITmwQfZ4HoVE06X444HRAzLN8ZJUf7me2gy6gOY7WVlUZ0LfRXRbMShiuumFAsANC4eY8r
 pJ5eqShvF/b10AaDd3mrcsXvH5PhnTl6EKLb2xxy8A+yRTSp4nJIk8PqNj+iIEdlsR1NdPs5thu
 WUm6BbrZP6z85EIde7ZPfPwCk1YKgrwr9+2ArT5JCWEuhNomYsISpjmk/aN7aY+j1U6TfhrZYZJ
 w9t+8TLNgDBbOIRzFsBFCjH6YV9UEnLrZtOu024/lEgJnSTEPiVxZPxbpUMwFKYxhq5Q+9CsQl6
 qRNthfAMfAJ5UM+exZky6DyQNNxRdzwUWAjB24uY=
X-Proofpoint-ORIG-GUID: jXAG5dkqMM0ugfsZ2S5LcSBBTXSkaCYh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NSBTYWx0ZWRfXyYNAxmh75cvj
 gIXWMDCnqi+oREA730I0FOlETsnGejDEULtCHwHoUmCuO3PnHu9/c2EunySSFPi1hkI+jO9G3Bc
 4a5xuYKdnciVb3f6PngNcc4XKPyBX68WkHcHqw/f8JWSAQAGQVxT

Compiling using GCC 16.2.1, for aarch64, I see this error:

In function '__const_memcpy_toio_aligned64',
    inlined from '__iowrite64_copy' at arch/arm64/include/asm/io.h:260:3,
    inlined from 'myri10ge_dummy_rdma' at drivers/net/ethernet/myricom/myri10ge/myri10ge.c:535:2:
arch/arm64/include/asm/io.h:217:17: error: '*(const u64 *)(&buf[6])' is used uninitialized [-Werror=uninitialized]
  217 |                 asm volatile("str %x0, [%8, #8 * 0]\n"
      |                 ^~~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_dummy_rdma':
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:511:16: note: '*(const u64 *)(&buf[6])' was declared here
  511 |         __be32 buf[16] __attribute__ ((__aligned__(8)));
      |                ^~~

The correction seems to be straight-forward to silence/correct the issue. The
additional change to the simplified `__aligned(8)` macro is suggested by
`checkpatch`.

Fixes: f8fd57c11159d ("myri10ge: properly align scratch buffers")
Signed-off-by: Mark Nicholson <mark.j.nicholson@oracle.com>
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index e5e51d021b2c..377f92150ae6 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -508,7 +508,7 @@ static int myri10ge_read_mac_addr(struct myri10ge_priv *mgp)
 static void myri10ge_dummy_rdma(struct myri10ge_priv *mgp, int enable)
 {
 	char __iomem *submit;
-	__be32 buf[16] __attribute__ ((__aligned__(8)));
+	__be32 buf[16] __aligned(8) = { 0 };
 	u32 dma_low, dma_high;
 	int i;
 
@@ -713,7 +713,7 @@ static int myri10ge_get_firmware_capabilities(struct myri10ge_priv *mgp)
 static int myri10ge_load_firmware(struct myri10ge_priv *mgp, int adopt)
 {
 	char __iomem *submit;
-	__be32 buf[16] __attribute__ ((__aligned__(8)));
+	__be32 buf[16] __aligned(8) = { 0 };
 	u32 dma_low, dma_high, size;
 	int status, i;
 
-- 
2.52.0

