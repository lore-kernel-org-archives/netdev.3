Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162774;
	b=GqdeF7B+CKRTOjO1W2YmUAdqgfWItd/mVtNe5B50KnihIKCzOvSnGbxUtr7xMQYKo4CL
	 TSKGUsV5vqI1rincMk5FAVf8lfn1M/4RM9vYjYntyj9+QLdPpGOmy/H3mbKD9CZpHSpqN
	 xtbLqkNK1/DYHvHV6q2aBiI57Fh16xDwzSWG/kmSKyg3n9vzHBH2HZSJmlotKOPhFWnsq
	 6t4W05dBhukbmqC3+tMIhizYCdud3TvupU9TWlS7ungCj+IMtdHBBidssGn4hqY50MF/h
	 nSzxkF8Ge6XJ5Q50/bYIiNBFDdQo1VH62/bw+d58M/TpzYIyiqLNJs4GKEs4PAlDsjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162774;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tMO6RdJ8myn7zOn0Ia6QWNQ8ehHaKLLcFycChGUT16I=;
	b=cteGhiVxKUgSF32+9iDDXpPvaHeFL5hNPyeAqOi2UfxOGJ2U5USalAFNqDNH8UiesGDR
	 aMSMRBVBHEmpBTyrKPIjTGu3N29YK659kWvmqvxGV9MQdr7bMj0afEVnu5gmkplIkV+Ka
	 MmVTVAPJTm+mb0rLmm86U30c3XlxpcNlZiaNgTia/Db4IdBxYyd+ruLj5wClm3vWn3pjJ
	 NL2L/Ya76T0uNRdXDORDGsRnJ863J4pk90wqPsia/xOswo2vGIdf5Hqwz1EqiMwhQU5Dj
	 aaqe5O2nTCaBdGTYiC+zUrdh5ZrVg7P9BslLvw9p11uUO5tJ/+XlqwccaveL4mppcQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc8i+3Dz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CEB606A323
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oc8i+3Dz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC771F008A1;
	Sun,  8 Nov 2026 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794162773;
	bh=tMO6RdJ8myn7zOn0Ia6QWNQ8ehHaKLLcFycChGUT16I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oc8i+3DzrXBFzNMttAcXqg+j5lnCaOWZV4z+AyeuqmtaEw5H38XaVvKuVYltGl0nH
	 y1EpGZXHutCZu2rcoYUcLsb4ArtdGY6KjhlR+ZeC7zhvkA6tsMiYBp4KwBJPdmFy0D
	 pJ08mn8Tzx22H/0BLZXS/5zq4IApQd6xJ+J7ofyFeyOKTOeSNPEVPNEry4cQlMWo5t
	 ygRB7LXRbwY3s6XWdwuOfk9iVYhgATSX6rsVX64caFH2tRWyywaq/Q1muFL3jKaGa/
	 RiDbnbwdneFJEfKEjkOeQvPN3kptLK0bgLFiutUpwI+ovJp/kAU2kFF1yAm4ncI7fe
	 tR5ELZ+o4hYuQ==
Subject:
 Re: [net PATCH 3/5] fbnic: Disable PTP completions during the Tx force-flush
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 08 Nov 2026 18:32:52 +0000
Message-ID: <179416277259.994134.8156444224751718462@kernel.org>
In-Reply-To: <179381515954.9644.10831265959574467679.stgit@ahduyck-xeon-server.home.arpa>
References: <179381515954.9644.10831265959574467679.stgit@ahduyck-xeon-server.home.arpa>
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

- [Low] The commit message understates what a leaked PTP completion can
  do.

--

fbnic: Disable PTP completions during the Tx force-flush

When the Tx queues fail to go idle, fbnic_tx_flush() sets only
FBNIC_TMI_DROP_CTRL_EN. That drops the packets but still forwards their
PTP completions to the host. This patch also sets
FBNIC_TMI_DROP_CTRL_CMPL_DIS during the flush, so those completions are
drained, and clears both bits in fbnic_tx_flush_off().

> The PTP completion path is governed by a separate bit in the same
> register. With only the drop enable set, a timestamped frame has its
> packet discarded while the matching completion is still forwarded to
> the host. fbnic_clean_tsq() then walks the ring with no packet left to
> match it against and reports "Tx timestamp without matching packet".

[Severity: Low]
The code change looks right. Is the impact described here complete,
though?

fbnic_clean_tsq() never checks which packet a type 1 completion belongs
to. It starts at ring->head (or *ts_head) and gives the timestamp to the
first skb that has FBNIC_XMIT_CB_TS set:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:fbnic_clean_tsq() {
    ...
	do {
		...
		if (head == ring->tail) {
			if (unlikely(net_ratelimit()))
				netdev_err(nv->napi.dev,
					   "Tx timestamp without matching packet\n");
			return;
		}
		...
	} while (!(FBNIC_XMIT_CB(skb)->flags & FBNIC_XMIT_CB_TS));
    ...
	skb_tstamp_tx(skb, &hwtstamp);
    ...
}

The head == ring->tail check is the only safeguard, and it only covers
an empty ring.

Before this patch, a completion left over from the flush could be
handled while a new timestamped skb was already pending. One possible
path:

fbnic_down()
  fbnic_wait_all_queues_idle() times out
    fbnic_tx_flush()   /* only DROP_CTRL_EN set */
  fbnic_flush()        /* Tx skbs freed */
fbnic_up()
  fbnic_enable()       /* TCQ enabled */
  fbnic_napi_enable()
  netif_tx_wake_all_queues()
    new TS skb posted
fbnic_clean_tcq()
  fbnic_clean_tsq()    /* stale completion */

In that case the new skb would get the stale hardware timestamp with no
warning, and ts_packets would still be incremented. Its real completion
would then take the empty-ring path and print the error.

Whether this happens depends on when the TMI completion FIFO releases
the stale entry, and the driver code doesn't show that.

Could the commit message also mention that SO_TIMESTAMPING users might
get a wrong Tx timestamp, not just a ratelimited error message? That
would help anyone judging this fix for stable backports.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179381496288.9644.9775319757787890210.stgit%40ahduyck-xeon-server.home.arpa
