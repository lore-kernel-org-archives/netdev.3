Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80491365A0B
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859693; cv=none; b=Ob2uB6P7wGttor+pWfzIL/bx3W8U6SPK3vYj4FLpLxYLT6Xb9dlAjAcGKxHV4VGmJEF4Ve9lRjtT4j3lDuGiALl9EwQ5fi4nR4hdUGfJhqfxiljN1cmkNH0vrnDKiiWL5ka2exh4WP0J1ZXAaxyiPmEViwmmWtfY3t482W0dQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859693; c=relaxed/simple;
	bh=pxCwKPK4mVAYGInRVJr4yp7pmmZibHp2j2w0mTURFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ01ss0U20Upb8z3dJvF5lWWiQfS5I2Qig2UZHPetr/fverJZ2pmtovAZ87D/Ilu8pDS0GeMqEYbk/lTWu3VH51yFt4rnksRkDX+/0+Ov7ts9auLjt0T3XXCpn+Ph07kjZQxnOh22HKsiZLlnCPgYz5a6iZ91+j6HcIXtAoB7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=E4p8iSDH; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="E4p8iSDH"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so35423855e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859690; x=1791464490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dgfEa5nzb4Vg9Ss2DXtXNsGgjNAqAr80/DQc6iOkiEU=;
        b=E4p8iSDHhivn51t0HOa448+N5e1WgLq2Z9+jPrYY0blVeK1nRhCWfM0BZJ/leYiHFG
         ThZA1l1lQv0Jq0ZyyHneejTU0m7+l7/oVHx6cb5WpfxreDcsvWgCtpgNpXytOhYx2dPE
         ceDgA6R7hTKuCdAkmLwNUu/ucT2w9YY5GqzFmUvL8IyNI2DUhw9OF2HiNE2mlD9I8kSJ
         1Nt/J67xHUR1lheVwKzeWJ8bmuPqkeYogRK8OFnoTbjwqY4ndn9JdBkZhaEInshhRrIm
         qXFe+XSfsNLBTkpexz5NlvjMUp4PaTFaz/3DppsIfrrP7DOnKUVLjeCVK/p2aoiroVtm
         i5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859690; x=1791464490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgfEa5nzb4Vg9Ss2DXtXNsGgjNAqAr80/DQc6iOkiEU=;
        b=eoIPyOEMNjJHnUgPYX/HOXjWyedsXWVIzVF6TAsaG1QaIYpfoOD8RaD+LxoW0BPJuT
         aGq9TdKL1rpTgHEHX2Boyw6UITeQoc0DsZTNF1K9tiHxnDOXSJjikdz6l+zsQ6HZ2Bvf
         80WT6WpC0Tb35gJ4eb1p99CmrNVYw62KeXzjOn6Oua6cCXowMJ+h8jBpfyZVmx7uNkTu
         HVHfid/gm/IUjYe2AnU6PnkJScq6kAXywLulyU84OPuQfALS8TbmcR5eZPkp4wB4Esp/
         KQs6UV5XmAc0Nj/2CkFDHtfNC+zdBocRY6Wv0piNtpAV5Es49Bspcj5CsCkwdeuiMtLg
         RT4g==
X-Forwarded-Encrypted: i=1; AKwUvBxaVpU1fc2lBw56e0LLLpUnUmair1BnTMP8aV3dkmaAHziwBvYhEHh0npttV+9F9wQ/jRdsBp0=@vger.kernel.org
X-Gm-Message-State: AFuF++mJc/lIOOk4wzwdCv48YQwJeF8qVqeOIvSMf10dXKt+z6WgUQxN
	SWFT4+KModtCZ6remRqc9ApfpgmBMVhguYb6NTdQWoqGSkI7zMA3AORVa1gAj7YEPG3ZifaZ/Yw
	C3iF0D4mgp6Nt
X-Gm-Gg: AYBFou0147JDpcHmAF4XDg1/ps9PE3Mwf5JyuyStTyNZRkht/BLoHtWAFSx6ZTgD7p4
	Pq4rJ/s6bXc+09o0kqdu61p3iw69gbiKEjrPSZKHHc5A2afrUPWmGkWSwAhTg95SywfN3ZOB84V
	2kdfoUNS32Q/Maa7zSdZPhFUMmT/OifJLzzzytejo7htQtSAaWNPwIOff1SWogvk9gEEQ1Sd210
	8Q2XHp5eRrXwBbqS0BYV1xNrLD7RKKMV+7YT2StJ+G07iCzQZqL1q4FNdFwY1bJc69+TjWcK5Rt
	Rtg8cMVKaMr0/hlPJb+2c9+fSQiWFPr3rIeMxk0AIqRsfuDCSdCqXc41P1t3NxM0NL3DqAnYB9N
	KRiPDvr8L0l27KAsduN/geikEiOeR7fDGf9HdvLEeYNQR24BqZgKLwv2p1FN/9uNwaapWi6Z/YY
	10RZtPM9flObSW34WD0pUxDg9LfxcnOeOzVMdy+zcniOgoLznCSI1X6yqFWz9f
X-Received: by 2002:a05:600c:3b99:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-4a01aff6a1bmr97548805e9.23.1790859689209;
        Thu, 01 Oct 2026 06:01:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99b113sm77732245e9.14.2026.10.01.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:01:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/4] net: phy: make PHY driver unbind safe against attach and use
