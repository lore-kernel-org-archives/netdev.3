Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A53D7D9C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874634; cv=none; b=kJwsHg6GkKhPBVgrqI+iYdeOMM9MfqCOcbNqgx82yqY8TfoFcP91wRkabcW0z0P0QRBed0ZNpG6gH2POeyOIWlpMPZ7+cZMxZ2ZjnvJMDrZFACjSCJ9fS3+/Bpm8IrKoejN76323w5/8HYGsOj3iImhJ6xQO1U/+6D2mMJ2ZLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874634; c=relaxed/simple;
	bh=iRuh/s6Ipo9nZvx/J9+0+HpYrUaUvgSFRS3OUGAoNwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHlz6T4MXZRIDE4sONLIYHHopdpLpCnGwjJkbJFCEqga4BsrEARnyOV9gNhLg/K+de1o415jSPHOHwVXSr1KmDq4g4pLkHNyyvkFBvrW22Jqfgv++ARGM+t8Wk08B2LCm3FqlWh6RW1OTeUPGX9IlMMCmin2OIOSoS+71qZdSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=KPBN5Q7p; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="KPBN5Q7p"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so22419385e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790874627; x=1791479427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBgkdMW2PJxTxBX+kIlfjfUkDEKiBwZjSW88C9NEh9s=;
        b=KPBN5Q7pmsFdNiGDGmqAHm+VUxTbNXGzZaVJ/O+EwdGRFHDx6Mrd5lm0Kp6DfoOLyD
         F22C+MjaTY71cLdY9D+c5c5HdmUxlEgAYBhWrh/ejmkXNzReBGPhU3qJ8Me4FfJsFh8N
         5Bf9VgxgX1F6V0A6wYzVxnAi3M/slh1XyXOJFMQMOEV1LsB5/h3TxajpNmvfYqdx57EP
         FMHAtsfpYkhU/2OeTy+USeAIJqt68lUIe5Vs62vtxFtR05krFM8cprK7zAu9slyLwSB7
         cr6OMEf/l4bPiehyGakXhlZX+4BP0jJdKBnP51b2nnz09k+ACttUjhOiYr973KVeF/w/
         dm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874627; x=1791479427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBgkdMW2PJxTxBX+kIlfjfUkDEKiBwZjSW88C9NEh9s=;
        b=SyuYPWkf74j3ZwU6sFrNJNTD0UBKLeV2Hf7jmoaOOI1TJclcd2wLB0ru4175FQ2o92
         3u0vkVDFVJZfwtWifE1+AT486IBQxw0heZC1IqD3fX5k8dmBKwFdTuXHwcxiESjzWVHC
         QeiuQ9F3J61k/0BnjXjQIhm7U67xnXk/3CQzSV+ImLpCDmBmAbuLrFTNB+LSfu5UH9kC
         RaQRswKS59rVquhVb0lGBq76bHvCug2FNHtYxaWSfkQrKqtwLcP1llbXomZTSkqTng4q
         uLq2QskswO/HwQkPQz3Ft0WulA3olpuJ4GzEteMjeDfAvPdXuDBqROkvHY3g2+/Jyanw
         kj6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOQYxarY7MvGLFQ+cDYDef7byQ4PW5jqSj3vDzSiWacvfa9PzIOTZTbBdbCU5s8PBYIe1ms3g=@vger.kernel.org
X-Gm-Message-State: AFuF++ln/2YlhSeHEU4Esd40jyV0u8DzS2QK7LvUPb09NMxOvLPnKR8N
	5nS+9HDcvQxY6OtfWejDPJRXYGjczrNFjOPhWdgZJlTxN8GFYuPRxekv22epwf7q+ik=
X-Gm-Gg: AYBFou1PUJ9dnXGF9BQonbB9VmXeXkFKYlAxRM++iYypIaTyJKheWABnTaYUBk5MTLB
	J2HIgmA6Z7sSytV+7Fl/fCVNcXsXDX+zi9q/MWX5t7RdNMsK+da0grDaTXq6vAQ4Tpm7wHq+nbs
	3WTBM8HcJk5IYTFSifreC/oay3oP65o3oz7YYhiGaZ/jQcbcMuxUhO5hp4bsHt0j3yCZUhbe8sm
	1R1PQTQ/k52mgJzeYVsWQ7MU54V/aKIUz7toeC7AncWrypa1Q9er54xgzu/0jUbeLr2DyVWIOuH
	P5wX69dnAmVRcL30aPYVrOlSjPp8z+iWpwkIfQDw3IGgyAYhikSSLX/1jQNm0ftRRiGCdfPsL26
	k/IILErtoUB+ibm1jqqk+odWeLAUW0fd/rn7ROqsXBP6ZzGWzxvLXPHtTGkor8+glTG5UvWislB
	N2zaOfatVwbO2T4N8fy6w4lpjSQyF1738yfm/lc0gvJaDT4LdvmFVoWCy0ATSp6Qvc0Pu8c5bkc
	GnAnQxwbAil7tpGiiX6ks1suU78GFqLDItLk+5xwtIYrPT+x1N8g21vRbjeJsZvvU6/cq83E91o
	Kc+o
