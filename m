Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AA281530
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786325765; cv=none; b=kUux9hjzpCx/i99/bUBIfC/9or74TUCt56WT01vyH/qLlzL++mo4TmPj9nacefua1ObkLDdGCycjRQlkV9Hbu4SD5vn+MHFkV8GPNUO5thsLo1CKZpos/f0lHZZ8Yq4lOY3OuO4OQe18UnDLr1azgXrYhT/gN7Qfm164zxweCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786325765; c=relaxed/simple;
	bh=hgWVXzJsJ4d0sRL88GH49EhKXhlQYDNwAM1F3JUS1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz6n9CbsImbuEPxWJEATviWYZXIuImUghEvHYiWBW15VwkPwOM9oKjASQguxCK/ZCNH1+8pwf766wJ+eNmDQ2SEFxWpPekhpdIk3SW/9dmux2DuTnf3eciLNgPRvo6AUerrIiHpI0P3ANcigJKXIXtFvfeIPfWXw+9jnZ860TCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbdXXSXX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbdXXSXX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so14178695ad.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786325763; x=1786930563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aiAA/a8nJJhpvuOCjBB2Gsecn2IfMJTVx/RtNy6N2qI=;
        b=lbdXXSXXiTYzfhnVVX1/YSDP1mZ9VLt2Cy6d+J/6K3akpcjwiV2/7BSq9AYt67/UyK
         ZgMMSmhZfzpXl/DY3OugaxmHWCaqWgL9ZDvbyKZx1r+yi1wZIrFdfSj6p9F44c0ryjdF
         7MuGGdTpyG53dtxmk9YqjjX6Lssc+bkm4us/tUFv+9FQhxb7yvjuALmzOCYH7U3s1bQz
         HlHen2K/Ky8jrrBSobzj0bFyDk6VBq4NrpRyYNiAjKA/3Qq4RLUlMwafNr5jyI//zST7
         zfBjdqWoZ0XMJtTko1CTu1n66wX7NXqErjmk4puN+8nLpZp80e8W7l+UIkjPZpTiI57T
         5D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786325763; x=1786930563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiAA/a8nJJhpvuOCjBB2Gsecn2IfMJTVx/RtNy6N2qI=;
        b=aORJtwTK+JVBwzRxxmwGdlhyjmYZrlzyUG6Y8HPuX3YJshPGWC0O92lCMK6GwFs4gS
         EUbJN4Mzor3syjORF22wKEI9asdd60fn6xBaiwRcvPPqz8yuXyQkoOmQ4fKJ/BtqfBxG
         piMNalOlt6v2mxC9DS5nY0KQie1IKEyM92bWWoh+GHeOmOEGDLYTl8NLxzSW41zqG/yc
         ZxDrBMiYebU2U5GxR2/ckKL9naUS+iEUdHVNr8P80+nZmkcuOeKcZZWP7JZ0AKRTlDkZ
         rR23anXAFPVZlYEF1YtoaPacqs+37kO9da4rn5ina048gnhk2M/dqKE+/QndJuFLOyXg
         1crA==
X-Forwarded-Encrypted: i=1; AHgh+RqmJh2xXJwtwWUQLStauwiAeAUVa08NHsylOx82QUsAtvqRqQciB/qdl/fhamM5ruikY1fSffQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNsfF6VbWpHbJDxBUlJXX2bTYm8wgV+WfhXR0cqDRpIGF0Exv
	Kqzd6KH3cG0g/QcD1gapOy80HL7KJhFOW09IRNC6e2LwQwVY5jMxd+ug
X-Gm-Gg: AR+sD102TfGHQUmuV3P74YbAe79Djdr9ySbstNgGR/y0JUvCHQrD5Wcut7OE8rv26jw
	iotz6hxKMegaeBBd49xZM7RhycVhhKHBTavCeM2q+xt+pMnEOS5l3iaLyR36CimbfghoI+f9a5s
	KWWIKiK9ppaliUCJG1a2JTtSH+3ucHKOa7I8KJWg6Xuv2UYV+M2FetjSAZ3FEIUk3cXmhl3nXxV
	sjQtU9LFeJIC8pyQOOAmxuhrLfazc9sqwbc8csamBVghk8R2pEekJewx4g+yKyt7rTw8b7/FJGX
	fcpyd0/7AjUJ6whP1jltsXzXFU9zghtlEj8Vk3ckV0zf3CQK4+uTXN/2KiaKuhsyUBUSA6dX78G
	4BMAsthYpoXYn8OTIF1Qr4z6/kUy9KFxGe3cRUhCBdsRf0DOrVTv4nPGZZvJX7MBue3qf66WsX7
	6yD9sQEpN72TOS9VIZKfj9ssxT7QV7QEvbZqZgF+pX4heTTGUw9QsA/V6ogZsqtq8=
X-Received: by 2002:a17:902:d581:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d0ca75b37cmr502324835ad.11.1786325762707;
        Sun, 09 Aug 2026 18:36:02 -0700 (PDT)
