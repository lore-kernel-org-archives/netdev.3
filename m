Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F33CAA2E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554918; cv=none; b=e5mB9+qjciuUS6FgMAUIG5RjXP6gf4a9Ab40N5R+pWs/lNpZmt5oXEJRjyjSP3KobiMtUxk0/py9RzvsLks2huSOwl7qeIiR9MItIDBRcTjCmrPQ9QqhzLvRUOxrXvWsvi8T3g8dX15NLJ2Q2CB2QHLxW2wOa6yBYrlBiN3kXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554918; c=relaxed/simple;
	bh=HGgvWm7/0UGfX/UQWmiozUVCbKqWz18zhSwakXhbxfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKzDfm04SLCe7T0F4sh0bdEH1Txd0l1Vo21eVdYX7wLlETgXNKxHg4e3iwGStAOc3HP0TSEYgtBUaNspHlVK9utyX95EubTKFKxQUedIDS1O5b/77kp9dTqWr9M+0TfX1wllklVFK0tlbVNf6rfAUHqt7JHHVEdUNVeKyWdmPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJDS7hex; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJDS7hex"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780554912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGgvWm7/0UGfX/UQWmiozUVCbKqWz18zhSwakXhbxfk=;
	b=HJDS7hex4P+bDQ4/ek//YftQRthJ2CT/jGi0AVnwRo54wmaNqMDqjDf8GGcJdG4iWmxPuc
	Q12LI9aPtB6El8WgKTFgYatMzclB9obVPjDcB40GPii+KSIp4PWswQO73/zmE5oieAGnr9
	1Q9Z0wHHMqsoJuSHvD4Dt97e+YJTnNg=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: flowtable: remove inline segmentation
Date: Thu,  4 Jun 2026 14:34:49 +0800
Message-ID: <20260604063452.1338-1-qingfang.deng@linux.dev>
In-Reply-To: <20260603025047.32839-1-qingfang.deng@linux.dev>
References: <20260603025047.32839-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Pablo,

AI says this may pass GSO packets directly to underlying drivers (as we
bypass the ppp interface) and corrupt their packet headers:

https://sashiko.dev/#/patchset/20260603025047.32839-1-qingfang.deng@linux.dev

Do I need to set skb->encapsulation like you did earlier?

Regards,
Qingfang
