Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429767;
	b=VEZC4IgUa1njXMtacOAJZFT9E93PXCeR2L8yksgM898PdIF8c31uRE7hl7lDWOJvf49y
	 bNWhPW+1I3epI0oRvagQ5/V4uJtWSFLmcaqw76ziBV2s/mqaVhUe8Pwzt4SOLOdABzY1Z
	 azb+ypWCUEXfnNgBFb7dCplgG00jqdMJh3xygt9o9raHjGsr+jDh2i9sCgF3/AxHhMcpq
	 IzfIFGG95boCzQ/eqgNtWZbbismvNCwsIQ9vnsbBlfcTrGSejCgnGKmwdupC0vPdFNT1R
	 5yQWde6T70bzxKAjR1x9AGv4Y9oc/dnePJ7hDPmKZG1XjhebbkOnzP21Fle9Noa3GKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=P01mh0gGXgBTKex8RQ8DPGeXMVKoL09RGgf7TfZXSqg=;
	b=kkdvGJZ3YDSEug2UI0ive6pdrrwSrZNVINNBHWEw4aYGu6NXycKwEa37c73+H/k97Fu7
	 6Q0bh6ySZrENHxnKs/ySqHZN0SGt8dSVTFrwCY7X40tDF4oTz9rsPRsWGzSuUeaAxxJeJ
	 IET75CHFJDJmt36JOMdNfi9pUZJxjzoVH3/nQhWKMO4ZbzlPUuUp+tvVs61f9nmRUGIJX
	 h38/P0mRkW4q2YKjz993xSJgpYAoiyl4B/htiHY8xgvzSQwzMgjUjU4mRa++uFZN+Broy
	 aXOpX+NGH9jKOipwac7RB30kU38tSTyePMoGaLKqSD6/eda4dsT+NiGqfsfIMNj1/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqK4VT5D;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7B606A331
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE7B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqK4VT5D
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so195319b3a.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429766; x=1795034566; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P01mh0gGXgBTKex8RQ8DPGeXMVKoL09RGgf7TfZXSqg=;
        b=zqK4VT5Dihb7vTZzP6PAfjlD0VkxHmHYkcShN701E5YnyxqqtVnY5xYlh6oYry6C9t
         Hq+7q4tA0No4aZt5TxjKD/lI3Kb5UapNzy7HczYME4dDyOV9ArAZH000IsbqTOTsJrlP
         iWIJN4Ao/5xyxu4AUTCq+hKXQz8XwWUhD/uHZEonr+BUXKLTNEHxsr1NOQARw68dnOEr
         rQaW3e3wX8z/m1DKOiafcYgu1UjgF1SdRBJwoIclKgAcX0DeX2Zh8L1YCnaFVspTZOIc
         gPy6HmQSvcTS42I8CwZiGtDEle+as6BGzMNgkhFH6KsL24PoY4Qr/ibUJug72qC0MtOK
         H+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429766; x=1795034566;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P01mh0gGXgBTKex8RQ8DPGeXMVKoL09RGgf7TfZXSqg=;
        b=nXcjLzQev/etXwN96X5H+545YgZyYB2Oq1ORUjQGIE3y0ujwoQPc7p67zbWjPS3wHK
         kVnAX4t6owAq2AAy7tQcAZkPg4nyUOjwI+IPfvumzRhJ8GG8s+SkeMQPye9deBrrT+wS
         1krgmOO17k6NVvu3c79TCKLFc4ynqg+2ZtUeDrIcT5C1zMTZ8wlqKF3uDlni6zZvvwBs
         qZi2+fl5dxUbP8QVM+IgCLuuX/tQSKjbq/miOeO8JMHT5t9k8zGeHTZULmbHMo4eHQA1
         0RQDhEA57gBoak1KUTb3k5FXHnmE+0A3ovLHnOJGHvF/zY+E6p/aYrgA8aKmzFp2HNhO
         h2Hw==
X-Forwarded-Encrypted: i=1; AL+hErHZMKddw8Lk51JH9knYXu0A22VYM/SQWUSyqtvW57KrO4DfqlNOiVuAadGBQYW//5K8RbjeFgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z81YNK1UiQeV3U2JS7mn26Gv1z3u78IQBCgD6UjvUbfQAWJo+Oy
	pNNftwgDQuVcoOroyS/ltDlF3idl85DvLjHkIjs71DGis8gXx4GmA2g1
