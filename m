Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768182;
	b=aMTTUUs1m7j+LStRdIBH1jCwihraqeC/WpYRxmJoCJUVGqK6pKnhy5rd37cfk7WGvNtW
	 xLK15oWkeyuaYcT+G3mh9bm0ldoP8m59HojolP4uNVgUBjx9x6YV5ePcjNMzL0b1wdqrU
	 mGU/H2FGyiY3LbT15iiiv5fSmUjnR/wC7ACJ4eficGBbAw6sDA45ClB6OdJHdZKbzsca4
	 TfbrsbCYsSGYUp1peUuH+/0sztQqrvl15Qvy6brMYavIdpe+nnHDC/vqDlZvdJAT+bpO3
	 Dpy0wo4A/ZILy4RmhgMZo0VvaUviTPNWfho4jaM4om42BED92AkZ63n2kB2Iu/zgZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768182;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=UL7OavTL9ssM6lwh+1YvzR4ePulZepWHCs2DlH8XSZ9VTfDrHN164SU/LjhjcHSfaU3v
	 1Kt8CL31RRXDcl0vsLqHN4q0vXY+hf3DyyhdNyNjfqfezxkz5DCHpxZ6n6DAQIe9JiTRl
	 Cxogsc4k9HRk/dPdrl/ITX2w37jZJD5/5J/ib73+3Wp/yJNITTnI19LFhe2pVNPmMhn+f
	 9qOE1kDV9b9PSp8y7T/sJfCw+1nNlQrlM3pdPArzIE9BGTbC8Is+rATbdDZ4DH2lWEMbK
	 KqHCI9BIMTBy/yl+QZVqOpU66F4fL0KWAD6slm2/kW2UsllpeHfiWILUXqu6rx/vGtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XY6f6aHk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FGR7K1hh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD960A260C
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBD960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XY6f6aHk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FGR7K1hh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
	b=XY6f6aHkeA9N6HGwv9DaMkIEv/SdDj/qEk8zhiTbanILVoCzWpgyemgnPRi11qTPX0X8b5
	1qXqwutAZk7Bbdb5Mu9OzNGlTkrAGGdbUgygLO8ICaaB48xqXjlWooJHRKzJ8qNNXi0Anu
	IoieuriFRk4ujmhJ1Ez4re1T2BkDTIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-LVAXQPOqP_6EjqqPMGb0DQ-1; Fri, 23 Oct 2026 11:09:39 -0400
X-MC-Unique: LVAXQPOqP_6EjqqPMGb0DQ-1
X-Mimecast-MFC-AGG-ID: LVAXQPOqP_6EjqqPMGb0DQ_1792768178
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1441659f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768178; x=1793372978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=FGR7K1hhqDwfWdw1XOiNYypgy5PLwSUIzqlabeV2ydOVxzOyYpxe33Qaq0ppnuNaF5
         I/Wv1A6RVOwYNLYXx7f01zj5/5Fd/uRBqDgSxWELqrQVycQBKmS1JwGBgCAGo6yQvgkA
         WsANXIgkWNH49H2KG4TYw6bV6JNaPZNvIItKBE7luXo4e2KySrrpsL+STQClza45zWvM
         kJDpkF5McSprEnc0pareOKh/q1TSgkSYVeCygFHLVuAmackUCCSC8izlTUxBQ2oFebEe
         zoJQttxFo7bhBilw4jGrhwYDemCS/R/Ac6YpPsezRJ5SeCuMyjM9piRthWVuqeoJ0NWo
         6xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768178; x=1793372978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrgZwsKhKHkmEbVDierK3hRSfuUB2Tabjw1XdPoU1r8=;
        b=sv3NX4Z92Sl8K/Tj2mSeW60+IvaqB1LdAv47nMPq+hVMlVPn4C1EjVRJNf9CqSn9QA
         ydDCVWqe9Kj+CbX4Gwsys1I/JfyqbDHgIZ75meiSFEWeDLbOHY0w7OF6Z/YlziQpfQrt
         tWGD7lHSLtrxTNCxVjonIRqw8ZxWPpA3XQG4s0Uy7JTbdvw1dJUwhOoFYwTHDzhHCPgm
         gI15pBFxRbK7rov5euuqdaQrxTZxGp+WTjeLbxXiQ+AOYbRPmktlIL7DqpRB11147lIp
         Azauh6wx7W1rYUyGFoLNWvvixaAmPQF1iZUQixY/U1Qv0V2FQtEXdTL2MFA2kLxP+g2I
         Rqfg==
