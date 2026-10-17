Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5D29BDBF
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273750; cv=none; b=N/7vHok4UW70lIceTegDDc4j7wVxqrRbgJO3s34+qcQ/U5Xa6Q0e4aJttORQvUsnwfB7kC8ZIF9CM+5c5oyX68DYgkKGGbEumtI2DTEPNK9LuUaDWEbJPHNosY+d581VZRA17KXbTIhg0J2wJJ4HJb7D3mdRBjbORBIgD29qu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273750; c=relaxed/simple;
	bh=VvmIiZsAQTuewLT4z+voMxu4lT+9AVGv01yAygNYMac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyJxuQQ50Sxjctyz4L/UARY1q87R8B/LtmNirPoyPq4HfDUziYUg0DJHqiUb3btaNwJ6Gje/6q29wQ4Zq6RMyR31cXqXY81yoxFXQZAtwQNBnr99zkDwGUEcYQCl/fR/aNpYNm1a2kFiOx8ywkv23moHVACdoNLdeeEkggHaCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=jLnZAvYZ; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Tc42URYe; arc=none smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="jLnZAvYZ";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Tc42URYe"
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HL3JdK1977632
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=59Nz+2ykEAA6Qs8QLk2O+NtyFmD2Phjzm6kC
	GW6XiFA=; b=jLnZAvYZp9rtfVnVUyLN91meiqStyzWbdQWlLZjK0Y6LaLQkOO+W
	i9uYsgFKb6roGw4E522azubZMhvAwX+0uo3Z71CVE/fpJfeJphcXN8G3PR1DuaVI
	0GznYoljJlNYFBN5rZx7RQ+jt4Xz68EAf1iouywij98H5YdE+Tr67cU+28um7uFR
	rENd9BcumswoD3gDzp1oD3WgECTTKK6sesUAMkFLNsf9Ymemqw3Lnf34Plk0Du9B
	Ym4MHefpFqbd4w1HfAzyBQn+tAedT8tE0isZ1+ypwgu6uNBJg1cY6ZH/2uxnHPB1
	cZhXPnXqXmfXVIo+lyr4nmjOX3V8bdBydg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hcgkn0a43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:49:06 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535294e0f64so18981551cf.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792273746; x=1792878546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59Nz+2ykEAA6Qs8QLk2O+NtyFmD2Phjzm6kCGW6XiFA=;
        b=Tc42URYezNqPFBn+5HejdFHwngGk6xdsVL9i/W8RbEMAnGaFGoP9eU29Hb5w/evDfu
         5Aw66vvy3WnJrUBDmDh06VV1qRm7wvhtgjiD0nkAUENfpxtM9/C7ybPl6nJf+R2pXcfI
         MUKe2VoF/Y/0T2atcGCRckW7LzINbbKzwpDyhC2nynqE5zWZeOgjUYnQOc3I7wTISnPw
         oyhAjOpgvFacQgnSmVxz0kSavQGqLNQX5kfa+hXTgjCAAavjLsS9xvhEf3Q7Kl8URbWN
         MSZ93eSYtDgn8PnYNkBBAJ0ZIY4Qybp2AClrS8AXrbRWwXdVtqVsYZcNgN3Vtk1bdKEq
         lvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273746; x=1792878546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59Nz+2ykEAA6Qs8QLk2O+NtyFmD2Phjzm6kCGW6XiFA=;
        b=HVwh7HivvDed+Z0K4A+Shtgsbyz4A3jhDRQtxz3OAzeXV2yP+acf9bpruIFSUNZaMS
         4Swl96Twi228wiBpYr1SiBi7zbhdgjjQqwJEOZ6IV/rXym9lyDPthTASEH0NQHubIwDG
         UDtIlL9df8RFJYbA0ct86RtPWVWL9TFkHoYGRP3MZPq3az8Y42VuYDZYefTqAnmDPCNp
         aCrrkeun8xjCQkPMysycDTjdE8Wlj8zts0h61x9v34Ik+fK6Qa6CpSnkzXEbBl98aRCx
         PEIzzh14GRQ6g3suB0svnU9bT6jQOBgJYTxjySp/6NuUJ8A3/8GPhiV7VTEZ833H6n4M
         pcrg==
X-Gm-Message-State: AFq9FYKuJhluc2+aRc9+vqqlxn0PwDit2vJOT+RaxJ/3rdLOlqymFckb
	W7FwS5tejKJvu+lJt6eusJg2qvDtoOtT6cXyh6ynMqASDlHkWkFWPVsDjXY1VUK6DHQ7x9tCI/f
	HfjamoH6cWnjDiLTOq29B0KV8SsP11ZQOIjL/iOIRg0yAMeNWM0g7lcY=
