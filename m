Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404091;
	b=LG/66qoEbiDUnqqMZmWsng5lyuCGXS7sV240n3iw34pR0TBYTqfMgatRGSoHBq/lDEEA
	 0eKe1IfO278aeaKmKtxtYNgrgGtvTOjWQLLOabfzn2NuO+0X0l/TKYJboxFpIYjPdAbZZ
	 +E5yIzO+I/BhTev6cWhHtaBmA/Wbf//KJ+PAeJXLjWRIM4wrVaZyYIk6W8r5NBG0I18gL
	 Tv3Xg27BIMW5193BOF/zAm9N49BKHztlByR5+fIqJPfZ094QyDu5Hhlj4D22emVTwOHYJ
	 PitpW1TeYvPFmy98AgvZHt87vOj8XWY706K63oXAIE3vY4AgCql3ikh+8LEbAqBQmxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404091;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-malware-bazaar;
	bh=HijG619Jo55u9xnTSz+yqii1K6ehIAKwvJmpVtupmc4=;
	b=LD262WTeFoux09marDwJVdhkc2KI0Le7Kapfw5ov8r3WMCPAGJ6Clf/1SFop73xQEIOt
	 D+H9Wby+NZpD6Yu5/jowJ+EYCbS83J+nZAbEARuGEvs8KnM2dNvnPPdpyiciqp0MhfWEQ
	 bw8yFZtomDRpVzwqOUL7tIMroSILc/IIYPjoGw7GGsPhwgJDHt3sJ5YRjB4L+Vtfa7B1/
	 sPgOrvkVx+F1WJPl/k1ITYHJRVw+BgjHUC6zVdOZeoBzHKqtdRfFgQoKJSxsCCIsh1f+i
	 tfeJOYwIoKHZCla2FkBzk8XFu5p/FGDgU6SllTGyhz4bp2NBTXWX0k8egLjDuaeEFwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=xMqXTu3E;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFC606A31C;
	Wed, 11 Nov 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=xMqXTu3E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HijG619Jo55u9xnTSz+yqii1K6ehIAKwvJmpVtupmc4=; t=1794404089; x=1795613689; 
	b=xMqXTu3ERUmM+GhVLfwK4Qaq8a2Bldd1Kp/RuLMvb+L2CHaLiPYeb/Hp85t1vkiVAVl7fIWjyKn
	gX4BwjYWY53QjkDm3kFVxGUZqDC509tsaFG5RVN3TaYycE9UF7ozO2YwCxqj/5cUSlqcb/aSJtKBI
	71TeisQJdUNUENJjJetgHcz6+GElkm+LQpq1LBsSn6r3yFY1moC+eGR0oW6evzyQKIzZO6XS9lXKv
	FUwwCojFH8G+CzriGAEnP4ML2KsfmtvJKCwW9B9ynt+SWlEprbHcYG6txgNMtJJ/MpfPQbPy63Bua
	VSdMsCUSiWA/K9wtqm4E2WkCu5JadpViDjTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xR8TP-00000004F1e-06FI;
	Wed, 11 Nov 2026 14:34:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-11-11
Date: Wed, 11 Nov 2026 14:32:01 +0100
Message-ID: <20261111133442.225455-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

Here's a set of fixes for the current cycle. Nothing really
seems hugely relevant.

Unfortunately we're going to have wireless-next conflicts with
this, so there may be some emails about conflicts moving from
wireless-next vs. wireless to vs. net. I'll provide a merge
resolution with the wireless-next pull request since it'll only
be relvant when pulling net back into net-next after that.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f66469d9905b39d2c260a15d7d6db450f4db67c1:

  Merge tag 'net-7.4-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-05 18:00:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-11-11

for you to fetch changes up to cb1edd20907e13b058c0d5bd34c9d51b5bedc879:

  Merge tag 'nxpwifi-fixes-2026-11-03' of https://github.com/nxp-upstream/nxpwifi-next (2026-11-10 21:16:03 +0100)

----------------------------------------------------------------
Various fixes all over, notably:
 - mm81x: fix frequency reporting of 2 MHz or wider channels
 - rtw88: fix stuck queue for AP on SDIO
 - ath12k:
   - fix split MSDU decap
   - fix reconnect of MLO stations
   - fix stuck TX due to lack of MCS 15 support
 - mac80211: use-after-free on certain TTLM/update combinations
 - nxpwifi: FW response/notification validation
 - (and a subset of usual "LLM saw a bug" things)

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: don't advertise EHT-MCS15 to firmware unless we support it

Benjamin Berg (2):
      wifi: mac80211: do not switch to invalid link
      wifi: mac80211: find STA for beacons belonging to non-TX BSS

Benoit Masson (1):
      wifi: ath12k: assign device id from the WSI index

David Carlier (1):
      wifi: mac80211: fix unlocked STA statistics fallback

Filippo Falezza (1):
      wifi: ath10k: Stop unanswered temperature reads

