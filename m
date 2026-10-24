Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824347;
	b=FRJw0qs17bfupeNHDCiGlsYRxEInWckDdYd4Sg1cLcgyxx7XZuijTUIzScQKoqeyq0zr
	 eYIdGPZXFypNJOtToEgN0p4pc8Cq+c0nTY1jkOkbF4Y5B6Gzg9kT20FfnG7Kvt3feyJKa
	 oIZUmVjXU5clykdPdDeF77edvVseg2Vik+IgWq6NCJgaUR4bblxG6U6bPY8ju3QtKDCvc
	 jSYNMCqx4ZB1Cvno1liava3XNGxuzhEEQ6yyibBMvwaSVIELWKmK2YgmLBsUYBO4MAWzw
	 Kdinu0DJ79a9u2QmllWL4aQyEaqUYWzrUAIO187EZqIo/RoApDBYW+XDsjSmvkg09mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824347;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=qk2bA6t4LSa12DT6vB+e86LntEK8Lj2xjZkANdfH5+gHPuG5EmszphuM+tCh859ujc1c
	 egasxdEOqfmZ7w9gRH4BDsbo1mPEYDx8KTgI7haGHmOlC7RKlk3uksXor/6ngxnF9gMeb
	 sZw2qeMiZZtTGsWNeQbY899fR92kStQ7eJXNhtCtB6xta1IAm1sUcAN2r6mKA4UOzN8o8
	 0pt3nh+vzaxWRwKnZKiCWy+OtdkEFzUGqzRZeAheDf0uORiQhhZCbCctNW1d8huTLT7XD
	 P8lGzhrVYL/UHjLhL0SRYlJGyZ5x4ciGlSlRY3PxX43uX/5MMV8PUjuREZIr33z19ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qyWrtnwO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B556606A323
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B556606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qyWrtnwO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792824346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=T7+vrpj7S76ce9Leg450qxqwAGfKOdzcByHEMCV2ibOIWLV0Yf7gD14ZuUBcMx3cU1tDZY
	WLJqw0EE4QarMyVMIOeb36TbJh2m0iESBEV+83oJd4cmLyZ3HxzepY8WGIrk/uY1jFr2Fc
	GudSOUYsVOhkCkZuEmh801195QyymVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-x3DBc4rsOZC4PcmQZLJ78Q-1; Sat, 24 Oct 2026 02:45:44 -0400
X-MC-Unique: x3DBc4rsOZC4PcmQZLJ78Q-1
X-Mimecast-MFC-AGG-ID: x3DBc4rsOZC4PcmQZLJ78Q_1792824343
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be141so13168435e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792824343; x=1793429143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
        b=qyWrtnwOQ/VuuWPScSgijCP+M7VHXg8PK7QLyCGp0Y7D/rUTgjc/9RizDiVhlu7dPY
         laBdpxunQICvYpKnx8sKthxhHZJjOx0ApDSXbYDDAvydfZ5Pwtg9CQ2f2cibuL2to2tN
         geljcatw5qL/kWpevQqvu3+UEZSZWAvo8koK20y71iUcLo+oN1a+1q5+TF07rjzggsbp
         cIjbFzXMjS9g714qiKjnMiXHwl++CYOwSHiZCG24Gl+nTFDv5ISdRDcDbB+5qkXGu0xP
         KT1PUJpKc0ty5XGdjOI2QECEAZOdHl3vX6T1MOiyf4dl1f7QWKxKJnoeJhV7h47LCztD
         ZcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824343; x=1793429143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
        b=FjoJ5EC69DF+tDFbD1CMP1KA07qBw4vG1QAyFSoQAM1tnoqXlGVRPE+8Zbp7tdKy2v
         grjWHapiD/0DYSj+GktAiqnm+wNosU8iM+UAugBrsky+zHfCz9Xt/7zmZN8P4PhIZgJV
         +hN7rVSQaNCaXxxMjSUJD0XGDiXkzlOD6XuJ4nP9G3ZzNFg41uqesOueZlwtG9fiVeDz
         wEbeWEslOtFcoPFali8DiC3iNRwfoQf7RT9xt5686FQ2xjaF3W8unG38rwbpG8FwivGr
         +paAg3SwzIgCz6Ssy8U8GtXvG/C31TUpEH2Mmp6PgK910mT1Oki41WcUzRhSSbCmF2q2
         cmzA==
X-Forwarded-Encrypted: i=1; AKwUvBxJAfnqiKxJy2cUfwdqdI863apOA3OnhRCGfNnMG3JDMwzfYzo0pWQ+AdxRIonhkv/jTMadHZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2YaST8d0i1wz8WnR62wgHIO2fUzneBHictuskZ/Fe40qY9pZm
	PjI89cZqEwJcZFCrvi1sq/SaUt/1k6B5yBAIGm702ZGieK4EPntbEp39tg4b22bdfoAl7xcn1Sr
	dRIJ/DCdWuAa99rOjVGCuj0qqrEQfa5JIRPBxt9+NqOnieGxYsbSdC34S8Q==
