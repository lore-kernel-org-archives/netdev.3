Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B83E63AE
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330609; cv=none; b=S45W0aK8LafIUO36QzBc/BaZ4r43wSKX0758AdXIlV4IrTU9OA6raqiOOHzx0YNHJdGflZPeNax1YS9zqTEBtfhWVwIJKya96dc+DEoDB+ANSlgvyXeBKRmYrE5V/eJpYMi65T5DasORbNYZ3VQvZKSEWuNAp1oiKAHM2NyopI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330609; c=relaxed/simple;
	bh=XzYP3vGPqSJFhA/VBQIqyLMN8XIaEmifsxr03+/yxnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSxEEBdpyN44IzQ7WXPD/ICh+hEfmEykRMZY/+gx/Pf+4gupXRwnWJBcL9BCc02CzjKplGiVrvCUI5gWjko6gYUnYFtPDwn/Mzau2PqxMtdRGzDfQ4P1o0vxTgoY7b8Kp0E/ne+hKG1TNAt+4hJ8m5WpTAWnvb6KwDV2kTffn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+iyXRSp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJXc5SaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+iyXRSp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJXc5SaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791330607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbVYFAx11ftCNKpUYlehSptFsjph+/37825gxnL+w08=;
	b=M+iyXRSpynXpItjV/IRLOV0iVDOuICZh/ZKV50OwL93Jtdo8twoM5auv8PlCj0clj+UOAb
	GclXJxU85gHPLpe6jMhrUAsxb4bw9mOEoL7XWgk6SIAPeEgzRcdRlqXHRRiVxJpx64Qf8O
	R0cvtHVUzvfnFGu8aXHmm15wTY7+clk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-56BUH8RpNDS_Iw3iwsDgMw-1; Tue, 06 Oct 2026 19:50:05 -0400
X-MC-Unique: 56BUH8RpNDS_Iw3iwsDgMw-1
X-Mimecast-MFC-AGG-ID: 56BUH8RpNDS_Iw3iwsDgMw_1791330604
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so27353315e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791330604; x=1791935404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbVYFAx11ftCNKpUYlehSptFsjph+/37825gxnL+w08=;
        b=bJXc5SaTa9gYZ/hYGrFlEnk4XXAIRJmlghOc3wztBfsU5sJxWIwacXWd3ux2jUX46V
         nORsEjakGf+1pYWi5gJKSNo5wNGhwJCRs4y+yT3b8HcwYaiUcN80cuhz4pGjN/SmBcF0
         xYSw3NZSWnzERCssJ12IYw1rJz39W2FKqCTh3JoUJR3iUcD+r+KSnwWAsCFpdAugddag
         EK/JUr8zgb/2+pbkB7yE4IDfUwNungoDEpRdLxfN/NFgTvYXLEy+jkXEj/W20oMyfCdN
         lVV0JwMQafIETRftyB9hyeMRnXvW6T2DJQVJUBQ9yT4kerObx3r+Bm1SU1QQ06jAO8kE
         C40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330604; x=1791935404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BbVYFAx11ftCNKpUYlehSptFsjph+/37825gxnL+w08=;
        b=OOhH2TxRbPp3F2PbuWJ8yXNeStJHSkQfCvlKfYAnY1EiHtjQEZyWMqktO6/JLewm/I
         cWDKStSrrwthbFxN0589ISFtaG3T2W6AL3vETQzd9a+iRFw/JqCwHT7FljHeUU+OjPRm
         u5XbOT4y1jFGXtg35schH+09nfHVbi+A+T9OwpBU1RjDdtFBEy6lJYPaFtOd1Gaky53T
         HxHoi9SaV65ySQClAhJ6HceqXtWjX+lHh+krnerhTmyOfnfECQdP5czXY6wrFYGxT4xk
         Bdb9wdPV+tHqbI7YuwAdZw5SqaeyzAX+mF4aCj6sCVYYe9VkGaWirM2HFgcqas6h+8Q5
         xXkg==
X-Forwarded-Encrypted: i=1; AKwUvBw1eU7Q0kz5i77/eKEtjXZV3oRhKR7yk23EixlFkS4xKtSbLuyaYQcapcM1iBwyBfw/8vjUoLE=@vger.kernel.org
X-Gm-Message-State: AFuF++lAchEDN936rZg3utWhj8oPQdl+xuA08AOf/U2dhyoNcd2LeH1r
	ER2ukOrojTlzS/B5joPTfLRKllL7OteG8kCUgaY8GQAjvG6WpOdNZvriDqGuXz/FxBofNomYLaI
	3TIuBmNtMpAp3BTDZRKJ0aKHZk8qstmBTODGAtLMkURfcWy0ISWMwtlQQRA==