Date: Thu,  1 Oct 2026 16:01:16 +0300
Message-ID: <20261001130120.104628-1-f@lex.la>
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

1: refuse a second attach of an attached PHY before taking anything.
2: put the module reference phy_attach_direct() took, not whatever
   driver is bound at detach time.
3: a per-PHY mutex and a "bound" flag. An attach either is done with the
   driver before phy_remove() starts tearing it down, or is refused with
   -EAGAIN.
4: phy_remove() waits for phy_detach() when the PHY is attached, except
   when the PHY device itself is being deleted.

1 to 3 do not need 4. Without 4, an unbind that loses the race to an
attach still leaves that consumer with a PHY whose driver is gone.

On the lock inversion (Paolo): patch 3 says why the PHY's device lock
cannot be used here. Removing the inversion would at least mean moving
the SFP registration out of probe and remove. The SFP upstream ops write
netdev state that rtnl protects. Attach does not always run under rtnl
(DSA connects its ports before taking it), so the registration cannot
follow the attach either. Nothing under the new mutex takes rtnl. On the
generic-driver path, device_bind_driver() can take a supplier's device
lock for sync_state, as it already does today.

Vladimir, patch 4 falls short of what you asked for in [1]: that
unbinding a PHY driver should not "explode ... even in uncontrolled
situations where the netdev isn't carefully disconnected from the PHY
first". What I looked at:
- A, phy_remove() waits for the detach (patch 4, kept): the unbind
  blocks, uninterruptibly, until the consumer detaches. For DSA that is
  switch teardown, even with the port down.
- B, stop at patch 3: the oops moves one frame up. Patch 4 has the
  phylink trace.
- C, let the caller hold the lock across attach and bringup: widens the
  series to phylink and still leaves every use after bringup.
- A with a killable wait: ->remove cannot fail, so after a kill it could
  only go on removing the driver, back into the oops.
- suppress_bind_attrs on PHY drivers: removes the sysfs unbind your use
  case relies on.
- A managed device link MAC -> PHY: the unbind would take the whole MAC
  or switch down with it.

A is a compromise: an unbind of a PHY in use hangs instead of failing.
It has other costs too. The hung-task detector, when enabled, reports
the blocked unbind after its timeout. System suspend and reboot wait on
that PHY's device lock meanwhile. device_shutdown() takes it and does
not detach PHYs, so a reboot behind a blocked unbind hangs. sysfs shows
the driver link gone while ->remove is still waiting, because the driver
core removes it first.

This series does not close one more window. phy_attach_direct() still
binds the generic driver without the device lock the driver core
expects. A real driver binding through the driver core at the same
moment can still collide with it.

On v4 (OpenWrt 6.18 backport, PROVE_LOCKING), a test module attached the
free EN8811H of a KN-1012 twice without a netdev. The second attach got
-EBUSY, the air_en8811h refcount went 0, 1, 1 and back to 0 after one
detach, and lockdep stayed quiet. Without the series the second attach
succeeded with a duplicate phy_standalone sysfs warning, and one
reference was left after the detach.

On the KN-1012, lan4 is a DSA port on an EN8811H. Without the series,
unbinding air_en8811h returns at once, and the switch teardown faults
later. With the series (an earlier revision with the same attach and
wait code, before the device-deletion change), the same unbind blocks
with lan4 up or down, and returns when the switch is unbound.

Patches 2 to 4 changed in v4 only by the rebase and the fixes listed
below, so their v3 results on the KN-1012 (OpenWrt 6.18 backport,
PROVE_LOCKING) still apply. They are in the v3 cover letter:
https://lore.kernel.org/netdev/20260924215951.2127682-1-f@lex.la/

[1] https://lore.kernel.org/netdev/20260311203410.rio7m6nuf72hs5p6@skbuf/

Changes in v4 (since v3):
https://lore.kernel.org/netdev/20260924215951.2127682-1-f@lex.la/
- Retargeted to net-next, as asked. There the detach code lives in
  phy_detach_internal(), and bind_lock also covers the new
  notify_phy_attach() bus hook.
- Patch 1: the test also catches a PHY attached without a netdev, as DSA
  does for its CPU and link ports.
- Patch 3: a Return: section for __phy_probe(). The forward declaration
  stays: dropping it means moving about 200 or over 500 lines, details
  in patch 3.
- Patch 4: a line over 80 columns wrapped.

Changes in v3 (since v2):
https://lore.kernel.org/netdev/20260919015340.499675-1-f@lex.la/
- Retargeted to net, and the race closed with locking rather than a NULL
  test at attach entry, as asked in review.
- The module reference fix is its own patch.
- New patch 1: a second attach no longer detaches the first consumer.
- An unbind of an attached PHY now waits for the detach.

Aleksei Sviridkin (4):
  net: phy: refuse a second attach before touching the PHY
  net: phy: put the driver module the attach took
  net: phy: serialise attach and detach with PHY driver bind and unbind
  net: phy: make an unbind wait for the attached consumer to detach

 drivers/net/phy/phy_device.c | 98 ++++++++++++++++++++++++++++++------
 include/linux/phy.h          | 12 +++++
 2 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.53.0

