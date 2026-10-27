Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109668;
	b=F6P2IoonBr7/uek3vKflA2DAy2+ONT9VsUmnMOrJLjY46lCkppf+SD2bXSqMuvoKgK5Q
	 Ji1t0txPrccw8TW6hm8IcmhWvY11AwZrK/jGoHj0SLvh6qH7vUxUBdQwvEQROkW2NPcjU
	 0rdHL2FcBwIjxMqOkw9thi2dXy+jDfCM7BYgzjsYpjG85QIktskZ4EnrxBX9n3Cmgf/MC
	 yO+J2bGDBOOsE22aKBQ9LIJq7iQyHIH9fJhkp/57Gu/wh3ouBS+ncM4ZnGjSScaeQt2C4
	 gb1pYq8FNw+Xs1uvQQrx+yzG8yJZTuydyKrB6obVc4UMV+EmPOs/rbe3MGpejl3497g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109668;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZlH5qzqfDtSRmCNAmYUV4Luz2z8PCSu8crRuRV7aY3Q=;
	b=GIRvdJti0kM68YD+16fVpHFUd/jBoHZzsWaoR7d2qPed7rLy9qGVfki+ofosBWxjFoJd
	 M9bxBwMxO0Al1UoMF74R8inMEM2rveQPaox/Y9jUOrFCyqUXPFG/9U8sAxI4K+EM9XSMD
	 GhsXJcAC8HphaallcQ0XY5OoXWXEOxbsbbGC+apgutXybgqhJIA7m8RUxY9JUHteQUsUw
	 rXGNVR8rJxEV1kv0bDysiiCynU7aAdSSO1swtD99TUUZwj51F/MNSuoWfcljJqLvHfW2V
	 fL7tdMSTHNZB8c4v5a4fnCGT2QpuJF5UUUV42Jx56bd8+4dD6KoFsw5IvYTYfwMGy/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sxt5BdDe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FCvzxTcj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A1606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296A1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sxt5BdDe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FCvzxTcj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793109667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlH5qzqfDtSRmCNAmYUV4Luz2z8PCSu8crRuRV7aY3Q=;
	b=Sxt5BdDekySuGr8gbfZgXFt/QyGOCSnX3Im1zJOFzQFl/Gwg0awMvL1cC/CaAY9Yzk6Y0f
	BZ8S/TmhjEH+L2xj5rNDAUG1IR7z2WM8YhZwruA/w6/F5y3HvQVEFEq7pLg3haHdPmSy8n
	BevLpRvwCvSPj65DnfHlLCy94u3yvr8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-p3xmDOzwMHyxQkbxfoa9iA-1; Tue, 27 Oct 2026 10:01:05 -0400
X-MC-Unique: p3xmDOzwMHyxQkbxfoa9iA-1
X-Mimecast-MFC-AGG-ID: p3xmDOzwMHyxQkbxfoa9iA_1793109664
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso2223374f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793109664; x=1793714464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZlH5qzqfDtSRmCNAmYUV4Luz2z8PCSu8crRuRV7aY3Q=;
        b=FCvzxTcjaMWeJU6vkKBcV3TG3j2FvGhy8wpErO3su9esKhrEsY6Jx12iidxYqxPGVp
         MmKAqPhvisBz4aXp6ZAOu3DtYnGj6zaAeH4A0aFC6hAdYyOs0LhrZbwQ5NJ62uV0TEB4
         9QPqyoVtowKOOCt8aQJSu11FuBdrCBsiY5ozXmwHKfm+aDpmGq+0iZbKKZhZdg/cpNq0
         zGHDOm3j3q0j4WOABVwG6YUUavDVYf0tCs7dsMcuTUFaC9bUBej/lS8+Kfcnmkg8Dv6h
         4bYCZr3HQjxaaoyj1byntssSNx4bovr65YklnOPnxxQFN6aCX6xoUF9qbS/1XnfbVnjF
         OMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109664; x=1793714464;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlH5qzqfDtSRmCNAmYUV4Luz2z8PCSu8crRuRV7aY3Q=;
        b=sJK2hUNr6gK/9bMpb8CXgKWA04vFcNy6vWLL0Gq+S6AsjW5Si6/6mWIWsaXJpEt1S6
         NG3o0FkBZEL20QOQM6s8lGcg4B4yCDksJfhuemuMMuo9B9kM0MMG9sWhdws+RH+oiUcL
         1hPJp2R7JwobwOGA6Vb9KWAx2lxGHcX0rfbdO//B+XhbttUYEPyRiHQOMpRB1zgxRqeZ
         8QRw4AUSLsvzTGeqynidgWEr/lDtySfmqcioUfI1KSnMsACxLG1NTt/U02dkW4p7CO2E
         HYHmC/oy7gY+F/KnadLSljAEbIQjv39IHjcQjsyzOAzOj7ZrBgO11rTXLOVjQM9kYbFf
         HCKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuAUy301GPFqtgwt45jxa42nHUJDBCvHsygnF3NaLBfnJoZDIIvCH9lqH3mQkGcnuZTsVlrvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJgOaxxzWOKMPP1zwjjQU3SJvKngDvbVjsmDUCcy5k3FetG4Q+
	+53tkvSI8FVVniI0kjbVWSdcjEdkb9vgFzViJ+Ntqjp16CR6LG1YTFTd7VxULn7rvon6u9aOSqX
	O81nf88TV4skjkjWJbVMMyqQ8Fv1TpgS3Aie5yCPKezXN7WMbvJQAtwhpbQ==
