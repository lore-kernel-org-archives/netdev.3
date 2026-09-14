Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20124A4408
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420303; cv=none; b=uzbOlQim4XQGDVeHFLnFdQrRicsHnLDmK5bAFsW/OIx4UoHuTywHyA0cMbyUVsPY+Sf3+CWDr/y+cOhH6JYI93/9+WsxOfnAbpwAY5XaqwmtrOw5bqJ05HFxcA3yRqzxYfTLIvqKWfLy8E0tjI8VNK0awo+ixMYhhsdLyEem8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420303; c=relaxed/simple;
	bh=urEMJqkip8r8NUOYHF0OXc2V0NjD2LcpIt+Sm1C4lC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyZePSTfTuqVQ4Ogg7QKP1R911YUF8L75vDv59Tad5IDIpxLMc0PuvoM0shdZw94lcNxY8W/rbxNNVnmgYG2U9I5n4Xu4T9dahEH6M8TYqDJUEmHBkCHN7eYj6fAbGoMBBEkbs9wGi4J8NDBvla4pz67DftjaxNxdd9sGMaHoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=d39uCyYr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="d39uCyYr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d05d51553so32549805e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789420300; x=1790025100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+vmo4SiPc4dv8Etu0O6oCuBcVgzOf6ES9F0FzCUqMs=;
        b=d39uCyYryHOVdG26WBfKPGEIGCixeJxe0tqrkewY4zxOvkkxkHhq2pDMXfkdb0Bb1c
         iHxxv5l5cJcJaoaWFIHyL3Ki9YVMNk6Xt8uLEM7CVAZ7X7+S7U+hWpY9Ju9l/4R0WBbR
         6QBX+ueEkWNH8kufqZwCDPG3EnF7H79RtBNMw532HlrZw0eDcwgz+jAtP0sBReQY0beh
         OH4Q8m3yf66rgclNYrp4yELPwbXpK3nnNbKQdqxRernI+OK8O+paHkSmC+INQxL66/8b
         KYnEE9UK8M6vPVR96j4Ai2088SfWZvqH6LjwQkFvhEra0ycuttChCeucQTVqTMqKqvdN
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420300; x=1790025100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+vmo4SiPc4dv8Etu0O6oCuBcVgzOf6ES9F0FzCUqMs=;
        b=ib+XZnBLNajcFPILYBVwaIAXtTPk1eMYky5ODjeTAxAXFVr99QxJ+o6ZPj4IB4hkM6
         3KMQaXY+TABPhTvYhRMpJWiVT7TUt4/c3bIOa3X812AfjvVLhnSjhOnUabM4V32Q96jZ
         mnjz+MPn5yfB1CE+u80Ag9sBCeZupaA1rxjplXdqcO0tmc3d51j3HYfZMIm3Wf/ORval
         2upd11Gb5DhTryxhb39QaKXU5r52X0XV/SVzvFUmKTP6cOuTJkYGVCoIxeblWhjS6pCu
         nygH6/vLuWOtYmEXMhiz3RVr+KmtjyheZD/OpiVudizzG58oxVLn60Kc6R3RdyO7sTS7
         2LoA==
X-Gm-Message-State: AFuF++mEYxLhqlAd+0vlZJDgEij3e0pTV4OsKgfzU9K+CgUHK4OMKoZs
	B8glGAvuIrKQjZghSzk08VOLZhiLTJ8H/4dUSOJYZlQD1XBo9eNcvZgky/W84sm2Gss4fK5YG7l
	MXl8Ar3qAjV/fmxY=
X-Gm-Gg: AYBFou1XE3Gjz87NeyfEu7NFcl8vbt3VFwBOcB5REsNKkg+ATt/6u99hgxnaoHWup0r
	RGOuc6wwdeEpGQ9yQBMyH/vfh/hymgG90D+XwFz9Hso0+4D3V+T0AfQPkPS62R+FgLifBkonu0O
	IE+0dCS4O7lIaOTX5LISzwKVME0+c8KHw6ljjYhjcpqEzGdPYEebMTj6X4JFPttypIDhCIen9BF
	mWms1kkSRxvG075RPOKVRXWGxJOhnWAwq4msw3VYFYKO8leGTonVB/8IchWy18qfCt1L8Plsjat
	nmbIksDJzIa3fuXBSKUApM2jFh4/+Lnd7y5ygvRaE5g1si0m92Gd55MBZvBZfFe4V+Kk6y9PVrv
	I7r2mHXGWBjVBepfa+lzOpdAZX0CoMubRaQphsRllAf510Js1bayTNvRZQLeJ+dTMMD3qOTu8ur
	NC99S9fPoVwNR0sa+DOtjHxe8iFfTRAiSZ1gM2aL4NOt85HIRF2RstayURpkBh
X-Received: by 2002:a05:600c:37c3:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49e7a678879mr63803615e9.24.1789420300103;
        Mon, 14 Sep 2026 14:11:40 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef74a5dsm5642305e9.7.2026.09.14.14.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:11:39 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v3 0/2] net: phylink: wait for a PHY that probes after the MAC
