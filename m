Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428747;
	b=NMhTAR1YaP+HNGwfncgHHBcNpEj+BFcbbAtYJoNFSy5nRb6sR9yh5UvNaV6eHFeu07wA
	 dzA2SuFXN3xCAscg5p/k38aD5zr80G57KQ0GEk391X6Y8ysZIAKr7gTaPuVWjwxcZCHUU
	 gUqsdGBbAyNxHGlMRNnd3hHBBUiWUdE0fFHqm119uW+RvgT24rknoALDN/yYgRjXio5es
	 P66U9xbF1LN6uur/9Q70WFoZWUZfSe4Yd3MZvvmFSp+bOAIYTjb3L+gqhzVMcIzzfKCJG
	 4K9fK5maNdTJeeap/+veIQVu5TT3yLG8o05TQCeuHe6PQyQWHUougZ/kmopVLLXhUPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428747;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=0SM17f8ws8GU5qkZSgnLS65xQS+fCq9gj/D+AFbizlw=;
	b=yIcDl804LuEJXzApKE4lbX4E9G4qyQv7mtNJKmcpJGgRLeqqkNZHMDtTrUKblyPQ8hOr
	 EB74rrZbh+qCdm8sDVuEwxVqVi0UubhZYVsC9JtO17Q2LTqpHh3TRBjbb+7JF+qn6ZZNf
	 /QH3GkRp1njFGRzzpKbxAIHyQMRaYB5fWKlLJqfmiYQzgnYfQrnVYuBlQBsV7hg5Vyz5c
	 h9vEXj+9WcHgwlzPyDaYwjz9WAerwBtAVD4YT/sjZ6LoLHWpCrVYKz/2mm5kOo74aigxL
	 DR0QVVBb5Xh5pF0N4LzApHqKxEMnEFowW4bvMmmweMJU0POkXmeBkYzZgbrWatSEuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=H7dYOwrR;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE2606A31C;
	Sat, 31 Oct 2026 06:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=H7dYOwrR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0S
	M17f8ws8GU5qkZSgnLS65xQS+fCq9gj/D+AFbizlw=; b=H7dYOwrRorkXAfm5yv
	rLwKSwJLFSosuNLG9vO9TL2Vu0LALDZnq1P4YcZW+zsUxD7KQPdN/L7eXoPwQYfm
	kIZOm74hLP9nYwiQt8jAH965el6k85nog6SdYYkenV8dTenY1+McaM6SkddN+3qu
	ucTz0XK/7DoBT7q1a1jkNW4i0=
Received: from flipped.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXv9jfjOVqDwKbDg--.29841S2;
	Sat, 31 Oct 2026 14:38:24 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] sfc: fix use-after-free of aRFS work on ring resize
Date: Sat, 31 Oct 2026 14:38:21 +0800
Message-Id: <20261031063823.876645-1-congei42@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wDXv9jfjOVqDwKbDg--.29841S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy8AFy8KFWkXFWrCr1xXwb_yoW5Gw18pa
	y5A3yYvr18JFy3K3Z3Aw48Za4rAF4fJ3W5Gr1ftw1rZ3s8AF12kr4rK3WYgr4Utr47Xw4a
	vr1qvrn8CF15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joUDJUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC1AJvYmrljOIkXAAA3C

This series fixes aRFS work lifetime and state-copying races when
ethtool -G replaces channel structures. Both sfc and Siena are affected.

Patch 1 keeps expiry cancellation inside efx_free_channel() and re-arms
expiry on the surviving channels, including allocation failure and probe
rollback. Patch 2 prevents new insertion requests while the net_device
is detached, waits for pre-detach receive callbacks and insertion work,
and cancels expiry before copying the channels.

Stopping NAPI alone does not stop deferred PTP receive processing from
submitting aRFS requests. The insertion entry point therefore checks
netif_device_present(), paired with synchronize_net() on the resize
path. All insertion work items are initialised once and flushed without
using the in-flight bitmap as a completion test.

Changes in v3:
- Re-arm expiry after channel replacement, including failure paths,
  so it continues without further NAPI polls. (Sashiko, Paolo Abeni)
- Add patch 2 for the insertion-work UAF and expiry-copy race reported
  by Sashiko. Cover deferred receive processing as well as NAPI.
- Retain the original Fixes tag: asynchronous expiry already needed
  flushing before the later change that added periodic re-arming.
- State the discovery method and testing limits.

Changes in v2:
- Introduce efx_free_channel() to encapsulate expiry cancellation in
  the channel deallocation helper. (Edward Cree)
- Add the Fixes tag.

Testing: the modified translation units build with GCC 11 on x86_64,
W=1 and CONFIG_RFS_ACCEL both enabled and disabled. No hardware testing
or runtime reproduction has been performed.

v2: https://lore.kernel.org/netdev/20261023134214.322796-1-congei42@163.com/
v1: https://lore.kernel.org/netdev/20261022133927.3860186-1-congei42@163.com/

Sicong Huang (2):
  sfc: fix use-after-free of filter_work in efx_realloc_channels()
  sfc: quiesce aRFS work before copying channels in
    efx_realloc_channels()

 drivers/net/ethernet/sfc/efx_channels.c       | 35 +++++++++++++++++--
 drivers/net/ethernet/sfc/efx_common.c         |  1 +
 drivers/net/ethernet/sfc/rx_common.c          | 30 +++++++++++++++-
 drivers/net/ethernet/sfc/rx_common.h          |  2 ++
 drivers/net/ethernet/sfc/siena/efx_channels.c | 35 +++++++++++++++++--
 drivers/net/ethernet/sfc/siena/efx_common.c   |  1 +
 drivers/net/ethernet/sfc/siena/rx_common.c    | 30 +++++++++++++++-
 drivers/net/ethernet/sfc/siena/rx_common.h    |  2 ++
 8 files changed, 130 insertions(+), 6 deletions(-)


base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.34.1

