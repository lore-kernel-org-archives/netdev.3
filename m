Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487779;
	b=s5dv2866uz+oJL1kHxoo4XYdPMZ6yuNtr0aZ6vpSkwQst3ZjHmSa4SpXKz8/IqycdbGP
	 R5qNcN/GEnzS8pCQF4PQaH1D5WlOI8Mxp7ORwfz2bs/oFh36fChrBWtq8RkC0o5roN+aV
	 c0qnhXMfZxlboB/jcCBnnAal0b0KkznOAl0gX5myoEoou0g7R2O2atRGzsafkGPImA7Nr
	 oGXdhB6uZjGD9XYFx+Efa0W9zYFioxnU8qOYDvVhoqF3aQ2j96/vNAG0vJXeUus3MzU17
	 8ubW/slkYbZhviUWflkd6LDRUGn7Xe5SzHTpuQMqVxevcEV2GnzAVxiok3CfzScjfyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=owgjM5IlEAAirr98PwLefNK0L3QScVP04Otk/jOoc+4=;
	b=Ff8if2DFoxx/ive8w5kZk3yoXC9iml3ustT4iOhCsTmZYMZ07gZmpMMaM8JYBfOm5Ogp
	 4X5BJmlbNqRGYxFm6dRXqJh91X9O532oUP96v/xY/Ca31vTRqbftI/XHU2hQkM+3g4zFv
	 TS6z+dv1/bKUTFlopjQWxJmcnIpRlvuuSu9EPaUvmCond+Hn3LIyVQrYQGfvksYWWTJz0
	 Y83vLzAvIMi5v+/pSR+YnOjQyklAZT2wRVKOuBV7MYFldoS4eBT92l3PND+h5HCzx4wyo
	 Hp6m7ZDqn9Nds7FhhsfNVtj1/t6Y3Nk3Un38JmU6F8YAjqPzJVm30kd0F5hPBsOOSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxJqk4hV;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABA606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2ABA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxJqk4hV
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c10dc41270so3976395e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794487777; x=1795092577; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owgjM5IlEAAirr98PwLefNK0L3QScVP04Otk/jOoc+4=;
        b=YxJqk4hVkLNz68hhJiev/pFunjC53VArPRMOKXpq56gi6tENKQQHvEKLPQqxBLxXtV
         16JphAeqrOwDOKNCBTi6CDQSzL7+8zQ/quXgvxtQdsWVfzKe549o/NaCxVNyrJ1RcyMC
         vsnBbCU+MG83iBVCYpl/oVv1faQN5nk1QkJRptZdYCN4x38iWT1ZY7YIqGHQRcLM+/Xb
         bD+yvtaFDDfC5dlHNCJyPojtROnlgZCMaQvGNHt8pFSQ8+ITi9uU0rNPmA7TKxk0jnKG
         OMP66yBq1ECX+vrUe6pKQAIQ5FdVOYeDbe9MbU5nROWhZLhdLhS+kw1l2aAHpdkBv3A0
         G5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487777; x=1795092577;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owgjM5IlEAAirr98PwLefNK0L3QScVP04Otk/jOoc+4=;
        b=a8IrG7aSgfIqnPjwoTv7OLi3I2mVl5i+jw9d5XyHQy4YrR+KOYkrNy+tjEB7a0aP80
         HqpMd0js/bachgMmPtGgvLmHT5D+YwvAPxU+EiioD4FvDgyxvce2rbTG8F1iiVl28gHX
         13fz/Lc7tpeBcfqpHGgieuQ255z0/o2KInmFU0pXyAjT7zTGkcINNmftyNtzQoAepack
         cT2Z3bcq8hv0WleDPwRjEwF/kHbFceQf6ayg52DqYLxEoKEtpdpy8Z81GSRdjr4j3LIf
         bnjd8sm88xwf8Gvj7Ht65d5zi5VN4U7buOj5tjajign9jOWqg5AC7aym+6yueDHOTqFT
         DE0g==
X-Forwarded-Encrypted: i=1; AL+hErHfdvZMS3ZI9eI8sw5wr9pIkN+h9tC2CKSICgGcXslwlKpPCEAhpZi6GlmvnadQx5K7xDUznB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eqoVWEiegZ4zq4wCU+7Y8W7L3XvCb47vBUnvmXBLHUyZ2CH8e
	tQx2LtSWp2MmW4udSXfa47d0AzfzA9rXbbvUjbzPJpyRyNN7BzWsHm2+
