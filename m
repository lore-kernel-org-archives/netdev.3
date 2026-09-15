Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42E47988B;
	Tue, 15 Sep 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516610; cv=none; b=fdrl4PqFzOBwRUyiyD9B8kWqzkwwm35j72QDIaf8VXJoBlnZN4OeD0k/NkaE2TtxPZ7KHj1vOjwefzschKaibahJAoxZyyqq40yrpQ+zH0dE0xKYo+mqfxpiyaS1IO4cML8qNJncj1vVbT0moqgPSVF25dZxNDDn58dMHpnu5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516610; c=relaxed/simple;
	bh=YiszmNz7RV9b0dmb/0wgUJH4gIiA+io01rRIvTzgYFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcvB/6BJzCdKobUFPq4KNQCv2AgtxJOFOsXmO1tdhy900/Cv02XS6+Yv3NaNzb7vRk8lDqU9on7XCR5ETlTlEQPVyvMo4voboWtQ43Dv20QQNa08gEvL5ydLJ16d0NcZ/OHHmq32L5yj6WTF+iQFm5fm94KFoBtsxq86KtbNTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy2i0Dxz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy2i0Dxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789516609; x=1821052609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YiszmNz7RV9b0dmb/0wgUJH4gIiA+io01rRIvTzgYFQ=;
  b=Xy2i0DxzSIYIUYytfbbqJ8OotcwGfmgey7soIVhFORQ+psf22P4aDoWP
   olQT8x3YEIk4ViotyTLFMhOx40iYFQV2tlwteb27ucEbO3RLvPC6cAgWg
   KMVEmUyoqrLR1woU5w+Vr1//5F4xIG2MJ5b4OJ7ZqHXRC+bTbb0e9bPgK
   cll2E1jqBn3nUExkka9oRc16qK8/PUUHKPXf61NO8W13f8a0MW4g6vyOt
   RBtyK9Uqg7t5hmJISo+GLDdqiwf4U/aszKKsS/8VgnQ30swo8yueXQdCQ
   VghdK9iVLY/CjmK0Y5+uxGJF3PVxJwtz/rZ08EKNZuBJCBwe6KbNc/AiD
   Q==;
X-CSE-ConnectionGUID: OGH27k96RKKBwM0kCHkykg==
X-CSE-MsgGUID: YHJOT1glTIy0YOCyg9MrXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89735886"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89735886"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:56:48 -0700
X-CSE-ConnectionGUID: pJJzE+9uT4e9egIodkmW8A==
X-CSE-MsgGUID: XR6TgAxiRzKsjMTjrqeoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277294036"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 16:56:46 -0700
From: Kris Pan <kris.pan@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kris Pan <kris.pan@intel.com>,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	atomasov@redhat.com,
	oliver.sang@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: iterate online nodes in skb_defer_free_flush()
Date: Wed, 16 Sep 2026 07:53:35 +0800
Message-ID: <20260915235335.3580993-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915164008.4f65ddc4@kernel.org>
References: <20260911020438.3502801-1-kris.pan@intel.com> <20260911023804.3503989-1-kris.pan@intel.com> <20260915164008.4f65ddc4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right, the node-offline race is real.  I'll fix it in a v3 so the flush
doesn't depend on node_online_map, e.g. a per-CPU mask of pending nodes
set by the producer and drained by the flush.

Thanks.
