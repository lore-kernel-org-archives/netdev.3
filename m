Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793465281;
	b=1kKJXiw+lKoshZnXCNZtogcqjwmj3WTdnl7CImYZxKUYKzim8wECZikfbDvYG3huCyrZ
	 I/2XRMPkQxgITd8zAuOJFixOSz+YFwkIiJPjuu2fHuL2mxwnKZAZ9rOp7OzPYFJWqYlde
	 1W41bvo0jMf6AOMlJhr4Rkr8cg55GhKX/sxUsO/ZuouMKsCwVJS0CWpaOjzhA9/02ve0E
	 01QNhoPVQSgp+go6SGqepcMZpYoSj5iUOh7c2MOD2l06LkwlN9SOKye/lzZ+iHr6N86Vc
	 SKUq+W9ioTuIRvFSVaZSbp939M/ioOe+v+b00zN8wv/BgLAM9HHRgS1qcrEGV7Lk/cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465281;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Sh2Havs12iJQp69ousMTmRccv7SUfekdL8f3htWvZ4s=;
	b=2rr8VC5jBTVMcfXpiVUrhCdrH6ViCx8Sxk//El8P3DEOWhV8fwMTwnzg0pA9U3IoTdy3
	 5V+Zl4Xzp+qdEUCSeMrvz3vwAVgtDTJSfrsAUaQO1Ha4PGYa1GbrMrci2tkER1r73NBvs
	 4f82xwy6OwAGCO0XiKbDOb0/OfdzB3oL7S4wkdBDXJ8etJqld6fVSx0pwF2NNRVTGxbQ3
	 SYmKuOglxnp8Vy3XwT/9gc0m8Idr8TPcm7589+MJgGxQ2VEIeof4QVTXcWlJPx7eb8ab7
	 WrJPT/6eL3A17LUnj+cYv47UjfcFmNidgnsmvKMTBx/ePyeB5JSzi85sFi676wzjwVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpaGljiT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC06606A31A;
	Sat, 31 Oct 2026 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpaGljiT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793465281;
	b=TfNW11pmZ8vLXIhB8IBVW6pDf3yE9m03iSGxcQHOVuEC/nJjtEltFkEaaywy06BCH1AG
	 op4JnlYG5dY1wdOVfg/c4SnuZIBCJnF3VBBfNc0n6l5gdNH3Afihj5qbGpDvVwTM4SUI/
	 sRZizuIHSbLfITRJodZTPx2ImJ3QjZQc8rdQTKRsG0KtHb1u9Ny55C/qoMVCnpGnsOCSY
	 YZ4TGJw+EsrfXaGnEO3FMOFI8ud4dN6fVNCBYOsTIXeHmIQj542/trXbdaMbX2hriPbfH
	 x2JK5XG50QetOejTM3ViAjfahqYr0kJ2ec2gkT5nWpMXrTB+tiCy4QQQ+kdQ8RRMekg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793465281;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Sh2Havs12iJQp69ousMTmRccv7SUfekdL8f3htWvZ4s=;
	b=vIdypm3Zx2GjNxKUHB4UJRcQSynLtPOEa1BXutmkZmB1qnRH95P2qEPBEnCspNvf3PbX
	 J2e+G3W/SWwMPJBK0H8OA22b8E//aWxSYgXJrPfsugvwMkBce8oStwzTncPBGouD0db64
	 Q6md6WGGwEjaMwq+4+m/oSRyWQiybPtNfxLpmY55bxfMDlXjydOLG2CjwM4SyPTRtF1TD
	 2y9/zaJ9WqNRIfVPN7FjZycmVUGdWkv8TqlfQPY8h65qycFut3TZph9qs20Arj/PCHrwJ
	 52GGuxiUHMKuueYzzUPoTTkys++7PT8g0QKkmSXhKl2U6CLGsWrUBSTRIKpdr8YqoiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81ADA1F000C1;
	Sat, 31 Oct 2026 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793465281;
	bh=Sh2Havs12iJQp69ousMTmRccv7SUfekdL8f3htWvZ4s=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=MpaGljiTYrT01rLMfJbAZ5axZWVtoZS9I17uAnoMpJZ0fRdPhDkDe33P7bkdBkuHX
	 x4pjzYGXdl/rAnv4Q4WUgLfZBzcdHq5iwD1uDSjvcTCXivmj427Ig9g9LR0yxj7cJT
	 zSENkkF0TxbUFShDp6LwGmCUysdSeCMyk91XlzFEfTYFGQb5Un0BAABijrKCHkKAQ6
	 UyfCojKh0YesqjztflqpcZ+0orff8lSDRQKL1XCZscvgRtRqe3+OZky7+kG7Jh4rAi
	 Oy49AQMd1yhsDvMb14m08eWMVQCAlgrwHj5T1JxDnwDEZGF7mXHG8RKObrv8IDVchk
	 +GkW7xZq6HdTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D206645F61;
	Sat, 31 Oct 2026 16:47:59 +0000 (UTC)
From: Colton Pawielski via B4 Relay <devnull+colton.pawielski.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 11:47:23 -0500
Subject: [PATCH net v2] net: 8139cp: keep Rx masked while NAPI is scheduled
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-b4-8139cp-napi-v2-1-5824797c0fe6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TW0xQqc/A/DgZYF1kghLRIN4
 d8tePb4JjPzVgjkmQKUyQqeFg48ugjylIDta9cRchMZZCq1SKVAk2EuVGEndPXEmFOEVip5VRr
 iaPLU8vs4vIOjGapfGF7mQXber/Zaz2Ee/efQLuIo/zMsAgXawuhcNcVFZ+bWDTU/z3YcoNq27
 QuHENalwwAAAA==
