Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32054763;
	Tue, 11 Aug 2026 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411021; cv=none; b=RKdu9W5FqSSwpSn008ppaZUTosxgzqxMaOdv2DphH7+m5yOrd8nF7IOpBMQ6Tk/PkLbpFoUz+TaIu/o38GUQeghrBHSWwvlF4UvlZw3jL6uBD3k1lS4BE/pWNrLThtOOH4F9n61g1g2vHmBDmUGvUCoDfo+cumdBpbn0QhB8ZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411021; c=relaxed/simple;
	bh=cIfvWk2+//tXEfg/koeKKwVF+yYdo1ghLt2GJJpIA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oULY2wNZCgxar9MSEu80LV0HYZwRxqgmR6KjArEeRpbvafxa3RNIYQXpuIJEwM6JZ8p2Lsl4/iPzzAVPXtPbt9vOFt+R9a5JNg75o7rbK8AeXAz05r6VU5UcQWjPhHyCyW4Lt/0uVYkLJ/vBultwUWk+dLzpACuapEv+IL75bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJFg+G8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJFg+G8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772CA1F000E9;
	Tue, 11 Aug 2026 01:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411019;
	bh=cIfvWk2+//tXEfg/koeKKwVF+yYdo1ghLt2GJJpIA1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IJFg+G8vdM7DMdLlYkq89R8VhCKr4DlOjKku+vBTZIqTXOe4AiJt71ZZmvI8VF/7y
	 ysNdKdNtr80PDpNVjOR5EgDjLMfAw3F76bBpE9mi2isCRY4iHvBVVX628EsdJvPqrl
	 yjmF6XOwKSPVBk3B7jBVwL60oKBk+zn96pmNm+BBN59kiaBM462eyW9zAPH2ML7Oz1
	 CH4VEP6mw/PgRPfMXh7DhxohPOy4CczAisnDYIPZJ8BbfwIyoORMiDGJS6VBRkGKyg
	 C+tE94LiUQdrnjNwA++7okVDrADBe6IMEmzJ5MWllO1C4WBrmc8Biz5ZixUqfSMC2R
	 c+6nEj642+TKQ==
Date: Mon, 10 Aug 2026 18:16:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v7 net-next 0/9] Switch support
Message-ID: <20260810181658.3135ab41@kernel.org>
In-Reply-To: <20260804104706.120996-1-rkannoth@marvell.com>
References: <20260804104706.120996-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 16:16:57 +0530 Ratheesh Kannoth wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.

Should we read your silence as "all remaining netdev-ai reports are
false positives"?