X-Received: by 2002:a7b:cd8e:0:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a02758ff89mr4168705e9.19.1790874626793;
        Thu, 01 Oct 2026 10:10:26 -0700 (PDT)
Received: from localhost.localdomain ([197.51.130.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0278fb6f1sm2496985e9.9.2026.10.01.10.10.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 10:10:24 -0700 (PDT)
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
Subject: [PATCH net-next 0/2] amt: mark relay data as a UDP tunnel packet, with a selftest
Date: Thu,  1 Oct 2026 20:10:14 +0300
Message-ID: <20261001171016.88208-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series follows the discussion of my earlier [PATCH net] "amt: do
not offer software GSO on the amt device", which I withdrew. Eric
Dumazet pointed out that tx checksum offload is off by default on amt,
so that case does not trigger by default, and that the better fix is to
call udp_tunnel_handle_offloads() in amt_send_multicast_data() like the
other UDP tunnels do. Patch 1 does that, and patch 2 adds the selftest
that I said I would send with it.

The earlier thread: https://lore.kernel.org/all/20260928181554.85766-1-omar@blockcast.net/

The trigger needs a non-default setting (ethtool -K <amt dev> tx on) and a
GSO source, such as a UDP_SEGMENT sender on the relay. The problem was
found by an LLM-assisted code review of drivers/net/amt.c, while
developing an IPv6 outer transport for amt.

Results, from the selftest in patch 2 in a KVM guest on net-next
commit eb0c18404c89 ("amt: pull the AMT header behind the transport
header in amt_parse_type()") with CONFIG_DEBUG_NET=y, eleven runs per
kernel:
without patch 1 the UDP_SEGMENT burst with tx on is dropped (0 of 900
datagrams arrive, tx_dropped of the relay's egress device +100 per run,
a trace shows __udp_gso_segment() returning -EINVAL during the
segmentation on that device); with patch 1 all 900 arrive intact and
tx_dropped does not move. With tx off, and with plain datagrams, both
kernels pass. The existing amt.sh passes with patch 1 (it was not run
on the unpatched kernel).

Not tested: hardware with UDP tunnel segmentation offload, hardware
checksumming on the egress device (the selftest turns it off there, so
the non-GSO CHECKSUM_PARTIAL packet that now leaves with
skb->encapsulation set is only checked through the software path),
KASAN, sparse, the udp_csum=false variant, and NETIF_F_GSO_FRAGLIST.

The selftest is a small sample so far: an earlier version of it failed
intermittently in about 3 of 25 full runs (listener counters rose but
the receiver got nothing, which I think was its idle timer expiring
before the sender started, inferred and not confirmed). The final
version passed or failed as expected in all 22 runs, but those were in
one 4-vCPU KVM guest, so it may still be flaky elsewhere.

Known and not touched here: amt advertises NETIF_F_GSO_FRAGLIST, and
skb_copy_expand() refuses a SKB_GSO_FRAGLIST skb with a WARN_ON_ONCE().
That is independent of this series, I have not reproduced it, and if it
is real it would be a separate fix for the net tree.

Assisted-by: LLM

Omar Ramadan (2):
  amt: mark relay data as a UDP tunnel packet before sending it
  selftests: net: add an amt test for UDP_SEGMENT through the relay

 drivers/net/amt.c                      |  11 +
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   2 +
 tools/testing/selftests/net/amt_gso.c  | 473 +++++++++++++++++++++++++
 tools/testing/selftests/net/amt_gso.sh | 269 ++++++++++++++
 5 files changed, 756 insertions(+)
 create mode 100644 tools/testing/selftests/net/amt_gso.c
 create mode 100755 tools/testing/selftests/net/amt_gso.sh

-- 
2.43.0

