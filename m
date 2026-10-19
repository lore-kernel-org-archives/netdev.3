Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D54E01FE
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408394; cv=none; b=qszvJR+yK/jsX/4ASgNS4XqUulYWOQIaDHR9MMJ4IJZSUJi5pb5V6SHHDo6DfdMKzUq0Tr/ChgmRJImTlllqZSBV3xKEP5BUFXu48advLCPV547XX0YAnJIPGTJ76RVB7d1MRv/IrQfhwvuWSIHmu7/NYWoCBcoIPfs6tuAV+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408394; c=relaxed/simple;
	bh=06IhMOTiJum8Y6ohwifN320Ejt4xYacngIgHBDWIuLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWkjzVJcWUBWkL5R8xhle4l2DxQEHnCWzYd3vOthH4C9wYOMXFMmbfqj+bVfqudbm4c/ci4+46GDC1Fqp5FUBm6yfwmfa5TB8XPDoH66rFfDR7koVwvSwQ+Nd490h0CVlsvxhwqriEBztSpldrGGN5ggczSrBXvaDsyoxKfv7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jnxPWWIH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWsHj49D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnxPWWIH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWsHj49D"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Os5D1665658
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyGQCDxBDck5OVKppEOUmr84isvygZQmpxTsjP6cvvU=; b=jnxPWWIHkmn93ms/
	c5vQ0mEmi0YNCW6F+13cNrRLgc8N6XaVlXNhU/M7fbIs361Wl8IjfdCxss2z1ZHt
	7CEhHNqVgEkBkmld65P3J6TpC3nGyNK6VI1kzRiJv7lVOCx28pvP0+z7KLgCArMk
	99nXf/E6dI1C9E3RA70m8jtWNzej6Jr9sLQS+QMznk46PzfNWt7a29+k6BXmC+TX
	90r8F+8ryvArCXnliikxC3W8MRl2hJv6+FBIq+Bg+du6/vrC+tH180ColJm1tppg
	QCa69NK7P8Hg2TDrjuZkq2OSsS+4HJnM1ySNSVZWKEZr9JkBloZxL4LhI7b3X9Hr
	m1bdIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0s2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93dd3c3badbso477091285a.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792408391; x=1793013191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyGQCDxBDck5OVKppEOUmr84isvygZQmpxTsjP6cvvU=;
        b=dWsHj49D7YlJ80l8mR6Mv18nq4OLzztkTInY3nP0BebZAz+sjkCt6aPE2lse8a4/lf
         kANFwvL/uB+7eLa1wsLu6ziCyTBzn6FOj6x39bZvpilJXKkP9WpUFKhNReCSXmR03x85
         wwPv1VisEeUPukP533sCwo2qeUR5XBazmQRVNs9xGMz9kaFTOkjEA0wST7hJjbah2oSy
         dzX0GYysKB3a2pIxOKYxS+WV8PJXEase6S5matb8V7LT90Onjbzsc1m9MSAQ4IlwjbSI
         CcJPwNCmfOnsq/Ac5VGb7KxbbCLCvDgAI9Q8wmcnrehTSRn55Aqm3nTZ5mdNiWAD2G/e
         aZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408391; x=1793013191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyGQCDxBDck5OVKppEOUmr84isvygZQmpxTsjP6cvvU=;
        b=zie0bw4zW4KNjpejnUMZ+OZMu+ETOoINNYBvPnBze4KQnb+0cOh4eLOkjNbupFP1IZ
         ekbcwwVv7P5qGo+WSdaxVqddbCfdDUNaQ0+DgcliUsdZoypJKYVEuJB/2c1NO8BKbt8l
         YGqTaW9ygUsPYkVnsrtw4vUhCvr8dA6i7f2pLa9z0wZxWnn39y1et+ReBLQEyqekaWT8
         P2MEsoWYv0qE9LRlUnizyr0z5ZAzxM3iYu+VpY5YOchcv4+XK19sSPO6P7B0u0WzGdda
         RhBzYyt0wMnI56eTplKhjsZRaht7drxlUJo1ktbgr1i64YjBXvC9uiyVMk+5YNR87HO4
         VsZA==
X-Forwarded-Encrypted: i=1; AKwUvBxgQddeMrcUF7Z/3GHTjmkbeZeZHNEP6YW+aFtsO64RVwdg3RY9OCb2NJsfsJxabbMj9O5kKVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxDFrESmKLqkduZ+3jwfaX85PHv7npXyic1aJ3abx6XkaGLVMX
	vhHB9N//TBGt57qwIFQ4zElzj4JtfMzPhizuj5Wj5/F2dhtXTaMVHghBPC6xhZR6gvFVYp2jMIR
	/aqq8vtlzspSTph1NpiicVABVWQIgatrV8gMswVRiTDj0Uc3wd5Dh2oHVDJvSsh6kZ5A=
