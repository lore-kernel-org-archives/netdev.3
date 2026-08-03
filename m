Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7E279917
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748494; cv=none; b=IXv1Ld2PEOlczc1laqFdCue+Nts/ZUPFyKD+LLZ570lPh4L8H7wVYuKTRzoZTzaw3+TZKa+Yz0GSzorAcaZ3U7T57zW6Es8ucu4wh/ybSQIaW58XYcAAUYxYWfYACipP3oPlVymbblP5RRR4aYd+s3Rkj0BpTUSkeeRUfYL+xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748494; c=relaxed/simple;
	bh=ddGi/WWEE6dLQ00tPVLWzMDSaH4IrzI/c2TemyW5Kdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaGKVBlNFLlO6vumyoxJ0Tz0GVtIBJLxMjEtWWj/Ge/U9rOP8E+Fv14biJd5CwZbZTtE7ymA5sAIq2BnEF+C85ykKyDL55FrDeJ4iTUmDKqFM+0LmwYYYxemBbe1u0sB3QJF6ezaNpjKwKQMTZmqvcVI62z7YPL0+N0K1DOLkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9ki8QQe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9ki8QQe"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc97653887so33116285ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748489; x=1786353289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vn2yoD3ty9ITTrrzg8yr4ALmpVmLt2wnyJR7mrvDrYQ=;
        b=A9ki8QQeKWYGAf+LENCbi3lFXVhrA3NPtXKbJ7cOsKQf67CzUs/bUu807KBLPW7e3M
         XmzUPu+u6wU9TXeHT2jfP3DtSLEk3V8qCUeakQ65b3Q2ClSUqU7GGvSepyQVU8M8W05W
         zPiKDeAOGtZobgYPcTqlqh9+AGgcH09OV/t/eam97f71OdKx9XakQtH66JCXuoUpJO3O
         0D4Z7p/cXNgUev3kHjOQ2cOHmejgxm9knqJRL/u2KKFj4A1SB6YSQbpD3IQm8A3HBtIs
         s52Od1CihjH9RXh82qNrTW4xwS0xv6K20wGxToJQz6EJmVAvDToNgn+/EukMKxlGrRgY
         4JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748489; x=1786353289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vn2yoD3ty9ITTrrzg8yr4ALmpVmLt2wnyJR7mrvDrYQ=;
        b=RsgS/PvKGeyId6JNqe5pePd36FVhC9KIZt+gAUGLzZOvhwzP3w329AOPQt9e97SI8n
         ijAauyZ2QQV7aoqP8WWmi1wywWR/DN3/sIxEV0zr3tjbjhwTHJ+KUv1oGb+b8vw3tR86
         SEQ+m/wSIoXUuNp8aO1tvlDhV7XCuY+fQlzqfB8PXySV4oJwAv+ki3MKMSwcv1ET5xBr
         ZjxSFYJPQjZp82Cpi59Z1t2EtNMKJNgVnJl67OGkep5FO1qJRYCU+OSctij8IkK6hJHr
         Fie3CH5Z4XdPOGvGJ+TRFl8P7lqmwbp82/tRQEp3BN5BBlbLReTvDHS2oDDfvcj7kt5K
         Jfpw==
X-Forwarded-Encrypted: i=1; AHgh+RpkZt+gIsL63M6EIhIi2FW94MIk4kVwaxgMZDRUuviVZ48axfzALB7URp/oIVjM+tt3pKceDGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlYty5aWZ9TdfYJQAkAi+sFDc+y6DuMCp0SzDzPsJt29WwnEi
	U8RvRa0kX0ZHTe+saY7FTUyzenmYwqzfs1xpgJx8npxUc6rVdhEfGBSn
