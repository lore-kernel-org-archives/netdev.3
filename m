Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833E4611C2
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141127; cv=none; b=T93dA30nfKjswB5knbNi9aYck6TLUxrRBopiCjzU1CEoxb0V5lHjtWRotdJXzz1p9QBME5ZZw0rXuQx1EWptH96RUbSbHJXJUZUHbbg4Mn0IP5yS5mdlRaz8eX2xLn9sXYt4SzBN50oluvJNYR/PA0nI9n+eMM2eQ2nquTjuMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141127; c=relaxed/simple;
	bh=8Cg9W/VqDPpxJP1l4PDNRsec1BC+6QLcbtrneiacO90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XegLaGDRbhIeigufA1QG9Os4G92hrKMi+Z4+JQej5PtdGJ2WpFcfNrd24EzR+x11SgFA7TjwFHoXFaOAYLURaWQyBTXIGn0IW7IuXTVWNv1pVhIPHK+1NgbJIWFtP4Rt0Gm7cxqILdeyPi3xLCmp7+/I0RjVH2IIiPNQdCSvR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prY0fydv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e30m/48H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prY0fydv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e30m/48H"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lWZ52885550
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ziNg9NxoSUN4305GBlBnhwtN4upme4eDf/usG7Qbn1U=; b=prY0fydvJbZLkJGc
	rJpuT3zBzeUK5dPt0w/fJ2B+halnt8x4Rg5I+LDjohaJbJpjxWsZRbE6Q7x33ORj
	IezRx3s6BYwrAWkJCjOOxzT3HpvGjU3x/HsoXdmxocdclg0fnUp7YNiifJjKiMUo
	n5MUodR4/PFWVdZAe9vLU7cy5Q3SGNS+jxD759vQngtZLjovmo0R4L2BPNfyvGE2
	nIhRyIr9n5hu8Ljmx9hG+f7mESuYEOrK/u8y5/r1e0BvMwBIUDvMz5s06XmDrNib
	tZxHfdawYSzOOpej0Z4DqS4oMA87kpciKhCQBVO5JQJjghkJ+p9y8uF3m+5Us7HH
	seEx/g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba261h39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:58:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so8188647eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792141123; x=1792745923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziNg9NxoSUN4305GBlBnhwtN4upme4eDf/usG7Qbn1U=;
        b=e30m/48HonVKoBbfkZPJUHLpmziE/DeNlZtZWO4fNLA43xvbTn1VRYj00JBOTFfvna
         IYKoVgppiqH6XmRRJdz3+eRs6vm51kjfl17Qjh1+u+YGij7M7xM4YPdcIzvU9FGV7HJy
         QYlIoISMSfK6axGOMd1t3LeyCW7UDzkJDWLWSDjdaJ+Xq3YAdHDdX0k0fmoCMhFvU2nU
         FH6ItEbdS+F1z5nGmOtkBUmO1RZR6AtNsNgoQjOLCXofChazEf+8RGrAK1SJgQc2m/yh
         kEyWmbJZDFsHRqc8v6eSxjCNs5xpi4iKOjRc9PJ1h41yhXIWDtq5MgoXibkPNiaZGUSW
         tkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141123; x=1792745923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziNg9NxoSUN4305GBlBnhwtN4upme4eDf/usG7Qbn1U=;
        b=DsqLSZjagJ3+e3je7awt3GKUFF/Fth+W8qpFwr6aMm7atVSPr6/P7go0+VbVZRaMpd
         nb0PWMp+6v5IsBFZ0ybiCgcSf3HKexN8AY8LLMx6BjTVIJFaZGawSCsZka7FCOUjB1vt
         PgyjmzmCV8g41Br3Fz9G0Bu4F2Bi2XDGafUr/XTKRw8gOXGcpqsR/Zx3txJnC1yqiFtp
         xR+C6dB++pq3LuXgwC396JgCvkXVDGSatOiPPMQRNXnR+PKLc/Ivz3LfF8N8BxOw1FmI
         Muvr0XPAyRMeQ7to1IN3iBUlPk7TiFye2ZZs7Zlgyf8WX9ZJZk+jfotAsdUHbMMykfFA
         nr7Q==
