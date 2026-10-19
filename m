Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792448825;
	b=Ni3bNHshNA7tnZvQRxHGfNn1ZSAYYq5wtO0YMyND/1cO9kbkOzbccKCS7EN9PZCs9HCH
	 +GDMoUlRnjDWX09GhdWFXjZ8Spmenmb5NPd71YVx1RgRhecOFXygIoPwviiW11WiPL9vL
	 BNAbigkknVBYoNnnsxWOyV+cPrtCC2tb0eslrQmVgQsu418pWsCBx0J4NEJXe1hKyoRtk
	 i7tWl0nQPrrriYQONF+I7Qf00Ghw99/rERhD9+EgProFajitrijJJT/ED93Z1IKT7fdsu
	 Bz7+4BctaEJ9bYpRN5e1AFJdTX6nCMt+cPC8az26eYr2orF8+IlrD26dkwcU7nmfScA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448825;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
	b=iYVK6W4qrVPwaEgOlSWtzixoE6d6aLzz4SiVWC/l/RbCKfnllSBLWEd2755FCkTTdXIn
	 xnqFWXLSDyTHMPyxaoS9Im94rQEe994nJP3573Iz+wonHlWtyn1mWdU8Z4MIwevrmLCeV
	 o+rsD0sQ9+og97COwmzCJDqvVH7flTNpssD44yW/0hnqoFvZUCcTqN02jfQiiE/fJFSOq
	 hsS87s5aICiVBK+1NHUym0OoRxrXPKhVLill76h7PcFgUuSaDOJMQKW4oqAKMcKPUdQtV
	 F1hGvMX60M0rmVWp5cfK0XOiNGnyEAVM0A0SDRTHAvDlM7bXaxlgfvVtKfJXTKjnfrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Ik8aelSe;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=nf9o7U+C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE01606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 22:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE01606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=Ik8aelSe;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=nf9o7U+C
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JLcPHd320168
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=7
	W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=; b=Ik8aelSen+0yPt9sa
	EocafKhobDXbKGKRRviMN6sAcOIuxKAj5l9lAdqzxQe8Kt/1ps6w2LkiPA1OLDFa
	lcRgEKIG0hiEgsV8PwrEQXlRmhPFB2Jkyi2eYBt4RERzLswy3Vmw5HYeT6d0addK
	D1FlUbITAR3x8hg8S9ckM4Z+QA4ebhPOXzyQeSk5GReME2Ua9j+MpLfkE0I3jILR
	JYuihYXTP6C1VVbJ23jV4kI8wVTHEKr1f+/eVq6pw7kDbbxwfSkFckQktuZpBKx6
	qO7EYqiTD4NzfHm3nxB2Xfme353iVlvZS85Jw53Q1I8X9fRG0QBOe67+IjCmwqin
	YZCGg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hdua30kgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:27:02 -0400 (EDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so157832eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792448822; cv=none;
        d=google.com; s=arc-20260327;
        b=OkkcxgHlENTn0Cp6LRQ46sr8GAl9PAPudELNQaO/tt88XRh/uh2DESzLEfOoyuMZYv
         ahvaVzldS3xeife0czZVC3KzyU22SOz9McrptOngKL8OYTXA49fGLL3TkpJ5mhGm+0X/
         B1m0tlQw84cieQ5RBkTlgPtMY8gz45O2KhO/keq284jMmDSk1OXyYfmmnqRVuFmzxBHj
         sOV1dUy4YnekefPK9mN+aBlnnmYGJua2G/azV+yXIqVoklDbY87kU/sN1yZShGVt1WlV
         zb9TAKKdEi/Jh9b2EdVxRImwIgh7O1gwuO7UxqfFS7yjsulM0GOhYNi6Kyl6LFoZbQPV
         2ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        fh=hfLLs5tdCXkQG/KUXE0/bfyuqWPQktOQvKopd8pdP8k=;
        b=m+FdLKS9fX1F+1qN6TiHvfqio9Dlrau76pQ+faIt3CRgt31vZ6V06nLVQA4Rz4Wrxc
         n6Sv1CVLKikT4F6cPyBpsQnfc8xNLRo31CxlT/hGOtCb7SsPigezQfiwzGRTN+4CXt9B
         zpm00UHO6Z13VCXbrkc//3jLiKd3vMaI63XL4GJ9q+796A4nWqG5NCL/L4gpF5OADJg2
         A8Musf3hL1sdWgoPr9+DTjOhK42J1u284JGEOhuCCdEDOChFH7nkhA+shEevVcBpOfRI
         2AaM+QqgyelIj8LEPbNiCHtdffhhD+mLtYst5dQ0EZrDCVFRZStgbgV5ixgTOEmIrbRO
         YGsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792448822; x=1793053622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        b=nf9o7U+CdVmNSA8SypncHM+YKDlJKnoP6jBDVVYI5lhlc9p3KaU6f9RGOk4JVolzlh
         kgo9KHZ9+1DnWHtHbKOZb5gmVdQobCb+jpQZBqva8haMFlhvws3VJm4l0Mf4x2HhYfcR
         74MqhWecZjGCVCBFJ4YTAImmvUW9jG7or0pcimmfMWYTT+aloWHcG9xaOQTeaVISOKgI
         ZfEpC8F+VFBPOJBvlB3crO93GfVAu37GQ5X/PfIk/cuxLHXB7WLKWXnbCRJkP/TpeMF8
         YtSQ0Klh2ydpBNhV7KUMppTGPl4JfCj6p+26OlSvA9R1XKxf0/UlPk8YZyH5e3fQ3FmQ
         4G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448822; x=1793053622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7W0BmcepB6Aeqg3by+8VUO80cva2C9MnIOBEI/kRUkM=;
        b=oJFGbxTdhCKAczpXtmfIBRah3i0vZRa/P5Nrw0GYlGyKWvoHWFLmo8BFJV61AtLYLb
         XGnTOc+dpPbNwKtkjH8rZEScetMphxWrjfcCAM6JmASkxvNCl9nwSpLlruN2lRksQGMs
         WgIhrb83IY2OiNefoBP01wUUW42RawgeSKEKYSYKqI8l8w/97vlAyxyXJOLCiBO1Bezt
         I+RWaSJmOkSARUsrWrGtG/RLKUI4HNw1sWtfAH3J2jR2r1YHlFZ92S/xMv8b5yS3FzRm
         9ofaAnjAnhGnUYV9xDGjpW7DH12pgTc/jL9fAbNhJHferpbV/3WxX8bHD/RFkpvUqZet
         4tyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRDF1STjhTfiTDoCI0l86uJn5uMBlN6291bbP3HamgfoMcJUFjbzkCCyKDIacqcuJohzsHaT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeYf7N5rpr1lyg1zKV/sb4MK310uEjmyrVkcQzg8mkc6CWTUPf
	GEHcnT+wZdg9GnEmSt4Mi+reFEDB4I9XZOwHCnaouJf6vMKRJDtFKny6aA9huGxQTi0oS4accBp
	hGe+wTMzgdO5spiGwrGsjhhpAqLIJtNQ8Uvzih6pcDkBV/Mq8eOsDHMAAwF9TQRRxY2wvOiiVJ7
	RbXrqR0YSdKH8fYflLXj5wtoUV8zVRbA==
X-Gm-Gg: AYBFou3z9SN6Mko+reDmrLXcj9dzUrgX69P4MHmFf9SENwbQrd18fZ61SUMhrJ+NZER
	4zPea3phiVa9uf+JTBkXsxFQeJWalAlSTevGj5J1X+oidgDa6x//57+aIy/VaSuevV5oib9vwCa
	E6YWHjtm/JcxntCSnO+MwyIDRntiy3no1rXj/Oucpx1EINyy5sC3Zi0JEjSg==
X-Received: by 2002:a05:7300:fe8c:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-365fbe702e6mr513080eec.23.1792448821926;
        Mon, 19 Oct 2026 15:27:01 -0700 (PDT)
X-Received: by 2002:a05:7300:fe8c:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-365fbe702e6mr513046eec.23.1792448821208; Mon, 19 Oct 2026
 15:27:01 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017214845.28769-2-kj2864@nyu.edu> <atXVqZDUhE9Z8InH@kwain>
In-Reply-To: <atXVqZDUhE9Z8InH@kwain>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Mon, 19 Oct 2026 18:26:50 -0400
X-Gm-Features: AclHuK_OizrKzXhjvZJbJnNHqcKl2cJmdxnoqVFQ_oSZGq_xEOdyc5Kt-heihiY
Message-ID: <CAPqbLS3wzSQTJJRoBGjJ-C-2GZ95qn6GLAwYBYOt3o75uRiW8Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX3BgRd5LxsA2y
 rPpdaNp2EL8SV+6N00Jj0sml0Sgw/YvtIK08+BC0PZyQTCXYDD4xn50jw8nYSIPdRycfDonU4lB
 FhRyJ1bYaV3og66T/cQ9t4eoiRHjq/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX/ji9TVONeOt5
 ggMTJ1SWYDJYVTNH17VA9oHDwL405S+n+Z17I8QhYnwaLqwcN/BXUGAISTfWIZmKxSeJDr1pyq4
 X96CS/FPaVM/WooAZVkRdjzop8Wo/+nCHpHoIbuKsVYOYiREii/AzfP4GHzKf4v8w4a4l7iFVpJ
 /PnyqvdRAsbDuq4Vj/PCNJBID2XNeSHRLut3EGz+h8tiwnYszy3A1pDcEr0LPHMCtboGewuaVo/
 NcPJYjFnqurV0X7595n2fUFd6Trg4ixSz73YoyqKcMHO2WKaRXD+5CouhlUGfaIizD/XEjkPLOg
 EPkGhMN35I0nd6/k69lLENKVC7kELyQ60uazEYeaxTe1qO0wK+/5Qbm31ZmKJacDr1FcylRjfS7
 yfsx4R1wD9CBV+iZ2pocawzFgN4ZNMVFujtqagp69U6bWkWOogw1Dx+Kk1IK5z1ceijSDQYtJk1
 7tfumnaNj4DDT0wHYLw==
X-Authority-Analysis: v=2.4 cv=FdqiV5+6 c=1 sm=1 tr=0 ts=6ad69936 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22 a=VwQbUJbxAAAA:8
 a=hKX_YmtgrgkOCiSBCTgA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: xteXiQpJZV2gkZLceC973rS5LZHqXtLU
X-Proofpoint-ORIG-GUID: xteXiQpJZV2gkZLceC973rS5LZHqXtLU
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190089

I apologize for deleting the warning.

v5 is proposed:
https://lore.kernel.org/all/20261019222531.1073-1-kj2864@nyu.edu/

On Mon, Oct 19, 2026 at 4:33=E2=80=AFAM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> On Sat, Oct 17, 2026 at 05:48:46PM -0400, Kaho Jiang wrote:
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
> >  include/net/tcp.h  | 3 +--
> >  net/ipv4/metrics.c | 4 ++++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4416cdf9bf30..ad80b8fb8a52 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1521,8 +1521,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_s=
ock *tp)
> >
> >  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
> >  {
> > -     WARN_ON_ONCE((int)val <=3D 0);
> > -     WRITE_ONCE(tp->snd_cwnd, val);
> > +     WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
>
> Please keep the warning (it's not only about 0).
>
> >  }
> >
> >  static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
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
> >
> > --
> > 2.43.0
> >
