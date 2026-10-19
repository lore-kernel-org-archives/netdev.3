Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1144EDCD6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411430; cv=none; b=eOCJWeKgM0X2bOinUalXGIvkGBUCO8Wxuv1H8QBrruKuda51ut+Lc2gMPuMacRQH7nqFhSeh5Xc/Q1eeTrOi3xqOaO4sVv+xySbpOswWv0uRDIHcdBZJv8fRP5QPIJyuKqsk8lj1e1d5eBGRdRlzvAtp5KeG0UHVZc+LDKYQAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411430; c=relaxed/simple;
	bh=IaWSRvOb2cGYlSz53/UzuVPRqHxy+V4mCLIjV89pieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAkS/RvdYS1Qtl8SvS8utY6BYVxidhW8kPLVqYlMJh8tLAu93Md+Vani9Ak6Dz/u424X+NR2pG35O+qNE0+jt9534Otvky72DR6uumYK8i6zMtxmUbPuyG8gwdVHPxwgtHDu+OCqB2CzM9jntsJCO/KM6frJnQy/4aZElWtawk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYi2GfEU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJgQ7MyK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYi2GfEU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJgQ7MyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaP8+sKI0/SWouY6crwA9muX1ZFQBStGGvXIun7lVgI=;
	b=NYi2GfEUfY24Zm5abVp6bAlGbbKfHXBKwC4FT66jc7B5VlglkGaE/RaLoJXYQS/48IubUH
	0MlG9rokDTqhWC2oQ/42wo1f5pxZd8uUvscyZg8Ll0pilV/KKUv+X+PR38KHn6GaK84U5/
	y4zv154CH/mPy8I95k3gldVLONoJOGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-qA6lSBxmPCm__ThLtU_FYA-1; Mon, 19 Oct 2026 12:03:47 +0000
X-MC-Unique: qA6lSBxmPCm__ThLtU_FYA-1
X-Mimecast-MFC-AGG-ID: qA6lSBxmPCm__ThLtU_FYA_1792411426
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso11816915e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411426; x=1793016226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oaP8+sKI0/SWouY6crwA9muX1ZFQBStGGvXIun7lVgI=;
        b=MJgQ7MyK/09Rh4c36YDxarkVl6gMawS6YDGnXfp9D9ZO95EWDIlPl1WyCoyYfQ2EDF
         C+3GEQqEON4dkWKVneHaCg7SnAK1GVJMev44UOy8ExFGxTsxK2/toW+vEHXvmROpReTc
         /0+8yGQD+byb94AXgQ1ieGanFhlyoyYfrDNZeAPJ3XtRv1OHlgVCLm3zav2KKy6wDCtt
         rRwIlGxbsY3SHC1FqtAQ3X9Moq1V1V2417EzS4eGyyvlJCDTNDlqLw4lpnasr3HqpB9Y
         1JnlgHjyw2fTmQVyFtkL4ZR/QpUXjc7GV5l5eyaqsLkiutMkD8rjPwKg9S1xmTXy6suU
         FTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411426; x=1793016226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oaP8+sKI0/SWouY6crwA9muX1ZFQBStGGvXIun7lVgI=;
        b=GCTccZMRoVWApLHNPytUhbARNyZKusmp4KErNSgQs1PzNqThD5bjJBSgNFl/G3gElj
         sJKjNH+3ghyvQoKi1qeN5rlRDQXkexJ346/GmwX8XGz31YmNSpIeW/QGJbSn50GYi3R8
         fIeYPPnA4avHqz8QY1AJjtR3MsxjNs51Y6BdKl5rxiKC1lveRy8m4uPGI13yFRolz0aQ
         ZU/8m3CK1/JEL3pBTLJObVhUYJ9wS6eiVZv+Nscs366lTCuFse+PoK/xNbO0LksStIZq
         Q2baT3xclQodmYU0ooaa4XpwWctXpiofvYoewRIR+g4kybk/gCYMqQdgEi5fXr44P3QY
         dX0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBm/ciVno31Bffv33UDtyPQSBUuREM2qom71FOPq9HIrvRhr6W8I6lFu7GT3zEN7ne0LCGUDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvUDAH5q3XcDEL5A4xkIO3aS9kZ8ojA9p+AWV9yzkn6CytFDTF
	m1ONcBm6jDUQwJii3ZolOOGhNLhEGKizjk8b92LSU8ALKGeEZp0Qh+f2pl9JODVsvsBd6/EkBnB
	YRnS9q+s3LLI94H+Lzymj/M29JKBh0WijGYDPNvU7yrjoKqgk17IPTejbxA==
X-Gm-Gg: AYBFou3qn9r6wyS8oRjKvjnTLvrEKs34mgS8Z7p/QowEddr6Hsn8XwMSyd4JFKcNXeN
	jl+8nvIFu0zBGswIHFVf/zcVABLWYOx1n5RtofN/WvBXmbjL2rGOTU1vmy9zVZ6U1EvYSewdPOE
	PT8nuJNd36NcPKAAGzC1D3FrmYOz5wqIoL3E0Bh+ya9vISqo4duVeZI8S5GaG2RwIF7wP4hN4zm
	9bOuwlzySxdcFYHTTfjMEcT707nyXDvwGUjkoywEN+5l37MgOs59MpZ3gfI95gddBAryQxBBp+s
	HEBQX+EVNmC85l7MrSum7xY5SmfQ+fdXl1zysXRr/ubYxRRqWgPvIQUV+/I0Yhjd6Wmjhw==
X-Received: by 2002:a05:600c:3b23:b0:4a1:cd83:b240 with SMTP id 5b1f17b1804b1-4a1d75ab20bmr196806665e9.1.1792411425843;
        Mon, 19 Oct 2026 05:03:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:4a1:cd83:b240 with SMTP id 5b1f17b1804b1-4a1d75ab20bmr196805755e9.1.1792411425263;
        Mon, 19 Oct 2026 05:03:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm24518591f8f.41.2026.10.19.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:44 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:42 -0400
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
Subject: [PATCH net v3 8/8] virtio_net: cleanup protocol calculation
Message-ID: <13dd30912d6d03da7f432e115e9db1ea2d2cf37f.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index beaecd9cd28d..bb9b5d016ce8 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -603,8 +603,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -624,7 +624,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

