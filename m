Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779441;
	b=ZWBKYxlk9ux6jy8vY6aH221p+FAs/QnMg+qaPlkvF6+/cenijp7vgK0A3vqWW5dIsZbs
	 S5V5Jw6hHI09G+AzraBHFOcGbbRBXAIXqeE5+ffNQf0jBYmqgzRGnpv/d4+IkVAapQd+6
	 dqbv2mtcHGVwEdYLdwsCI6XB8v8MXVADxnyw3mzNh88CcxWtlAFgK77PdgzCIldCEQ/2o
	 jBAgdnBEdZzrd7uIIIDoYd1uTtjUKsbGKQDYs3JR1TQeDXj2aXry3rc5fetA0tzNqCUSf
	 TIy5TCh8PckKsVZCeK4fdCBaTXu7ueUH69qox2NXwfIURR3PhCXavC2f1EQ7tnn5xHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779441;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
	b=TaDjxM0TMKs+EK6ol6Wz1lEflY+GjEjQ9S38C80zscQtH6uVSJtP8vgUWuyU7xH+t+0U
	 nQ2yS1gIxEwXqdMnWaHvxcXU3rGwo9Qmv5s6TGqcq7wSkQbXAoaemdL8N3bWQEzc94IZI
	 jDRKe1ijUbi/X3b0SXqHoAD6raqBV8vOPH3iQh93+A1vp3c90Vd0kKe0gC0PQ2VQthH5I
	 Zc1MNU4aIX/KlhLI3IzXI6B/cjbo701VlTk9npOhlih7hK/GwNhXk8NjFKJxrRiGt3I7s
	 Tpc6DRYRZRczdlmuYb7pWKKp8CC5O2EBLlISsrj6LErz/omcUholhkm1nq/NUpEDxfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PaRgi8oi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qjC4BqGZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD63606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD63606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PaRgi8oi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qjC4BqGZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792779440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
	b=PaRgi8oigNuGFJi2xCNaAlC1RrSTQ8TwHKdzu3e6TAOvQ/RuYO37vRPaktCQFNGl2hJ2Xe
	2PxlgGrKRRwNf88vCtnJnoZII6LAkKOCaht+Xtoba8ABlK9wqcFi091Yd+0bgaxlxFVeMo
	y3wlCa2nRXF+j3Ssp9fD2Xg3Jn9njDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-IpzT9qlXPXea2RIgQ_N9zA-1; Fri, 23 Oct 2026 14:17:18 -0400
X-MC-Unique: IpzT9qlXPXea2RIgQ_N9zA-1
X-Mimecast-MFC-AGG-ID: IpzT9qlXPXea2RIgQ_N9zA_1792779437
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df5b058ddso733834f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792779437; x=1793384237; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
        b=qjC4BqGZ19GiA5CbMkSA7HtE/unfd/YVz7YCgLXmBk0oiNwhfNF0Q/pJXKZh6niKIj
         CHIF5SgI4sBnrrUQOfLYGVLd7etjUkn6npZcEs/mlTF7mUoxBdq+r4vVe9WDQ6YZAcEy
         Z64cW4/rHmHWxMbFiIwgJJxAIb2oUg6nZK55A9nb1hqw3/6m/48caDP6bi+8iHxEFlxj
         Lx5ndbOFySjBVXf68OIWtXUIHKSxvEgzFBE53sLSF50KdeA2sJC7PZezLgZZ6/NQMhph
         juvZsMeAAN8DTucvBqU4Jirb/hLZ2D4PMWW4mAkD+cpZ8vFuhWmevCIwCkvDHyvdGChK
         bLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779437; x=1793384237;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rTx9dehoDL6UrtB6cqyEQOfT2QURvHvNHtybLXG9ayI=;
        b=olCFOErX104P+vnd8i21f7uCy1hDppl60PDKfy0KtHDvJyRzZXRjG6DaQL+O/SULJ0
         /ovKtmVklee3eG5xhtwZZNFaPMDHZzHknGInX4ZcWXOyQHGIuRJPgD0/aKKNCX+g2zGb
         91NYgr3hQqTkx0ClLlxaymRgEoETShVWfa2n5kOuMM6wuF/qZ70UojGedgS/kn479qe3
         IV6rdxaxLHTPZq8DWDhuDa4lumwg9dDLmhs5b1zanlV2kHGhD2pJ8OOUaW8bLoOtAhrO
         GwzfoKY2lMHxfR3o2OsehRMUUBXbpzhzSl+FM0UygROimJc+2HwVhr6+QgCKXD0M5sQO
         MaJA==
X-Gm-Message-State: AFq9FYLnLvs4nYCbIv4wNzuLFyUUnSEa3rU7NrwQ+rtEwhI6Xxvtadoz
	YFmPXn8OcTtl9P4yOszwM8KwKHoztf48WY9cFJSJ9cn1nINvryiLHo/TYzLKM55eK+sl6Sgklwh
	TEITKeMHfJlDENTrMellSa57Zg7EFXl+YMnXfuqVabxfXE4uSUAvNZwVQHg==
X-Gm-Gg: AYBFou3KTnqqZKYrOAQoq0lqTk/jd9YddUgJGmjgL6SLcWyZYXQ3dcYZbUDGbvDDYos
	NRI8oRAUWsPpmq2h1SRtImknJYZ1MiJRZxbqyZ4gHpDcVioHGL8m08/Y7httM8HIGWC0TXres3D
	fO6os7JCEO+Sa91ThXKKs/Lh6hlDjQw/xiKtySRShbiMc6I6kuR8ag6hKBEF1oLefrO8lQ6b0JC
	1XttsullIfoKWjeleVizTduWamaZ6hPv0A+wuBQKgiJb/PT/cUfWREHzu5YXQI18TeO94FIiLlP
	XYTN9ctiNtz+2zp8/TevMLP+ofZeRY3Fihr/OQkYNFvv2wPgiZtA8QdXjaxvM07kR7hEeTSDXHx
	v6O9mGv/I6E+oAK8JZAJ29QC5pF6Cgg==
X-Received: by 2002:a05:600c:3b18:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a211ed8fb3mr45467195e9.33.1792779437326;
        Fri, 23 Oct 2026 11:17:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a211ed8fb3mr45466695e9.33.1792779436892;
        Fri, 23 Oct 2026 11:17:16 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm305055e9.5.2026.10.23.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:17:16 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  Pravin B Shelar <pshelar@ovn.org>,  Martin Varghese
 <martin.varghese@nokia.com>,  Jiri Pirko <jiri@resnulli.us>,  Victor
 Nogueira <victor@mojatatu.com>,  dev@openvswitch.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net v2 5/6] net: openvswitch: ensure a linear inner
 Ethernet header on TEB pop
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com> (Jamal Hadi
	Salim's message of "Fri, 23 Oct 2026 07:59:20 -0400")
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
	<ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
Date: Fri, 23 Oct 2026 14:17:13 -0400
Message-ID: <f7twlr8s2mu.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
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
> pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
> ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
> the linear area.  When the inner Ethernet header sits in a page
> fragment, the datapath now claims an Ethernet header it cannot access
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
> internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
> packet with one bottom-of-stack label and actions pop_eth,
> pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
> 4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
> label, inner Ethernet and 4096 payload bytes.  The two pops consume the
> linear headers and expose the inner Ethernet header in page fragments.
>
> The Fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.
>
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

