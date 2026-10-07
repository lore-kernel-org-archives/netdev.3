Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEA446849
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360267; cv=none; b=prKd9zUfvKJtaC37WFrSeiAe9WHjo0JCQGHu4UsJcq7MJEz/7+PGE1MveN3zT4XpE7clUAR2tpXStj3RGt7cN2Sn4EyWKClX3kwU9bLm2LSvtR5xWNjttN9t1iQQdGYQ+d7it44P6N9wdhF6870+r+isS67gSgZDJYwWOhjvLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360267; c=relaxed/simple;
	bh=wyvjXM7mtQTWdxFcAW0HBUwuMSFsvxbK+ZdXBfzYGvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb6UQ8wmS96me+WOGsPdMsII4OE4G1aHzQokodtkN6K4Z1aP9QluopEZcwGFbGXPFKQI3HWNaocH7QdAyLGNLbGa6oqiqJ87OgohyI4zZqIGHMHePRULUImBNqWKAc1TLDM/LCh6t5PCHGKUfIdpNA//10vfkcTtT/1t5ITEtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXY1zaV8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSZruztg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXY1zaV8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSZruztg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791360255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmwsvQXQ+84ynlzkoUt7OfxWOBmhleZjGu0A+S2WlUM=;
	b=YXY1zaV8CzxJy7rpmiIknHZ8A+tPfckYRlU/XQoILXC5/pURvvQUcd0Uw9RAsXjY/hZT0n
	nXjqsPLt9EdFx4YMbIxuxebeGiFd0lWy23aKSfZSB1WjbVNnhiHW4d7IqSSp6taXgvsoFU
	NSZWwD1OlHNCjMTlTFLJz+789VLW4h8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-0CId40s_Mxqea_mvaULshA-1; Wed, 07 Oct 2026 04:04:13 -0400
X-MC-Unique: 0CId40s_Mxqea_mvaULshA-1
X-Mimecast-MFC-AGG-ID: 0CId40s_Mxqea_mvaULshA_1791360252
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso27465875e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791360252; x=1791965052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmwsvQXQ+84ynlzkoUt7OfxWOBmhleZjGu0A+S2WlUM=;
        b=NSZruztgv2gBpmB2UdZbPuSyROWXWBYDkgeJM8qvBTfzwD45ObR5yNEw26r+VyDhPi
         d7a6kykrBg0tdLE8pCkJa99GTIEBuoXOFuo0tBBYqWumHs2MCk5bg69Q7MK7nh0mUifI
         eXBkOoP8VkJDldhnM2ggzgGNVFwnyOP3tQirw8RzWvLidrNG88SPW1wRCy0B5wAUShb7
         hLwffzMX+z8Sd3p6pv75ykU2tGT3kntt4Lzl7v1zuNXd+6AGpCEdTbPpUwS9w3u4IJxQ
         5kFZ46TFVJ5qJkOxLAG9MT5TFsz5Fnss0EsajfEU597v6dWfL3OtyBTKAVarjo6kZueF
         M0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791360252; x=1791965052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dmwsvQXQ+84ynlzkoUt7OfxWOBmhleZjGu0A+S2WlUM=;
        b=JWQcx/o8DpRNgwSn7+m3fCXbwyeh48oVPOqPQF7S5poqJXfawYl/FDzZjacDaAIikb
         3JD8QGO5WI5HVV3ZAZH0JxyYIFoeGE+gSBGODbzeINvO3eNtlfCGLdAYZIKXn5DYHBp9
         bbGmWYo5aF5/Mxi+pecqzvs24gEk+uJo9nBLCyXA3R7s6shR6IFr0TWjJ/+/Xzt35fAq
         EnIMbfHuCT3YVPN8QbUIAH32qeLQwvTnvwPQUweQkkzOSTQAqKv7F79xrV1bghnJ8xqS
         yDAtd0mHs+Wer8aVR9NxWf1dl/hHPitveXSOG1zU9e7K8/dgiQlXVf+hshdbG39aEnzK
         TFfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcakOYMod9mMNfDIFJ8Pd+bOcidvTYOTgs3f0DfS4fbg4asXLGoA0FpTPOjetSxr7fZa0V+y8=@vger.kernel.org
X-Gm-Message-State: AFuF++lcbUXXtxzBLe78b4KabW3e8uFtBIvFQp1+6xRbWzHZdOTjSpLv
	wxJYvxe14rgkaNAbSxGJxLMpgClKOdSAyTJqVgqql6o4Xwz4+wWP23t6xguU3YhAfL9iMbV8xJ0
	RLsmnxeU10YHt7WnJrMPE64hYSYq9E7mbII+PAWxQGL9YVe02kJq28HxEQQ==
X-Gm-Gg: AYBFou0RBoDv8V7IOhzwFkPNkVVGjxxNA1PKLBeDs35t/gLbbVYq6WJ9D6IJAgrbGdD
	IIIIptz607c7UTdck+EpWUzJK2PINz9cu4VRe9bhAmy7irEQoT3g6GdIeCq7xk1XHlGdEVsepv8
	er8xJow8Uc2baxw8pdczp2vf6q3F6sWJ7Z9nlBJfp0xg4aQ9+xK1oupUStB9KKSMTfe23iJIduf
	OWNPvkV7dcA0rs9BQr9Q5gbSOesyMpXHx+z9Oyb/V2p+QkJjEKGNVx6FK4avksMuYJdh6H1XaST
	C+RopXL/9WoGHY0bkYXN/u76ycnKnJ+3UAZjkEaO+d0tNqFxKqqHiGpV3QfHSI/4upGJ9hQ=
