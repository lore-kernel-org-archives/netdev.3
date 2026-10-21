Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624367;
	b=E3zsTgqHier3W9jmfhmFd11uMIMOS93KrRUV18xeDaAxBzrBO72brWsKbJ9FqM6P+4q7
	 5AALfqKw0RG/rXb6AMwS8EkX9cP3cY7YXvHh7ivPyYXTb0GO1FUdQWwwQg2HXSJR/8hDL
	 QrIc6Lbw3y0eujTKxr4c7AWICftMS0vZoCMXFEHHJQjgLmtQmOqPmlw+LLeg9dyHs53bZ
	 eH0EJaJtqVxiCzgeLYvRzamw9M4IL0ICAzVzihr0HyhsjkpLU6P+yee3vRmZWGVhM0b5d
	 FWg6UZ3fh7gCPd67VkVlK6kOIy4acer0NnaS+90uuoKa7EUp0rXs5HXCpLD3FjoEDXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624367;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ylXvEHomDk37upseZ/fh6pc49f7rFFf0fRiYXkMT4tk=;
	b=rX1vWHNqTbdz9mxUcmhuydyz7UYis51Xc++IV+Vrm6oPR2WoV7XG4uq+TEpIsIm6AG+0
	 j7Q6SeU/d4zB88HvDa/R6bI9cetTrnJwK1OicUXAPd5GfXxntmTpRfROrRej+uCZid2Tq
	 m19jxL4HhHUF5kM4FuapmaPtMspVQMa5n7LKGwpb3r1sgTvv+KgmMvJqzxyEA5GgMwlFZ
	 nm4OldfNcVqkZf7jm4Uk8jrlwZ64a/OJyak3Ksn0xCrXlvRxnVo3ayYurBBntg3t9UgEU
	 Sd1HVzq7wls89DnzaD5UEQkVkkCH8uwcxTps7+d3VsW4J9WgdBUy/IwYzUUEfCBAG5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4C6VYHe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB15606A31A;
	Wed, 21 Oct 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4C6VYHe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792624367;
	b=QhY3arrDGeHUKwENnnlx+zJMjpmt6Skag9j+H7fT+rWkuT8vbGmWhw3woq3WDKhVi3r4
	 3QinLjXxx17JoPFRZ/qKj/dJN3HiDV6VNkFxbixhJxEYRmWqWWSkpIt9MXwFkeGfFrPhH
	 Kc4PbbIXe9NNldlZoMON1CMPHIpaaV7YMSicl6umuO8LfM2DGxAMO++Z/ur/2Q6Jbx5pg
	 FbOX+x3ScVOjiHsayqG8U/CI1mK42+6zOva5O+zwce8W5GnjLfEjpQOLVxWiyISxtF/Wm
	 a15sX0GiFVob29jOKqE1JJkFYODCx35Citn4RVeTMfnSBavUBRH6I8SZf9OI9UgN2iA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792624367;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ylXvEHomDk37upseZ/fh6pc49f7rFFf0fRiYXkMT4tk=;
	b=QaBYH5B5tOAlN8E+7+1SDMxEJdTfTQ6ggkXRtVf3Hf+nygRTMu1YWXo4g5F+DhRwk9+E
	 JomlrqvzsG3yRD7qkhWM+lDje+yLDwOmsIH2xANsDeBgC8PpoNU2xkO0h8sVrZC/6emsr
	 w1zyy6fAdQ+Ok+BcHCTJJkV8KTOQrokSOPQIStKHjp6io0/HcqCUHY7BSZ8EzOjtCKhpb
	 15Do+XjjKuII9nikpUrErKKrIz5TlfLUzmLdWkHNbZxX7ZY3TuboFw1YvcJ6KkiBhjYlV
	 2/7OwEfyu7edfuT4oYuvZXIg1fWSwNIQaeFvfeRHK27vGfY4RkuCFgjj9MDUJS6Qq/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 876681F000C1;
	Wed, 21 Oct 2026 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624367;
	bh=ylXvEHomDk37upseZ/fh6pc49f7rFFf0fRiYXkMT4tk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=S4C6VYHecMm2xuYhXjUgU340yOUYntxc4Rezl1GDUdzdtc/NaByI4haANm9zmRSo8
	 ETE+DXT5prjI7xitDoV+YwGQiDCAQTCDRBfPyEPNfnEm5ccwNq8Ct3DqaWcCA9f73C
	 pW7XKwz09mwrhm9YtlUcbC3DBnjw+mL308/lNXRFzNMEyzozYp0+OouwQyrJd1rL3v
	 rNPh/FvW+Jwmhxz+nlLsfmGuTEHHlxb+VkSSoU8ajANxDPBVyN4CN13exj39D18M2v
	 dZii81E/KMSFf0ntoa8OxwIbyXMdelz7EpzOtTst2JolEoZ4KkrEdIuvw0swmxuSt5
	 mPWMJAg58gjDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DA98E43450;
	Wed, 21 Oct 2026 23:12:45 +0000 (UTC)
