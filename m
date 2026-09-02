Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04EE3AA4F8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375697; cv=none; b=QJ9qkjJleUq1FXrhKvId76UmeSSmKzueo8Ehobf5jWZPAF8EYOcKRh1zp6W3IORx+iIXHUYVI6EtV7nglLmAOVmfBP3yRUBhXegIPV/NttwLBflZpKCw66WCWqaRqALq9VXUZsjvq+RaRaLuBQe6rLyC2W9IIvcNRkDBK9o/m40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375697; c=relaxed/simple;
	bh=Pj3Tfj/rXbhYtoCKSJ4tuNiipc0mwby1qypcJp1Kk7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeyNqHK5sG0WJA4/ZWt32favsy50fk7fCqZLibARL6RllbQU6/V0KCZ3IwMbTGub6jIgMoIDctPiobb7WbiLFckDxLVzULIIxnOs3giuVG7CZZiOmygGELCKlut8IZay+I6MDArwNID2H/Y/99lMIaThDg/F5mqrU4fF6aSJpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWlTn01M; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWlTn01M"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c25344a8c6cso191656466b.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788375693; x=1788980493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QNUfCL4s/ReoBmg8c9La9jH0Egi+d1LIRRzTEf1FzS0=;
        b=LWlTn01MHKJI/rt8KhroFjQ4dr+gEj0ua2yXhS0Y6g6L389PATHCxrHrxH5YTVDjRd
         a6w5AnN+cQ4k+p24WQYT/RCbS66KsYpBjnC0RoxF/UVn2MV222yRXGn/Qdy2zamVHyCw
         nUyhXpfxaFPX9Y6wy9bx+LdOv/eond11ojhfUJ2DjaZMsIJzW2vErSjCZmiHxzAu9vcl
         dh21AV22YOPs/aj81JJHUH9jIskwewgV/3SpqKd599Oo8B+6o5M/IlecAGe81jheuqqO
         iOWTAs71rNtRZYz4NEN5jkNchCSEO4GjKAViNzXYYm1XHJqFtQqvfZBIFWo22jkXh5pH
         DKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375693; x=1788980493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QNUfCL4s/ReoBmg8c9La9jH0Egi+d1LIRRzTEf1FzS0=;
        b=PdHUZeMN3D9gM3x7GRtCJtdHxNLex3nxZGoihvwHuWfumPYAzK0VU36N13W0LMSgVF
         Ueuu9Lom0s+D7zeT+CGdGt/wNxugdouCtn46hPCVP8RaxPX0XpnfNo1YmJfw8lzTOjTE
         rg/xWH390V2wW3qlP+v0GSUbEB7mpkxMoNNCtQOLP8LBDzggguk9sCWCoI66MdCrYWgv
         u0beqzNlDyPqT3sFAvpfOXUAgBjUzcQWskO2JtaMHT9w+t3bzbJNjAFwBDhPpzdL2aWp
         +CwFNV4vnjnidFJjrl6KE8mT2tL969BqvMg96lzLwp/n86oUB4Hk4jHgH+UxXUyi5vM+
         1uBg==
X-Gm-Message-State: AFuF++lvlLWlC6hNMTT/iT/KfH5heMD26ZuRclYcNqT6SZWEytJo6rl5
	RZUDH/t2f2UeqO33xgeqGNParoPY0QhimD2wN4gNMLdC7UxIj1yQSEMVaJLkun3mig==
X-Gm-Gg: AYBFou3/F18WmoDCs5tGMg6qEst/V+h/e7PThImLxMQAadwqUsJNwkxkLHUXjkte8o3
	8/crzynUbEo+27IaSs+/x+1xNakABHtjnPocV+uTzmRSvhSGWWuqnHQR5n4yy9zmCiG/ARK4y6k
	/RfaCGQwTKhB6SoEQNAb4NJ6tmkqaGG3OwcJOuAiO3dSwuX6jR/OKIyMktQbbTQLXpKvXT7YwhO
	y3bFLIC98/z55BOBvSMgp6TjErNQ+4n9dov5aTygGIEEOxtxzj//9m3fow6idvZjr4VK4yBXG56
	gkesthA0+SiX2tqCGJ0XeKHe/YqQpvqdQPXMR2jhbw7g6fR7dD+IY2YDW7WOvSpKHUaG7fAxRrU
	7JmLTTVptuOYU7Dx54Dc7XnarmIWuA22Hv2ZggWPyI7HlKB97tLAk+ntI0yaqI0YqlqVEHoToxy
	tzfjYZgOjnJZcnOrZLh6DWgcOkbaNvZV2TppzA/PPpqhCtaumn7HQ=
X-Received: by 2002:a17:907:7293:b0:c25:2e93:28a6 with SMTP id a640c23a62f3a-c25d52871f2mr443022966b.3.1788375692672;
        Wed, 02 Sep 2026 12:01:32 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f42307e6sm611866b.55.2026.09.02.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:01:32 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Wei Wang <weiwan@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: yield the CPU on every exit of the threaded NAPI poll loop
