Received: from griffin.linux.hr (griffin.linux.hr [193.198.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0834DCCD;
	Thu,  3 Sep 2026 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.198.212.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420905; cv=none; b=srbEHiVOkiNtPLqbIUhHVk5ZMqOINWi3IzG392+399XX7qKeOETf07MRsADr3I0pkLPZksHKb1x+C8ReN8E4k/bVTZDkElfGDBDKVDMBrmiLKus7C3YVPHT4r8QL1f3ZsBIC8BcH3vFYE0/pni8A8QgEvBe5YSis2p+SlOy483E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420905; c=relaxed/simple;
	bh=uU3M1QH9GAGStJB+cvap9TRM5aLHXRZOvz8g5b8/ow0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dZhzv33W52xKeAFAFa3nFQKI2iBKDylnFcqIA53XZFnht5AZsBUAJDyny/Vl4JNN8YpTwLDULu6xnvLRgIQFf6iU8SkvmXk3iB8yt6J1onfV6/nuF4lNUXFRHOsISLDemoiYr8IQYjwtropw/NbO/VghA7fgYjv6kaROJ0chomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.hr; spf=none smtp.mailfrom=griffin.linux.hr; arc=none smtp.client-ip=193.198.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.hr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=griffin.linux.hr
Received: from vkosturj by griffin.linux.hr with local (Exim 4.94.2)
	(envelope-from <vkosturj@griffin.linux.hr>)
	id 1x20pF-0008Uv-LZ; Thu, 03 Sep 2026 08:21:29 +0200
Date: Thu, 3 Sep 2026 08:21:29 +0200
From: Vlatko Kosturjak <kost@linux.hr>
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ppp_async: drop the errored frame instead of
 resetting its headroom
Message-ID: <apkR6ZU+tqP2C3Fl@griffin.linux.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Vlatko Kosturjak <vkosturj@griffin.linux.hr>
X-SA-Exim-Connect-IP: <locally generated>

ppp_receive_nonmp_frame() prepends a two-byte direction tag before running
the pass/active BPF filters:

	*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);

Nothing on the receive path guarantees those two bytes of headroom. The
frame-error path in ppp_async's process_input_packet() resets a reused skb's
headroom to zero while claiming to restore it to a freshly allocated state -
but a fresh skb from dev_alloc_skb() carries NET_SKB_PAD:

	err:
		if (skb) {
			/* make skb appear as freshly allocated */
			skb_trim(skb, 0);
			skb_reserve(skb, - skb_headroom(skb));
		}

ap->rpkt still points at that skb, so the next frame is reassembled into it
with no headroom at all. A peer that sends a bad-FCS frame followed by one
beginning ff 03 then leaves a single byte of headroom by the time the filter
tag is pushed, which lands one byte below skb->head:

  skbuff: skb_under_panic: len:49 put:2 head:ffff888003c10000
          data:ffff888003c0ffff tail:0x30 end:0x640 dev:<NULL>
  kernel BUG at net/core/skbuff.c:214!
  RIP: 0010:skb_panic+0x13e/0x230
  Call Trace:
   skb_push+0xbd/0x100
   ppp_receive_nonmp_frame+0x48a/0x1d10
   ppp_input+0x4e9/0x2f80
   ppp_async_process+0x2a/0xe0
   tasklet_action_common+0x20f/0x8a0
   handle_softirqs+0x18e/0x590
  Kernel panic - not syncing: Fatal exception in interrupt

Zeroing the headroom violates the NET_SKB_PAD guarantee that dev_alloc_skb()
gives the rest of the receive path. Besides the filter panic above, when CCP
compression is enabled ppp_decompress_frame() hands skb->data - 2 to
->decompress()/->incomp(), which then reads out of bounds before skb->head
for the same reason.

Rather than restore the headroom, drop the errored frame - as ppp_synctty
already does on its error path - and clear ap->rpkt so the next frame is
reassembled into a fresh skb with proper headroom. This is simpler and fixes
both the filter under-panic and the CCP out-of-bounds read.

The original V1 of this patch made room in ppp_receive_nonmp_frame() with
skb_cow_head(); Eric pointed out that fixing the root cause in the transport
is the right approach.

Found by fuzzing the PPP receive path with a mutating peer on a pty; it is an
interesting (remote) DoS: root configures PPP, the peer supplies two crashing
frames. The reproducer (repro-ppp-skb.c, unchanged from v1) panics in about a
second, and returns cleanly with this applied.

Fixes: 6722e78c9005 ("[PPP]: handle misaligned accesses")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Vlatko Kosturjak <kost@linux.hr>
---
v2:
 - drop the frame in ppp_async instead of making headroom in ppp_generic
   (Eric Dumazet); this also fixes the ppp_decompress_frame() skb->data - 2
   out-of-bounds read that the same headroom reset caused
 - Fixes: the commit that introduced the skb_reserve() reset, not 2.6.12-rc2
 - [PATCH net]

v1: https://lore.kernel.org/netdev/CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com/

 drivers/net/ppp/ppp_async.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -812,9 +812,6 @@ process_input_packet(struct asyncppp *ap)
  err:
 	/* frame had an error, remember that, reset SC_TOSS & SC_ESCAPE */
 	ap->state = SC_PREV_ERROR;
-	if (skb) {
-		/* make skb appear as freshly allocated */
-		skb_trim(skb, 0);
-		skb_reserve(skb, - skb_headroom(skb));
-	}
+	kfree_skb(skb);
+	ap->rpkt = NULL;
 }
