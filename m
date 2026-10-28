Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155837;
	b=1P+i4hzktUBYiaJbXbF0g3Id5DUtKYmMuSK9XVEK10ExWPI6LdGPa439FbwZRf0/55IM
	 u5EkgzpzTnlNelPkjUJ+XcAYE02onCiFy9SWVGxBR/5EomyQMgUfDQ7MXucFm0cXGkVOf
	 IvYGEUJG55fpktC8+XmF7GgwxaTvH4Hs8Z10piwJ3y0/4w51kGC6a589pzRIrMVJDrHuZ
	 QOEmpkTKRcAnQUhZDFGWplqwjk3sAsTF2daI9MDW3GBiiWsAjW/QBalbes9sNLn5B3Ukh
	 ormWLQY8A7oWAr79YOg3LPfM+CHseTyN62L7t237IpOmXBnEXdYPMEyTgXoF0+knd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
	b=Xh121+qU0cBiEnBN6Q+95JyjINJFessRStZqAuMFDkULcchYhtkHNoglJOPNYfqDzatJ
	 htu5jDBBLB9q+w4OG8jY6ZVNoHsesHRkzbpYvp31XS9+iBngYU0Wo8aOQF5NmvzD4fxON
	 urRpQcfklUngB56ZhN+ZcDs6JwA+8k4m4rfQdqSylfz1eEAp8xnwigKq0VzN2n1xY4KcJ
	 K2coUB0Uikrg9/0coPhFDuisjX+r4eTfU2MEJfRSA/bZdE7h8sZnyy2hk6L6fMyyXiV+y
	 bY+W5ynqYyGY5TEJ+euiDYu29g9ttI/gLQOUSi4pbJD/Qo7zcUimBaoJZT7D+ZxUiPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eyx7f7/Q";
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3B606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB3B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyx7f7/Q
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad211ad92bso156415a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155836; x=1793760636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=eyx7f7/Q+fC5WBU+omNKOxO+4BfKSrMYmI8hYrJpclwUOEoA6wTu7EeAmY7Z94v2oI
         M2TY42zmspkcu6VNsxBjAE+aF4d7IfbfAvfA97oHKZtIeEsT6eInGiG94FMu1Cn2ev7/
         Fszu12V9BVBTIMIahHLC97qq0zzHjq9XpWGOvDUNFrPmjxkCT7wpKB180sqCNkYD7ryB
         eUWUPZVUN5qMpZYuwf/1KjMQpJeVFpWVHh3uDsxU6Wn5FeL8hY5sByuXW7AGfbxKz3DD
         HTubBCzRUHy7MA2t5uuYNN3slB9JE+NzyjvZwmX7KN6tS4KhIhFId4YKXcelvnKIL8AI
         1cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155836; x=1793760636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dzXShKALUyaZeixBnjjH+DrrZjfaru5HO9W3ebDULU=;
        b=1FUS4Sag3GYxAa373+oAsIg9OFZjqSd6VamXKwu65Yt9bVEqatZONvIsWkmqScLNKm
         LmqcYtLz2Ge7MrkuqbCkaBQ+0coCg8yQBuYgZqxPjkaQlU840HZkhcyS5l0HbeK3so+B
         Ec61Zylhg11mGxHzN0KsHa+xlBPrUHHMopAwXa8hG7/2t8tE1k4/WLd2pCwxURVFln1L
         QGPcaJlYzHy8arpM4F49MZY+MskCCSyO/dcBpRZIyLTf3InMY+g8gd0VBZEK1bsYuzB+
         Vi+Tl7qyCSIvEvBfyYM2e4SU8cZj2VDfPCzFBCY0qFQL7GVrzY+yqx0ivfs0EPj8kR44
         aMbw==
X-Gm-Message-State: AFq9FYJMkwa4KIdxcvu/h/p+StgqHeMSZ4Y1Jcgb68YDIr4FND017drB
	UTwC2Soxyzk5ThfLswP4tkFpXclr+tHGauaerJqgwpvq93uy5y8K4LIKnl9AxCQH
X-Gm-Gg: AYBFou2IKKfhD08t+l0yTpG/t9GVuC0Xix18iyLpDUmpI2zkjDuQsUeeJbauPVsfozY
	DSH1khItR3qv7Y9bUM39Th4P/ZCSJgvucVkz6m4RrUJXnVdBq27Gjyl5bgKjS5jLEYiNaYxsuln
	tAQZQvYzQZGAzSO/J1FHZosixO3BU84Aprkpz6NxizNzsuyXybxAe0QCF9nTv4tkIOFfEM6laju
	jW+KMuvfklZeKcaSTEb55I97S1yuXYrR2OQy6VR6hR2M5m5aziekTVK5UjGfj9x1yVQ4r5oHwgk
	/jttTgPSIxML2QjTG0P3uB1EuXx/wt5p4gNebbkL5xvZYGdhuzDqJ5MCkEBtXha58ERo4efAOv2
	4qRaR0TMUO4OFMOMypUIYFU2pA3nnH+h+HHm2BPq7WC1nYdUsLhkRZTGBKM7HOblpI7Ko4HiFn1
	8f+tEZ5TXQ3/Jp9SE0OV3wXi/hpM97+Z3eb1rgv/tScRvoeAvi1EB+dttgTZoXaKV4D6eDRzVMj
	TEjyiaqhxSVcrugx+nFc2nIeD4vFSv6LLchXSfoMUip8v56tAwBGzoPOzYbnB96wob7j/Gs7Jf9
	cCVtTGS82pbdZQHLBo6OaWppTIwYlTPeRYt5Y+9MnizVJVdVlwMJLk+z6jaijDeOaI7mz67gKdF
	Lzj3H1xcH
X-Received: by 2002:a17:90b:3eca:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3ae57e078a3mr731546a91.1.1793155836154;
        Tue, 27 Oct 2026 19:50:36 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:1d00:2b84:48c6:402f:d1c5:644a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm812447a91.1.2026.10.27.19.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:50:35 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v3 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 10:50:24 +0800
Message-Id: <20261028025026.11401-1-testwrzwrz@gmail.com>
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

This is v3 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 extends test_xdp_metadata to cover the single-descriptor and
multi-buffer TX cases.

The updated selftest passes on the v3 kernel in a local QEMU run.

v3:
- preserve unlikely() around pool->tx_sw_csum (Maciej)
- restore the binary MAC literals in the selftest (Sashiko)
- keep a distinct malformed-packet counter out of this stable fix; if it is
  useful, it can be added separately for net-next later (Magnus)

v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 122 ++++++++++++------
 2 files changed, 99 insertions(+), 46 deletions(-)

-- 
2.39.5 (Apple Git-154)

