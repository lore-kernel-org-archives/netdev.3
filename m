Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502640;
	b=FntQpbNjlN1r1jQXEbDlpsneUwQeFhSe/3kWZ1L9htWsBDC1rjvGtRlvCEsXuo4kKpQk
	 kkB4jwXyYx10+X3TYgP0oAy33WmoCUgulMi0v/jb3GTj10Ut4Q7qn4+FnqpMm4VsQXvdb
	 ndFOxIHxxED68LON2nGWQGZ+wpdx+y/9oUOpDOIlRUdgdKu46x3NuSTMkLzrPigN8awIk
	 8sATtAhfPDQhUfXtGhluQeQbCNqMCRDGNBy50gnr5+am2J2aPNyS5xG/vo1vVdTkUHmzs
	 AYfs1MYhfpxrI5sxWshbMjuQZuC7SrKNHP4T/BdeyA1BUXI1Sw9AlHdnRKKFH7N1CTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=X2Z5YhVYGRdtcX7EwvR7cdwefPer7xIIMkGQk7qbOJf/4jwzJbpdB0eI9zK9XObhoWqN
	 /BwuG+Qib+DbOuHvbfvnUcdbM6zN/WKeaSwl3bRnUPGLje3T1v2UEamFJHHOX03Luob6v
	 2hiooMEA01aGQlvk0HfkML4dJ4zT2W/6G1xaVGt4J7wBVsr3mnJKo9Ja0T4lxZuR14JTV
	 VmgEKk36v/rQMfqNbKJphdmV9rEeH9DEoj16TiUx4XX/kJaleSGCDvz+dlWoBHceIui7a
	 Oquwkq6IoU4Kdjqs9NuGct3q81syB4OrAWdW6+e7tTqwfhUdy3F6/Cr52eK8ESFDhsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fyqcpX0Q;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4706606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4706606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fyqcpX0Q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=fyqcpX0Qt2uw4WJt36u9hwUAxMORlXZDo/gI6j0ii/ZP4gy5C3nR7iL/wwgQL88fhvMihP
	bI3sGDL0J1cJKXwp0youeF/fpL3nT34DXZlNzHJ5UNYlevPj2uFjOm7mLNT2w+QDKuN3yZ
	oIBHj0Li82AnzFwogrUbTFDKjNBnd9w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-2WH6Ihq2OYSR68TvQX3Egw-1; Thu, 12 Nov 2026 11:57:16 -0500
X-MC-Unique: 2WH6Ihq2OYSR68TvQX3Egw-1
X-Mimecast-MFC-AGG-ID: 2WH6Ihq2OYSR68TvQX3Egw_1794502636
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f184f3334so10826d6.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502636; cv=none;
        d=google.com; s=arc-20260327;
        b=HupA6qrbramtb2zhVx0E3JWfX8cDF2tE8HmL66mIEln2huR2h6gh9xmxxXooEWdM9A
         gzzB5Yapd5MUXH77YXrYhoWeSwQpkYCZJp/FsfF8lDtVZby8UGm7MgSGYR83rCxOMbcE
         0RnARH4YSwu723isFldR0O79YlYJ62Uvvnx29eu62Z0jbaeMnSIq1WbF6+q66EarRK8t
         blizEFGufcMCTtvodfz01HWObCJ3iysYY4kxW3l6eEmgTTiNpIs5pk2GH3oo6qbzNO2N
         v4jXhvYxD9moXAZUXpL8yphGzijozeVize6WwitXK5KzC5+Dvbit0EpGMLPi4KLS/0wq
         0QxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        fh=4BzsYUytOum67Ro2WQUvj7vRZT0idiw5dowE1Ai6FB4=;
        b=NZNEHNgDbOkYMAvmy7++ipIdKzAGq0gyt/yJmZx2TqOyLsjDpB9OmW6UeH19KTKfuh
         /luB0xw7NOmsybhzzgFY/PRThGSsDJ/Xe0cdyG9cnfn/8JgMGoM3DHHPA+Gcbofgu+Su
         GdNb20SfQzvXeavRpRCpQoxtNGIG0UwsijI+Bml3adBjcDDMteZBiX2HSdb541hZKv4l
         V6AOHV5x8bslRz78E6xaisQnmXJS/SrKedkf7Zack336CDZVFqp9O4QmrFcjWGzTKTN+
         ufpKXLPJoIl46C2kNEd7vL2CmBMrii97DmPYTlNfAzlkqsSBuk7hTvNPtYxueywywxbp
         96Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502636; x=1795107436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=mfphcUTJmKpNNjKE/vba8sbrm2GA7Y+gcHku8cTk1a+y2dk3EloihtRyKAQeirIvDp
         wvg8gkhJ5lC1AkaK6heaVC6iCZhP3qCeGnLlBSZBpeyaU5rKFLySsduaBj+RJQrdj/E/
         IvWZE44ZUGb6gMSkTITxuIkeJPwmU9i14CTY5gqBw8ihusdtAVkW8q/898LYixqHhZYX
         YqpsLL6HWprFGBwF9Jr3IbUomVpiAGiwrOGlg3zjzrZwjD5T5QVv8bgZRv4HjYSAOgZf
         YjJaZhabEjQq3VWp4hxuQIFQlsqsnhAkHF8n3rCUYqLL+Up6ZKGZVhESekpKQ0IoL+2B
         u0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502636; x=1795107436;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=YgChqmFvYm4l/8FyLCfzGPSGZP2GCfWQLzrgTf42zWzyUGqUG0tfnN6kQRY+W0yxJc
         7ka+sJPZLhMlHCDNFM4dB2dhJ4PfonSLpTtEpPuBvvkXvkb4wrOoGAWc7Wk61fgJyAOa
         LPKCxemQVoH0S/lMVtdWJmcwpMjXJF2CidL7QVguNpwpkOvLvaIsFnIsy+H+drx2wP9p
         WjF8tez3TlXycCW5O45ZXar5ntcDWZi8tQz+ZdNL7ohln6XLuPXPZWJ8CavUxQKoC77X
         mz95OOs81Jwknef3bFauFAgXZ49aS2KWTUjr1yiSc1ABMrYD6woZjz/1/aaDBgrRMoID
         /hHQ==
