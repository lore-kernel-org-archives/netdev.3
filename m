Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915A439F78
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387676; cv=none; b=jZLxhI4FzaWamwVIzfsnk2L8C/AW+PlbBS0TTutySyeYtOFCfsYI3HqVcd8LXIogxBdGej8M8vFGi/aVlWayNCIzf5EDd6Z5ZAxzia4T/FRTN/GruQTymuzwzlhpwK3ZExpBEg5yeBoDdfZgwMDpx5YAxa8dnb+xeNKnD+gjZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387676; c=relaxed/simple;
	bh=x0QsXYnYa8Y8GiWNms+Noz+9KVQO46lMTo5YQMfvmJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqNcIMtwi3EK+fkexg5aT86zVzlnhcc9On3KOa1Bjbc/xuA3lfv5cRiiOoo3EilEhZaMOHZPXWI/qdiEx+MIv6R+/UUDEVAIW8tqoNatFdkFLymX4ZdIeNFF8ZfIiTC3bQXyLst5HgrnO9eCoV3dr4gCcfP8HjyAa0HmdCVqtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/9BWBF4; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/9BWBF4"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so1225628a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387674; x=1786992474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
        b=e/9BWBF4ZeTaqLUqsEBNK4tfCva1JyzfOeJ8VCbeRT2eVn88TiLrqMY3lFT6fGDjvf
         ZUGumvmG8t56mlRr5M7Qu/Yb45SxpQIqm9wKdFRaB5W0UrSyahKIuucm2nSVvgDhu5DC
         +2VoNpdgCSBf/BsDeek3mdvTLFN3ozpFpFz8jFk4/eu3lLshlmukGxPBQkhXLrk0e67H
         GVNM4zPQFYPaquk9yzq5MRvm3Yte+4C2jyAUaxbhZZu+NOHBMdDJy6f00l9bM9Yz+tEv
         7/O/ygkKvBrld6qw1ITeOS4CY4REWxK+BpfiOSOKlHU4dHfSqWxLYfJ+ZCizztAFvye0
         RiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387674; x=1786992474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
        b=h/HJD6XhieUq628JkN4tqxMxGs7SrJAqEuNsuIVgtY09Bv1z3nJFEpLdY88osIl3Uj
         hU2qOlihDWLQsbvevoGGQ5DdrPjUkjIf1F4FlkxsKGZKlxiSK2SrrPPxpT4GYdbdpMB8
         crejzOiYzNMokLg04FCI453U0Bl6rDWMx81xCAgWF3yYmy2kBb+o93Xy+Dq3tz/dnS3s
         kTlPjt/3EzXMEdo3AmPmvQDucveBXDn4g65SaBcTykmF3A8GHt6qBvFUoFKLr/ZWTuYZ
         PukdhgJ3eP6otx+Ag/cRlrtGEXGqSfYtjfSBvNA7VPALib9O+nt3bOJi1ddK0UFomTOn
         lr9w==
X-Gm-Message-State: AOJu0Yw9uX3WokQn/xKzqU0ccYleltD+3zc6Qj8cP0ASKz6gMCCDT2dK
	Ny9lWpt0cvvC9oZ8oWHhEiF8U3aw+7Ad1Kmd2d24CCsvtIh/sh6X8K2mL7GELdfU
X-Gm-Gg: AR+sD11gH16NU4r7EEkgF+Ba3Kfw0BnMi5R4G+WeeXuUrrd39Fp1vDgtHVOwL5jKfg/
	84GRI7s/Hxb8tSQ5ITXVhMeERx9efnrpxZz7wg6T22sJSCm8ZkEC75b+xPX1eUBe9hFwCiuKFop
	9NhKK+BlAIbgIyFjXKzNrvb5uIJETwnjgAihz3U2fT+C3uTL5MqW1H7UZIzzlTwBVUGQoRs0/cz
	mp7mtdxRqVZTAii9L/PlVOtDq/kLuwvS3T1NmTg25HyFd2tRX1TVMhsgjJ4/BREV3t1QzFjo+LQ
	JQ5Y2hXd8ZMzJmNCEg3iURAJl6QCcpmvf4AtBfHGFGwlCrb676o8ryOo/Sby9aL3E7FHXPdtZC7
	KqNjdejh7gEp4QlGPnBGI7NVsJHrLQihJ9HBzRQzcwEwsEGXGKSoz6mdjJJeyZbZZRCqC+/Bb1p
	sZMhNZUTvuP5jqlMMzn2OUUlRDgF4tRC4g+6qOVGTdZ4yoQUQSQk/3sg==
X-Received: by 2002:a05:6a00:3987:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-84f9c965aacmr3341745b3a.21.1786387674437;
        Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51d88dsm4244979b3a.29.2026.08.10.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next 0/3] xsk: pre-existing AF_XDP TX metadata fixes from Sashiko
Date: Mon, 10 Aug 2026 11:47:50 -0700
Message-ID: <20260810184753.135756-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes to address pre-existing issues from Sashiko review.

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: skip queueMaxSDU check for AF_XDP

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++-------
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.53.0-Meta

