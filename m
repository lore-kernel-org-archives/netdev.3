Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100121;
	b=m3PK4NUlWZnaOjrOVstHNAZbsJl6tBu/TVdz3jkgcZaXQdiopFoTrhLHOd5epOXDkbt9
	 gtUCDXkjx2sIlKyv8t8JSoVf4CdJqbBOedpKNZX8I9CDvqw5FYpLK0i7xT5ouLgJyUjzY
	 h/Q31BPU/g90s1HqFaBJsWQWezL1WsV55TBZG2HZOdQV8cLUfvF081zTVtRoX1RLwr+Te
	 JAJPkuXk9J4OA2o7TQrd/wPvPbgpOp2tzuHScyDUzDWqUpjjrbEtfzQPXOtJq+RUeF3Vx
	 q1kAkhEGNTHPnrkNh16mh1fFDOAVxugq8Q83wQMdInADE6nAKTtXLipEtROQP1aZj5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100121;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FDWKmv9OnB4r2DAPnWAEF9SjLEImPSiYBnJWoztT80s=;
	b=Z4YBeJLoMEXqp6Mv4rQAhp5cLmFbnzj3BaV0EPL5RiREahX44AzcE2lfaUxKh8VWtBsA
	 LxjFFrEMcYA3adk3LuxVU3A8P8kG+59+BndpyH41L7jnKMb1tZERLijHtg4/TmfS9oERS
	 7XzA5ldNc0NFUeWo1kaD74YJtPIZF9v1ojbbHkcpj0zPxvalGtqd2xPh67oPDr9vGyO24
	 /Kpkx5HRSefOxkTZv736YIarcznEgRoSYmwBGbXe2hiDTdK/s2VPv58UxKtgdj6ZXmT0G
	 wDvLHC2lFOGi2F1+T5WzuqDNgIzVDdja0LCfbQYgbTsNtS8rdkpxnyFaoI1osbbppgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPIyLcRl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kLfJsVWL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DD606A325
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZPIyLcRl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kLfJsVWL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe0bW2458167
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDWKmv9OnB4r2DAPnWAEF9SjLEImPSiYBnJWoztT80s=; b=ZPIyLcRlZqnVtwSi
	2UleO8gtdP9r8b11Z6Mb6Qcfxsp/BL8WnV4NI+it9UROgCI5fPc0bbXRjPF230ox
	x43W8G7vTe4PgTMMaNdu0oTb/e0gGVedNQglLNDGoRQi/C5+KEduDHs0qwf2qrEG
	UIHwKYnoxXw59zFRdTR9UoXieJc3tvpR2f8B/unJdFz2Psrd4jMMtmud5STj/qPj
	E8WnIMNesjfhzxpoyUSaPBqkR+9/uS1QZFvF0fXAHhRQfsBSWHVAibskfX8lLaxi
	g/wgbX+/hVfQTKhjsUYXbMGTPvlPG9gs6MsZrqVdv7gjKG/K516r5ORiy5YiSTGV
	gfBfpw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbta0ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:21:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb71b1443so895372185a.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793100118; cv=none;
        d=google.com; s=arc-20260327;
        b=nWvQ6zQ5ErGiLyif4BiSNJiGt3JoKB593klxXH2U3pyG870h7nGMcUP4uGqntSGW7Q
         ehrwnqr+19VtK32KcMhPBx8P1/AvjfR2baGHJF9rX/DoSa+s6nYi8UjPcYygkbI7Saib
         Na+CNMzZWAhkmzAVrwd9oxcSJ6l6P5YZwYfMi0D4y7aKMPtpBfjqnZGIScnhxWO+AD69
         0H3icZ6PHNXINHb+mvxsC6M7CIVUwSCxEv2JCxLKDQ+8eKsFflrQKibaLdV8Fcr7VMNV
         Wzq6pH994gkVim6xwzKFu8VIxigQKSjxIe351Kl1AsZEB5ynNTdE3kRxKJ0NARhvg94+
         WXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FDWKmv9OnB4r2DAPnWAEF9SjLEImPSiYBnJWoztT80s=;
        fh=UiOTY4SZLIfgtq71rs+cRgNDeAq6GUmoZbS8bSJZ26I=;
        b=U1JVZjtzJL5M0dQN2UJt/jS9NMxWDfoXOfcxQ3tRTSFieO53or0MQ46sDfnmqY7jdj
         mA4p9HAf+Kn3yHDlHloh6321DB/o1Ic2TP8VQNBpEUuuw1CU0o//PkSkE0QOFy+GyX7Y
         HWljziaigrruoaxYsGkNnKQoIqTCLtGd2HS22LshecY7MRKenBiFQRuBpAAkicsCmkD/
         yexMKzy9ISDJkzURROdbdaAhXMdg0z3l7OheKVsItnRvAqlTzubsUtRsBsAL+Pc43qKX
         s8e7gtQvnvCm61GAYwFo5Iu48yXgePXFqADEKQDiJ0JBbxaY8lvwa+gfcBMuW97WpM1b
         Rwzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793100118; x=1793704918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FDWKmv9OnB4r2DAPnWAEF9SjLEImPSiYBnJWoztT80s=;
        b=kLfJsVWLK3WJrLgTb+b+Dn2t3ZubfLrIu3DQuLkgcIkIBZMxbwoHlcC2Kro05grjni
         QAT1FvTpT479/kMkA2KtD/Z0/0dSi1lKoaoKSe9cPENJYBgr6Ybl7Y5I0rCkHywFrS8m
         7uMwEyk4N+qIt9o6gEMoo5Pt4CElszzGsknS73lSlG0wa+9pMR9yUumcEjDk7YQWlDAw
         O0LKN0sHjQzkKrS34JWrEUn7C8b4e1LuadJ1vlz4VKeVN+GGutjYEJL8wQhgjkhz4jKR
         fgajS8FoUbcN2OomfqjbVhExVK+M4kX2Qf+oofzUtu/AeDFMb9+qNqhJbomvJXyuJhIS
         qryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100118; x=1793704918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDWKmv9OnB4r2DAPnWAEF9SjLEImPSiYBnJWoztT80s=;
        b=HdaacOxAa9KY4Gfo19muixtPIRBfKKqZGcN/3o87I5/CkrpFh7EOwR0ZoXUcjx4+Lq
         qoBixCOKmuS0YULSQ+cGrCV6tfLcqNe4muQ210qbh0lDFhs/Bht375zWJBsHz6b8rtBT
         TIb6eAWQSlCmSVcUNSexDZ+9FrHXNty0apMXyxyGwmTZ9Nr/T/yAgF6veo8cdPPIqgNa
         5Fg57hoIiivnENG48HSjgcIkgqeVemwzk0yxBqFor+KDIIKV7xN0FkDM6RvKPGNl/Zhz
         ODz3RAJskXhmSPQAuN2P+eyvaIFvNxijWMGwWXXC0lP++BqRqOWkRJlXJhqyRbG1uUYR
         lZHw==