From: Colton Pawielski via B4 Relay <devnull+colton.pawielski.gmail.com@kernel.org>
Date: Wed, 21 Oct 2026 18:11:41 -0500
Subject: [PATCH net] net: 8139cp: close race between NAPI completion and Rx
 unmask
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
Message-Id: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMBCE4VeRObtgNmKtryI9aFzb7SGGREtBf
 PdGe/wG5t+RJKokdMWOKB9NuvgMUxZwr8E/hXTKBlfcmIoNjTW1xt5dID8EpVYyZrZ8sw3yKUS
 Z9XsFe3hZ8fiPaRvf4tYzheP4Acf8Luh3AAAA
X-Change-ID: 20261021-b4-8139cp-napi-8e139f232736
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Palmer <daniel@0x0f.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Colton Pawielski <colton.pawielski@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792624365; l=2614;
 i=colton.pawielski@gmail.com; s=20261021; h=from:subject:message-id;
 bh=xysNCUVTIwjH2gSf4rA52HhJwF/s+KbxeRxHiscJJ5M=;
 b=gwUh2h96+C0ZYB88boeAGPNY+yTTOLkpwJE1w8gE6k6U/SyfaMhc1Hr6DOGDUyPsb3zMuV5Tu
 5p3PMWu5h6NBUZq0EYzn42RBit3vE8WuXqQMbyvYukNm1I6yZOBWcvV
X-Developer-Key: i=colton.pawielski@gmail.com; a=ed25519;
 pk=QFoKkkRiV70QY509+evUr/DtmgPqjU3fLV0TaScMuE4=
X-Endpoint-Received: by B4 Relay for colton.pawielski@gmail.com/20261021
 with auth_id=1266
X-Original-From: Colton Pawielski <colton.pawielski@gmail.com>
Reply-To: colton.pawielski@gmail.com
Content-Transfer-Encoding: 7bit

From: Colton Pawielski <colton.pawielski@gmail.com>

cp_rx_poll() calls napi_complete_done() and only then takes cp->lock
with interrupts disabled to unmask the Rx interrupts.  An interrupt
that is not masked while polling (TxOK, TxErr, ...) can arrive in
between.  cp_interrupt() then sees the Rx status bits, which are still
set, finds NAPI no longer scheduled, masks Rx and schedules NAPI again.
cp_rx_poll() then carries on and unmasks Rx anyway.

From that point Rx interrupts are enabled while NAPI is scheduled:
cp_interrupt() leaves the Rx bits for the poll routine, does not mask
them because napi_schedule_prep() fails, and the level-triggered
interrupt fires again as soon as it returns.  On an SH7751 LANDISK
under combined Tx/Rx load this interrupt storm was captured with a RAM
trace right before the board locked up hard.

Do the completion and the unmask under the lock, as 8139too does.

Fixes: ab1e7e1d2666 ("8139cp: use napi_complete_done()")
Signed-off-by: Colton Pawielski <colton.pawielski@gmail.com>
---
An AI coding assistant (Claude Opus 5.5, in Claude Code) did most of the
debugging: it instrumented the driver with a RAM-backed trace of register
accesses and IRQ entry/exit that survives the power cycle, and decoded
the trace after the hang.

Tested on three I-O DATA LANDISK boards (SH7751R, RTL8139C+ rev 0x20).
Without this patch, pulling 300 MB over ssh while reading the disk
(concurrent IDE and network DMA) hard-hung the board in 7 of 8 runs.
With it, that test passed 8/8, 3/3 and 3/3 on the three boards, and
copying the full rootfs and multi-GB test files over ssh also completed
without problems.
---
 drivers/net/ethernet/realtek/8139cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 9016527e229a..a9334d3a0f7d 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -554,11 +554,12 @@ static int cp_rx_poll(struct napi_struct *napi, int budget)
 	/* if we did not reach work limit, then we're done with
 	 * this round of polling
 	 */
-	if (rx < budget && napi_complete_done(napi, rx)) {
+	if (rx < budget) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&cp->lock, flags);
-		cpw16_f(IntrMask, cp_intr_mask);
+		if (napi_complete_done(napi, rx))
+			cpw16_f(IntrMask, cp_intr_mask);
 		spin_unlock_irqrestore(&cp->lock, flags);
 	}
 

---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261021-b4-8139cp-napi-8e139f232736

Best regards,
--  
Colton Pawielski <colton.pawielski@gmail.com>


