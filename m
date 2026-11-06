Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973728;
	b=ZMTACihwKhGF+1k9h7/bnuqcerWjRHbAaYKlVnB9u1/YR1RpFrwIiTcWbDY/HNYfMV7S
	 acYKKYnbBKGYSfdICvSKoX2l7jBg83lBPBgC4JL6KG2T8Bug0BQilKl0RKM5V+P1YLGQP
	 5RCTTD8cr29NuguvE2y9V8px/XI9Hx1C6BdXYCC+WP6ERpYCzpQWelLFgefSsB9fi1u36
	 nSjkIV8m2XOHQ8x4qAXR4BT0oTOdt2BLFpKoNMI4AN9FF3v6gOc+gan2c9vf3UJhcFXy1
	 fWj1MAh7/IHfaOnCvA5Bd57CdCz7uhHzU+Jb4LUx9lfsI6ez/BoGUCmKkWRjD0urK/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973728;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=n2GWGOm2gRBP1S4H8dnUEM13lExO/Oa8j8HtH41e6t4=;
	b=o39zw8Shhl1ugnxik15VsRGwUmhqI9hwUPgfSwwSKfz9dSrHr5lm6sdjEKbSYPU6dAIe
	 stUU9C8LtkFbvqZr0sHOmuKq49pl7NyPsK9dR3I0UdRTB6ZWhlZYu2AwbwxpYWtFMUBQS
	 gvEUH8Cuv+eX/os0Gk62KLnfqJSAiYWZ35q0BEFVCUH6MAC/Qgft8Kgbx3V4wrO55mpU/
	 kU32zUn31ZNIOjmEXmME7nOYBtNfL+coLrtwOAQv0ITpVA/xW9iLmO+dBI0nIyOCLiszW
	 W75R1jK+8N5TBl9TZifLb6Swy/MuM4lrWmABQyRB9K59P6EHw3/e3bXuoTroQnxJBnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ENbe1qHP;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76118606A32C;
	Fri,  6 Nov 2026 14:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76118606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ENbe1qHP
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41655A159C;
	Fri, 06 Nov 2026 15:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793973723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n2GWGOm2gRBP1S4H8dnUEM13lExO/Oa8j8HtH41e6t4=;
	b=ENbe1qHPjmyWso7Zbzqw8GXA5zGDFqL2IOa2nLrqD/XtKBM75bDJiZhnq85xOMPypR/YPc
	yDuC9obwS2zBdDIR6goX0yw+FNjaLZxrLTf5WNPzL99BI5h/wkIBVHBIYv+w5fLdR/Cjuh
	WOaAsAvhPQ9YYpMcsYIJRRGTC5xKAimn0DbP5i/Pls9CYfuEA7TkwXU2SzlOgdWBVn16Zj
	6e2Hnj9pfcpXx0c6vRkQoYJRgUzdOI3GF28ifDyKQ5dynxsP38e9HfDx7C3D4luMNBc3Xe
	dlr2SOYZavCQCVwgndrtza29fARiKvd3wHWwwOjcwlujejWgwN62bPWP6gq/Eg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 06 Nov 2026 15:02:00 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Vadluri Mukunda <vmukunda@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sunil Goutham
 <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suman Ghosh
 <sumang@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-af: skip NPC_AF_MATCH_STATX access on
 cn20k
In-Reply-To: <20261103091831.914393-1-vmukunda@marvell.com>
References: <20261103091831.914393-1-vmukunda@marvell.com>
Message-ID: <7582ad3c94a6412f8c570ddef4cfb3a1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vadluri

On 3.11.2026 10:18, Vadluri Mukunda wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> NPC_AF_MATCH_STATX is not present on cn20k silicon, and cn20k does
> not set up an RX miss action counter. Two paths still access it:
> the npc_delete_flow mailbox, which reads the counter of the deleted
> rule, and the rx_miss_act_stats debugfs file, which would read
> counter 0. Avoid the access on cn20k. Counter support for cn20k is
> left for later.
> 
> Found by code inspection. The issue was not triggered on hardware.
> Compile tested only; not tested on real hardware.

What does the read do on cn20k, fault or just return garbage? If it
is only the latter, with the recent discussion about routing
non-critical fixes through net-next, this looks like net-next
material to me?

> 
> Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for 
> CN20K silicon")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Vadluri Mukunda <vmukunda@marvell.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
