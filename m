Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904B13D16FB
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.150.240
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273938; cv=pass; b=dMNHFyoUFCtz6XGIvu/1S+8/BSBf1OiYkRG3WrEaWLfaHkmUKgCID18tzaPVno2qx+UQX2tCfiBhn5HaJYLY3jcLWG+EQuS9kXxhUMrhOu4nqxtBlCFNaCugVSsgFojlscTA5bfQH62ePqLADVXl/lMDsPylc8AsMGNDb2DNTHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273938; c=relaxed/simple;
	bh=d8B6iYTbhPZ4eQhHbMclnxqxpRbx9Q0XEc7yVaOrrpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auqM6rXDb8OfTGJBCmGiANFSugwkrRHs/sgYCx2WixZRpZDqyD1S1XQS4Rlx943gx6iR/cRFBS+jljwNiEg9bHxIpiKJTGJkwfGbaYE1IJruTuZCTFtZ3SXIOZDN5GkK4TSyzvXAciArnUNdTtMw4rHPQXhwyes2oW3eElRHV0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=hmE9i7Zy; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=lPN/qBNM; arc=pass smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="hmE9i7Zy";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="lPN/qBNM"
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HFi7pp3689164
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=8
	qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=; b=hmE9i7ZycV02BfcjP
	HkDp3dloe3OyHmC1Fk+R34beoPq8p5iKPRXyIscXZXqM7RiOOR70OS4oSzLDHmQU
	8yuH0mLCQZ9+/unn5SYfpDiHbOWIKPIYvdzOb5BaZRIjyZRfIoadh79pxCJ7P9zQ
	M1FeuUlEx4A48kiQDGcaLeozjbDkCP7vvTCX8VtJBnl1k7rDgIrzO8aNOob41768
	ToEAGFSgOS06zU2fzsqxzMpxa3mMByIgmeS2MHPHvpI9cdej2uh64rmp90kcXdd1
	cdE6GvwJLTl95m1IfDFkBei08WbqRs8SB9viHHglyd62uMKbR85YNIc8Oho2TX4l
	TMwEA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hc2bbyrq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:52:09 -0400 (EDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so1189610eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 14:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792273929; cv=none;
        d=google.com; s=arc-20260327;
        b=F3O6OuJnXGI0rjCrcIlARIMcQCa3TrGsHte4WEDU/4xxnMSjsOR4VRaxi53lFXazkF
         m1z2BnbyN6zw21MKe6Lzm4siWALYs16DqNxGyaoZTG19oRQ6yfTQWje9xlJ5eLLNqH2a
         KGRYyXN1GUmjL/JG7YJ+GFclD6N3EdIr2TZQ3SOrBrJm4k22OAXy6Pol7P3VPwrko+XO
         uYY8Xst/je8NpCRAdJSV/43JIzkGUEKUyqLf4Z4Pg8rr2h0LLKTp4Vo4CS4yYuhN/bO2
         Af7oY6dxFIhLjoDAcYdfUWjvPuq/xZux1jTdD/Pmjl4Q2jRyG0TsjfBkN09Zxl5G93wW
         CrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        fh=GeeGvy7aau0omp/HYP7aao/WX30nDVSc7rG+HupOejs=;
        b=GUhGWJO8B8P33obZRxq2nWE+IKBOSHC58gKJbTlNMudQS/9PHAn6OOlzTN4sFgWTtr
         SbLezxjaMFkC0tllwHdkjnPBLK/5CkQhgD0TaXGcG54WBtZcQydyncQTy4P0OMwE9Eg0
         /QWtajdZ3Mxuxk1HM8dw9nOBvVbyJRv5N9pVQy/OXDDedKhIT1kigSZtgISWpTYr3kFb
         xKMk1/meMQ0pojNBvY3kzBNF3HwbmP1+qCsPJJe83Z/WQVCTzDFa3lCEbvqxK0vw7LZ0
         U831H0Dl8z+IQaTtEetj5MbleGRpRLvVH8MeMiv1bw7vSu7GL/J2rWqlFYvN5tJj+6ei
         M+rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792273929; x=1792878729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        b=lPN/qBNMb3s7F/uEvK7v2u3wVZmyOWknoqR4J1UH4O3aEr4eE7EwJzv33Nhr1R1Clo
         +f7grPHEa/xrehMVdyb02DZnvj9v1y4k6lLYS9I2+NmAslczRwtAnRQhJba9Fu38JD+8
         ReXIlY+HVGmiA5BU4GgUiMsjJBaDgzMgDuq8DrNQuf4iIti65XmPNHlMrh14PpDONALJ
         SCh6TCFYNzLi87JjHEhfi/SvshXAFCTwykvElfzwK/lrt51qZWKJ+9k+De7kZ0mbc6o3
         7NWIldeeNvxsL3NT/62EB2a+3NtvC9yTk+Bok5oCWJ29ZPFupyZjxIcAic2iwMe5F52u
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273929; x=1792878729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qt7LuF8GRgjS8yzBLI9aYUymptt8k72tgwjkn5uLH4=;
        b=GgtPquBWaEw0Na2FWCqg6IopAhA07/cgWHlN6kynslY7y7mZvTy1HLuYuP3LsB99S4
         JeLkz2v/qyShCaP9J9j+J6uYgyo0l/Y3FgKlUfDs/opHqJ8N6Fq5WKFyNK9hr7/fL+8o
         CyGDKQTtwVVMiQAfvqm3kHgOLSa9vJ3c401ok46Rn3NPlhtej+R+i5CcCL6qVPtJ4N63
         onrrxlEmVS3KlRWM79kbou7dRLfjpxV8V6cDvUq1wLsGlMHULgKfB0HWRy9+xKa0YgNH
         3SjSgCUTVNkY29Y9yQXD64Bpy6K9QVWS5tn5qwe25sSFga3LzaetYmnTROYLO0QilOtm
         ntkw==
X-Forwarded-Encrypted: i=1; AKwUvBxK2yLzLbbgA3v7KFQVw6k6mIeX8BGrj5dJp5ngBn3wXokYP0Mrm8RAlOOgeZd1lzVLG9dgzhs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPeTPbz2J9wrmJ8Vxln/A0HvsuWFf+/6CFqaP2RCi/6CIjivPy
	uDzyAPxU/mOR/H7tGTOrajrM+L26pqlxY/4yA08t+17xB2wsJyvN7JrFIsniWTyWEyQrTH5nNyD
	GYcswCxHEkBWdmih4FIbj2oz9SJM52EDPgmjAHnW9EHw4MBhWXP1CzspEBp/uo22FzF2Jf2zalm
	VgJKU1bjNx4JIFyHIMvuPInr/FWUVLkg==
X-Gm-Gg: AYBFou2QD6N8s4Qv2oUpAm+77NjgjWgjfChJu1Pn61TTa8DNt6mJdJmQP8rqFZmYRp/
	B5ihRvGjH96pDfPUxDJEHoIhVAtChh41OCShIHfzfjVUjr7gPlQ2r7N9NRLJfDd/jaugxWNXtmU
	7OjRBSydX6wPAOpcL/sSoOc0NRy+ejlxrlstP+M5BL9gcE+8pDKHs7ic1q+g==
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-3602e3a6861mr8093129eec.14.1792273928988;
        Sat, 17 Oct 2026 14:52:08 -0700 (PDT)
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id
 5a478bee46e88-3602e3a6861mr8093109eec.14.1792273928367; Sat, 17 Oct 2026
 14:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015201549.4023-2-kj2864@nyu.edu> <atMFPKhON1IK5cxc@google.com>
In-Reply-To: <atMFPKhON1IK5cxc@google.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Sat, 17 Oct 2026 17:51:57 -0400
X-Gm-Features: AclHuK8V8PqtlumCUfPitjiENks2rIhGVpjBZixB0b_eQMRRbzEBuswi5lOYgMA
Message-ID: <CAPqbLS0vsCAPqoAwqZ=HSCqfH4SigQTuv+dn_ByED-b2ickRXg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
To: kuniyu@google.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX8SOAq0ozoppp
 Lu2/PEfsJFD5xkSU4N0W0t020/qscX6kjTFxSfOFzESxmbiJvO3U2RwD2G02jkpXEbrElj7KJOi
 J8CA71Ee97KLdY84OjmIQMECgla6vPQng0khbv/bAhSHgeRRaw+Bx/4d4VEzLXTtY3H6rFtYaT5
 mOakL+UEt3mWvMoC6Kz7O8U5iabDDGphaQQH0H87S1XXt9+EFfQ7XINTL8qPi6Z0LV/kinXs9G6
 PAfsoHoBekOd4XIohkQCyzwaPo/nz1OvcOng1n3+rCPi82SGSrItJtAnFlAx64vCf4kcEdKiuF4
 WCVlLORiyUWspLP9ayX63F36coTZ6CisRCk7f5wgx3wTRwckZv/Scje17LYUwZDmStlWuFXq0e2
 /skLdpgPJddO9G6vb0BYTYNgBRMIRH4eyA3woM/rPZeJbKguzi6FT2xT6IPyicTqJlXaWflHWDc
 UP+ku0BtoX++6i1odhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX8HRSs+E7lMQe
 SBUJF0vAXv+jNg7kdPbwQ8K8SKbXGY1LA+/o7khqtcM6TKqtXqpgdIrgsNl9SOIUPV0a7Y3kFIA
 bVynzawY5RGYRvpUaEuJ9gHx1ItP72A=
X-Proofpoint-GUID: 2GUkEVxBsMPoVJZJkK4zZz6ntpl91kDF
X-Proofpoint-ORIG-GUID: 2GUkEVxBsMPoVJZJkK4zZz6ntpl91kDF
X-Authority-Analysis: v=2.4 cv=XP2l2ghE c=1 sm=1 tr=0 ts=6ad3ee09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=CxnIfPQeirmdGRAfp5MW:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=LDwnR17CkXKMPNxMdHAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170087

I've made some further changes using suggestions on my v2 patch and
using !val. This change should prevent all future errors regarding
snd_cwnd and snd_cwnd_clamp being 0.

v4 has been proposed:
https://lore.kernel.org/all/20261017214845.28769-2-kj2864@nyu.edu/



On Sat, Oct 17, 2026 at 1:21=E2=80=AFAM <kuniyu@google.com> wrote:
>
> On Thu, 15 Oct 2026 16:15:50 -0400, Kaho Jiang wrote:
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
> > Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch A=
CKs")
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
>
> While at it, please check RTAX_INITCWND too (although it is
> ignored and TCP_INIT_CWND is used), also use !val.
>
>
> > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater=
 than zero");
> > +                     return -EINVAL;
> > +             }
> >               metrics[type - 1] =3D val;
> >       }
> >
> > --
> > 2.43.0
> >