Heyang Tan (1):
      wifi: nxpwifi: validate monitor RX extra-header length

Johannes Berg (7):
      wifi: mac80211: mesh: don't linearize SKBs unnecessarily
      Merge tag 'ath-current-20261102' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: fix use-after-free on TTLM disconnect
      wifi: nl80211: fix ERR_PTR use on wdev disappearance
      Merge tag 'rtw-2026-11-05' of https://github.com/pkshih/rtw
      Merge tag 'mm81x-current-2026-11-05' of https://github.com/MorseMicro/linux-wireless
      Merge tag 'nxpwifi-fixes-2026-11-03' of https://github.com/nxp-upstream/nxpwifi-next

Kang Yang (1):
      wifi: ath12k: set MSDU payload correctly

Lachlan Hodges (1):
      wifi: mm81x: report non-1MHz frames on the 1MHz control freq

Lorenzo Bianconi (1):
      wifi: ath12k: fix decap of MSDUs spanning multiple RX buffers

Loïc Kassel (1):
      wifi: mac80211_hwsim: use CLOCK_BOOTTIME for the beacon timer

Luka Gejak (2):
      wifi: rtw88: move the bmc high queue decision to tx.c
      wifi: rtw88: sdio: limit the high queue to DTIM delivery

Mehmet Fide (3):
      wifi: ath9k_htc: do not start ANI before the first channel is set
      wifi: ath9k_htc: start ANI when an AP interface begins to beacon
      wifi: mac80211: abort chanswitch when leaving an IBSS

Miaoqing Pan (1):
      wifi: ath12k: Fix failure to create ath12k_dp_peer on MLO reconnect

Michael Buesch (1):
      wireless: Remove me as ssb maintainer

P Praneesh (1):
      wifi: ath12k: fix IRQ disable imbalance in AHB ext interrupt handler

Tristan Madani (1):
      wifi: nxpwifi: validate scan response TLV sizes before indexed access

Vishal Gupta (1):
      wifi: nxpwifi: synchronize scan cancellation state

Wahid Khan (1):
      wifi: cfg80211: don't truncate the merged MBSSID profile length

Yehyeong Lee (3):
      wifi: nxpwifi: guard the 11ax response handlers against a detached command buffer
      wifi: nxpwifi: read the 11AX_CFG extension ID at the right offset
      wifi: nxpwifi: bound the TLV lengths in the 11AX_CFG response