Date: Tue, 15 Sep 2026 00:11:35 +0300
Message-ID: <20260914211137.2760618-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an MT7981B board with an MT7531 switch, the Airoha EN8811H behind
lan4 has its PHY driver built as a module on the root filesystem. The
switch sets up its ports before that filesystem is mounted, so the port
is validated against the generic driver, fails its phy-mode and stays
dead for the uptime. Nothing retries it.

Let the PHY node say so with needs-host-firmware and have phylink poll
for the PHY instead of giving up. Patch 1 adds the property, patch 2
does the waiting; the reasoning behind each choice is in patch 2. On
that board the port now attaches at 7.0 s and links up on its own.

Changes since v2:

 - A connect that fails with the real driver bound is retried up to
   three times at the poll rate, then given up on with one error naming
   the PHY node. v2 did not retry and asked whether to retry unless the
   PHY node owns a reset line. That condition does not hold up: the
   detach asserts whatever reset the DT describes, but the re-attach
   runs phy_init_hw() with the driver's soft reset and config_init on
   every board, so what a retry costs depends on the board and the PHY
   in ways phylink cannot see. It is bounded rather than conditioned.
 - The poller returns without attaching if a PHY arrived by another
   path while it was queued.
 - phylink_destroy() cancels the poller before any teardown instead of
   in the middle of it.
 - The NULL phydev->drv window v2 asked about is not specific to this
   series; phy_attach_direct() meets it from any caller racing a driver
   unbind. The guard is posted for net on its own [2] and covers an
unbind already in flight.
 - The link_state fix v2 needed is in net-next now, as 113998aa372f
   ("net: phylink: initialise link_state before a forced major
   config"), so this applies without it.
 - The MDIO device driver posted beside v2 is withdrawn [3]; nothing
   here depends on it.
 - Rebased onto net-next.

Still needed underneath: patch 1 of the phylink/phylib pair pending for
net [4]. A late bringup failure has to leave pl->phydev clear: the
poller takes a set pl->phydev for a PHY that arrived by another path,
so without it the first such failure ends the wait with no retry and no
give-up line. It is the prerequisite listed below.

Tested on that board, with these two patches and the prerequisite
backported to its OpenWrt 6.18 tree, warm boots. The retry paths need a
connect that fails after a successful attach, which this chip does not
produce, so those runs used a debug-only module parameter that, after
a successful attach, detaches and fails the connect with -EIO a given
number of times, on an image without the PHY driver so the poller was
still waiting when the driver was loaded by hand:

 - one warning after the first minute naming the PHY node, then the
   interval doubling up to the 30 s ceiling
 - two injected failures: retried 30 s apart, the third attempt
   attaches and the link comes up, no give-up line
 - failures that do not stop: four attempts at 1 s intervals, one
   "giving up on ... after 4 attempts", and with per-iteration tracing
   on no further poll in the 237 s the capture covers after it

Retries inherit the interval the wait has reached rather than choosing
one, as the two runs show.

Not tested: cancelling the poller from a teardown while it runs, because
the only path to it on this board, unbinding the switch driver, oopsed
earlier in mt7530_remove() until the fixes in [5]; and a PHY arriving by
a second path, which this board does not offer - that rests on the check
at the top of the poll body.

The runs above also went through both attach branches: in the
two-failure run the PHY attached to a port up since 15.8 s and linked
2.9 s later, and with the driver present it attached at 7.0 s to a port
not yet started, which linked once brought up. Not repeated on v3:
ifdown/ifup with the PHY attached, and checking that the PHY interrupt
fires after a running-port attach.

No in-tree device tree sets needs-host-firmware yet. The board is
supported out of tree, in OpenWrt.

Still asking, which is why this stays RFC:

 1. The poller repeats what phylink_fwnode_phy_connect() does - choose
    the interface, attach, bring up, detach on failure - with a
    different point at which the reference is dropped. Do you want a
    shared helper before the rest?

 2. Polling was the plan set out in [6]. BUS_NOTIFY_BOUND_DRIVER
    gives the exact edge; do you want the notifier in this series
    instead?

[1] v2: https://lore.kernel.org/r/20260908155729.4164814-1-f@lex.la/
[2] https://lore.kernel.org/r/20260914204200.2743251-1-f@lex.la/
[3] https://lore.kernel.org/r/20260912130430.2246285-1-f@lex.la/
[4] https://lore.kernel.org/r/20260909204306.2374562-1-f@lex.la/
[5] https://lore.kernel.org/r/20260914202421.2737079-1-f@lex.la/
[6] https://lore.kernel.org/r/a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch/

Aleksei Sviridkin (2):
  dt-bindings: net: ethernet-phy: add needs-host-firmware
  net: phylink: wait for PHYs that are known to probe late

 .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
 drivers/net/phy/phylink.c                     | 227 +++++++++++++++++-
 2 files changed, 228 insertions(+), 7 deletions(-)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
prerequisite-patch-id: 293623f600b825505376e5c5bf72df2ac1f58e1e
-- 
2.53.0