X-Gm-Gg: AYBFou1TD2NbPwIXpY92JSS7TSeX3OwxaZa++VOXthJ6tRRjV9fkxbqTCf4wnrFYQZN
	ey+P4L4M+RgrxcBKDwyxhr60YXuN5OieU6O97RQxE6OW8XSweHKl+OENdnoVfvwmEyKoCIgLz7A
	/cWXb4mvHPlrTQRHwVRIepr8IyEo0m4IyX7QQwRHvwrcx76To3QmqKlBTn/c/cmt+oNcQ+bMd01
	weynesHfgw0NPU6jaL4ZcJ8WBqEDRSliCVgiC+f99/AfvwAMmrwasKcnQdDSrPY8p4zlFPLfWV6
	8NK4U8YI1z5m226Him9RgmkowAzjU/cRaGL1W9+IqF84vqnZXyeBaiSJtJ9EoEQmuwXlt3g=
X-Received: by 2002:a05:600c:4ecf:b0:4a1:7d08:780e with SMTP id 5b1f17b1804b1-4a1800ca15fmr5367465e9.1.1791330604497;
        Tue, 06 Oct 2026 16:50:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecf:b0:4a1:7d08:780e with SMTP id 5b1f17b1804b1-4a1800ca15fmr5367075e9.1.1791330603878;
        Tue, 06 Oct 2026 16:50:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f557bcbsm29287545e9.9.2026.10.06.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 16:50:02 -0700 (PDT)
Date: Tue, 6 Oct 2026 19:49:59 -0400
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
Message-ID: <20261006194851-mutt-send-email-mst@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
 <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>

On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> On Tue, Oct 6, 2026 at 6:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > This series fixes a bypass of untrusted GSO flow dissection in
> > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> > > and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:
> > >
> > > - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
> > >   with min_t(u16, ...). This truncates skb->len and returns a bogus small
> > >   transport offset when skb->len modulo 65536 is smaller than the
> > >   transport offset. Offsets that do not fit in the u16 thoff now fail the
> > >   dissection instead of being silently truncated.
> > >
> > > - Patch 2 initializes skb->dev and skb->network_header before calling
> > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> > >   virtnet_receive_done(), and raw_verify_header(), removes the
> > >   '&& skb->network_header' condition and the unvalidated
> > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
> > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
> > >   so it validates the dissected L3 protocol (keys.basic.n_proto) rather
> > >   than the outer L2 protocol.
> > >
> > > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifying
> > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
> > >   flags = 0 and flags = VIRTIO_NET_HDR_F_DATA_VALID) are accepted on a
> > >   TAP device, that mismatched GSO types and truncated TCP headers without
> > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
> > >   accepted.
> > >
> > > v3:
> > >  - New patch 1: avoid u16 truncation of skb->len when computing thoff in
> > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
> > >    frames before eth_type_trans(), with skb->len up to 65549 for a GSO
> > >    frame carrying a maximal IPv4 packet (Sashiko).
> > >  - Patch 3: truncate the TCP header after 10 bytes so that the test
> > >    requires the transport offset found by flow dissection, and add a
> > >    65540-byte frame test (Sashiko).
> > >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-edumazet@kernel.org/
> > >
> > > v2:
> > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
> > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
> > >    NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirkin).
> > >  - Patch 2: clarify the changelog regarding why skb->network_header was 0
> > >    in those callers and why skb_reset_mac_header() is dropped in
> > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
> > >    Michael's reproducer.
> > >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-edumazet@google.com/
> >
> >
> > Not without trepidation about the amount of stuff we are shoving
> > into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LOC
> > of trivial code in 2019:
> 
> Unfortunately that let through many bad packets and unintentional
> (ab)uses of the API.
> 
> The current state is the result of numerous fixes we had to apply
> since then to protect the kernel. Generally there are two approaches:
> 
> 1. make every reachable path in the kernel robust against unexpected
> input. Frequently that means checks in the hot path that penalizes all
> normal traffic, only to catch a bad actor or fuzzer. And it's not
> straightforward to prove that all reachable paths are protected.
> 2. strict input validation.
> 
> With strict input validation from the start the checks could have been
> simpler (hindsight is 20/20). Unfortunately, now we are stuck with
> weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
> headers, ..) that we now have to work around and try to not break,
> that may or may not have real users.
> 
> This patch actually makes the function simpler. By reducing the
> differences between the various callers of the function. This is great.
> 
> It sucks how complex this function has become, hopefully we can
> find more such ways of making it simpler. The strict validation itself
> is a good thing imho.


Yes indeed. I have a vague idea how to do it: check some
performance-critical types of packets and for the rest just calculate
the checksum then and there.


-- 
MST