X-Gm-Gg: AYBFou0wOd6k5rf5NmVWRs/3cxxf77woUr2GfIEF4QBPMCMjSRTfnLVbQoFkiaL02Rk
	Ht99mCDGmPZr1o0CjnntHN3hrHKZt93D4Y+P840JSnXITmvhhMfD6l4aAYp6TYUU7zN1ZBhxTt9
	jOYadxpp19zmYvMfyM7Ypqjx6V/lgQSvZ+u4Ihjk672QusPgWppLTKoiU5GWsePanpWK4SNR2S0
	fjauXmeC5LzkhPWA+qP7rbzZNiGX7R8J+7BqUAp6rxdSNLKYsrjT2xRMrcHWm3VAF2Jkyz5XlHa
	DnzVeuK//lseJ04Z3S+o6gYWJW7WvDKyekcelW6fw9KfXsm2/CjL7iidSMJhY6sHigcEGAieapi
	sOwT5MIZg8eEs6aepg0aSmpYvACoUXA==
X-Received: by 2002:a5d:5f48:0:b0:48e:4835:de5f with SMTP id ffacd0b85a97d-48e4835de71mr15720047f8f.47.1793109663867;
        Tue, 27 Oct 2026 07:01:03 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:48e:4835:de5f with SMTP id ffacd0b85a97d-48e4835de71mr15719977f8f.47.1793109663279;
        Tue, 27 Oct 2026 07:01:03 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bdbsm18832596f8f.19.2026.10.27.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:01:01 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@kernel.org>,  "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  Jiri Pirko <jiri@resnulli.us>,
  dev@openvswitch.org,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Ren Wei <weir@nebusec.ai>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs
 coming from the stack
