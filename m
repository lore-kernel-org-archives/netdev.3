Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627242;
	b=BDHld3u3X0JCFIhuIMviMyyu5AKyeCocrJ8vogvKwKrUG//7ZSKT+dlf7FUfFDjzHE0H
	 FCkr+PLd9uOI37KwEamSzrgw6nUuh0sRcgesfmbJfZy4xEPWI6DdFMjMAR9rbtLHtmaJJ
	 ARp0qI1AYFICbVSveswXYNxjqZew95W9WkgD6EZhkPqlptAyjt6MpGl7hXTuxJQJHUVQY
	 u7RRQ9uVmbWkdCBuWElBWAyXNlRsLugqBFeW7RGwwP+LlWb7Fq3daXcVtPC3GydwCsvtA
	 Rl7B2aHZCxF3IUcLp17g4sJRQ8PcxR0n7yQ+iX0h5mTsHmM30i0NEgGULjYa98Qu5og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627242;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=f27jOrx+2iM7UtzWtFrPeRbcgZX5eHDK4Ztm3dKDBiM=;
	b=MHWFSE+nV3KF7A2ITKozUCshykY7Rft0NLgtz+2DlWnTJLTxGE7xm/hhj2dQMFtj0xhX
	 04RwpqXBBQotNn/LD2DPz+w+uggJie7XXZQQxo5Pbv0MxWvcKO7TmXyWkf/azZ90Teg5E
	 fH4Ca0aDEbjtLN52z5UO0tmyyMxePoZ6UPjbHHZ03dEjDE34AfNbsUzXbtejuognJXUn+
	 HPD+VME6wU3E1aIcdQwbvY2opNgFH21arkoDJ/me7x9IxcjwnuZfeNxnmpi4Z2K4AedVc
	 NGm2xXwn+ElxLihV3ZWYPCAuHrU+zU9mPBLScKxE4Ri22HAROQoIjGaCi2CDxr8bAkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Rw4Z1DEc;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=XJUsvk35;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF7606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEF7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Rw4Z1DEc;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=XJUsvk35
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKEsB23070033
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=f
	27jOrx+2iM7UtzWtFrPeRbcgZX5eHDK4Ztm3dKDBiM=; b=Rw4Z1DEc0d6UsDsfI
	taY6uBIYIqE9DxxQmN8ts+5IvTf54logVjt2jGfAqY9AWjp3yG/trvGgLDpoAhux
	sEuLFqdsQdl3Y03TX7gww9zSraXmlQSFrAMIGARzyynom1aRDN/TOJ1vmCTrjiO6
	BzomujS/dSwxGMCerkHc12rimg9lkQFYc9qq0+F/r8S8r2J38ZB59L07W8l1NqGY
	UzpxMVHWnsLz5uH0I975KQ6nQXNh0pDUlyuaNTT2EuOArqIRpBXcxSTMVgkcOCu7
	9evI4Xn42auLA9I5ihEgJ9U+VPMMESbReayvH+wFtoXlBDdRW51XQ0HfZWhXu9HG
	MbyhQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hf48vaxht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:00:40 -0400 (EDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so2961877eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792627240; cv=none;
        d=google.com; s=arc-20260327;
        b=jzzd2vO+CfKGo/yYG2N+yph43HjVelcHouyTi8nqItEcviLmWIpGZp0345aaVtrY3O
         kh85mMpZmLw/UTa4Q7cNa7W1IJhmckcHtNCzyLbiV4lwa3+XX4vmdyxZmU8y8ytnVdKf
         HK+mbpSN0R+0jdjcqpa5Y8zQvUoO73wRVchaGsjc9V0UvAfVsOHPNtrpO1OZIvzcwal4
         ptw5rW9olZQ8gkmprRNk5tGjyocr8dXdzsICCaXTnQoM4EPopNhh7NWaX89Kf8w7dVih
         /TYv9krzz3Of1SrMDzOYboJu8tWLYIphhsbsuM86LjhTyGN+1daYVe8XBo3U1/vxmaDh
         jDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f27jOrx+2iM7UtzWtFrPeRbcgZX5eHDK4Ztm3dKDBiM=;
        fh=y7Q06i8okrF1XN/Yo2hzOztNdFROFyxqf0h+Rn4vjVQ=;
        b=kSuGg3mV7VbM4zP+1hpowDgHRwH4ncvRja4OecV0OavT7WSfwXimxMsOZ42G1g16AD
         s94pxLJO8AJKgWLwhLMX/HRu24Ri8hnKp0JKe9GYESIE7dIbml/efQ7FopGkJKkXwJpJ
         JXWWb6HWv5PxvY2aQTrUOUDgYJe99pxqCyx9k2bz21NxNrAscnUb10JeXnZf7nlcVuuE
         VV5cq2ms+Yh0+t5lj4w5kberyJ94aLIMtM4WelGOLhCQpIjZsiusxtfN/XYYQSLWx2iD
         4ohrMmYizM0JeY0ixLjgtwAHpKdkZx8dS05Wa2pVCCRpAVr6QI8C9NySbJ3NCkfle9/R
         3oxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792627240; x=1793232040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f27jOrx+2iM7UtzWtFrPeRbcgZX5eHDK4Ztm3dKDBiM=;
        b=XJUsvk35jYYPwegFz8zglN3SaDjOxIQ3L6tQMhHVqQJaiXcFnJAAf4vtFujQOO1gr3
         BMBR587OIXwaYeCsEFsuKL0lJdPZISorFlb1I0Dm4aDqF+UiH8labwilblnL1/47yTv8
         5+ADMaRqAEpl6DAx4s6bpW6uup+A3cxcTSLpmcL36AdYD7bTvO1KOTxJzciS4f/Maisv
         KLV3RMumcuoMLvdoPQLGEWeATXYeTC2AXDxXTy5oKoasoSA1DJjlyxBftXwwMPqsxyz0
         sBbiNecJpdFJvxbJDEES2Q5Lk/QiY+oE3rC+QIO2EQH9yB8DBKpw9qv3NuWI/K+JeVne
         UUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627240; x=1793232040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f27jOrx+2iM7UtzWtFrPeRbcgZX5eHDK4Ztm3dKDBiM=;
        b=SiJivqka5omyOYclk7fytMKuTu092pIWdAe65Zx0QKepeWa0GWCBMXO615i3P8ISdv
         AkeZyBEsOd9Qo1jLu4a0LnFf1fuq8xFE53LUI3ISUFcLke9K2EqjeZ3AHEdD2haJzIot
         I3GHiMImqvEdldgxzV9Cr2xAA665Kn9fd52n9nOC70GTwyRnfH+GgEXCFIc9HgIpbL1/
         3H2O2h0FXP7P6X6tCHT0JhCP8DkNrND6Phj0LjT8w9m0nnoYTDpQjhvjtScExZesyrVx
         p2NAtYF5xyTcMQ0ha47wcMzf+Xkdop/rVgPxeR6o6j+5cuh32BghXxPLZxzkq9QrHe0h
         QI/A==
X-Forwarded-Encrypted: i=1; AKwUvBwraW6uNERlpeP+JTXjfCkSUwD8sMlCj7KFgbdb2lfwZwTbJ208HqDHGi7ZcWcJGdnQsBn18Wg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKq8GtmPA9ViDUa2HD/36J2CPBpk1yak/sahhuw4hHDlW065vw
	HDDmOi+mj8XF3AE2F98I1/CdYl1ITIZXCdrNHOlECLTQGhtTMBYggTSmunnhW8O9rtAuygy2T4P
	iPS9P6mDTOWL4VjcgN5f+Yoj9Y5boSPZRUGoCWAunCoYzeF1E0N2oZ/+70nXdHBvY32cfLWXs8E
	hnQDJt+6PHJEEH3O1pK9LbCwLv7pv3SA==
X-Gm-Gg: AYBFou32Q7ka+xZJReTOTBB13P1n9nGdfT9ue2aZb/RuKvdWUizXN1eLbvCORIs2htl
	O60tgbWlc35SY0JTfI0i7VzBQxmCJvy723kGWGvBsON1p2S++stWfE6ZCLKwuGRSaxKgRoOojJD
	wQgEEeqJXsl9ezl43wTG03WILKqtuFwHXqSNK1WYfsq28+QAEWuYxxWGI94g==
X-Received: by 2002:a05:7301:1525:b0:35d:97bc:234f with SMTP id 5a478bee46e88-3674cc36af9mr4891143eec.20.1792627240026;
        Wed, 21 Oct 2026 17:00:40 -0700 (PDT)
X-Received: by 2002:a05:7301:1525:b0:35d:97bc:234f with SMTP id
 5a478bee46e88-3674cc36af9mr4891095eec.20.1792627239257; Wed, 21 Oct 2026
 17:00:39 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222531.1073-1-kj2864@nyu.edu> <f54da1f7-4ee2-4e19-b95c-c442f4f91a31@kernel.org>
In-Reply-To: <f54da1f7-4ee2-4e19-b95c-c442f4f91a31@kernel.org>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Wed, 21 Oct 2026 20:00:27 -0400
X-Gm-Features: AclHuK9xCX4KHQvk1uZTH-lfO1gZWuNqKoKZuPwAgRj3lnFUTOasdxdh20Fqm0E
Message-ID: <CAPqbLS3d0PHi=oQx_4VA0GLJgcP1UOgYzEgNKbVniqFm9VrV4w@mail.gmail.com>
Subject: Re: [PATCH net v5] net: ipv4: add zero check for snd_cwnd_clamp
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZUYw9_eD4m0-F8839T2xC4q7rNkxM4cK
X-Proofpoint-ORIG-GUID: ZUYw9_eD4m0-F8839T2xC4q7rNkxM4cK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX5xupkWH2G+p4
 3Yu1dtHlqL6UUh8YW3d99YFu/8EaibRujk5GsoLziTRA7A/f2Um76A84h13RgpfXnm6SDyBd9Fs
 dxYIP8D+ixF3TnianrdV0812VdH704A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX4YU36uXzk1Rn
 NhriVYNQU0qg+mJ9M3psg+2Uh/dBKV2qkk6F0DnEMLegG3oGSllHfifdIG7SoztUiWRQ8/9qZVa
 b2ZR9sF/kWDfWeGgKs7DCmQlL4Oh6itRRKCJICyM0Ss1NwOGV7jTwxo/hmmieBvAGPCei0iYVz2
 WmWd3lV+5a+B8cz3P5Xb8p40Uac5/jntUhHTTEYdAWd4xIQvpKHwVF/QbazElaIsJMuGuAS7UkA
 RIoNHJEhoNvEq0umwV9RrrdtBklUNegkB1CqVlwxiRY60gUQaabGNJC3Zdq2JmkkYDp3VfWiX8i
 8cO1tEFh5SJhexQSWe+MevOywjtBD2rQE6rjpADWG1Tf1dIoiRzbmI3OXnqlT3KAkMm1MsIRDOd
 T95nyeIHCu9DfvEx3nMOLww+Y3HjCKmKkalAP1O4P2MVqdaW1xfrbz+13idx+R//zBGGPet7itm
 Kn1rM9qROT/TM6ozEnA==
X-Authority-Analysis: v=2.4 cv=HLtWhYtv c=1 sm=1 tr=0 ts=6ad95228 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22 a=VwQbUJbxAAAA:8
 a=8hFUfd2p-Jtc3vMddRYA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210095

My apologies, I didn't fully understand the issue and naively
implemented a fix in tcp_snd_cwnd_set. I've tested the patch you've
given and I believe it should fix the underlying issue, thank you for
the support to help me understand the true issue.

Here is the v6 proposal:
https://lore.kernel.org/all/20261021235732.1313305-2-kj2864@nyu.edu/



On Tue, Oct 20, 2026 at 6:31=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
>
>
> On 10/20/26 00:25, Kaho Jiang wrote:
> > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > This could lead to division of zero error if not checked properly.
> >
> > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > Call Trace:
> >   <IRQ>
> >   tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> >   tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4=
/tcp_input.c:4440)
> >   tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> >   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> >   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> >   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
> >   ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
> >   ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/net=
filter.h:319 net/ipv4/ip_input.c:262)
> >   ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c=
:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./=
include/li)
> >   __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
> >   __netif_receive_skb (net/core/dev.c:6410)
> >   process_backlog (net/core/dev.c:6761)
> >   __napi_poll.constprop.0 (net/core/dev.c:7830)
> >   net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> >   handle_softirqs (kernel/softirq.c:645)
> >   __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/soft=
irq.c:758)
> >   irq_exit_rcu (kernel/softirq.c:775)
> >   sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discri=
minator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
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
> >   include/net/tcp.h  | 2 +-
> >   net/ipv4/metrics.c | 4 ++++
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4416cdf9bf30..9f605d9ecb35 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1522,7 +1522,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_s=
ock *tp)
> >   static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
> >   {
> >       WARN_ON_ONCE((int)val <=3D 0);
> > -     WRITE_ONCE(tp->snd_cwnd, val);
> > +     WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
>
> No. Please do not hide bugs.
>
> I repeat : Do not change tcp_snd_cwnd_set()
>
> >   }
> >
> >   static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index ad40762a8b38..cb36686973e5 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >                       NL_SET_ERR_MSG(extack, "Unknown flag set in featu=
re mask in metrics attribute");
> >                       return -EINVAL;
> >               }
> > +             if (type =3D=3D RTAX_CWND && !val) {
> > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater=
 than zero");
> > +                     return -EINVAL;
> > +             }
> >               metrics[type - 1] =3D val;
> >       }
>
> But is it really fixing anything ? I guess this is why you added the
> max() in tcp_snd_cwnd_set() because you did not understand the issue.
>
> An unlocked CWND of zero is harmless.
>
> I think a better fix would be:
>
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index
> ad40762a8b38379e4ccdc505e3885adb8dfff763..b7f8c47f72f9707adb4ef4dde5558af=
23b46a502
> 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -60,6 +60,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>          if (ecn_ca)
>                  metrics[RTAX_FEATURES - 1] |=3D DST_FEATURE_ECN_CA;
>
> +       if ((metrics[RTAX_LOCK - 1] & (1 << RTAX_CWND)) &&
> +           !metrics[RTAX_CWND - 1]) {
> +               NL_SET_ERR_MSG(extack, "Locked cwnd metric must be non
> zero");
> +               return -EINVAL;
> +       }
> +
>          return 0;
>   }
>
>
>
>
> Note that my email address is edumazet@kernel.org
>
> Make sure to refresh your git tree, because git should have handled the
> change automatically.
>
> pw-bot: cr
>
