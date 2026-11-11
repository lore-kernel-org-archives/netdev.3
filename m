Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440905;
	b=xrn/TwcaLV9Hnwsmj0LtwSUNwTDJwgUrQgYsXXTycxBE4oP4JE6MCgmVccLZSmfmBXh4
	 xHH0PznURywsdFV0G945JnZ0KzIES8QyX1RoggMQJ253EjIO0njDe3sxRoHMnxS5Jtsct
	 mrl3lJEE7J/C641Ew62lkkPWxdpffC76tdUbzMbtNauxl79sYMBofvS/EpaU8xOFhgOoW
	 ZKqemsw5voSDK0bE6dEw3mARbsJx0Tk0oxvsaqnTU8aegyhRwTR86rethaFHEHg5orE6o
	 fU+TCNr7mrRSKjJu+DOOL+F3ByCE0mwJbdlrWUzgusVv3qMh84vYiifuWF9f7eDgUwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440905;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HcIyqdgBVqDQl1X2czRRxA89xP/QmfaHzPYH/NFUI0Y=;
	b=z6wszJ9SjQ3jShdvUu8gORTP+TE/RtdCXydKODL0tYEGAGeLnWSK+avsyajtO6gO7pWX
	 N//J3cKNu1MIRUUGn4Wc3sIeMltIVg+3Q9OlAb+gBfBEQ1nRVtoqxTjy4LMJsBTNDc/fu
	 bApnzd7cjsmf1qHGTlF6MACfQBeZ0a0WVgQHTwwN5hPAAp4eP3GsGaFwWaLwRvKy5Aa50
	 suWa9dDM3QYDBkNv8D+7GO5EakPnW95bylnn3tZxB1j+UUpLzuxArRuv5o0m4pes72UyM
	 GcitXBi/mljAqjm0yLqfXvEr9nTNvex0snJ0L64IfaoCSa75/L9/XjDsaGrlJpILt5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T20JEc5z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1D606A331;
	Wed, 11 Nov 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T20JEc5z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794440905;
	b=R36lHJ9N2wjdTNUhVG/bXn4k6LwUcCz8BmmF1rSbAGfUH8m/ktnUJywu92ou3w+5zUTH
	 q2rxuUkSu28yUrGfCxz95eAepxCyfznWkpHq3EsVMhoPcXRS/zflEy0Q51e9L6PMfeA5Q
	 fP9DHmrxLc5zbA4okVAIHusTiH3NFr+xfJ7QzVnuCJM5HsgK4hRPf8nxi6/+rmNrQjdpK
	 rIrdeJPWYZ8v0LjioiDUZHU/rfc7SGcXt9JyF6pD3veA5Tna+usf+O3CU1ZOzqPA/N5fG
	 3mEk/dgHd0x1LkrR6GhLzVM6RizFXgHvoW7dKhfJpvohRgcVUxe+XxWAApTCqs+Tmfg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794440905;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HcIyqdgBVqDQl1X2czRRxA89xP/QmfaHzPYH/NFUI0Y=;
	b=o4I0E7m5+ohluCX5ycEXqVBQh8iy0YKOoGdiFB1NRQ/iQC/sXM40+W2h9dMAXnka1hcd
	 +XSXKcWCK6DVvGfGER/JBy8QgqIyxg+FKzjS8qTcBaFMtVFeihzHn0O7+VhGnLhv6E+yG
	 uGQDAsKuwY6XB59oOnC0dsn/ckTe5ETqsQHv+w6sqbCbQmpe0g67Fn2fE8DaW+i5mqxqK
	 l9D1OCdinOk+o9qTnL2fjC9J8KhKLwHzOPhfr2jrQUXCc2VL6pSahmnx9zJ/nJT3FqWJK
	 qbfL1cY8A2b42R7ECvDPl/PmF3PZmr45IC1iTMLdhaZzJJqjSQ5uMIjR0mSkJhK6BNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5EDEA1F00A05;
	Wed, 11 Nov 2026 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440905;
	bh=HcIyqdgBVqDQl1X2czRRxA89xP/QmfaHzPYH/NFUI0Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=T20JEc5zE1bPZW3j8KjkNRoxUkWlk1URMH1R+KmHArIPTvIuvA8VMWc50TwiWB6hr
	 Dgn70IeCPT195Yv1bLmk67M58gcpsaxubq7PNhQSHettVZ5GJoEhCqiDwExuk33c8j
	 Jm1gi4wGtZLTSVcS+OMrP7oavNfk34HAKVUIYiIMfNswVXBUInSRCYGZw1M7nT0Ufh
	 keiQKBeRR531/StwgnBoFMIOmrzC0AVhlwu2HA0ayxB3lA2nTKcBCQPxVPEH77jBhh
	 BEu4ZGz5Ct6Tsc+IOW+zq1p8R35sHSTll1A24i62hBYAyA3wBrjnjZ02pe5S4D4+tI
	 6BhWjUTKPnNog==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C960149181;
	Wed, 11 Nov 2026 23:48:23 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Wed, 11 Nov 2026 23:48:18 +0000