Date: Wed,  2 Sep 2026 22:00:53 +0100
Message-ID: <20260902210053.263070-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_threaded_poll_loop() reaches cond_resched() only when it is about to
iterate. When __napi_poll() clears repoll the loop breaks first, and
napi_thread_wait() returns without scheduling if work is already pending.
Under a receive load arriving as fast as it is drained the kthread never
yields, and on CONFIG_PREEMPT_NONE nothing else on that CPU runs.

Everything waiting for deferred work on that CPU then blocks. Deleting a
netdev hits three such waits - synchronize_net(), flush_all_backlogs() ->
flush_work() and rcu_barrier() from netdev_run_todo() - which is how this
was found. run_backlog_napi() runs the same loop, so the backlog kthread
can be held off the same way.

rcu_softirq_qs_periodic() does not cover it: it reports a quiescent state
but does not schedule, so the work items and the callbacks still wait.
Moving only that call is not enough either - the delay then migrates from
synchronize_net() to flush_work() and rcu_barrier().

Without the patch the kernel reports the thread holding the CPU:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:  0-....: (5999 ticks this GP) ... (t=6000 jiffies g=913 q=1218)
  CPU: 0 UID: 0 PID: 203 Comm: napi/qdma_eth-0 Not tainted 6.18.44 #0
  Hardware name: Nokia XG-040G-MD (UBI) (DT)
  pc : __dma_sync_single_for_device+0x8/0xfc

Measured on that board (Airoha AN7581, quad core Cortex-A53, PREEMPT_NONE,
HZ=100, airoha_eth with threaded NAPI) while it terminates a 950 Mbit/s TCP
receive load. 30 minute runs, timing "ip link del" of a dummy interface:

                          before        after
  mean                    31.09 s       0.20 s
  worst                  151.92 s       1.00 s
  over 1 s              13 of 37      0 of 89
  RCU stalls, classic          14            0
  RCU stalls, expedited        43            0
  packet rate           79363 p/s    79520 p/s

The packet rate is the control: the same work is done in both runs, so the
difference is not a lighter load. Three of the four CPUs sat around 65%
idle throughout the first run and did not help - the deferred work the
delete waits for is tied to the CPU the poll loop holds.

On preemption, raised in v1: same board and load, unpatched, two halves
differing only in that choice - worst "ip link del" 248.48 s with 8 stalls
under PREEMPT_NONE against 0.39 s and none under PREEMPT_LAZY. So lazy
preemption does hide the symptom, and PREEMPT_NONE and PREEMPT_VOLUNTARY
builds are what is left. It is not the NAPI thread being preempted more -
nonvoluntary_ctxt_switches on it is 4.6/s under LAZY against 13.9/s under
PREEMPT_NONE - so that is a measurement, not a mechanism. The missing yield
is there under either model.

The loop is unchanged in Linus's tree - net/core/dev.c at v7.3-rc1 is
identical here to net/main. The numbers come from 6.18 because that is the
only kernel this board runs: mainline carries en7581-evb alone, while the
SoC dtsi, the board DTS and the airoha_eth changes it needs are still out
of tree. On 6.18 the loop has no busy_poll_last_qs parameter, but with that
pointer NULL the two are the same code, so the change under test is this
one. The busy-poll path is unaffected; cond_resched() was already reached
there.

Reproducing needs the loop re-entered tens of thousands of times a second,
which depends on the driver and the shape of the load rather than on this
board: threaded NAPI can be turned on for any driver through
/sys/class/net/<dev>/threaded, and what it takes on top is little or no
interrupt coalescing. It did not reproduce on mtk_eth_soc, whose net_dim
moderation folds the same packet rate into far fewer interrupts.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
v2:
  - answered the tree question: the loop is unchanged in Linus's tree at
    v7.3-rc1, and said why the numbers have to come from 6.18
  - re-ran the A/B on a kernel with no out-of-tree module, so the splat and
    the numbers now come from an untainted 6.18.44 build
  - added the preemption-model measurement, and why PREEMPT_NONE and
    PREEMPT_VOLUNTARY are still the exposed configs
  - noted the repro is not board-specific
  - shortened the comment; no other code change
v1: https://lore.kernel.org/netdev/20260814220427.623427-1-sochnev.v.74@gmail.com/

 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..5c7f8cdf8443 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7924,11 +7924,13 @@ static void napi_threaded_poll_loop(struct napi_struct *napi,
 			gro_flush_normal(&napi->gro, HZ >= 1000);
 		local_bh_enable();
 
-		/* Call cond_resched here to avoid watchdog warnings. */
-		if (repoll || busy_poll_last_qs) {
+		if (repoll || busy_poll_last_qs)
 			rcu_softirq_qs_periodic(last_qs);
-			cond_resched();
-		}
+
+		/* napi_thread_wait() can return without scheduling, so yield on
+		 * every exit, not only when the loop iterates.
+		 */
+		cond_resched();
 
 		if (!repoll)
 			break;
-- 
2.55.0

