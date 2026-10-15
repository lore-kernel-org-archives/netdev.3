Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370A552932
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.150.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083498; cv=pass; b=dIdCxfFdhc8EcPWold82kREB85hCzgD/IaaMfuxKRUiINXe2Py8VRwqx58OJDbjHXfHNVtGPTQ7YuU+rN96L8cTs/6WatRl3CrRmu795KWIzqyU41XWHRdLRSuFowzk6mCzHPAK7lMyQqG81p3yjGWkPf8XshLiShDFNNJH6Tec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083498; c=relaxed/simple;
	bh=5SvIsi7SBbQT+gfq4uEUynEUgBhqEiqCCRbjzgQhmF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZE3649TTMQJvIa50FhBG/h66huwflw4SEBPPYSUkfAa1m6h1IvBAMZA8Cp7sHZhkyKljzSHSH8DCiGs+oQct+dy0noAXNLUFQBGu4BUijU53Ya2iGI7G9lAgNAexN6+NaeqjKSDDIVviE7GRbNLKz67xK2Qpyf3fVmgCDwK31Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=TbCtNgZ5; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=bBmUaKBv; arc=pass smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="TbCtNgZ5";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="bBmUaKBv"
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FGTJhW2641858
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=E
	WnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=; b=TbCtNgZ5pqfGfWlB2
	tTsfdWcTYueTaUtyJr+orPiDsvFGfaS69yMaAWatqFLx2NtKrF6Zu13UJ01cq7Xn
	V3+H2PDs9qAVotq9eL2qLCx9fJ1HScrXh9f5EkfjMkjwQ2mRGzTJsVQSwV2bvykH
	Yc28NcSRAYqM/ZhW2nF1yxIpjIAAGrsQmClK1Hp1lSjbo5e3Wf2mW6OL1jEVyL6k
	2YZWh5Y1bXRyLRc6YMfhtxepxtA9lWLuPqc5ONgY5JlN0/9hhyGzJaCOW6mAsFHF
	EfJ/FFUm+0DmLQnnDmL8FFPT/uhn1xhmF3AwpWVrTM9p8qnCIVlj4h3JSsbGoRuo
	CPwsQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hb05j3y6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:58:05 -0400 (EDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso9704296eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083485; cv=none;
        d=google.com; s=arc-20260327;
        b=rnHvwQPdL7vVO/Gn3PuZZ5JYYC87OChnC11RCnYqWoND6uheuaT3ie630Jxx+5IzDW
         +YGaEgl1A5LErzEIcD4tUzjIwbqqnLRphCYnZuoumSP/GfCllq4JUaRtvqD2ZZmhQDJo
         26FknswcZqeM0nX31BXHS4LB4RYDNW1jby9tBO+GlUKdZru/n/0Eof3tEQ/2v1VaguMh
         +9hvjpW58qyT41ysdVtN4DX8yEYN/H+h/j93D9wk1NTFI/u4cPQrN5IafMzTZiD1a3zu
         N/42ctlezatUCn/fuB1t3rejZs16TmeNb7QvZ4KgnXwMAzhsnwoCoKbZdTMZNVtqPtEV
         1PcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        fh=fz9f+0RPYGgTDBS5++fSGesT3w/5XsNgY6PolXjK14w=;
        b=e3yjJ9yS4vk19mmWQqQdGVXcKM2/fToGsd4YUW6GT1/6Hw3pxQF99j/PPBpnrMmrb6
         sQolbTcNDhEQKA7YKR1wFM4CfyxeArUx5c0/BNmDX4pRx7ozniR1Au8mJo0Oznqtiyri
         V04k5HVXTjv4CBavPnLjmsD/u8BD5rej8AJ/8Mqn4jSbvR1RIGFkkuDl+MS4XrwnvoeY
         UZ25na6OcbBbNjfVz0C2swOBdwyGomnf62vDqyXDgMxgZsW6qI19ozGW4iLEljFpaXmj
         QDUQIgTqcdhpiXAHo2rZiMXomqb/bUEFkwcDXOVwD/NimgYckXSAiQyQEPy/9kUOUZbd
         78Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792083485; x=1792688285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        b=bBmUaKBvnlJX02vrsVg2r6HZCYmvG04U7c3pBVLhhsVpx5a5hhvevfTvwMM0AwqK6i
         TdKh63hypbN/DA7c8gSh8dXKFpZX5k9kgxy2MceToRIyf04p2iSzlos2BKa3ttUBZnFt
         wJhaFyIa3FEijd2BJTs7spKJmfznPWJ2Gbwg+40O+w1Qd4cEhjkaTEp6C6o4ur0+2cW6
         2tSjyZHIPrfyrCDBIefsGcZ+sSEnHMWRdbfifiwGxWPsX2x9yPLDcXODFYoEio+jerkv
         qe6+pd47PZkeuO11i2EAWy5hKEH6sx4GueLZ8ke2ggSocfdMcyAxhAI+pY6NGDefoGCr
         i4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083485; x=1792688285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWnJ+H2sZYoV2Jv8w7ejHJBb3pXYIPz2WtL3bUBFqA0=;
        b=xlnTcHjW7Syn1qeK1YEcb/HIxDvtuzbA4CDyOzesDdokZeVsrlq2Rm/xBuOpZujrt5
         ap3gc3Q0Oo5mPtJQANOQ7HOP2iD5En8xHsoavL0CwPHjx2pOqi2R7fsQeIpCEA9fa7v/
         H/wsqi8ZJNWM9tFsDuBEzPp3iLcEr6Eye++M5QELyEPNIaik4YA34z1k4FYlPI/GvwYA
         iwD4beQtq7rEPGV1/7g1IDXFtW1Wd/CTbKwKHKzbp+zao4uT0kl218hrNj6SRUgqSiYO
         wltyvKUFS11qCO2vI8n5dq5pzgtIqBv2JnP6zk2NFEx9lFrRj6E6VGJJfyfTBP2XevCP
         //fA==
X-Forwarded-Encrypted: i=1; AKwUvBxA0+bbCPSMwu6mVceafQkL06BZU4yb0UKHRT5Q3UGYOi2fSSbXKt1phOBp6E5IGtBAk9UIRLQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAU5W4C6NDqAtniMfNSRjItHjlmyYOT2qmZeh+jEU2NVnvDKE2
	WDjdoCmcvLT/cW6+fHRyQa4TlT539t9bIxLI4uIa3fKvGaTTXvIGaEuDNx6N3dFohTpZGRCdHN7
	Dp4hUr49XzhW3S+0encGgy//VFQqlLJe9LBglS7HYItxunt6YRNmRM+FsHwdkhReCGlF1hGIEHK
	OBaMaZkoGmGQIoTZKE7LAJrfAsJyPzLQ==
X-Gm-Gg: AYBFou3jbTeYkbanhwOxTujhEiPpfh2TQzK/ezNQNBMsnnczyBaoJgzf2Idh/2F+4sn
	9i+KLLsgDHXBJl2Pc4N6Q4DJj9hLTnJgayspwpU1dU0nHM49jAvEG6k67emrhL1SqaK4FT0nWlM
	3iirGqoa8uG3udKcVgN6zzdg9+/JI09h2GdQDo4ybNJovKFsiR5rYUtf0YKQ==
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id 5a478bee46e88-35cf6678c8fmr10408708eec.6.1792083484437;
        Thu, 15 Oct 2026 09:58:04 -0700 (PDT)
X-Received: by 2002:a05:693c:66ca:b0:35c:f667:8b9a with SMTP id
 5a478bee46e88-35cf6678c8fmr10408674eec.6.1792083483848; Thu, 15 Oct 2026
 09:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain>
In-Reply-To: <atCf_85Ei_J9CDtd@kwain>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 15 Oct 2026 12:57:51 -0400
X-Gm-Features: AclHuK8axhoL9SJOQPtXMgXZpb7I487EoomfVtbK9W7aQp2W5VgW_o_At6K7uXg
Message-ID: <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 0kjhU-Dukn2itiugfeH8_3qnMuyW2zhH
X-Proofpoint-ORIG-GUID: 0kjhU-Dukn2itiugfeH8_3qnMuyW2zhH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX8457jBTAkylu
 y72m9uG7svDZDObAJGytKqb/fTz4Zh8dvE9jIIRp0c+lmCarSB1XWG7KMxh7HznITBcQ0Lwl14z
 TBLLZVAXtkhwt0686lGJuMt+lraPAMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NyBTYWx0ZWRfX62lr1kQfY2QT
 PYCQ/hDu77fgd44Zb00ChoVA5R2wUTaeDmgf9EkTLpisu586lAqqGgbAUR/VRf6/emjfFHLhpKR
 HkiSD0siyI1n91kNND+lGq1yKynO89mVK1XQq2Ns0pmmTkIM8cZkskNaVM4q39DF2F1s2oWEG7y
 zYoiAd5ieijQrfAgih/NIDj+kKQQhnCBVXVp25OL2dKUyjHrqvJ54FXWnE8BK1g1byV18o9ZCTR
 KxoXE2quydQXzHminNLmhZANdy66vkxGXah8T9uJDpahc6R0sx8776UTndUXNN3JP8Z8+Y3j+zx
 DF1ArO3S0MVzGUhmmEire/VlvcCpcg7LDSdZlaiqyW6YRnLPwvHzli95EVvuCAh3RNXb4IsQzR3
 8VnjwxPKiwJVdcBbRMZ0YQEvii/9kTzq08XoBVB07IQ0DBUNQH4exQRZW3V6Gjoeo3rpAjnwZ/I
 jxNkZTlF+YWUmiz9rhQ==
X-Authority-Analysis: v=2.4 cv=L+aI0OT8 c=1 sm=1 tr=0 ts=6ad1061d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22 a=VwQbUJbxAAAA:8
 a=hKX_YmtgrgkOCiSBCTgA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150067

I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
tcp_snd_cwnd only would just ignore the problem. My current patch
should completely reject the user from creating a socket if 0 is
passed for RTAX_CWND.


On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > This could lead to division of zero error if not checked properly.
> >
> > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > Call Trace:
> >  <IRQ>
> >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/=
tcp_input.c:4440)
> >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
> >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
> >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netf=
ilter.h:319 net/ipv4/ip_input.c:262)
> >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:=
492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./i=
nclude/li)
> >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
> >  __netif_receive_skb (net/core/dev.c:6410)
> >  process_backlog (net/core/dev.c:6761)
> >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> >  handle_softirqs (kernel/softirq.c:645)
> >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softi=
rq.c:758)
> >  irq_exit_rcu (kernel/softirq.c:775)
> >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discrim=
inator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> >
> > Fix by checking if user pass in zero as parameter,
> > if so reject the value zero.
> >
> > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
>
> This looks like a refactoring commit only, 814d488c6126 might be more
> appropriate but please check.
>
> > Cc: stable@vger.kernel.org
> > Reported-by: co+71b6509cb791e531@bugs.sh
> > Assisted-by: LLM
> > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > ---
> >  net/ipv4/metrics.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index ad40762a8b38..e83a129a25b6 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >                       NL_SET_ERR_MSG(extack, "Unknown flag set in featu=
re mask in metrics attribute");
> >                       return -EINVAL;
> >               }
> > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater=
 than zero");
> > +                     return -EINVAL;
> > +             }
> >               metrics[type - 1] =3D val;
> >       }
>
> My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide by
> 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> tcp_snd_cwnd_set to not only warn about invalid values but also reject
> them, preventing similar oops?
