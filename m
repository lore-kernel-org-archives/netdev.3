Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803A54788;
	Sat, 15 Aug 2026 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786835818; cv=none; b=ldqUlg+Iu/7AAAFSAia9HQCZuxWfaNyoWd9gVaqMKjMuUX9LBIDR/okGkiFYEd/1rK5aPGlh7G/oomTig432EmMo9e/hxss93wfqSknvyK8T4EqYFT2lFrFtdAIDbYByQ5RiNppMejQiNIspNuan5CvJCgb+3QLKez6IR2vMJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786835818; c=relaxed/simple;
	bh=bbZeRCOBRUO/ne6MNZpttW400VANN08aMmfw52Ynaaw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=CUJPU38rtCyeV+rHD2qmriZRzvKEwT9+eW2ZaPVuo8fsWV610ry9rwXh25eRkLPjZabaSPgJjbGGl4EnqElVP+glPbjwIFrwuhky985nZxmAQag/bfwUmcKZjWMDNcwH0zB5dQg1tBNYo3b2y1uxY2xSpjZUJtSSucYRwWM5W5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnYnKaVJ reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnYnKaVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7031F000E9;
	Sat, 15 Aug 2026 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786835816;
	bh=EZONV+mmqNKg90YlXURJ16OttGU6ksDb+t7bA0yxhVE=;
	h=Date:From:To:Cc:Subject;
	b=XnYnKaVJQRmhZcR+cx6mS+WlPzl6KXRLlMp4EbEXgk5YLxL+Bi+XyOVvcV94RH0Bq
	 wfluspLE4iVxMx7qQC/T991QE6o9eqzjy8eDDJezullDY8yfe5WNiOpAecb8XHvMEI
	 J6UwMwYvHU4aieUlqsDXJehQQzLknt+M5pDHGg3kGhIUv8UL4fTGPkw3I0VUpgt3JB
	 6pG3gCRMQP3TwICeICKo/RWm7ltabykGtlGqWsJjiAYkALL9cZOa08gApZrKNaM0tu
	 OLctSUJnHnMo+FhgRcF044dKNDONqy0MJrzbCS5O9UFXQJTEqAGhTRW06YML3bPGwr
	 u/b/3xoHv1IrQ==
Date: Sat, 15 Aug 2026 13:16:55 -1000
Message-ID: <a974e086e6aa42e341612cbd240bc971@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: netdev@vger.kernel.org
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Hayes Wang <hayeswang@realtek.com>,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	linux-usb@vger.kernel.org
Subject: RTL8157 (0bda:8157): intermittent silent traffic stalls with in-tree r8152 (v7.1+)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hello,

This report was researched and written by an AI agent (Claude Code)
going through the affected machine's logs at my direction. It is
informational. I'm not asking for immediate action, just putting the
data points on the list for whoever is working on RTL8157 support.
Uncertainties are marked inline.

Setup: a small Alder Lake-N box (AZW MINI S) acting as a network
gateway, running Arch distro kernels. Two Realtek USB NICs are ports of
the same bridge (so both run promiscuous): an RTL8157 (0bda:8157,
bcdDevice 30.00, USB 3.2 Gen2) on the LAN-facing leg and an RTL8156
(0bda:8156) on the WAN-facing leg. The RTL8157 leg is TX-heavy (~35GB
TX vs ~5GB RX over a typical two-day window).

The RTL8157 has been in service since 2025-10. Kernels before v7.1
don't bind it to r8152, so it ran via cdc_ncm with zero incidents,
including a clean 30-day uptime on 7.0.11 ending 2026-07-09. That day
the box moved to 7.1.3, where the new native support (fd3c7d080df5
("r8152: Add support for the RTL8157 hardware")) took over. Since then
the bridge has stopped passing traffic four times in five weeks:

- 2026-07-13 (7.1.3): outside access lost in the morning, power-cycled
  hours later. That evening the RTL8157 flapped carrier several times
  over ~40 minutes and twice spontaneously dropped off the bus and
  re-enumerated, all within 3 seconds. Stable after a reboot.

- 2026-07-29 (7.1.5): same silent loss in the morning, recovered by
  power cycle ~8 hours later.

- 2026-08-06 (7.1.5): network path dead in the morning while the box
  itself was fine (sshable from the LAN). Both adapters were manually
  replugged. The RTL8157 re-enumerated and got carrier, dropped off
  the bus again 2 seconds later, and on the next enumeration the first
  init pass failed: a control read failed with -71 and
  r8157_hw_phy_cfg() hit its WARN (never reached PHY_STAT_LAN_ON).
  The driver's follow-up reset then succeeded and the network
  recovered without a reboot. Splat below.

- 2026-08-13 (7.1.8): network path dead in the morning, kernel alive.
  Both adapters replugged (clean re-enumeration this time), box
  rebooted for good measure. Stable since.

In every dead window the logs show nothing at all: no carrier loss, no
USB events, no driver or xhci errors. Interfaces stay present with
carrier up while traffic stops. The only artifacts are what surfaced
during recovery, i.e. the -71/WARN above.

Caveats: the association with v7.1 is timing-based. For the 07-13 and
07-29 morning incidents the journal is simply silent, so a system-level
hang can't be ruled out for those two. The 08-06 and 08-13 incidents
are confirmed to be network-path-only. On 08-06 the box was reachable
over the RTL8157 leg minutes before the replug, so which leg had
stalled first isn't proven either. The companion RTL8156 has run on
native r8152 on this box since 2024-09 without issues.

