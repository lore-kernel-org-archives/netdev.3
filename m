Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAF52758C
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068092; cv=none; b=MKxqBLlaS91oO7aDWh5E0MW3CReqg92kq1Pm9rO99H5JiL8Xt4snLw4y2TXhTTw+v0lauQrltx7/6PTRnjOHJI5kLubMxs92oc9fss0gjhkt9ISwQ3Hs5thkLQ/0sotYH75NQzTEg61N9kUjtwB8fY+GRo0eSv2beOKW8skFSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068092; c=relaxed/simple;
	bh=B9H+Ad0yi56qqX3Wrqd3mE/6pQkLakPw4j1ZK3PT0YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WobzsgwsNaukdd3ABLkkVuZ2mk0z+qRlhC/manFs6fsGUuFiaxqucWfe2X6HsnvyQWUSz4y3DIgT4ORv6cXD8wWM+nDgrMBJMnRZbWmLrY+FNLjpTVicm2Ylv40mnFbdBeNuSwfIJZl+KaI45CTlL8vxvuAQfKDrK9uJRL89CVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaETDrYX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbGvYkZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaETDrYX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbGvYkZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
	b=eaETDrYX0nPqaZ8/qwhSwAxH7j+iQEgcd2E+3/ZgJsKaGhXku8pCS+WwQdoql6EvjZXQ52
	gjxiBvbHMrmGXcjknGp2Kxqms07SaGDAwv81xYjy99jlCRcP/ROU3kqDZZvYUkTi/I5Q2E
	zqCZYt7Q+MwINe+Yoz+tlOIkgsH/ZZw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-c9ct0RMBPMaw3wR5oTEVYQ-1; Thu, 15 Oct 2026 12:41:26 +0000
X-MC-Unique: c9ct0RMBPMaw3wR5oTEVYQ-1
X-Mimecast-MFC-AGG-ID: c9ct0RMBPMaw3wR5oTEVYQ_1792068085
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso4240129f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068085; x=1792672885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
        b=AbGvYkZ4TxllfD2DAaTPBCOB5VVDgXqZCK6bJvUrFgWuCRB2MtWe2UKeNmJmFaoR3Z
         GmPytInp9yfZz2pEftYFF3CMZRN+UKCsliNoq9Bt0nIFk0j4HzJiYSNnqRnQzYpxsBdA
         cvSvqIigwC1gEado1848+6X+LHnbvrUp04+vcZR3b+S8ffYGNuik/vIIvH9hmXwRLTGV
         aOdIQxPCzjRKvvsYEjbjgZ+Ioi/vpEs0qEwRj7qXNTeyNrlDmawIYMdd1ogvX6s+uYYk
         5MIKSqvCaSHjy7eq+4wc6SPhRNgppDxdQMAcSvJjlDduG8rzyQiLjBrAm84kPzCJnaJ6
         Ub6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068085; x=1792672885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
        b=Ca6Wy4y8HOL4NOP+nbYcm/gKn44dUnlKJ8kluTemx20WgDHbkeSUmRHNqYTBaSP7qN
         m31+NGIUBPEkZhVv4TH36CVZZFqwoR+EheW3cBeJAKsg78xtP+aiw5zzYJ7moK2Us7M6
         CGO4i350/2L6ttsyVKx/r4GlIkx0g/A/Xid2LKZG7ier63JrOQ1bJK/xJ2Az7fT1CzKF
         l5hkNc0WZNK2N9sMJ1wPTEiKgZBoyIeDpM+HVE1140Ys2wAhjXDUJuZzAWU5Io9cfjS9
         vMz82X6P3rviyGLGKdkM6zqzB8ESyfRsfe6UQ5EK7QE/BsaL9Str1slKPmSX9UD8hR9l
         BssA==
X-Forwarded-Encrypted: i=1; AKwUvBzpOi08i3kVyxZ9SEAGkMML0mnFmRUR/j/vrf+lnzBXKuNRtG536OPnlR/aj91gPLSu3hQBXX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJz0vWFh1hMpVvwqgMfF7AJmIttbvhm93867lL/7o3RuwlYz6+
	yAU+4RkCeNWFfICnQw0x5RsaoRfYdAg50yHCJMSXvhNmYlOCnEtALh2JnKf8WFuw00Y3mUfF8bY
	CQkvLfAEJ+b8lSxmZnnPTQIxwa3IoXtzVhDXiId5yIszkwFd6DQlud4hFDs5prJjk6A==
X-Gm-Gg: AYBFou3mnTHx7OT72r3cPRv8Wg95pZPem6ZMZOPJBLv00l4BvH8VwzXGTqqDJXDxSOe
	pEPMflkz3WrHHdTnUtXndvUtTWvIQRTaoiksbr6fSCSLNjKClLsXhVpE0vLUn2hiGCosqsXE1hg
	TOMwzjJbn2DyGdO1pAD9KLpLPeuGo018xoOwpFjpztzmik9MFjgPrl+hxT0DBg/Mdi7nbmU3Eii
	VexVtLwNNfFRBJlKgJ8c8/7dBp/UuktKvx9niKYYJMS/fI4JQZ5U5rVtEk1E9eN1lLP5pZKvNr0
	DUn21L+yHEJqD12lh3NI72ik3nvm4vkK/SoGwgfrXf2EQB/aWmWn7OcuGTvU8dlkVGwFlg==
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912250f8f.16.1792068085118;
        Thu, 15 Oct 2026 05:41:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912175f8f.16.1792068084547;
        Thu, 15 Oct 2026 05:41:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm23198836f8f.4.2026.10.15.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:22 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:20 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
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

virtio_net_hdr_to_skb() refuses packets whose checksum metadata
it cannot make sense of, but the vector raw transport ignored
its return value: rejected packets went on into the stack with
their metadata unvalidated.

Propagate the failure.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..8b7548458663 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,9 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	if (virtio_net_hdr_to_skb(skb, vheader,
+			virtio_legacy_is_little_endian()) < 0)
+		return -1;
 	return 0;
 }
 
-- 
MST