X-Forwarded-Encrypted: i=1; AKwUvBzzmGmWIKb57fePUDJzlRTuLhYvLc09ZWzOIWVF8uPbxHMYKQGtqkvWQGHJ83AGUVk5oPDxg58=@vger.kernel.org
X-Gm-Message-State: AFq9FYI25uESQH1tnBr2SIQnG21g7dtMtS1x8x3qQXdZ5LJlOKuP5FZh
	NQJ25gdbzrAwu18Hnjvpg0h4K7gaiy3Z2CFlDncWTdnlBOEtqHO1VwOl/MSmZULxr2pzITO37Ja
	r5bT0oCPLaLa4j+Y9p60B2XVLUxe5ynRpXR1HCa7pHDcn+sfIt8TEobRuWw==
X-Gm-Gg: AYBFou0D4pqPIq4F/cg5N1sH+eW5Fdi4yYhPWtskHSHop1E4HEN1f1/YnedWiTCROBJ
	406mSB81uoqG0NWJPWS9iqhsw1KxDixlVkJ76jnHeHcphEZ6/SfnFiLTn5bUDQndsAZT1goFNtp
	66kvlcvRADnH4YXA2JJEl8FFv3S2w1Bvo0sNdwyJwhi7syDM4tFGn24mOMFtTfjEQbFS9xt+aw3
	Pm/sKSZ0pqqjy0wf9u33W5cz+7lJvgau623Spfm45yCNeo7EeGEf0OslXZnJqUY6Jfxuv7FQUa8
	RRgYYGOdryeLHTWWzsYX9IoW3NWfouyqFgBqm6+4f29gX3IZ+1rmHVCXRog/owpq88YghzY=
X-Received: by 2002:a5d:64c3:0:b0:48d:faa4:af9a with SMTP id ffacd0b85a97d-48e385937f2mr4148527f8f.9.1792768178072;
        Fri, 23 Oct 2026 08:09:38 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:48d:faa4:af9a with SMTP id ffacd0b85a97d-48e385937f2mr4148486f8f.9.1792768177564;
        Fri, 23 Oct 2026 08:09:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d408f15sm343026f8f.33.2026.10.23.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net v6 3/5] virtio_net: parse tunnel csum_start little-endian
Message-ID: <ac2b7e8b635da611f7f2bb0b42436a8155edc7ed.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
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
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

All tunnel related virtio features are > 32, so none of this
functionality can be enabled on legacy mixed-endian device.

Accordingly, all tunnel header fields, csum_start included, are
little-endian.

The nested virtio net header import parses csum_start that way, but the
inner transport offset is parsed with the endianness specified by the
interface.

If tun is misconfigured to legacy big-endian mode while the tunnel
features are enabled, the two parses of this field disagree, and the
value stored in skb->inner_transport_header - which is only
bounds-checked from below - can point past the end of the packet, where
GSO segmentation later dereferences it.

To fix, parse the field little-endian in both places.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..013c6c7e2dea 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	inner_l3min = virtio_l3min(inner_isv6);
 	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
 
-	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_th = __virtio16_to_cpu(true, hdr->csum_start);
 	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
 	outer_th = le16_to_cpu(vhdr->outer_th_offset);
 	if (outer_th < outer_l3min ||
-- 
MST

