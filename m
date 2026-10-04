Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CB3C1991
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130338; cv=none; b=P8wxu5R26/cXVOduYEKkrRDtAPjuqyBNNuUoDKV5xknSoIEl2BSCQhOtmNvNj89EJD67H0jfWkusc1C+BjWwfMYp/F03TCt7t+NhExN6MKNh5yUlDteGpWmCF0pcGJHRNGJsfWDzXHlBFEqQFUxiJhA8mKE3eR+AiPwg5wjyx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130338; c=relaxed/simple;
	bh=/idkTiictibcBwPx3KaPsQdtHC3he+EupjWKYNAP2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/7i7BNgHWGrZCfVavsI4a+DRRRo33/M/jn0F69/ghMCFR9bcwcbga4O3fptv/ODUGgYtG5JfvxMhwMLbAXUjK9vQf/K0lLtrqI+W1SjssgWlhnDiTBPr2U6b2Y6O2sHwycfK6zoNgDkdhsqIP8FVuH5eNrp6u/GIlgbQBPJrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=LvYwD5Gy; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="LvYwD5Gy"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48b0241a47eso396178f8f.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791130334; x=1791735134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPYochGZLRchHnAPZrvdvx5IZfJjHufMRI6BSKQPizk=;
        b=LvYwD5GyiDwXhrg/S3JMlbplWAU5Gcxl9zVnG1Q9it0n5G223lMoTRKLnxwTCSII6i
         K6JOHWf6U61ppLp3jIfvF243UtfPQ+lZW9g96sbmxG3bPMQwBs2LiwWp0ERocW9Fbkiu
         voMfnuuPH3woYNouPAHZeoIGSdhDt3K372E/rPhoG2EVsqWMLOTgw7NTvpsX4uEJx4wY
         K6TYwAJrPc6JxVLPC4WbKCffPhCWMm85zq7Njg5QU+KMR5A7rddbxf955UmAcpZU45if
         wpm0bU+hWdXebgQUI0ClWc94jgXoCpFv0lGgDF35leDqggX7gL4U25OUC9JOsku8z+fm
         vV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130334; x=1791735134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPYochGZLRchHnAPZrvdvx5IZfJjHufMRI6BSKQPizk=;
        b=dpwm5MHoMWkDpSRRdZdarHZh1BdCtbOkfGqwGpxnyJ13D9O9fyRqP0B8ze9tzDIuGN
         r2RlAm+y3yikq5wiwG6WR2c0lShrv9SpED4BiEkHHLhPelOfltiDsYfR0dQ3kTwpBkzM
         HSO7FcFgsq0LtR5imlVKouHNtcFKECbiGEdJagszpgMymbTBBUUrntvbJqzkQidqwAcI
         3NhALPOUa1rEKkdsIvkBGIfYWW00Z9/99rsrxMirUhmbwb8tVnEFonMcSgeOzGt3U2aU
         Oin3oN8Ia5v3EnS9/7hsnfmNqM8j6/A+ZQkr2YuMQlSsC+t7nwEAR+YbMuKPE9FzRKWA
         4O2Q==
X-Forwarded-Encrypted: i=1; AKwUvByLxAW9Gx/z723uMdB0EkBQFZ5KtbBkHoXSzeD8Gn5pDnPRS54zIx7jkuCLUKIVAtm9AdyRKR8=@vger.kernel.org
X-Gm-Message-State: AFuF++mDnxcXTqJKEl+YJAWd8hNo7SY/AuKXRp3MlGqBH2C+2yFUU+yw
	n1I25qMXf7wpNpywG4IxBcFwgmwAAzL1xQuxHlhMsUWrXOZgARWmTIh4D9//Pkjih7Y=