In-Reply-To: <CAM0EoMkkVK5V9dVRdr-iOSU_pmXEjf9m3Og71MEFzWZFnOGV1Q@mail.gmail.com>
	(Jamal Hadi Salim's message of "Tue, 27 Oct 2026 09:07:03 -0400")
References: <20261027082604.1485903-1-edumazet@kernel.org>
	<CAM0EoMmmnNttUE3FWWg5Y52gCFz-JqxBUXAZEVoxzmvziyV3UA@mail.gmail.com>
	<CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com>
	<CAM0EoMkkVK5V9dVRdr-iOSU_pmXEjf9m3Og71MEFzWZFnOGV1Q@mail.gmail.com>
Date: Tue, 27 Oct 2026 10:00:54 -0400
Message-ID: <f7ty0bjqm3t.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Tue, Oct 27, 2026 at 5:52=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
>>
>> Le mar. 27 oct. 2026 =C3=A0 10:17, Jamal Hadi Salim <jhs@mojatatu.com> a=
 =C3=A9crit :
>> >
>> > On Tue, Oct 27, 2026 at 4:26=E2=80=AFAM Eric Dumazet <edumazet@kernel.=
org> wrote:
>> > >
>> > > eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
>> > > NIC drivers always provide this, and they should keep using the fast
>> > > version, without an extra pskb_may_pull().
>> > >
>> > > Devices looping skbs from their transmit path back to their receive
>> > > path get skbs built by the stack instead. tc actions (act_vlan pop_e=
th,
>> > > act_ife decode), BPF helpers (bpf_skb_change_head() before a redirec=
t)
>> > > or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
>> > > than ETH_HLEN bytes in the linear part, and eth_type_trans() then hi=
ts
>> > > the BUG() in __skb_pull().
>> > >
>> > > Instead of fixing every producer, or adding a check to all
>> > > eth_type_trans() users, fix the few consumers exposed to this:
>> > >
>> > > - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
>> > >   header first and returns a drop reason on failure.
>> > > - Patch 2 uses it in loopback_xmit().
>> > > - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
>> > >   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
>> > > - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
>> > >   (TEB) and NSH pop cases at once (only the MPLS case was tested).
>> > > - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
>> > >   consuming the inner Ethernet header. This is no longer a crash aft=
er
>> > >   patch 2, but egress decode never delivered a correct frame.
>> > >
>> > > Other eth_type_trans() users already pull the header or never see
>> > > such skbs:
>> > > - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
>> > >   before vrf_local_xmit().
>> > > - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
>> > > - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
>> > >   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
>> > >   only trims frags.
>> > >
>> > > Tested under virtme-ng with AF_PACKET reproducers. Without the serie=
s,
>> > > all four cases crash in eth_type_trans():
>> > > - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
>> > > - lo egress "action ife decode pipe", IFE frame with 8192 bytes payl=
oad
>> > > - lo egress "action vlan pop_eth continue", then a BPF program doing
>> > >   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
>> > > - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
>> > >   eth/mpls/eth/4096 bytes frame
>> > > With the series, no crash. An ICMP echo inside an IFE frame decoded
>> > > on lo egress is now received and answered. Normal traffic on lo,
>> > > veth (including 8000 byte pings) and vrf is unchanged.
>> > >
>> > > Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@n=
ebusec.ai/
>> > > Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4=
@mojatatu.com/
>> > >
>> >
>> > Looks interesting ;-> I dont think you are covering xdp/bpf holes but
>> > we can worry about that later.
>> > I will spend time later this morning looking closely and actually
>> > running it. Will keep you posted.
>>
>> Thanks Jamal.
>>
>> I went through the holes you listed earlier:
>>
>> 1) bpf_skb_adjust_room() + bpf_redirect():
>>    An egress redirect ends in the target ndo_start_xmit():
>>    loopback (patch 2), veth (already pulls ETH_HLEN), OVS internal
>>    port (patch 4). An ingress redirect goes through
>>    __dev_forward_skb2() (patch 3). The repro in patch 3 uses
>>    bpf_skb_change_head(), the only helper I found that leaves
>>    1 <=3D mac_len < ETH_HLEN with an almost empty head, passing the
>>    mac_header < network_header check in __bpf_redirect_common().
>>
>> 2) bpf_clone_redirect(): same __bpf_redirect() path as 1).
>>
>> 3) ingress: after tc ingress, eth_type_trans() is only called again
>>    if the packet is redirected, see 1).
>>
>> 4) XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() refuse to
>>    leave less than ETH_HLEN bytes in the linear part, and multi-buffer
>>    tail shrinking only trims frags. skbs built from xdp buffers
>>    (XDP_PASS, veth XDP, generic XDP) have a full Ethernet header in
>>    skb->head.
>>
>> Let's use something that can be plugged / unplugged easily in the future.
>
> I reviewed and tested all existing issue, they are fixed - kudos ;->
> But, but.... you missed one;-> see attached patch.
>
> Additional questions:
> 1) Would be interesting to see what performance degradation happened here.
> 2) I think it is reasonable i send my original patches 1-3 to net-next
> when it opens as "hardening" patches
> 3) Is it correct to put multiple Fixes: in net patches (you have i
> think 4 in one of them)? Sashiko complained once that a patch I sent
> made stable backporting hard. Either you pick one or split into
> multiple patches. I realize picking a "good" fix tag is very hard in
> this case.

I don't believe multiple fixes is disallowed.  At least for OVS side, we
recently had:

0dbc2398fca3 ("openvswitch: only skb_tx_error() a packet we are about to dr=
op")

This tags multiple fixes (dated Aug 22).  And I think 'net' has a few as
well (like 06e3f54e8b22).

Maybe Sashiko was feeling ornery, although the complaint that backports
can be harder is probably true :)

> cheers,
> jamal

