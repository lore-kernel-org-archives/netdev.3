Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496035;
	b=KPmy6hXjaAFnVynYNgGmQlvDqO42haYUab0mHyJOME6KkpDoFP5UqJPeuHy00iL5jr5B
	 fp1G1qaXCZTXzAV2O4k4RRAjmAo+OrBonGsRbBV3tcoOZio9srXemJhuOzaMSB2nlvpoi
	 HBukD7oAbzAU7jkreTkHJobY/8KY/bLlLUfJ8H/vum1nJGr8sCo+ESN2vZX9Uj1ynYPml
	 Ppzz/KZuW0+Sth2zIKrnILdv6sqvXFgbhmM3XvJgwaJ39AocmxWQQ1KU/WLzw60kBeGg5
	 hTE3XsBE6iQUmkT6qLbS6pS20w2edqzIjOHiQ3yMEDA66lLG2ap15wNpRE/81yaoGUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496035;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WlrfR38cNKeDC+JyPpGDyzWQ//SZcX1/OAOUfGcDW8w=;
	b=DUBO6bPWFdInKAiSL7XPmANj4M9zzpTNk/ZC0QyISWKH89+K5DbRs4Q0bV2v1WqO0pc2
	 BB8S10hIzEYAIsMkfz19hSH0Q7f+wS8LuPk9kMLrr/9zl1dmj1GQpA1SzfOo8A7gH7KCr
	 XGnocZmB+iiADuiW4uuNfUpeCospQFQ9tzbbabl6P/RwRt2+iGGPfwzyU14YyVYsnLdnp
	 MS83+XKcepPpws0hnMP95QfmNYWACZ7V+L/vsBWx1AuDQ+W1ZriMI2y3P7ceOz6r7bSbN
	 3YOP1l4HjE1vp8Q227YODIY7B046iJ1/G9j8Y1hNsWjUeRT9v4pkQNYYK3b88tAe7Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G6skkkjw;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q6i4XYUi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978A606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0978A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G6skkkjw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=q6i4XYUi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792496033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlrfR38cNKeDC+JyPpGDyzWQ//SZcX1/OAOUfGcDW8w=;
	b=G6skkkjwOJ6SeMzF0gSSmWcE8l4BSyOCf+BNvWi/qu5wBsLbgxWQAQHb3vNGPOLgcKtB8Z
	6J/RQaFuLeuSNRY941F67ottnsCFKINcKeQgsc2ptgeMPDN9f3e8FM6DiPAIyf34/uRnfU
	zFi7WMNunbbTfLxjUQ72cmtP5tC2qDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-xrha9fgvMk-nxuLA6hgu4Q-1; Tue, 20 Oct 2026 11:33:52 +0000
X-MC-Unique: xrha9fgvMk-nxuLA6hgu4Q-1
X-Mimecast-MFC-AGG-ID: xrha9fgvMk-nxuLA6hgu4Q_1792496031
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so25610235e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792496031; x=1793100831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlrfR38cNKeDC+JyPpGDyzWQ//SZcX1/OAOUfGcDW8w=;
        b=q6i4XYUiQfDNtYXWuXSuLVA2UCnuimVODJfiaQjVBbcSV4A0qnqHYWGSnSM/QU36RT
         Zj4KYcLToVvHTI6bE8CTXojRu4Ukq4ogOwkHWBP486HL56SM2zhR2HzhoIlyGH1oqcEI
         +SkpjepSiw9e9CcIecS5Cjx2LpDerrj60hmvr4AmAXkXqYbakjGP0YtcfJzaHWh8l+hL
         r0zsYyreT9ruyz4wJt35g0zbfMk/C5LPKwYLy7+w0I0+aIMo05CADOrzSg6syujjMXNe
         VAiChqcmM1qSqmy3eQ2WSU4VAEyGSeDu+zKY6p8S8v7TtMYuUVGeAECWZMksxehkv2jI
         pQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792496031; x=1793100831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WlrfR38cNKeDC+JyPpGDyzWQ//SZcX1/OAOUfGcDW8w=;
        b=2AgCdnEvMpkMp7CAWD9BzVkrX9+HDXWlMXIWzkBvy4Grq/yEWs8RX7CsgFDpi/hvj1
         lTyVpmrvLol+WCeRvaZzlQSWQRaPeMF2nWt+uSTP9CbL7QecvEhjG7rvhSvDXq4yo7eJ
         rBPTPOw8j+Jj9S/JT8r+SxC3j3hFcDJq7MYSpwij7o7erHFxSMtq39udgFcEGuuj5Ady
         EvMBkfzArXOQPYlXlvFyP2dTeJSC9GMwe/pO219+8K4PtfWcHBy8XqH10KWtlECAxHEo
         qU8ccf7+9OiScbZDSXnjCT5OTqVM9wJ+x4dFxc/4itVuGn5FO89nwRbx+OAIJ73Uy1Xu
         omJw==