Zhao Li (12):
      wifi: mac80211: fix use-after-free when MLO link setup is rolled back
      wifi: mac80211: drain link readers before stopping removed links
      wifi: cfg80211: release rejected nontransmitted BSS reference
      wifi: mac80211_hwsim: ignore non-generic netlink releases
      wifi: mac80211: recheck injected headers after removing FCS
      wifi: mac80211: restore dormant links when link updates fail
      wifi: cfg80211: preserve mesh A-MSDU lengths when adding mesh headers
      wifi: mac80211: reject invalid EHT guard intervals in airtime estimates
      wifi: mac80211: recheck the IBSS station limit before insertion
      wifi: mac80211: bound pending IBSS station allocations
      wifi: mac80211: recheck the OCB station limit before insertion
      wifi: mac80211: bound pending OCB station allocations

 MAINTAINERS                                        |   3 +-
 drivers/bcma/driver_chipcommon.c                   |   2 +-
 drivers/bcma/driver_chipcommon_pmu.c               |   2 +-
 drivers/bcma/driver_pci.c                          |   2 +-
 drivers/bcma/driver_pci_host.c                     |   2 +-
 drivers/firmware/broadcom/bcm47xx_sprom.c          |   2 +-
 drivers/net/wireless/ath/ath10k/core.c             |   1 +
 drivers/net/wireless/ath/ath10k/thermal.c          |   9 +-
 drivers/net/wireless/ath/ath10k/thermal.h          |   2 +
 drivers/net/wireless/ath/ath12k/ahb.c              |  11 ++-
 drivers/net/wireless/ath/ath12k/core.c             |   3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   8 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  17 +++-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  30 +++---
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  32 +++----
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  30 +++---
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   8 +-
 drivers/net/wireless/broadcom/b43/debugfs.c        |   2 +-
 drivers/net/wireless/broadcom/b43/dma.c            |   2 +-
 drivers/net/wireless/broadcom/b43/leds.c           |   2 +-
 drivers/net/wireless/broadcom/b43/lo.c             |   2 +-
 drivers/net/wireless/broadcom/b43/main.c           |   2 +-
 drivers/net/wireless/broadcom/b43/main.h           |   2 +-
 drivers/net/wireless/broadcom/b43/phy_common.c     |   2 +-
 drivers/net/wireless/broadcom/b43/phy_g.c          |   2 +-
 drivers/net/wireless/broadcom/b43/phy_lp.c         |   2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |   2 +-
 drivers/net/wireless/broadcom/b43/pio.c            |   2 +-
 drivers/net/wireless/broadcom/b43/radio_2055.c     |   2 +-
 drivers/net/wireless/broadcom/b43/rfkill.c         |   2 +-
 drivers/net/wireless/broadcom/b43/sdio.c           |   2 +-
 drivers/net/wireless/broadcom/b43/sysfs.c          |   2 +-
 drivers/net/wireless/broadcom/b43/tables.c         |   2 +-
 drivers/net/wireless/broadcom/b43/tables_lpphy.c   |   2 +-
 drivers/net/wireless/broadcom/b43/tables_nphy.c    |   2 +-
 drivers/net/wireless/broadcom/b43/wa.c             |   2 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |   2 +-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |   2 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c      |   2 +-
 drivers/net/wireless/broadcom/b43legacy/ilt.c      |   2 +-
 drivers/net/wireless/broadcom/b43legacy/leds.c     |   2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |   2 +-
 drivers/net/wireless/broadcom/b43legacy/main.h     |   2 +-
 drivers/net/wireless/broadcom/b43legacy/phy.c      |   2 +-
 drivers/net/wireless/broadcom/b43legacy/phy.h      |   2 +-
 drivers/net/wireless/broadcom/b43legacy/pio.c      |   2 +-
 drivers/net/wireless/broadcom/b43legacy/radio.c    |   2 +-
 drivers/net/wireless/broadcom/b43legacy/radio.h    |   2 +-
 drivers/net/wireless/broadcom/b43legacy/rfkill.c   |   2 +-
 drivers/net/wireless/broadcom/b43legacy/sysfs.c    |   2 +-
 drivers/net/wireless/broadcom/b43legacy/xmit.c     |   2 +-
 drivers/net/wireless/morsemicro/mm81x/mac.c        |  20 +++-
 drivers/net/wireless/nxp/nxpwifi/11ax.c            |  67 ++++++++++----
 drivers/net/wireless/nxp/nxpwifi/scan.c            |  52 +++++++----
 drivers/net/wireless/nxp/nxpwifi/util.c            |   4 +
 drivers/net/wireless/realtek/rtw88/main.c          |   3 +
 drivers/net/wireless/realtek/rtw88/main.h          |   5 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |   3 +
 drivers/net/wireless/realtek/rtw88/tx.c            |  59 ++++++++++++
 drivers/net/wireless/realtek/rtw88/tx.h            |   4 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  64 +------------
 drivers/net/wireless/realtek/rtw88/usb.h           |   5 -
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |   4 +-
 drivers/ssb/b43_pci_bridge.c                       |   2 +-
 drivers/ssb/bridge_pcmcia_80211.c                  |   2 +-
 drivers/ssb/driver_chipcommon.c                    |   2 +-
 drivers/ssb/driver_chipcommon_pmu.c                |   2 +-
 drivers/ssb/driver_extif.c                         |   2 +-
 drivers/ssb/driver_gige.c                          |   2 +-
 drivers/ssb/driver_mipscore.c                      |   2 +-
 drivers/ssb/driver_pcicore.c                       |   2 +-
 drivers/ssb/embedded.c                             |   2 +-
 drivers/ssb/host_soc.c                             |   2 +-
 drivers/ssb/main.c                                 |   2 +-
 drivers/ssb/pci.c                                  |   2 +-
 drivers/ssb/pcihost_wrapper.c                      |   2 +-
 drivers/ssb/pcmcia.c                               |   2 +-
 drivers/ssb/scan.c                                 |   2 +-
 drivers/ssb/sdio.c                                 |   2 +-
 drivers/ssb/sprom.c                                |   2 +-
 drivers/usb/host/bcma-hcd.c                        |   2 +-
 drivers/usb/host/ssb-hcd.c                         |   2 +-
 include/linux/ssb/ssb_driver_chipcommon.h          |   2 +-
 include/net/mac80211.h                             |   3 +-
 include/uapi/linux/nl80211.h                       |   2 +-
 net/mac80211/airtime.c                             |   2 +
 net/mac80211/ap.c                                  |   3 +-
 net/mac80211/driver-ops.c                          |  14 ++-
 net/mac80211/ibss.c                                |  27 +++++-
 net/mac80211/ieee80211_i.h                         |   3 +
 net/mac80211/iface.c                               |   7 +-
 net/mac80211/link.c                                |  13 ++-
 net/mac80211/mlme.c                                |  35 ++++---
 net/mac80211/ocb.c                                 |  23 ++++-
 net/mac80211/rx.c                                  | 102 ++++++++++++++-------
 net/mac80211/scan.c                                |   5 +-
 net/mac80211/tx.c                                  |   6 ++
 net/wireless/nl80211.c                             |   6 +-
 net/wireless/scan.c                                |   3 +-
 net/wireless/util.c                                |   6 +-
 100 files changed, 513 insertions(+), 309 deletions(-)
