Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5D2628D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332340; cv=none; b=fpyNKSlU5WWZ6R1sXzBKjBSXhL/7BJrHwPnWymvrbNGKVOaonEZAlIA0UFJM/3ZAEtM34OwVY5k3TjZLI0bVgr21KA06AmXfrCLkkzxs77hjX/V+pzIH6rdzdlb0elgnpFoFbPlJb+9ntFzW/x5kIsLAUqibvL6cfZOgb/K1i+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332340; c=relaxed/simple;
	bh=E0qSrFYqW8v/nLft21cyHFC5BZgnsK/NXQ7egvBH5L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUDKSqnfqfrxyh46tThnuX5JeD6308KEXtbCI8SQiacqL0OBZV693PvVKqbUnGjXGDUWdC20+vlobm4qAS9u2f+U/XtUwQiVq76VoPAaL58DwHd4QriTVjLXTuV8rSn6zJM6Si5gSj55gBEZ4vzJh7jTZsJ68oO8gu5zr6iUP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apsc95i9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dopbnjn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apsc95i9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dopbnjn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791332337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVQUH2Fpz1okKuYnOLuVDdaJetai0oLZCdWOE2X6+B4=;
	b=apsc95i9UQRKdUELq97ETZJjhgb84Zq9KJdmhOWE4BfEZw6H7RtRCr2TCfW4eFtjQYJP2L
	IPpA001PFPciyZxQ1YoG1LmnV7LwcqSkpcueyc5om34NXD824uPJt8Ng46p94BquoxhoWO
	WCvnmqrvEVVz9PQXFEMrGOQA0ZBSBmQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-wmj-q2BzP-CgM5T_peqcHQ-1; Tue, 06 Oct 2026 20:18:54 -0400
X-MC-Unique: wmj-q2BzP-CgM5T_peqcHQ-1
X-Mimecast-MFC-AGG-ID: wmj-q2BzP-CgM5T_peqcHQ_1791332333
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4887e5afd67so2795814f8f.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791332333; x=1791937133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVQUH2Fpz1okKuYnOLuVDdaJetai0oLZCdWOE2X6+B4=;
        b=Dopbnjn+x6rjMd1qq4fjczX5v7YueIdeO+rVRbq0QJ1UoPgIbbShAolxyZNFNT13Ae
         69yFdYqk0TOAFYmvfcVDD2TxZXBvk2vicEp+fQWGKWJY7tYSSELeVRc7jdButLuX7pvV
         RAww05ZSAqjP9r5anSl+3j0lYcfXs930TmJKfHK/qlat+xWPu/hmD02vwlEWrrdu7zP6
         jHsH+apUkBCH19yaYCV6aBT5k6uDMXLQHmsCurjzXf3S6stWNPqmgs67oEwWvN4++iPF
         sp+KJP1iKitUiLqhdB7rYy25hfUjHGdxffJ27NRNLQtFzH1iBJmtoST7Q286Q1v7LQsQ
         hfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791332333; x=1791937133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FVQUH2Fpz1okKuYnOLuVDdaJetai0oLZCdWOE2X6+B4=;
        b=AgxkmgHDNI5YBF/ARv2PhppEc/jTMCrA6FFu5Xc+dUmBA1K5S8MEVFVDH3l5AIs2PA
         +ZuXBrdyShQSFXZvQtHCgYfDnnpk06HJpNyqTDPxEpHw3Br9eeupmnhtvKlzG7iGX+o5
         2o+ybQQnqF7X/jPMbywpV0j8kke+MAAAA2UtpjUAgw8zBBqe9GlUniywxbTd5GMiDcea
         niix/+WVmtccgfPNrCcEzKFKqAzFm/hfkZKyZ1a7BMSWw+GkQtGbDmsH1C15xvXpYnrp
         HnaIpzrja2CqAuIZ+Gc5MpbujflTiOGWfcBTaIacr3fYZyhuFsZGRkyaSpLjaiAfUhNA
         OFKw==
X-Forwarded-Encrypted: i=1; AKwUvBytNXropEDV5mQQw2WzCgYupSH0t8a+Xl8vB4ekY6MUkvW294FF1+75jkISzfMHpzm+vsuDYEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4OB+DRcmO69Ffh5NK4jIiTHA/kadNyOBZSPe2KDKeFxeNHNtD
	zm5C6HTXyVZuJrdgwDMbKCbeK2Cmfa3QY0IXOPggMii+Nbahhs0/se9iRtI4ZkjRXmaIYaacC1j
	T5Z30zeUx4f89ndLs7pSGiYxXFDcRe+5B2XrqQiOfoG5qI2Hvo1Uy32oixA==
X-Gm-Gg: AYBFou17y2Df+DHTkJ3zwleotNK1t/QTCdVVAdKRg6Idm3CP7UukIzy/J38lt9P5NY4
	0ZMAMMlmQOj0V+QtvDAvtlsHIy/Bo2aO/VmjdcQz76r/mCUzhw21/vyjEVUr6j+/hGYQBFpv6dx
	ViwZVrND6WZXMo35JjyJuZTyn5ZHn5ZtRuutVQCsaSmw6bMxwzgzkGwmq8C7B2MInO4E3u2U4NX
	BzTigPeuuwXJw2VNJZOBqru6GZtyqe9ZxnirBMGHjfnzoSwIBm10pIQd2w+YHAv0iroMIEvv4i3
	a1+MxW/mb922Ybl/Bve8BccwtV8F3oYargjq9bDs0oYSXuvjIep60rAUnyRi9nxdF3q74fA=
