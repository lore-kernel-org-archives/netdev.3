Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176836;
	b=IBxhskQzLX8GmvpMzI0K6TG1RLcJohmFL0Q1dySa7uJrLOMA3X2pChJ1j6Fsypyckvlx
	 wfDXiatzM33Gg4gTyHzCtqbrkGusMY6U8NzU5R7HwzSRApT2vw6RKWyeqwmrqNG+rv9xC
	 8gerpNsapfcL6YJiTmulXt5enQ9oNX4ynl25zUSVVxr0iCuj0Mojyneyj2vWYxdwlPteX
	 3FYk1o2/uNZYINYLpEvA2vi7hJVg74hdFGlZAEOaKEg0Dged48V4lwPkCrkkPi/DEkEhW
	 hMDt69yx7FO7NaJ3psCO1WopcuiZPrHkawN+kb2e5L2m8yddNu30qpPyAltDWKl/r6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176836;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3X8z9HiQ90Esek9ry3qYxDhUP6ikQF/zd5RI1d+W1YE=;
	b=X4fdfemN0U3SgLq10n3aYDTPQMjuw+1rtoYXvAUKsc7NZO+HJIRl2JhAxjAUuQMOtGcc
	 Wb7ib1jKB4cOW8VVx64pbEXSA5ey+q2LmxLY6uDDffDS5f/qGi7b+E3Mah9sWuFOZWreh
	 b/gwxFv2rScBM3YR7sXmQj62jMoYnldEUe7zeQOTfZ+re5ciL8oB77IW9OcT+UkCVR8YR
	 3Y0G3Ymg+DhFyjJm9b9GR5HCAnLqd4Eb8/I5v2CJN2uHr73/cqmpbggHBPqRG2D1Vtq/O
	 LIAIjH/kB1DtisvZqzOo2ZHbqeP2NqON9Qnd2bW82CXX+cEBStOa+rvCr/UPQNutZ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MyVYzr3f;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7701606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 22:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7701606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MyVYzr3f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794176833; x=1794436033;
	bh=3X8z9HiQ90Esek9ry3qYxDhUP6ikQF/zd5RI1d+W1YE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MyVYzr3fGjcb8IVV6SUd7vXptT969yI81velePfFgEwJ8ccdIDM2lWiIXILjNbq7Q
	 h2XwGgQTDf0Lq5qentju0Mx6r4+cuiYIoePN0N0DSkvroClbyWd2A+CL4q2ebaVHzC
	 I4+FgpSHyq0RFoNXTi2bJpP5UYDiXg04ySJaFzxr2uLq1Ng596IDr56bF5VQU+ZdXN
	 MmTYW86LeQbYV/kugxrfV+sc+vzTeOZN0mL0L23jWTTfvkS6kET7hUQfeEiNEHE4ug
	 AYKvGUu5Afz336Ky16nmw/5rb1LLF+bZa5OjR6j3NTrJexriJQWBwxyM6FaSSXZTnF
	 SnHJNqZNjhLtw==
Date: Sun, 08 Nov 2026 22:27:08 +0000
To: "nkapron@google.com" <nkapron@google.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: f_ncm: bound NDP length against the NTB
Message-ID: <VFFcAz18YOCdAGLJxQp8TZxPPL6-T5bPEHLSdIkdyWPj4Rr7dRgBoUrlYHMc_CYxsZXLbk2_xPPKx8uMzHzck8QUAC84Q2ZlluLo7JG-Ry8=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 5d8d5eeb64b5057d721702834f3b47afb57c5df8
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

ncm_unwrap_ntb() validates the NDP wLength only for a minimum size and
alignment; the sum ndp_index + ndp_len is never checked against
block_len. The NDP *start* is bounded, but the datagram-pointer-entry
walk then advances through up to wLength/8 entries regardless of where
the block ends.

A hostile USB host can send an NTB whose NDP claims wLength close to
64K while the block is 16K: the walk reads 2-4 byte entries past the end
of the RX skb, continuing as long as the out-of-bounds-derived values
happen to pass the per-datagram validation (index/length checks). The
practical overread distance depends on adjacent heap contents, but KASAN
flags the first OOB access. The bytes are not returned to the host, so
this is an out-of-bounds read/DoS rather than a disclosure channel.

Bound the NDP length against the remaining block, mirroring the
existing minimum-size check.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), drivers/usb/gadget/function/f_ncm.c:1254-1346 (ncm_=
unwrap_ntb NDP walk).
Longstanding code.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/funct=
ion/f_ncm.c
index 500c9c1..a0e2049 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1262,7 +1262,8 @@ parse_ntb:
 =09=09 */
 =09=09if ((ndp_len < opts->ndp_size
 =09=09=09=09+ 2 * 2 * (opts->dgram_item_len * 2)) ||
-=09=09=09=09(ndp_len % opts->ndplen_align !=3D 0)) {
+=09=09=09=09(ndp_len % opts->ndplen_align !=3D 0) ||
+=09=09=09=09=09(ndp_index + ndp_len > block_len)) {
 =09=09=09INFO(port->func.config->cdev, "Bad NDP length: %#X\n",
 =09=09=09     ndp_len);
 =09=09=09goto err;

