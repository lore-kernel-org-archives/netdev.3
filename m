Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1629ACC5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633782; cv=none; b=dWXYDORqRQcRI8dGKhyyDHyzGQAG42y6tTmpgHLfXE8R/guVh372Q6MTQirj7HluYpRcjxESBr+0GGmpZye99VBCVIR4H4No8i0Hq3XM2/11RAc/bEuYYsDAl4UzaadzTYSHI0kX3Iw8TaWH6dnOqkm14RtfAsA2AYtczjMpYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633782; c=relaxed/simple;
	bh=J53d4ZAEFQL4u+cRW7KTszqjCVHcAreiqPpsicwRi8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EurbLu59KhbTc/g/bUIGB6vHBz6ee3BwFpc1/1ciTmzIlFrkakbfdFwpbrXJhDH7WM14VDwM5vGgva+lc+rN/VoxnEr1PHbd6or5rg+mWcAM/DJnyesEanayt4cw6UaFW8DIEegYn+dFI6JJcroBwX9jq3tJNbAYq8eKQLlXbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMhs3mAf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=darpooeN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMhs3mAf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="darpooeN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H7wldO931095
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IDEYVQCkx7UdqLCZalqnFH
	UrirML9c+nDMbyTl+aRvE=; b=dMhs3mAfJpYrLtcVaNVgvJ1dqzIfU96wDvLSw8
	ob3k4XBA7LG+Mxu3RT7iJ/mUvsudq+6ZCKarWwobQ0gjrw3m4Q8ajFpTrUrZ95UG
	fzzeMA/367mU+DBGhprkFAv45dOpzoUZL/Xs5lyqZ/AORRXro7cevyi31ee33SMZ
	/En4N3BdvUgO8GQwH7N/OsB+Hcal/TCFW/XQB+gbbeZf52djGeS5HqvtfHUaGeD9
	kjKRmtAvjln7YiuqqETeLgQ+hke27a+WSg9ABhDAJwIJ6F3McBspD1p6gQoHVYhy
	jSyrJPu5Bvp8ymnc1f9PgMajTBn9xI/NAai9nc1nJWGpeJbg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grc9w8400-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936aa34873bso98105885a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633775; x=1790238575; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IDEYVQCkx7UdqLCZalqnFHUrirML9c+nDMbyTl+aRvE=;
        b=darpooeNMt4mOqVtVtgBkuGiGanP+kIu6MK2UH4YnU4bVYuhD80Kv/VIszavf4wXX5
         oXgi1HRqUg5hYa8vJNbMyZeNMaw2cq4Ufa3MrJPe9pJAgMmp5J0TKEyu5lZhBRut13sT
         c2yyKt+AKVsvFoLNuW2oEPF9CU6iyehAQc2GcfTscKpnVgAPR6KQUjYDIuGD+0idyb0o
         peyK/oRrMpl6A3ImrZxdrjBE+O59c0VGITy46bUEOk6/UJBCPA+ld8xO3t+P5/LXvxj/
         BsRcgNqyoMplF6A3ywbHKxQeojZ+CJ2gwxtiCbA4X3ALKF3+6yJksHCWdwarLh1XcLtE
         DHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633775; x=1790238575;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IDEYVQCkx7UdqLCZalqnFHUrirML9c+nDMbyTl+aRvE=;
        b=byvfNfyRXXgnBdvWUmhGg4iZdHP/IiC+0cOJuG7Vb1EeF577hEwTdrTTUBwBL5Kggv
         ICycvaLwQz6wbhPApVIy4HfS3vhn1WgcWWpo2EsWDGjXSaeycLgHlbijN1mbRVErUXdL
         SV27SstmxUeIkQGy2sx4oqO1Gb6HohoLWYC1c35aLohJzuDFQ3q1G1cM3WvjaZfCMJFA
         jYsWLtG/GspZ9b4Wd3JT9WHhTQanVRfA144PBujh38Gfw1cAKHfaZzgLEkCSPpPIGctN
         0F2JSaG/WJ1srtHy6GcXb7zZSQoF5fxq7zCuBkhLOKX+4JMJl/0VGowUtdGITfEjXTFK
         WDXw==
X-Forwarded-Encrypted: i=1; AKwUvBwN59wAdzhKl2Uqx1q5E3O7Af2a7FygUP1wGuyKkZqn8PpVs6KDIDfOA4caWYpNEHhr/96TMDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mkkLD9AV22kxDInrMWc6YyR0Q9MSjVnFFm0z5dYYFSUPeEFCHv
	T1cPj0l3FKtDyUSmLOH6oVDID2n9QSgKwGlHerXR2eBRU0XaNVlELO5Ha2YPPm1B6rrHqi4OdY5
	J44VteDQa4ntoWgnGUteRzCNKm2G6/5GP/PlfeFIv93Gy3bLFPXU1DbFE6fk=
X-Gm-Gg: AYBFou1cFnlj1N3uJWVym/D0eIxef6D+TKkFcZOVL6JHTxU143mpSe5ghfJqBdQr2D6
	wo0OoR7m/pU3Ex/nE6WwbYdHiBWi8HTB3wMBxm6/UbkisBSyXXS8koFDYOuEBA0oTHTa17SOFa+
	yygiGM6Jv267Y4zQnqJm8UooR4tkxgXE4K4iA5Qlo3A2dqxs4DSaUbqPhacFGvjJxfVrASxiDKX
	FVFrJNaF2uq+7NzBTeD0kmP7/hmKrTEFsLWOjKTD8dmpagyLIIwHv3VKrXertLLdvwoSpsIq1RY
	AcoYFRLI5qTn/WityxPoqXcN2bs3cVyMLcOMGRhc9ieL285Ot6WfYjOEY7SaiboOw2KFRGSDrmD
	FG46pXRvmLQ++CA==
