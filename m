Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551357;
	b=xOEbUwiQDtVc2OmsSU+zhK2LKpt+PHIyv4Nr4aG47qT1DRYr3WnCZOeF2uM71hZGXH6Y
	 ZvxhHNnTlYIt0mIW57d8lIycUaAWJTPdgBGom6Dmkt42WCVVYT7Sp4dTbykJ2A+vSD3fb
	 GDAss0YbtF7v2x0q8SdhpzQmjGDmw25pUnqg4h+WqiSBP3svuYx3BBfxS52GimtV/0HnU
	 n21girEV9MMnjaMEmvXDD7wKzBdfnicR4p0pDM4hM7IS+eFSL1jTNkOQEpcFe2gC2DeUg
	 URtr6cTkCIwbj6PxUmppMYeLnpT3DHi+YRqJpqkrX9yYcb8AxzmEnIeK0KVoGqKcE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h3piVyXKbxXF45kzvRxf3YzN7IqLeFtgxZUOFf2nvGw=;
	b=NQj2N6IvrINEykJnTpJyQgzyO7noGPC9jE52I89vmkgDjCaLGoJX8/TrCGqPNZxDnDrr
	 UDeJdeEv9xuyFv0QjbuePta/IPEos46B2HN8T3vZY2vGEU0wWHEs0mCo439umpPZQjfVa
	 cP4h+3WdFQ5jsR+WEw/Ta+FVcEoyV9q+8VpQuElFYIE3+DsmMiIa1QT7hx708SAcwuuNv
	 WBE/ovT7oerPg+W6OfMdDlAMtWazgB/LkpqdweP5JPWzg8tKJRl6dnTfv7/WLInQHZK9J
	 gZO7gMjslbyT/kxp7022nLt5hex52QOVRVJ/Rbs9bLWlUfNDmVi3/ORjTyckUzEliWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=r+andFfu;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094860A2605
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5094860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=r+andFfu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c43373ae89aso335889566b.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551356; x=1794156156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3piVyXKbxXF45kzvRxf3YzN7IqLeFtgxZUOFf2nvGw=;
        b=r+andFfuYmw8tZ/lBNJViy2W2AEcxc6un9UYY5rwNr/Jhvd8dYXvktpWrfuHUdSTIa
         Rj+FTyXbSeEYNMd9WHo04RID4gHh4ToLGokARfRdSJPVtObzrE5lj4dVRoWkz3KWltWM
         tduyC8cQAXFXrR2spedEX/2jERqpZV+3PBFKzkVW8MK0Y7eq7/HYLH3WnsOqfVBxTeA0
         W6X+rBGiJYMNz47X00qO8ibKU7G/gl0eAAKdH3ePWlNQph4Nwf3hhJV64aJPGUtrWmjf
         cud50d7G7XSl38GfoPDsDhn6+PFioPVvaTuvN6TUwnavvqGREFxUNBnRG6NkGIs6fM/T
         8m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551356; x=1794156156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3piVyXKbxXF45kzvRxf3YzN7IqLeFtgxZUOFf2nvGw=;
        b=nSXq7+ct1qjmT4PMBHczLBEnr8pfkx3TqSmhHSlF0jpAyWJgppC6HGk0FeLZy6PDxL
         z68/OAsWF88aAfDb8D3GCkSI8MWxPggRLUHjO1ZJljABvSSLMbg17lBn6+zPlTG+NIWv
         geIuUVkrAVIjpfuOCQv8mlARo4JLhSKBmnmYEQokLonvhIDBWOl7e9rHzFWn9FWyYlid
         IS+S3cNyb/VsHVyaNA59SFj4vCHhLfIBEPRCzE5bI/IjKcQvVzyja8cSDOzZNFb1EN63
         iAHjhTwKRkgSm2TCCWHTC2XHmjZ6RQGSAST6RwcuXFnu358RhMb/2vfpjBS9y0xE7u7q
         PylQ==
X-Gm-Message-State: AFq9FYJK3/qcwFofFF4/zL8dQbVdXnzK+CdhJoZoTGyGvnTOdU8iw8sl
	earbc24QfEM9ACIvabDczXMWsXeRbXUoLzSRLmSc1qJqObmlpbepWvtb28c35S5vFOipvRb5E8H
	iOl/1Yr7s