X-Gm-Gg: AYBFou2loxKWeILhPtpEKrav/Qh+5Nq0livnv/D/FUiJv3t7W6ynSl1QJUL1ZrOZcqp
	cN33W+TOaVrPu99/ibApA+yw08Lpui/6Woe18RVl9SSOehVacKD2VZAVUZnPupBw7UlRNOs0/s3
	L533PEWvbgaWvwbdXMxt5BctQAGdMvgKGvXM6f/e6KBA7h9JuxzRKvrvWx7JBh2ffOPQIXudiGK
	EebuIAj2sGwybrLpzdkLQqpU4jIUA/975X+DROOpli8ZkfkBVPDBBXHnw3TMBKBzueQReTudVO8
	ebcwWzEwv/YOrv4HMXl8A19qNiAFlpbUsT+yuog+dGSIiAN+s+mMMRvWdhhi1Jd4D1r+inwXqjD
	1eqY5E+Fex4LtU0Af12DbX1g2BlA0rzSTMxjONz+B4t2WFtB9JiK3J8Fnv/XPuvgyU60EJ9clX0
	DGVxgwgcZUSG2YE1TT262aOtM8AuPx2ORxcn27C6x1KZBlHmAqId/ZkjVS5mKCmbACaHEPXISi/
	F74hskvnMKmaZb8KIyw9PC8QslLyyCs5qZ3EB1dT7Wl7GvsDvxR9ftZ4O/yGAexz7GRkewmHw5G
	1JySUD3NxQJTqMpCH+mPf0TtuwJH6LMC5g==
X-Received: by 2002:a05:6512:b84:b0:5c1:4dbb:9fbe with SMTP id 2adb3069b0e04-5c15d5e7741mr1857704e87.47.1794487776648;
        Thu, 12 Nov 2026 04:49:36 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157ba5b98sm1582156e87.17.2026.11.12.04.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:49:36 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 07:49:32 -0500
Message-Id: <DMT8TQ6XLC6N.1BPNTVA5WTR1N@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <dimitri.daskalakis1@gmail.com>,
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/6] eth: mpnic: IPv4 and IPv6 in IPv6
 tunnel segmentation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261110-mpnic-lso-v2-5-ccd37b051d08@gmail.com>
 <179447813848.2199510.18299256518114707021@kernel.org>
In-Reply-To: <179447813848.2199510.18299256518114707021@kernel.org>

On Thu Nov 12, 2026 at 5:08 AM EST, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] mpnic_ipxip6_gso_ok() only checks the outer IPv6 header chain.
>
> --
>
> eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation
>
> This patch turns on NETIF_F_GSO_IPXIP6 for mpnic. The device can segment
> 4-in-6 and 6-in-6 packets. The patch adds the outer L3 header length and
> two new L3 types to the Tx descriptor, and adds
> mpnic_features_check_encap_gso() to reject skbs the hardware cannot
> handle.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 2a0560b7dd19e..839feb4716b60 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -228,9 +232,17 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb,=
 struct mpnic_tx_hdrs *hdrs)
