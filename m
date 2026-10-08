Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433643744A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492937; cv=none; b=ENBkVpfdHeZc//dp15vTx5ycE4fdDzx6zkD3zQmQWyYr92R9HgTBRQGPxdLnFGun7ygi7quQbFnfy6RHklHoQM+HtP5hkuSTn1eGPx2JZIZWXLC/Stbx/oUSUDj9O1xIfA0Kw8+z5+8Lh1v73eML0qVlV8+ywEgx+8xyc62LFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492937; c=relaxed/simple;
	bh=RCR8v4wg6zIPpIM3hQwfQY8v+AHrUv+LbEfH8bQfkvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWiu+cySoVKH8wzhgKeENcezIqjSZ4EZPbPOkWPj3QMKv31+pNSzjm6zeP4uBnyOpqEL0BoDHKQ852vPxn0vGQAQz+gI/XRFN7tYrNFUi0oU1tiAse0kTGqUHaTM/dE5tMKpwDtqcnnb5yZR7Rgfxhqqdz7WpgxPTLVjT3/bJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4tWwjP3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZzIT4k5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4tWwjP3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZzIT4k5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791492934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cfbwxn7zYHza8U/eEiEC8IUyIDZgGYMEYuC3CC9wS+Y=;
	b=I4tWwjP3+aW4UJ1erdvwkkg4zR0ustAR4kHeuhoLBun7f4/W9cLPeR3Z6+2YIBoFv2HP5D
	O6yWeGzo4snLEV1S/dzVAcqnlx6ntSxWDwfrMKOFEHnHMxsW8WV1O239MLeKUQu4/FjYDG
	l/JmTN396K9aKwwvXZCCB2WGiAuIAx4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-fxjaOKFrP8CPNhVO4S5Z8A-1; Thu, 08 Oct 2026 16:55:31 -0400
X-MC-Unique: fxjaOKFrP8CPNhVO4S5Z8A-1
X-Mimecast-MFC-AGG-ID: fxjaOKFrP8CPNhVO4S5Z8A_1791492930
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso29592265e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791492930; x=1792097730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cfbwxn7zYHza8U/eEiEC8IUyIDZgGYMEYuC3CC9wS+Y=;
        b=TZzIT4k5JPwWiiXmhZUU4JruSML3rz07I1LG3QDkwgySHmKq1WhbaOZsIC68wCmvXF
         oHuERsov3nEn1IcZ4uSt2bTh5bl0fehDJsm5QF3rob9oxzweNFPH5MyZXgLevQwoGX1o
         xKpsWLkA6pLh/FjrK3gYDhXJR1IifNV/anqa3U+1vXPnjKtyCnwa5KVNC2qCbG7YaUD+
         bgPL4p82ieZY2pc71y8MkDJ07n1PoYCEn8ZVH/g5y9DqBQcUDTuDS1V+J3w2aLBsPJAd
         vm+0QmKEJnB2ZV61xXEtL/dtHlpQOyHsIqbq6Rl0EVbLlvlpvwOi0gXNsFLoXCLJVWfH
         veyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492930; x=1792097730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cfbwxn7zYHza8U/eEiEC8IUyIDZgGYMEYuC3CC9wS+Y=;
        b=IpoCZU5U+mz8TAo+ZwjXEbP10mcoAA9y1ReptHEXhcZm5QaJN7e3+cyMyWQXPG56SJ
         VkZqxsFxl73Jsg59d/WIgMbb5Dk46AWmi4IjZhgVRDsc3paP+GqsIkj/osLbmuhOz6yS
         AoegksWXMX+2DY9iGbNSLIQM1yshLrSnvF5siqaxGDYCoK8hH2l1myGIZobuzMpLUu85
         vonQmI6q6h65h31kejTBfCc9Dk7vTA7tTl9zYHEbkGMRUI2u6yQ64CKnoIUhA5eapBoO
         TzEyyoN5495IRF5FXtf8izEUlfEAJBNOh3hxfDmSH+l50XVdcjuD/QVmYmp4o4i8HYH0
         ogeg==
X-Forwarded-Encrypted: i=1; AKwUvBy5Gy3luYJG2dNZ0kg3UvrfsG2zutspZWGPnj70z4g7vcY8bj9mdekapMsC8Bt4JKbqPATCLKM=@vger.kernel.org
X-Gm-Message-State: AFuF++mKfWcNsHqBFdiilHN+YVjDJTMn6XCDau3IfKyFonkjWEsIszJd
	OoAfm4RdFYXozdtgDbTECuD79dEir8jbU0rYhZsMu5AgjSAyMOfvrH/vNRP4C7joNypcjm/IBBD
	yt32lElpCGk98PayP9R584TB4Eo+WpKt5KDrECcYP917btWdEPLCCHP7H6g==
X-Gm-Gg: AYBFou1SGblkdUd3YO/D/rm71s4GiYpYlAte9HCFl9vtt3TqjWOrJViQaC9r08+h2JI
	Yyd9SCpO+nQVA0Tn84CIbme+WY5yaY+kwfFutZ8MVrwle5qPrjAZAdx3k9KZoaxvFwKlxghVtfa
	CBUKnYcsTZYUx+Vtf2X/thvYAUxRlQCcHBy5v3tdI/2FHD3VGkLujJCyoJOiYJasoIRmxnKt8TO
	TxWOBQGkikYGC7dMW6xnwfq0NeeDlgG1A7vtCacDyMsKMnXL4T3yCiOz2ZG+CFSK0gQB42CKuNA
	zhsR7WYEFusRhAJx8BAzWkEOlWb8evd//saEnDORW5DKh7Hv5ESfv5QJhFcsoW+H+NFLNQI=
X-Received: by 2002:a05:600c:6749:b0:4a0:251f:a726 with SMTP id 5b1f17b1804b1-4a180455d47mr127260715e9.24.1791492930219;
        Thu, 08 Oct 2026 13:55:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6749:b0:4a0:251f:a726 with SMTP id 5b1f17b1804b1-4a180455d47mr127259655e9.24.1791492928341;
        Thu, 08 Oct 2026 13:55:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm13248075e9.8.2026.10.08.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:55:27 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:55:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
	jasowangio@gmail.com, willemb@google.com, habte.yibelo@gmail.com
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to
 VLAN, IPv6 and IP options
Message-ID: <20261008165313-mutt-send-email-mst@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <179148831819.434549.14553358529954439471@kernel.org>
 <willemdebruijn.kernel.18efe47d2170f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <willemdebruijn.kernel.18efe47d2170f@gmail.com>

On Thu, Oct 08, 2026 at 04:04:16PM -0400, Willem de Bruijn wrote:
> netdev-bot+sashiko@ wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [High] The fix leaves the UDP-tunnel path, virtio_net_hdr_tnl_to_skb()
> >   in include/linux/virtio_net.h, with the same weakness it removes from…
> > - [High] virtio_net_hdr_thoff_valid() decides whether skb->data starts
> >   with an Ethernet header only from `skb->dev->type == ARPHRD_ETHER`…
> > - [Medium] On the non-ARPHRD_ETHER branch, virtio_net_hdr_thoff_valid()
> >   leaves proto = 0 and then guesses the L3 protocol from the version…
> 
> All comments look valid and require a respin. Any revision will take
> them into account.
> 
> Based also on the previous conversation in this thread, will review the
> approach. Updated in patchwork to changes requested. 


But let's agree who works on this, please. Have a bunch of stuff on my
plate so if it is you, I'm very happy and will just criticise :)


-- 
MST