X-Gm-Gg: AYBFou1FO76xYoksMAjGufX9x9xOd1ablT4ZTTj6Wx1So62OrvMRIHTnIOIiLwYOq8A
	SgIV9Llvy+qoIk7LTnKZiYx8N5SxlS0i3ld6d2PBXJBZijOTQqKKlFzBQ4lkk65LgdTuVOunBL6
	HgFB7okHeRNRWSHLCR+33qBxLP29YDi+mjp7Bb7rrrZJya7Kj4GasjDjCiIW3jeJ1KV2OTeQQvg
	/uN4vsACLXWvjfDck+X8+3YTdCT6ADCLfhmvq8ewV2fh12Wgr3+JbgitF+C+JcUjx51NVrg36u1
	0uYd6dNHTp5C4JUnl5ZD+/jV9OvjB3AfFRLRK+vV+iaMNAQ2/YyRV86vCqA3o8VH2r7oHlE=
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890835e9.9.1792824343204;
        Fri, 23 Oct 2026 23:45:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890615e9.9.1792824342728;
        Fri, 23 Oct 2026 23:45:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm63050615e9.0.2026.10.23.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:45:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Message-ID: <20261024024028-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
 <20261023080824-mutt-send-email-mst@kernel.org>
 <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>

On Sat, Oct 24, 2026 at 10:11:01AM +0800, Guikun Yang wrote:
> On Fri, Oct 23, 2026 at 08:13:22AM -0400, Michael S. Tsirkin wrote:
> > Which backend did you use? Sounds like you did not set
> > TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
> > That's the issue then.
> 
> The backend is a tap device attached via the normal tun path:
> TUNSETIFF (IFF_TAP|IFF_NO_PI, no IFF_VNET_HDR),

Ah, no IFF_VNET_HDR *with* vhost. That's a weird combination.

> then
> VHOST_NET_SET_BACKEND on the RX vq.
> 
> I re-ran the repro with TUNSETOFFLOAD declared before attaching the
> backend, listing every offload bit the interface understands:
> 
> 	TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
> 	TUN_F_USO4 | TUN_F_USO6 |
> 	TUN_F_UDP_TUNNEL_GSO | TUN_F_UDP_TUNNEL_GSO_CSUM
> 
> TUNSETOFFLOAD succeeds (0 is returned, so tun accepted all of them,
> including the UDP tunnel GSO bits).  The result is unchanged:
> 
> 	features[0] = 0x108000000, features[1] = 0xa   (tunnel bits on)
> 	VHOST_SET_FEATURES_ARRAY ok
> 	TUNSETOFFLOAD ok
> 	--- RX buffer first 32 bytes (initially all 0xAA) ---
> 	hdr: 00 00 00 00 00 00 00 00 00 00 01 00
> 	     aa aa aa aa aa aa aa aa aa aa aa aa     <-- offsets 12..23
> 	     33 33 00 00 ...
> 
> Offsets 12..23 still contain the stale 0xAA fill.
> 
> The reason is that vhost_net_set_features() computes vhost_hlen purely
> from the feature bits passed via VHOST_SET_FEATURES(_ARRAY):
> 
> 	hdr_len = ... sizeof(struct virtio_net_hdr_v1_hash_tunnel) when
> 	           HOST/GUEST_UDP_TUNNEL_GSO is set ...
> 	if (test_bit(VHOST_NET_F_VIRTIO_NET_HDR))
> 		vhost_hlen = hdr_len;
> 
> TUNSETOFFLOAD only updates tun->set_features and the tap device's
> wanted_features; it does not feed back into the vhost feature bits or
> into vhost_hlen.  handle_rx() then writes vhost_hlen bytes of the
> virtio-net header into the guest buffer while handle_tx() / the GSO
> path never touches those 12 bytes for a header vhost itself built.
> 
> I could not find TUN_VNET_TNL_SIZE anywhere in 7.3.0-rc7 or in

Apologies. TUN_VNET_TNL_SIZE is an internal macro that header size
is set it. TUNSETVNETHDRSZ is what I meant.

> linux-next (drivers/net/tun.c, drivers/vhost/net.c, include/uapi/linux/
> if_tun.h, include/uapi/linux/vhost.h) — is that an interface from a
> tree/series I'm missing?  If it is meant to gate vhost_hlen I'd be
> happy to re-test with it.
> 
> Meanwhile the stale 12 bytes are observable with a plain tun backend
> that has declared full tunnel offload support, so I believe the patch
> (Zero-initialize the largest header layout and copy vhost_hlen bytes)
> is still needed.  Happy to re-test under whatever backend setup you
> had in mind.
> 
> Best,
> Guikun Yang


I have in mind simply disabling this combo: vhost + !IFF_VNET_HDR)

I'll research a bit whether anything anywhere could reasonably
use it.

Can you reproduce any problem *with* IFF_VNET_HDR?

-- 
MST

