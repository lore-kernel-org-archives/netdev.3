Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219383368B7;
	Sat, 25 Jul 2026 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784948995; cv=none; b=e7MnjAg7eicNRC1dOnh+hZLv5bmVG9SQJsza5IqKx7FkAcq5jU+X/pJWCLIfcuAylQAI7B6ewLqJnxZUvJJoGg01N/REUFR/KhnYVNyE/xTRGpKQZ937R9Zb9ZYMY1G9PiVSyfjqx13o/ITLT8AtW088lho/os4kGgOnqUGZHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784948995; c=relaxed/simple;
	bh=BDDFOcUYxwSMc37yI7GVwZrjYaS3Sui+0k0tQMuEjQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pE/sOX0mRFffnDtArgomA1ugNGhYG6SDtUkEeiiHFQEQciWWdUo/xaPiB0OnjH6uRy6E/Pnwcj3JGU5XoDWwzREB8NssSgGzMsdQ0q412ZCHVPNHPqhJXART2mjJGPOG3tPahGoIDfTFC/KVsFvqj7Tkbz/RWIkHmTtB8vPQT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e163ivBa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e163ivBa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P2wd6e1784493;
	Sat, 25 Jul 2026 03:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BDDFOc
	UYxwSMc37yI7GVwZrjYaS3Sui+0k0tQMuEjQU=; b=e163ivBa48KtiiSoJa0Mh6
	jg++P2bBjJyY4442zJcUV6WajiiFMQg1SGjFtebdRhqELU7HuxcursNDR1vUU7MM
	HwUmiEfkA6lCLf2TpZInw+jEYyKvaVflHJJccSpjaRbtajLntdfKLVAOHaRnNiYI
	b3fKXZS3tV0CzAEjSgIyXxeclquMYDomEN4kj0vengFbsJ/supAKFFeIxTyDV4QH
	Jy4eL9WzSoDeesaCBNP4zHhM7qAXFZGDu9w8LyOQ3PNsOMLCr6X//gpVLTLpSdFa
	WG41F68GjYdFPyCpV+Hf+nvjsFuBGf4Vt9Nr/q0was+alkSBrbDZOcU0qMnUo7wg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmtq00yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:09:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P36oXw018259;
	Sat, 25 Jul 2026 03:09:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wkpjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:09:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P39Shu38535676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 03:09:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D85200F2;
	Sat, 25 Jul 2026 03:09:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9205200ED;
	Sat, 25 Jul 2026 03:09:27 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.111.80.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 03:09:27 +0000 (GMT)
Message-ID: <ab01a87d17e491de68684f7116d55ed1a70b7522.camel@linux.ibm.com>
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, bcodding@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        svens@linux.ibm.com, brueckner@linux.ibm.com
Date: Sat, 25 Jul 2026 05:09:27 +0200
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
X-Authority-Analysis: v=2.4 cv=JcWMa0KV c=1 sm=1 tr=0 ts=6a6428ee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=BCt8zh-F8LzyvZBcyEsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAyMyBTYWx0ZWRfX1d5xEmEuIU4e
 OxEXKezp4Dm97RvH10c4mz0kfsqKCLC2k/ZyFn2HY8WXXqpzVdqIWkyRvfRi4PiKeaXTFOKKJKG
 8GN10NreI6YieFxYGfm1spVBiIiCAbwgfscRMEwod9ZGK4H1yT8+ofAx3oDBgiO3CLtrHihPqM5
 6dXPsKBkW7n96Q8lg07xxDthJR9ymuhn725YzfEzYW2W5TLBZ3uMWuklDiUYqT7NT0CHit3pKf/
 qpdO7hKc0nma+ZTwkQh5x3IB23+v6RLamNcIPsYsrq7/Pfv1EvbFPoWBRi2wJBKdetCWoWxnrGV
 rAUS32fzWLA9JrPspouMSF5LXlr+nBP4tX3ls2gZT29nEF7trtkBt3I5ORarcjWoNvui2Wrjhhg
 vLqnb+vJ3iATYSdimBrm9Nr/EN02ejpEnGrtn8nsfgtYphoDXuyrtic07405bYWI8LWvtNAiIWV
 0ARiuZ1jgHnsjaxUBUQ==
X-Proofpoint-GUID: KfyuTl908j9966IT22hlMWz7q_tJizBQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAyMyBTYWx0ZWRfX8wQDOU9KcT1v
 Y3HoSLJ08COPAkxej1ukkc0ljXyIjQojOg8AeThOPXi/jq3ZOgW072OVdAPjJN1YWRocc2sj8tq
 guWQkg889MB7xPnAHpMQphN42V5l49g=
X-Proofpoint-ORIG-GUID: UYulYLrY0HcqT81XMVYjhNEGAtSMmHMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250023

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

Is this an explicit requirement in the subsystem or just a practical
observation. Because if this is only fixed for ERESTARTSYS and some
part of the networking subsystem later introduces code that might
return these other restart error codes the same problem could occur
again. By my lights, it's better to err on the side of caution, but if
we can be certain that this assumption won't be broken in the future
I'd be fine with dropping the other restart error codes.