Possibly related (conjecture): the RTL8157 firmware lockup reported in
2025-12 against the out-of-tree Realtek driver, where sustained SG/GSO
TX wedges the firmware until a full USB reset, with control transfers
timing out, and disabling NETIF_F_SG/NETIF_F_FRAGLIST mitigates it:

  https://lore.kernel.org/netdev/CACw+751Y=f4ARfdiPYAMaXrE0jCBGkrL-k3+XDoCHEo-6kZxzw@mail.gmail.com/

The in-tree driver enables SG/TSO/FRAGLIST by default and this box's
RTL8157 leg is TX-heavy, while cdc_ncm's linear NTB TX path wouldn't
exercise scatter-gather, which would fit the before/after behavior.

Checked v7.1..current mainline (3eb40771c00a): the r8152 changes there
(RTL8159 support, 10G EEE, PHY firmware upload capability, a
r8157_hw_phy_cfg() refactor, a double bit-clear fix) don't appear to
address this, and the failing PHY_STAT_LAN_ON check is unchanged.

The WARN captured on 2026-08-06 (7.1.5-arch1-1):

  r8152-cfgselector 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 6 using xhci_hcd
  r8152 2-1:1.0: skip request firmware
  r8152-cfgselector 2-1: Failed to read 4 bytes at 0xb6d4/0x0133 (-71)
  ------------[ cut here ]------------
  ret != PHY_STAT_LAN_ON
  WARNING: drivers/net/usb/r8152.c:7991 at r8157_hw_phy_cfg+0xe9b/0xeb0 [r8152], CPU#3: kworker/3:2/1002949
  Modules linked in: wireguard libcurve25519 ip6_udp_tunnel snd_hda_codec_intelhdmi udp_tunnel cdc_mbim snd_hda_codec_hdmi cdc_wdm bridge cdc_ncm stp cdc_ether llc snd_hda_codec_alc662 usbnet snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation snd_soc_sdw_utils snd_soc_acpi soundwire_bus snd_soc_sdca intel_rapl_msr crc8 intel_rapl_common snd_soc_avs snd_soc_hda_codec snd_hda_ext_core x86_pkg_temp_thermal snd_hda_codec intel_powerclamp coretemp snd_hda_core snd_intel_dspcfg kvm_intel snd_intel_sdw_acpi snd_hwdep snd_soc_core kvm snd_compress ac97_bus r8169 irqbypass iTCO_wdt snd_pcm_dmaengine btusb aesni_intel realtek intel_pmc_b
 xt snd_pcm ee1004 btmtk
   nf_tables btrtl phy_package snd_timer i2c_i801 btbcm gf128mul nfnetlink mdio_devres iwlmvm btintel i2c_smbus libphy rapl snd intel_cstate spi_nor wmi_bmof mdio_bus pcspkr intel_uncore mtd soundcore i2c_mux mei_me bluetooth 8250_dw mac80211 mei r8152 mii ptp pps_core libarc4 aead intel_pmc_core iwlwifi pmt_telemetry pmt_discovery intel_oc_wdt pmt_class pps_gen_tio joydev intel_pmc_ssram_telemetry mousedev pps_gen_core pinctrl_alderlake vfat cfg80211 fat acpi_pad acpi_tad igen6_edac rfkill mac_hid xe intel_vsec drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm drm_exec drm_gpusvm_helper spi_pxa2xx_platform i915 dw_dmac spi_pxa2xx_core drm_buddy i2c_algo_bit video spi_intel_pci intel_lpss_pci ttm spi_intel intel_lpss intel_gtt idma64 drm_display_helper wmi cec uas usb_storage
  CPU: 3 UID: 0 PID: 1002949 Comm: kworker/3:2 Tainted: G S                  7.1.5-arch1-1 #1 PREEMPT(full)  bce30b97cc4aafc7123e6f9c4abbbcae2d599f9c
  Tainted: [S]=CPU_OUT_OF_SPEC
  Hardware name: AZW MINI S/MINI S, BIOS ADLNV105 12/12/2023
  Workqueue: events_long rtl_hw_phy_work_func_t [r8152]
  RIP: 0010:r8157_hw_phy_cfg+0xe9b/0xeb0 [r8152]
  Code: be 7e b8 00 00 48 89 df 0f b6 d0 80 ce 50 e8 1c 20 ff ff e9 bc f2 ff ff be 01 00 00 00 48 89 df e8 ba ec ff ff e9 cd f3 ff ff <0f> 0b e9 0a f2 ff ff e8 89 ce dc ec 66 0f 1f 84 00 00 00 00 00 90
  RSP: 0018:ffffcfed84c77de0 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: ffff8e8e47256ac0 RCX: 0000000000000002
  RDX: 0000000000000000 RSI: 0000000000000287 RDI: 0000000000000000
  RBP: ffff8e8e47256ac0 R08: 000259f6d0b2aeef R09: 0000000000000001
  R10: 0000000000000010 R11: 0000000000000000 R12: ffff8e8e47256e98
  R13: ffff8e8e401c1805 R14: 0000000000000000 R15: ffff8e8e47256e98
  FS:  0000000000000000(0000) GS:ffff8e92006d0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f8135c4d480 CR3: 0000000455a22000 CR4: 0000000000f52ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   rtl_hw_phy_work_func_t+0x205/0x8f0 [r8152 ce92b748190746793289ba069c4da29ccde93c48]
   process_one_work+0x19f/0x390
   worker_thread+0x1b1/0x310
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xe4/0x120
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x2a7/0x330
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

Happy to provide more logs. The box is a small production gateway, so
live experimentation on it is limited.

Thanks.

-- 
tejun
