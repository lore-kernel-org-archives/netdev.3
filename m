Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143D38F926;
	Sat, 25 Jul 2026 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784951931; cv=none; b=nxGMELjGZQH2TOwY1JvkeloUUtgxpBjZjeOaTHwNSyYwn6/eSYFwAFMg5YWDNIejDnyamj7iVX5Yxh3ob3efdNiZ33Lga3w+X7td/2VDaBpxOZL59IHKO4f9lfK8SMCEzcgiI8z4Px3VfyMouZiVx+MYrDFJQweNuBW+wavu0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784951931; c=relaxed/simple;
	bh=BkweISXzWt/XR0ZRCwhwzNasN3vVRWoEUdtl0g5e9lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JE082PTZiJ3YfpQLlB2DjTS9R20T8WzOlZDmCZr2R9x7GV4JV4bJHGfIGEgbLT3jU5Ioqji0kIGxPub4YtQQksKvC8biQfc/tHxSxrs9WU+uA5WZYhfuH/2NbJHMYZuiGdAK+Ta0VUvyINJlPpTbhLqKujxwBTRPBxE878K9eIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NN76u4n3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NN76u4n3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P2v1ep3680027;
	Sat, 25 Jul 2026 03:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BkweIS
	XzWt/XR0ZRCwhwzNasN3vVRWoEUdtl0g5e9lo=; b=NN76u4n3iQ2MxlYHM3mtNJ
	4X1V1L6m2/T5j5Go7t01ldM8ce7olWNDO2pUMFSqZC9AhsmyQcCYQNfvNFkPDsn2
	rvd2bEPwcnrVoDwZYKcaxhpPziul8ZbC1qZhTLZj15PwyYgwz2fEKnC/puw3G84G
	23OjsaMSzjWckuaTcJOX1c9jpMtiYstZL51H+YMQGAcOMFVxyKgWwcgCq8DIJ3GZ
	E6+UtIWMWwbII9MgIB7ESzNDHml8KpgY1eayabQ7QfYqi7bOoyCorJLC0ps4hbQX
	x9FIf6sXPSzvd5RFLSZvtNtM0uOw7/J8eys27Z94KJWaVULEq3DQULOSY26bju/Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmst04tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:58:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P3uWZn008817;
	Sat, 25 Jul 2026 03:58:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn1u03gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:58:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P3wbHR32964898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 03:58:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC7A2019C;
	Sat, 25 Jul 2026 03:39:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979E620196;
	Sat, 25 Jul 2026 03:39:13 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.111.80.37])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 03:39:13 +0000 (GMT)
Message-ID: <43db5fe53663619d199b3adf0fc025e7526cf819.camel@linux.ibm.com>
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Date: Sat, 25 Jul 2026 05:39:13 +0200
In-Reply-To: <fa33ce0b-d040-4c4f-9bcf-4ccddb127b92@redhat.com>
References: <20260720090940.1334523-1-maxbr@linux.ibm.com>
	 <20260723092630.1a1c9b4e@kernel.org>
	 <fa33ce0b-d040-4c4f-9bcf-4ccddb127b92@redhat.com>
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
X-Authority-Analysis: v=2.4 cv=COgamxrD c=1 sm=1 tr=0 ts=6a643473 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=BCt8zh-F8LzyvZBcyEsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAzMSBTYWx0ZWRfXyQlSldB32CKZ
 phrBJjdnfZg+rQ5njd7vUosq+g4kuA0mYR4LhmPDnhwY9PoEMfQ1ftn+34yF01kZTL/AX942VEA
 NomoFwzWPLPpjvSgWHNLNwp4gRVeI1E=
X-Proofpoint-ORIG-GUID: E5JfK3lFNsSFJENtoVsdd6aYLhe4Hgbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAzMSBTYWx0ZWRfX1TGv0i/1tW0k
 eRroz+Sh6XvI35zx7Pgfs/bTpWMAyetG3bPBMSnT6kGjNlZnPMaiqNERQ10TKwaF0cQrO4mlQ4y
 6WGP34MdvTd/IVhtu6dFalAEgTL2yEhfjVhNTTwEoR2aGmzEgxaMveeXDtlgtRJv2eLDS6WJj9n
 2KgSxjePncmSWXPq4wLrzOJFFfy6k8KRoDWDYxBsOyA36O5W07QKSeUdEvpQOAISEBe5a+as0sB
 1KwE3c6ko86pUyuu+oEXjqaMy3WJDNUPYUcX6JjPNnxJW5g4R0dSeJ0l7vuegbpB9yjJ0vOCNLf
 iUcwUCUYvvSZKY2V7DzRkknj17okNep455SHodLbvaCFUWQhJ8yXgFz+iv74t5N4ePPN/3Azs5V
 /G3VOtSJq0y4Lc8/Lb+JoYRZe95YCKEaV3NE9xHBSDBQPqeMJ1lD2egXQYDPA151E5l+y2qR+2Z
 wxQW8UBdMKlbJxzTmjQ==
X-Proofpoint-GUID: NmNdKdF6eVaTm3s0xNKpW-os8Htt9Vn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250031

On Fri, 2026-07-24 at 09:40 +0200, Paolo Abeni wrote:
> On 7/23/26 6:26 PM, Jakub Kicinski wrote:
> > On Mon, 20 Jul 2026 11:08:47 +0200 Maximilian Immanuel Brandtner
> > wrote:
> > > When a signal interrupts a blocking send, tls_tx_records() treats
> > > the
> > > resulting -ERESTARTSYS as a transmission failure and marks the
> > > socket
> > > errored via tls_err_abort() with the raw error code. Later
> > > syscalls
> > > return the kernel-internal errno 512 (ERESTARTSYS) to userspace,
> > > as the
> > > signal it stems from is no longer pending during syscall exit and
> > > thus
> > > never translated.
> >=20
> > Can we just add ERESTARTSYS handling? I never heard of the other
> > codes
> > you're checking TBH, can they actually surface?
>=20
> FTR, I think only EAGAIN and ERESTARTSYS can be observed in the
> network
> stack, and the latter only after sock_intr_errno() translation, i.e.
> on
> sendmsg()/recvmsg() return path.
>=20
> I would not add additional error code handling, until we have somee
> proof
> that it's needed.
>=20
> /P
>=20

Also you may just have forgotten to mention it, but EINTR can also be
returned from sock_intr_errno(), so at the very least the error codes
EAGAIN, EINTR, ERESTARTSYS should be treated as non-fatal.
