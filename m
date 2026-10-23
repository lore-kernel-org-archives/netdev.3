Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731127;
	b=0rDF7jkB3L0PEqbnqFvLJ3TwSuZ/2qzQMnm0xy/QpSRCZEai8UsbJ44O56/J9ZdFCAYp
	 XNrHw5u1Zq2j8eZ5dUv+FQceZQAUjOAgQSW18gXih6yKr0OuWToocRCzxu3J4t1bIk4UR
	 MQqjUW2f34wAXQxfVx6XyJRdJWoyWBql2b8B8/ZK0/yc0rH5wy236dK43HcRabzBznyKa
	 ySGs9cTLmEb8dTbnlaY6vZTZ4nAP4obxWs1Ued23wtvHXSrnEvwUatog9Y3fx7isaTr1U
	 JQT2mfadAeZH2X5gyYh98akWrl5BrnCevA+PbLiBqXamFxBfpyd56/IUxKfBprNMGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731127;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D30nNXRjiP8TsE/AFA9HAZ4TRwgaJqNqJTiotkgZq6k=;
	b=m/JXG4FYVmMGiU7BT4WNn5+vCmtVOS8NalBjeoZElvv8FsNmtk+Jl1jfgatHgTUgYGkG
	 Hw+NJ7UXcSt2gqmRmE9bs+RlQNQYNLDasV1bEfBJBAhB+ZkBfbubUWdx5MFryNDNen/Bm
	 iRLncnaB8L+qLQi0oNPemYKm8gb2QDDMcrT/OBGITLHi/4MyfPCu0uGws12rvSICjkWfi
	 PvckZadtEqxFnZxpTLoznTuyxaQcxt1j19WNSVR5e8HROL7q7UkAmAouCsrCRP2S3OM+0
	 USmGXflr95JyooF7Qp92Q3V7PO4ErztZfsyvO4BPRiiX2vMY1KvWZbZ3J9hAwDFdPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di3O8UiG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C66606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Di3O8UiG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFA51F01825;
	Fri, 23 Oct 2026 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731126;
	bh=D30nNXRjiP8TsE/AFA9HAZ4TRwgaJqNqJTiotkgZq6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Di3O8UiGH0C/7ezn1q4ouy3VhjZgorTtXE6VHIt0tgFf73H8bvspJh63fmQxRDkSA
	 wWw3OMHBeED8MHBM+JVf5kCQU82ByFCHdeGBaboC1k+KtNo4FMSOlgumR0/atS4cui
	 6Lk5mPggW7ooNY0tDROOnVcwd2d4C6meXPjguASYmztXFEO4Ke9Yt5i2hEOgx83bWm
	 fQ0y7muPVhmaMwiUpOBPduUB2aCGdHe0J5mE/oS7TYWpL3PcG1otRTek9zISJNsNvV
	 i4q29w38VtOCrWJN+xCDhjWUVCYz4/2uxbtzkTTxgfRyTkW6yGGH7CFx+oQRtOenp3
	 YwRd5EnovhgRA==
Subject: Re: [PATCH net-next 07/15] net: skbuff: let skb_zerocopy() copy a
 short skb without head_frag
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:05 +0000
Message-ID: <179273112552.3134.3914409238087921235@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-7-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-7-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag points at the wrong commit, so stable kernels
  will not get this fix even though they still have a BUG() that an…

--

net: skbuff: let skb_zerocopy() copy a short skb without head_frag

This patch moves the !from->head_frag && !hlen check in skb_zerocopy()
below the small-payload skb_copy_bits() path. A short copy from an skb
without a head_frag, including a zero-length one, now succeeds. The
motivating case is an Open vSwitch OVS_PACKET_CMD_EXECUTE request doing
POP_ETH followed by USERSPACE, which ends up calling
skb_zerocopy(user_skb, skb, 0, 0).

Link: https://lore.kernel.org/all/179173804997.434549.4450793967361922984@kernel.org/

> That used to BUG(), and now the
> upcall fails and the packet is counted as lost, with a WARN on
> CONFIG_DEBUG_NET kernels.  OVS_PACKET_CMD_EXECUTE only needs
> CAP_NET_ADMIN in the user namespace that owns the network namespace,
> so with the openvswitch module loaded any user can do this from their
> own namespace.

[ ... ]

> Fixes: 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

433380f5ab8f only turned the existing BUG_ON() into an -EFAULT return.
It went in through net-next as part of the "net: skbuff: replace most
BUG_ON()s with error returns" series, with no Fixes: or Cc: stable tag,
so no stable tree has it.

The ordering problem is older than that. Before 433380f5ab8f,
skb_zerocopy() looked like this:

    BUG_ON(!from->head_frag && !hlen);

    /* dont bother with small payloads */
    if (len <= skb_tailroom(to))
        return skb_copy_bits(from, 0, skb_put(to, len), len);

The BUG_ON() has been in that spot since af2806f8f90a1 ("net: Export
skb_zerocopy() to zerocopy from one skb to another") in 2013.

On those kernels, the path in the commit message reaches the BUG_ON():

ovs_packet_cmd_execute()
  __dev_alloc_skb(NET_IP_ALIGN + len, GFP_KERNEL)   /* head_frag == 0 */
  ... POP_ETH leaves skb->len == 0 ...
  ovs_dp_upcall()
    queue_userspace_packet()
      skb_zerocopy(user_skb, skb, 0, 0)
        BUG_ON(!from->head_frag && !hlen)

With the current tag, stable tooling would only pick this up for trees
that already return -EFAULT. Wouldn't every stable tree without
433380f5ab8f keep a BUG() that a user can trigger from their own
namespace?

Should this carry Fixes: af2806f8f90a1 instead, or the OVS Ethernet
push/pop commit that made an empty-skb upcall reachable? It should also
probably have Cc: stable and go through net rather than net-next.

A stable backport would also need to move the old BUG_ON() below the
len <= skb_tailroom(to) return, since those trees don't have the
-EFAULT conversion.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