X-Received: by 2002:a05:620a:a18a:10b0:93b:be6d:4f3e with SMTP id af79cd13be357-93bbe6d4ffemr598951485a.25.1789633774665;
        Thu, 17 Sep 2026 01:29:34 -0700 (PDT)
X-Received: by 2002:a05:620a:a18a:10b0:93b:be6d:4f3e with SMTP id af79cd13be357-93bbe6d4ffemr598948485a.25.1789633774156;
        Thu, 17 Sep 2026 01:29:34 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de63c5e7sm240916666b.53.2026.09.17.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:33 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next v3 0/6] net: netfilter: preliminary support for
 IPv4 over IPv6 and SIT flowtable offload
Date: Thu, 17 Sep 2026 10:29:06 +0200
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-0-fd2ea96fac7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53OTQ6CMBAF4KuYrh3THwFx5T2Mi1qnMklpsUXAG
 O5uZeXCjW4meXnJ++bJEkbCxParJ4s4UKLgc1DrFTON9lcEuuTMJJclr7kAb8G6MPb67BDSCNo
 YdEBdSR0k6qGL6Kglr+MDilIVViNXViHLi7mzNC3akeUhj1PPTrloKPUhPpYvBrHUf4GDAA6Vx
 G19xp1Rwh5CSpvbXTsT2naTz8IN8pOofiPkmzClNqIqeCWLL8Q8zy8VoXGyWQEAAA==
X-Change-ID: 20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-5635fae03f3e
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX+Ou4fSowzq/S
 a3mfOEQxAnrjjAh2z62Qc8MBDLveook9rEHR1QhC/oWrkcsIg/4+d1kHG7xF84iph4ufBSLVZrd
 MIC/1ZESby8UjRzgHJuo9S74LxZdb12kFy14chUHWfj+tPhDwe2Od/fs/w7KLOGxbTXupyYJqP2
 /dXCiMTuPGOUKnCB+nx98XnHUQ08OUvXtpdak38ezdvwyxHpBKp04DW0KBv7VsjPbTle1kg8n0v
 /Hdu0cVY+/kJt0BDcaDmVOdggGI4wpU0ysQCxTtmG22G+bue4TnM/0JHGP8XTFUKNboKFQqztM1
 g0TKk9X56Q0T7amJ/TTUF3EmkBBiaXGiXp+mQ4sUYkPgpdA59I0NcO5sVc53tS2c1MJrkyQI4Cv
 pl1PY6P1JWSNnE5jpzHPCV5WzizFx4S+os5FmeHz8MQQK1wj48DmH35YumxEp7DLO8kXK6pQpp/
 R13IWlUGIfwO2P/fk+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX+J8jSyg9IMLW
 M4YlNM81G69J//r/Krw+xZ3X7DZkftKkXInr1TwFnZP5KVxMjzK4eqgBSqcbJjPD9nosC7YbKmu
 jzfxbV6e6QXoi0UxqSqyWYlqy86lNhE=
X-Proofpoint-GUID: lhFvcXCukLfYZG6VYv1ygMcQifbrBZ6x
X-Proofpoint-ORIG-GUID: lhFvcXCukLfYZG6VYv1ygMcQifbrBZ6x
X-Authority-Analysis: v=2.4 cv=EsZHPicA c=1 sm=1 tr=0 ts=6aaba4ef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hjUsVgM4bzNdy_QoUQ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Introduce some preliminary changes needed to support flowtable offload
for IPv4 over IPv6 and SIT traffic.

---
Changes in v3:
- Rely on nf_inet_addr instead of using two pointers for the same
  address.
- Add specific IPPROTO_IPV6 and IPPROTO_IPIP cases in
  nf_flow_tunnel_ip6ip6_push() and nf_flow_tunnel_ip_push().
- Rebase on top of nf-next main branch
- Link to v2: https://lore.kernel.org/r/20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com

Changes in v2:
- Fix dir configuration in nf_flow_offload_check_mtu() to compute tunnel
  MTU overhead.
- Link to v1: https://lore.kernel.org/r/20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com

---
Lorenzo Bianconi (6):
      net: netfilter: nf_flow_table: recognize IPv4/IPv6 in tunnel proto matching
      net: netfilter: nf_flow_table: set inner protocol when popping tunnel header
      net: netfilter: nf_flow_table: populate tunnel tuple regardless of inner protocol
      net: netfilter: add encap_proto to flow_offload_tunnel
      net: netfilter: nf_flow_table: refactor MTU check for tunnel offload
      net: netfilter: nf_flow_table: unify tunnel push for IPv4 and IPv6

 include/linux/netdevice.h             |   1 +
 include/net/netfilter/nf_flow_table.h |   1 +
 net/ipv4/ipip.c                       |   1 +
 net/ipv6/ip6_tunnel.c                 |   1 +
 net/netfilter/nf_flow_table_ip.c      | 215 +++++++++++++++++++++-------------
 net/netfilter/nf_flow_table_path.c    |   2 +
 6 files changed, 141 insertions(+), 80 deletions(-)
---
base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
change-id: 20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-5635fae03f3e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

