Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68F4D4886
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951756; cv=none; b=lhuGSzj6cWV8PcrvDErVl6c4zfy1/+6oVK/TL4k5U76dLrrMQHuJWtd5arzGyzcF/kOubiJHZbwwpIvIHZHjeaOhjag2VGVJYUH4N5AnwpiP5BvhUZiVzlK3aLSA+U/2kqSfVgbLcwWaNdmk55P9kQ0/6FaLXK1RCHvwzdbc0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951756; c=relaxed/simple;
	bh=sl/5SK0AkE7KgGawmgwiBrMyZ410mcBRygWLmXnAT18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1d046Y+ZnvQFPgCVPHzGAzPT4LDPQyRi5pAAih0vEB2+gzaIq9Fex4gB6BuLSbZLK8pT3NSfZLiPRGslEY9+bDMy9+wEnOVGA40H4o4aktsLtZL8PIjcgx5dRDbkxN7qdrw6b2sV0/x4S2svW/RTZgkoWWW7M01JCImStVKOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=g9sEWNcX; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="g9sEWNcX"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so1365014f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1790951751; x=1791556551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+YxcSkfcoEfck7Zuecwp5VWL5LwdnUB1Sk9JzZnEL8=;
        b=g9sEWNcX6iltrGeEB/iSEXsS/ONz/k2u9AyWOtXa3biN+bzuz4YKAjApdcTMsxVfJk
         KWChsbnahloS34Ofl/sxIoRnuqcdxrNwbpVmiGGICWsieE1dDR7wW1qe6cpM8BpKEX6o
         MsuCwibntLe+TEekbibaI91Y32NAb8dggeAu5MAPxOhD2f4RilGhZvUirOqSFh08g6Sa
         JQ17AdmlrCyg5qpxaRfgLNLuwF0lO8Gb4d4k32Zdb8JZsZneaH3xUUhGMaiivp0JFNSx
         l0Lr+vMURPovHcPi4k1MA9twiSeSpwKlF6ozOQ2PpLlK6kuCTYaDyzjGa7KqxLpmlIbe
         IQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951751; x=1791556551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+YxcSkfcoEfck7Zuecwp5VWL5LwdnUB1Sk9JzZnEL8=;
        b=gmeadpqrIsud6xhO/K4qcLBwBR71FoSba54Kg6AXj03JaXS3SrAs7hx5Yr6hmQ5VVT
         Nkw2xUKMXZnzm+OFCoQUqEUhqCcglLhyCULlyednSKPFsfbwOwM011HptoE8mXjkos+j
         XYW3h/4Ww3IFV3N+PFMsx53ca4AkF+pruXorMQVEffo/kb8pl8lOryVymtDsMcwQSCuI
         Jxf2xqqgoliIBZwZ0rJ55r1+izRT1s/hUN3AImGKdL/oRdWTl+jCUxm30j+ItXdCeSj+
         YJkTGoM39YMYLK1OuDWllyLInlHCunN6am6Cj7cX+4gotu1d+jsVUrASS7Vx2r0ZrG75
         4E1A==
X-Gm-Message-State: AFuF++k9OYUYGNBBannMC6rIHs2ZefZuXcxwcAg/B9OTfTkmnX5CqOWh
	92Cg8qObNILkSTXvTh8FfnAUWpTDRdlyabeQ+Z93g7T/sgfxtBMDECO2ZNxHlbTRqvo2Q+ihacH
	lUhUfLVFuOA==
X-Gm-Gg: AYBFou11ja35xwmMZpgo1dWiK1uG17E3SB1Uf/2N/4/PPMgclEa1ifHrlM/ugui/rbo
	b55Hfa+qCOeXy32Goc9Qbhc2eflqPWyPgNlpmn8G7SqtxyLENVkLdYZAoVBx6izhAZZhUSwNpGw
	rjaqjXh+spIcNrk/qrp4yASkk66oad9bwh+T+Ee8t7N7Pnsu9ZQBYXLgH2PZ3Emov096rmUeCRY
	GmYjygAEyKmNSi01iZi6uPdZAcQBePhhVPhziBMubYPY0vk88MBD5hIN8e93v+ixruhyZ7+brO7
	MLFwOiUfElcfOc+IFwneiTYCX05qzO8XaR4Iml+CpLLj1qfhwy6j6SrBNw4RRGZmnRhRFb2hq/0
	GMRb9XfHP8CQFD6Sf98mxTxkx/lJFFwxE4VVSewO1Voiuyr6VVoEYUrzlleNal9mepSPvTSLC7d
	eQwfr87LQOLP4PRIMREDy/llaMM/lzjulkqOj+8IwqI9U1dEImXt0hCLCVThP4L9Za8oM=
X-Received: by 2002:a05:600c:8717:b0:4a0:2867:d8a9 with SMTP id 5b1f17b1804b1-4a02867da4cmr44371235e9.30.1790951751358;
        Fri, 02 Oct 2026 07:35:51 -0700 (PDT)
Received: from koen-nuc11.. ([2a09:bac0:1000:2ef::4e:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67cbfesm8715315ad.28.2026.10.02.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:35:50 -0700 (PDT)
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
To: netdev@vger.kernel.org
Cc: quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dnlplm@gmail.com,
	linux-kernel@vger.kernel.org,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: [PATCH net-next 0/4] net: rmnet: optimize hot paths to alleviate CPU/memory bottlenecks
Date: Fri,  2 Oct 2026 16:35:25 +0200
Message-ID: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing embedded ARM platforms over a high-speed
private 5G SA network, we observed severe CPU and memory
bottlenecks limiting overall throughput.

Examining the rmnet driver revealed several opportunities
to significantly increase efficiency,
particularly on the RX deaggregation hot path.

This patch series addresses these bottlenecks by optimizing
memory allocations, reducing unnecessary payload copies,
and improving timestamping efficiency.

Test Environment

Hardware: IPQ4019 (Quad ARM Cortex-A7 @ 717MHz), 512MB DDR3, USB 3.0
Modem: Telit FN990A40
OS: OpenWRT-based
Network: Private 5G SA (n78, 50MHz band, 4x4 MIMO, 1Gbps core uplink)

Methodology

Results are based on the average of 10 consecutive speedtests against
a local speedtest server located in the same datacenter.

Performance Results (Download)

Before: ~318 Mbps average (Peak: ~353 Mbps)
After:  ~389 Mbps average (Peak: ~458 Mbps)

Koen Vandeputte (4):
  net: rmnet: use fast monotonic time for tx aggregation
  net: rmnet: optimize rx deaggregation memory allocation
  net: rmnet: conditionally expand skb headroom in ingress handler
  net: rmnet: optimize rx handler by replacing skb_linearize with
    pskb_may_pull

 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  4 ++--
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 10 ++++----
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 24 ++++++++++---------
 3 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.43.0

