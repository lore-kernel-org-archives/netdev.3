Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D153EEAC1;
	Mon, 17 Aug 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008959; cv=none; b=hwdnxcs+5umXu8zpHvsGuGgZs8ISVgykIzXkDCSU+44fCiuMenEEpGTL6lRmNUj3V9UJDJIAYexpWT+johywvfKVWcC6cmSq9o/W7aTgd3kIQcnNraG6+NqI1IRADpbWzuIgk5xsCmMp+Eagn0WYJ1Ryk3/OOPraeljMzvlajBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008959; c=relaxed/simple;
	bh=MNeoyMfln8dtva1+V2QY4UWbWjuqGzNKjvRAnwkkgro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgqr56Crx5ub9OJ249pgTyYz/zHICTc5I3UbD3xRGpEcF9e4915G4VQpfpkwZhgG/6pTx97X8KsKNm+SngX/smMMbYdy3p+IXs2coDruEE0CsTgP3sXL7QzfJkiAkNO43s6XJcMyTMmssZxUJL+Ni4RrLDu8RBunaSVR5ly3u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs5FZ+Bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs5FZ+Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0821F000E9;
	Mon, 17 Aug 2026 23:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008958;
	bh=P8T0P09mLXibmVR6w5z3HjTl1Gn9OVrsCaX80P6nwq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cs5FZ+BqiiA1CWwTeWLPdK2R5X729Uke46k04RUVl370mt2DMp/D0K3W5o8ACA/5W
	 PGUjR+u6yYwZgp2/Sq7tGuxH9bZ2rtXDnjAkvM4q9VRtMi41Aoz1wAFnadNmO9Bu/i
	 sXJyUJmDkcH5KEk7c5u33JJUSp6iBk3OgWWB42/1B8Sz8f1JNFSHzfO/lcmFQCpET+
	 9it/WwKqT3jv7jDv4mTXS7946woAiYTosVAndQjYrAe6AItpN9syYWDyVcYRwm9uKp
	 QhjCAxDvql5+Q50bHXzQZx5Hm3cfAiQat30JgavGJTJUydqTBz987PGLK9T88U9Ddx
	 kRo6a3UNf/4IQ==
Date: Mon, 17 Aug 2026 16:22:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <nshettyj@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Satheesh Paul
 <psatheesh@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Add mailbox to read default
 MCAM entry
Message-ID: <20260817162236.181d37dc@kernel.org>
In-Reply-To: <20260812053523.3329305-1-nshettyj@marvell.com>
References: <20260812053523.3329305-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 11:05:22 +0530 nshettyj@marvell.com wrote:
> From: Satheesh Paul <psatheesh@marvell.com>
> 
> Add support for reading the default unicast MCAM
> rule associated with a NIX LF on non-CN20K silicon.

Applied, thanks
-- 
pw-bot: accept
