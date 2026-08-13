Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620742F5324
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586749; cv=none; b=DqfhWvzqzjR0S9H/v1Ut2Nk4a7E5kQwUv4trk7KlvT0m0YLnTwgTjImNh28ph+rTbiz5T1FcM4YaE1W8Q0C6dZV8cCP9CJfrCDLrjVVjBCcZSqfbcVeldVwv02EB9A93BoTgrdkRAhFImk6p6uXzPHKB25Vtd/COhhq58o142v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586749; c=relaxed/simple;
	bh=GdHd9XwXDasBVjWcSDSrVIVbgmomlJ8iVVsl91RJuhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFYD4WjAT3HYO8ZpLkVGczAO1SraPsJPIpRUc9b7zqyvqgWt+ST1t2DT1deukCqybQftU2tBRGa4wWJb3eW7IF4bqgg1HpYe+S6Sywoy63H89t7/8wCTMQ0jJgajq+gIHMASXJIfddZ+QhwTqgUHt+v6qNPo9dw5OZZ9W+HSH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym9LDdBd; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym9LDdBd"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66807ba2f0fso2591873d50.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586747; x=1787191547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRssp239zrXPHLOSSf9CxktDlsORGzDkK87ujc3fkb4=;
        b=Ym9LDdBdy3xujyNwndLfTWKZ9cC2pWRIvkRre7Sp8liotnSGYU501ZXgqS3GcyY3Tr
         6Dv0hX6JFNASSWXnspXfIhFjISkeyCB+U2MYBayQM/3KAPqpAVO2sufkm4YPthNoDM7Z
         jkfpU7asx1cKVMsu1xz/9ccgkrcn9GYrfZ02NqBV6i0BzOLLU45gu6qsSN8SBuJqwIyR
         tCTcCBUJka5N0jjc/Q3x7F7f1021YrsRg6oXHYmFhpfmH85W1gMSgNFO+/HfJ6phdFG2
         a3uPv4VynXlCTjN28GEUPb4RmHOTPI/5GTN8DXYkHMhYxqxfVEyyCyz8nZc/Fl1/vIjT
         A/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586747; x=1787191547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRssp239zrXPHLOSSf9CxktDlsORGzDkK87ujc3fkb4=;
        b=a5vdaNr+rCJJTAuUVNQxV7K4hTOoxgUMY4gBX64/brt0W0wst3IwAlMEVi9H/YzVZ8
         HSZsbMC/XxRTKSfj0PB4mYa/kI6uedsa7wxYowvbhYBRHyVCkJBhG1POACADgYlDQhNp
         sX3c+ymkOMbZjr361skw7whrNdpcxhPL0ZsQ0Jnvrr1ooTFwFZ+Zca+EaJlJBURitREQ
         re8XytZ4Ek74A7Vnheq4KMpu7Mp0c8Z53X2NvFq4EhISPy//tp1HA+p1UGhX3FsZRwb2
         y0XnI0xS5Yhg8ITDunCaLv4eGx8HPxDWW53sokcbSaPT8McR75tzCLVV9ORuhgghspJg
         ieqw==
X-Gm-Message-State: AOJu0YzJDtviX1vmHsL1HaouihDsRVqOB6XYqUlUOHxrvxd88gcXjZtH
	/kCpBAsAHBLQ3GO6GLI3OhYyHeBQE5aW4bdbxoW11eHkYp5yzNPzFGVkfYHIdA==
X-Gm-Gg: AR+sD12nDjmFC67cup51e60DZdBr7IArlFzANnVjn+AHa7fWzpklfxQ23WIET6IStrf
	gVD8eyGV0QiwENKVLzn2L3Pm2E8DdX3YWTvyhN6RCpvpTVLQLO3wyii/V0QSLfyuxIytpfI8XEi
	l/CU8VYwPehVKHR1YA8yeHXKjwy7ILKp0sjzTXmYpMUHd0uNf6HfQlt2eWHKqRycWNYCI8hgVrT
	pbY4GJ8mW0TcjtVvWCJeEVj/OA+XwtbBtDxVEIgdQw4FNQf2WW7U2GqeGRun0hEY9GX+wP68w7i
	eoFU9jyf1sfZSU0hjFvJv/j1ySnDgLE6VL++9ppJdNar09v6E3jLkjKEZnqNowmigLjrgVbM+ax
	dC8PmueR+35v6sSnVMba1ihI7cAGNXstcb9IvwHQ2fpOLlGvCNSVCjRmC3uExIzULTwDUwBahs9
	Bdjfry3uFapqOYrD+u/dsUPXi5fHEp3xGk2iURpKHfp6ywat41Ge6Ze2rRcn95kldvs4R7n9J+3
	jna1HyEfz5ohmlbKKeEX/XW8acY3zCB+LyJm2CaeeKD7g0PGI37BxxwgAwLNDjeMSyb3g==
X-Received: by 2002:a05:690e:ed4:b0:667:bc49:373d with SMTP id 956f58d0204a3-66c515c3f72mr970825d50.33.1786586747327;
        Wed, 12 Aug 2026 19:05:47 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:46 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 0/6] hardware pacing offload
Date: Wed, 12 Aug 2026 22:03:55 -0400
Message-ID: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add rtnetlink support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details and detailed changelog in the individual patches.

High level changes:
  v5 -> v6
    - Address feedback
  v4 -> v5
    - Rebase + small kdoc fix only
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

NOTE: the idpf patch will have a minor merge conflict with commit
"idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc".
The end-result should look as in this series.
(https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).

v5: https://lore.kernel.org/netdev/20260808155217.885299-1-willemdebruijn.kernel@gmail.com/
v4: https://lore.kernel.org/netdev/20260806232913.4020403-1-willemdebruijn.kernel@gmail.com/
v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |  12 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  66 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  53 +++++-
 include/linux/netdevice.h                     |   4 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  25 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 158 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  74 +++++++-
 13 files changed, 372 insertions(+), 56 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