X-Forwarded-Encrypted: i=1; AKwUvByd54ZVbBZfkGnduKZrBM8KoCbbdkJxyhm03gpeYRR/EAMz4//ZXVIr7cdEwkIpxcqJvoLdBww=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3WYJWH0SOaa1NgZpL1Q8XzoaPa/Dwe1RUn6tZ6mEzZq0AQF2W
	EN4N+JCObn9RoR7zjPbvBfJxQ7TT7nBqyf++YMD29bpUyCqkU3MDq+4CEJq2/Vw8DxPD9LgPelC
	gPBKznaYBQVPzE96tR/rNpnICHtEdppDq3RYwuHC7P9iqgADespvtDsJ/jjE=
X-Gm-Gg: AYBFou2g/hWYdql/JOuXcLPsSLRwzIqpWJBbfZIcdfTXwagwfpVv2+vGWgVY7D9lyqD
	vkYwe9X3Q1nQuWSbIk3+NCY/dMTlQAEuI8Je8mr0CtIVc0jHSfvgBPBW4jBD3MnN4YO8IT4W1NY
	2SGf1YOrGPAdPFzAJ3Os60jsFk2XXjP9rfRLBek7JIt6b+9g8rbp6Y9uOOQU3SZb9y6LrJkLNma
	xo0kpvNCVbKBBhfI4lxbqcCTU4wyY4bi2xWKr3h1yNU7OZaSD5p2IcDwiUam6jmJEWYOnYaTHx2
	eU9uM/1S1icwfrUQVoE3AT76i9kyIOOmhsfzXwnLNJQjEerlsdcNFh6XlLxC9/ma9DslNJZJzJG
	E921LkI9ujkZF4qW6+bfqeaUnqsCCyDeU0D1OAnDTNwbEZL8aNWeMV0o=
X-Received: by 2002:a05:693c:66d5:10b0:35c:3dd3:9410 with SMTP id 5a478bee46e88-35c3dd39553mr15036372eec.30.1792141122459;
        Fri, 16 Oct 2026 01:58:42 -0700 (PDT)
X-Received: by 2002:a05:693c:66d5:10b0:35c:3dd3:9410 with SMTP id 5a478bee46e88-35c3dd39553mr15036342eec.30.1792141121926;
        Fri, 16 Oct 2026 01:58:41 -0700 (PDT)
Received: from hu-chunkaid-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9475436eec.24.2026.10.16.01.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:58:40 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 01:58:20 -0700
Subject: [PATCH net-next 3/3] net: qrtr: implement shutdown()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141117; l=2830;
 i=chunkai.deng@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=8Cg9W/VqDPpxJP1l4PDNRsec1BC+6QLcbtrneiacO90=;
 b=tsbd1XCAahBbSDVdpBUCqEjrx+aW4kI/713JISZRFcHHRo/jjHZMxn8hzGwdxWEZ751VLnnBF
 Oy7cE4cHsVyANV/8uguh/Fu3GH4cNJkrfdOleeF/TjIgI3RGzjXSny4
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=wWxCpsJRKQeVRzpZ8GLRnUX6ozLMowqE3hiz/j+j9O8=
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad1e743 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=m2P955qNnlo4rMcBazoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfX6mA/N87H51BL
 NqgXVXQ5EzW/CFVu468yRt3MgnC7Y1Rbvcftb7YfXTd7nyt2vXtDEu4OERNG+3XdPUtuoxhg0pP
 CkYWEa2AESbdi4ULt+vK+FCLBo0k0PxX8JPv+gRNcuS8dqfX99T+Rl5f6DJfTGFPXLI8E/oG8TR
 eqCEtTwT4QyBx/vzawv97hFf9vMxweK1uGJBNQeJq4/z+MOxhmbxmUOfAlxyGB43Z7mhvJ9Cl2y
 rAsgS2jPGb93qK2be0QrGDgl4G6NawcOU8JzV/P2P6srJhr6w7iJZGzTSepN5lb/OdTa6TMhJj7
 KtcvUl97edaPkF5m+wf5A50gAikofft4luVSe4OkzSBz5RI0gvulOlqzcyeOsKLUTc4PRIAGrsK
 TZ0ugtQb97Akr1C943Q4hxwTIP1HZA0zbDIIulc3WvdvYHCwpX13KYUZVCjwnLupy8bbY0y3Hcr
 l8GBe4dJg3vFgaAwCkQ==
