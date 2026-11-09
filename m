Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268631;
	b=aW9i940nCd1t69aaImnM/xPy5N7+WpTtdIxDNJGvxgec503yRUGB6gCTPiDAlf37JL8O
	 tA9DCj5FHuigYeGyPMCD9o7SOJuZtSoD9Qnbb23AUIUCzS96r0kO6KdMB+aozwBT5ad6R
	 422y5heDSslnKGY0nlgFuiv1KdPTbjjYDp1c4jbSN/l5KTdAb6Os0SI4UpdGWr+7um6Nz
	 guDfVg7ubrRyAlO77UNArZNZGT7JxfBKrO4D3Lbef1t9w9fMzvA6LHd0FOL9IYF8iCjMj
	 aFDh2HlGNsg7kC/ke7ER0Gbrz2brcuidNrtIIK/D9pCSIUve/BxR0+hVddfbRzx4eGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4QtPx/sfImUb2j3o6tXqSSTPDZ/xP4IpG3PYn+xcfLA=;
	b=UBwzG2LKJt17GWJQ+IqOeP2ICFV2ri878/vlHxcr6Ac/+59akSqabH7+464b2SAqQOKC
	 J6kUqJ29iDDZdURF3BqMWIMKsRahnbSJnkKlNDctcP3hBKEaPgtF8HtB+DUXVt//rH4L3
	 DI+qfuqA6HbvUQeU3a66QtiHwBPNCGsZO/3yunOe4ip6Xp2vcprfWxvo+g9maNUSLxiby
	 wtRFOts5Hu+6u4+gGJ+SCSd9lEu0yN1DzqcXl7pYAhsZLTifeSilJL5c8kgxrgorKmGk2
	 akcd2V/gHt+I0oUIwbLRLEigYO4Qnq5nHc9zJxTB3yXEkvO/svOMUctcTSL16b2zdDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFhS9AND;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0118606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0118606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFhS9AND
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d58c50743so30037566b.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268629; x=1794873429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4QtPx/sfImUb2j3o6tXqSSTPDZ/xP4IpG3PYn+xcfLA=;
        b=sFhS9ANDj67M01mHnqET4gArH+2qoFDKb/2FsFvOS69CgWOuJ+Mti1so4OC8K/JaMt
         UQRfbA6jPzKkvBsOCD8sqR8uRFtD13GZ73yqUKLmSv/RDzXSHnaXXlWit8ArXJ0cNuve
         vX1bWb6UWP2xZd4GfMV2he77fElu+LAUGTpwRtew58D4eO1ui+MPGglA8q1WPNKkDIG9
         4m47kHNDb7Rbn4KH54NM+aBbp5r916ox5JWDL93C0ijLP8YdHAKsmH/csUscRoSxT6W6
         OzLoBfXNxfkjuSZuBazVsVWl5iv0UbzzPF/OR36ZFhFeP2Ks8tNYud/hWPBO578zs4dk
         Qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268629; x=1794873429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QtPx/sfImUb2j3o6tXqSSTPDZ/xP4IpG3PYn+xcfLA=;
        b=tjGThYPVeY8AJzgh1YFNNBZY2Xem6WYA/8OcNQ/513PhGAFaE1rsAi2z4YwBnRZ8ax
         3s5NpehK9pqvKOLU4urClmMwt4ZyEciShTlaRRemiDt7D400tHI3SG4tzDjmtCAyE8pI
         kT0S/SZAnanu0sygXnEQMhUXQQ1dyrURN/yNyj6AuSZ9RL7xHQunl9AUDtK0+Z69rDE5
         91COeOorbGRAxeiqsNeZMjH9oA6+BwiF86+Wf6cQ2KyIYNmzV4zIOEYMKkFcBDnFrufa
         7wohPQoYfcWhUVGB5KSnGOjlz21LcYEIpSZ2wI1jcykzyx4htePJBduP1GteI1fQBN+W
         sUQQ==