X-Gm-Gg: AR+sD10SGpHNgcXzXt3OobtfCilsonhtl8PI1awCdInKxlJ2JE7/Q3QFOCZTfI4TCCp
	XNmRNnkJ/P4VQyhyyMGElz5Wba9ONIDp2J061Fknsu9iKHynT9+nmG+WNRLrKIAxAI59g63lqpz
	Pg9+if5jC/HCDU0ZV6Wp2CiVtqTu5Sxpq/eFqyV7LQJTQ2JA/Y3QjxoiSbzsBQArsQp5cVTMd3W
	Hyyg+gGo5ev7voxt1/7btjRdZdsTNuHzIJqLW0FAut5ML2C68uUhMRJx8jX/9WMIIFLzMC4TQld
	Og1v9o2QxJmEF2rHkrv4HPbMbVGhvGy6yOIKWY7Ll19Hee9JuVxilImQx7J6ZHSWTAjMcrgAbq4
	fjB0Hvp+k7bthU9EZ1+be2GX7GIrCBrJtWLa0zLOjRtZVRoTaJ/vIOR+A8i3qGU7opqk2x2O/o/
	Cdd8GX/WmV8P0H74zEiHS7+xy+ZtJ81dvWF3aJDrQMEs6rCnB2yO6gJYwCX/mBgRdoh0Rc+qnKW
	DeD4J4PE0HGdgXMBDzQbbEqTbluyGZcy3FTqNJoLQw=
X-Received: by 2002:a17:903:234d:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2d052286188mr88408515ad.17.1785748489288;
        Mon, 03 Aug 2026 02:14:49 -0700 (PDT)
Received: from C-PF5A3Z8J.nsn-intra.net ([167.103.78.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7b7sm34546515ad.39.2026.08.03.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:14:48 -0700 (PDT)
From: Sureshkumar S <ssureshmsd7@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sureshkumar S <ssureshmsd7@gmail.com>
Subject: [PATCH net 1/2] can: bittiming: fix divide-by-zero in can_calc_bittiming()
Date: Mon,  3 Aug 2026 09:14:25 +0000
Message-ID: <20260803091426.29050-2-ssureshmsd7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803091426.29050-1-ssureshmsd7@gmail.com>
References: <20260803091426.29050-1-ssureshmsd7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_calc_bittiming() scans the possible time segment combinations and
computes the prescaler for each of them as:

	brp = priv->clock.freq / (tsegall * bt->bitrate)

bt->bitrate is supplied by userspace via IFLA_CAN_BITTIMING and
tsegall * bt->bitrate is a 32 bit multiplication, so the product wraps
to zero as soon as bt->bitrate carries enough factors of two for the
tsegall values walked by the loop. The division then faults:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:can_calc_bittiming+0x32e/0xcc0
  Call Trace:
   can_changelink+0x8ba/0x2060
   __rtnl_newlink+0x1013/0x18a0
   rtnl_newlink+0x6b/0xa0
   rtnetlink_rcv_msg+0x6f9/0xb70
   netlink_rcv_skb+0x11f/0x350
   netlink_unicast+0x5f5/0x860
   netlink_sendmsg+0x70a/0xba0

This does not require an absurd bitrate. With the segment limits of a
typical controller tsegall reaches 256, so a bitrate of 16777216 is
already enough to wrap the product, and that value is below the
20 Mbit/s CAN XL data bitrate ceiling. Any CAN driver providing a
bittiming_const is affected; reproduced on dummy_can. Triggering it
needs CAP_NET_ADMIN in the netns owning the device.

priv->bitrate_max cannot guard against this: it is populated from the
optional "max-bitrate" device tree property, so it is zero for most
drivers, and can_changelink() only consults it after can_get_bittiming()
has already returned.

Compute the product with mul_u32_u32(), as can_fixup_bittiming() already
does for bt->brp * NSEC_PER_SEC, and divide with div64_u64(). div_u64()
cannot be used here because its divisor is a u32, which would truncate
the product back to the faulting value.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Sureshkumar S <ssureshmsd7@gmail.com>
---
 drivers/net/can/dev/calc_bittiming.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 42498e9d3f38..4809f5e0c96e 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -119,8 +119,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
 		tsegall = CAN_SYNC_SEG + tseg / 2;
 
-		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
-		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
+		/* Compute all possible tseg choices (tseg=tseg1+tseg2).
+		 * A 32 bit tsegall * bt->bitrate can wrap to zero for large
+		 * userspace bitrates, so compute the product in 64 bit.
+		 */
+		brp = div64_u64(priv->clock.freq,
+				mul_u32_u32(tsegall, bt->bitrate)) + tseg % 2;
 
 		/* choose brp step which is possible in system */
 		brp = (brp / btc->brp_inc) * btc->brp_inc;
-- 
2.43.0

