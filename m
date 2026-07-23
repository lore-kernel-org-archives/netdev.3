Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B052931D6;
	Thu, 23 Jul 2026 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831921; cv=none; b=aFyNQc7xRRqJ7RwfCBw/Oqba8lSuVim+umStn46AJA5KiKpS3uQwOffJ4r9KDZkCLRjAduPMQ9t12j9qQYvnV3NbC7sQO6C4EUWGRO3EK/lIltsk25ayi7b/gUIOvs9E+3h73bGvltSZxa2x7m/sClMcuQUvfJhvPX2pZuKnfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831921; c=relaxed/simple;
	bh=1NeeIXfnWGlQLhIRr2b/V7Mo3/dYcYyxTzAypBHqhzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9i8CVNN4hoieV6qa7uTMzGIhx14iXcFNvzkr1Y5gYCqC3rjLuKUDq9DCw8CdPUDSzACBwZhSA3Sw1D97eQOxi+ZfqOaKUMuOXrfwzzR7rLYmbpETX0OTM+C6ociw3Tgzm0/uWWuCgQU2atqyaN56aVJm1gUx2nQ6+Pza0IWJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pJfI/Uys; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pJfI/Uys"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgCnc3608580;
	Thu, 23 Jul 2026 18:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=caz17a
	SgCtxj6G38F0Hi3dPUkH9bV+H1m+Qnwv0uYn8=; b=pJfI/UysI87i4BI6vwuZTW
	22vlNPLGLEBO8FMAvaLH4l1XlQVaeS5bNLSLkXmkpooab3V2UzHwLIpuAO9S8Quc
	PPyHmsQimU0BKnJdtJ7Ie2fxTruwB33UomRuUTn9eWcb7hICUJ+ouJL7kbIFMqez
	VQS91mPX487Ku3WpZsoXMXRrOfyZRWqiR3NQWVlejfDLsAmXxbSPA6eKEqnRq+0o
	SUYngC41inr4GfOnTjyPKe0ppoOaizT/k8hGANssU++T6QM0ycJXqp3ZEi54cYhd
	n++w2j5iTvufuWZJSObODML/D25/oVB+GIZggQq5a5mlLNCVXwSTJF2N9dtXsXSA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kggx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:38:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYbiZ019009;
	Thu, 23 Jul 2026 18:38:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gnbhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:38:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIcS5W60228064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:38:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D0920040;
	Thu, 23 Jul 2026 18:38:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 550B32004B;
	Thu, 23 Jul 2026 18:38:27 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com (unknown [9.111.49.67])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:38:27 +0000 (GMT)
Message-ID: <0c91c243a9b1b92e33c3d8fba386e6e141e2d605.camel@linux.ibm.com>
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        bcodding@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Date: Thu, 23 Jul 2026 20:38:27 +0200
In-Reply-To: <20260723092630.1a1c9b4e@kernel.org>
References: <20260720090940.1334523-1-maxbr@linux.ibm.com>
	 <20260723092630.1a1c9b4e@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a625fa9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=XzwdMBfDO4G7gBtO6BEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXzF2Zjyw4rbdg
 SL4OZ2mhQY8xb7OM3QaUZip3doR1pTLc1SM2sQT/llgN+o0FIQgTemis6LOiZfn/1QBQxgNmr5R
 1ioXJh5ikPGexRLCDEVFdUeZPmRfpN2wekXModbICkI75st+YY2RhBUXqh4waDE1XaMFMy/pI7e
 usZ/SuFWLHRVrKMzplm/Gzo/Pf19LJNacgGkhniwFKbF6ZRun+rcIC8ADITZOlFwbuw7FzhDEDM
 8gqnYv5HWx+rbUuU5HFS1EUkuFjLHZgmLE9js/HP9RgDghYP9a/D5DCGAFOhvnx9+VAqeIgQXA4
 7QKcNodIrO7DdtUia/ZaJOEf6ZW21bcSP304xG9Zom2CnbR/lEXH5FVHfahCTz0+U8izwMGlZoG
 HjD+jJvZpcn+hpmOYQPgpHof+37EZjfXbWi53S4tnCmIuo2P3WSz2ts8canSDFAFm4m/0DQRcVE
 TtSqQyyomIDybs+FtFg==
