Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764104;
	b=oQXNCbEAQX7D/l4LAOOtjXcoleRiczgHDcZhXjAvYBHA0/L6hbnKXETTATrJOre3tUF2
	 8iaExSLTDZrjfWUiGkN8DhCXI5Mr6+/CvDAJNuZdtH4aVCP+FEDsxmsRIz7gpS4vt7YkB
	 bsEUy9meUm2yEgFiPzgEnyrXjwvid3Be9ZKvlbC+ei3VXphym83VoFTX+pgqyAFef1Ma4
	 FQa933i8miot1rcnvxiU5RKBIz8XVPctWDbyDzq3d93AuQp4EGPtI58MmFSxLUrs1TsGp
	 GQgptoqL2p5nTU3KDvOKioBXo9JxDwaaMX/+K3W39j4mRKcuORZJU3IOXhz2/73POIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
	b=owdpNcHvzTdgP875zHru6smyY1WjO9MjVD2+sOJQc0elRAFLGqbUghF1IFLTvqEMh9yR
	 mv+vEiMj8+dB1WyqNha2je2pnhcA+4OgqQ0snTzT0RjYxEcr/2pT8PVSO27ysV7Xoffj8
	 s1UjJvRfT85TLhj3H3rj+famCihh3r7QLNqZYqf3iiWHuhT+wSGGDz4/OuO1gaU34VAdC
	 U/EaZJcJ25XNrQVfNjxUFUh9pB/uxoWzKebbqrVvgG7wpsnh69j82m64o5RFuAr9d4vOr
	 dDabZmAStgoqEYlVcrTJtTn4zp31Dk4iC/XcNS7NwhMwIo8p1Z2mc/6Un4VjjIutNUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1F606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 03:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A1F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3ae7c6a2d07so111594a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 19:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764103; x=1794368903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=VgUuajXE3fSQNacAxk3tEj3LnGJEDe8eO4Xmi74v6UY6fHz6tM3wa7S4tUAUWkHaBM
         59ho7QGCRoW/e1+9Kfw/D3fuzzPaViTo9tlaMuoP7axIzYO2nEO17qpALd9cEOTLymK6
         UYFvxKM6X9SUGVxJowCEQrtOBdJW/HWvUoAZoEvn5ATujp/55l/zYq78izLTyuuLUSpe
         wSrm7vgT2wQcq1AB79XHUT0+BU5jNvnwTpab77YKTc5ImYJFdywHCga0pB49jTwNEAOn
         YENRyBabanJlUxoJqV4t6/vIXVCXdMjYrbJ26/qhFsUqDm1o4E5sTJf1sc34JPYx5bsJ
         /9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764103; x=1794368903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=B7iJYg3yHxOK0dL3urhWCk/JDdzAC9d/C51BeFbFLDhJjK9yeYANrRqNj+8alEChne
         Bi0AcpMNVo0Dyvp6lKPODssMTimNhTclxC9nDpPdjlgfkbPbWonHjcx86ypzp24xblTh
         iyollNvcqz2Yj86aL4QSKkvK4FWgT+Iq49Rsr9X3HwKd74DnlJdePMLD5LVufoeWnTOV
         2kLDn0keK2tcTw4nW7HipD7w02Pg2G83XvBdngsg98c375Q9zCyymkAOecSxsyhI+X7/
         uTIhSFx5FN7oM8HhPdQapH41AELU4DTqBEFDkmdkieUP8kaOLjixJQBVWeDSbUJBYv/5
         jgow==
X-Gm-Message-State: APuU4Z+5S78lbNNIsxRaJZ2dBU2j/eeTMGjH9beMp4cFttoSxRUnYbAs
	eU0V2aZ/tBRhl0kEAwUwFx82eotbxK9xvZHFsVk4BlpWpmu1aCBTcEFFKCyqs79Aktjq1A==
X-Gm-Gg: AYBFou1+dtMM+ND1MRxjPzF8PWnm29xTS2RX0VOnucMwZOpXpdGrDvVQiFJ5UdEeHcL
	a/qkzTb+yEeljGStMvEFR3czsiDIEkke5ef2QL5F4t3HYAYpAf6HIdyCl2UKqPGraMC7jcxd394
	2uFhKROqoptb0PYhDZ3TLd2yZk7ENZ7pUM5g8NwFe52c5VSVKcXMkDpKUgxWRhtmQC466A989bX
	dxwbWukIYSOQiyZhCnvnEYNMQtc5W02MK6PHNdWeit7YDHnk27R224xS8POZRicltbPTwFuCXOt
	JKCgwVyrUW1P6tkC9XlFgIIRkLKJCtNdXg+31mS8M+3useV9pDnWU5D1uqh19uerAY8KAScLlIB
	hpHUPJkDDjKxjhxRSgUfb2bgLMbcU7eIT6dvoNZ5aMd9rT+bwpuhJydGlFFU54ZpOAPZEmPyhcY
	eFkQezWiBKVvIYyjYLOA9ZV/RWbMS7TKcwny5WBrZed8wB4Ukabsg2JcWeOqeMZ9qsQUKeINS8S
	g9bG1Vy43z1dDtQArjRH5cbjM8gOA8L3yOBw83XoAoMCV1L6WFTYJHbldmr9UHDh/ZpREScd2wB
	RM1mLVE1aR9UKhmnEkgOP+OG0ZEil4OcGcwHM0Hc6QXY+6d0IjJtiET70AkNsk0iQnLW
X-Received: by 2002:a17:90a:ec90:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3ae89831a14mr12516860a91.49.1793764103123;
        Tue, 03 Nov 2026 19:48:23 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:22 -0800 (PST)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v5 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed,  4 Nov 2026 11:48:07 +0800
Message-Id: <20261104034809.24545-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is v5 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor
was correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

The updated selftest passes in a local QEMU run.

v5:
- remove the unnecessary else branch after the multi-buffer check
- carry all review tags received on v3 and v4

v4: https://lore.kernel.org/all/20261030023248.78802-1-testwrzwrz@gmail.com/
v3: https://lore.kernel.org/all/20261028025026.11401-1-testwrzwrz@gmail.com/
v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 2 files changed, 107 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)

