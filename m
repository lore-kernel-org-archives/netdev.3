Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551355;
	b=Pe/P8uqJAYG1liGSjg4LW3x1BeqnNZpp3kY7JFvlgT9ejSsTeLhFamBn9jHLTdH7XX0y
	 6aUAJEgQlz/tDhvK60EfxfVxDdJ6nTzGwvdg7Jz1AKlXGyiiyvnegKfqwlTOTDHaRZRSZ
	 nwZe4n28pUQ0+efO3K/lDDwJf/vVDWCyHtLgO3zDeHhDZeuD5UD0BKt5IHjnnjdkbK2Zq
	 ECIdFTULLQD6I5u6+KUCEA1AJXIbXo4aSVubwMZcBN3ske+6y+A3TLf9539bGST+b/R0O
	 0h4/g+SZlSLcaZ8oKFVPQCZLkWH7fYUqO5qPpVxW+3ApKai/BOWYZPRx3F9QnizDGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+GJ4llxO6J68sBfyk15mNFM6CNay8BlVU8uhm4hMFEA=;
	b=Bdo6HnuMVQBfgfQgDEhPNY0AP5epowlg/VkwDbTrCWP/592mAPKATdXE+dJi7ybeQTzV
	 btgNmW6b6YpfTryzON3HREQunQ3vMTpgW/g4WJpNnJChwemCRow+MS76uSWFXrs9EZwdH
	 8Wqe4fDU2gtppkXRoLqDqhT7ceWzGV8//gg0sQBxACuyTFMhfd6kMKcCM+OOp9Uf9b1sm
	 Y05EfRZq7eshTMDFDjxv8RWRDhh/qQhC13wZrW1TF1bYJt1n3bQZ7H2CwvQLyYfISHxXu
	 fMTqba9Rp4D/D/OJKKJfxEbT6U6lbq6je/kO/P2MoSCXYGfLORLmvXS5yqSx/Y1k4JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=vooLOtcl;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C3606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324C3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=vooLOtcl
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso267055866b.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551353; x=1794156153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+GJ4llxO6J68sBfyk15mNFM6CNay8BlVU8uhm4hMFEA=;
        b=vooLOtcl/MroA0vTqzDzgdI0Ti/cJtZJvuLNrt+rtfgph9jLeZcjxZM2SsY2aT4ztK
         7Lpk3X78Ng/R5jpue5sDUvfagpGmhqEZBN6BDlcySL8f3yDobuE89dMtHFJOv7n55EHf
         GVGzuElUpywUwIaTo3bJZ98SEZ2azZOMCmmJ0dKdHYRaOvRFcbRgLDnVieWY1AcatgFc
         tGDb8FjDP0LkwxwKdbJ0V/nxJW4kFXZ8xatEG82feCCvjJmWfzh+VoXc59h7azwJ4iH2
         7TG58gOlsyUGcQYssagb2OtUwNsw3f1uQChgwJSuFfZ4MCsJxroXdGCXqgPBYYCkuv7u
         dZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551353; x=1794156153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GJ4llxO6J68sBfyk15mNFM6CNay8BlVU8uhm4hMFEA=;
        b=HSLhSKmU/ZSFZx/gj+P9PeOBwU5xBDcN1b9HSYmzAIAAZJbGPcRGiKTtWH6xOqHWcP
         9HRhRuW1mrbsh4oVvAxkJw3thaJyamzu60dov2ueAUvvRp1vJlgOXKIxdM8H+fkdJADC
         uFpsQT8Vu3wofDyrKyyqdJYHEA8zjdZEl0VtL7y0wjbMV9/IFbFM5lutX1JdZJUNhlnY
         NXEb3XXAq6XD2ka4+vBTys6JTrNIbds8b1waqhqGEgMDDcOppGH7n0/Vmu27mI9URwWb
         vf5OeCbO8ZC/PaEy5/OCtQfS9bdeol18DpnGWHSS5UUgQqyobp4scLnqqfM4KS9GwXKC
         2Qvg==
X-Gm-Message-State: AFq9FYLEUDB6n2trpFt8D0MRUMTn66YBaR/YiQqEzzJw6QF8wO+07ba7
	Ep4QLNTAL3ZWtA/23IugSYJIWZkSrdvVhd5iKmU0n6XcXjoCNs799N0S5pfjJ2D/5EvoaGiUyUk
	XMqxZ8yMp
X-Gm-Gg: AYBFou2aBUL6aXDyhJ7Czzov/MFGPtXrNUgWd2MasnEsu9I7qkAysqFLPHwPeBh3Jd/
	+UiiqGRlxd0RYrLatgqF4dJbNUC5N1CCQL3M3rlcunf0iP4eLF3zvzpXcmbyfFMISl5GRpQLzul
	kQwHDvkZV1zSke2KjtE/+2rpJUEhM1mUHB5RpITkQIdtCkOeOvrN6kluxQyZZPl4+kVa6tXrxPr
	7xopLlrwJ7Cfh1rUZ5axqpYxvMtxNkb1le068IbiEvKWeh7h5E8wn9fuKBZC1n2gQnMoQofQ/eH
	er9xHLRTTKfdla2YMZmyuAQyryfFomFoVP6iSztkCvL8gzW4Fmn0zIE+yMQNp8L4USuCX1SzQ/i
	Bq9k4C4U6tTT62eEZdNQZBe9qnm8LhChT4o+zhHsHCj30dvVX3I1PThkov1tnK9Wl76i/2YMx5J
	OizeWJSa+BxuxxPzvLPy7wJm1CQWDEicHcbpho37xQ9XWb/5dOOr6VFmk2qHKrCALQYiMnaNgwF
	H3DaV1tGRRgc2xKNQPeKpsH+1uloZm9ouRIdOyvXyZ6a67dYoyMrSCc3uBxAw5Gc1Su2vKBqtBm
	Uw2OkNbl3xganajWeeEret0Sm3MVrZrbN0+4fPPRKB8sVkEibmZRemnPfdE8ixI2jVmkSs1yDZh
	QZ1rEXNi2NzT5tyJGpEicU+jhUXvuGfR82OTleq4LPmlDTgpwQXwh2hoMYTfGs5cvaSroq/93jt
	sOl0LUXiEnbEBIsbbAHKBv/0qJ+JIsXR4VLAYQUdvPQYmGfQ6Yx3oEgksYJeljga8zDLMnqm46X
	zbShacTh9pk4RN2h9P4mRkI6RWa5TUsuckv5XMLzNyjbCTyPlb45qSUoHL1jG06TMFrBHtDSkv/
	CCnFuE5YOXOKfvnPzrVBnq4sbw8WQPb4ffZiBNw/