X-Gm-Message-State: AFq9FYJhY4Qb9QR6kxnJFCjlB16AnsRdfBoO+mvRm17m+7zUmvOEN8ER
	5m0zxv5xNk0WYMz90IN1ax+kdJz2SnD15Rl0sDABacQwSUpZOYiWdsrGBk+RiB1sXjQOkjRUWjp
	98ewSVd8pJBQu5tx8cBVZWKZwDqMbMEcAvPtz76vRbAUNjAWYShJtMuWE/MTdU8+EOtRNIWKw3O
	0HT9Pj0/Ue2/cr4q9oa0D4Bioml8w4mW5m0g==
X-Gm-Gg: AYBFou3zJBtPcIc5XAXBFnmFNK3JVmEobkrMyZme9j5bqXu7IliNj2k55hw7KsR/KVG
	MRWYDolI3tHnUgNnSWznxD7VBfvbM8ShJ+CyJTgEUaGo2Kdb3fcggdLGF+pDd6ntQH8K4oH/bsc
	abzjWKjgFJnFK5iXHg3M+eAkmsR28ow+960PMjnXXvV1nOEFJ0J3QFcPpjYRVz2NhUsmyCzZg1E
	FBTC2yKAsGQoN+/u14RYpPCR/yfz1bhNykwCGhK8ov+t8HID3enAQwR2kxwE2Z7GwV6+W7/vrmW
X-Received: by 2002:a05:620a:2987:b0:93e:5247:f61e with SMTP id af79cd13be357-940ef8bbf03mr1381982485a.25.1793100118320;
        Tue, 27 Oct 2026 04:21:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:93e:5247:f61e with SMTP id
 af79cd13be357-940ef8bbf03mr1381981485a.25.1793100117860; Tue, 27 Oct 2026
 04:21:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023174113.2388353-1-peter.hunt@opengear.com>
 <CAFEp6-1brLBvgkaNK7bnXfGwHJkF_sqK4mdc2zaVuLw3_4+djA@mail.gmail.com> <20261026154056.4037990-1-peter.hunt@opengear.com>
In-Reply-To: <20261026154056.4037990-1-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:21:45 +0100
X-Gm-Features: AclHuK-XCRpxCXE4QFA1aB3sdX4dMBT48mjuVvVkCJDDEuaqdwo7ZIEIFXDhQB8
Message-ID: <CAFEp6-17DD-4mOaD+r060WYfpvkF_fERnUiSE-fA+kSPXntazw@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: mhi_wwan_ctrl: keep DTR drops and resend
 state when IP_CTRL binds