X-Gm-Gg: AYBFou3oxp51tmnlZK2hWe2pwpCBX4o6wOB5InvAfBDChBDdnlUYue81v9syDGO3T1h
	bmQjl3Zg4d31JijwTeUnG+A16RjTbaDZW685p47LOElQV04YUSRsG0IbB8ngWBOCoN647zu5/oP
	1Y4uNgOCa7mtmNY3BaKBxrgVN5evfnWfUXZq1gu8griIvC3iaft3iMWbRgBazwTmYEGF/GrgGlq
	qw3U8I3v6fQuz/E56OBYudR+YEhYdHgNzDwzroG/yai1jCBUk6a/muUdmLxbi+wTnFEDQtDXoFg
	ghdm0DtBMB7U3czT/4HDIXNffQRpQ2pWq074m5lJQuBhbK2uKkhoWG6k+LHqGeeb0IFzN9lSJrq
	K6Z2phamOd2KHiKC53lConDioQ0CgVoFcOC3aPXGT1tl2
X-Received: by 2002:a05:620a:bce:b0:93e:94f2:ada9 with SMTP id af79cd13be357-93f29d7fb88mr1267634285a.58.1792408390771;
        Mon, 19 Oct 2026 04:13:10 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:93e:94f2:ada9 with SMTP id af79cd13be357-93f29d7fb88mr1267628485a.58.1792408390183;
        Mon, 19 Oct 2026 04:13:10 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4256c790adsm211472266b.31.2026.10.19.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:13:09 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:12:01 +0200
Subject: [PATCH 1/2] net: qrtr: ns: keep going when an announcement cannot
 be sent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-1-bd420aec171b@oss.qualcomm.com>
References: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
In-Reply-To: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX8Ln+A2jjCKr2
 1RjSHp9pLuA4fGzx5c1AFa/+LjV8fkr7EKxx5jLSQnlkX+HghAM8rTYSNcKDEvu1eqvxICxcvQk
 QbmgNpt4rrFxkweeHpOrmQIfd6jVY/A=
X-Proofpoint-ORIG-GUID: fg1KG4Z3uSxaNfuatUhnTDy5WGUcSvZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX8EriWr9b3MH1
 5a02b9nJDEdM7uuPkQVaHlDR8l/CXy8V2D/serQa3S6HBab+HeyQk0Sru5fSSRe1EU3hegHBVTj
 xk+idwc+hMV4tqO7X2QxBlIt53zSjV7eir3ol3r7xClId/ot/RuoQC+I2qifeVU5ybGMe5cnllr
 +a6y8rcV6wB0Hiwh+9rMyrdezopZNqvgCRsEWeQS4S7NqgxXRLORpu1SxsVkkvHmW0I3k2kt+M2
 s3QoVwJ1unStK8JQQplXdxyEIZQgZUHRR2+++OdPw16xFX/vrettLZXD2BqLLi/a5w7/738v6rH
 G9bQ7ElkKozy4PzcC5vJ7Os9Qch8ke+KCjM0pNKNlu4V50Rs7u4jH1wHTjeoxS0MRJuH7dPdOxP
 GgQ46HZcD6TVqu09SjbNtOhdonG7qUhE10zS3cOo3KgoeR8EdWa84AhcPAYgtnvyHGXqfncA/NL
 tfUN7z6WpYQWN0YAKtA==
X-Proofpoint-GUID: fg1KG4Z3uSxaNfuatUhnTDy5WGUcSvZe
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5fb48 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8ZcYjYkWD9nQVPmNhLsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190044

announce_servers() answers a HELLO by announcing every local server to
the new node, and stops at the first send error: the node then never
learns about the servers after that one. ctrl_cmd_new_server() returns
before lookup_notify() when the broadcast of a new local server fails,
so lookups already registered for that service, including the ones of
remote nodes, are never told the server exists.

A send failure to one node says nothing about the others. Log it and
carry on in both places.

Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 net/qrtr/ns.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index bcb090ee79d4..dfc2cdad688f 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -232,7 +232,7 @@ static int announce_servers(struct sockaddr_qrtr *sq)
 				continue;
 
 			pr_err("failed to announce new service\n");
-			return ret;
+			/* the remote needs the other servers no less */
 		}
 	}
 	return 0;
@@ -488,10 +488,12 @@ static int ctrl_cmd_new_server(struct sockaddr_qrtr *from,
 
 	if (srv->node == qrtr_ns.local_node) {
 		ret = service_announce_new(&qrtr_ns.bcast_sq, srv);
-		if (ret < 0) {
+		/*
+		 * A failed broadcast must not hide the server from the
+		 * lookups already registered for it.
+		 */
+		if (ret < 0)
 			pr_err("failed to announce new service\n");
-			return ret;
-		}
 	}
 
 	/* Notify any potential lookups about the new server */

-- 
2.53.0

