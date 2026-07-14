Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D373472790
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034238; cv=none; b=pajurRalMvIa+kW1irvMkoVhFNwUNRXJVvKbUW2aYzju8Ve/ZQqt135iRyEOqE+HArQ5hpXfuH1/A2XbQd210L93kGBBaUBi5HFJZ+RrOK/FPEdRoeAnhQyjFRpRO7cGAFkh+FtfoQiiKw+dJ5CRq9BkHQbe/0PMlRAUVpnTpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034238; c=relaxed/simple;
	bh=+9LSkEaOqHP5J+gwKCY481xJEYJYJF7buSxUcCGkD+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNjXedmGbTIk2zzX5XY713htJfidfNi8hd329SMb5MBWofobTb9d5KVMMHV5pqDw0GZgcYJ1hJS4NhOFI5bkX0cj3uCXBd4vPlv83f1beqzSnFBmhu87x9UVivalXY+QupicZje5DgFtjqJBwjga6rl+T2lvDjS+J8qIqARqbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=oXNuM1us; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="oXNuM1us"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-470174001a0so499497f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784034232; x=1784639032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcF0L770TQKMQqDorbzgjGu6vJT+Lw4syVjdxxXe8x0=;
        b=oXNuM1us0X+T1LlQf5qFfxZTFuukMAx5HuDd/w/MKIKoGVq19fqeVU3x57f0cm8Cah
         LIhWDgLE8aH+KyAq2iKrCHVUP8hLN7eG/c9N2/X0qEMEoGTa6oaY3G9kBDghZwaXY0U5
         fshcOKovEIbIjcshNdzTP0yfbO0Oc40zUPcLsasVvjivAQ9V4AX3BVGEEnq7+QAuNEiB
         FNgyo7sjQHVfrgdOKSJrVLBaqjuSgJ6kq1SmD+CqD9XT7BlFIOvp1M3LYbP49chPEjvz
         XFSIwbZmL9aDC5MqfwuleqLiHR783CX9QfW1fnOs/XLsHIiHEwyLnlGqJj9ZkGjeTaDT
         kzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034232; x=1784639032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcF0L770TQKMQqDorbzgjGu6vJT+Lw4syVjdxxXe8x0=;
        b=dmYPOhh0qV50cfe3j8Gg4eW61p9K5jBki5q+HsLBFn/ylxhxaXwOO2UmD0LLm1YBnD
         zy5A7t/p4L43RhGiLyfEW9vLmxOr5M6OduZmbDztMXJrENaQgjUTNp+DPOa8OxEH4BVw
         0s4iE+yYjW0+J53MqG69kT0ufSoFGxsAZgK4XzblhOeHhgOh03rDI0wNQ27kfO6BQjF6
         sy+s7dz5/Te00vMo03gDI1PcQgJDMaAqVHmGilZqoxjVYKn8d/tJ+H9yDAJYzqPBoofV
         E642l3abwUpsffYcgh6RVsXydXGtVi1znl1TVsXDsOPiVYlUlKz+ThAkrIUHKR0vPch8
         wzkg==
X-Gm-Message-State: AOJu0Yz9hsMBKj6b2moWhVhJolptCXCncBexuQ2y5b4TFJH5Cq+5r2Kh
	eZ6SW5Z333xo/mVPLy0bSjhVhIgskUGUiWUeWcXCYIh4nQ6i8E/17GrqShk6sbYBt/sk
X-Gm-Gg: AfdE7clEPXLrg3qwgOUyWpBaEpD+rDr1wfk7u1bx5nsvmh78B0Ro20dyXpYgFVHWkRt
	UoF2lzRIbJ3A0Rn4uobXv+DAMH+6gtGFbQoZqY6uGawmEeeoSfkOHa4ThRY7qHBYJel933sx3pk
	/VYluDqH/zFH25FZFBdWDfyGK6Z1W+kZNSYYFi0KjiT/wjDkrveISXOX2KJtGTBpafoaA5kFm1B
	kqzTYXEpDpc8xT1lPo7JczPl6Yrx6nGDydg+2vKrCv/HNdzxLswwnwkjRUUAt1b5MQcyqYVachg
	TKTfTJ10VKscJFkZCnt5x8Igk9bnTeLOk5FxVvLPfgBb0bloOQ5fEfgmKkAoj1pHCDZ4zJ0j7hp
	LC19+CbVjuCY83gFtavadyAcwQJnnNX8nzyPxW665U3rctblaiYEPv1OKQoYRPSWvSFOQ6AkKtS
	R/FWgVN9/acz0QjMRu/WCPKZqrhpjnl7LN1BLjSRuDdtVUiLE43ujf5oQNejazsji0Lf3wxnitW
	WAihQHyxhJadfcxe8npq6FYjo/kkBGfaE8=
X-Received: by 2002:a05:600c:e54a:20b0:493:a573:179b with SMTP id 5b1f17b1804b1-493f8829b05mr88159195e9.30.1784034231418;
        Tue, 14 Jul 2026 06:03:51 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm79484005e9.14.2026.07.14.06.03.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:03:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] mctp: serial: reject zero-length frames to prevent rx buffer overflow
Date: Tue, 14 Jul 2026 15:03:48 +0200
Message-ID: <20260714130348.72716-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCTP serial receive state machine reads a frame length byte in
mctp_serial_push_header() case 2 and validates it upper-bound-only:

	if (c > MCTP_SERIAL_FRAME_MTU) {
		dev->rxstate = STATE_ERR;
	} else {
		dev->rxlen = c;
		dev->rxpos = 0;
		dev->rxstate = STATE_DATA;
		...
	}

A length of zero passes this check, so rxlen is set to 0 and the state
machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
incoming byte is stored and rxpos incremented before the terminator is
tested:

	dev->rxbuf[dev->rxpos] = c;
	dev->rxpos++;
	dev->rxstate = STATE_DATA;
	if (dev->rxpos == dev->rxlen) {
		dev->rxpos = 0;
		dev->rxstate = STATE_TRAILER;
	}

With rxlen == 0 the "rxpos == rxlen" terminator can never fire (rxpos is
already 1 on the first data byte), so subsequent bytes are written past
the end of the fixed 74-byte rxbuf, which is the last member of the
netdev private area. Every following data byte is an attacker-controlled
1-byte out-of-bounds heap write, and the overflow continues until a
frame (0x7e) or escape byte resets the parser -- effectively unbounded.

Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
discipline and bring the resulting mctpserialN netdev up, after which
the bytes arrive via the tty receive path.

Reject a zero-length frame in the header parser, matching the existing
upper-bound rejection.

KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes:

  UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c:370
  index 74 is out of range for type 'u8 [74]'
  BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
  Write of size 1 at addr ... by task kworker/u16:0
   mctp_serial_tty_receive_buf
   tty_ldisc_receive_buf
   flush_to_ldisc
  Allocated by task 152:
   alloc_netdev_mqs
   mctp_serial_open

Found by 0sec (https://0sec.ai).
Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/mctp/mctp-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..1e3d285c0500 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -313,7 +313,7 @@ static void mctp_serial_push_header(struct mctp_serial *dev, u8 c)
 		}
 		break;
 	case 2:
-		if (c > MCTP_SERIAL_FRAME_MTU) {
+		if (c == 0 || c > MCTP_SERIAL_FRAME_MTU) {
 			dev->rxstate = STATE_ERR;
 		} else {
 			dev->rxlen = c;
-- 
2.43.0