Received: from Inspiron5409 ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac19esm27558895ad.9.2026.08.09.18.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 18:36:02 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for AX88179A-based chips
Date: Mon, 10 Aug 2026 09:35:49 +0800
Message-ID: <20260810013549.2510969-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
References: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the late reply. I think the previous experimental workaround may
have some race conditions, so I was seeking for a better solution.

> I tested the 100MBit connections mainly with a AX88772E 100MBit adapter
> (UGREEN CR110), which has the same firmware (1.3.0.0) as your and my
> AX88179B adapter.

My adapter is an AX88179B with firmware v1.3.0.3, not v1.3.0.0.

> You did not mention which device is used on the other side of the
> Ethernet link (or maybe I missed that), could you specify this?

The link partner was the Ethernet port of a ZTE ZXHN F7005MV3 gateway, not
another USB Ethernet adapter. ethtool reported autonegotiation support and
no advertised pause frames.

> The only way this could be coming from the driver that I see is via a call
> to ax88179a_stop(), which would clear exactly that bit.
> Have you traced this and can exclude that this function is called somehow?

Yes. I added a dynamic kprobe on ax88179_write_cmd(), filtered to
AX_MEDIUM_STATUS_MODE writes, and recorded the value and caller stack.

During 30 100baseT/Full-to-1000baseT/Full cycles, four transitions to
100baseT/Full lost RX. In all four cases:

- ax88179a_mac_link_up() first wrote 0x0102;
- there was no intervening Linux write to AX_MEDIUM_STATUS_MODE;
- about one second later the delayed worker read the register with
  AX_MEDIUM_RECEIVE_EN clear and restored 0x0102.

All 71 traced writes to AX_MEDIUM_STATUS_MODE had
AX_MEDIUM_RECEIVE_EN set. The complete 1,209-entry trace contained no
ax88179a_stop() or ax88179_change_mtu() caller.

The earlier failed-state dump also retained AX_RX_CTL at 0x0198 with carrier
up. I therefore think ax88179a_stop() can be excluded as the direct source
of these clears.

I also repeated the test with the same AX88179B and ZTE link partner using
the ASIX vendor driver on the Arch host. All 30 further
100baseT/Full-to-1000baseT/Full cycles passed. All 4,415 carrier-up
100baseT/Full samples retained receive-enable at 0x0132. A separate trace
recorded 30 writes of 0x0132 and 30 writes of 0x0133, with no write clearing
AX_MEDIUM_RECEIVE_EN.

Dense sampling did show the adapter changing 0x0133 to 0x0033, or 0x0132 to
0x0032, while the link was down during renegotiation, without a corresponding
vendor-driver write. The vendor link-setting path then restored 0x0132 or
0x0133 before the link became stably up.

So the device can clear AX_MEDIUM_RECEIVE_EN without a corresponding host
write. In the failing v6 case, the clear likewise was not caused by a Linux
write and appears to be an autonomous device-side change.

I do not think this proves an unconditional device-side bug, though. The v6
driver failed four times in 30 cycles after writing 0x0102, while the vendor
driver had no failures after writing 0x0132.

I therefore tested a focused v6 variant that writes 0x0132 instead of 0x0102
at 100baseT/Full. Failures still occurred, so retaining the RX/TX
flow-control bits alone is not sufficient to prevent the problem.

This points to some other difference in the vendor driver's link-setting
sequence, possibly register ordering or timing. The physical xHCI host in
my tests versus QEMU's emulated xHCI is another uncontrolled difference.

At this point this looks like a device-side quirk exposed by the driver's
link-setting sequence, but I cannot distinguish firmware behavior from
autonomous MAC hardware behavior.

> If this can indeed be attributed to a bug in the firmware of the
> adapters, I would add your patch to the series with an "Authored-by" you,
> as this sounds like a good solution for this issue.

I found several race conditions in the patch. For example,
`cancel_delayed_work(...)` only cancels pending work. If the callback has
already started running, it may still be running when
`cancel_delayed_work(...)` returns. Therefore, if another execution context
performs a read-modify-write operation on `MEDIUM_STATUS`, there can be
a race: the link is brought down, but the worker subsequently writes the
RX-enable bit back. This particular issue can be fixed by using
`cancel_delayed_work_sync(...)`, but there are still other races.

One possible solution would be to add a mutex to serialize accesses to the
medium register. However, I am reluctant to add too much synchronization
machinery for what is essentially a defensive workaround, especially given
how infrequently these network configuration operations occur.

I see two options:
1. Leave the code mostly as it is, changing only
   `cancel_delayed_work(...)` to `cancel_delayed_work_sync(...)`. This keeps
   the main code path simple and clear, at the cost of leaving a few rare
   corner cases unresolved.
2. Add stronger synchronization to eliminate these races completely, at the
   cost of making the code considerably more complex for cases that are
   unlikely to occur in practice.

What do you think?

Thanks,
Jianhui