X-Gm-Gg: AYBFou136UgYKWKxujaZgHY2aFluwOgIXX67sFlGbpCEbkZWvlccXtYL0Mumcsp4UVl
	7NIpgyj0Sw+DdXU8IAtnBxuTfIxPywC1J7hEmylXrIj0SzUj6f40x3okp7SswX0f3n/jjy5GeL/
	gchNeWCAI/Z8AFvtOji8k4fQjokecGJiNxl4tRZ5hh/zv1Y0Ro+sG/mLMmjYvk/VIvAWihC2QhL
	ER9R1N+ttTK84ueXrYAU2LTxpw9EI2kMuixiw/ln+R0u600v1FoUXSF9PZkXSdz1cZ/Fhj7Mnsz
	0I62K9pyBSfO3ThlL12nVhqcQvYyN6bLu0n2PgCE9sNW+okbNJt0/m/CP7H/ZaNID4uz8WsIRq8
	EXip5/Wwe37mXVjuu8M1HbIf1tpe04TdOX0EMzMSc7F2a2tmAuyO8x6PBq72EgGdVp426xMWeP3
	KgFT0M30qlJzjHVGL88NJo0XZzYvdOnI2R8OM7UWcwCSmuMzN7P7oIPFrDv/Bh2ea6WrcrDGeVi
	yfluxUWIIwzmIRNyvFHAksVJZsyhPRvArNkifAXvDc9lkiUHckj1Qf9L7Q4MUUJxl2c8oG6M36Y
	61KaJ26OB7QNkCwty+zAs4rvSufEgrd5wv4tZmHujxPsCYIy5QRq8GK5h5yIRbA421TQhBsDWNa
	CHNeiSYsvkLyUSVctKtCB9R5VizKdC4qRRNJQ1FJ1VhF9x5UDChIHw9vNf+7WSn6vjTWxICmrKP
	ykHs/ejoX2RR/wGWxXY0JR8Lcu24ImYrYFC6OA6A5iyk9jWXi+WV180bs0Ul6iow4sFN2Qz9Xtr
	qkTYww7D4tJdNSqJZGCgXZHazYxY/iEfR3E5vQBZBMwQE1MUVoC6btuAqYm9I6MxpUXfCRNB3Nc
	4nJ3oVCvC9KfHrcER04=
X-Received: by 2002:a17:907:3e1f:b0:c42:82ac:b6a9 with SMTP id a640c23a62f3a-c4ca7b411f4mr624706166b.29.1793551355786;
        Sun, 01 Nov 2026 08:42:35 -0800 (PST)
Received: from Desktop (p54aff88b.dip0.t-ipconnect.de. [84.175.248.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f37esm296622966b.33.2026.11.01.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:42:35 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
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
Subject: [PATCH net v4 2/4] net: gso: count the inner UDP header of encapsulated UDP GSO packets
Date: Sun,  1 Nov 2026 17:42:30 +0100
Message-ID: <7b6a12fbe0853f7faf2987610e25957d2017bd54.1792838740.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792838740.git.julius@bairaktaris.de>
References: <cover.1792838740.git.julius@bairaktaris.de>
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

skb_gso_transport_seglen() adds the inner TCP header length for an
encapsulated GSO packet, but not the inner UDP header for
SKB_GSO_UDP_L4, whose gso_size covers the payload only. Every segment
of a UDP GSO packet in a UDP tunnel, built by UDP GRO behind a tunnel
socket or sent with UDP_SEGMENT over VXLAN, is counted 8 bytes short.
ip_forward() and ip_finish_output_gso() then let DF segments that
exceed the MTU by up to 8 bytes leave unfragmented.

Add the inner UDP header as the unencapsulated branch does.

Fixes: ee80d1ebe5ba ("udp: add udp gso")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/core/gso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/gso.c b/net/core/gso.c
index b5bd269e56e4e..eb95c9d2819b1 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -156,6 +156,8 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
 
 		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
 			thlen += inner_tcp_hdrlen(skb);
+		else if (shinfo->gso_type & SKB_GSO_UDP_L4)
+			thlen += sizeof(struct udphdr);
 	} else if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		thlen = tcp_hdrlen(skb);
 	} else if (unlikely(skb_is_gso_sctp(skb))) {
-- 
2.53.0

