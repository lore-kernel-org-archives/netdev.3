Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3D368D79;
	Mon, 21 Sep 2026 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972030; cv=none; b=ZZgIc0WKjaF1h8dgXmhwySNUlGtyHSMgDv0MPacR/egqQec3x3MB5Il6vfk+PQcEl7T9pZumpAl1tHmzM+M6h0Ds7LRMpgeEf0CeF1g2TNZjhyzhqkPxstFvhdHQrCnLPNOxzE9Hs9nkMJzC/IHltDOOoBIuTN/YybY//io2Xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972030; c=relaxed/simple;
	bh=h7rAnpRUWdoFO9wRV6G8lhzzaCAWMSLGFjO1ZqeZDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXDU5haSkC1HW5ancriCjW5cQKHIzkEVYr1GVKP9PE2Xj8qU3D7oFo5rAvpcSKXJNoAVVDwr/Ww1CiIQ/RA2QapQ41KMjtqKWBuOCL3k578v/uyi5a5i8Mgv2HqA5EpwaGPJiOcWC7nNK96ovDj0JnR0EdWJKqCs0MLci+bfcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dbxYBTGj; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="dbxYBTGj"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e86eb585;
	Mon, 21 Sep 2026 14:27:00 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	"Denis V . Lunev" <den@openvz.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: neighbour: Serialize proxy timer teardown
Date: Mon, 21 Sep 2026 14:26:50 +0800
Message-Id: <20260921062650.22461-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918231954.4049829-1-kuniyu@google.com>
References: <20260914075604.120183-1-runyu.xiao@seu.edu.cn> <20260918231954.4049829-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c2a57e9903a1kunm49c0ba5e353f7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU5JVh5OTR5MHkwfTx5MGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=dbxYBTGjUK2E4uabB6gnW5eRe7l/mpAmFs8w2Mh6zue8IBR+isTrOh++Xkt4DFpH4GwvXiGnLMXWRQSFaj8FfUGwpRDf+bk8fqX3ZBB44CECSMUDcK9/73HUP34w2XeWy66wFNabAjbizxoBmtBXuWz0ZAthE/gZ/hQrI46NOtc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=uHyHVs2p2BeM204OzQEYRrR5F0lBaEiaKwvTaTbBE4Q=;
	h=date:mime-version:subject:message-id:from;

Hi,

Thanks for reviewing this.

On Mon, 14 Sep 2026, Runyu Xiao wrote:

> A controlled QEMU test with explicit 5 ms schedule injection reproduced
> the orphaned queue state on the unfixed kernel and did not reproduce it
> with this change. Natural-load runs reached both paths but did not
> trigger the narrow race.

Could you provide the repro ?

The reproducer uses an x86_64 QEMU guest with three network namespaces and
veth pairs. Proxy ARP and IP forwarding are enabled on the guest, and an
AF_PACKET helper sends valid broadcast ARP requests from a source namespace
through the proxy-ARP ingress interface. The same interface is repeatedly
brought down and up while the requests are being sent.

For the deterministic run, I built the baseline and fixed kernels from the
same source and temporarily enabled C0109_POC instrumentation. It adds a
5 ms delay at both of these points:

  - immediately before arp_process() calls pneigh_enqueue();
  - after __neigh_ifdown() observes an empty proxy queue and immediately
    before timer_delete_sync().

The guest was run with two vCPUs and 2 GiB of memory. The trigger performed
300 down/up cycles while sending the ARP requests. The test-only oracle
reported a failure when __neigh_ifdown() completed with proxy_queue non-empty
and proxy_timer not pending.

With the unfixed kernel, the run reached both paths and reported the oracle
772 times. With the fixed kernel, the same workload reached both paths but
reported the oracle zero times. The natural-load runs also reached both
paths, but did not hit the narrow interleaving without the temporary delay.
The delay is only schedule amplification for this race; it is not a claim
that a third-party workload triggers it frequently in normal operation.

> Isn't is resolved by simply checking if dev is down here ?

A check of the device state in pneigh_enqueue() alone does not serialize the
queue insertion with the purge, empty check, and timer deletion. An enqueue
can pass that check while the device is still up, then be delayed until
after __neigh_ifdown() has observed an empty queue and before it deletes the
timer. The newly inserted skb would still be left without a timer.

There is also a second teardown path to consider. __neigh_ifdown() is used
by neigh_carrier_down(), where the device can remain administratively up and
netif_running() can still be true. The proxy_timer_lock serializes both the
per-device and carrier-down teardown paths with proxy queue insertion and
timer rearming. The timer callback does not take this lock, so
timer_delete_sync() can still wait for an in-flight callback without a lock
dependency.

I will include a shorter version of these reproduction details in v2's
commit message and can provide the complete QEMU harness if needed.

Regards,
Runyu
