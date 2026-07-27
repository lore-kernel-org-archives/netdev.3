Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F93ACF17;
	Mon, 27 Jul 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187747; cv=none; b=lupIPIOOYEuEfE+FtcId0RGbJSm/lDPM17kCuZRpsfdqFRNAcDfTwTPFjtsPCvDyigXmyWprfnChOyXI1RoA6VkJimgQYDqM+x5+n73XIR/DEzl0GxUJzGzUu6IR3isbqaZJm67tk6P0O9KNWbnYkKERz/MCy0iOTkPrR6vxjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187747; c=relaxed/simple;
	bh=NDswSJS+g463vz/2ACpX8J4ha0LCcBQwS1gnA4ez/b0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCDok1l8SROB9C4SlXogi7ktxxhanL0I7u+jgApcZgyqctPZp+AaxhS8oNArBjI6zsYqMC4ScW8u3prQM+akxQg6b9FSq6AyN3JaOCQKfQIDFWrjVXsSP6a5xuSvNiX+9TsgUMkuMFXPkhuITDIj2LaV2VCZNahhHKjYKRNie8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=COGZB+z6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="COGZB+z6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHunv2876323;
	Mon, 27 Jul 2026 21:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NDswSJ
	S+g463vz/2ACpX8J4ha0LCcBQwS1gnA4ez/b0=; b=COGZB+z6V8YdGEsKWTutCH
	ZYLvsLYfuZh+OzTSz4AilWHg4or35nB3XavZZmhshEucaOqiksSsVwWW9qQ2N3wd
	MmQJidM2tuZLmknUWpXPqixYqkcwWr9bFRVAZMwvaZM06ww87ATetldN8FI0mCcJ
	SgBAEYYXA3Hu4TzpNsTDcLTosoXly6wfnGub2mwVKLHtBjDnNe2DBkF1s6QcMznq
	fWkmEQ9q1AF29mjVBGNJ1JyjeVH5ga+riEq9OL9gFTewYfiHfrni753t7xR5Svi4
	nTXuhPaT7YsBqOl88F7I7iig9kNGLmgs4tG5nMZK6gvGb+RQv71711FRmS8OOzUA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nhp5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:28:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RLQcvF013664;
	Mon, 27 Jul 2026 21:28:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xxtqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:28:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RLSrjW43123042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 21:28:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1DEC20075;
	Mon, 27 Jul 2026 20:40:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73FDD20076;
	Mon, 27 Jul 2026 20:40:00 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.111.2.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 20:40:00 +0000 (GMT)
Message-ID: <2a48a680b9b15cf6567a2d5e5993db816797d9aa.camel@linux.ibm.com>
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, bcodding@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        svens@linux.ibm.com, brueckner@linux.ibm.com
Date: Mon, 27 Jul 2026 22:39:59 +0200
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MSBTYWx0ZWRfX4lIBtw8XTllk
 JoPIB1bWkYHVQuClmtUtk31jDCRZqPl/5B9bsBuwcibTc/cUqObdTvdvM9fs7DMZ55prVR9ot9u
 T/CchXX0zuBi4/dy7S7+afbACJYnRv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MSBTYWx0ZWRfX3JP6FlzFhEWu
 kniW4GpDQrbrY4eEKrx0cJhJpyLql4+UmPOwdJ9xJAF1N5k6j8mGA3/fbvdTJAHpJPtuDfCSlBk
 6nBqZYFP86kPbJJFjjAX+czfI1q4wJsPw18FFZgZadTS3gelLG1VzaK0bPlkQrYsfIjSgpq99Ah
 1Te2egw1KdyuGrgIEc8nJmg1/tRg3Xpu3CTgJkj67dZnbU0LMNo5ZSVD5VXak5ov/VNtnRBUHqa
 mUXZjAjUSBM+cNaN3Yl6FNWwZurMOMEN67OZvTnCq9McgBvCKXLeSmOZpLtj7WZq/CQvpJuiPtq
 bKaLlbv+j4/tu/5WgRIdDodD7oXCLjexymCl2G20wrYqctjMf8qnfkKOv+zssq5cTr56yaSUJRb
 QlEVMsJvCgsLcz8FAw6AmHhfSaWCew+YK9LVMTGIZU9EBogI68Jnon3XSq6P+cQDoyZ71hp01Jr
 SIsyy2xMIXCqm76HhsQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67cd9a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=qJiFQjoMe4Y8Skl4EZ4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q8AbPuk8hjBDLLW4h93FEjz5hU1DjgAb
X-Proofpoint-ORIG-GUID: X79UA-KH_3wQmPyiGrhg-XDPf9XccoxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270191

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
> I would not add additional error code handling, until we have some
> proof
> that it's needed.
>=20
> /P

I have a v2 ready that only checks for EAGAIN, EINTR, and ERESTARTSYS.
Before I send it though I would like to receive some feedback whether I
should really remove the other error codes.
