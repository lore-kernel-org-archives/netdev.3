Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673925;
	b=ir/8WqJ8KY1MUT8cxi1KsjiONaMdBoW1tvQyfrR9tg/wMtEnqLatdZH+xFEgOq3vQo7P
	 yZlDpEEg9alw9YypWYMeQEJXgWzsj3d7Kr4sbB6D9G9xDNki3M5iy4S+0iDPCa+56kwlR
	 1XxRZILPbVPApQvuZYY+F7P7nJKtgPCic5satjLdOoN00Isp1iLYn3iuh3IoEvX6Dy4CH
	 eTym80GReAxVbJQEsIj5B71qBkRDmsNPywiOvufbdvn4VypYTySZPzXNV3C6C7RsQzYJ2
	 tVAPHmN7mEfwaevg1QMxbSQPCRF16a4VLz1qtdWI4y2TV8uW9OpZD7ZTiRSI5d31TdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673925;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailer:X-Mutt-Fcc;
	bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
	b=VkxWEi47iceY9tgCJOPM0qEwq3hGHVBS8GJCRLg40k9JEP+QeO7qQceN13n8CMzh5M15
	 swaOIDof/u83D7Lt9n11heLwDgo8ICZv+9bP3O3sjU1nbnIjU7BQGJlZrHefcympvHfsO
	 dH+U5IxjzjXl2sESWccDa2O9SdBNUy/Fu4SIE3XT3ljcVlj/U6I8yldHEnIfSIbDT/JSS
	 0BwB2KetxtBSxL8agK0/BeWJ4e+5v8JVQ5WsSot0kpNtK9j02xZz1HlhhgowOaU+4YL+h
	 +33sYc6x6Q6w2Ujn7ln29egO588+HuPFhONjDj+mxwlu0x41g/YSGCFbwVsWtbcg1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTmKuuKk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sVwcwAZQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0260A3806
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A0260A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTmKuuKk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sVwcwAZQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
	b=PTmKuuKk/Lv7kMtclHpDyz/9oaBylwrRrHY2GCP+YjgzNpb7DqUTtsLPTFuKLaLzt/wlrO
	vCurUTaDOUP46hd4RVJn9JT6/3pS88IISEzoE7PRx7Pd/ZwFfWy3FajFhu8+5KL06OzS5t
	UKa4stNMo+ujQsxNFDisX+c+uD5Xpvs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-qeorMzfINWi6_Zz4TNPlog-1; Thu, 22 Oct 2026 12:58:43 +0000
X-MC-Unique: qeorMzfINWi6_Zz4TNPlog-1
X-Mimecast-MFC-AGG-ID: qeorMzfINWi6_Zz4TNPlog_1792673922
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1895ffc83so12521115e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673922; x=1793278722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
        b=sVwcwAZQhTs/O2+eL8iiHNYEuYXjpLOtcs/sTjpZAHC/YnK1MwdcOPe6LsosJtz55V
         y2PT8jdpEgnaLP32JCcgJIiE51q3jw6KgCJ80LTeJmRhSFCvKoKM0XN+OqObDDKA3nFz
         Fw+JM2SEnbyUKGuY+QJxztRr87u5yyEvIfysWhNBv0JrWcdHWQ2gBjtP7InL5B6zZ2Aa
         +v+r4BkvNCZ+GKVD/KpZjPthMgzymD7PaCyVRoSz/ZnIpWHoBYgkRm0FkEfhPy+FGVCH
         SF5BkiTldp1I/SgJT0t5NDPTKtAL7zCTO/GYQykZGkWPITFupdCzKscJTpgrLICVbSre
         aXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673922; x=1793278722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wm2lsA+w7xm6rhMTdU3cXhV3KJ+IpR+CE+ng3KKGWSc=;
        b=hWrfPcAf6hJ2inGjLXUJkN3eKKwz6Ei+iO5MxrjC90pO2AKtqtds5XvBgG/g4uTmpu
         vwW3Av10E2uonik1ah9px9zHPENOdKoXBXg8gKQ8LIW8ddj71euA/AOY/NrDp8wd0sRc
         i2+WjJeHrQfPPhqf9AktTQwvXsAD0X/0LMFChN1Owhu+yLZFuUHw/fiKvzmWdldvlmC4
         Sh+oU8IqTzYdqivDbZlYd1lRrSJRscHSoAbgMWufF+w6dMQBZAx2c5cHSWll7Nk/wsvb
         /z8Nl2kOEIWMGmezpRGshw09scB1O2sRvN8ORBMA1GS3voLqDZh6vatMVizMDPgJxy99
         y3UA==
X-Forwarded-Encrypted: i=1; AKwUvBxc0kCoiTjDAQLlLBwUhoTT7odeMnQa6MXA4XfzbqYaImKke7UV3b+SjUKjSFOWl/PT9cbE0ek=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe7Yi4iSq1ZLHEC9ZqpzxlZrbAD9v9PRFDjc7kUvF0uBSxdu8D
	C6pu2FtJ87yA+FPtu0PFVoWAEAxdeUF3IZuCPDEko/yY0L8y2aVzn/kb21GKhtgMz6YSgjjpo/J
	yJkxmBdv1IQJ2CnztNlCZYoL35FV457XRFH9kuHP0cmhf+gUEu8Q84evhHQ==
X-Gm-Gg: AYBFou2QLQ+RybSd2nbOYvkt+o8E/FL6xJbFhQj02ydjwLXL2HVtdPTIeTuvg9VIDFp
	q4HEALZqGjX3vhLnPbWvdMMtAhvAvAaixQcd9hfSWfeufpfX6kUdZiZXPn8QORhSUXTtd5mYeqF
	UTpoupMKaZ9qmy/JCz9zuqp2znKl4c1HL6y83MpApYFuQD/reh9kqqSOKz/FCXNhxzyCSlT9Jon
	kSNPOhdC4T2sUvHHLaL7CDPLcfLC+EBBRLCX9EMSKWSM0WBUqMhhyxeCFu49fAGJ06VyHHwx57f
	rxgtuxM51iTRMioUAEMk02kFJbchEZZT8fIEiEzrcIdaB15bEGm1hcpW2IuzMvfoW/g=
X-Received: by 2002:a7b:cbd0:0:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4a1fdd22fb0mr76175155e9.34.1792673921675;
        Thu, 22 Oct 2026 05:58:41 -0700 (PDT)
X-Received: by 2002:a7b:cbd0:0:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4a1fdd22fb0mr76174745e9.34.1792673921125;
        Thu, 22 Oct 2026 05:58:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a62aaasm69570865e9.15.2026.10.22.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:38 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:36 -0400
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
Subject: [PATCH net v5 7/7] virtio_net: cleanup protocol calculation
Message-ID: <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
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
In-Reply-To: <cover.v5.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

A trivial cleanup removing a duplicated code line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/virtio_net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 063cc116e51a..e984e446ba44 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -613,8 +613,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-			    htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -638,7 +638,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
 	 * set CHECKSUM_PARTIAL.
 	 */
-	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
 						 inner_proto))
 		return 0;
-- 
MST