To: Peter Hunt <peter.hunt@opengear.com>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Daniele Palmas <dnlplm@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXwPpJlddayWAH
 CA9yI8MsGi4wLIQnhhEhqA3i0GV2cN5LsUbLg1e4X9s0cmOmKtgZk3HZX/YEePnoWgXBrJDhz1Q
 bzsUUw3oCWSdhScx7yfyjkOfGRWhGj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX+fZ7a+Udiyzq
 SeUp0+1rUMmYNa3VJRfp4yNA/l+lxj45kdmi6w+aYfrwheUxpxml9mPQGkPCBsRf5fjPWboygzb
 q5HPjfPuYFepkbFYTDozw34KStSA4OjbJqLPaEMqQn/qsz+RKQptYn15tuyPZ4qb+JTn9lpcQSR
 EzYkuGjxk3rRYHXh1DgaqBpj3zeKdYqHXGmhq4JFvzPCpbZlcTotpW5J2+oaTMRi35e5d0B2UGB
 WzMnMNMpzCW7FTVbXDJbQbSTTNW5eGH5HQ9vdcvc+ipotUwH3qcdAhh13Y0+xNeCdxwi1qvQlOD
 Rv38E8suCVGHyeW53vDtgGFF8baf+Zn0asSN2arXmBrR5J49h4cY8hCJxU0RJCmHvo+WEzmQi3j
 c/n+zCMkrNAJKwyrvP/ThVd01fhSIXPdYY0eI1EH/A5UIGMMHRqnGhHs99PtcpHY6RpSt8YKUF3
 L4UWMa+FrW9izY5QlAQ==
X-Proofpoint-ORIG-GUID: 1PONEuhiVWVWYXmjPeBcgy-PavB6zC0h
X-Proofpoint-GUID: 1PONEuhiVWVWYXmjPeBcgy-PavB6zC0h
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae08957 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8
 a=EAWOXMPjoDnuF95MvPIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270045

Hi Peter,

On Mon, Oct 26, 2026 at 4:43=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> Hi Loic,
>
> On Sun, Oct 25, 2026 at 3:27 PM Loic Poulain <loic.poulain@oss.qualcomm.c=
om> wrote:
> > This looks a bit over-engineered for the reported Sashiko corner
> > cases, and adds quite a bit of complexity. You'll also need to handle
> > the lifetime of dtr_work and ensure it cannot run after/during device
> > removal.
>
> Thanks for looking at it. On the lifetime, I think it's covered, but
> please tell me if I've missed a path. dtr_work can only be queued from:
>
> - ->dtr_rts(), which the wwan core stops calling once wwan_remove_port()
>   has cleared port->ops under ops_lock,
> - dtr_work itself, re-arming on -EAGAIN/-ENOMEM,
> - mhi_wwan_dtr_probe() (new in this patch), which only walks the port
>   list under mhi_wwan_dtr_lock, and remove() takes the port off that
>   list under the same lock first.

Right, it's handled correctly. I overlooked the disable_work cleanup
in the remove path.

>
> After that, remove() flushes the work once and calls
> disable_delayed_work_sync(), which cancels a pending retry and stops it
> re-arming, before the kfree(). On the IP_CTRL side, the work only finds
> the channel through mhi_wwan_dtr_list under mhi_wwan_dtr_lock, and
> mhi_wwan_dtr_remove() unlists it under that lock before unpreparing.
>
> > I don't have a better solution to propose at the moment, but this
> > problem suggests that we should enforce some level of ordering between
> > the MHI devices (channels), or introduce an explicit dependency/link
> > between them.
>
> On ordering, here's what I found. On the EM919x/EM929x IP_CTRL is
> channels 18/19 and DUN is 32/33, mhi_create_devices() adds the devices
> in channel order, and module init registers mhi_wwan_dtr before
> mhi_wwan_ctrl. So whether the controller powers up with the module
> loaded or the module loads afterwards, IP_CTRL already binds before the
> AT port. As far as I can tell the late bind case is only reachable by
> unbinding and rebinding mhi_wwan_dtr through sysfs. What I don't know is
> whether that's worth an explicit device link, or whether other modems
> would declare IP_CTRL after their AT channels.

Ok thanks for confirming, for now I think we can safely ignore this
corner-case then.

> The DTR drop case is different, it doesn't need any unusual setup. With
> v10, a back-to-back drop and raise from userspace (TIOCMBIC then
> TIOCMBIS, or a quick close and reopen) was mostly coalesced into just
> the raise in my tests, so the modem never saw DTR go low.

Ack.

>
> So I see three options:
>
> a) Drop this patch and leave both cases as known limitations.
> b) A much smaller v2 that only handles the drop: when DTR goes low,
>    ->dtr_rts() flushes dtr_work so the drop is sent before it returns
>    and a following raise can't overtake it. No new list, flag or
>    field, and the late bind case is left to the existing ordering.
> c) Keep this patch as it is.
>
> I'd lean towards b), but which would you prefer?

Yes b) looks good to me, I guess you can also flush dtr work
unconditionally in mhi_wwan_ctrl_stop as well.

Thanks,
Loic
