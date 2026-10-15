Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9D52BE5F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068120; cv=none; b=mTxzlJmb+WGtEnztMVqjhfe00imPOVYKPhfXqxfOGaQ/py9bmWjaMit4lcwl3bZnEKRKrpATt6eSTNi64V6re9mhM5GljFyb3qsRv4Jl65KPCyUoHAZZ6KF49rd7adLnX2mE7IvlYoNevbJzC3dLR6HmfsZV0+R8+FG9gVew5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068120; c=relaxed/simple;
	bh=FTwjQZjllXzgo977Sf3MiFovVAncHOGHuO9YtIzBc3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9HlwruGI3yUuuRVyKCQmTFiE7Xubc5L+kFoiEE049mTarCsKmGzYs8be45SSeAKbZWWHrvZzQbZkJeUdWH6lTo4OWxqcxvEd8ihlHkZIQ1+6PpaSePbsjnDOtFseen+FMOQ5msxfI7AHcUQo55D4ZrdvvO7Yl90RK3fCBb2ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgB3sP9d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMme7vQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgB3sP9d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMme7vQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0zC8OJ6Wap1IWbd88wEN7TwTQBf0XfiTXbdedWRtNk=;
	b=YgB3sP9dEnUjGibH7skj/5Nrq3w9xjr8EA+aTPnRNTnXsxztpLAG/+/pYytNNqXC0EQk7E
	Mp4sYEUnD5BGsanZOK+crAPFHa7kzohnlokPPZiv6x14Rf6bJllqHyVNDS4HwYKVMFPhN1
	cjVasQ2X4EamSOAVz2QLkkf1asGLCdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-j07xQKojN0y_wJq9U2iFJg-1; Thu, 15 Oct 2026 12:41:56 +0000
X-MC-Unique: j07xQKojN0y_wJq9U2iFJg-1
X-Mimecast-MFC-AGG-ID: j07xQKojN0y_wJq9U2iFJg_1792068115
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-487038bc9b8so4220752f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068115; x=1792672915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0zC8OJ6Wap1IWbd88wEN7TwTQBf0XfiTXbdedWRtNk=;
        b=TMme7vQZznECjHpnYeNObJDV8BytbFD17NyXNqDtuYlEhdWKvSM6aIAUdEhCxyQJv/
         k5mf3oIlsAEp0++idEVt7/oY07bl9adK8LV61ccCEOLKj4h6aL8PFXXq46TCCStw4LUo
         5UVVtweFnl4Xn7Cvw8izJ742X+HolEqAArHdZBAP4xBXNAcXCqcS/xqIzTyPTjgOoKXt
         5REOu0f01Kz6vSkvLgBZCoLCr4U/3/jhAGc11S8cYis2C5qm2mzlkdKuQ27r4CD8J958
         Tbinpw7Mdw9noAsS7G75k1sf/XbCic9fUaKLsbLk0U5ORXq46avUcAT5/YSC2VpzdD5k
         W6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068115; x=1792672915;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0zC8OJ6Wap1IWbd88wEN7TwTQBf0XfiTXbdedWRtNk=;
        b=WspOTYFFgPopxLzKgetAGljMHx2iW4kEMZPDtQsaEWciaB/9uYhqOUcKhvkqDkCD7w
         WNyNVmE2u1w+/WXMzCk9CDSE77bxKbcYvUblsNR3aM7tOzMY1x16s80fnyYRbobmaE5a
         bUN64c2kvEAcJCqZi3QeOtdkibs9/p91tN3DB6MbOA8hmhv3/n+DzX8NSbjpA3ZNdIyQ
         RSpTIXmpovY2i6g02YsIy76NJwZPKc+j+d5ap6XGO/O6ceG3bzOTwDb/CjPtOhsU2mIU
         fO0ZmlVvvS+5tR9Pcl1CyVC0MmWId3Xw66Vvu9kcKo1RqU1yy2sMvjPP7zGifbp5b31J
         VWgg==
X-Forwarded-Encrypted: i=1; AKwUvBw7FEwueAsGcRZMg+XNCRJ4x0/A8soyssMZJ3f2RwxznvnEPsyQECSxNbF1AIwRqyrjivZu5EE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaeLA+igeZG456wiooH+lLHxlet7ecT/9WkoOwGx0BhrQiizV1
	Cv2IHtNI+0/9jo8lUqV1yqI8za4hM6rtO/QYslWepqyteWVshTBNvZyBQgobL/Lly+IfrE/ZILe
	pyDMaPFk+RzBFYRWrGIAQF2KBubXM2RZx/r8TtZEWUs2MbXSpEtbi/4eJ3Q==
X-Gm-Gg: AYBFou2zRKYBKRz/I26GMlP/AphcctjlKQuw9T+Q7/l+1j7pAOsnhsj9lusX67ET0PJ
	5vt3mjjVAqBXIBfrwL115D7j+Awt5mFALThVOWF6z03c0wFMPVj8bN3Ew8wqhGWoF9le3MK+VEb
	tZiIFUc4ao/IqHKArVQcsjrI6hHO5eDKxePbDn8zV7w8IzjcKe+rUloNXzexNsgPOWds7BH+g3U
	IC4N087vsh8y+rimz2sMeTdO4KNo/+n7kYAinaPITzTYMlWtd1r5x+DEzGg74/9dbZdCTK1WSU5
	/YnOqrMlLGZWqpA8rwL6jMupWutRpyYkvPbAQDJc7UC5XG8WC9i4Nzh0KeyWz6Nx0c6I3g==
X-Received: by 2002:a05:6000:25f1:b0:48d:f02c:eb68 with SMTP id ffacd0b85a97d-48df02cec55mr8110171f8f.10.1792068114637;
        Thu, 15 Oct 2026 05:41:54 -0700 (PDT)
X-Received: by 2002:a05:6000:25f1:b0:48d:f02c:eb68 with SMTP id ffacd0b85a97d-48df02cec55mr8110120f8f.10.1792068114075;
        Thu, 15 Oct 2026 05:41:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5b03sm19748114f8f.30.2026.10.15.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next v2 7/7] virtio_net: cleanup protocol calculation
Message-ID: <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 85ec1039f73a..a9ed42013476 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -570,8 +570,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -591,7 +591,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

