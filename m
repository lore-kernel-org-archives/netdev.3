Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BA3E2ABF
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627041; cv=none; b=WZW3MG9H9RWbNyO1LJEmGrfufhz3Go16JSbG4i80UdICni04/r5UTk+py5rbtHIr6bpTq0W553UVShP7ROFfi4jPDPj/ugwmH5ZacyVebmmVyv8K7bEgwZ/pRWW5k+kYDaIBFs3oKfPeu7g0wwLToCNBAcZRF+pUmbbyknN4NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627041; c=relaxed/simple;
	bh=IbY5PVTOrL8eCaLa3jm1ws2zoEcSQsbPbwxz+zUyn1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuVlZ00xlt/eHtI6wo7cvZDlYQXnqTXohhClruI7LNN0on/h9pCTZWVF/SgkThy+DhCik6cZwi55Sx/xp4wCZFLO8FD3XCtnWjGg2RACJ83RU7Qq1XOd9ofhngyRXlQy28RR9BOMwnHaSrhUbV9MVoreLNuJZUFgzGhyqGzYoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcrEvOi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcrEvOi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF9D1F00893;
	Fri,  5 Jun 2026 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627035;
	bh=9lPe3V1kbXwQcy11sW9IOTZnFlvLl5J21zXgtrx0sp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcrEvOi8fn1Uv0faiTif0FKT/GeSxSATG2b/i9Os2vBRMbDcknYXhXZgL3dCeKG+W
	 CRbrhDTrD1RcwKQUv1kv7zFmpF17ADd21xXhwIeewwf3zNsNzAJGfBxwBb02J2/Iqs
	 VwQr8GADFXdKb7O5PJUIK4X/yNp9lQpvm1YmEB/IRGtYrNKuHMwQX6ax1YC6NKtksM
	 JA38qJpx9j5+sDTSAN3bsA1rfvXt/WLa87k99iXnvCLltt5X2pUWNQvQlLqaApzfmw
	 AgVzPVh34V8XFxh/8mAjPDztbiexYyfg/Rb9UBzX7iCG3sPAn62DS99Hl6YcwLtXbx
	 oNs+0BTfDk05g==
From: Jakub Kicinski <kuba@kernel.org>
To: alice.kernel@fastmail.im
Cc: Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
Date: Thu,  4 Jun 2026 19:37:11 -0700
Message-ID: <20260605023712.3627277-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-6-alice.kernel@fastmail.im>
References: <20260602093931.516281-6-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
udp: Support gro_ipv4_max_size > 65536

This commit allows GRO to aggregate UDP packets larger than 65535 bytes
by writing 0 to the UDP header length field (via udp_set_len()) and
restoring the real length from skb->len in udp_rcv().

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 3e92575f1d55..856c23b9d6dd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>  	if (ulen > skb->len)
>  		goto short_packet;
>  
> +	if (!ulen)
> +		ulen = skb->len;
> +
>  	if (ulen < sizeof(*uh))
>  		goto short_packet;
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 96987b1c05cd..f7da760f046f 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  	struct sock *sk;
>  	int err;
>  
> -	udp_set_len_short(uh, newlen);
> +	udp_set_len(uh, newlen);

[High]
After this change, udp_gro_complete() may write uh->len = 0 when the
aggregated packet is >= GRO_LEGACY_MAX_SIZE (65536).  How does this
interact with conntrack on the receive path?

Looking at udp_validate_len() in net/netfilter/nf_conntrack_proto_udp.c
at this commit:

    static bool udp_validate_len(...)
    {
        unsigned int udplen = udp_get_len_short(hdr);
        ...
        if (udplen > skblen || udplen < sizeof(*hdr))
            return false;
        ...
    }

For a super-packet where uh->len has been zeroed, udp_get_len_short()
returns 0, which is less than sizeof(*hdr), so udp_validate_len() returns
false.  udp_error() then logs "truncated/malformed packet" and
nf_conntrack_udp_packet() returns -NF_ACCEPT, leaving the flow untracked.

The deployment this patch enables (gro_ipv4_max_size > 65536 with VXLAN
or Geneve TCP-in-UDP and conntrack) is the very example given in the
commit message.  Should this patch also update udp_validate_len() (or
otherwise account for the zeroed length) so that conntrack does not drop
out of the state machine for super-packets, breaking NAT and stateful
firewalling?

The follow-up patch in this series, "udp: Support BIG TCP GSO packets
where they can occur" (b73c2d663201), updates udp_validate_len() to
accept udplen == 0 when skblen >= GRO_LEGACY_MAX_SIZE, but until that
patch is applied this commit on its own appears to regress conntrack for
the configurations it is intended to support.

>  	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
>  				udp4_lib_lookup_skb, skb, uh->source, uh->dest);

[ ... ]
