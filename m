Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412155;
	b=kB+QFDtQXg3Dr/wh25hnE7HLC/QFrIJY337BJV89r7vokyXpdI2Zzkchqh6Q8hWck1E2
	 FYk5cpNZcHMwwJNmmiy8JuA/s2V3znWQX7i/A25fGC4j/kc+UPh5GcpWqcQwomBDQCMrQ
	 svYd4ntlqbdYQZORmAm9l+pGwiCH5KUs8dob4UrBcso0gelMiP8E+BAiPao1HgDmLydwC
	 beARnc4nctFnQyFL8rkkprFnK0YF+92bm5WqNQ3V03aeP9y4THT8Q2NFoUShYxz2WZNTj
	 NLHnjzpfBD+GVKNIrCBy2ZDiUyk9cq9cdaNxt6xWjAYRyCr79s6SBrHgEB9ER+O9Gww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412155;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
	b=rV04Kq3UWZKdhnazhc5qeZMffGnLFji69oauqKIKNaN9Nh/+q7hMBIITWUzzm9SLBo0O
	 bT35Jwu9UEv6OSJtjb6y/TyFnx+XIX7CxZOnerH4MocL8u1AxEKUg/bVHnCgpFl53JtQy
	 0OQOHAoY+d9r3c0PEm7X6yKlNHkeNXtumbOKNK56hsXZFmadi64JLr/DJXmpLoM8348eP
	 cFcuphGLFkFmHr3HvcueR908QkACeWujLl+kor9E+uhfQHepJ0eMX4BiStHXjRaU76Bim
	 8j4BzPZyGdLrxKb+8bOkXjRoWj8I6nzW/vO0DZQfIeMHfiynVqvqdt1tSRDtTuaNg/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XuyISIbC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sWYYTTHF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A8606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XuyISIbC;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sWYYTTHF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794412153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
	b=XuyISIbCrnllSFaW4C0POERFtddlFaQH9dZ2XJkGmx8TCwUBCDQJAFiT89/7boJ14Lu0VR
	/Qim7B5huAveqIuKjTNy9dUnYLrC0iUqo6MQBOyorPcUvNnB4nnLNUQ1diEKqFtTcoGl/h
	6QkEDJfhmfX8tiDw+VOsCjUeTO7KVYg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-M5QPqo16PwyoVRI1zVf4uA-1; Wed, 11 Nov 2026 10:49:12 -0500
X-MC-Unique: M5QPqo16PwyoVRI1zVf4uA-1
X-Mimecast-MFC-AGG-ID: M5QPqo16PwyoVRI1zVf4uA_1794412151
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490c1867460so2535829f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794412150; x=1795016950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
        b=sWYYTTHFxFkChOge2dL3RnJ6C9vwyuLF5f8Bgy1itS1v5gW+S3RjMHGUX2cH2b2Xw2
         wGpixVsvmNgcX+lxNPmD5np+dyycD66cBUlcniLuS7FnVkvVvzXZXLL7Qm6/yrpTxrmL
         l+j7U1Ns7XWzTczrrMhN/2jTJmmf/ZBmJ/YN6WayiM8IMWwauQxfBIl8i4jm391Qj7I6
         /jxpFdV5l3JFr1na4oj89wmd0vsJM4CnUtjgnOkAHj/3TMC6/gLqf7upqDvvy/czaqow
         Ev1h5QgrH/6ci2sIibfyjvvdn0iviWOJFGZzfiS+Ng4Cm4O7EUc5fGuG6ulTYpDr6Wnp
         y1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412150; x=1795016950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
        b=xMG79HMlilUu6WEE+K/U+sT++SlnqqIukzzsv4S53tvFHXFqff+uvZvyqqPgmkbK8p
         toGqaqJarNjN2bqkRvOgBrEtX9jWUn/c3uK0KyTi4kyX0VFgl9EIMVBY78Hh0bgS/Nvn
         naljE1aCyuZgW0FJrHJVChCo1c4rAoRYlHSq8/rJ9mh6oLEGjbsnQeKhX2smzMfU+jKO
         r9Kvw79hwKaMmo2IPHBfLvdVZMYjn7b4odOevIopEbyjd+FiCDnky4RnRRI0Sz+BXVej
         h3H4QohC12eGMDSuw/Z2q7REMfSPwKCyDnYkGQ4u6cifnmpVEXKzYEfMRukaDQZsMW2m
         +LRw==
X-Gm-Message-State: APuU4Z/uEOYVfgIrxNCN/oPSsyC5Sh8VJwG0XPaUDCe4FoRqgeSxVaa+
	d2hCK8ouPP2EK3Qf9gv8XVJrA9T4DEOK0aJtYXd8c1F8kr53W2hoGyuqM/LHCw5icDCSI9kAMQo
	l1k+TNevbD5Whv9aso5mzdprpzpy/niOFxEFVIAa0VMRjYLEerzoiw/3f+A==
X-Gm-Gg: AYBFou1CId5XnwfUc74lCTBmafJYJXtmK+d61qZWHzWJZSGqYi3oHe7f2Dn+v5hL38x
	llB0pCZeVxTToujFT4JnbLEZzeNrwaF0eHvXoylpSxcX07wQZiFMy6Lwy6P0zKOPqo/sMyTN8+1
	G4m3YFyyes4VXG8y78ko0IV/GEoJ6yE6XJPCjjfhDw24NiTWijOd2wp8RgzdaEB1IkTUUpAhBTp
	TlX/b7h0stmwgRa1nkohe793oIegfjFm6B6rS2993j8uGnOifmbetqeeyw7cIKBYoJkhmchrck/
	OaGI3elbbo9QgF1HVk7L/F2OjpRglOElIPOpMXD3P7PLWbiR76G4Hey8ucDD4IbjCZBeyq60G76
	P8jVHLUzxIdXmD0fVXMCjZENrZuS6I9SHwcVf34rlpA==
