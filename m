Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022E37FF5C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277497; cv=none; b=gDCrHsAvLiWVrEIuUbTs35xmnxRXIbJEe8SLooH2/rXiHJeJYWulRVVaj8YLMV6t7Jgzm3mkCZs7l2ln0yVsNoIljd22Ku/v5l+ADgEWps1uPQv5L6iYpetJVC2B7ZweH27pF5TNv9Y4LHYWlDJZwpSJ1A6Do9+LGBWE4UwC3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277497; c=relaxed/simple;
	bh=5nBR6qO3iFaPNwzgcFqzJ733it/oV3Uk+zssr2Xpu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSgyp2ewJGEMzhTToEQKvkVN5oUq02c/Q1rlwz7Tg1HFi7Aa6Ux845QkeiMqb+FX88NMGPT16LJmIvHfQ7KjKfmlT3VoMECut9tqMgJ+oEjLzgvHva5z9+rj7d8RTnVZg4K+AcweN04PIe/BbaqqJGk6NKIWqQyTvC05E5os2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PW49uuzP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PW49uuzP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777277494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbrfRO/EVFZFvsXK5E0qgavDiLdR6y/50L1LjhZpdMk=;
	b=PW49uuzPjkpMlH8iceevMt8YLcYqHwTBKm8dQA6sbsuursjgPRb/sB/2jFwymZLd7qysHH
	IJonzc2NkHk4grdnOTix9Xb2YXwoADM/m2cyJjRXMOoHvqbpeOire5ZzB3+nJjwiJcw3IO
	+sq1QPzCKyhuxmqvhWrODIB2Q/RPbng=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH nf 2/2] netfilter: flowtable: fix inline pppoe encapsulation in xmit path
Date: Mon, 27 Apr 2026 16:11:16 +0800
Message-ID: <20260427081125.2157166-1-qingfang.deng@linux.dev>
In-Reply-To: <20260424100759.534113-2-pablo@netfilter.org>
References: <20260424100759.534113-1-pablo@netfilter.org> <20260424100759.534113-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 24 Apr 2026 12:07:59 +0200, Pablo Neira Ayuso wrote:
> Address two issues in the inline pppoe encapsulation:
>
> - Add needs_gso_segment flag to segment PPPoE packets in software
>   given that there is no GSO support for this.

FYI, there is a pending PPPoE GSO patch:

https://lore.kernel.org/netdev/20260326081127.61229-1-dqfext@gmail.com/

Regards,
Qingfang