Message-Id: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAML+9GoC/4XNywrCMBAF0F8pWTuSt9SV/yEukjaxA32ZlGAp/
 XdjFuJGhNncucyZjUQX0EVyrjYSXMKI05iDOlSk6cx4d4BtzoRTrhnlNVgJc7f2aGEwDcwDYHh
 AEuC10q10rNHSk3w9B+fxWeQrGd1CbnnZYVymsJZvSZTqL5yHgqrpiUrlBWf0giYd+1TAJL8Qw
 X4j8o1Yw4UV3tdGfpB9318XLeJ9BQEAAA==
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, 
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5635; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=HfX1jf3NSg3omI4ZglWLxQwe7oK6Rg2xu5oqUFPBLQU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlf/h2RWbycV7E84fXDLYe1X6+ZUCnsY36LucPo/uojx
 XyJl/v2dZSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJ7G1h+M12KHfPZFnORCPN
 JJUmyb6ZTtsdpuZPsWFYouRvc7QnJ4qRYXLGBp5/eXPa3zn1R/ulxtRM8mrsveVlGJdW0pbxJcm
 bCwA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

When the MAC driver manages PHY PM, phylib never sets irq_suspended, and
a PHY interrupt during the sleep transition runs the PHY driver's
handler while the MDIO bus may be powered down. On Helios64 (dwmac-rk)
this hangs the board on suspend as well as on resume.

