Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AB44D6AC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752759; cv=none; b=Zu7aMpyL5ifDGOj5imOKMFt5HiKzG9X8MkX32cfp5sEf8EAQH6DKA5tZaO4fmKay/s93N9BNWXcOiPUAkuqSsnGayEbFTi8zYoPNaCFTqx3KkNj9wJp/m5XIGJcmCFYUiFz8bpX9CIa4QXoMvl5cXv9qY81FXzPgYWlkZNEVP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752759; c=relaxed/simple;
	bh=aJVsoy5Trk1oVXSy6lO13HBYy2aSxZSVKLzYy8qqiKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/q9JE9Xc2XcsMZHu1WIVGMr14z82jYtHRBbvJi7QwGJqd6zayujH3YdQNrFnWemxHeFXLDgblywPCOtQVlgaL3gmI7NsB5f/0xarpEJa66JHhAQZkqaCrwvGmyXYJQz70sdnlhZVXRyJ86eb0x3VK9mTecwTL1sfC7y3SpgrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcCAB3cU; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcCAB3cU"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e22e123350so16651195ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752757; x=1791357557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=HcCAB3cU+UouU2Vh+4JuDZ1pjHM5Ba62oUWGDj+nGEeXw3iLRSwv4uUmA1yUj5tLY0
         4B6AUdrKPk4977leORDoQS4T73H5y4bjxuUvwteLQSciU0mdkIgo1F+gVSEZfeg+NNLQ
         P4CtAfxfG+iuidcokb5r2zO68rbWe9A75hn9wZ6jmOGMsuzjb6DmqsOiUxFeiJLxBK7J
         HW3s1wanYjCb5Ge5ZP5opgqTUjyi1SncMKFBoFleUmBkl4aQTkpPzKh9TeEkSW20Bdgb
         QsIc6jlSkLdtE5GiVvlADm50LKA9AIyaCGY+Om4IQyyS66d7PUaG4qVdrK6pGn3VvJqq
         R0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752757; x=1791357557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtXRhGuw2qVKHIOiXDCs7JborWUyDWhbjStFj79j+rc=;
        b=1l527sH3LBEJj0+biFMHOZqLuAxpgUFoRLEzm44ncpzwxOxRLwIH5/rm8UD4YCgWJw
         Jj+BxocqwHYddf5xFYVjTV/dCZDPtN2EDdp9Zg6haMQwsL6nJFG4pzhvxLq1Cew8d0Bw
         4AaqbzWTSS/9IHzTf5K2x21XUJhqr/73Ey1Eo96KjoetJuJNIRzRqIQH39l8xpEfBcIO
         V35M+c/tQFjRmf1m1Gj1bkEa3zxePC3fX7W9g7dk4b5s7d7UljyNFCcqGTygQtLhe09t
         fp++lOMXefM14uim1BPLfVfjDcZHSmpej6ywyo6HwzWtSSqNuDP+no07GcuFLcGyI8U2
         1X5w==
X-Forwarded-Encrypted: i=1; AKwUvByi2Ocngz/bk/C1bG56CPTcfoBzhTApye7AI9DDJ0NGO1iOuR15RtR7nIb0E7gNxSsNXBPpAIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiH8hj3v1a1fdREGIAs1dddMbqe2CgL7LI9gsveq6hymejzIhv
	3G0CcOV8SN3UaLMGUe6xFbW5dYadKeuJZfNxVkNoy8AQnS3SGZ8/+hQXueRQ9Xdz
X-Gm-Gg: AYBFou1NBET+BalDYQYEXBWEJe5DOajBI3neEJlGTMtXEI3stcPfI379ueuiy9qG0Hk
	0aMux0beyUyXlR6dyoFgqS21Z2US71S/tEWx2BVNDTXpdtOidNaM98FO70ZW9mdPUuteGNTLcG+
	qeD9oQaVuwB0B4BlZ9h2X0qIpSG53JWYOKrDkqSs+o3V1WQtXpgxl4NWUJGllt3ZZX/HkK4IQu3
	5VjqEpduwmtyhj0+eipSXP15+NzfqrAx3zAzEBavpW6LNc2mjLyDAjVDYF9eT8VelQkwaDKsgHx
	c9xM52BZpcI6R4IWA7atTD+M3t/5ACicK77RKwrr2Li7h6Yr8UUpxA85t7ah3W+6B5SjBnI9s7s
	KJiuLaDqeXC3fuFFKZe7vezKHio5AVvhdyYfwqaa+XXK96kAiB439kmjrFQeM3V5MTW1+/9RSz8
	1dwTC4OeLn4eE1iFocTZZhqZbi1lW0o+XiGu0kW1cLJPYZKqMexyHGXzT1Hj7KBjzPz/8Q0MhzE
	x0LbdQhPrD3e1Pofx6t/wR5niFcw57Vja/JSR7GqNRryFidADT4j+nxcMBYovyyD+rNYEAL4kdz
	MQSTC5tskTegmOYWqTmC
X-Received: by 2002:a17:90b:4fd0:b0:3a4:a3e8:22ff with SMTP id 98e67ed59e1d1-3a4d1509d56mr448821a91.19.1790752756998;
        Wed, 30 Sep 2026 00:19:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4caec0f28sm2256687a91.17.2026.09.30.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:19:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
Date: Wed, 30 Sep 2026 07:19:12 +0000
Message-ID: <20260930071914.421586-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930071914.421586-1-benquike@gmail.com>
References: <20260930071914.421586-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_spi_transfer(), each SPI transfer reads
sizeof(struct mac_message) bytes into cas_ctl->tx_in_buf:

  cas_ctl->transfer.len = sizeof(struct mac_message);

However, ca8210_rx_done() only checks the received packet length
len = buf[1] + 2 against CA8210_SPI_BUF_SIZE (256). When buf[0] & SPI_SYN
is set and priv->sync_command_response is non-NULL, memcpy() copies up to
256 bytes into priv->sync_command_response, which points to a
struct mac_message object on the synchronous caller's stack, overflowing
the stack buffer:

  BUG: KASAN: stack-out-of-bounds in ca8210_rx_done+0x117/0x6c0
  Write of size 256 at addr ffff8881009e7c40 by task swapper/0/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   ca8210_rx_done+0x117/0x6c0
  ...
  This frame has 1 object:
   [32, 182) 'response'

Check len > sizeof(struct mac_message) instead of
len > CA8210_SPI_BUF_SIZE in ca8210_rx_done() so that any packet exceeding
sizeof(struct mac_message) is logged as erroneously long via dev_crit()
and dropped before copying into priv->sync_command_response or passing it
to ca8210_net_rx().

Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
into ca8210_rx_done().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Check len > sizeof(struct mac_message) at the top of ca8210_rx_done()
  where dev_crit() logs the error and drops the packet instead of silently
  truncating memcpy() with min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3).

 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 01af4f9..a990a0f 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -686,7 +686,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 
 	buf = cas_ctl->tx_in_buf;
 	len = buf[1] + 2;
-	if (len > CA8210_SPI_BUF_SIZE) {
+	if (len > sizeof(struct mac_message)) {
 		dev_crit(
 			&priv->spi->dev,
 			"Received packet len (%u) erroneously long\n",
-- 
2.49.0
