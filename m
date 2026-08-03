Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D832D9780;
	Mon,  3 Aug 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767931; cv=none; b=g5GYZ5TXK1UZJd1df4qrN7CIOupc7CXo7AB3wFOvZoIbBCcDt1dhsyDrWbDKt46glEwA70z5SFyq7wDUfA9gdv7MfQqvCZBdipwEVxG4vrHpyrJgGNPhrIJCSnoXWxRIzhyhm5sOq/w0WnAu92b/8/zDYVvNzfA9zhaBpFk+N5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767931; c=relaxed/simple;
	bh=VlJrDlV0/4pChOLduGROgPCiwY13oied8OmtEHar5/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HCXgRH38TeY5zxzewc9v5AkRx6si0PwHPGoXObe93j0uJ9e8QWJDQ/LkT2yNsruwfQp9vnPuMpKFh7Zb6w3l0vt+yr88SAygBS0RG3Mu1kE74UHcer9/plolrXqAtygfZtwcwkO3XkP1y0MzqtCe0KNE5JVvO9nqJJM4qb8izRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhXc72J6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhXc72J6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00A44C2BCF4;
	Mon,  3 Aug 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785767931;
	bh=VlJrDlV0/4pChOLduGROgPCiwY13oied8OmtEHar5/s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KhXc72J6nGqpdl4f/OcGjnYEfFuE21ticabBFTUbloDgAdJD7LVy+dvCv0s2P9qlu
	 dQgxhP6HqBK0+o0EyF7tQEVc+WWJe7vVoKp5TqQkUPfGELUXshhsqaJBYjKI4SJ5KG
	 PkmyF5pQ0DItRyv8mT++zWRTgG8+hP2Mi1ulCXn4OrGk1ycxy0zkmFye6v++u3hE7N
	 tVjY7ea1dFxaQJRGjbUSb2EZrN1z/B5UQPs9B/Sleam8/eWVYEaxWbP1V9bZC9bQTC
	 w7FLYvnr1xj/jTKiLZodXrTYQVERqZJ4qurGJ82789I+0ooqwm0aR6wiN0NlCzrfCu
	 tNpuPdT6a7FoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF48C55184;
	Mon,  3 Aug 2026 14:38:50 +0000 (UTC)
From: Fan XinRan via B4 Relay <devnull+shinjiangjiang.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 14:38:50 +0000
Subject: [PATCH net v2] net: thunderbolt: Tear down DMA paths before
 stopping the rings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-b4-tbnet-teardown-v2-1-27de6a13ca2d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPmncGoC/yWMQQrCMBBFr1L+2oEhnYp4FXHRJFMdF6kksQqld
 zfa5fv891YUzaYF525F1sWKzamBO3QI9zHdlCw2hmN35BP35IWqT1qp6pjj/E40ycC9CAcfBc1
 7Zp3s829e0J647mN5+YeG+qth276z7DSFegAAAA==
X-Change-ID: 20260803-b4-tbnet-teardown-f4503440cbd4
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com, 
 kuba@kernel.org, linux-kernel@vger.kernel.org, 
 mika.westerberg@linux.intel.com, davem@davemloft.net, YehezkelShB@gmail.com, 
 westeri@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785767930; l=6902;
 i=shinjiangjiang@gmail.com; s=tbnet2; h=from:subject:message-id;
 bh=2VEx2vZrGgzuxegRvN8HTWMc/FlSK3Z7MurSRiJTFQE=;
 b=7hdtWsP7DHmZW/4LuPw3ncxiuNPd8G5/P5QBd48M6wIJZe2QtA6Q5+WDn92eOeKQvo7eM71jt
 y2j1gUDp/2MBHfsovhTHYhOmbUQxQR8zXuJ0nhTUqu+IyRJS2Ul0lET
X-Developer-Key: i=shinjiangjiang@gmail.com; a=ed25519;
 pk=S5b5AWBlS1MzhQto3bSxuygfVWGoX1K7saZNT5wGWeY=
X-Endpoint-Received: by B4 Relay for shinjiangjiang@gmail.com/tbnet2 with
 auth_id=915
X-Original-From: Fan XinRan <shinjiangjiang@gmail.com>
Reply-To: shinjiangjiang@gmail.com

From: Fan XinRan <shinjiangjiang@gmail.com>

tbnet_tear_down() stops both rings and frees their frame buffers before
calling tb_xdomain_disable_paths().  tb_ring_stop() zeroes the ring's
descriptor base and tbnet_free_buffers() unmaps and frees the pages the
frames sit in, so by the time __tb_path_deactivate_hop() polls the hop's
'pending' bit, anything still in flight has nowhere to drain to.