mac_managed_pm hands phy_suspend(), phy_resume() and the state machine
to the MAC driver, since commit fba863b81604 ("net: phy: make PHY PM
ops a no-op if MAC driver manages PHY PM"); the PHY interrupt stays
with phylib, and so does postponing it.

Patches 1-3 fix the postponing that phylib applies to other PHYs, so
that patch 4 can extend it to MAC-managed ones. Patch 1 moves the two
flags out of a bitfield they share with the link state written under
phydev->lock. Patch 2 keeps the line of a postponed interrupt balanced
when an edge reruns the IRQ thread or phy_free_interrupt() runs during
the transition. Patch 3 undoes the postponing when phy_suspend() fails
and ends it when the PHY fails to resume. Patch 4 sets irq_suspended
for MAC-managed PHYs too and decides the wakeup event of a postponed
interrupt before the device that owns the MDIO bus suspends.

Not covered: MDIO accesses from closing or opening the interface during
the transition, and a MAC resume that fails to power the bus up. On a
shared line, a postponed PHY interrupt disables the line for its other
users until the PHY resumes; patch 4 extends that to MAC-managed PHYs. A
nested threaded PHY interrupt is not replayed (irq_wake_thread() has no
thread to wake), and mdio_bus_phy_may_suspend() does not ask
phy_may_wakeup() about an attached PHY.

With MAC-managed PM, a postponed interrupt reports a system wakeup only
when Wake-on-LAN is enabled in the PHY. A PHY that leaves its link
interrupt unmasked while armed for Wake-on-LAN can then abort suspend
when the MAC changes the link. Going by their suspend code, BCM54210E
leaves it unmasked, while RTL8211F and AN8801R mask it. Tested on
Helios64 (dwmac-rk, RTL8211F); Haoning Cheng tested v4 on i.MX6 (fec).

Changes in v5:
- v4 patch 2 alone could leave irq_rerun set across
  phy_free_interrupt() and a new request, after which a postponed
  level interrupt fired without end; it is merged with v4 patch 3 into
  patch 2. phy_free_interrupt() re-enables the line after free_irq(),
  not before, and only while other users of a shared line remain, so
  the handler cannot keep running on a source it cannot quiet;
  irq_rerun stays a bool (Sashiko on v4)
- patch 3: when the PHY fails to resume, the line a postponed
  interrupt disabled stays off, as before this series, instead of
  rerunning a handler that may not reach the PHY (Sashiko on v4)
- patch 4: with mac_managed_pm, only Wake-on-LAN in the PHY makes a
  postponed interrupt a wakeup; the ethtool flag may describe
  Wake-on-LAN in the MAC, as with fec (Sashiko on v4); for a PHY that
  phy_suspend() already suspended, the PHY part of its Wake-on-LAN
  state is kept in the new wol_phy
- patch 4: Fixes: now points at 1758bde2e4aa, which added the
  postponing after the early return for MAC-managed PHY PM
- comments say that postponing lasts until the transition ends
- Haoning Cheng's Tested-by on v4 kept on patch 1 only: patches 2-4
  changed
- rebased on net
- tests rerun on v5
- Link to v4: https://lore.kernel.org/r/20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv

Changes in v4:
- new patches 2-4, one pre-existing defect each
- patch 2: an edge that reruns the IRQ thread no longer disables the
  line twice
- patch 3: phy_free_interrupt() during the transition keeps the line
  balanced (Sashiko on v3)
- patch 4: a failing PHY PM callback no longer leaves the interrupt
  postponed (Sashiko on v2 and v3)
- patch 5: the wakeup event is decided in mdio_bus_phy_suspend(), where
  phy_may_wakeup() can still read the PHY (Sashiko on v3); Fixes: now
  points at the stmmac commit that took its PHYs out of postponing
- v3 asked phylib or phylink_suspend(): phylib, as macb sets
  mac_managed_pm but suspends with phylink_stop()
- tests rerun on v4
- Link to v3: https://lore.kernel.org/r/20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210@iav.lv

Changes in v3:
- with mac_managed_pm, a postponed interrupt signals a wakeup event only
  with Wake-on-LAN; with MAC power/wakeup enabled and no WoL, v2 aborted
  s2idle on Helios64 3 of 3 times, v3 0 of 3 (reported by Sashiko)
- phy_free_interrupt(): stop postponing and re-enable the line before
  free_irq(), not after it (reported by Sashiko)
- mdio_bus_phy_suspend() comment narrowed to the MDIO bus (reported by
  Sashiko)
- patch 1: Andrew suggested taking phydev->lock in phy_interrupt();
  the commit message says why that does not close the race
- tests rerun on v3
- Link to v2: https://lore.kernel.org/r/20261026045343.837889-1-iav@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (4):
      net: phy: move irq_suspended and irq_rerun out of the bitfield
      net: phy: keep the line of a postponed PHY interrupt balanced
      net: phy: stop postponing PHY interrupts when a PHY PM callback fails
      net: phy: postpone PHY interrupts during sleep with MAC-managed PM

 drivers/net/phy/phy.c        |  45 +++++++++++----
 drivers/net/phy/phy_device.c | 134 ++++++++++++++++++++++++++++++++++---------
 include/linux/phy.h          |  35 +++++++++--
 3 files changed, 169 insertions(+), 45 deletions(-)
---
base-commit: 8d5ce4751fad9499ea408163af7f410f18a85782
change-id: 20261029-b4-phylib-mac-pm-irq-v3-f656d4e1c64f

Best regards,
-- 
Igor Velkov <iav@iav.lv>


