Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623810;
	b=sybvNHRZ6AlNZmRPPgQ0fHj0Q7c1m+DSBbi9PZlSA8obQzX9KLh06OA+B54B8w8ZpYWE
	 WLMEA77+eTlfCb5U7PANEMaj53I3J4z0xiK4aym3SzkppkAzT/Deubn4OQtZ9ZsKrMoeC
	 m+JjvnHL2YpguJrSYx81Ncd2FXNaCufySANqcwnwrBi07in0jfkJgjr6nLpNxEEd/Q60I
	 a1udT8mhBqzV4P/+l2wycu/UVTZ8uVoCEC8U5RfNSSzDgQ0TnzPy4HXHeNDQtVsK9ZBG4
	 yw/G1quyqXPTuAtoMjfuc4/DFMAZfDjMsiqy2sykreyQ49Xv88hNFE+ioRaaYrifGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623810;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NtcqnJI4eihhPYOpUcvjAtuM0mXDNTKjgD0O5yUeeS8=;
	b=0v3ak4ObHzP3jfK+pNqwl9Qc+Wb/s70y1LXjV6HLvHwJ94vzf7EJ3WVpmH7SP7vWK2B8
	 gxI8P6mVcd9LJfw2MOReaFaZaj91DjTvXey9iZI+sIkXev6whI4HaKRJVKSdWqGgqBkTV
	 RTeOTkZ/9zy5UhKQ0JRDq3O8qoMYRlOGfrHxSInycOzgBHu1fltfDwUVo4jTh8nO2kg09
	 VIxtvwdx+AJ5zeZ2nzoCdi30Am1yFFBBiROIzVxhz5QqBbncViEM5izD7oNYnDtbbaTgS
	 72E9CIeEYS/xJr9UpgFhzXuC3krfQh643PniF+ZAreTHJNcI6zqp0CRfzL9JsjLtmww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBIgRKFl;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B2606A331
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A57B2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBIgRKFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623809; x=1825159809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1b/2Q398Hb9hv07IksWUMlWHgMzE8rw7C60wimdZCW4=;
  b=kBIgRKFlNKPtoo6R46MNtP1sLKN72jv9yOuHhcQVLTSH2n2yazsU5wTc
   PA+Fud6qUfHpI8/ALsYlRatuRgfZmxMfvy9eLbU3FcI3BkRy9NoXqu/1R
   bv/AIdri8A/4K7kbxnP7c9yhsZHiH/Y+9aZqxeHccy/crsJ6A+8lfIAwk
   VQurLiN/8AE6v4Wm5hPzL1xDZNKwYA0Cx8kd95wAbx40+jeH24Tn9z/zy
   LKgtTPYTtlL7oOZSKCngMCbT8UBhw6MACGUJ3OGfzHDG1QJ2+hOb3SP5s
   aLp0r0HBHd38sj4T9MAtd8pT+OBYV/qXZ5GZmmh3EzNT5qBMx+rg+FjoY
   Q==;
X-CSE-ConnectionGUID: jTdnllVxSAC2ZiCgSgOODA==
X-CSE-MsgGUID: onWA1Iv0QXShgtP7svAW2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191844"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191844"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:08 -0800
X-CSE-ConnectionGUID: UZGsSqLbQpCBQnuXxgnISQ==
X-CSE-MsgGUID: S8BKckjKRnu//0SS8dSavQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928469"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:07 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	zuomao338@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 3/9] ice: xsk: fix leaking Rx buffers in multi-buffer path
Date: Mon,  2 Nov 2026 13:49:44 +0100
Message-Id: <20261102124950.958345-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
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

ice_clean_rx_irq_zc() consumes a descriptor without freeing its buffer
when a frag has zero length or when xsk_buff_add_frag() fails, which
happens if the frags array is full or the fill ring has duplicates.
Such buffers are lost to user space until the socket is closed.

Free the buffer in both cases. xp_free() skips a duplicate already
freed with the frame.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c3..ea8ac0fcdf6e 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -618,8 +618,11 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 		if (!first) {
 			first = xdp;
-		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
+		} else if (unlikely(!size)) {
+			xsk_buff_free(xdp);
+		} else if (!xsk_buff_add_frag(first, xdp)) {
 			xsk_buff_free(first);
+			xsk_buff_free(xdp);
 			first = NULL;
 		}
 
-- 
2.43.0

