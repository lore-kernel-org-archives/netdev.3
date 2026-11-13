Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614339;
	b=B4g/jHJETkYWNCGM4URtME/UyFWWX2Q4FLRTBR9wdz8LUVI+8d4jGnGpq6HU0O0PYmEf
	 EoJ0PT2JdypKID/6tEqjWhc8jf5zZRNR6nGEHi+Vqi2xYheu9gGvRz/Wg5+x1nAnWPRM9
	 wBZQrT525UhJ8xr0tRWo0Uv8ybpn1G0ojJxRMKpsDQqMWDqlpqo0RTn3gnWdq70M3QgFS
	 D/6R0sGZuw+df6P+mcjdVL1cmz1/kWgY/+C79MaORc0WQsffc3890mi51cWhvauAL8u+y
	 uHqnybEGT7Oxx5xMNjLU4vDV1F5LQKgM+MmOW6QIr9mJ+IDgPVVRnbMEcOQcj1Fm59w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=P94FGP68ZZgSuMQ+raENon5xMjnwilC1ilibSCmAWWY=;
	b=R1y0kylproXlV284Jo6Z8JXqr4xBCsYFOE36hV9d91hNUENv6MrvqHj/yngNDNsQnKa0
	 YQl5qJXmB+TDQ7PQAlJbj6uEOlS3Sf6mnYSh69qUw51DLuG0KDuQDD1zmQNBwVZ2Z2nNM
	 eLfd2KCXbnfoSwRCauTjhTT1xEFpY4aZghVDp10YgkVjKRS/A/zzA9DScI/URAYIwQLDn
	 XsmO1PSroB7tyeROAM0D3OYWO2gxVKhnbgi0pWJErAYYcEkSoml4ZbP6Me/XyFEjAnM55
	 IdMELEf98grrvi43961HGYIDi2iDInN8wgvoDvBmwsbt+St5/E7IgylJLywHHmtVgyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDCi725j;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C26606A89D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C26606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDCi725j
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso251221466b.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614335; x=1795219135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P94FGP68ZZgSuMQ+raENon5xMjnwilC1ilibSCmAWWY=;
        b=QDCi725jAY8cUue0RnUbX3KnWcAY3EZb1Nom1G9NjTRENmxjOL8Oomd7F8M2P/T8jN
         KoP+vT5zGC8VZJSHeiTdB3gK4rxTHih+R9D947GTbBXkZnFzUnfjWrDZWQVz+ZHStQH3
         UCQnyGpFWRZpWiW+GBkrHzF/M7WdDyQirkObeQJR5ekS7ZwjMz8qi/N21xe6Se6hGHl5
         X0NyVtTPaXTv9DL+Uh1go1EezC04K/AdJjGVp6Vmt4M6ghskrEx/gMJyTJotVxhf9Oey
         AZx5H1CfA9X0KJzivbSR7UH6PO92f2y/y9VArCotuWL1Gm50gA2RBWaqJrjeC6+IwOqk
         h/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614335; x=1795219135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P94FGP68ZZgSuMQ+raENon5xMjnwilC1ilibSCmAWWY=;
        b=C2HdYjUndL1YBM1XqV7NvXP7hh9OwyuBxjJx0pGZ9G7yUTV0oaX2JRDeuyyZzvSNPx
         zsI4hXpvyquXC8OF6CiGLq6du+CEMbB3JAh1ibt6w3qTSn48P7S36T1yeFJC5cMCoLuD
         e0XBuNPRcHsEHrfp0YbHpPKGEPOFBmr1fQUAAPu93WbyM3D4uMDmiF9iMFebDbHdpO/9
         FKBElOTCZKagtbxA5sItx+oZhYisASOTGh152EDF3uyREJTrsywPLoHmB1hrZXkeBiSV
         ZnOWWsea6iSApbG3aeIPucNhJpbQaBV+41X8sCuvzlQFTaytrhuzBYYApA4t0CSih9qO
         v6og==
X-Gm-Message-State: APuU4Z9nBGW9Qd1TbSIYKhiecDOCslb7FWz78bmyYXRBz8Tb09iUqkG5
	JxqTk1oHnDUmCheRjf3/U1zLMXbi9sbXW+mUX3O5eaLKJhM2yYLz5HUs4gqmd7Jd
