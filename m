Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283062;
	b=mMnb5b1ciw6EAs3IS6Tx8BOM0xzIHhyV0+SJnX5b0mK9Hwd/PCRPjsBCOMvyQpgoBd4i
	 xUTPxPfl0M09e13ChC4SWyABAbpqfqJ9l8eybRGgGfi7b6nuRQ8jeftbzSZ2/Q/6COrtv
	 oDkB0hy5K1CEgtrtYvkw4ow2OKgm0GAMfpQPaxztdUPTeAsHsusGJiDZxjvFxb1s6N0zQ
	 cvjC5eP7El2ySrR4PpzBMixtdlPA0BN4S1NtqqL78zaoikQBKtSr2P6WFohkUKzB6poLa
	 1UgXao7GrXxp8+BGZi7HziZqAORfcLB1chrAf1ttpufofbh0X/Ytp+77sh0LWG0g+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283062;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=S2ezqz0ZqnFURyg+DrMUvl/ZxfvgKHi+fzqaASqkQZU=;
	b=EMjqTbMqkJYEOMsU1VC9r4s4xlkgpKOXMa86GrphqM+phEwaVQEpkIl+7XchKiJVOD+D
	 beLu1kaJ9kVekMFZP+jv/oALT/lZPvFeU6pTFw/C2c2HYCGFdTRIBN0h/ScKYcnbmc5pW
	 cO4w8/2cW+DGNW5ieXn4nf4/cyd1jpokhsvYi5yqW6MfzT4j3Vvuff2SebCPWYQlbgakD
	 xymPJt2awDZLPURoUXvUD7i0ZQ1G9Z3pHzHgVZrB69w+Z1FAKlAhmBSdAunw2RajBDkgF
	 6Q2h2O4MTtoDKofrmd1Qpwwk+79EwM5RdfcGEFCQFIMNZVx9U8ZfiInSaaVTDBRFDdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IM6aY+Tl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="YVx4oR/n";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33542606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33542606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IM6aY+Tl;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YVx4oR/n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793283061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2ezqz0ZqnFURyg+DrMUvl/ZxfvgKHi+fzqaASqkQZU=;
	b=IM6aY+TlVfz0gRvwoblt04nLvxoKSzs/C2ZxVo2cBhusYcCq7YdCrKWBDM0I6RLtywB0iw
	BrGriwaMcxCwcPr4i+z9ZPxnkihTmj3pNy21MBUqct0ERmubiFha0TPIMGBP4L6Ywoj4MV
	JAjrjXUpMp0QFuIhfDgvsT0u9UgzLw4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-U3UVp8KCOmKWRMPsCjwamg-1; Thu, 29 Oct 2026 10:10:59 -0400
X-MC-Unique: U3UVp8KCOmKWRMPsCjwamg-1
X-Mimecast-MFC-AGG-ID: U3UVp8KCOmKWRMPsCjwamg_1793283059
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3f88d2ff28so169034966b.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793283058; x=1793887858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2ezqz0ZqnFURyg+DrMUvl/ZxfvgKHi+fzqaASqkQZU=;
        b=YVx4oR/n0LHUGCyD0QM7wgcb8iHCMqf/Wz0vat/jFRU484OMwPMXnSxJT2Gkg/DwqQ
         aRoQu+0v7/caPt36fb+qv5Ib0FznxcMDafDP04mcoB4aBKcKq0Imezy7KajrfNe5p8PJ
         9BbPISUAphAIsFvLcLZsrInIrRTvO6MqV8KeemnhbumBPm/RDoFv4JV6cxfLacB4U8yo
         I5nL8pQW4yHAwfLO6NDq+yWnwUArOaVlUP4ntEAUlge/4/fEjThoguAkV8MQ5Y0t5EwV
         g0YzdLuNoxB1bCsAuHYJO7vVjO39uO/WNFfX72zE8D13OSXk/bJ7wJiJbYbO6M72utWU
         q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283058; x=1793887858;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2ezqz0ZqnFURyg+DrMUvl/ZxfvgKHi+fzqaASqkQZU=;
        b=HvOifuMnEnIEhCfWT0xuG8loAw6jvC1dqbT+biBcr5LrUoN/7NPwAN48oqN3HEZMPy
         GfdHF0/sZyZ95WBvMWqhEREBByK3Fg+F+qwIsXfxyPkVbWXFxWTEv/YVMS9FfRDM5RLV
         lvhritbDMycfnP4FC27XdLJE5Ij5xCsKCLX552BCULKWZ9Q4tiOiv8nJrupVn4o2ABpw
         eyP12QjgGyGjzwGEw+N5D37hhNhMRL/tBPMBWUcHBoz41sLPQHuVnMHm4Q5PuCe6Jnu3
         961CSatHSCG8kP2JmM5rT3aKZ+lAnaHlhbf0j3R3jZJtKQP1Pd8ItUR2kPWQ23/v7Ow4
         7lDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0QnEORB74GG6YflyUm1Yj5CEWwjylrk1qabqWs7ukAtQ0/+iOWX7ilx/qWztN70X69YgOuTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb4cKptN2Z29vMCiB16O2Rkqnhb4g9w/dO9UGxkAOojqc4YNAO
	mEmljwfN1vYQRuE2qojNECOGCVXDksIMC8h5vtPBTNFiw+6AS0rjRymvtQXPSCCwP2As51OggOt
	KQCnvBtYaXPmxG8XXLU8CllgwdUv+yo9NdhhsUh+IL0cPDO3ciH8yb2HH5Ve6Q1EzkQ==
