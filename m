Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779476;
	b=pIFsdJOweVvGmV8C82uQbU3XyILRgi7saMDXEO/9tnR0wyPbJnyw1hMh3v1VOHPOgJQp
	 eVjFcLHswmXMlFOUp18nD/JJYgHIxq8/w4XXA3f+oCuVTVBR4aPSoAdx9lYCIXBcEdLRW
	 gDWSm8UxvQJQVrwNs6JhlyMkO4Fm6rVBkU7lZrCmScQuo0orXQTLuDjVylEyHtVRrANip
	 61ROKEExfDwsdX39MqHrC86qAwzAc4tEbeOLMjTdyEz6VVHRnJDBHzK9h4sfISHPTt295
	 TR1k5r3F0kNGB9EvFl4It6hxKUqGJ/LjU8u71awt30GrYvPt+jO+1Yj0XRNPgu+Wd3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779476;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
	b=Da0Gedq/D6PltfuKwmTlETqcuO+1iHOKx5guZgZkFCpbisDwkabJbOJbYMh3hQ1iOlnp
	 3W+A1X+PmQVE6WlZa+UT6/w+WOT1ibLnr4txxbiQPG4YRG4X2eeHN6RMp08I2vRJUhRB7
	 XGKTUGw1LKfgfRzvxtCACkcuxUCNOAWwnhwXfYmrLQ5pOM2n/ottuDekVy0Aee8r6ru4l
	 pgpDRAYrh6JO96tZiuap5HpHU/gLjCSW/DjeV4hcFjP2J6bD3vFTGoqfUbghd/eicHbUv
	 3p8eo97ztOwAujAtrlqlBa5G2i8Blps8EFtyDxJZVZxyhJB3/WyO3IwebzfXq7BIeEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1kU2J4w;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HX4IGHDY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1F606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F1F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1kU2J4w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HX4IGHDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792779475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
	b=h1kU2J4wUYRE1cIJ01iH5k9cwcvhIrwa8UnOuNgKZFIvQz6EbMYnN6IrCjYXvyeJ77TdYA
	vMtot2ytaTCqCwetCPhZjMLhu2kfasUsVzjRO29I0QsLKwRljuvUdIuYg+SfduEe+vxgen
	6dIuGJ7ncyei4051R5OKpS0fVBktx0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-WSf6Thz9OGKQ9k9GWfBXyQ-1; Fri, 23 Oct 2026 14:17:47 -0400
X-MC-Unique: WSf6Thz9OGKQ9k9GWfBXyQ-1
X-Mimecast-MFC-AGG-ID: WSf6Thz9OGKQ9k9GWfBXyQ_1792779466
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so11741515e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792779466; x=1793384266; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
        b=HX4IGHDYdIrjok1aszOL8xIYdFvRe9IuFtViIn98rOpyfBSQMBPPmTTdL0coieXgsy
         y3ovUD9tVAAcV4irP49ao5VYh4y2RRJH1wAXK6Bm6mG1D22AZog9egOQu9Q5mD4IiTEy
         9WWSvaGluO4A9MvYqfw/I1VOTfFgYpTFsgL0LzxiSmIkuEcF0stncJUmV3Xjbu6cYJXj
         CwvUzOCk781ToU434BGnd63vIhthMoAYX8sCxWpKUlXulquSwxyJ428pUWymJLzbc0Rh
         j/NjtDY30rPe0t69ZgxovrFlrvjgfm62m++GBGc5FK3uuTpGgmVcj0jfp0iHbnh47Zeb
         hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779466; x=1793384266;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5LxNtIZvdjONqrTpoN2AwYKMzojJ1AJCqiw4LF+p3CQ=;
        b=Xe2gIw6vlsSQ18Q7UtSqtWVgflY/4a7KXCfnfbtLnDxzlJryOWeRxRi9ZQtaE4LZ4C
         fn26Y99hiBSOVHcDxETni2vJtQq+rZH9QkmkhQQezw/4ruCBPPfaaYAyABH8FvRZtosX
         Bp8CzZDdbsFqTYvunyka5YL+8rcgBRPKBi02Wm3dzkrTisgf00uLzqCWJkCRHglr0xF5
         zwg6wBSSz1T5xt1H1UHR3rxBRkJVhYUt3V5ae42vNAiC/dbA7JQrF2Qo61AwQ6Ebyrqy
         C2F7txgz6pgb1WwdLYXSMtnk+UU1cXFqQGnROWkqlEbZpWgsfbO0wqjTUkYyUqeVnxrx
         A2pQ==