X-Received: by 2002:a05:600c:154a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18043b5fcmr18003335e9.16.1791360252106;
        Wed, 07 Oct 2026 01:04:12 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18043b5fcmr18002655e9.16.1791360251443;
        Wed, 07 Oct 2026 01:04:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f795f29sm44029965e9.11.2026.10.07.01.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:04:10 -0700 (PDT)
Date: Wed, 7 Oct 2026 04:04:07 -0400
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
Message-ID: <20261007035758-mutt-send-email-mst@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
 <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
 <20261006194851-mutt-send-email-mst@kernel.org>
 <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>
 <20261006201729-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lz9KSJ8Z8Fz8EF_+nmN5ea9k00sweQvvR74HpGCGwVSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-Lz9KSJ8Z8Fz8EF_+nmN5ea9k00sweQvvR74HpGCGwVSA@mail.gmail.com>

On Tue, Oct 06, 2026 at 08:30:50PM -0400, Willem de Bruijn wrote:
> On Tue, Oct 6, 2026 at 8:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 06, 2026 at 08:13:43PM -0400, Willem de Bruijn wrote:
> > > On Tue, Oct 6, 2026 at 7:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> > > > > On Tue, Oct 6, 2026 at 6:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > > > > > This series fixes a bypass of untrusted GSO flow dissection in
> > > > > > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> > > > > > > and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:
> > > > > > >
> > > > > > > - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
> > > > > > >   with min_t(u16, ...). This truncates skb->len and returns a bogus small
> > > > > > >   transport offset when skb->len modulo 65536 is smaller than the
> > > > > > >   transport offset. Offsets that do not fit in the u16 thoff now fail the
> > > > > > >   dissection instead of being silently truncated.
> > > > > > >
> > > > > > > - Patch 2 initializes skb->dev and skb->network_header before calling
> > > > > > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> > > > > > >   virtnet_receive_done(), and raw_verify_header(), removes the
> > > > > > >   '&& skb->network_header' condition and the unvalidated
> > > > > > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
> > > > > > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
> > > > > > >   so it validates the dissected L3 protocol (keys.basic.n_proto) rather
> > > > > > >   than the outer L2 protocol.
> > > > > > >
> > > > > > > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifying
> > > > > > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
> > > > > > >   flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
> > > > > > >   TAP device, that mismatched GSO types and truncated TCP headers without
> > > > > > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
> > > > > > >   accepted.
> > > > > > >
> > > > > > > v3:
> > > > > > >  - New patch 1: avoid u16 truncation of skb->len when computing thoff in
> > > > > > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
> > > > > > >    frames before eth_type_trans(), with skb->len up to 65549 for a GSO
> > > > > > >    frame carrying a maximal IPv4 packet (Sashiko).
> > > > > > >  - Patch 3: truncate the TCP header after 10 bytes so that the test
> > > > > > >    requires the transport offset found by flow dissection, and add a
> > > > > > >    65540-byte frame test (Sashiko).
> > > > > > >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-edumazet@kernel.org/
> > > > > > >
> > > > > > > v2:
> > > > > > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
> > > > > > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
> > > > > > >    NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
> > > > > > >  - Patch 2: clarify the changelog regarding why skb->network_header was 0
> > > > > > >    in those callers and why skb_reset_mac_header() is dropped in
> > > > > > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > > > > > >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
> > > > > > >    Michael's reproducer.
> > > > > > >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/
> > > > > >
> > > > > >
> > > > > > Not without trepidation about the amount of stuff we are shoving
> > > > > > into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LOC
> > > > > > of trivial code in 2019:
> > > > >
> > > > > Unfortunately that let through many bad packets and unintentional
> > > > > (ab)uses of the API.
> > > > >
> > > > > The current state is the result of numerous fixes we had to apply
> > > > > since then to protect the kernel. Generally there are two approaches:
> > > > >
> > > > > 1. make every reachable path in the kernel robust against unexpected
> > > > > input. Frequently that means checks in the hot path that penalizes all
> > > > > normal traffic, only to catch a bad actor or fuzzer. And it's not
> > > > > straightforward to prove that all reachable paths are protected.
> > > > > 2. strict input validation.
> > > > >
> > > > > With strict input validation from the start the checks could have been
> > > > > simpler (hindsight is 20/20). Unfortunately, now we are stuck with
> > > > > weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
> > > > > headers, ..) that we now have to work around and try to not break,
> > > > > that may or may not have real users.
> > > > >
> > > > > This patch actually makes the function simpler. By reducing the
> > > > > differences between the various callers of the function. This is great.
> > > > >
> > > > > It sucks how complex this function has become, hopefully we can
> > > > > find more such ways of making it simpler. The strict validation itself
> > > > > is a good thing imho.
> > > >
> > > >
> > > > Yes indeed. I have a vague idea how to do it: check some
> > > > performance-critical types of packets and for the rest just calculate
> > > > the checksum then and there.
> > >
> > > That sounds promising.
> > >
> > > Checksumming is only one of the risks. Segmentation is another.
> >
> > Same approach for segmentation would be great but how do we know how to
> > segment at input?
> 
> gso_type?
> 
> The main issue I see is that we do not have a way to then process the
> chain of segs. So maybe we cannot realistically do it at this stage.

I mean, there are what, 8 callers of this? That's much less of
a brain surgery than carefully calculating offsets within packets
as far as I am concerned.

> Come to think of it, I previously considered this and ended up with
> commit 121d57af308d ("gso: validate gso_type in GSO handlers")
> instead.


