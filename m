Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265852;
	b=ZdOxfk/Eub9q88q/4VCrU4XyRLG2sOkOZf9mPcCKlDLqrj667OdvbBPQLi0zrp4D6yMn
	 UENBgiZpD1UE20cTsYy884kso22yBuR7ug/M8QS+rbW88CmyVfLhVTT1vugh/5ImmAWwR
	 S3Z197h3a3SGQ+JSnSV0SB0Iu3jdKOq9Bw4Znb+82aWheBwfBzwFzVt3CB08h9nUyeyR/
	 zhC644+2h0bsBaNWyFUWnxl8l6v9ZBnvT6uqw+znXMJF2pjOwO0V7Qyj6ZhMYk2FBB5rq
	 JL4prsUia3nX6qOhixAqyiXp8dPJikBZ+WkwjMqGXyDO1xhc/Zdvx1pQnEdq10snQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265852;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HaJlroY9pRtUeNSxJxKIPMUGSA6RCeyCrCa+Q3bzSpM=;
	b=HQUJef1STnX81YYg+OKbxvtOzy1cpw1i2zMjTnMhI/d4N0Jka2tE6srn1IAYc4Ao9Pzt
	 Yo055QOMi8AYVMkTb57Q1ltBzD0LeWQGJkjw3USVtHhJqQqvb7h+9GZF/s4TpE0LLlw0Z
	 d6jaPgHtwz1AxYP3oElAjmeqzZsRHY/4N4KiBSY+sS+VgUQn4eQMWg8XnLfJsqaLGAvib
	 9f0QsewxFS6TTjkdvkSmPZVovph+ivKn4Q4XHkbvKvz85KCdcfGYkFUaS6F+PO+sgEx7u
	 plWUJG1P81EZGxVLtKUH9unsOom9CZoDj0HkHn3Ovkrp8ReoK7MKxqQ6V82Qy7DIBBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHhVOo0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4988606A321;
	Mon,  9 Nov 2026 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHhVOo0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9A31F0089F;
	Mon,  9 Nov 2026 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265851;
	bh=HaJlroY9pRtUeNSxJxKIPMUGSA6RCeyCrCa+Q3bzSpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UHhVOo0ePWYpZuMrpdb6wL5i3t/fpsYRdT6OtOCqusadMQrFgm7Ypi6GqwhILyqrB
	 gDN1S3VEe7ZhiU78LMeVm+cpO8MUj1LK11fbMmlTfiYp2Y4iihzlXVpfUylVlXHuU9
	 ULS90T8eJV+UcW5Er9Bnx5TpVk8dhCKkKPv2h5LMPSbeCG6Eq0W67i2/vqKD8mvkSp
	 eYIA1KwRqmrp2ZcZB8Ck+ultKy2iuU+kEIpPAsRypBDk9+s7MoKlXE+0faApuZSM+3
	 FC0XovwDJZZkEHIg7EbXnslPIkFiU3ZMEeMqCbKAkUtJWfFT3y7b1hZmGuKTNo41Ab
	 JmP6IzKM+bZRQ==
Date: Mon, 9 Nov 2026 15:10:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] net/sched: revalidate the sleeping-root lock in timers
Message-ID: <20261109151040.050550ba@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20261030042312.74363-1-kylebot@openai.com>
References: <20261030042312.74363-1-kylebot@openai.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 21:23:12 -0700 Kyle Zeng wrote:
> Autonomous qdisc timers select their lock through qdisc_sleeping.
> dev_graft_qdisc() changes that pointer while holding the previous root's
> lock, but a timer may have read the old pointer before the graft and only
> acquire its lock afterwards. RCU keeps the old qdisc alive; it does not
> make that lock protect the replacement hierarchy.
> 
> For example, a backlogged MQ child retained by an outstanding filter
> request can be detached and regrafted at the same parent. An SFQ timer
> that selected the interim root can then rehash its queues under that
> obsolete lock while tbf_graft() resets the SFQ under the current root's
> lock. This corrupts skb lists and SFQ slot state.
> 
> Add an RCU-side helper which acquires the sleeping-root lock, checks
> that the root is still current, and retries if it changed. Once the
> check succeeds, dev_graft_qdisc() cannot replace the root until the
> callback releases its lock. Use it in the SFQ, RED, PIE, FQ-PIE and
> DualPI2 timers.
> 
> Route default-qdisc attachment and scheduler shutdown through
> dev_graft_qdisc() as well, so live sleeping-root publications follow
> the same locking protocol.

Clashiko suggests the fix is incomplete:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030042312.74363-1-kylebot@openai.com
-- 
pw-bot: cr
