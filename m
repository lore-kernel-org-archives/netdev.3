Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551624;
	b=GM5mpTH0O/TBX2G/PAyEEqZzkWoVBrHPfWHvT3elz1NjQZiXtwe7aJLBZCkkRQ8f0giy
	 PGSbgdYi+oersT8YqcjS8zRL1VxP4VvwgZnx4k3e98i0vbUVF7nTgiuYzWtaD3qAtmk+H
	 y+WuuPonN6nXD0NiUi8fCc9TCmGwuYxymgKLnOJZCnKB6DhlechYuGlpR3omhbZ1kPMHe
	 C4yBfIm3sFWsaHei/Umpz9/gMPNVxSU+WQZBKbYDe2atlKMq+VbwYs9/BuYjluWmri7iD
	 ZsMSXLS95wGsp6u7htN6BR1UvAH64HTe0Ee7TWVcUnyHn/01mq1LrbmWstmaZAhg/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jcWwVvsHGcVV3wfMX+fsnT3+LWyvPrRI8VZs9//T46s=;
	b=njEpXHLIOESSdRRqwWDO3AwS4jt11HCPiD4I8jgxCyNBwpNOAIZp6O1uaKB1hCvj1TX5
	 V5Ja/B4trWgEcpND+ydHMvcigYfY4bNMZFKIuNuCqtJ/mEBBL3HcpSqQDzJopxHshw986
	 vKUq3ZjrG+UwEea7Bh1YMoOzJ/53lcBkW8r9brdF5287IXirdw6uHAcAE3vY7f6/7bR73
	 PK13b7ntEqcJ5/kpyGi+4UQCgWc+42exWjzxdBOlwbFGGUYiFULbD3456L4Zzhz1Ga2uJ
	 bCbMbSE7SA16MmYyX5lDnRe2PGu5x1G32Q7s8JkPa0xQBInzqD/bzZr97NPzQCxkN9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b="0I5fmee/";
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C08606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=0I5fmee/
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c414e5d282eso267426366b.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551623; x=1794156423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcWwVvsHGcVV3wfMX+fsnT3+LWyvPrRI8VZs9//T46s=;
        b=0I5fmee/bbK+vJPMwHkrVXTZ0WrA3xaJuu4QUdVw1uC+SxykNpBaiAmZ0/zlcIKZey
         2XWmVonCdQ4yYx+tTi5IYoJb+WU3a7oDg69/M3DDRyzPUIqY/kyKH+Oe78pP+i3QNn/H
         0M5CnbZfE4osOoK9hiuqS3Z8s4kH8mkCM3dbWKBjDSa8tKn9cI5kVBhL/9SU8bkS213L
         YShiHmChcMvC2aqjiSdEXMRcLpqs3cmRAJBGWSs27kCMAM3JzXepqj4X43naeoHCy3HN
         qTfVm7HYfEDUKL1lloTZ6hraqRfkhRfqBgckwGOBWjmYvTBOteZ5uE9yfEcOb/gob9zZ
         UllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551623; x=1794156423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcWwVvsHGcVV3wfMX+fsnT3+LWyvPrRI8VZs9//T46s=;
        b=MbAA57nuRRSMT5XsskIwlNb1o6s++5rD0lGWbFjbUgquJ6dTC1WX1ZDKnVpuFOHXLp
         RsNIBXVKLFTUn4ELFqcVnmSTXRmY6jhFRmmNFFN9rKV57/DYbr8Mf3Zka4sSX/oWx8lC
         7mjhx9sIM33r/V2gtkqjC9ko0VXJ7u88Pk0E2RSTxdukoiyQaSRanam4q8ycQKzG14no
         iN+gmV6OfkOYvn26U/jTG7VrqPZXdScxRofwxA6Gdr7otrLYKt9+Hlf3h15y11InPLvx
         UMjTSWMQoQGnM8wRy+LsiovsF87lK2+QnhYbRbGql1lVyUJSn6c9ebdEe0usMpWRbrag
         gweg==
X-Gm-Message-State: AFq9FYInLocGugDNLHTks+xQ+z7eFO5V7+TW9tdl0oTY5u8iA8SFvuGW
	RSs/5AZeffP3+saRaIZ8WvBatuQv1YQYW9VunFGkbZFzHQn4qAB0frT0ophuuNNCnw==
