Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FA448396
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517498; cv=none; b=g3HknI2E3WbW7GQM9iaNtGqe56RwIrHQX9T2/WZ6dQL+7yn3k0C434JgWbJy1gJ7CZtQmZOYWRMzkPhEFJ3s6UTptPCLLLp3FWylLAjFEydziLpumSfEs69C9dL/Q86aTTc4FeGwfg2QXMkwPskD0sPM2N/F632tnds0tJm7B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517498; c=relaxed/simple;
	bh=TiEiCLzRBgCRWu0MaEFZR+ai00p3m9+yXWylxLxfsEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9/3IYLRhP221ejmURBVbhmDzqiBxelMON4uGFfbhpuMw9mSXpB4gJANQQb7HzgLmjjbnqZvOEUlT8+DJJmk19QC/TJV+Uaa6i+cYERsT7XPGucjoBuESFIqvTVYFWGAea4By59HSidxASXFVQSzPfwqqQZcOxQdFuPIvWO9eXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rM9unod5; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM9unod5"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso3751935ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785517496; x=1786122296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mI1rZZtu8o4cfi0FGJlAmOUjg03NURhPr/05wZVSU0k=;
        b=rM9unod5pYatwebtwY+/vwPLU9+50BbGH3K02+rneNv4Y8g+SCWZfmTWYjjOC9beu7
         kDJ+c/vM0f/4ZiFiTTy5V0GcVqF989QMreBEpjs4IrM7FBmqNgPdtkaiLVKmlXtROKc6
         bdmE5APDKVPrZqoghJgR/COA8nFKlhZBAjKYC+93VfpNBRy/K/tKTSs2U/MJqWAoZKUQ
         BiOFEgdZRL3yxx5BDxa3t8VEE53Rk7QGLgYQcpPg5osYHAAbQ9mguzbs8RD0tfsnOCH4
         02DcxhEPblKWNYY9w+ZwTEfOT13p8PJOnXpqEbkSzDVz/misFIh7nvu4dps82zZfTDjW
         vu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517496; x=1786122296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mI1rZZtu8o4cfi0FGJlAmOUjg03NURhPr/05wZVSU0k=;
        b=UDtEZRuwHx4kU2lnJXne9Qm9P+La5tNaLSJGXaWrTuBIjSdbo1eyFaHhey4UqeC2T2
         6rP0qURi6+owhjJnRldOOFEnQO0ueK7iPMUnC+8AfjsOAwyR08eLPMzD4XftX2r61VoL
         FjnAvXTN+eea8mpEEH10kVwvSE8XAS17GfyzKBxFeohAmrNUHdslqo6RndM7cIgQpnZq
         6wlywyfQ3Lt9uEFKEv1t3M5h7AFOhG6QGhLu5/bpipC4af597k6oUKOtG6uAYGpHwpH5
         q7mIKAPGY73nrGaD2c7Bp6hI+VsTHyoYxEVlXIUkPFq9lVRGZl4sKYqvx58g+CrYs2jW
         loCw==
X-Forwarded-Encrypted: i=1; AHgh+RruQMkUCIpEa5A53b9SR9ducJRyZ39LtaSx7pzsd0dNdHgR8Mhca0hXvLkZ5eeNooWCxEkE8tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiSmlBklwuIo2JDcR7shqQo2ptizzVKXbj3pKkcNaJRT50QQT
	7kiSJ+uFP5duh9+PNjfjHPRkPIjFXIBR4phdj5+q5170EGoR+fhp1A4=