X-Gm-Gg: AYBFou2AsKiSXu21A/O7OGLpSksWeOuKLJ+uqfuU4Z8HVMq/BpYEMTNhmr4Oiqq0koG
	zAZL3MSWsyvTrDHSeHqOf9DcnohSQG3SlvBF9qXlFsSIH3cnTaThgYzwm7G81qZ4q5nCkk6nxTs
	pi63Z+ra3hQ0Gqo+nxQQ2Nf33UiEwUvo8pVWMQ2zTG8oO5vbdC4chqFo3+aX+v8Ffb4qQ8r6/oZ
	84OrnbemDPkWXZ1zf+1Uqh/8JO67brdAc3JjKJLWq5jbfdtyR1qfG9bxX0Vza2hAIEmlLzRP/0p
	BtGegzhYXJUy1gqNUVaRPGr/nHrjvJE72FpD5tT4o3FNl2PobzwQQ08lyXKtY93mTR0HEi21Zn7
	Kr1w5wG6jmZctiWHmTp+i36LhpWcqdhZAPnaK
X-Received: by 2002:a05:622a:5ce:b0:536:5a10:5c4c with SMTP id d75a77b69052e-5365a1081d7mr25580361cf.13.1792273745916;
        Sat, 17 Oct 2026 14:49:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5ce:b0:536:5a10:5c4c with SMTP id d75a77b69052e-5365a1081d7mr25580121cf.13.1792273745472;
        Sat, 17 Oct 2026 14:49:05 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-129.natpool.nyu.edu. [216.165.95.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb0b231sm56350806d6.31.2026.10.17.14.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:49:03 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v4] net: ipv4: add zero check for snd_cwnd_clamp
Date: Sat, 17 Oct 2026 17:48:46 -0400
Message-ID: <20261017214845.28769-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX/O6mdXepe9SI
 CabZVY/hBxLNfiQUae7IWH8pMfpeIjV2KiKAYcU3M+/B2Rrz3ETkDo5uKUUt2eDEk12VeKkIk/T
 BSBRmgHEf3ml7AS1Y+duD0xhgwWSj2QVw0cKdFw/0eoUWDtUuEIZ8LPymiB6G3+j/zmRvdKeO+t
 e0J74sw7xr5XXJ9D+IJC1QvPdTiKsGARTvJZb+SDtbhH2wbCKDI9wyKGtq4Ahp75mcsk8crbCjK
 ZO2ZB6ozdgMEzEkUdflV1VMnjchE80ZZd6SxzuwlJ1oyuEybEpw6jAAkszXd35aaMQW+duTMlZk
 GmeghEfaEP9dzUQ8ZsVTpm4GAHljZFRKfu/E2sGf8uvtOt7SDTiOpFJDG3rAvkrkYKKsRPMLTim
 GExj2oIIPfQGnQ7YQSDUwr6WblxuSCNH5sB0SvtIeNqhPeNWtTYJiiGc2wvitE09rossn47fVFd
 q9jVlicWbT2PaaGlPzw==
X-Proofpoint-GUID: z5_HQG9HOKOhJPFtRAO_DU-TBGs9MUDi
X-Authority-Analysis: v=2.4 cv=C+58WgP+ c=1 sm=1 tr=0 ts=6ad3ed52 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=k9NFnU9fOQnGI6ew/wxyRQ==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=tr4woWNwjDflhTIOjkZU:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: z5_HQG9HOKOhJPFtRAO_DU-TBGs9MUDi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX0WbGUKXT5vtl
 aJts/M2vey4KQcaL6OxU47rOGlgTFaIGCzovEucQU78nu+dH6bi6pMKuJeBmKaIZUBOulhxHdZn
 Rued7/QcWOl7/SCBZ23WTAVdIcyXQp4=
X-Orig-IP: 209.85.160.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170087

User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
This could lead to division of zero error if not checked properly.

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
Call Trace:
 <IRQ>
 tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
 tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tcp_input.c:4440)
 tcp_rcv_established (net/ipv4/tcp_input.c:6685)
 tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
 tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
 ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
 ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
 ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./include/li)
 __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
 __netif_receive_skb (net/core/dev.c:6410)
 process_backlog (net/core/dev.c:6761)
 __napi_poll.constprop.0 (net/core/dev.c:7830)
 net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
 handle_softirqs (kernel/softirq.c:645)
 __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
 irq_exit_rcu (kernel/softirq.c:775)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)

Fix by checking if user pass in zero as parameter,
if so reject the value zero.

Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
Cc: stable@vger.kernel.org
Reported-by: co+71b6509cb791e531@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 include/net/tcp.h  | 3 +--
 net/ipv4/metrics.c | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4416cdf9bf30..ad80b8fb8a52 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1521,8 +1521,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 
 static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
 {
-	WARN_ON_ONCE((int)val <= 0);
-	WRITE_ONCE(tp->snd_cwnd, val);
+	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
 }
 
 static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..cb36686973e5 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if (type == RTAX_CWND && !val) {
+			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
-- 
2.43.0

