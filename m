Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352397;
	b=Tj5XfDsYvRVYfoKDJSm3mSG27jH7c6bl4pwovo6CZAYiNQk95vYr7RoZ/V3RHxWUaY2E
	 5zWXaIBeFdngQ/lrZYELXkMEpuX/GgzSI9uaJRrIvnBd/0/psr9Cx1dN6bgnwnCcQTiGA
	 UeIkHWnY/YTAx7nCgbb7yGDsYbJ+l5eODA5dZ25//fhsnwOSK3GUToSSH7aJMtF6XbbHL
	 MonFZy41xckK9mQK89ZFJ12TR5pgj1W7hU5Q7hXQY7pZcFwUg3/ZyvJyPTtrIeNSe+HlL
	 Hzk7DF3J3ZjJIVvEF9DkMLJQd0XvIkRdLh9wh4DwmVCaTA1kJgDwJ3ZCRbLuHPQ4jVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KsKueNaLCcMcO8fOomY84U8+zo1sTWNNmG5cOs+hZOY=;
	b=e0zOrWpLY2cNeeay0x9XEA9t0JJQikJ15JHMBs7c2QPNxnzawJxotLZ7JQDUTUzGlvi3
	 7ULiLexRBXMwWkTlMOVnKTHSqMrWlNDUjaaBECuvvV4aMh2tdFfHLqUvhdLyQ4r6Tc/mv
	 WRdXeeDeegDfWqQ+XVPonEEowmb8xnwQjBK7qsFwomJJdFhV4oW7wGsla5IKGFmdoh/EB
	 3Bb7bdeIRulOuevd69CUrQWfQrtaGIBSH7ra21JcmYnGkmv5MmbyhBxTG6ay0e343guJw
	 TGcrtA+m3KkJhNWXZsZo6O7AN8lIdUA5bDZyLw3fBkXDPA25bvhzRaaB9Ep5W9wJ1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FK+2VQx1;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E6606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FK+2VQx1
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1542010a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352396; x=1794957196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsKueNaLCcMcO8fOomY84U8+zo1sTWNNmG5cOs+hZOY=;
        b=FK+2VQx1Rck3gtirbWEklE18mufWggWNqt0gkFomavHdTH2lDK6wGCOKuhYvkSs168
         JWb6GCiCQekKWDzmzJP+23oUZfYNKz3VcLEI4aXD8857RgT1zdkM6HJ2yD1+K3jat6kp
         FFqOGlsxx5PC4PG43cMC/K2o1FVC9ueUrziRxN8vlsAonFweSnZnQGhmMTv4OLKcRcEK
         XzPBZyn6/fVGad47aJPMDHw+fi5A6trGw75sM64+F5ch/tXwpCHR6ieTrqkkU7lhfP1o
         L8zcig4Fd9NOO8DOsX5+ReXw9f9YHDYolbqs27VMYF4U1J4wNt2kpYyv0yuGdHKgf/gB
         aBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352396; x=1794957196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsKueNaLCcMcO8fOomY84U8+zo1sTWNNmG5cOs+hZOY=;
        b=tcTAN4Ji772+RWR3bazf3VPPZSyDk1QxnDN86FU9HEiffT7JtbM9vd2yPPXSyliJgO
         VqLhI+jelWK2jPvJ2C6T7V/L5j64LyTkonE1aY9/K1LugoGYVhguf2Pz20RZWLmdfs24
         tty3LYwnDjc2pfM6/44i7Tlw9/0N29NL+rhQP+jMMRjbEO7lCqOhds3PVpatwEEnsS8x
         ChrWtOtQ1gnSCOye2/zJbsukLOTH6sfl4Ot94M8VU0/nJViRSoiDX7hofiDKyLVgrnp4
         20YpbjtWl8PzCIg4+jhTgkk8IUHYVKIvSE/B+cRkp4NpHdf/uCVy4nsUPFSWjA0Y9C5w
         By4Q==