X-Proofpoint-ORIG-GUID: ISbCBRdQDJOzqBBHmpBgqv6trUpUIHBn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX8MFUEfzxHl/a
 7O7ha6rs0AVAx7zWe685DfOgQAk6Ncuq6JE0ExCHiQ6Umchma1ldDFSL60XcoyVOVCOO9qgqYGW
 lziWwbM4FuPTPKc5blAO63sx+D1B9XQ=
X-Proofpoint-GUID: nURIUC7SGUJyZogkiVS79VJrNvwCdOQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230178

On Thu, 2026-07-23 at 09:26 -0700, Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 11:08:47 +0200 Maximilian Immanuel Brandtner
> wrote:
> > When a signal interrupts a blocking send, tls_tx_records() treats
> > the
> > resulting -ERESTARTSYS as a transmission failure and marks the
> > socket
> > errored via tls_err_abort() with the raw error code. Later syscalls
> > return the kernel-internal errno 512 (ERESTARTSYS) to userspace, as
> > the
> > signal it stems from is no longer pending during syscall exit and
> > thus
> > never translated.
>=20
> Can we just add ERESTARTSYS handling? I never heard of the other
> codes
> you're checking TBH, can they actually surface?

I don't know whether three are any drivers that call these error codes
in practice. However, I know that these other errnos also get handled,
by the signal re-entrancy logic (for example see `handle_signal()` in
`arch/x86/kernel/signal.c`). I think all these error codes should
propagate to the relevant signal logic to be converted to the right
error code and avoid leaking kernel-internal error codes to user-space.

Maybe EINTR could be removed from the patch. I just kept it in just in
case.

>=20
> > An interrupted send is not a connection error: the partially sent
> > record
> > stays queued and is resent later. Interrupt error codes are
> > therefore
> > excluded from the abort in the same way as -EAGAIN.
> >=20
> > Fixes: b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling")
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> > ---
> > Tested on top of net commit 3f1f75536668 ("net: openvswitch: reject
> > oversized nested action attrs").
> >=20
> > Several subsystems contain static helper functions to classify
> > these
> > interrupt errnos. It might be worthwhile to refactor these static
> > functions into a generic helper function.
>=20
> Yes, please.

I'll prepare a seperate patch-set for that then. Note this helper will
only cover `ERESTARTSYS`, `ERESTARTNOINTR`, `ERESTARTNOHAND`, and
`ERESTART_RESTARTBLOCK`, because there are a bunch of places in the
kernel where these 4 error codes in particular are checked against.
>=20
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index d4afc90fd796..3c9e94069e82 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -405,6 +405,24 @@ static void tls_free_open_rec(struct sock *sk)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +static bool tls_is_non_restartable_err(int err)
> > +{
> > +	if (err >=3D 0)
> > +		return false;
>=20
> This doesn't belong in a helper for classifying errors.

So you would prefer if (rc < 0 && !tls_is_restartable_err(rc))

>=20
> > +	switch (err) {
> > +	case -EAGAIN:
> > +	case -EINTR:
> > +	case -ERESTARTSYS:
> > +	case -ERESTARTNOINTR:
> > +	case -ERESTARTNOHAND:
> > +	case -ERESTART_RESTARTBLOCK:
> > +		return false;
> > +	default:
> > +		return true;
> > +	}
> > +}
> > +
> > =C2=A0int tls_tx_records(struct sock *sk, int flags)
> > =C2=A0{
> > =C2=A0	struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> > @@ -458,7 +476,7 @@ int tls_tx_records(struct sock *sk, int flags)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0tx_err:
> > -	if (rc < 0 && rc !=3D -EAGAIN)
> > +	if (tls_is_non_restartable_err(rc))
> > =C2=A0		tls_err_abort(sk, rc);
> > =C2=A0
> > =C2=A0	return rc;
