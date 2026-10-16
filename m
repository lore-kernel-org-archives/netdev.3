Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DC44AB68
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141122; cv=none; b=fLbc1QeAhGs/VlFZZeNCmV4tJsME4+EHfqePngMlMtTkMrxTUWAFt74ONQNg6xiPbXBCTEe3wbaMjl6gk9IJZsNd1ckz4msVMqwWodD7/Et8i8QdG83VidjlYtWcizdbx9emIJGnYSzz6BxYonetlUcs83UgG5UjiP6cIU8t8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141122; c=relaxed/simple;
	bh=gdjPnOQrLSM5BuhfTWXU350XcrToK/vEq1DOpk2BN7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtiPbp2dvMQaUTEozfsJiHoU6OhlhYjKyf1je6axS9yhvJHS98RU5fqcRrKnaZuNEDsFGSBXltaGEwkgKPFvp5X6xu1OT87jGAt+BKi7ANIbVTsw+nNKTpYmcsMOLOR9fNc4wmDIZxsDTnIZbQsEq2UofBu41AjJgMjjeDDm1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dU4a78Lm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pb2NhC32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dU4a78Lm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pb2NhC32"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lIuf1797671
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	diZI0o+V3nuL6+l8kxgqaxJ04TAbeJ/sJ6LSIDp2hJQ=; b=dU4a78LmBGbUPN1o
	LtncCJ7NCJGLOKarUsGDTnLULo3/SFSvaejA6QDPCa5gv8O6sONoX/DIwiMgIAgT
	W4HDEIxFtkfIa7X0um6uFF7R/BBOzGDNXW99Xv5ZUIwOtSW7//ggNwoEcw6Wv02M
	Gpw7m/t1HmLivL7anva9svEqEDf2L5omYK9jO6K0Du53HDWH4ocf7cK7qRob26OR
	G/ZjAKrAObVY+T3/AuiEHIykO42TKsBPhLCweHp6wC6GrrRLtieUNtQhZR4ERrAs
	FIvdtg9hkZKj20LjW2g8AQNgpEEW0L4qgh6l4ZNF4+ceK5fl4mKCQSadlr58USEj
	d5lT5Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a89tr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so8188434eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792141119; x=1792745919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diZI0o+V3nuL6+l8kxgqaxJ04TAbeJ/sJ6LSIDp2hJQ=;
        b=Pb2NhC32ruTwt0D/PWgm1MVoYWeJHqPQKsHGWs7PDL9Epajbp3Kp/rgHx2gZvxZjTF
         idbogUw/gmgo9jOzAYRxFoNxPn9fyEduBH08DzknMfxxm8g3w3JsK0rItc9meRQgKjWv
         Nw5NJMGbn4vsUnWmORxHGIsrsMLyfeytxQw9pWHni+1tbRdXU6gtuiu5WhaQsd13p2Ss
         ooCm+1JNx6DHXxc7ME1qj9E83Ik2cligGL4kd881ugrfhelBacLSp25XKarpitaMc2QH
         /poYbx/bRVXFdX0rV+V9K1eCcfqm35/pej1Fos2Z7n0VJcRifEhznsu4ej0714ypkdRr
         3Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141119; x=1792745919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diZI0o+V3nuL6+l8kxgqaxJ04TAbeJ/sJ6LSIDp2hJQ=;
        b=cdjQssONY7rzHSngX66BJMH8S2aBCk3nCYm4hwBpD5IGH6DJgUTYjDfFtW24jdS9Gf
         BwokidPr21LsgaqpPcJETtjlXQsn6hJ5UFAhQyykBKeeQJM5GAStAJWsSVu1zsRPrxig
         bNn4vIK6COamynJHLgkl4tCA2L7sXBsmtM0PEBI3oPjoWLXgSOFuMdXqp6Jm2na4OAQV
         E0gKpkwjoLJkl9ap+6eh0fnuKvtYh4c3vb4LJIQyWH8R+WZpQMs/dOiozYthsWDegnuu
         PzG95ZlE/VHLoL8gNSYK4cyChAwe2NlcjiwZKSZ1cKZlmzmMksT25uvOFb+waD2QLMz0
         jkvg==
X-Forwarded-Encrypted: i=1; AKwUvBw7LoqCDbWktJSP6+dV3NEPtzIIk33sCeB0+Sd652S6nXabAGb+OsQtFNWhdaKDQXhHecgYi0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsGc3CZ/KGCIjApen7B19X3ARbSibpcnnZVdwr/RcXKZOqQd8i
	rgho0RxbbrJGF+5BlDwJqWlP1WDr5iL+q54jQMdHChlqLXolChZgMV9+AsSOMDiG5Z5bb3DM/zi
	nBTVHGQ4p6oDlW4TKIcHVi2haPyERLp5K/3SySWRbsU0asAsS6zf4iF+cWGM=