X-Received: by 2002:a5d:4fcd:0:b0:48a:f3c6:7bfa with SMTP id ffacd0b85a97d-48c728976d8mr891087f8f.52.1791332333263;
        Tue, 06 Oct 2026 17:18:53 -0700 (PDT)
X-Received: by 2002:a5d:4fcd:0:b0:48a:f3c6:7bfa with SMTP id ffacd0b85a97d-48c728976d8mr891066f8f.52.1791332332756;
        Tue, 06 Oct 2026 17:18:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3032csm2041365f8f.45.2026.10.06.17.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 17:18:51 -0700 (PDT)
Date: Tue, 6 Oct 2026 20:18:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
Message-ID: <20261006201729-mutt-send-email-mst@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
 <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
 <20261006194851-mutt-send-email-mst@kernel.org>
 <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>

On Tue, Oct 06, 2026 at 08:13:43PM -0400, Willem de Bruijn wrote:
> On Tue, Oct 6, 2026 at 7:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> > > On Tue, Oct 6, 2026 at 6:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > > > This series fixes a bypass of untrusted GSO flow dissection in
> > > > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> > > > > and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:
> > > > >
> > > > > - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
> > > > >   with min_t(u16, ...). This truncates skb->len and returns a bogus small
> > > > >   transport offset when skb->len modulo 65536 is smaller than the
> > > > >   transport offset. Offsets that do not fit in the u16 thoff now fail the
> > > > >   dissection instead of being silently truncated.
> > > > >
> > > > > - Patch 2 initializes skb->dev and skb->network_header before calling
> > > > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> > > > >   virtnet_receive_done(), and raw_verify_header(), removes the
> > > > >   '&& skb->network_header' condition and the unvalidated
> > > > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
> > > > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
> > > > >   so it validates the dissected L3 protocol (keys.basic.n_proto) rather
> > > > >   than the outer L2 protocol.
> > > > >
> > > > > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifying
> > > > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
> > > > >   flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
> > > > >   TAP device, that mismatched GSO types and truncated TCP headers without
> > > > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
> > > > >   accepted.
> > > > >
> > > > > v3:
> > > > >  - New patch 1: avoid u16 truncation of skb->len when computing thoff in
> > > > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
> > > > >    frames before eth_type_trans(), with skb->len up to 65549 for a GSO
> > > > >    frame carrying a maximal IPv4 packet (Sashiko).
> > > > >  - Patch 3: truncate the TCP header after 10 bytes so that the test
> > > > >    requires the transport offset found by flow dissection, and add a
> > > > >    65540-byte frame test (Sashiko).
> > > > >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-edumazet@kernel.org/
> > > > >
> > > > > v2:
> > > > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
> > > > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
> > > > >    NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
> > > > >  - Patch 2: clarify the changelog regarding why skb->network_header was 0
> > > > >    in those callers and why skb_reset_mac_header() is dropped in
> > > > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > > > >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
> > > > >    Michael's reproducer.
> > > > >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/
> > > >
> > > >
> > > > Not without trepidation about the amount of stuff we are shoving
> > > > into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LOC
> > > > of trivial code in 2019:
> > >
> > > Unfortunately that let through many bad packets and unintentional
> > > (ab)uses of the API.
> > >
> > > The current state is the result of numerous fixes we had to apply
> > > since then to protect the kernel. Generally there are two approaches:
> > >
> > > 1. make every reachable path in the kernel robust against unexpected
> > > input. Frequently that means checks in the hot path that penalizes all
> > > normal traffic, only to catch a bad actor or fuzzer. And it's not
> > > straightforward to prove that all reachable paths are protected.
> > > 2. strict input validation.
> > >
> > > With strict input validation from the start the checks could have been
> > > simpler (hindsight is 20/20). Unfortunately, now we are stuck with
> > > weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
> > > headers, ..) that we now have to work around and try to not break,
> > > that may or may not have real users.
> > >
> > > This patch actually makes the function simpler. By reducing the
> > > differences between the various callers of the function. This is great.
> > >
> > > It sucks how complex this function has become, hopefully we can
> > > find more such ways of making it simpler. The strict validation itself
> > > is a good thing imho.
> >
> >
> > Yes indeed. I have a vague idea how to do it: check some
> > performance-critical types of packets and for the rest just calculate
> > the checksum then and there.
> 
> That sounds promising.
> 
> Checksumming is only one of the risks. Segmentation is another.

Same approach for segmentation would be great but how do we know how to
segment at input?

> Perhaps the general idea can be extended: harden the kernel to the
> small set of well known types, strict validation and even processing
> for the long tail of other traffic.
> 
> I'd even (optionally, maybe behind a sysctl/static-branch) run
> flow_dissection to ensure the packets are what they claim. When
> only unencapsulated TCP/IP is expected, this is cheap enough. And
> it avoids the manual sort-of parser code that we have now.