>>  	else
>>  		hdrs->l4_type =3D MPNIC_TWD_L4_TYPE_UDP;
>> =20
>> -	hdrs->i3len =3D skb_transport_offset(skb) - skb_network_offset(skb);
>> -	hdrs->l3_type =3D ip_hdr(skb)->version =3D=3D 4 ?
>> -			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
>> +	if (!skb->encapsulation) {
>> +		hdrs->i3len =3D skb_transport_offset(skb) - net_off;
>> +		hdrs->l3_type =3D ip_hdr(skb)->version =3D=3D 4 ?
>> +				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
>> +	} else {
>> +		inner_off =3D skb_inner_network_offset(skb);
>> +		hdrs->o3len =3D inner_off - net_off;
>> +		hdrs->i3len =3D skb_checksum_start_offset(skb) - inner_off;
>> +		hdrs->l3_type =3D inner_ip_hdr(skb)->version =3D=3D 4 ?
>> +				MPNIC_TWD_L3_TYPE_V6V4 : MPNIC_TWD_L3_TYPE_V6V6;
>> +	}
>>  }
>
> [ ... ]
>
>> @@ -362,6 +375,35 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, s=
truct net_device *dev)
>>  	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)])=
;
>>  }
>> =20
>> +static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
>> +{
>> +	struct ipv6hdr *ip6h;
>> +	__be16 frag_off;
>> +	u8 nexthdr;
>> +	int start;
>> +
>> +	ip6h =3D ipv6_hdr(skb);
>> +	if (ip6h->version !=3D 6)
>> +		return false;
>> +
>> +	nexthdr =3D ip6h->nexthdr;
>> +	start =3D skb_network_offset(skb) + sizeof(*ip6h);
>> +	start =3D ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);
>> +
>> +	return !frag_off && start =3D=3D skb_inner_network_offset(skb) &&
>> +	       (nexthdr =3D=3D IPPROTO_IPV6 || nexthdr =3D=3D IPPROTO_IPIP);
>> +}
>
> [Severity: Medium]
> Can a nested tunnel still get past this check?
>
> mpnic_ipxip6_gso_ok() validates only the outer IPv6 header chain up to
> skb_inner_network_offset(). It never checks that the inner L3 header
> leads straight to the L4 header at csum_start.
>
> Some paths reset the inner headers on an skb that is already
> encapsulated. One is bpf_lwt_push_ip_encap() in net/core/lwt_bpf.c:
>
>     skb_reset_inner_headers(skb);
>     skb_reset_inner_mac_header(skb);  /* mac header is not yet set */
>     skb_set_inner_protocol(skb, skb->protocol);
>     skb->encapsulation =3D 1;
>
> For an IPv6 outer header with nexthdr IPV6, handle_gso_encap() then adds
> SKB_GSO_IPXIP6. BPF_LWT_ENCAP_SEG6 via bpf_push_seg6_encap() looks
> similar.
>
> One way to reach this is an ip6_tnl device whose underlay route has an
> LWT BPF xmit program that pushes another IPv6 header:
>
>     ip6_tnl xmit (encapsulation=3D1, SKB_GSO_IPXIP6)
>       ip6_finish_output2()->lwtunnel_xmit()->bpf_xmit()
>         bpf_lwt_push_ip_encap()   (inner headers reset)
>
> The packet then looks like this:
>
>     outer IPv6 -> middle IPv6 -> innermost IPv4/IPv6 -> TCP
>
> Here inner_network_header points at the middle header. So
> mpnic_ipxip6_gso_ok() sees an outer v6 header, nexthdr IPV6, and
> start =3D=3D inner offset, and it returns true.
>
> The skb is DODGY, so validate_xmit_skb() runs software GSO validation. Th=
at
> recursion ends in tcp_gso_segment(), where skb_gso_ok() succeeds against
> hw_enc_features and NULL is returned. The skb then reaches
> mpnic_xmit_frame() unsegmented.
>
> mpnic_tx_fill_hdrs() would then program o3len =3D 40, i3len =3D 80 (or 60=
 for
> an IPv4 innermost header), and L3_TYPE taken from the middle header's
> version.
>
> The descriptor only carries OHLEN and IHLEN. Would the hardware then
> skip the per-segment fixups on the innermost header, i.e. IPv6
> payload_len, or IPv4 tot_len/ID/checksum? That would put malformed
> segments on the wire where software GSO would have produced correct
> ones.
>
> The v2 changelog says nested tunnels under an IPv4 outer are now
> rejected, but this layout still has an IPv6 outer.
>
> Should mpnic_ipxip6_gso_ok() also check that the inner L3 header ends
> exactly at skb_checksum_start_offset() with TCP or UDP as its protocol?
> For IPv4 that is ihl * 4. For IPv6 that is the header plus any extension
> headers.
>

This suggestion is insane. I thought I could count on the stack to not
reset the inner headers more than once and handle nested encap like
iptunnel_handle_offloads() does, but I wasn't aware of these two cases
with LWT and seg6 encap...

It would be helpful if we could establish a definition about what the
inner headers of an skb refer to, or otherwise put some other bit of
metadata on the skb so that drivers don't need to parse the skb for
these cases.

>> +
>> +static netdev_features_t
>> +mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t f=
eatures)
>> +{
>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
>> +	    mpnic_ipxip6_gso_ok(skb))
>> +		return features;
>> +
>> +	return features & ~NETIF_F_GSO_IPXIP6;
>> +}

