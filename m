Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108946;
	b=2o7nZM3KjmeGYXvNVQmu/AiyIOmI4TbFjS4XOhhuWzu4wPSDRSLiDglaU3RUuXFuP3n7
	 6m2ZJisPCST0mD+62fPLPEIBuSdT6OJSJhxdYLY9oI1Uci1VOp1/f0Qi1ZmoBVoyNCnVp
	 C0NDbVWArRxTnOdYcoVs9xdDacq20qW8iUdwJQaufnwgdYdfYYGJu8nU7gaQmNB25Ele1
	 pWS85EIotQjsWuCPNwCoxDMMzxe5yeHR2kKLQDzmPtujBkKYjYXq7cV4MWvtzeEax4U5n
	 9tthqaj3QhyvgDK3k8rF57k5kAONxm5bSyKAjLswDza++j5+b3EShPOOq3dMiU/pe5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
	b=RuWSJikkTlnno3H6x3Ed37WySpxblRKtoAOTVma9QClq1FS1/Q2D5B8FCWBzYYONh/WV
	 2EtOk0SoGFgPDPgU2acWxkQ7092AHBbA5Massr0dXwl/r4jjXGDJ+T+cVrv5CNajHP0sn
	 WqFgTTvcL514ityTW4MeOMZgCJoULpiWKWq+PjiZ/P7md161rRvC6As8mSkDUiXfCpQhH
	 isrCpP5X9vRlPX8VMMaRQP4kejJSlOfKGEaZ9Kf/UgRvTXwaya7HfxSSFrK3Byf5Wi9E8
	 D2DuTB8oIXRdr5K91t3WI5lDmk4yh5JSVQeURG3f11ClbrMXrzZGtxfKt+Lk7fb9msA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJtwWxEG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GDaP/36T";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B332606A33B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B332606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJtwWxEG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GDaP/36T
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe54O1922139
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=; b=GJtwWxEG9BWyuIF0
	OZmt83Pz8xiqShipwY/KqIKoUpMQ6HoP5r4/KEsv2rB8R/sUi0OUewC9yz/15ZJn
	JJTZgXolj9EWoGV5YaigdFNXeZeLAtrwZRTujVL8DJ/PDYTE8FCI024Mg0gn4skW
	XbYZEe5yMCqEKgU8ocUSTRlzzDI2veGGk/UJ5hdAVBnDTFdXR2R+grKa5GiN3Eyj
	sTVQXAXiL60KmQMl15YzrzTTqHVryVXUZjMHO4iUp1IX651O3TnjKpWAmqkzHslz
	RIMeQpP4ul6PYFhf8GcTZ8jFq8CsyS5u65piLhA0bLOcL+U4cq9Am5rNeGcMW2T1
	qfTaQA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq695j0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so1154159285a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108943; x=1793713743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
        b=GDaP/36TCWjLNuC6WZLLxtLBps1jWxe+7ErRnxmKnXtuU0xjSWH+pCnqsLbz4UHPRO
         mGFzf0IXRNHF7Xvl0g7+ljvRQRuyUnZZf5oNqPuImBCMqu9E0moqByFjPFfsTphHHfpo
         dD1IXcprk/RHbf9qyO2MvET/nG4DBNn2yq2FjK/3qPF4cidwHNC08XVkf9dyEqtPP+5G
         8Rg1EVx7qhN89LFVzWG4ZEn9lSDenIRuyGcH/xzF/nS2rbPzGm2HjpLUBDePW5u3yVQp
         BdUBMLMDnJSGT2tbGLVHB956EsZ4QNNy6KKPaeImCSOzx4vMgUTP84ySt0eq6T1hjZin
         F+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108943; x=1793713743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
        b=WehwKAWouwbnDdipC5z2IQxEHzOXROe5bg0Po5+9fA4xlEdWM4dwO30GhxqCstYwvc
         HC2Vhr0FBGivNf4vF6YOajDCa3GZMiM2KLKrdcPvoJQUINu7d4SNOuc6COyPixVApDaY
         PbBeyqsJhlQ/u6EanQiRpxK0GsKEEPx8/Gj4Md+LVbOU99almAc3Issc/cMpElStDw8C
         99Qd3po4pK9A+ujdHhVf5Gwfxi2Vhu3FFI0p7R6Uv+J3pUs5bVGLX2ZvACJUYZEgKpQs
         U/sHAKDKt9OBmCM9xtWfOsWa9YmXSKOM+Oyx1c9vZZbLF0TLnjMHTF9dgph6VsvEqEWR
         TQDg==
