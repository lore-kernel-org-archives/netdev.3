Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3892DA756;
	Mon,  3 Aug 2026 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796432; cv=none; b=GfeMzIaVd3M0rqUJICeAw+LNKVzjtw094MHQbOS7U75T2KVAompB2v907oE7G1qlWWjb7kNXcRsdWc5sQQceAUNP77/AIE4zrYDBUnoDRMTVr2dZl9jlchapF/tF4HfpJHcJ9LFyZ/03ithwLZ9UHq/04UDW8SkKDUp8Ps3MKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796432; c=relaxed/simple;
	bh=TShZzFxii34SU1iNvtiC2pWxeIEKDZ5nTuEAr8CoEJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+SYbxXbd8jt9Gt9h+09g5zcnLOCFJIqW9mZttSB9iXzyCRQ3zInA0oQ5sRY2CVy7PHCFPadEoKQJzDJQQfIOr9nOGfdsbS9VWPdgyGXCNert4xvzgMP8p9K+FcfnA3R8bvWiO2wVTwO6X9auB8Q7hN/c5y2MAp4qyeC8u9PxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vbd88ax5; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vbd88ax5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785796431; x=1817332431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TShZzFxii34SU1iNvtiC2pWxeIEKDZ5nTuEAr8CoEJY=;
  b=Vbd88ax5MYTNS4c6FM661Ywym9WWmYm9uYtDzB7akMjvIFXSRVZ0Wg6B
   c3ktdeA0yQjjnOYiS/DCseFIeSSf/US6e+ktYVKCQQYXO7isms+R0y02g
   PE6o7smdEF0AiglBcaCkxIZfnBSCEm1dzEjUzvROA8HDAXOkCmPUvPUlS
   JVrqfw9F+5dfZUBjcRVk4UZxKBaJhhav/6FfatIN9n2AiymonickBiGYD
   +VzS6bg8ajI9vqa6q3lO+a67dCBlMFnck+2ZQSxXAVzkEbNQdF5RDoH41
   ofEt5Kuzk+45dqHgM1DYJRyzqlK6Df5j7A3llXGny/qeCk0QFg8SmYImp
   Q==;
X-CSE-ConnectionGUID: O+j+rxpeQse4otd2Hd7A/Q==
X-CSE-MsgGUID: xaw3hMl/S0GWpFQs2uPM0Q==
X-IronPort-AV: E=Sophos;i="6.25,203,1779148800"; 
   d="scan'208";a="24795596"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 22:33:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:22278]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.68:2525] with esmtp (Farcaster)
 id 44dd6d21-1f63-4e06-a321-3040c4701093; Mon, 3 Aug 2026 22:33:51 +0000 (UTC)
X-Farcaster-Flow-ID: 44dd6d21-1f63-4e06-a321-3040c4701093
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 3 Aug 2026 22:33:51 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.59) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 3 Aug 2026 22:33:50 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <zcgao@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@google.com>, <linux-kernel@vger.kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()
Date: Mon, 3 Aug 2026 15:33:44 -0700
Message-ID: <20260803223344.91621-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260725030806.28135-1-zcgao@amazon.com>
References: <20260725030806.28135-1-zcgao@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Thanks for the review! I will try to come up with a packetdrill test
and send it to net-next.

Nathan