The teardown sequence has been in this order since the driver was added.
The setup path has not: commit ff7cd07f3064 ("net: thunderbolt: Enable
DMA paths only after rings are enabled") moved the path enable to the end
of tbnet_connected_work() and documented why:

	/* Both logins successful so enable the rings, high-speed DMA
	 * paths and start the network device queue.
	 *
	 * Note we enable the DMA paths last to make sure we have primed
	 * the Rx ring before any incoming packets are allowed to
	 * arrive.
	 */

Teardown was never updated to match, so the rings and the paths now come
down in the same order they go up instead of in reverse.

On an ASMedia ASM4242 host router the 'pending' bit then never clears:
every teardown burns the full 500 ms timeout and
__tb_path_deactivate_hop() returns -ETIMEDOUT.  Raising the timeout to
5 s does not help, so the hop is not slow to drain, it never drains
at all.

The failure is invisible above the thunderbolt core.
__tb_path_deactivate_hops() is void and only calls tb_port_warn();
tb_path_deactivate(), tb_tunnel_deactivate() and
__tb_disconnect_xdomain_paths() are void as well, and
tb_disconnect_xdomain_paths() ends in an unconditional "return 0".  So
tb_xdomain_disable_paths() reports success and the netdev_warn() below
it never fires.  Repeated teardowns eventually take the XDomain control
channel down, after which the peer node is gone and only a power cycle
brings the controller back.

Deactivating the paths first fixes it.  Measured with kretprobes on a
stock v6.17 tree with no other patches applied, on a link that was up
and had just carried traffic:

  before: __tb_path_deactivate_hop() returns 0 for the first hop, then
          -ETIMEDOUT for the second 500335 us later
  after:  0 for both, 525 us apart

Alternating the two orderings ABBA over three load levels, four
teardowns per arm: every teardown failed before the change (21 of 21
that ran), none failed after (0 of 24).  The before arms ran short
because the link died partway through.  The same split shows up when
the interface is enslaved to a bond instead of just brought down, which
is how I ran into this in the first place.  Throughput and latency after
the change are unchanged.

Hosts whose routers drain the hop despite the stale descriptor base see
no functional difference, since the paths end up deactivated either way.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Signed-off-by: Fan XinRan <shinjiangjiang@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Mika, thank you for running this on Intel hosts.  Not having one to test
a regression against was the one gap I could not close myself, and I am
grateful you closed it for me.

Sorry about the wrong Fixes tag in v1.  That was careless of me - I
should have checked the tag against the driver's own history before
sending rather than making you catch it.

v2:
- Fix the Fixes: tag.  v1 pointed at 4944269305df ("thunderbolt: Properly
  disable path").  That one lives in drivers/thunderbolt/path.c, is
  correct in itself and is not what this patch changes; it is only what
  makes the failure visible, being what added the 'pending' poll and its
  500 ms timeout.

  I went with the driver-add commit rather than ff7cd07f3064 ("net:
  thunderbolt: Enable DMA paths only after rings are enabled", v6.1),
  which is what actually introduced the asymmetry with the setup path.
  tbnet_tear_down() has stopped the rings and freed the buffers before
  deactivating the paths ever since e69b6c02b4c3, unchanged, and that is
  the sequence the hardware objects to; how the paths were brought up
  does not change the state the hop is in by the time teardown runs.
  Tagging ff7cd07f3064 would limit this to v6.1+ when the same teardown
  code is in every tree from v4.15 on.  Happy to switch if you read it
  the other way.

  Two things that bear on the backport range whichever tag is used.
  Nothing before v5.2 can show the -ETIMEDOUT, since that is when
  4944269305df actually landed - its author date is 2017 but its commit
  date is 2019-04-18.  And 4.19.y, 5.4.y and 5.10.y never took
  ff7cd07f3064, so on those trees this change makes teardown stop
  mirroring setup rather than start mirroring it; it still closes the
  stopped-ring window, but you may want to trim the range there.
- Rework the second paragraph accordingly.  v1 implied teardown had
  always been the mirror of setup, which only became true in v6.1.
- Pick up Mika's Acked-by.  No code change from v1.

v1: https://lore.kernel.org/netdev/20260731170442.45530-1-shinjiangjiang@gmail.com/
---
 drivers/net/thunderbolt/main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a916505..a04c0901c 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -386,11 +386,16 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
 				break;
 		}
 
-		tb_ring_stop(net->rx_ring.ring);
-		tb_ring_stop(net->tx_ring.ring);
-		tbnet_free_buffers(&net->rx_ring);
-		tbnet_free_buffers(&net->tx_ring);
-
+		/* Tear the paths down before stopping the rings.  This mirrors
+		 * tbnet_connected_work(), which enables the paths last so the
+		 * Rx ring is primed before packets can arrive.  Stopping a
+		 * ring zeroes its descriptor base and tbnet_free_buffers()
+		 * unmaps and frees the frame buffers, leaving anything still
+		 * in flight with nowhere to drain to;
+		 * __tb_path_deactivate_hop() then waits for the hop's
+		 * 'pending' bit, which on some host routers never clears in
+		 * that state.
+		 */
 		ret = tb_xdomain_disable_paths(net->xd,
 					       net->local_transmit_path,
 					       net->tx_ring.ring->hop,
@@ -399,6 +404,11 @@ static void tbnet_tear_down(struct tbnet *net, bool send_logout)
 		if (ret)
 			netdev_warn(net->dev, "failed to disable DMA paths\n");
 
+		tb_ring_stop(net->rx_ring.ring);
+		tb_ring_stop(net->tx_ring.ring);
+		tbnet_free_buffers(&net->rx_ring);
+		tbnet_free_buffers(&net->tx_ring);
+
 		tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
 		net->remote_transmit_path = 0;
 	}

---
base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
change-id: 20260803-b4-tbnet-teardown-f4503440cbd4

Best regards,
--  
Fan XinRan <shinjiangjiang@gmail.com>