X-Forwarded-Encrypted: i=1; AKwUvBxsZylvzp32GcZ2LZ7FDBPM9ugBlng/L3SGaIcsHgyMuq6C7lVUxR7dBbIt2ZMZIQgJraMPYOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQH6PvBdn5vsm1EDp4rxhTjgTeu3sNvpNO79ZLVrjWsdHbNwUy
	wa7DUJBbci2P2RUp8u8MIl8oAuOAkxYBhiwIccb/KP5Slx+X2KDJwNJIeL+A++gEJyELLNPgigW
	fOlOx+DHyi2iyqPUrAOEMGpfnRdMNQFzs1tsurokY7ufdVcKcm5fOUVMngg==
X-Gm-Gg: AYBFou3f53unuTSiStqdqAAqwLfzdZoxWr4o4GU2AkNDcdMXh9iduFxHiSNxg3lxhzU
	kmtAC8zwp2V4pRcTROi+EzFfC9xzfJckwhF5fWDGPQFOPS+T91kT8jtwPPkXuZxPxOT7OzSmjz+
	SQEC1bto+Kex/pXDQ4B+SU4HKbPuuiWL32DYqXIPT0XKMaEOzXsAtAzXoSS4j/r07UpQtR19YAO
	gPWP4nUdNfxcmTfoGNNFaW07zhXAwBJYgIdqSpycX8ZU0Dn9O9uVj3GU46tnrolV0UJuIMGlrJY
	ljtQGntSi7dOU2JznpaAZx9TKsby13+aLDg/Y9lMrhJUHBUsjowsKpKO+QCX3mMz4wOvieKIJs0
	9ivX9yAXZls1L1+K8RzCUuadBFoOj6j+uRaT6iTgdIGpn4v2W9CiK+9DFbPQizynSv0bwsMdtWg
	==
X-Received: by 2002:a05:600c:1546:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a1d76164f0mr202670375e9.27.1792496031331;
        Tue, 20 Oct 2026 04:33:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1546:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a1d76164f0mr202669715e9.27.1792496030799;
        Tue, 20 Oct 2026 04:33:50 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm61179775e9.9.2026.10.20.04.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 04:33:50 -0700 (PDT)
Message-ID: <670db6be-2e2f-45bb-b0bb-61d38f4ee043@redhat.com>
Date: Tue, 20 Oct 2026 13:33:49 +0200
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
Subject: Re: [PATCH net v2] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
To: Joas Antonio dos Santos <joasantonio108@gmail.com>,
 Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
