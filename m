Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602042;
	b=sY3PrzkpGE0xIiSWf8cQZv23VE+JpKzHL9FDV/Cf3GfwbgUjPiK++NSkz3SCvEl2h7pL
	 8VHYVf+KqrNuWIwwiiUqaAQuHJIi8uuyaqapq+uVq6f6g8mj8WgzGuMx+cnZb20sTpL1k
	 v7u14NNOiG/zRH4dKWFaJH8UUclHbCK1Ryr1xTAwscT/hixzav4nlDYyzxyWCzGvrzJaF
	 TZk14uBUw0SktgvKL0fMRcezXvTn9OzQm9Nx06suZ3Ahi0TJmRirv3bhupN9gnRVTIsxG
	 Fj4XwHci4vzOybNrTkJFrGNryCpc2QOX2NvLs3D4KLsmOzby8uu1rCh6r9HqdJjoaIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
	b=QQE7/2wKdmuun28GP4cF/LDaRRySh0XLW2p9040W3KmOO7jTVZasRH362BPsjJMV67S4
	 aE3ayv8DNUJA4IUHGfWPQgl0Dr5m/YcVpSMFgZ+D1DKOaepCMBscBtRCGIqXFb9dP4cR7
	 xZRR6C3MrqS4pvn1lXMZXvHI9LS8w30Pinnzq23eSZ+ozB/sVXtHppCjQ1N8k5yUJoxdm
	 dQz7q+R4uW4CtD4Fzowv4Uhk3i+ZyM56Z3r8mbm0KiKYcFWeq5SjUCbGDRpYy83PtYHK7
	 he/TZhw4B8He9hU0Ktji5RL8xvG78P3B8bXklI2O51n6oEPvOLpm/V5X55oTF9c5lkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMOpKt+b;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UbimXrB5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F8606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMOpKt+b;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UbimXrB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792602040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
	b=aMOpKt+b9bJKokL70zGWAC80tgnRVx+0vL00xHOy4BGxAnBDFY/ZnOhEYHSXWUBfC7kL5I
	1mNBQgrBCMiqca+1yzH+dnr+cu9YyCJ5AlmIiazsUo3OY/vcRaYWp5yGindE5Q0VEu6UIV
	0SOHfV9sIwRK2D4FsQi82QtiRNQVsBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-4taBSDXqNbyGwnRv_xkOPA-1; Wed, 21 Oct 2026 17:00:38 +0000
X-MC-Unique: 4taBSDXqNbyGwnRv_xkOPA-1
X-Mimecast-MFC-AGG-ID: 4taBSDXqNbyGwnRv_xkOPA_1792602037
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a2001e85c8so5142105e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792602037; x=1793206837; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
        b=UbimXrB5dGdnO0TsxeGofcIk8ZGbuenQmt+4Krqq2N9jETg6GFKSrNicaEK8SOMOOx
         RluoUpqKAZKuoZPZ9zVK5w6urFc+EEZ5hb+k82B2vrSFzVHgu7/gXieOJSRCXrXUCY8T
         CWBz+rkJNObiVMAZ780stknk0A9ApMtdmB90IyGdeDNsCG1GOtGblwHv/0xVZ1+buReF
         9o/13GiC+N+12rejlU7VIsxpwkwSz0CvoF2npzfKLby1c8/AE+uHprSl/63+flNrHvxX
         1+7b60YK9e1RSmdPHh+y21luDknXV1MfF7sBf7Ky+XZK/IHLEFu0fLWQxMWGxDmQPvAl
         O3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602037; x=1793206837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
        b=fBwoLVfBUciajFWAXnD5aXEKtITzPGYbqOjZWhmhCN8Ada9PQD9qblQ2AXqb6Nt1a8
         dBa5NbOw7xpnp5bgPt48vUMYCTWp6nkSPR7tfSgqQlwNs5YdHd1TknWfrHkoqJB1Xv1c
         4UzP0LRBZnKR20m8c0ChXv2KawWOwzCG4v28cO4w16whvOwni7zD6JDxwSbuq4OJJolN
         juCfYGdvZjOvdX5No54Ocs1kSMh1s52O93wygR3whwBFbXwoibDxD1tuKbYvpchvYD8Y
         OsjLSAXE4Ygc0T7STZJkIbCG84C34DYAFgYLJ6Ksg6TMtPuF2uVkh0BAXld3Y7uyMXUW
         pEMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsWASbISe72qEL+GjZjwlG/uXI/71q2auqInMCnDvwNhQ4ZHkdd/y+0I8OM9So1MC9zKgGy3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBcN2UBJ02Qs00zWnZp/CyrFgIcbJUyiwCROwpmtPNmAtmjW2K
	Zi4jcIRJQW9LAGfbKCl9qTncEc41Ai/YUC1r9U+u+MYe4lnvVJuka/wS0PvGB+KWZXFxBqL/mxR
	7jN/0bcwdKMZUECNJ2sCuoSDAZUQsOSDRR7+ScE3PD2ZqkD+H+HSTKIWFyA==
