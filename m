Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109056;
	b=L4qe5Tpsb+s1F7TqRWYqJgPpZenjP2E+1fIk2fP/jmCKIeGerAxTaH+Dzxj4aLgtSjrf
	 KJgZYy3jXdzmEB9GwM3iWRg5NL6pTLMPhZsJUFOMvVOxeVJ+1W5SDSWvUOlLAYQ4ygxTo
	 fEDPj3Qt3vVdMa6NIJe8gXCWyLxDYXI6zJ+n3RjOIMy7SyVWB4BsF0KEk0TfCoQNSL9Ew
	 zEVks1zqqjL1+3FIvbImaA8JCb0rvcNL2/+xL3JZ7BuUy/yf4iJeKe2XQFP5bA/ujOf+/
	 xnyt7cgMXLcjK5fo+CJuYKsKEo8jScnKWU612zT2P5v/anNnImRGUwldHtUj5/DSLbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109056;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=B3G8vwunW1g9kV5zckoAlO5b3O6FhHS+HoVZFrr3t3Y=;
	b=fzwNgn7AqV/lyVCXQv9AhW4RWt9P7Ulw6S+WbMmzTSHPuEoqQANmuA3BEG21q5y94xpS
	 8mvBdgaxomvS4+C2Y5gqfBLoZGq9zLmt72HWA1krNdds3k9DQh1Wr+U9XsiUF44jo2V1k
	 a2HV+qc+oaQE2mZbjF+pwgCTN7it7jqvvPQCHJSJh6Oy///vlDzzltEdU8hst89LBS649
	 2Y8dq6UeXuzfXLflN7BrWklbY9QaVhh61uhEj3Ps0pBdUwFbe8v0sy13hJGC6XvrPWboy
	 C4njcK/xErrbeKSnsrA1kRl4o3gXeptux8Pe7JU7EZGfw22M9PTjiwCC2rSVk45xv2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXuRFc9c;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ccriGe6U;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48868606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48868606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXuRFc9c;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ccriGe6U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793109055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3G8vwunW1g9kV5zckoAlO5b3O6FhHS+HoVZFrr3t3Y=;
	b=VXuRFc9cTLivc6dVcbpzJ/C1tzrdyrCQ4i0uJ4NowVJMGZTom8CH5uGsFWiHotcRCneCvF
	e+Vw86PCyQ4vELRVFvnlPdq0xoi3AxpdwOvkLoMT7Vvo3sKMBhboCrx/hKDAbEWsWpHCqE
	3X+jlIW8Q/ZfrOxSfhW/+j9c3PKF25M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-YpQcIdruPjSwDMRwTuCDzA-1; Tue, 27 Oct 2026 09:50:53 -0400
X-MC-Unique: YpQcIdruPjSwDMRwTuCDzA-1
X-Mimecast-MFC-AGG-ID: YpQcIdruPjSwDMRwTuCDzA_1793109053
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a20a40d3e9so27102765e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793109052; x=1793713852; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B3G8vwunW1g9kV5zckoAlO5b3O6FhHS+HoVZFrr3t3Y=;
        b=ccriGe6US+nmJnVssXW8Xyje3CeSz2UmkWVPwXqXoljTaGRmU2xr+YN4I8/K8RGzht
         xwcAA9W9nCnB1K1/3ed7NhC2XVnSPymnMCt65c2WwY4l0gm5H3Wdq4dvrnVvVzR9Le2L
         Jivp2coa58SDm0pxqrqCDTXjuZo00It4leV/u42vk4wH8UHmQob4csA3lcaHeSkJws6X
         nX9lE427Y9t3VE5iwi9oG9CYRC3NGdb1b4DQ9sJ4lbXrLXg+q77PiDWShb7i1P4K63eX
         7XTnZNSljvH21nznisEBaJO9NontSsLWqt3iaeEexECh/V+2IKwifAws4ObUnzs03C81
         72DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109052; x=1793713852;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B3G8vwunW1g9kV5zckoAlO5b3O6FhHS+HoVZFrr3t3Y=;
        b=FudbE3LP+sKkKpGXSR0udvTmO5+SRPJwhJQDlmD5SdBg0SObc2bpiJ3C6Axa8EIrgv
         M6bcWYH57xu9IIllDaQYwCsLJNLhW3+Hu4ndnaudXWgGBVNpwIKyKpfjA5qn9fY2XiWw
         L3HPwavHJKLS5ggtqHSkANZXfWrBvzHuMTqvjOuQSwDzbJACK3cJb1eCueeY7SweggOa
         WfO8wXe9J1nbZDGXw/7gBJ4RZXnDCIx8lP8cVfc/jjNbWjzdknfoZYyIJuxc+n0wm3Sq
         EaPW+viLALzk5NYNpoAnQbpgT0HYza4dxxvTdEhSrJ+0LfJSeu8YE4LYNU/1B64Ijz7S
         QnWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM8bflC6YjhK1z2ETKIXR9rIajsiQa5/GwKpOZjHRHUjJW9zqxJD6QSvoWizYI4aq/3gesBtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxS4E2E3DlvY2EdoNzzUMxLklRZ3lcxTWrqSm+FPT3/Ixl6KOE
	zw8s2VlwKIv8ROG3nJ66Iuw3g/VEz/G+gU1M6900M4WCiun8aAcSdqOPvm+gynG1E+/5mWuGSPL
	xFjL08Mofr/yOdBNpAf2aw5bMYZpFy424ZphuwQfz2UJl9rYWpSbyWiAzIw==