X-Gm-Gg: AYBFou2TOAr8OQL4aQfUPZHKRSmKlcF4okBmrKsb3z+DPDCz2Ve9b41a4HOQnYozGYG
	4ZUHLztHDat1ftVb6AwxnuvDUZkzXm1xQR3vEh6WprdF2CkSSnCHKWeCAxN5OyOWvVZrdCuu0MH
	QbP17CEKgPuoWAg2qIViZyXqFoH+jNOgMLPolJXChUJId53DCyXBjAG+PyyG1uGSKiAkpr0wEbI
	Mu/BmniU8RivqXX3FhQg88xNlOX3kpRoRxFOs6zSuwWoIGseJoMzK5XQ17+s0KEOWYrdc3g5N/m
	RbgSG7obiom7zn5OIYy3QdpaCqV/Sj5Qk+HM29+ltgnepGAjdZAbolBiMdur7/g/r3OXYDDPKSS
	I4OZUKirIx0a+mF37bw5dAyB6y/Bm4Qi8i4uHwPlFNzpK13fAKlBNk30=
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr13854003eec.3.1792141119416;
        Fri, 16 Oct 2026 01:58:39 -0700 (PDT)
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr13853970eec.3.1792141118870;
        Fri, 16 Oct 2026 01:58:38 -0700 (PDT)
Received: from hu-chunkaid-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9475436eec.24.2026.10.16.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:58:38 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 01:58:18 -0700
Subject: [PATCH net-next 1/3] net: qrtr: do not take the sock lock on
 blocking recv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qrtr-add-shutdown-v1-1-e1cc01ca5919@oss.qualcomm.com>
References: <20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919@oss.qualcomm.com>
In-Reply-To: <20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chunkai Deng <chunkai.deng@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tao.zhang1@oss.qualcomm.com,
        peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141117; l=1467;
 i=chunkai.deng@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=gdjPnOQrLSM5BuhfTWXU350XcrToK/vEq1DOpk2BN7U=;
 b=qz+Edq/z5T4C2brJNUdgaVHrcSfqDlWe0eu9Ie9ggtGNVvGh3Mg0QavMvXkIRBK8g7ZeiJQ7c
 kFbAnm7MnB9C166sRYrA5JMtc0Ho2OmV/gLORKGCJjeczGNIw0teJPs
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=wWxCpsJRKQeVRzpZ8GLRnUX6ozLMowqE3hiz/j+j9O8=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfX5GsblD8j1UWd
 FGqLmHKxWCad44S/M57yIpFNy0jLLB+upygiZwaXdHPpej+HHblhlr8ASoaz7ssuXnxQ9nIXaTT
 cfnyIvmGXBjgykH4PVmClfeh4hcpV4A=
X-Proofpoint-ORIG-GUID: FYPuH1UjsnKgsz9dowV5LGGk9-J0Q_ak
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad1e740 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=k-Ub7f4L2iafiF0gtMUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfXyFQ/l8qobxZT
 /lqe2A/DMP6tb73iJYn6Dj7JAloyKdjzfMnP56VftwAoKt1oVrtWLXFCHMqY6qwkc6Dr4sqJYqB
 98KggezxlM0Ls4z0Vlgu63TEUQeS9Rv3Hj38Kbq+tjeeodp8JqwizS0+q0VV5JOpCSy6KCob8qA
 8U53cmPMReynG1SLmdJRkJ1Bd+sj0qxGGo+1pymq78Zw4LPWBA9GELgHIA+lV1VLkJ2BlL8c+5d
 WloBEp3URV28BwavAHP4ORMQsjy9QVauQpMEXjD/WzpPAmtO50ZjrWR3gucUc6ng2TDdhkw9UKg
 kl33hFnp0scJCrzAnqOuFhYTaMgNHN7LdhnQQWvakuZQaVm2lW8svnR3b3Tsnfl2HcljnNwOpMB
 GODh8V3kRgjxD3eViUT8tkSz+lUnFmV/vcWK1Lv8xtYXtppLV89WolN5JOJJnzBVwseJ4dn41mX
 8XnxaINfoLPErALmIGA==
X-Proofpoint-GUID: FYPuH1UjsnKgsz9dowV5LGGk9-J0Q_ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160035

qrtr_recvmsg() takes lock_sock() before skb_recv_datagram() and keeps it
while waiting for a datagram. Any other call on the same socket, such as
sendmsg(), bind() or ioctl(), blocks until a packet arrives.

Take the lock only once a datagram has been dequeued. The receive queue
has its own lock and the enqueue path never takes the socket lock. The
lock is still needed around the copy and skb_free_datagram(), since
TIOCINQ peeks the queue under lock_sock() only.

Testing SOCK_ZAPPED without the lock means a recv() racing with bind()
may return -EADDRNOTAVAIL for a port that was just published. There is
no ordering between the two calls anyway.

Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
 net/qrtr/af_qrtr.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d02ef9a74c3ca..2d7339338e460 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1034,18 +1034,14 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct qrtr_cb *cb;
 	int copied, rc;
 
-	lock_sock(sk);
-
-	if (sock_flag(sk, SOCK_ZAPPED)) {
-		release_sock(sk);
+	if (sock_flag(sk, SOCK_ZAPPED))
 		return -EADDRNOTAVAIL;
-	}
 
 	skb = skb_recv_datagram(sk, flags, &rc);
-	if (!skb) {
-		release_sock(sk);
+	if (!skb)
 		return rc;
-	}
+
+	lock_sock(sk);
 	cb = (struct qrtr_cb *)skb->cb;
 
 	copied = skb->len;

-- 
2.43.0

