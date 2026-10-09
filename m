Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DE4F3937
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569159; cv=none; b=Drc18sCcszIanUMno0mlN+ge5MbR9aK389iMXrv2yhnGF6QR1+CakAxVquJcg/ffwIFaUPh8Q6XjP5+po6biF4aKbG7hb7D5wy87bnoka/hwuapsiiEsJosFYmhS0O3t3q/QJoSwOVQLc1zyv2Ii3NqnpH3eZtDg8fLTzELxOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569159; c=relaxed/simple;
	bh=nOWwepnFpJwCtUcsjoUK8SKMYT5w2CkQU2SfUQ0Q67g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNM9MpAdwuwJMqOGiy0puh2hC0y5jpzkm8mBthRnPppdkURpbQtaGul/zzL0dw/vjB330pUHeyFr0WzFWAvGr18lO+BrK9lgepwxWchE1L6CRjK+ay2iFrb8BuFRuPtmPHn3xIjoHxF5W0orJsP/hw0xFOeZ6IClJLeT0BOKhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=bLtE1ogU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="bLtE1ogU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso1967575e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791569156; x=1792173956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=th258UQlwl6rTU5PwiT+S9xpjAkBo5K5mvMgL5n3qn4=;
        b=bLtE1ogUWdDLGi+/52DqNF8murf4O1UYCmcZrzU1J7ZuP5tyJNSkQXk3NSX3FMmVHV
         XWLe6CHt5sstSxl7Zd4f9u8k0vszDRLcuO5hkN3bHHGvfGgdL8f3LqiYmr3oiOy+G8EY
         lwC/OaUuW5vGwdlDOTvtcHiKcAoI6Sj6A+cttjolBaTPyQTKmbmln+yvsum5UI5aIR20
         SNJYiyzInNeqzOgpAMruVy0VDy1vBXW2BNROjq3/iQei7+okjqFsleSh+66a4apZ+XPP
         vZ6/aRVS0JC+gI5q9EyfYZenFUyF3kgTMluPMAUa4UdMHbl3m933Ce9YcgNaWn119Fy7
         o3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569156; x=1792173956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=th258UQlwl6rTU5PwiT+S9xpjAkBo5K5mvMgL5n3qn4=;
        b=UZQb2i48xMyQheuMATUrjJ2vkrizkblhO1EBPdFsKHANR+N8V0s+myCFPDDY0SLBXj
         FwM+Ii69SHqzl6AZ5a24YOrycMfvrecqmv9CO5SDhRJ3zWGCi4IF4pFtKOMNRmRvNLlo
         B2huc7MOPf6m0Pg4o5RGBaR3aYzgGpnLpY/xmKwxcYnLpHbZqptTvbZ48qpCppPj2hGA
         O48BkT/8eRGOL77CVjynqBJ3HE/qVQf70JEeJqfrrdQGpOlkbtYqNj30bpC+EpImBNWB
         SZfU2TgO7qp0w3xJRxc760NV89b1ixUIiZWpGvhIL8tAgQaj5oFGSlcqIGBQh1Dxxrvu
         T5uw==
X-Forwarded-Encrypted: i=1; AKwUvBzCb3/zCkzquMctfmXiG4YlAjrTbRzYH9mXDEORKhoEr4V0lzXkmbz9mgqw0GFtuG++ja74Pys=@vger.kernel.org
X-Gm-Message-State: AFuF++k4zyUCctSqTBSFI32RK/4HROBXWtU6cQAekXJjrbc1ZUliiW5y
	6tu8XAOEkVPji2qQE3gC95jwjzf8RPs41V+F81LfpmHOV3MoDtPZEO2X9l6MWruGxgc=
X-Gm-Gg: AYBFou0iPuTOGpgm+Xlgw+MWAIv1yZtDd8682gbJ4MuLrjNIXQA+/gHA/uBZswndoYc
	pZotfasP22BEdxD+SbwgIwS3wySzxeV86qlWs4xJ2nR0p4drdJqlu8L/BEZ2U5wcQiRaPt/luU6
	Pz8NgMBw8suR1vhxZPv9/0L1e8wSrLhU8/bGnW3wRTwg7zAB8on/Piv+sIr15GeobkJr+p1L3ve
	owk9M6dBTxzddG0r5e0txu3NvxVPq6GYxPFstCFEEt9ty0OjjK1B3hmcgwF88HgTqfZPnzbg7EM
	TFLuhyVst0tAvzRff7JH46adUgoXfJZ78+l2i6NjxFgxBkU3Nwsm0tf8uTNocWeOdGZOXlZBFdy
	2OE8+gk1x23vg6V99j5QiW2iwWXC7Dl1O0wqW1BgfVLbOXLzHHiuE4SQldVh+fBx3fYqllTeBqZ
	JNkjFpoBKyVkGJcyJqI9zlJz63zFdcT3BWUcecW6r9OwXc9RNokw==
X-Received: by 2002:a05:600c:4708:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a18e4a6ea5mr53023535e9.13.1791569156312;
        Fri, 09 Oct 2026 11:05:56 -0700 (PDT)
Received: from remote-01 ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm118184915e9.8.2026.10.09.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:05:55 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v5 0/4] net: phy: make PHY driver unbind safe against attach and use
Date: Fri,  9 Oct 2026 21:05:46 +0300
Message-ID: <20261009180551.1234107-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbinding a PHY driver through sysfs while its MAC brings the port up
can oops. On a Keenetic KN-1012 (MT7981, mtk_eth_soc), an unbind of the
wan PHY driver racing "ip link set wan up" faulted on the first attempt,
with no delay added anywhere. The PHY driver's config_init read
phydev->drv after phy_remove() had cleared it. Patch 3 has the trace.