X-Gm-Message-State: AFq9FYLz8tt+1QNPRcQx0jcHZT3I9KZ/rVcT1epBcC6IWRIAo1KF5Kob
	RjZ2SxPAL9Nvz00CGhTeup6AVJvBZaw+WOfIvAp/OhebDha/HXLMAHwQDNW+yarL3DYASFKowa6
	fiTDk08TyTlA044o03CqXVIU5TSz6bLhuMbDz1sX5Gx7qJ3KpRY1FA/y61OQ=
X-Gm-Gg: AYBFou2BBppt239XW5sUkqhg/MfyVS8KRM/0Kp8qylLHPww3y7ImXtOavafuXih7O9Y
	8+EDmJCurDWcHbLIC8HKPVrzFAvYRpKjnSJ+9gDblCe3lL+C8Tc9haSZU35DHa0CtX9qJQ4WzC/
	IDYo6ZSa/9k/c8Fwg/rwpOlE34dSKv5xU+wQDP8FYJdfDSQe53yODheFC/7WopRE7m1W287dCD+
	HfvBsRB6ijCxtC5x5zH+ElhvciLQGz5QdtmrEL8BXZCz1hsjnRpfphaBZmpIMZfAWbUtLBbkD7N
	DWAO6ZVoOan7aJQ9RwVTSaqrbuICR+jMvpQxOiUws/PvToFd/c/JtY7Kfea/FPRLnzFVfOiObrt
	mfY4GKpI4Amo=
X-Received: by 2002:a05:620a:27cd:b0:93e:c12c:fbbf with SMTP id af79cd13be357-940ef96ee50mr1550617685a.76.1793108943038;
        Tue, 27 Oct 2026 06:49:03 -0700 (PDT)
X-Received: by 2002:a05:620a:27cd:b0:93e:c12c:fbbf with SMTP id af79cd13be357-940ef96ee50mr1550612685a.76.1793108942481;
        Tue, 27 Oct 2026 06:49:02 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89cesm464714066b.13.2026.10.27.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:01 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:39 +0100
Subject: [PATCH net v2 4/6] net: stmmac: copy XDP metadata in AF_XDP
 zero-copy RX
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-4-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0abcf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9RzD3mWewD2guqUcLtsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: etw0EUb4GPGKNHUvkht-I6fGJCwb2fDf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX53/RK4wPCYQR
 0gLWip5PEoL+1eJlWv81HpeUksvTxdUi4sRT3SYGQcAwxBwGXSN79JxoyoNv5k7rpHgfqr6Jp7t
 DcglTHao1Pitol3II5z9l6zr8bJj+eg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXxidk9rxgLz0d
 I/qbACFUaaGh0g+qAGkhE5eAWdq6T29XfWbTqEKp+r9vXX28lNp0QV+H8UEkUwpl5bSi2fa5KqR
 rEsVYuW6MXm3HLx/htfSNqbB/lnJL5UD92nHri8k5eydKfXxsorjKiALvI7FEkInhjzdBEldg8G
 vdB5ulToNztClVlNDrwR4fBc25ntB5SlPt4TW4zHg+H38MucfZfMbInpF1+gFjF8ZiLMnKTdBAP
 TK5JVQpRKj3fuQ8vHVb4uflmsULkGniEd7UIGC+6UkAv6mACXSuhafJvjeyUVfjFojc/Usi94lX
 Fd7/ixOcp6mhVMxVTUbyMchJB+S4yB2AJgWWYLujozoO2F6MRT8CmgGmHyAYosekvtSr3YoOeLx
 B9Y4B7pSpn7A14l6/hKcpHRegIUC+2TfXKVr2jBAojzCsYyQcOVxChEKsWqUUzquQSk2td7FOo4
 J4rk7HPmH7pFmEf7QYg==
X-Proofpoint-ORIG-GUID: etw0EUb4GPGKNHUvkht-I6fGJCwb2fDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

stmmac_construct_skb_zc() reserves headroom for the XDP metadata and
records the length reported by the XDP program, but only copies the
packet data starting at xdp->data. The bytes in
[xdp->data_meta, xdp->data) are never copied into the new skb, so the
skb advertises metadata that is not there: after eth_type_trans()
anchors mac_header, data_meta points at uninitialized headroom instead
of what the program wrote.

Copy the metadata together with the packet data starting at
xdp->data_meta, leaving skb->data at the start of the frame and the
metadata immediately before it, and record its length. This keeps
data_meta valid for the stack and TC BPF after eth_type_trans() anchors
mac_header.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 71858af6fd66..d9fc2464a160 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5519,7 +5519,8 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 		return NULL;
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
+	__skb_put(skb, datasize);
+	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 

-- 
2.56.0