X-Gm-Gg: AYBFou3c6iC80QwSlpjEiPdjaVIDxevGj/qGmgr4iPZEttg1FF7lthvEg+J7/wl8kcX
	TpTmZoPJEzGlVcKI7Z71C0YGI1XbgRYdNDb7DOoIxiIHVDU6xStuAilZ/avDkA4HnZ5C28g68gt
	UF7nWmdsLZRQe6dRJ19C2FFvgLE0RxP5jm3Vt6mopxkqvEiS+YWjMKn1CI2joLyaNzh1NfWY3hE
	FfEX6eqcojSEIUP/i1QztbbH+X0wUDf8JedfRXN5cWkWtqR4Uson49g6uV52xw+CrXLXq2FfwN+
	tXfbVLKnsm8MfHBwR16Z44b8TS8RVK533GfVmBw6YIxDsT/2TG71hKwmt0LcOqDgILS7YEqhk/3
	NNa+jF7Myl2o4C5bOb4u33zYVjPFGbQ==
X-Received: by 2002:a05:600c:524c:b0:4a2:105f:ab88 with SMTP id 5b1f17b1804b1-4a35ac963f8mr188029025e9.18.1793109052316;
        Tue, 27 Oct 2026 06:50:52 -0700 (PDT)
X-Received: by 2002:a05:600c:524c:b0:4a2:105f:ab88 with SMTP id 5b1f17b1804b1-4a35ac963f8mr188028015e9.18.1793109051443;
        Tue, 27 Oct 2026 06:50:51 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4115f496sm21919675f8f.5.2026.10.27.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:50:50 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Andrew Lunn <andrew+netdev@lunn.ch>,  Eelco
 Chaudron <echaudro@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>,
  Jamal Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,
  dev@openvswitch.org,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Ren Wei <weir@nebusec.ai>
Subject: Re: [PATCH net 4/5] openvswitch: use eth_type_trans_careful() in
 internal_dev_recv()
In-Reply-To: <20261027082604.1485903-5-edumazet@kernel.org> (Eric Dumazet's
	message of "Tue, 27 Oct 2026 09:26:03 +0100")
References: <20261027082604.1485903-1-edumazet@kernel.org>
	<20261027082604.1485903-5-edumazet@kernel.org>
Date: Tue, 27 Oct 2026 09:50:47 -0400
Message-ID: <f7t7bj3s154.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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
Content-Type: text/plain

Eric Dumazet <edumazet@kernel.org> writes:

> OVS actions like pop_eth followed by pop_mpls(ETH_P_TEB) or pop_nsh
> can expose an inner Ethernet header which is not in the linear part
> of the skb. Output to an internal port then crashes in eth_type_trans():
>
>   flow: in_port(0),eth(),eth_type(0x8847),mpls(lse=0x00010140)
>   actions: pop_eth,pop_mpls(0x6558),0
>   # AF_PACKET SOCK_RAW on dp0: eth / mpls / eth / 4096 bytes of payload
>
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    internal_dev_recv (net/openvswitch/vport-internal_dev.c:202) openvswitch
>    do_execute_actions (net/openvswitch/actions.c:1296) openvswitch
>    ovs_execute_actions (net/openvswitch/actions.c:1606) openvswitch
>    ovs_dp_process_packet (net/openvswitch/datapath.c:310) openvswitch
>    ovs_vport_receive (net/openvswitch/vport.c:448) openvswitch
>    internal_dev_xmit (net/openvswitch/vport-internal_dev.c:42) openvswitch
>    dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
>    __dev_queue_xmit (net/core/dev.c:5066)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
>
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled. This covers all OVS actions at the consumer,
> instead of fixing each producer.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---

Thanks Eric, this looks good to me.  I guess Jamal's proposed changes
for OVS/TC aren't needed with this series.

Reviewed-by: Aaron Conole <aconole@redhat.com>

