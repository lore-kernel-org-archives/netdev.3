Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B34EB877
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411403; cv=none; b=TdfzXvCBeugp4gJTtNYmEZRbZmEs3ire6orAyFRTuWCPraR6i2C8ZRhoDgsY8Oo1d71sb+K6bWjawjC2udIM5gQKt8d2u9Fii8cOpNCm1B5kwQvFX0HZzFALPcS3eQBc8kiuzbsypd1NywQcBK1dIc3hr3dh2n0wU7W0qrwzgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411403; c=relaxed/simple;
	bh=q3RS+TwRg3t5oZH6IrcoVIYjH3/jmXqxC3p1mYXXgks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmtCesHoQpf/zMZXu7GO2fCiD480F65IuI3XIEK8zd3pKoh+k2vPDvkoCWkIxVHn7ow1PPasZ5EpuB4peuMoVm2+P8p2SWdV+25Gvn18+X8Jt3m/niXS5pxUdej6nl+48Oo6bQUsnInbarbSO69y9J+f2grJV9lvcoaaNi3b0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPiFHZY5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLpwLsyb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPiFHZY5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLpwLsyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
	b=EPiFHZY5fICb2NVnDxyAOcqA4B9G6/T6GafpI0CpYiF+SA0KioKr/jJnnuGVW0CNPlGAfP
	rZHdx+MUbpTueXPhyJrktRhReqKnBIMbOkW6/+Liy1iRL82ZNMNtHnXzt95Eh6atQt0bDT
	g3c3TEbqY1dOSipw+IlUF79gNatYbkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-IrpD7fqyNT2fQe-uZ5pRLw-1; Mon, 19 Oct 2026 12:03:13 +0000
X-MC-Unique: IrpD7fqyNT2fQe-uZ5pRLw-1
X-Mimecast-MFC-AGG-ID: IrpD7fqyNT2fQe-uZ5pRLw_1792411391
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1544106f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411391; x=1793016191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
        b=PLpwLsybiSr9hSYWNcfpnEYJomXj3jSTyqzLZvm8DFunH5Gc4gTd4qneCAQbAnwYVV
         lbfX2xs18w++JnKvY/ZckC29TZxw6q4OkDiymrkfXNEC8JnKrSXlbxxnTt7CpmxYjsjO
         iBoVLc53e6mxC/WKwGFF+kx6AssFeXn+eYEVFk+ius3DK1whOge4+JxPkWKTy7F/rb+f
         54HyCBAesO7948TpAAWbsBq9+8eEOka38GMYfdK3dduTQSq2JLX4c3keFitNjlWHj7Ey
         qwQVv5gajp8i02bZU795/hFeD603jeD3DI1DKoxNFc2uf0NIWdrJFNIClZJ2kGiS482+
         YDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411391; x=1793016191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
        b=XoGuMg36oaQK4Dec2fgJzlNkB5v0IrgxcmtssNMKicMdtBWixicFY46k27yWuV0ZTY
         u+sBt77Fy7JDfKnADKGPopwXxp++CuoSpcZg9lg8G/cVdDKZ7tqK5ZzMQ23ND/IAhafr
         oYdwdSktAdbDk3gL667akf9t9p8t9YszyR376j1n+glkInd6gJ22li7sBIjiN/u8aqsP
         zg7tDz09knmYcH4x2ueGiTXSyLuNsc4JqIVIPrFs22KjiEOQ9e0+o2XgiTkaF5MlTQ5Z
         y4+lT0NSSb55+LWNULt42AyvywFyE8QvrizBj3HMks2Muz4+zJFigpGvQY6DskjyQJJQ
         j/pg==
X-Forwarded-Encrypted: i=1; AKwUvByt7aRwKngA/ng10fz3BZtt2Nz8ZHtKXkfaxLAeqQVZOxpvmOux5rXVBp9CIf9HMmMjvm6snFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbSvLkcQof57Z7rXI+FTAQ/1N+FfsmhDUUQqecQa/uYTfLCupk
	jVp0fjp4WVT4qyuK9xdZeypb/GQAW5GWMcSfP92rqgrrDcDUiAVBaUbLv4NKD+1EvSGb1fbwlxb
	MDhrzURWhil+6BBFu/Mdakz7/wv+uCXsqSTrW9F5DxIW29LY+5EsgJHvj2g==
X-Gm-Gg: AYBFou19lcrW7Z1TTszLDA/JQ6uQKE/LxL1FV800uoT+XVV7pk1F3ybjSEEo83mbHCx
	eezw4smbxrH44UeH3FMpEybKrBMrZ5qHRYW5jcAhd4iX/IynX6RlbujUe0y8iqEkMEOUutkF/2H
	jJpUSsjXSL9N+ZVaI/1Bz2cYam3CZK5LvVHvRdiUu5eosq3edUpxzPkeNnLe3TXD7LDIl4QfrCT
	tIn2GNxIO1lrfWDF8FKsP3d+EFcRasRtlo6ZkfSnm4dPOsyfzM4YxRSGPCJ/0R9+Mdm7dQlQmsY
	vvUfvWRgvzbBMWCQpuiEOyaqwtqAmcJoMZ32eJkC5zR5yrK4mDPzaP1yGra9zGE104qYRw==
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831745e9.12.1792411391185;
        Mon, 19 Oct 2026 05:03:11 -0700 (PDT)
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831005e9.12.1792411390490;
        Mon, 19 Oct 2026 05:03:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm20719207f8f.12.2026.10.19.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:06 -0400
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
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

virtio_net_hdr_to_skb() refuses packets whose checksum metadata
it cannot make sense of, but the vector raw transport ignored
its return value: rejected packets went on into the stack with
their metadata unvalidated.

Propagate the failure.

Note that a follow-up patch will modify virtio_net_hdr_to_skb()
to return a negative value on error and a non-negative value on
success.  This is why we don't just propagate its return value
directly.

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