X-Gm-Gg: AR+sD119rqkLfieNBU5xq59sVReLH0VpiaXGNwfEob8Pkmva/wew90rHEr0K0Ub5+8Y
	nXMS+qVXYqHf4yYJo6BL17KwLnHZhPesxKY7eTfI8XTrMlzHFwS1igme+yAMs5h46ws8gT9PHm2
	zYjxNM0OFhlBGK5Qi3jrW3YKnJB81E9cPfqdu3paduFqBiWIdd5siQE8UxNAA6plwVB0FnZrRzR
	ojXJ4YKMusqOnD1hkApsh8T6D1DqqOrEFPiurkzpa3bGNTi12ta8B++B2v1Vb+QRZCyXkA8uonJ
	rNaMKFGcWu8It6dbu54+HgQzidDqelS8vQmvMKBHAIYSHPtDSSPGU4RMom4N1Sm83WFkLbzogc8
	GlG22KJ3WD6lwgOTFJiFXronZMi67qMdk6sp2XhcCFqxyP63HEq9KOR0TaUcd34QkP221zWBqk8
	Jb1h6iP/nA/yADwfnEB1SVvv9en/iZMMxXsdZJaiWv5VIYJ+xEMygMSmx3RlhJeZo=
X-Received: by 2002:a17:902:ea0c:b0:2cf:6f7f:55d8 with SMTP id d9443c01a7336-2d0523f76edmr6597195ad.37.1785517495457;
        Fri, 31 Jul 2026 10:04:55 -0700 (PDT)
Received: from jplife-black.. ([171.2.207.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm8064705ad.6.2026.07.31.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 10:04:55 -0700 (PDT)
From: Fan XinRan <shinjiangjiang@gmail.com>
To: westeri@kernel.org,
	YehezkelShB@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan XinRan <shinjiangjiang@gmail.com>
Subject: [PATCH net] net: thunderbolt: Tear down DMA paths before stopping the rings
Date: Fri, 31 Jul 2026 17:04:42 +0000
Message-ID: <20260731170442.45530-1-shinjiangjiang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tbnet_tear_down() stops both rings and frees their frame buffers before
calling tb_xdomain_disable_paths().  tb_ring_stop() zeroes the ring's
descriptor base and tbnet_free_buffers() unmaps and frees the pages the
frames sit in, so by the time __tb_path_deactivate_hop() polls the hop's
'pending' bit, anything still in flight has nowhere to drain to.

This is the mirror image of the setup path.  tbnet_connected_work()
already documents the invariant:

	/* Both logins successful so enable the rings, high-speed DMA
	 * paths and start the network device queue.
	 *
	 * Note we enable the DMA paths last to make sure we have primed
	 * the Rx ring before any incoming packets are allowed to
	 * arrive.
	 */

Teardown should undo that in reverse, but does not.

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

Fixes: 4944269305df ("thunderbolt: Properly disable path")
Signed-off-by: Fan XinRan <shinjiangjiang@gmail.com>
---
Notes for reviewers, not for the commit log:

I can only test this on an ASMedia ASM4242 host router - I have no Intel
host router to check for regressions on, and that is the gap I would most
like a second opinion on.  The argument that other hosts are unaffected is
that the paths end up deactivated in both orderings, and that the window
this opens (rings still armed while tb_xdomain_disable_paths() runs) cannot
take new traffic: __tb_path_deactivate_hop() clears hop.enable before it
starts polling, and tbnet_tear_down() has already called netif_stop_queue().
That is an argument, not a measurement.

Details left out of the commit log to keep it short:

- The three load levels were idle, 100 pings, and 3 s of iperf3 before each
  teardown.  The 21 vs 24 asymmetry is because the "before" arms stopped
  early when the link died: 8 teardowns completed idle, 7 under light load,
  6 under heavy load.  Only one arm per load level died, so I would not read
  a dose-response into that on its own.

- The failing hop is an ingress hop on a non-NHI port:
    thunderbolt 0000:70:00.0: 0:5: hop deactivation failed for hop 0, index 1

- The enslave run is a smaller sample (the link dies faster there, so the
  before arm only got two teardowns in): -ETIMEDOUT on both before the
  change, 0 after.  Note the interface also gets destroyed on enslave
  regardless of the ordering - that looks like a separate problem and this
  patch does not claim to fix it.

 drivers/net/thunderbolt/main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a9165..a04c090 100644
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
--
2.43.0