References: <179190292783.42615.15864971875396706456@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179190292783.42615.15864971875396706456@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 16:48, Joas Antonio dos Santos wrote:
> A peer can lower the link MTU to TIPC_MIN_BEARER_MTU (100 bytes, plus
> the UDP encapsulation header) with the max_pkt field of a RESET or
> ACTIVATE message; tipc_link_proto_rcv() only checks the lower bound
> returned by tipc_bearer_min_mtu().  The same bound is applied to the
> device MTU when a bearer is enabled.
> 
> That bound predates two later reductions of the link MSS:
> 
>    tipc_link_mss() = mtu - INT_H_SIZE                    (tunnel header)
>                           - EMSG_OVERHEAD               (CONFIG_TIPC_CRYPTO)
> 
> With CONFIG_TIPC_CRYPTO=y, which is the default, an MTU of 100 gives an
> MSS of 28.  Once the link comes up, tipc_named_node_up() calls
> named_distribute(), which computes
> 
>    msg_dsz = ((tipc_node_get_mtu() - INT_H_SIZE) / ITEM_SIZE) * ITEM_SIZE;
> 
> For an MSS of 28 the subtraction is negative and the result truncates to
> 0xfffffff0; for an MSS between 40 and 59 it is 0.  named_prepare_buf()
> then allocates a buffer with no room for any item (the u32 size wraps),
> and msg_rem never reaches zero, so every cluster-scope publication on
> the node is written with publ_to_item() past the end of that one skb,
> over skb_shared_info and into adjacent memory.
> 
> Without crypto the MSS is at least 60, which still does not hold the
> first fragment built by tipc_msg_build(): INT_H_SIZE fragment header
> plus a message header of up to MAX_H_SIZE.  With pktmax below that, the
> header copies run past the pktmax bytes allocated for the fragment.
> 
> Raise TIPC_MIN_BEARER_MTU to MAX_H_SIZE + 2 * INT_H_SIZE so the MSS can
> always hold INT_H_SIZE + MAX_H_SIZE, which also leaves room for name
> table items, and add TIPC_MIN_BEARER_MTU_CRYPTO, which adds
> EMSG_OVERHEAD on top, for CONFIG_TIPC_CRYPTO=y.  Use the crypto bound
> for the device MTU check (tipc_mtu_bad_crypto()), the UDP MTU check,
> the netlink MTU setting and tipc_bearer_min_mtu(), which also bounds
> the max_pkt negotiation.
> 
> Found by manual code review, assisted by an LLM, and reproduced with
> KASAN using two network namespaces joined by a veth pair (see below).
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Fixes: 2320bcdae628 ("tipc: fix changeover issues due to large packet")
> Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> ---
> Changes in v2:
> - Derive the crypto bound from EMSG_OVERHEAD instead of a hard-coded 32:
>    TIPC_MIN_BEARER_MTU_CRYPTO in crypto.h and tipc_mtu_bad_crypto(), as
>    suggested by Tung.  Drop the BUILD_BUG_ON().
> - Apply the crypto bound to the UDP MTU check and the netlink MTU
>    setting too.
> 
> Tested on 602042bf29f6 (arm64, QEMU, KASAN); net/tipc/ builds cleanly
> with W=1 with and without CONFIG_TIPC_CRYPTO.  With the reproducer
> below (node A with 40 cluster-scope publications and MTU 1500, node B
> enabling its bearer on a veth with the given MTU):
> 
>    config            peer MTU   bearer on B         link   KASAN
>    unpatched            100     enabled              up      slab-out-of-bounds
>                                                              in publ_to_item()
>    TIPC_CRYPTO=y        100     refused (too low)    -       none
>    TIPC_CRYPTO=y        171     refused (too low)    -       none
>    TIPC_CRYPTO=y        172     enabled              up      none
>    TIPC_CRYPTO=y       1500     enabled              up      none
>    TIPC_CRYPTO=n        100     refused (too low)    -       none
>    TIPC_CRYPTO=n        139     refused (too low)    -       none
>    TIPC_CRYPTO=n        140     enabled              up      none
>    TIPC_CRYPTO=n       1500     enabled              up      none
> 
> The reproducer exercises the bearer-enable check; the max_pkt
> negotiation in tipc_link_proto_rcv() uses the same bound through
> tipc_bearer_min_mtu() but was not hit separately with forged messages.
> 
> This edits lines next to the ones touched by Yunpeng Tian's
> "tipc: bound the device MTU accepted ..." (upper bound, posted
> 2026-10-03); the two are independent and I can rebase if that one is
> applied first.
> 
> Reproducer (as root; build with "gcc -Wall -O2 -o pub pub.c", run
> "sh tipc_repro.sh [peer_mtu]"):
> 
> pub.c:
> 
>    /* Bind N TIPC services with cluster scope, then sleep. */
>    #include <linux/tipc.h>
>    #include <stdio.h>
>    #include <stdlib.h>
>    #include <sys/socket.h>
>    #include <unistd.h>
> 
>    int main(int argc, char **argv)
>    {
>    	int n = argc > 1 ? atoi(argv[1]) : 40;
>    	for (int i = 0; i < n; i++) {
>    		struct sockaddr_tipc a = {
>    			.family = AF_TIPC,
>    			.addrtype = TIPC_SERVICE_RANGE,
>    			.scope = TIPC_CLUSTER_SCOPE,
>    			.addr.nameseq = { .type = 1000 + i, .lower = 0, .upper = 0 },
>    		};
>    		int s = socket(AF_TIPC, SOCK_RDM, 0);
>    		if (s < 0 || bind(s, (struct sockaddr *)&a, sizeof(a))) {
>    			perror("tipc bind");
>    			return 1;
>    		}
>    	}
>    	printf("pub: bound %d cluster-scope services\n", n);
>    	fflush(stdout);
>    	pause();
>    	return 0;
>    }
> 
> tipc_repro.sh:
> 
>    #!/bin/sh
>    # TIPC named_distribute() overflow reproducer.
>    # Needs root, CONFIG_TIPC=y, CONFIG_TIPC_CRYPTO=y (default), KASAN recommended.
>    # Usage: ./tipc_repro.sh [peer_mtu]   (default 100; 100..131 trigger it)
>    PEER_MTU=${1:-100}
> 
>    ip netns add A
>    ip netns add B
>    ip link add va type veth peer name vb
>    ip link set va netns A
>    ip link set vb netns B
>    ip -n A link set lo up
>    ip -n B link set lo up
>    ip -n A link set va mtu 1500 up
>    ip -n B link set vb mtu "$PEER_MTU" up
> 
>    # node A: 40 cluster-scope publications (any number >= 1 overflows;
>    # more publications write further past the buffer)
>    ip netns exec A ./pub 40 &
>    sleep 2
> 
>    # node A uses MTU 1500, node B uses PEER_MTU; the link MTU is
>    # negotiated down to PEER_MTU, the link MSS becomes PEER_MTU - 72
>    ip netns exec A tipc bearer enable media eth dev va
>    ip netns exec B tipc bearer enable media eth dev vb
> 
>    # the overflow happens in tipc_named_node_up() as soon as the link
>    # comes up (a few seconds)
>    sleep 20
>    dmesg | grep -A30 -E "KASAN|BUG:|Oops"
> 
>   net/tipc/bearer.c    | 16 ++++++++++++++++
>   net/tipc/bearer.h    |  2 +-
>   net/tipc/crypto.h    | 19 +++++++++++++++++++
>   net/tipc/udp_media.h | 10 ++++++++--
>   4 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e..02b2e9f56 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -433,7 +433,11 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
>   	dev = dev_get_by_name(net, dev_name);
>   	if (!dev)
>   		return -ENODEV;
> +#ifdef CONFIG_TIPC_CRYPTO
> +	if (tipc_mtu_bad_crypto(dev)) {
> +#else
>   	if (tipc_mtu_bad(dev)) {
> +#endif

You can (and should) avoid most of the newly introduced #ifdefs embedding
the dependency in appropriate helpers.

/P