X-Gm-Message-State: APuU4Z9jQ3GGqtcfWJ61StdczRE7W/gGIVleHMk/GF9OGnpSdAA2qoRR
	2YxcDVhnuLJQ66CTBLW/cDOey06ynjxbmmfkguZzNHYPvpSxYw7Tb9iXKZ9t/J7XDZVZ3pg1R0y
	Pye8G
X-Gm-Gg: AYBFou1+wwB+QAshV9CAWfZ5qKaPk0efwuTOUWdwFBrcUP3FHyI1X/BVXM+xWJHl7OR
	XSNXqRDuj0EckuEdzpO+SD8tU0DNKfPiux8V/LeygtrF4dY0eH4TWbzXjGI+PE9zyY0pL5AKhlA
	kWSrvmm5dqPtMVxhhc9QfQdvqU681v75NefWx2XSIVSuY2E0zZWjYIlbxhlPiJbMZyKS0m8+ND4
	MWGcDJX+co7WmMeG3+03mCA3LbcWvJQlho8BYmzrmTfQ33igDdl+MSvqXm7j/AkwMZQgyIjfEfd
	MTolu/R/njjCNMe1cNHbXSS8DSlwPC7d1gvZmrEZ+5Sb5/H1KggxmhAByu20isDQOgNyfAuhvPD
	X1IzR7GpyFeKEhoS59NQ+AtoNy3jJ8NzTHv33Dm8zqIMoAX1QxPoFbCMd7zrqYI7NwqfnmUC70M
	6G3uuzvGYq2yR27hB2lFFg6s5JQS4I6i1oENKalor+/YItwpzoQjN0304+czv749n+z/FLfYkDm
	LDChbGvdtEiNDn3LQ9U90r7kwaOC4wXWb7g5csvSxMoTW2uV62YYMNbk09YVavWv0A68PnM+ff0
	I8DfTac8knn3bp8oEqfmM0QAKqJJHrL47XQpRXh7kg==
X-Received: by 2002:a17:90a:b107:b0:3b1:83aa:5b53 with SMTP id 98e67ed59e1d1-3b183aa5ed3mr229122a91.58.1794352396089;
        Tue, 10 Nov 2026 15:13:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17da51f80sm1524296a91.1.2026.11.10.15.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:15 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@kernel.org>,
	linux-rdma@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/5] mlx4: cleanup and doorbell fix
Date: Tue, 10 Nov 2026 15:12:54 -0800
Message-ID: <20261110231304.1859217-1-joe@dama.to>
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

Greetings:

I am working on adding support for SW USO to mlx4 and the branch I have with
those changes locally is becoming a bit long, so I thought I'd try to break it
up to make it easier to review and merge by first sending this prep series.

FWIW: I plan to include more detailed data in my SW USO series, but I'm
working on SW USO because it significantly improves performance on hosts with
an IOMMU and an mlx4 NIC. I have a lot of hosts like that in production that
would benefit.

Anyway, back to this series.

Patches 1-3 factor common code out into helpers which currently have only 1
call site each, but I will be calling these helpers in the SW USO code I plan
to submit next.

Patch 4 and 5 add code to track when a doorbell is deferred so that the it can
be written in the drop path. This is technically a bug fix (and I need this
to avoid the same type of bug in SW USO), but since I have never seen this bug
occur in reality I am sending to net-next.

Thanks,
Joe

Joe Damato (5):
  net/mlx4: factor VLAN parsing into mlx4_en_prep_vlan()
  net/mlx4: factor csum flags into mlx4_en_csum_flags()
  net/mlx4: factor HW loopback DMAC into mlx4_en_set_loopback_dmac()
  net/mlx4: track whether a TX doorbell is pending
  net/mlx4: flush pending doorbell when dropping a TX skb

 drivers/net/ethernet/mellanox/mlx4/en_tx.c   | 95 +++++++++++++-------
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 65 insertions(+), 31 deletions(-)


base-commit: 97ced2c090bfc2156db31fca9f52cf253e4bc186
-- 
2.53.0-Meta