X-Proofpoint-ORIG-GUID: XXKWuo30U-mxpB4ONpwGv3-gS5Z8ooOl
X-Proofpoint-GUID: XXKWuo30U-mxpB4ONpwGv3-gS5Z8ooOl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNSBTYWx0ZWRfX4WkNeNt51yAz
 aGZYzmG1I/WXV9/YUpBqiw3p1uGOs52pFbny19h5glaUd/sEmcrX+kv/giYKsdbL7G8YNHwmXfX
 s3ZOUgW9N+HO0SCgTB0wg+jp8XS73uQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160035

QRTR uses sock_no_shutdown(), so shutdown() fails with -EOPNOTSUPP and
there is no way to wake up a thread blocked in recv() on the socket.

Implement it the same way as unix_shutdown(): map SHUT_* to the
*_SHUTDOWN bits, set them in sk_shutdown and call sk_state_change().

Do not use lock_sock() here. qrtr_sendmsg() holds it while sleeping in
qrtr_tx_wait() until the remote returns flow control credit, which would
leave shutdown() stuck in an uninterruptible wait. Take sk_lock.slock to
serialize concurrent callers instead, and use WRITE_ONCE() for the
lockless readers. Do the same for the store in qrtr_release().

A sender already sleeping in qrtr_tx_wait() is not woken by SHUT_WR;
later sendmsg() calls fail with -EPIPE.

Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
 net/qrtr/af_qrtr.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 09c1cb443f5c..c955c05e71bd 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  */
 #include <linux/module.h>
+#include <linux/net.h>
 #include <linux/netlink.h>
 #include <linux/qrtr.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
@@ -1193,6 +1194,36 @@ static int qrtr_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return rc;
 }
 
+static int qrtr_shutdown(struct socket *sock, int mode)
+{
+	struct sock *sk;
+
+	if (mode < SHUT_RD || mode > SHUT_RDWR)
+		return -EINVAL;
+
+	/*
+	 * This maps:
+	 * SHUT_RD   (0) -> RCV_SHUTDOWN  (1)
+	 * SHUT_WR   (1) -> SEND_SHUTDOWN (2)
+	 * SHUT_RDWR (2) -> SHUTDOWN_MASK (3)
+	 */
+	mode++;
+
+	sk = sock->sk;
+
+	/*
+	 * Do not use lock_sock() here: sendmsg() holds it while sleeping on
+	 * remote flow control, which would block shutdown() indefinitely.
+	 * The spinlock only serializes concurrent shutdown() callers.
+	 */
+	spin_lock_bh(&sk->sk_lock.slock);
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
+	spin_unlock_bh(&sk->sk_lock.slock);
+	sk->sk_state_change(sk);
+
+	return 0;
+}
+
 static int qrtr_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1204,7 +1235,7 @@ static int qrtr_release(struct socket *sock)
 	lock_sock(sk);
 
 	ipc = qrtr_sk(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
 
@@ -1237,7 +1268,7 @@ static const struct proto_ops qrtr_proto_ops = {
 	.ioctl		= qrtr_ioctl,
 	.gettstamp	= sock_gettstamp,
 	.poll		= datagram_poll,
-	.shutdown	= sock_no_shutdown,
+	.shutdown	= qrtr_shutdown,
 	.release	= qrtr_release,
 	.mmap		= sock_no_mmap,
 };

-- 
2.43.0