X-Gm-Message-State: AFq9FYJeUkiTk7gQUAu4aniY3VYsNY0ebKpoRPEK/RFmee1vOXyEZpN6
	ZNCKwEjm/+qWUk8OemkLBrbj936PnviRdN6bBxbYpMfmhB5yMABLKlnSKsmjDAHzf8nvqOJnWIH
	9E0px5fZkLiVOWvAzdX8cr2MhNGBBhrGsGsOD490Lim5uE9hv3W0GYis59w==
X-Gm-Gg: AYBFou0Z5cCsDOC1XWCTFg19AN/q4cR4E+dpcN5Ff2HUc8mSnPaVZKH6pEyWRHkZfFf
	v+8UYwIMeODJ3Vdp3j7s0DyK4dbSHKbHq4g6sPBVeY8Etir7ax4Kg/ZRrkxsFyHcOBYFTwCMydS
	AObw4RqVGqMpEhRqrJnGKeNJRSAW/0v48pQAXu4WhgvpaMh2HRO6SJwPEcMUQ2wokFG3F+qbm/f
	nujpjkQbLLWkKCYph7LUsTh9V6Wu3c0qIunLSRxKJZkNzDU3OaaL7amDQJnLJh1oVUaQe2YGBKY
	kyAoGafTRkHqhZDtZ9trsdcKCz5Dl4/A2l9vRFFNQXIvvNQQMvXmAk5H4BWviRjfpLsJNzg6r0r
	5+Xd2OL7BbQf7aLGTP2Wgmw3bsmsuUA==
X-Received: by 2002:a05:600c:6099:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4a359c9a82cmr2965855e9.27.1792779466511;
        Fri, 23 Oct 2026 11:17:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4a359c9a82cmr2965665e9.27.1792779466176;
        Fri, 23 Oct 2026 11:17:46 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a03654fsm27225e9.2.2026.10.23.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:17:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jiri
 Benc <jbenc@redhat.com>,  Pravin Shelar <pshelar@ovn.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Victor Nogueira <victor@mojatatu.com>,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2 6/6] net: openvswitch: ensure a linear inner
 Ethernet header on NSH pop
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com> (Jamal Hadi
	Salim's message of "Fri, 23 Oct 2026 07:59:21 -0400")
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com>
Date: Fri, 23 Oct 2026 14:17:42 -0400
Message-ID: <f7tse1ws2m1.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The issue:
> pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
> is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
> in the linear area.  When the inner Ethernet header sits in a page
> fragment, the datapath then claims an Ethernet header it cannot access
> linearly.
>
> Output to an OVS internal vport then calls eth_type_trans(), which
> pulls ETH_HLEN from an empty linear area and triggers the BUG in
> __skb_pull():
>
>   kernel BUG at ./include/linux/skbuff.h:2830!
>   RIP: 0010:eth_type_trans+0x335/0x500
>   internal_dev_recv
>   ovs_vport_send
>   do_output
>   do_execute_actions
>   ovs_execute_actions
>   ovs_dp_process_packet
>   ovs_vport_receive
>   internal_dev_xmit
>
> Conditions to recreate the bug:
> On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
> enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
> internal port up with MTU 9000.  Install a flow matching an Ethernet/NSH
> packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
> and actions pop_eth, pop_nsh, output to the local port.  With
> CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
> Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
> two pops consume the linear headers and expose the inner Ethernet header
> in page fragments.
>
> The fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
> producer fix in the previous patch.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Jiri Benc <jbenc@redhat.com>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviweed-by: Aaron Conole <aconole@redhat.com>