X-Forwarded-Encrypted: i=1; AL+hErFn+074v7/2Bbd154KFVU/t1zOaTFFr/IZTg5DOxjq87b7EfzX/w6+mGed0vT4oHf231xzOp7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0J7D7Fh/W+/HPmdrIYHgE2HObFyxXx1X/R1eRapdokp8a1lr2
	ViAxPgAZkWFQzvfG3B1CSl6hE+v7ZXFdUshW3oON5M+v678ILL5hoHHSDb4lHwxPSYx2mEITeoa
	nZPa0jez+Y4cFZdDzH0QF0fTOiayrAQWqQ3fBFLQkpkH5wGgzgsGLpME/pyjU/omP2hPYGBkc4w
	zOeukZyLMw9RM33Iy7zofQjSWcRFrRE2FC
X-Gm-Gg: AYBFou3wLASKHx3FZvkJKB0Y3amteJNifdl/7w6CbAHHOQZRZyX6pKNLfTuiRTSOITX
	U661faLaPJpdN1A6EoEghU4ZL3+zRwlyAZLjT9+cgGajVNsNI6WNEL+K9DQR21POPuB3kFfdcu3
	xQ0EUz2RYcpyWtgAH/E0FvCe4Jq2lWm9md6DUq1Ja74Rcyd89RdpEF6o4=
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id 6a1803df08f44-91f04024a36mr108416356d6.16.1794502636064;
        Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id
 6a1803df08f44-91f04024a36mr108415966d6.16.1794502635425; Thu, 12 Nov 2026
 08:57:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 10:57:14 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org> <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:57:14 -0600
X-Gm-Features: AclHuK97Vbt87h1PiWp1yuLFdgsXXBfxSod9rL7qWx7O4MzdkcMf0Vg2mTyClE4
Message-ID: <CAAiTLFV5g4XV7ZU+TYFboAi3n535murgSjh4SBw_PMnp=oQyww@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
>> Vhost splits large datagrams across guest RX buffers, delivering each
>> fragment as a separate message. Allocate full-size RX buffers with
>> page fragments when datagrams are negotiated, and drop whole datagrams
>> if a guest buffer is too small. Refill empty RX queues even when only
>> one full-size buffer fits in the ring.
>
> I wonder if it might be better to do what seqpacket does, and just split
> the datagram across the buffers (for seqpacket, until the EOM flag is
> seen)? I'd expect that we will get better utilization of our vq buffers
> this way?
>

Yeah, I do like that approach better. I'm going to implement it for v2.

Thanks!
Sergio.

