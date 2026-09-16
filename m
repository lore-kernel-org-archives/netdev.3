Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F6369D47;
	Wed, 16 Sep 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521252; cv=none; b=SS/qdjmMdbTROQHkhAiMYL6QOyY+wJ+MrK5ao2vbRFJixL/stq07Kuqzv3yOtzO3+0gvl/Wztol/jbBNb6fg2l1w7CR+2e7AkdK3Q8qYRhmBu/dtXTyBmbGs4UCLoOxwLMn0Qn1XSqqgxRHNNDXSLBVo+cvxvIdv5ON9vKJ3fdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521252; c=relaxed/simple;
	bh=tBheM4JGtJ9K1oucjI8P8LfsEDItEbbafAFcpLlBoHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEjbSDp1BL6XqOPa+/bjhp+C5hW/H6dyGtaHeB0f5/NIcvRizw9szj2vx88iI08d9QZu1BkS8L7zAgGcZb4OoiT8KtK9q+RSDjf9KhNK/u29atI4nDZPyyFwxfhqD+1//s3cAyA+ew129geiY4JHQJUtGOQVVdldydsMkwHn3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFfd7a3v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFfd7a3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789521251; x=1821057251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBheM4JGtJ9K1oucjI8P8LfsEDItEbbafAFcpLlBoHY=;
  b=HFfd7a3vLEP0YLd9xsYyF2E8QBeB1gp5zSMMSwjbaRHjXjWXzzO2izUl
   HXJ3+pYItrSqIET6WOBON+g2Kw0p9jGCaEDr9LoGBbKOpdQLjU0NU957V
   iIS1be9M4yEwDbhzTRFP7HQGVBkaxKS5SH4DfSe4qL8Xwzzl3FwFTTqxI
   t/TjBOLdQhVM0s0nD4LXlXmm4jZtPQSZLV/AI2uNxpUlBIJlXjGJCL+Mt
   ZqDNdn7+CyZvxbr/cFs0tJ2RnmPadhRiyV60Qgy/4FGoSf6ud448Tvszf
   gFdRxeV23CZXnkqo2/b7GgjixstxiTbpMMy+8Me972Fcz9uVa5iwK+glR
   A==;
X-CSE-ConnectionGUID: bBF2OnhHQc21IHOCd4oHDQ==
X-CSE-MsgGUID: lIqSZkRlSuyUuKs4OSpUcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89833994"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89833994"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:14:11 -0700
X-CSE-ConnectionGUID: lXHR0+zcSaeunsmIbjcEFQ==
X-CSE-MsgGUID: JMeVm+KqRgCbXaVxFbM/Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269493895"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 18:14:07 -0700
From: Kris Pan <kris.pan@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kris Pan <kris.pan@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atomasov@redhat.com,
	oliver.sang@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: iterate online nodes in skb_defer_free_flush()
Date: Wed, 16 Sep 2026 09:10:57 +0800
Message-ID: <20260916011057.3614184-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJLvByHKcsjcNnCRjCE153TttYJfgmungFKWNhruwZD9w@mail.gmail.com>
References: <20260916003430.3612956-1-kris.pan@intel.com> <CANn89iJLvByHKcsjcNnCRjCE153TttYJfgmungFKWNhruwZD9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review and the patch, Eric.

Splitting it makes sense: the dev_cpu_dead() drain is a real pre-existing
bug fix for net, and the for_each_online_node() one-liner can go to
net-next afterwards.  I'll drop this v3 and wait for your net patch, then
send the one-liner.

Thanks,
Kris