X-Change-ID: 20261021-b4-8139cp-napi-8e139f232736
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Palmer <daniel@0x0f.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Colton Pawielski <colton.pawielski@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793465279; l=4242;
 i=colton.pawielski@gmail.com; s=20261021; h=from:subject:message-id;
 bh=7Gdp49sTAj7nx7xBdYxeqxP8MqCpA92+96SZGvd7Q0Y=;
 b=R3RavTVmBCmEDdIZtTFe4FLSJklOZ8fxT+SGt27gal/R3PnDuCPY47HdMsg7Y3UIkWclJLca9
 5xCJonZxqfRBLCBBv2u+2PbX8zMhaWygevqxH+qDCA2KJlmKlqofVnQ
X-Developer-Key: i=colton.pawielski@gmail.com; a=ed25519;
 pk=QFoKkkRiV70QY509+evUr/DtmgPqjU3fLV0TaScMuE4=
X-Endpoint-Received: by B4 Relay for colton.pawielski@gmail.com/20261021
 with auth_id=1266
X-Original-From: Colton Pawielski <colton.pawielski@gmail.com>
Reply-To: colton.pawielski@gmail.com
Content-Transfer-Encoding: 7bit

From: Colton Pawielski <colton.pawielski@gmail.com>

cp_rx_poll() calls napi_complete_done() and only then takes cp->lock
with interrupts disabled to unmask the Rx interrupts. An interrupt
that is not masked while polling (TxOK, TxErr, ...) can arrive in
between. cp_interrupt() then sees the Rx status bits, which are still
set, finds NAPI no longer scheduled, masks Rx and schedules NAPI again.
cp_rx_poll() then carries on and unmasks Rx anyway.

From that point Rx interrupts are enabled while NAPI is scheduled:
cp_interrupt() leaves the Rx bits for the poll routine, does not mask
them because napi_schedule_prep() fails, and the level-triggered
interrupt fires again as soon as it returns. On an SH7751 LANDISK
under combined Tx/Rx load this interrupt storm was captured with a RAM
trace right before the board locked up hard.

Mask Rx in cp_interrupt() whenever Rx status is pending, not only when
NAPI gets scheduled. If the race leaves Rx unmasked, the next interrupt
masks it again, and the pending poll unmasks it when it completes.

Fixes: ab1e7e1d2666 ("8139cp: use napi_complete_done()")
Signed-off-by: Colton Pawielski <colton.pawielski@gmail.com>
---
An AI coding assistant (Claude Opus 5.5, in Claude Code) did most of the
debugging: it instrumented the driver with a RAM-backed trace of register
accesses and IRQ entry/exit that survives the power cycle, and decoded
the trace after the hang.

Tested on I-O DATA LANDISK boards (SH7751R, RTL8139C+ rev 0x20).
Without a fix, pulling 300 MB over ssh while reading the disk
(concurrent IDE and network DMA) hard-hung the board in 7 of 8 runs.
With this version that test passed every run on two boards over several
sessions (16/16 and 24/24), as did the runs that also pushed 100 MB to
the board at the same time (6/6 and 9/9).

The LANDISK is UP, so SMP was tested on a Raspberry Pi CM4 (4x
Cortex-A72, arm64, PROVE_LOCKING) with an RTL8139C+ on a PCI card
behind a PCIe-to-PCI bridge, pulling TCP data from the far end of the
card's link:
- without a fix: the CM4 hard-hung during the first 100 MB transfer
  (2 of 2 boots)
- v1: lockdep warning within seconds ("HARDIRQ-safe -> HARDIRQ-unsafe
  lock order", cp->lock held in cp_rx_poll() across
  napi_complete_done())
- v2: 32/32 transfers (16x 100 MB, 16x 500 MB) and 12/12 runs with a
  concurrent push, about 14 million interrupts, no lockdep warnings

It was also checked in QEMU: x86_64, -smp 4, PROVE_LOCKING, with
QEMU's emulated rtl8139 (which binds to 8139cp). Ping plus 1.5 GB of
TCP downloads ran without any lockdep warnings. v1 hard-locked there
shortly after link up.
---
Changes in v2:
- v1 moved napi_complete_done() under cp->lock, but it flushes GRO into
  the stack, and a reply sent from there (ARP, TCP ACK) re-enters
  cp_start_xmit() and deadlocks on cp->lock on SMP. Reported by the
  Sashiko review, reproduced in QEMU and flagged by lockdep on the
  CM4. Leave cp_rx_poll() alone and keep Rx masked from
  cp_interrupt() instead.
- Reworded the subject, since the race is now recovered from rather than
  closed.
- Dropped Daniel's and Geert's Tested-by since the fix is different.
- Link to v1: https://patch.msgid.link/20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com
---
 drivers/net/ethernet/realtek/8139cp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 9016527e229a..8f81dc7deef1 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -600,11 +600,11 @@ static irqreturn_t cp_interrupt (int irq, void *dev_instance)
 		goto out_unlock;
 	}
 
-	if (status & (RxOK | RxErr | RxEmpty | RxFIFOOvr))
-		if (napi_schedule_prep(&cp->napi)) {
-			cpw16_f(IntrMask, cp_norx_intr_mask);
+	if (status & (RxOK | RxErr | RxEmpty | RxFIFOOvr)) {
+		cpw16_f(IntrMask, cp_norx_intr_mask);
+		if (napi_schedule_prep(&cp->napi))
 			__napi_schedule(&cp->napi);
-		}
+	}
 
 	if (status & (TxOK | TxErr | TxEmpty | SWInt))
 		cp_tx(cp);

---
base-commit: cb284914e749388eef402938bdb3115fe1f6d337
change-id: 20261021-b4-8139cp-napi-8e139f232736

Best regards,
--  
Colton Pawielski <colton.pawielski@gmail.com>