X-Gm-Gg: AYBFou13PFnSr9b97z61z2JOsVukytGTNQw0plDMmBORDUXlbZza2830YEz3RvQFBnw
	XKa8KReTXs5JXo2lfS77d9H18uslDn0p7UircmTIp6QXL4+m4L4NLZsOMwiY9Q2gwM01Qv3vByr
	AJJzJyqivS2Gq0mtk43kguEuuu0BNoRs1YZbBfy1NUpcsKPmLLf4rUIj+r/Q13eWYCZRtkH+g5e
	uua/sOZEzvWLlZ9C6D9DMMwRnSPIcvqeXa5lI81WcxDC9P57HJ9NO3PYuEQtYt20rSNAcLuWo6z
	0/YvD/UyJIzlVs6LBAjfgwNCp9Jljs1URgAXvFO6V1N4CvfoaL/KalNRS1DgSpC1Oj4Fdu9ez+n
	doP28bT3G1nJIo/5Med1oeIVOjZ1xiXpWkQ8CEAbbVeor+lCGn+YGk7uLyY5+B7yyyzH4q64kBR
	zhDemwN7kgeGLokN505rAZkgFAF0j27b3FY/N3WkvLHv/NsBYQMVnhylhXVQkNOKOE4UUAghXeq
	bavtEwo5ATtdi1WLMfJDxfaMbG8w7NUQcJN71hogB3oNmYcA4mKWvxxSRpJ3oDqb6rFYLQEQvko
	YcKTqgiHJRRCIse7KcXpRj1uy+sjwtEuA5W5eyAH
X-Received: by 2002:a17:906:4fc5:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c509643c050mr381566766b.32.1794614335551;
        Fri, 13 Nov 2026 15:58:55 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:55 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/7] net: bcm4908_enet: TX ring and DMA fixes
Date: Sat, 14 Nov 2026 00:58:40 +0100
Message-ID: <20261113235847.517308-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
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

These fix the BCM4908 Ethernet driver. Patch 1 fixes a TX stall seen
on a TP-Link Archer AX6000 under sustained load. Patches 2 to 7 come
from reading the code and from review, and have no reproducer.

Tested on an Archer AX6000 with OpenWrt and Linux 6.18.55, whose driver
differs from net only in one tree-wide change, with the LAN going
through this driver: TX and RX at line rate (941 Mbit/s TCP), and four
ifdown/ifup cycles of the conduit while it was sending. I ran the same
again, plus a UDP stream at 1 Gbit/s (944 Mbit/s received), with the TX
ring shrunk to 16 descriptors for the test, so that the queue was
stopped and woken over and over (about a million qdisc requeues in a
minute, with the ring full or nearly full in a third of the one-second
samples). No stall, no errors in the counters, no DMA timeout warnings.

Sashiko's review of v2 also pointed at older problems that this series
doesn't fix: open() ignores a failure to fill the RX ring, and fills
it with napi_alloc_frag() from process context; a failed RX refill
loses the old buffer; and the driver does not work without its
optional TX interrupt. I'll send fixes for those after this series.
It also found that a TX completion reported before start_xmit()
publishes write_idx can be missed; patch 7 narrows that window, and
I'll look into closing it.

Changes in v3:
- patch 3: leave the TX ring empty after freeing it, so that a failed
  open() cannot lead to the same skbs being freed again; wait for the
  TX channel with read_poll_timeout(), as a 2 ms deadline in jiffies
  can expire after one poll; leave the skbs alone if the channel does
  not stop (Sashiko)
- new patch 7: order the TX ring index accesses between start_xmit()
  and poll_tx(), and publish write_idx before the DMA kick (Sashiko)
- add Florian's Reviewed-by to patches 1, 2 and 4 to 6, not to patch 3,
  which changed

Changes in v2:
- patch 1: stop and wake the queue with the netdev_queues.h helpers,
  also when start_xmit() finds the ring full on entry; the changelog
  also names the slot that poll_tx() completed without a frame
- patch 3: wait for the TX DMA channel to stop before freeing its
  buffers; free only between read_idx and write_idx instead of
  clearing slot->skb in poll_tx(); drop the OWN check that could stop
  the queue for good; fix the RX timeout warning; the changelog
  describes leaks and stale frames, not a use-after-free
- patch 6: the comment and changelog no longer say where the DMA waits
- patches 1 and 2: more exact changelogs (the measured rate and what
  stopped; what driver.rst says about NETDEV_TX_BUSY)
- drop v1 patch 7 (RX frames longer than the buffer): its trigger is
  not reachable with the driver's own settings
- wrap lines over 80 columns; author name without the nickname

v2: https://lore.kernel.org/netdev/20261112195051.597102-1-kudzo51@gmail.com/
v1: https://lore.kernel.org/netdev/20261109235700.2586821-1-kudzo51@gmail.com/

Kordian Chmielewski (7):
  net: bcm4908_enet: fix the TX ring wrap
  net: bcm4908_enet: drop a TX frame whose DMA mapping failed
  net: bcm4908_enet: release the TX ring on stop
  net: bcm4908_enet: unmap the buffer of a dropped RX frame
  net: bcm4908_enet: unmap RX buffers on stop with their mapped size
  net: bcm4908_enet: publish the buffer address before OWN
  net: bcm4908_enet: order the TX ring index accesses

 drivers/net/ethernet/broadcom/bcm4908_enet.c | 143 ++++++++++++++-----
 1 file changed, 107 insertions(+), 36 deletions(-)


base-commit: 86706ffa990ecd46a4326f8eecbccbbd60a6cb8d
-- 
2.56.1