X-Received: by 2002:a17:907:160f:b0:c49:a539:aa45 with SMTP id a640c23a62f3a-c4ca7ac0de2mr634290566b.42.1793551353378;
        Sun, 01 Nov 2026 08:42:33 -0800 (PST)
Received: from Desktop (p54aff88b.dip0.t-ipconnect.de. [84.175.248.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f37esm296622966b.33.2026.11.01.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:42:32 -0800 (PST)
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
Subject: [PATCH net v4 0/4] ipmr: forward GSO multicast packets
Date: Sun,  1 Nov 2026 17:42:28 +0100
Message-ID: <cover.1792838740.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

With fraglist GRO or UDP GRO forwarding on, a routed IPv4 multicast
stream arrives as GSO packets. ipmr_prepare_xmit() drops every DF
aggregate larger than the MTU, and ip_encap() sets no tunnel GSO state,
so a GSO packet sent to a VIFF_TUNNEL vif is dropped during
segmentation. With that state set, a fraglist aggregate reaches
skb_segment_list() with tunnel headers, which can write before the head
of a frag_list member; this also happens today when such a packet is
routed into a tunnel device. Checking the segment length instead of
skb->len relies on skb_gso_transport_seglen(), which counts the inner
UDP header of an encapsulated UDP GSO packet 8 bytes short.

Patch 1 makes room for the tunnel headers in skb_segment_list().
Patch 2 counts the inner UDP header of encapsulated UDP GSO packets.
Patch 3 sets up IPXIP4 GSO state, outer IP IDs and length in ip_encap().
Patch 4 lets DF GSO packets pass when their segments fit the MTU.

Tested in QEMU (KASAN) on veth, one run per arm: an MFC entry to a plain
vif and a tunnel vif, 40 x 1316-byte datagrams per GSO packet, 4000
datagrams per arm, UDP_SEGMENT, fraglist GRO and UDP GRO forwarding, DF
set and clear, software and device segmentation on egress:
- net (7076f684d513): every DF aggregate dropped on both vifs (FragFails
  2 per aggregate), and with software segmentation nothing arrives over
  the tunnel vif; fraglist GRO routed into VXLAN reports a KASAN
  slab-out-of-bounds write in skb_segment_list(), then panics.
- this series, all 12 arms: 4000 of 4000 datagrams on the plain vif,
  FragFails 0; on the tunnel vif 4000 of 4000 IPIP packets with unique
  outer IDs with software segmentation, and the 100 GSO packets of 52688
  bytes whole with device segmentation.
- VXLAN with DF, 1404-byte outer segments, route MTU 1400: net and this
  series without patch 2 forward all 1000 segments at 1404 bytes through
  ip_forward(), and the series without patch 2 also through the MFC
  entry; with patch 2 none leave and FragFails counts them.
- a GRE GSO packet (skb->encapsulation set) multicast-routed to both
  vifs: all 1000 segments on the plain vif, none on the tunnel vif.
- fraglist GRO routed into VXLAN and IPIP with software segmentation:
  every segment reaches the peer, no KASAN report.

Changes in v4:
- Add patch 2 (Sashiko).
- Patch 3: drop GSO packets that are already encapsulated, and set the
  outer length with iph_set_totlen() (Sashiko).
- Drop v3 patch 2 (TCP fixed-ID flag on encapsulation): multicast
  routing does not carry TCP, and the flag also needs the decap and
  GRE/UDP segmentation paths, which go to a separate series (Sashiko).
- Rebase onto net.
- v3: https://lore.kernel.org/netdev/cover.1792293419.git.julius@bairaktaris.de/

Changes in v3:
- Patch 1: name the VXLAN out-of-bounds write (Sashiko).
- Add patch 2 (Sashiko).
- Patch 3: reserve one outer IP ID per segment (Sashiko).
- v2: https://lore.kernel.org/netdev/20261011162957.1328474-1-julius@bairaktaris.de/

Changes in v2:
- Add patches 1 and 3; v1 let DF GSO packets reach ip_encap() on tunnel
  vifs, where they were dropped during segmentation (Sashiko).
- Keep the additive MTU comparison and check mtu > encap before
  subtracting, so a route MTU below 20 cannot wrap (Sashiko).
- v1: https://lore.kernel.org/netdev/20261010131842.2157365-1-julius@bairaktaris.de/

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (4):
  net: make room for the tunnel header in skb_segment_list()
  net: gso: count the inner UDP header of encapsulated UDP GSO packets
  ipmr: set up GSO state for tunnel vifs
  ipmr: do not drop GSO packets that fit the MTU after segmentation

 net/core/gso.c    |  2 ++
 net/core/skbuff.c |  4 ++++
 net/ipv4/ipmr.c   | 29 ++++++++++++++++++++++-------
 3 files changed, 28 insertions(+), 7 deletions(-)


base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.53.0

