Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623823;
	b=IBQ2bHmwUGSLerEw53a3v6J1hwWe+ZcpLG8bwM6LsEOqEmY9lk6CJ3jEA/CvRAym9dOV
	 acYu7a4XI3XC8IkWKDvScPUDVhBX0qxsA/gwN8NmB5Sk5+o6AnxAKzuld3T0QJxQI/0lk
	 /CWZlmwuL230wrEQ/x9Lo7gyPZcOz0YJ1CYdzONSkDhLHgwiDOB1YF2lCq96rJGYH055W
	 3MJ8y3tQtWN0SJmpj1N/jOvyJA9bs6nDQYCxxlXWdPTahUKrVMddj4BNGDghICqZf4aP9
	 DNA1Fb4BmMq6wHXqwYoH+Ea5bl9W0fIa+ifKK3J4FvR8mhgE6gQsE6dosMmYW8amZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623823;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nn8hrJySRz2QsgnOMrsRAY24mOLg0RAn2rZ170XfQmU=;
	b=sbSd5OYabc/gNFluDxovs6Tq/RoZBjWrcaJ/CBRQCbg0hJg2RPASs8yjnC9twfQzc91j
	 WcD3qB5E39UY1epOjwYASBnmgca+4nIWaOw6u5pe+Wc85TqNJITgqFRk+pByygK6BJ3hq
	 lfoJA361w+Vd93bWNBRK2wEm6z0AlzJGPoI3migKja5NLRMV2gQ2ekKeI4k53TpRHJcnY
	 W4QdLesygYDlQH8DaGOS4/+buwPgF4LawCaZhQWkTlHMwAhNSscohVwnk3sTADufcbNAX
	 3n/AAC/9bCSRWf/lKxubfLY3UVtaUth2zIUviZmzzu9EQKrEwEjGZ61G3dvTahPBjgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XRtF0LF4;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0E60A2610
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E0E60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XRtF0LF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793623823; x=1825159823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8x7Lk8HUNqHyKwkRSFueTSNMtFEoKXyP69kya+7ikok=;
  b=XRtF0LF4WDS8eMDc9SoHT0pr7xs1Bob96J9qHQJye6nih3H6YXGTvxI3
   OcX4kd4/aQMUSY5DJkwM55xjgfWSASfIf5iagJ3Ouxe4tva23QYtUP7SF
   0GJCmZl84g+K1LNbeMwk5UACUu7mZl2UofpnrNq5mrqcPlbleIZXAZnou
   nzMXanu8mbvr7uqL5Zmtlia1R3ZXPMMxtbXJQ7klLN+XyCNColwNoUDlB
   Ti0SnoqVJtecBGp4B9P9MeWEes8Bvy7hLj1LDx+mh+D+NbylGrrCoR2ak
   gHY8rBEShQSSZQ/X+2ewlZzYW6c3PIxIhOXaEbY31JHjNL+2FmhECTBwF
   Q==;
X-CSE-ConnectionGUID: X7owtS25TLWZp84Zv6Rh7Q==
X-CSE-MsgGUID: 5bPEQiLGQdqrKpIbkPZfyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2191889"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2191889"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:50:23 -0800
X-CSE-ConnectionGUID: g/Nw2lMnTmWMWoDbadzBDw==
X-CSE-MsgGUID: b1siDrbWQ8u4uBVlDNdJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7928556"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 04:50:21 -0800
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
Subject: [PATCH net 9/9] idpf: free stashed XSk Rx frame when releasing the queue
Date: Mon,  2 Nov 2026 13:49:50 +0100
Message-Id: <20261102124950.958345-10-maciej.fijalkowski@intel.com>
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

idpf_xskrq_poll() stashes a partially received multi-buffer frame in
rxq->xsk, with its frags on pool->xskb_list. Nothing frees or clears
rxq->xsk on queue release, as idpf_rx_desc_rel() only returns the page
stash sharing its storage for non-XSk queues.

On ifdown, the buffers are lost to user space and, as the pool outlives
the queue, the stale frags are taken as frags of the next frame. If the
pool is disabled on a running interface, the queue restarts in page
mode with rxq->xdp.data still pointing to an xskb of the pool, which is
freed later. The page path then takes it for a partial frame, writes
frag info through it and returns it to a page pool.

Free the stashed frame and clear the pointer when the XSk state of the
queue is cleared, while the pool is still attached.

Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/idpf/xsk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..5a0a1d8a7a86 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -134,6 +134,11 @@ void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type)
 		if (!idpf_queue_has_clear(XSK, rxq))
 			return;
 
+		if (rxq->xsk) {
+			libeth_xsk_buff_free_slow(rxq->xsk);
+			rxq->xsk = NULL;
+		}
+
 		rxq->pool = NULL;
 		break;
 	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
-- 
2.43.0

