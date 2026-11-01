Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572404;
	b=auuJBqK4ttKygpbQSbeo1/I7XGnPgKlvTYITqh/394Lc9IQpOX2btFv8l2/jtgaAurJO
	 eHDWZjkzFOc51aeC8ffjUzE9Qdu1Y/1I3nk84HUfib/qOu14K7958vdekea/8C0mUrRnQ
	 r0muAqoUP5N7QzZ0nusMGsw0Tm6LflpzdCqQO8BikkZDYK5h3FHzc6P5zvRRVKk153mu/
	 ojY3G/uaCmMv+01+NDQl2UbQZNBjiQ4+S4lVvOo1DPRXj+MunHEV9viG47qTzgXACU0vR
	 11/Qj4FsXqYQaVCL9XMk2G3HwSlsT1gqnhl7nzhTTmGK0fb3Fe9qtmTwePZP2M9FeTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572404;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KONiOIrdfoPz6BqkGYOxnCQLoYcI6qbk+C9TKZZq4iA=;
	b=xZKf1CJDvbEydz+OxMKCKKYIl7LQWSm5APvv5OitRn2KX25WnZoR52asQBADskXSe90w
	 qfVz0dUxgzXOII0zruhreprI+jC2oDUa26qSsXDtVRJywIZukLm5cfhtZXFSZRuPtQegI
	 duUhDk0bAix19PK6oN+gTXM2MOLn9FomfpvFyypa9RBHaGxSmf1YiRMkM2Y1BEuN9Ik39
	 ddjWklxj+L7gyuvRjufRegjFKagOPtKMOJrR/gpa7TeZ+H6N8/ei3BdDfz3lP+mhylHIu
	 xUtMwAId+O7nwEPU9sVPcoTfLYTNzBPTJBYX7dME7RP5BKmvCREHNQL0aWPXf+MgQlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDTCsHoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431B606A330
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDTCsHoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB101F00A18;
	Sun,  1 Nov 2026 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572403;
	bh=KONiOIrdfoPz6BqkGYOxnCQLoYcI6qbk+C9TKZZq4iA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZDTCsHoTSD+ZOHcI5eYuM7vHqvkpja4t1LpQ60AswO4WTWqGnLpN+dt4fF8MhI7QH
	 i8plWw5mYecJkmIr1ORvF4K4kGUaTnANUASbO6maVYWWlXIBMxOdR6pA/gUoUosQ+7
	 yU34g1f/5VpkdeudF68P2hQPoVEEZBVyZYJAKkp8xLKfZc1zI1j+7yx6FZWH3mcja/
	 /Fw+iAao9T/LrRqrwt7hF7YVrTMyk3iuZ8DpompSgkdCJvsgQi5QH66nMYC2HxDFPS
	 t55idNQ6o/qPh/vyqg9zA+YK2M79vK+T5KeK0bLB+EVs9QRL5p0/+gWpbfsDY+4VKx
	 zWTGkrxOLtG+g==
Subject: Re: [net PATCH 13/13] fbnic: Disable PTP completions during the Tx
 force-flush
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:23 +0000
Message-ID: <179357240309.3131.2127000180885176175@kernel.org>
In-Reply-To:
 <179322345631.40667.15699365218498548850.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322345631.40667.15699365218498548850.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The Fixes: tag names the wrong commit.

--

fbnic: Disable PTP completions during the Tx force-flush

When the Tx queues fail to go idle, fbnic_tx_flush() sets only
FBNIC_TMI_DROP_CTRL_EN. Timestamped frames are then dropped while their
PTP completions are still forwarded to the host. This patch also sets
FBNIC_TMI_DROP_CTRL_CMPL_DIS during the flush so those completions are
drained, and clears both bits in fbnic_tx_flush_off().

> Fixes: 40bf06a160a1 ("eth: fbnic: Implement Tx queue alloc/start/stop/free")

[Severity: Low]
Is this the right commit for the Fixes tag?

40bf06a160a1 added fbnic_tx_flush(), fbnic_tx_flush_off() and
fbnic_wait_all_queues_idle(). Its commit message says it has "No actual
datapath / packet handling here, yet". At that point the driver never
asked the hardware for Tx timestamp completions.

The symptom in the commit message comes from fbnic_clean_tsq() in
fbnic_txrx.c:

	if (head == ring->tail) {
		if (unlikely(net_ratelimit()))
			netdev_err(nv->napi.dev,
				   "Tx timestamp without matching packet\n");
		return;
	}

git blame shows that this code was added later by:

  ad3d9f8bc66c ("eth: fbnic: add TX packets timestamping support")

That commit also added the request for Tx timestamp completions.

So the leaked completion can't happen on a tree that has 40bf06a160a1 but
not ad3d9f8bc66c. ad3d9f8bc66c is not in v6.12, but v6.12.y already has
the flush code.

Stable tooling that relies on the current tag could pick this patch for
6.12.y, where the problem can't occur.

Should the tag name ad3d9f8bc66c instead, or include it as a second
Fixes tag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
