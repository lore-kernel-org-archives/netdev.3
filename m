Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809478;
	b=K0JPJ9r2Byefz709cgmVc/ZoLYh/cMRyr190hRNrBh7WRnzgCDpVte5t/PvK62MmrgmM
	 qeiasZeThoRr/COUFO76j0hXJ4Pj/O38bdS2SrLD1d60CwuQTvKRA9ouxET8kNIMzEOLW
	 gwUH/7IKhalGZD5jD7AG8pCxVgihUIAqx+zP4tHZ7yRSwl7I2WnloELk9/HDEEe784I4p
	 ex292ShV7cJbLuKv0VquPLn0VxWXVgln6Fh3jTbQWg/Jm4W8Kamy9vsMUNKBVoDQdmQIE
	 xI7m8eFHfO6nSO/scJMKtStVwN9Hm/glwALj5vp+fAeAWv8e7MZgxUtcb5euSwNJ4Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ytwtwFXLfZthSRCPbGLzVPAFTTC4VWn/TZg3jkbm7sA=;
	b=kaK4CPQayG1INuQpR12757wj8oeNLGyZ5KMjDx1Vg66F8zUChUbh0MWdBE7uY/Ee+Gr2
	 ii7UYwT0LjCs2SKeiOf7/Uf9u+I0DesEy5n4mpQrkRg9JmyK46NsTLvztm61g8d1AeuRN
	 NwGdpET8NJSP92MZHoIxmKtVGwxn4XKRYraC9/Kfvqfs16fs8PPJEsRPu6LZR/PJw5Y5+
	 jbu56fmZwwPDy5OMrXtXV8vrvLWL5YoDXqQvg7egVyCF59+X3Q7coyi05LyUXWZuLHxJA
	 GOdjguUm5hxSbfjZmeJ6CewBk88A5gNgxXXxDmA/OCrfhahFPNctQMBSlYBD1pRYoEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YG8tym7C;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D4606AAC0
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 101D4606AAC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YG8tym7C
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso322437e0c.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809477; x=1794414277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ytwtwFXLfZthSRCPbGLzVPAFTTC4VWn/TZg3jkbm7sA=;
        b=YG8tym7CgxkptPrRM6N4vI9Gyw/H3NoPmUF6ldaEapb8yldmVRDFMtRHPdRoVvoN1x
         9xdfu41I9MYWb+Lo5HogJNk77o4Bohx4wr+AxYoH5AHAanovuzx/IgLACdA6XBXJG78f
         QJk+qGi+nCgLMkVXevjQdDC1jj0VnDEljQyr7k4A6M32DEkBc2sHeeqxl/BTjichsAeM
         meBpm6IjbXGLTzgKKVKbUDMhBK231VUSLvlF0KM/3vfFA/FTL5gvOpi+7Rn1f9OPYt2V
         16CG/4YC1T2KdBQJs/8F8Ny+Ciicqh7asHnjU2nziV/U9v0PuZN9KQWkx69OdkxedJGD
         FBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809477; x=1794414277;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytwtwFXLfZthSRCPbGLzVPAFTTC4VWn/TZg3jkbm7sA=;
        b=odnI7kX1MdEsafGY/H/NVhpy36kolRi+kDKKyN3j4bDOMRYx9tVgZ6tPODdsGEORx/
         N2tWprwAhdHkm31oTC4HSLIclROEhD72oCKFfNSyc/EPw+Nz+rlu1ZU9XpFkBIzwhODI
         Do7nmQivGtxvITECID++PTOmzbD3pDIoobbgd8eO6Qs0uy1lD7iaMsswk7rBMCGKAFwQ
         oTQIH3ixzbyhrAOlXb2LbJ3eEgBOskgtdRIt1eN9ztxkHkqtbXpDsPqsESQxL8O95h5I
         ByW63ZDxeskYuQv9t2VWiCn5HgfDY1Pa6BYhnVOEENkPb1/j9pApI7BgFYFwwMrMy/Eq
         KerA==