X-Gm-Message-State: APuU4Z94ypHK6ZyBXyfDSucs4x3Thab4Hxbd3l6i0Rk9E2UckGFCE5EL
	OuNl2YDgloqc+br7PIdOK7Abdw1xDrniXTIpZaqjwreIVMRmQXo5qFxjBalZPiBz
X-Gm-Gg: AYBFou2TJ4Xh8WBvDupCw0jeiCILQWbPLH/7uliJjC+ISXWsyPlCWjbSt3aYGzGhTMr
	gIMepKf1CQ9Y/sUn7wGCsn4MIUMjiI6ylyX+bzvB8+loYgtjeaR1KWPJUHyI9ERCLdlJdqlzFj/
	IRV22lDsxEVkAW4ZSAfTWtqciVnE8cV03x15Ijc4Q0cjylKSfS0SuxZk2JouSu4HeBKIIx06NIR
	8dAHjnOrA+dxZczdK0lEDxwRZuQMiEmJLnyNpAVhHDogD2O/nM3AZ2ZncoEONbTkpaDjbMwGv2L
	S8RENvRIC/iKEt/kiTFM19e3A+fj7rBZ/S896FaHTYsrVmMzVWZf7Q//yvZGOCWbvanpyk3hJVJ
	9B3m9h4NYURsB2G6yqLHugDuXdepGUmVmuE2YXozddAGYTUHH04faaIJbtFI2cDIQLAxSdgPtpV
	gQTJrx8Xk9Ctc+LP/fUB2r6p2xzdhw0W1mlwkxK+uryuWo59Qc7q5faBdO9tNZ/psAB4RA2f8KU
	cbmZvupQ03Jc/0N7yGH5LbBjHVsIl3zL4D9enqn2rQP1mxYhAAazj1846jtzDvynD7zMexfy21G
	lJ01Nt83nK6QwSHugqX/WlL4gV/PMt3/LxQ4ASRxCacInA/iHJMQKXA=
X-Received: by 2002:a17:907:9694:b0:c46:88ef:2e46 with SMTP id a640c23a62f3a-c504922b5c9mr78004466b.1.1794268629159;
        Mon, 09 Nov 2026 15:57:09 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:08 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/7] net: bcm4908_enet: TX ring and DMA fixes
Date: Tue, 10 Nov 2026 00:56:53 +0100
Message-ID: <20261109235700.2586821-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
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

These fix the BCM4908 Ethernet driver; the bugs were found on a
TP-Link Archer AX6000 running OpenWrt. The first patch is the
important one: the TX ring indexes wrapped at different points, so a
full ring could look empty, and under sustained load the queue stopped
for good with nothing logged.

The others drop a TX frame whose DMA mapping failed instead of
retrying it, free what stop leaves in the TX ring, unmap RX buffers
that were freed while still mapped or unmapped with the wrong size,
order the descriptor writes before OWN, and drop RX frames longer than
the buffer instead of panicking in skb_put().

The last patch guards against something seen only with a non-default
RX burst length; I am fine with it going to net-next instead.

The same changes have run on the 6.12 and 6.18 kernels of two Archer
AX6000 units and an AX11000 since the end of September. Here they are
on top of net; each patch builds with W=1.

Kordian Chmielewski (mlody1212) (7):
  net: bcm4908_enet: fix the TX ring wrap
  net: bcm4908_enet: drop a TX frame whose DMA mapping failed
  net: bcm4908_enet: release the TX ring on stop
  net: bcm4908_enet: unmap the buffer of a dropped RX frame
  net: bcm4908_enet: unmap RX buffers on stop with their mapped size
  net: bcm4908_enet: publish the buffer address before OWN
  net: bcm4908_enet: drop RX frames longer than the buffer

 drivers/net/ethernet/broadcom/bcm4908_enet.c | 106 +++++++++++++++----
 1 file changed, 83 insertions(+), 23 deletions(-)


base-commit: 86706ffa990ecd46a4326f8eecbccbbd60a6cb8d
-- 
2.56.0