X-Received: by 2002:a05:6000:2612:b0:490:2bd4:5c42 with SMTP id ffacd0b85a97d-499c86a110cmr4320641f8f.44.1794412150117;
        Wed, 11 Nov 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:6000:2612:b0:490:2bd4:5c42 with SMTP id ffacd0b85a97d-499c86a110cmr4320595f8f.44.1794412149503;
        Wed, 11 Nov 2026 07:49:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498357648f0sm12253487f8f.12.2026.11.11.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:49:08 -0800 (PST)
Date: Wed, 11 Nov 2026 10:49:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitrii Iakunin <zeil@nebius.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
Message-ID: <20261111104557-mutt-send-email-mst@kernel.org>
References: <20261111120448.49979-1-zeil@nebius.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111120448.49979-1-zeil@nebius.com>

On Wed, Nov 11, 2026 at 12:04:52PM +0000, Dmitrii Iakunin wrote:
> Commit 6785011f8b16 ("ipv4: validate checksum_start before completing
> checksum") added checks so that malformed CHECKSUM_PARTIAL metadata
> cannot make software checksum completion write the folded checksum
> into the IPv4 header.

... after validation but before ip_do_fragment received?

> skb_csum_hwoffload_help() completes checksums in software when the
> device features cannot satisfy the request (e.g. via validate_xmit_skb(),
> ieee80211_tx_skb_fixup(), openvswitch queue_userspace_packet() or
> ppp_bridge_xmit()). Packets built by AF_PACKET with PACKET_VNET_HDR or
> by tap with VIRTIO_NET_HDR_F_NEEDS_CSUM can reach it with a csum_start
> that points inside the IPv4 header, and this path was not covered by
> the earlier validation.

And so what? it doesn't go to ip_do_fragment. if af_packet
wants to inject malformed packets, it already can.

> 
> At the sw_checksum label, for IPv4 packets, require the fixed IPv4
> header to be pullable and reject csum_start values that fall before the
> end of the IPv4 header. Return -EINVAL so callers drop the packet.
> 
> Unlike the sites added by that commit, this path cannot rely on
> earlier validation, so:
> 
>  - Locate the IPv4 header at the depth returned by __vlan_get_protocol()
>    rather than at network_header. After skb_vlan_untag() pops only the
>    outer tag of a QinQ frame and the skb is redirected by tc mirred or
>    bpf_redirect, network_header still points at the inner VLAN tag, and
>    ihl would be read from the TCI.
> 
>  - Reject ihl < 5. ip_rcv_core() has not checked it on these paths, and
>    with a sender-chosen ihl of 0..4 a csum_start inside the fixed 20-byte
>    header would otherwise pass the check.
> 
>  - Skip the check when the network offset is negative. On the PPP
>    channel-bridge path (L2TP or PPTP), the outer headers have been pulled
>    while network_header and protocol still describe the outer IPv4
>    header. The IPv4 header of the packet being checksummed cannot be
>    located there, and those packets used to be forwarded.
> 
> Hardware-offloaded checksums and SCTP CRC handling are unchanged.
> 
> This change only covers the software fallback in
> skb_csum_hwoffload_help(). Other places that call skb_checksum_help()
> directly are not covered: drivers that fall back to software after the
> core offered hardware offload (e.g. wireguard, igb, tg3), and core
> callers such as xsk tx_sw_csum and netem corruption.

what does this mean?

> As the earlier
> commit notes, validating the metadata on input remains the complete fix.
> 
> Cc: stable@vger.kernel.org
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
> Assisted-by: claude-opus-5.5
> Signed-off-by: Dmitrii Iakunin <zeil@nebius.com>
> 
> ---
> v2:
> - Locate the IPv4 header using the parsed VLAN depth.
> - Reject IPv4 headers with ihl < 5.
> - Skip validation when the network offset is negative.
> - Narrow the subject and document software-fallback paths not covered.
> - Update the Fixes tags to identify the original introduction points.
> 
> v1: https://lore.kernel.org/lkml/20261102140633.42564-1-zeil@nebius.com/
> 
>  net/core/dev.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b0334..fafcb8f7ff9b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4111,6 +4111,9 @@ static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
>  int skb_csum_hwoffload_help(struct sk_buff *skb,
>  			    const netdev_features_t features)
>  {
> +	__be16 protocol;
> +	int offset;
> +
>  	if (unlikely(skb_csum_is_sctp(skb)))
>  		return !!(features & NETIF_F_SCTP_CRC) ? 0 :
>  			skb_crc32c_csum_help(skb);
> @@ -4130,6 +4133,26 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  	}
>  
>  sw_checksum:
> +	offset = skb_network_offset(skb);
> +	protocol = skb->protocol;
> +	if (eth_type_vlan(protocol))
> +		protocol = __vlan_get_protocol(skb, protocol, &offset);
> +
> +	/* Use the parsed VLAN depth: network_header may point at an inner
> +	 * tag. If the network offset is negative, network_header refers
> +	 * to bytes preceding the current packet data and cannot be used
> +	 * to locate the IPv4 header being validated.
> +	 */
> +	if (offset >= 0 && protocol == htons(ETH_P_IP)) {
> +		const struct iphdr *iph;
> +
> +		if (!pskb_may_pull(skb, offset + sizeof(*iph)))
> +			return -EINVAL;
> +		iph = (const struct iphdr *)(skb->data + offset);
> +		if (iph->ihl < 5 ||
> +		    skb_checksum_start_offset(skb) < offset + iph->ihl * 4)
> +			return -EINVAL;
> +	}
>  	return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);
> -- 
> 2.52.0
> 
> 