Serialising attach against unbind is not enough on its own. The unbind
that loses the race then removes the driver from a PHY that is now
attached, and the consumer faults one step later. A DSA port gets there
without any race, because DSA keeps its PHYs attached from switch setup
to teardown. Patch 4 has both cases.

1: refuse a second attach of an attached PHY up front.
2: put the module reference phy_attach_direct() took, not whatever
   driver is bound at detach time.
3: a per-PHY mutex and a "bound" flag. An attach either is done with the
   driver before phy_remove() starts tearing it down, or is refused with
   -EAGAIN.
4: phy_remove() waits for phy_detach() when the PHY is attached, except
   when the PHY device itself is being deleted.

1 to 3 do not need 4, but without it the winner of the race still
ends up with a PHY whose driver is gone.

On the lock inversion (Paolo): phy_probe() and phy_remove() take rtnl
under the device lock (SFP bus, netdev LED trigger), and attach may run
under rtnl, so attach cannot take the device lock. Nothing under the
new mutex takes rtnl.

Vladimir, patch 4 falls short of what you asked for in [1]: that
unbinding a PHY driver should not "explode ... even in uncontrolled
situations where the netdev isn't carefully disconnected from the PHY
first". It makes phy_remove() wait for the detach, so the unbind blocks
until the consumer lets go. For DSA that is switch teardown. Other
options, and why not:
- stop at patch 3: the oops moves one frame up;
- the caller holds the lock across bringup: widens into phylink,
  leaves every later use;
- a killable wait: ->remove cannot fail, so a kill ends in the oops;
- suppress_bind_attrs: removes the unbind your use case relies on;
- a managed device link MAC -> PHY: takes the MAC or switch down too.

The wait has costs. The hung-task detector reports the blocked unbind.
Suspend waits behind it and reboot hangs, because both take the PHY's
device lock. Patch 4 names a device-link case where the wait never ends.

Attach still binds the generic driver without the device lock, so a
real driver binding at the same moment can collide with it. Two
consumers attaching and detaching one PHY at once are unsupported: the
end of a detach can still reset the other's PHY, and with patch 4 its
generic driver release waits for it (a deadlock if both hold rtnl).

Tested on a KN-1012 (OpenWrt 6.18 backport, PROVE_LOCKING, hung-task
panic) with lan4 holding its EN8811H. The image carried 03101a02b2fa,
which differs from this posting only in the patch 4 message, one
comment and the WRITE_ONCE() on removing.
- second attach of lan4's PHY, with or without a netdev: -EBUSY
- air_en8811h unbind under lan4: waits, returns on switch unbind
- free PHY: attach 0, again -EBUSY, refcount 0/1/1/0; on genphy too
- irq back to the bus number after each generic-driver detach
- two attaches racing without rtnl, 200 rounds: one winner each time
- unbind of an attached PHY waits for detach, with both drivers
- phy_device_remove() releases a waiting unbind
Lockdep stayed quiet. The one splat was a known kernfs warning from the
DSA teardown order.

[1] https://lore.kernel.org/netdev/20260311203410.rio7m6nuf72hs5p6@skbuf/

Changes in v5 (since v4):
https://lore.kernel.org/netdev/20261001130120.104628-1-f@lex.la/
- Rebased on the applied phylib interrupt series. Patch 4 moves its
  detach-side restore ahead of the point where a new attach can start.
- Patches 1 and 3: the "already attached" test runs under bind_lock.
- Patches 3 and 4: detach clears phy_link_change, the recorded module
  and the attached flag in one bind_lock section.
- Patch 2: the driver module is read once.
- Patch 4: READ_ONCE()/WRITE_ONCE() on attached, WRITE_ONCE() on
  removing.
- Messages: patch 1 on the generic driver, patch 3 on its exception
  and -EAGAIN at probe time, patch 4 on the reboot hang and the
  device-link case.
- The bind_lock kernel-doc names phy_probe() and phy_remove().

Changes in v4 (since v3):
https://lore.kernel.org/netdev/20260924215951.2127682-1-f@lex.la/
- Retargeted to net-next, as asked.
- Patch 1: the test also catches a PHY attached without a netdev.
- Patch 3: a Return: section for __phy_probe(). The forward declaration
  stays, see the v4 notes of patch 3.
- Patch 4: a line over 80 columns wrapped.

Changes in v3 (since v2):
https://lore.kernel.org/netdev/20260919015340.499675-1-f@lex.la/
- Retargeted to net. The race is closed with locking instead of a NULL
  test, as asked in review.
- Patch 2 split out. New patch 1 (no detach of the first consumer on a
  second attach) and patch 4 (the unbind waits).

Aleksei Sviridkin (4):
  net: phy: refuse a second attach before touching the PHY
  net: phy: put the driver module the attach took
  net: phy: serialise attach and detach with PHY driver bind and unbind
  net: phy: make an unbind wait for the attached consumer to detach

 drivers/net/phy/phy_device.c | 123 +++++++++++++++++++++++++++++------
 include/linux/phy.h          |  12 ++++
 2 files changed, 116 insertions(+), 19 deletions(-)

-- 
2.53.0