X-Gm-Gg: AYBFou3w5Z0c9/MaSXZYmHOBMDKkbD3WP7D/QnDEViHJLz5jDIquTdke1VV9iPqMShp
	GuJ+bI+qD+1rmx1xQ77eIbZ1daN73jgIiJBXqp1hykOD3DVcKRv72fIPomfseMqysPFk34y5Jm5
	GlpRLaOlS2GcQVAhdWeskL3k5sGr1rU+L3t8q5D2pAKFaxBmjWZ45vLnpHM+QwWDpIsnaoz11Cy
	BpiwMsjDqHugu653pSXFw2rVkZ2hSRuSswmu59HTpAnf9A4FnjmNsoF5TAaUk9zrNebWJhoJ+x1
	dcitao9j/GyjZJGSBBeo1eHVaxDfeNdqTRW5JoAWU7tWZAqKQqukY5OfAE2rxv/d9TAmdf4rB7D
	heDcoeXkoNM4CX3VmE37rusQHjuEKJEeAaQjrAunsE2CNx2BpSRJW7AXAijg9PAdyJDJCwtCpsR
	9v/vUqg1nRh2OkS6y0da3SG+0tsTPcUKxSkmviAeKlyX+lNqW9hknFasCVTF6y7v2EYCc+yfXam
	/qGiHAeJvOg8PlKwqgCN45g8TdEmv9xkNHIpZtu2Meuu580MHVquyKVP68wr0mALtkipMW//6jR
	VxWqSUgzIm3ApV1Sn2nGWMmiwJcKEaUAPxfpUH4gpCV6H6hCkfxokuKjXAuG+Q+Ap6FqT4Qp0KP
	1TiQLrYIjC8kJBC8ab/ypg0MJOiZLQYf6DRiXneccAhH+SwpBu8rgs5cJAkvZbtzBamZqvA5WUI
	73T/d7+ZXvx+Lt4a21GzItBTB8EKQmjqJUVzYwF0R+vEdEZ36hclC49zK4lCEdON4JxmbdM7KRp
	wGNqvtr8SequX2PYbO0qBQNP5yWKRLdhyRA+8yK7scvq4lqF/aIhf1OvqiC0w0VTwCrY0wRpT9H
	hVG9yWDTzLeIC6o0nTk=
X-Received: by 2002:a17:907:a88e:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4ca7b20cdcmr673840866b.23.1793551622679;
        Sun, 01 Nov 2026 08:47:02 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfdc3csm291298166b.17.2026.11.01.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:47:02 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/4] ip_tunnel: move the TCP fixed-ID flag to the inner header
Date: Sun,  1 Nov 2026 17:47:01 +0100
Message-ID: <20261101164701.301997-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179241582749.3135.6106878374160339370@kernel.org>
References: <179241582749.3135.6106878374160339370@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Medium]
> iptunnel_handle_offloads() is not only used by the IP-in-IP tunnels.
[ ... ]
> Wouldn't the inner header then get iph->id = htons(id++) on every
> segment?

Agreed. gre_gso_segment() and __skb_udp_tunnel_segment() reset
encap_level before the inner inet_gso_segment(), which then tests
SKB_GSO_TCP_FIXEDID, so for an IPv6 outer header the patch turns kept
inner IDs into incrementing ones.

> [Severity: High]
> This assumes SKB_GSO_TCP_FIXEDID always describes the current outermost
> header when skb->encapsulation is 0. Does the decap side keep that true?

Agreed. iptunnel_pull_offloads() and bpf_skb_net_shrink() leave both
fixed-ID bits where they were, so after a decap SKB_GSO_TCP_FIXEDID still
describes the removed header. That is older than this patch: GRO sets
the inner bit for the inner header since 3271f19bf7b9, and nothing moves
it back on decap.

Multicast routing does not carry TCP, so the ipmr fix does not need this
patch, and v4 drops it. The fixed-ID state across encap, decap and the
GRE/UDP segmentation path is fixed separately in "[PATCH net 0/2] net:
keep the TCP fixed-ID flags on the header they describe":
https://lore.kernel.org/netdev/cover.1792857378.git.julius@bairaktaris.de/