X-Forwarded-Encrypted: i=1; AKwUvBy/NorHC8Q3fk6g8msOfO9TJ7ykHpqHqGDrKhkeIxRlRt0NXFE1qkJ7+s2PXpzi/gnPrj22Gik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s+p0iFoaqOG1b637pAPcImqagZZbldAbQz5glt3j4/YQQ5yMe
	wsjhMSXrD1w/D5FCd9URZOYDSX+9bO8Ev7VdrPed1oWOzurs+LkDymSQ
X-Gm-Gg: AYBFou3MW31kVYILJPqEvnafEPzXd4ue1Y5h7GDsxCKzHU1pJBRY2pdRjf+W3v5ihG5
	48h5F72Zq/oho2ywr/nzf2q22oaMB7w8yN46wDqETJyukIo17mUBTpZ6ncgy+YWZVmpLnxAmNUT
	Af1pDwOdF96AfsKBZ1edbcdsk43vCWvwBE+GzBDgZZJeN5e+KzieQNh0qCGhrpo0SRgt/w+OQO6
	tDsVnwWSTgHU2njK7kCNvJ2Zz9mH8Nm1NhZmogOGZ1c6tU7ATUdgc2gK8lj3mCHSGRpe5H8weQ6
	oYOTTSP4+q+o9CoOMfENvVFQo8FH5uCaJWd6l+oREvn1ZeaFbUFj+/MVvo7CjQxrJKeiNbDqw8a
	NPjO7UzCtVuvq2bp8KhQhyBKCx1Azx3L9l76FOXplfMdxReR5LSQ/l0xDAXUqb3gII0hzvyt8z+
	kc1789kSQudvWuMlqMom71UJ3Tyi3O5xGl8CQK2YJgsYcooIbd2mcHsmoBZistzr45CFoaLtDwS
	23Eh/poEWCDvq1eQ3bV3wacoqevDwgqvxIce6qrxL5Da+DU+3cCVo96TxIdJ5r137xLbUdpYi5M
	VaUORM6VE/dXtJn2mW41UtvtJOeiBn9ZpTH4574P54rtd6G7mHVw2qnxwLX+VrGzRnU+fDNYDBS
	PFTpx5aacWbTnCtvLqSMfa828yqnYLD76OPbCCyDfxmZbO2iDDH+1r0JNxH6xhyCLYFOsp7o=
X-Received: by 2002:a05:6102:1623:b0:7a6:a24e:8140 with SMTP id ada2fe7eead31-7d072c2ba18mr5773758137.14.1793809476799;
        Wed, 04 Nov 2026 08:24:36 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fe2d5fesm1891241137.7.2026.11.04.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:24:35 -0800 (PST)
Date: Wed, 04 Nov 2026 11:24:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Duyck <alexander.duyck@gmail.com>, 
 netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kernel-team@meta.com, 
 kuba@kernel.org, 
 tactii@gmail.com
Message-ID: <willemdebruijn.kernel.1f1cead288fc2@gmail.com>
In-Reply-To: <ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com>
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
 <willemdebruijn.kernel.2de9d4f8c5034@gmail.com>
 <ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 11/4/26 03:51, Willem de Bruijn wrote:
> > Alexander Duyck wrote:
> >> From: Alexander Duyck <alexanderduyck@fb.com>
> >>
> >> The netif_needs_gso function lets a GSO skb reach the device unsegmented
> >> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second case was
> >> added for FCoE, whose transmit path marked CRC offload that way at the
> >> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC
> >> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exemption in
> >> place, with nothing left that needed it. Fraglist GSO, added later, is
> >> its only user today, as its segments already carry valid checksums.
> >>
> >> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without being
> >> fraglist. Hardware LRO builds its aggregates that way, for example mlx5
> >> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, without
> >> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc mirred
> >> redirect does not, so such an skb can be sent out another device. It
> >> has no csum_start and its TCP checksum field is whatever the aggregate
> >> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, such as
> >> fbnic, i40e and ice, then send the whole skb as one oversized frame
> >> with a bad checksum.
> >>
> >> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GSO
> >> skb other than fraglist as CHECKSUM_NONE, which means the same on
> >> transmit. The netif_needs_gso function then segments it in software,
> > 
> > tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
> > tcp_gso_segment will send it on to hardware if skb_gso_ok with
> > NETIF_F_GSO_ROBUST.
> > 
> >> and the __skb_gso_segment function unshares the header before the
> >> protocol code rewrites the L4 checksum field. The callers of the
> >> netif_needs_gso function that decide on segmentation for themselves,
> >> such as tap, are left as they are.
> >>
> >> Found by code inspection. In QEMU with an emulated fbnic, TCPv4 and
> >> TCPv6 GSO skbs built this way each went out as a single 11 KB frame
> >> with a bad TCP checksum. With this change they are segmented into
> >> MSS-sized frames with valid checksums.
> >>
> >> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC offload")
> >> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > With the above aside. Not important enough to respin imho.
> > 
> >> ---
> >>   net/core/dev.c |   11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index f32353b0467c..28b4a652d037 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
> >>   	if (unlikely(!skb))
> >>   		goto out_null;
> >>   
> >> +	/* Only fraglist GSO, whose segments already carry valid checksums,
> >> +	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
> >> +	 * skb has no csum_start for the device to segment from. NONE means
> >> +	 * the same on transmit, and has netif_needs_gso() segment it in
> >> +	 * software.
> >> +	 */
> >> +	if (unlikely(skb->ip_summed == CHECKSUM_UNNECESSARY &&
> >> +		     skb_is_gso(skb) &&
> >> +		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> >> +		skb->ip_summed = CHECKSUM_NONE;
> >> +
> > 
> > It's unfortunate that we need to add yet another branch in the hot path.
> > But I also do not see a good alternative.
> I understand fraglist GSO has some use-case, but I'm really wondering if
> it's really worthy the pain?
> 
> I'll personally think we should consider removing it entirely.

If non-fraglist TSO packets with CHECKSUM_UNNECESSARY can be built and
drivers are incapable of handling them, this has to be fixed up.

The GSO stack trick of fixing up csum_start/csum_off and then handing off
the TSO packet to the driver is a neat solution.

Though that currently only works for TSO, not yet for USO.

Apparently with a bit deeper restructuring the check can be added without
additional overhead to the common hot path:

+/* Like netif_needs_gso(), but only fraglist GSO, whose segments already
+ * carry valid checksums, may reach the device as CHECKSUM_UNNECESSARY.
+ * Any other GSO skb has no csum_start for the device to segment from.
+ *
+ * The extra test sits behind skb_is_gso() and ip_summed != CHECKSUM_PARTIAL,
+ * which netif_needs_gso() evaluates anyway, so non-GSO and regular
+ * CHECKSUM_PARTIAL GSO skbs see no additional branches.
+ */
+static bool validate_xmit_needs_gso(const struct sk_buff *skb,
+                                   netdev_features_t features)
+{
+       if (!skb_is_gso(skb))
+               return false;
+       if (!skb_gso_ok(skb, features))
+               return true;
+       if (likely(skb->ip_summed == CHECKSUM_PARTIAL))
+               return false;
+       return skb->ip_summed != CHECKSUM_UNNECESSARY ||
+              !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
+}
+

@@ -4222,10 +4243,18 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
        if (unlikely(!skb))
                goto out_null;

-       if (netif_needs_gso(skb, features)) {
+       if (validate_xmit_needs_gso(skb, features)) {
                unsigned int max_segs = 0;
                struct sk_buff *segs;

+               /* NONE means the same as UNNECESSARY on transmit, but has
+                * __skb_gso_segment() unshare the header before the protocol
+                * GSO code rewrites the L4 checksum and sets CHECKSUM_PARTIAL.
+                */
+               if (skb->ip_summed == CHECKSUM_UNNECESSARY &&
+                   !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
+                       skb->ip_summed = CHECKSUM_NONE;
+
                if (unlikely(!gso_within_dev_limits(skb, dev)))
                        max_segs = skb_gso_output_max_segs(skb, dev);


