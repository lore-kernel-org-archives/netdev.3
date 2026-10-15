Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8948551D;
	Thu, 15 Oct 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054619; cv=none; b=gQW96NV0mVcSfrXvQETaJwYlvZer8h/Np9CvtGo8tVyz6KI11teq3obPfTQkgAvqoXKfsDtIHkEqmlq+BT8OWWShbyKb1VxWzWdHHeONPYUxlce/hEVN8nWGvyMehOlrEiewqBGHqIvsuwqFIkq4N4PkzXL71qgucA+ziYF60/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054619; c=relaxed/simple;
	bh=Z8N8NgeSBvvlK4Sf3zvGZG6zrnRFc0U6EN7ecs7Aqi0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j1/7Fn70GvVlY62Dx3SzV136WxibpcRAzaGt9oMWoYrO8rWSuhE656midbT4Ngs7nEk8ygoPhUzTx/oy9HY7/8u2b9dWQb00n6qRvvRW/K8GMbgA5Z6lYb55YbQyjuRnlf5+8s0H3UFGgV0+zDr7rOYZZUbBEv++svhzgxWchJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jLvkTqWc; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jLvkTqWc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 278B9A1595;
	Thu, 15 Oct 2026 10:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792054612; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LCIDmcWieddnF9CQQL9rThTyxbbGVha74X8K+RKD8Wg=;
	b=jLvkTqWcPtdwWj9TUgqaMJxZn051nvIwBwkBuw+dB54Hm5gfL2zdU2/zjb2XjCi+ZAmFzs
	qoQjDmipdFbIB97dJH3zcQvwb9CLt2qru0Oh/lhF53tlPVKK767gH1Xn3c5sDq1zjDQlgh
	Fuiqq91w14GCXQWfsaKA4yMrWybyp5PLAt6EU1t0SSmts520dCF4Yt0Jxgo5cEAtTLZ63K
	2Q8lVzrp1OQa0pTWm/yLfoxw4OiqAZ7HC4tY8w7zeZFIQ4LPO0mCFuwUIUsltbCnV2zimR
	RTD0svfzOQGLm4deHeKdjHwBvx3el/F6gLyTZPPuSLe8DDPKq9iRYt8otaEbDg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 10:56:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v5 8/8] net: bcmgenet: reassemble jumbo frames
 from status block fragments
In-Reply-To: <179198777861.434549.7442931129502036522@kernel.org>
References: <20261013-nb-genet-mtu-nn-v2-v5-8-076b6fc240be@tipi-net.de>
 <179198777861.434549.7442931129502036522@kernel.org>
Message-ID: <2a6ab59bcc44dee8db033e96e883fb7b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.10.2026 16:22, netdev-bot+sashiko@kernel.org wrote:

> [...]

> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch, but 
> this
> hunk touches the DIM accounting. Should ring->dim.packets and
> ring->dim.bytes be cumulative counters?

Yes. Neither has ever been cumulative, ring->dim.bytes is assigned the
same way two lines up. This patch only changes packets from a descriptor
count to a frame count. Another one for net.

> [...]