X-Gm-Gg: AYBFou09B51IO3wEBH98FhCHtBCUD2YeCYp66PKCR5R29GzEB5G+wpriSNQB+yZea9b
	w3s/KaPPi6u8WsgobxJvvd1sWAOcLaGS5SgKnxhvnPmacLXDjMTNioIDdXZGFW3dqDL45najlZk
	uL6EtPenT4aAQsxxH+Py+MN/VOOKvBEc3Hs66ykMvi9gCe3HigYRnTE9/CnPlWUBpZOOD8u1fTp
	KQZlyDsEvfl0hORho59PdQIjFsfLQOKKZZkq6ams9IhaFlNOOr107YG+TfOeZkCpe2kvCPNprXi
	/mzWJKGpXYp1EiqepnbgsvIq3Yp9EKLvkV1Mf0eZolOIarvEy2GRyw+TSF3OT5EJv+BLz1XsFQ1
	lJ3Kcc72vKe13HPn8TE5mViHLHoo0K0RPqd8vdV6LAd/nwPDrjXKNNKdmZZsqgcUd5sSOjTq+QV
	ut8X1FzBZgRyLecb/LqqSiQDBfR5NIpSi9ku5LMT4iSScT9YwghuKvJfQCTWOLVAzFKpwhSoxw8
	QTH85CDTOnns7nbupBK20y5xt1UHAuZh12CaXjmX8ax8y+tTRDYwB+4/UIWUeVz/P4efLgnQInm
	IEnRtW/XpYo=
X-Received: by 2002:a05:600c:5392:b0:4a1:6991:36d7 with SMTP id 5b1f17b1804b1-4a1699137bfmr78497205e9.10.1791130333960;
        Sun, 04 Oct 2026 09:12:13 -0700 (PDT)
Received: from localhost.localdomain ([197.51.72.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02854073csm244512275e9.3.2026.10.04.09.12.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 09:12:13 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] amt: mark relay data as a UDP tunnel packet, with a selftest
Date: Sun,  4 Oct 2026 19:11:58 +0300
Message-ID: <20261004161200.27196-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_send_multicast_data() never calls udp_tunnel_handle_offloads(),
unlike other UDP tunnels. With tx checksum offload on the amt device (off
by default), a UDP_SEGMENT burst through the relay is dropped before
patch 1 and delivered after it. Patch 2 adds the selftest.

This follows Eric Dumazet's suggestion on my withdrawn [PATCH net] "amt:
do not offer software GSO on the amt device":
https://lore.kernel.org/all/20260928181554.85766-1-omar@blockcast.net/

Not touched: amt advertises NETIF_F_GSO_FRAGLIST and skb_copy_expand()
refuses such skbs with a WARN_ON_ONCE(). I have not reproduced it, and
it would be a separate fix.

v3:
 - patch 2: fail a case when one of its captures dies (Sashiko review)
 - patch 2: also check amtg rx_dropped, as the changelog says, and
   mention the plain-datagram cases there (Sashiko review)
 - patch 2: wait for a fresh READY, and fail a case when a helper does
   not start (Sashiko review)
 - patch 2: fail, not skip, when no relayed probe gets through (Sashiko
   review)
 - patch 2: fail, not skip, a tx-on UDP_SEGMENT case in which no GSO
   skb reaches amt_dev_xmit(), as the changelog says
 - patch 2: make amt_gso reject sizes that would overflow its buffers
   (Sashiko review)
 - patch 1 is unchanged
v2: https://lore.kernel.org/all/20261002212458.34247-1-omar@blockcast.net/
 - shorten the changelogs, add Suggested-by, and move the testing notes
   below the "---" (Eric); patch 1's code is unchanged, one comment is
   corrected
 - patch 2: fix the shellcheck and 80-column checkpatch findings reported
   by the netdev CI, skip when AF_PACKET is not available (v1 reported no
   result and exit 0), add CONFIG_PACKET to the config, drop dead options
   and code
v1: https://lore.kernel.org/all/20261001171016.88208-1-omar@blockcast.net/

Omar Ramadan (2):
  amt: mark relay data as a UDP tunnel packet before sending it
  selftests: net: add an amt test for UDP_SEGMENT through the relay

 drivers/net/amt.c                      |  10 +
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   2 +
 tools/testing/selftests/net/amt_gso.c  | 462 +++++++++++++++++++++++++
 tools/testing/selftests/net/amt_gso.sh | 282 +++++++++++++++
 tools/testing/selftests/net/config     |   1 +
 6 files changed, 758 insertions(+)
 create mode 100644 tools/testing/selftests/net/amt_gso.c
 create mode 100755 tools/testing/selftests/net/amt_gso.sh

-- 
2.50.1 (Apple Git-155)