X-Gm-Gg: AYBFou1FJA+FDaTh2l8N2gbkLz5sGeUlW2kjSb/j2XV6fZWS7uDRWXobfMLHQmcmPj2
	SWcRVKPYDPPLinkXuXm88nI3qu7rXHcCpdMA3RQ3SD2xVq8IBetF+I58EXb43wKwsA/XlenSdft
	MN6NNtB5iI1DIERql+0MJ8sGt9X3WaognZNI1kU+0AnRh811LDNnhERNJZ+4Zj3LaonIKKIFUIx
	7BL0/80Uek/PqZ2V7JhzzgglfqbsyOrhcVQmQTxVgL/f3GXACc2oUjCLB8jPnfJJ6thS4KVPw6Y
	NZWbNj+6w2nz0Y20a52Y7PSuCgPEUO6S3K/ICc5NUxFSJu6OfcKok+5tGBBP3w2WmQQ=
X-Received: by 2002:a05:600c:8b6a:b0:4a1:9831:a69c with SMTP id 5b1f17b1804b1-4a1fdd3bc69mr52099405e9.30.1792602036449;
        Wed, 21 Oct 2026 10:00:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:4a1:9831:a69c with SMTP id 5b1f17b1804b1-4a1fdd3bc69mr52098645e9.30.1792602035808;
        Wed, 21 Oct 2026 10:00:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd360e4sm46139995e9.4.2026.10.21.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:00:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:00:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
Message-ID: <20261021125549-mutt-send-email-mst@kernel.org>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
 <CAL4Wiir3NTn8VdbzS=sV3tfz4XGoBXmSfjm96k9SBMTiYBBtjw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiir3NTn8VdbzS=sV3tfz4XGoBXmSfjm96k9SBMTiYBBtjw@mail.gmail.com>

On Wed, Oct 21, 2026 at 05:49:35PM +0200, Eric Dumazet wrote:
> Le mer. 21 oct. 2026 à 17:13, Michael S. Tsirkin <mst@redhat.com> a écrit :
> >
> > If a TSO packet is processed in the stack before a transport
> > header was ever established, the TCP data offset is read through the
> > unset header offset, far outside the packet.
> >
> > This was demonstrated by syzkaller, back when the input path did not
> > dissect such packets: a virtio net header supplying a malformed
> > network header was enough.  Qdisc length estimation has carried a
> > guard against exactly this since
> >
> > commit a0dce8752193 ("net: Skip GSO length estimation if transport header is not set");
> >
> > the GSO length validators never got one.
> >
> > We used to, but we no longer allow such packets in: since
> >
> > commit 44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")
> >
> > the virtio net input path dissects all GSO packets.
> >
> > But as a defence in depth measure
> 
> I do not think we want this.
> 
> The root cause was fixed at the source by 44378d02c5aa. This patch adds
> code to skb_gso_validate_network_len(), which ip_finish_output_gso() and
> ip6_finish_output_gso() call for every GSO packet, including locally
> generated TCP, to guard against a state the stack no longer produces.

I just worry we missed some entry points. Shrug. As you wish.

-- 
MST

