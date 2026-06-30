Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1419DF4F;
	Tue, 30 Jun 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845566; cv=none; b=AHuz2j8Y3nr/nxTngJcydXbWThAYP7um+uLpwX6V8cgNc1X6xo72+OuMmsQgNcYSDRtbvicYl+3G9RCjc0oE2aULl0YnlJDY5dlwQaeCzqD44txJFSem7EzXjry8k8CaTWFbEljOm5+JJYAUle+znpQC/n0YScDRLqFTFGnf5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845566; c=relaxed/simple;
	bh=vXoGTXa7yOfZ+Uz4oCc9QsXVWOkaOXUUNBli4k+0M40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IubVZQzPD60PdQQhB8WUHugAEmoMqABtaC5Px44tAEUc2neZaW+obMU28+gQwwLdk4YddQqVR7xo7ia5UjpcixieXvnYRqx4MSiTvm3ETUDrMuPXOJrB/jNuAQn36mtP2e20P0dBZk3tnbUz/Uh+MuaoIPNqYclmSpLN+iAo/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzjve3ZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzjve3ZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E41F000E9;
	Tue, 30 Jun 2026 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782845565;
	bh=/R5x4upYXKuPYhHztTLUT8qvKxBK3EbNELQaayF3Enk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nzjve3ZHUyRD/VQjkWpvhA0rcAZLfTckC3CrloarflxPntChqVgmnD4GoaQzk6oUn
	 b78YspNj/IvPScnlYiiA0Tgs40+pkLRcSi1WQVM6zug3BFmWZTWfs026de46HG7md1
	 qptuWIcvOBoU3FX/1cbERAGSqVD9r/e5YMqfYp6ZBARJcZzNKM2spaJCTFdT1rh2If
	 foPCUYUjqz5vgi3PDi9z9SGx908msKzGc0Uc0unF1DHYw5cYJvCXtkur3Ch/EKQLJE
	 dWtd0NE+ySYbBvt441w3du2Uw9Okrpchhaw9JeQDkBO2PaWWXO973qPgGQa4er0K3W
	 RQPE0I8n2YVIQ==
Date: Tue, 30 Jun 2026 11:52:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net-next 0/9] Switch support
Message-ID: <20260630115243.19cd0b4e@kernel.org>
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 08:17:06 +0530 Ratheesh Kannoth wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.

There's a number of allocations here which are missing a NULL check.

I'm sure sashiko will also have semi-infinite number of complaints,
so please check that yourself.
-- 
pw-bot: cr