X-Gm-Gg: AYBFou0rW3VAaWhL6lpIO8U+z7FRYtuSfX9fNK6/FGUtYtNgqFB6Z30roynX0TWiYMC
	2gTxGFVB/sD5w3kjDvqeA1RH6xfpFltqF3FPHtl2eSYD2TL3dP/xlQ2HeLW5Q78VU4X86SdfHRY
	mfAfNmFlH0vJeDkPAlNNeRmcm9LyEp2wlNJzfakTp0VCIHCIRwCdGanSmg1so4RyWdx7HVA4IZ+
	hO7vr34FAUwwTCHLzbQ6zCNw9CFPpqMdunTUWlJ04MFpc5m86btI7sAFuwJB/1UEw9v785FHfDx
	JAm6C1hvaIZNDEntq1AY2j5qlCGc9nxXh6Y7YbMTlWRjlBP6cZaE0Z5y8mQB9MOq3rJRNSncuN3
	mI5B9PAXC5I5wJL3TUlBNRS61d3EP6svYzIeUK0oVxnv0EV7BNmnoWMPdv+bZihhppCazuOmiLo
	ERWumFUVTMx/UKbNsH1oB10u+p5M4Ha+5K0NuWAuqfbp9qd9Q=
X-Received: by 2002:a17:906:eec5:b0:c2d:ca32:2176 with SMTP id a640c23a62f3a-c49bdf37849mr505713266b.8.1793283058561;
        Thu, 29 Oct 2026 07:10:58 -0700 (PDT)
X-Received: by 2002:a17:906:eec5:b0:c2d:ca32:2176 with SMTP id a640c23a62f3a-c49bdf37849mr505710166b.8.1793283058105;
        Thu, 29 Oct 2026 07:10:58 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm740498366b.64.2026.10.29.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 07:10:57 -0700 (PDT)
Message-ID: <e0347015-0b0f-4a87-92ce-ea5e4868cf2a@redhat.com>
Date: Thu, 29 Oct 2026 15:10:55 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] tipc: fix NULL pointer dereference in
 named_distribute()
To: Tung Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 jmaloy@redhat.com, horms@kernel.org, tipc-discussion@lists.sourceforge.net,
 syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
References: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
 <20261028033722.125477-3-tung.quang.nguyen@est.tech>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261028033722.125477-3-tung.quang.nguyen@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 04:36, Tung Nguyen wrote:
> +/**
> + * tipc_nametb_insert_self_node_pub - insert publication of node's self address
> + * @net: network namespace
> + *
> + * Return:
> + * * 0          - Success
> + * * -ENOBUFS   - No buffer space is available
> + *
> + */
> +int tipc_nametb_insert_self_node_pub(struct net *net)
> +{
> +	struct name_table *nt = tipc_name_table(net);
> +	struct tipc_net *tn = tipc_net(net);
> +	struct tipc_socket_addr sk;
> +	struct service_range *sr;
> +	struct tipc_service *sc;
> +	bool sc_created = false;
> +	struct publication *p;
> +	struct tipc_uaddr ua;
> +	int err = 0;
> +
> +	sk.ref = 0;
> +	sk.node = tn->node_addr;
> +	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
> +		   TIPC_NODE_STATE, tn->node_addr, tn->node_addr);
> +	sc = tipc_service_find(net, &ua);
> +	if (!sc) {
> +		sc = tipc_service_create(net, &ua);
> +		if (!sc)
> +			return -ENOBUFS;
> +		sc_created = true;
> +	}
> +
> +	spin_lock_bh(&sc->lock);
> +	sr = tipc_service_find_range(sc, &ua);
> +	/* 1. tipc_net_finalize_work() is not scheduled because of namespace
> +	 *    teardown.
> +	 * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
> +	 *    to insert node self address publication into nt->cluster_scope
> +	 *    due to memory allocation failure.
> +	 * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
> +	 *    executed yet.
> +	 */
> +	if (!sr) {
> +		p = tipc_publ_create(&ua, &sk, tn->node_addr);
> +		if (!p)
> +			goto error;
> +
> +		if (!tipc_service_insert_publ(net, sc, p, &err)) {
> +			kfree(p);
> +			goto error;
> +		}
> +
> +		list_add_tail(&p->binding_node, &nt->cluster_scope);
> +		goto exit;
> +error:
> +		if (sc_created) {

The above is a bit ugly. AFAICS you avoid the unneeded label `exit`
moving this error path, label included, after the `return 0;` statement.

Also sashiko complains look legit.

/P

