Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529F49502F
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731704; cv=none; b=NK8HYRWJiP5U6/I5Zx7nPfQL4Uqwn5MYlzLPJZDlAttkJGuGTRi0YWB0eRRJ9Gcz/WHk8acx1y21AdGtBe0lDHV3/6gVb/oK3KUTaIUyFzozIL7QNXYmnoXZNqWXTdk967n1R/qbatMbMf6JmFAMU7x8x/KlyaDLpEs8fcX1izI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731704; c=relaxed/simple;
	bh=oPsTVQ6lpyMyO4+OOnqj3XhG2LWKllIRv4lgDUMqN4A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMV2a2b40MoE3SBCu5zh9H7azXYswLu5KhKeWGbisu++cMVEU2QTEE5OQ+PzarXuCLIaQT2aUy4VEla6sIbtSwOBVDBKPYM3aVZx00ohw6arYGnVqj4FGXu9gK2KYkieENSOdFjkf7TaEZEDKqtVI664956QXTq0Sv3l6+cC7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RwvA3vdi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RwvA3vdi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EH1mPa1722108;
	Fri, 14 Aug 2026 18:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oPsTVQ
	6lpyMyO4+OOnqj3XhG2LWKllIRv4lgDUMqN4A=; b=RwvA3vdi5DOMjBU+4HLUHL
	lmZG/SZ8LsSRhSTwSU7xZysl880rFldcFQT1EXPRNqA6Ox3pjJohOHl7adjDAiwP
	EaiSoVvwsagM4Mc65qw3rtNBZmQP0Q8ETRYwClXD7A/+MJt0DrBzRGFsyRVaq35T
	/cmqUnKJA2Vy97fnEumBCTk1cyRoSV6DvVU1KEezfZlECspyvlurfYY1nlIIZ345
	gdaQ8nwxraUm5UmuIWyeUsDnc20Enzi5MBn3WJ9eYs2RMV5mXpRK9SHf9oHIPlaF
	3xP0zsXtTFIePenVmD+b2VMt+hWGXNsrTi5t1nw15NhTbm+EX4u83/M8aHH9wgBQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma698e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 18:21:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EIBLTn014515;
	Fri, 14 Aug 2026 18:21:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk8drk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 18:21:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EILVr152232486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 18:21:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F7F20043;
	Fri, 14 Aug 2026 18:21:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3EBC20040;
	Fri, 14 Aug 2026 18:21:30 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.111.3.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 18:21:30 +0000 (GMT)
Message-ID: <eaf24a5a2e83a7385e75e410475597f564b5ca15.camel@linux.ibm.com>
Subject: Re: [PATCH net v2] tls: fix RX desync on overlapping skbs
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Date: Fri, 14 Aug 2026 20:21:30 +0200
In-Reply-To: <20260813121337.3300688-1-maxbr@linux.ibm.com>
References: <20260813121337.3300688-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzOCBTYWx0ZWRfX8xaHuHI8f3pb
 ldoj+LUaLn05Zacn6EtbVwH3lSebTij9HUzpZj7IHcOKrJ4aHIKuqcjpfk/vDW6/A4Wdpbclbj0
 UfhR4ahi43iehaJgCYjQghAuhL2rzcoFWCEeohw1k4oh+ylVwbAC4Q5RG6TDAZJId0HXsYSr/Li
 8Xfxv/c3aHBCY45Aov3uYCRa5UvhbICH/qvIzUFUd0Fu4vo9J3r+LI83/rT3whS6UryinqknNvB
 ki/O9xmfieSUJqwJRG+BNW0m1nhSM7pxTk+pp5j22rULVSQOUJEVF2U4c9ratq0MvMZqwFXeQbW
 cN8nWusI1vtNHVvbTsMJtgE6T5nlbLBe1O69TxH/jR0vlUXClbP3ilwxm0VfGSawFR+IkYoOQHM
 KoDtfaosUFIVQtqcGIxGs+aA1D+cKrRkPOszysZYAQNlNzHQO1nR3QIU+BJgzMm44LMVZUBMHmC
 UMuQqNNimJWcBZ5OZVg==
X-Proofpoint-ORIG-GUID: ZgqRiIJsyay0vHOt9a8D0CsRzigl63AC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzOCBTYWx0ZWRfX97OSJA1yPq1V
 ora5JRrAog/Va3+I2+FrW7Wjok0BUdBFbQQ25xMcRh49xSZkin18/JnSjBNGH6Bv9uBa3oA7Lnm
 ihaIymyrO6JxxMC7L1BINvmGHF+qWNg=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f5cb1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=w-WFKapeeXf4jo0CZP4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iF99aQWa_8IeebUhPHqqaMFuXOWAKjx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140138

I just saw that for the v2 of this patch sashiko reported a supposed
potential null dereference which I believe to be an erroneous finding.

Sashiko claims that in tls_strp_check_queue_ok() after first =3D
skb_shinfo(strp->anchor)->frag_list; first may be NULL which would
result in a null dereference on seq =3D TCP_SKB_CB(first)->seq;

tls_strp_check_queue_ok(strp, TLS_HEADER_SIZE) is only called if inq >=3D
TLS_HEADER_SIZE. tcp_inq() counts real payload bytes so [copied_seq,
rcv_nxt) holds at least TLS_HEADER_SIZE bytes which live in sk-
>sk_receive_queue. tcp_recv_skb(sk, copied_seq) returns the skb
covering copied_seq. tls_strp_load_anchor_with_queue() stores it in
anchor->frag_list.

Therefore, skb_shinfo(strp->anchor)->frag_list !=3D NULL for the check
introduced by this patch.

Kind regards,
Max Brandtner