X-Gm-Gg: AYBFou01qmibO6UR5EHbHC+e9YRs50xP60AcPvex480yzrVzV5P5aSR1Kdjdxi61S15
	1SgnnGXx5c4DIqDPpa8PmFjWCZ54FwkXQh2Xb0dlz4zVvH3XeHLEx7OTWVEfwmiNW5wiBXcq0bo
	5m26KxXGJgxXKxNgztaaLqqk58ktMtE8WRJfHhAEx2LsgigqpGbeKtqE5iCDRUl2bc9RWqLKcMm
	yCW94pe527A+1Ot4VLLaEV0OQk6pcUzJHn0wqdrSHbEHPmFElWFxPgdpfpuzq3v8MqslDw2A6Og
	pGnDfTpaLpBxL5weT8heo7wvjaGBZoQxajE+fI076wU8Yt7CL1vopdyXlHz6NLmBTZyB8jW+S0C
	olnebA2ySiHxwLI0CUy7HEEWc02RcB899X0ZclmQKxslMQBdgH3iBXLGs6U7mEJt45Sx1ANraM6
	uhX2E+gF11K8k9Mfjs33VSorKsSYzdBOKrHzvoNmdGMDBXC7riEHdseGS1pUYxBzjsd8nGu5tIk
	BSyzBWzUTFP12vYynpAcGLdI+fe5mu0AG8jOQ6blRj2dDAF1ZvIpxeyeqDija2EeazzdPLNlMoX
	mkoAR38tNLNlHb8FumbfjTsha1PXCMOvUukhwLJy8S3SDHAK
X-Received: by 2002:a05:6a00:991:b0:89e:37b0:d1b2 with SMTP id d2e1a72fcca58-8bc1ca741c3mr3731307b3a.37.1794429766245;
        Wed, 11 Nov 2026 12:42:46 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1226e6sm2395194b3a.43.2026.11.11.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:42:44 -0800 (PST)
Date: Thu, 12 Nov 2026 05:42:40 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net] ipv6: gro: avoid truncating transport header offsets
Message-ID: <avTTQNyvwPP6LtGx@v4bel>
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

skb->transport_header is a 16-bit offset from skb->head, and U16_MAX is
reserved as the unset transport header value. A long IPv6 extension
header chain can make the final offset exceed the field's range.
skb_set_transport_header() then truncates it.

In the UDP reproducer, UDP_GRO is enabled on the receiving socket and
the first packet is held on the GRO list. The truncated offset makes
udp_hdr(p) point to the source MAC address. The first four bytes of the
source MAC address match the UDP source and destination ports, allowing
the second packet in the same flow to pass the port comparison.

gro_receive_network_flush() then derives the first packet's IPv6 header
address from the truncated transport header offset. ipv6_gro_flush()
consequently reads from an address 65,536 bytes before the first packet's
actual IPv6 header. Both UDP and TCP GRO call
gro_receive_network_flush().

KASAN reports:

  BUG: KASAN: use-after-free in udp_gro_receive+0x1f37/0x2680
  Read of size 4 at addr ffff8881065f005e by task swapper/1/0
  ...
  Call Trace:
   <IRQ>
   ...
   udp_gro_receive+0x1f37/0x2680
   udp6_gro_receive+0x23e/0x11d0
   ipv6_gro_receive+0x1200/0x2750
   ...
   dev_gro_receive+0x1a7c/0x2600
   gro_receive_skb+0x271/0x970
   virtnet_receive_done+0x3b5/0x12c0
   receive_buf+0x33a/0x4b40
   ...
   virtnet_poll+0xc69/0x1980
   ...
   __napi_poll+0xa0/0x530
   net_rx_action+0x8ff/0x1280
   ...
   </IRQ>

The out-of-bounds address was in a free page, so KASAN reported a
use-after-free. This classification reflects the state of that page,
not the lifetime of the skb. The invalid read was caused by truncation
of the 16-bit transport header offset.

Use skb_set_transport_header_careful() to validate the final offset
before assigning it. If the offset cannot be represented, the skb is
not held as a new GRO head and is instead delivered through the normal
receive path.

Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv6/ip6_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 700f1861d8eb7d..de4bab42359ba9 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -241,7 +241,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		skb_gro_pull(skb, sizeof(*iph));
 	}
 
-	skb_set_transport_header(skb, skb_gro_offset(skb));
+	if (!skb_set_transport_header_careful(skb, skb_gro_offset(skb)))
+		goto out;
 
 	NAPI_GRO_CB(skb)->proto = proto;
 
-- 
2.43.0

