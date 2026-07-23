Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE39377574;
	Thu, 23 Jul 2026 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832652; cv=none; b=FPaG45FNPaDk4oSgsPd5IYAhVVa7YYQQ92njB7eWv7HtEJFEF7PMkfEyX5CYjclPqtXCx0otYVptgMg+JAYiF3U+QDZCyH3ZQeUMB+OoLlo9k6UiKJBRydsyMoDXw0VyCSFx5bnMLbvvyezY+MZTYA0hlgjMObAQ0pVTQqp2qbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832652; c=relaxed/simple;
	bh=a3NK/SgIXB9Drk3qfz5mL+TpX/TnU5R0mo3CdrXCOxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvI2Km4iUNMacXycoHz6XVkm7745SQ3+GUwddws70x6N7ycJ1fP4jFPK9K43IjhBeBKNIlkJvOKzNhEn91nJr+kG4DHX/ppL+QklLnez2SO62QU5r4qJTY72YiQwA1rweNa/FyNbdPqy33/yErrOyylf4H5M17wBsb+g5RkSGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYRd02kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYRd02kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA52C1F000E9;
	Thu, 23 Jul 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832641;
	bh=zE4mku3XfaKe8G+3otMAefAgynu4dPQmmP0XdQzdWUI=;
	h=From:To:Cc:Subject:Date;
	b=mYRd02ktzeVmzSmJX5SS/4Sm6Gu49fs967Atfd+cJnPCkB1i8H2fhARZkv8ZD764q
	 k+bzEpaGG9s+Ur6GjwLy4dUAP9uhsT+0YArxXNdYbh5oA65z4BhO6C+jpPct9895Dt
	 Ec3NVtqa5mqUXq0rf/LMWMS9NXU2Ar8fsAHVykHZuTDWPLBT8JydDUBsOB/BGjNn1F
	 GZJKK4OXETev8lIa0L39yEN+uH72RJPI2pxGshYUSzOKp9L0ahZ/GIQ0JWhpnISw2J
	 jkt+nHV0tQttfIHmZ7c2g6lyF0iGHSYPR/bPuToGBrNFcjzJbevVxok2/81Nx/TqwN
	 3OKWRLITT4H9A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.2-rc5
Date: Thu, 23 Jul 2026 11:50:40 -0700
Message-ID: <20260723185040.3891350-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit e13caf1c26587434f0b768193100440939c0fb91:

  Merge tag 'net-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-17 10:25:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc5

for you to fetch changes up to 6a8da869fa338e008533dd6385a0eb35dee6acf4:

  Merge branch 'drop_monitor-take-care-of-32bit-kernels' (2026-07-23 11:00:03 -0700)

----------------------------------------------------------------
Lots of fixes, double the count even for the "new normal".
Largely due to my time off followed by a networking conference
which distracted most maintainers (less so the AI generators).

Including fixes from Bluetooth and WiFi.

Current release - regressions:

 - wifi: mt76: fix MAC address for non OF pcie cards

Current release - new code bugs:

 - mptcp: fix BUILD_BUG_ON on legacy ARM config

 - wifi: cfg80211: guard optional PMSR nominal time

Previous releases - regressions:

 - qrtr: ns: raise node count limit to 512, we arbitrarily picked
   256 as a limit, turns out it was too low for real world deployments

 - vhost-net: fix TX stall when vhost owns virtio-net header

 - eth: amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN

 - wifi: ath12k: fix low MLO RX throughput on WCN7850

Previous releases - always broken:

 - number of random AI fixes for SCTP, RDS and TIPC protocols

 - more AI-looking fixes for WiFi drivers

 - number of fixes for missing pointer reloading after skb pull

 - reject BPF redirect use from qdisc qevent block

 - tcp: initialize standalone TCP-AO response padding

 - vsock/virtio: collapse receive queue under memory pressure to avoid
   client OOMing the host with tiny messages

 - ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup,
   make sure the ICMP response routing follows the routing policy

 - gro: fix double aggregation of flush-marked skbs

 - ovpn: fix various refcount bugs

 - tls: device: push pending open record on splice EOF

 - eth: mlx5:
  - use sender devcom for MPV master-up
  - fix MCIA register buffer overflow on 32 dword reads

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aldo Ariel Panzardo (3):
      rds: drop incoming messages that cross network namespace boundaries
      net/sched: serialize qdisc_rtab_list against concurrent get/put
      net: qrtr: restrict socket creation to the initial network namespace

Aleksandr Loktionov (1):
      ice: reject out-of-range ptype in ice_parser_profile_init

Alexei Lazar (2):
      net/mlx5e: Report zero bandwidth for non-ETS traffic classes
      net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation

Alice Mikityanska (1):
      mailmap: update entry for Alice Mikityanska

Andrew Pope (1):
      wifi: mac80211: recalculate TIM when a station enters power save

Aniket Negi (1):
      net: airoha: fix MIB stats collection to be lossless

Antoine Tenart (2):
      geneve: fix hint header definition wrt endianness
      geneve: ensure the skb is writable before fixing its headers

Arnd Bergmann (1):
      wifi: mt76: fix airoha_npu dependency tracking

Asim Viladi Oglu Manizada (1):
      pppoe: reload header pointer after dev_hard_header()

Avraham Stern (2):
      wifi: iwlwifi: mvm: verify scan id reported by firmware
      wifi: iwlwifi: mvm: copy the correct TK length for ranging

Benjamin Berg (1):
      wifi: mac80211: copy aggregation information

Breno Leitao (1):
      phonet: pep: fix use-after-free in pep_get_sb()

Bryam Vargas (1):
      net/iucv: fix use-after-free of a severed iucv_path

Cen Zhang (Microsoft) (4):
      sctp: validate stream count in sctp_process_strreset_inreq()
      tipc: fix u16 MTU truncation in media and bearer MTU validation
      rds: tcp: unregister sysctl before tearing down listen socket
      tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()

Cheng Yongkang (1):
      wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request

Chengfeng Ye (2):
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios

Chenguang Zhao (4):
      net: txgbe: fix heap overflow when reading module EEPROM
      net: txgbe: fix FDIR filter leak on remove
      hinic: remove unused ethtool RSS user configuration buffers
      mptcp: decrement subflows counter on failed passive join

Clark Wang (1):
      ptp: netc: explicitly clear TMR_OFF during initialization

Coia Prant (1):
      net: pcs: xpcs: fix SGMII state reading

Daehyeon Ko (1):
      tipc: clear sock->sk on the failed-insert path in tipc_sk_create()

Daniel Borkmann (2):
      bpf: Reject redirect helpers without a bpf_net_context
      selftests/bpf: Add test for redirect from qdisc qevent block

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

Danielle Ratson (1):
      netlink: specs: rt-link: convert bridge port flag attributes to u8

David Lee (2):
      net/packet: avoid fanout hook re-registration after unregister
      net/x25: fix use-after-free in x25_kill_by_neigh()

Devin Wittmayer (4):
      wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7925: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses
      wifi: mt76: restrict NPU/PPE active checks to MMIO devices

Diego Fernando Mancera Gomez (1):
      usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect

Dmitry Morgun (1):
      wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()

Doruk Tan Ozturk (5):
      wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
      mctp: serial: handle zero-length frames to prevent rx buffer overflow
      mac802154: llsec: reject frames shorter than the authentication tag
      vxlan: require CAP_NET_ADMIN in the device netns for changelink
      geneve: require CAP_NET_ADMIN in the device netns for changelink

Eddie Phillips (1):
      gve: fix Rx queue stall on alloc failure

Emil Tantilov (1):
      idpf: fix max_vport related crash on allocation error during init

Emmanuel Grumbach (30):
      wifi: iwlwifi: mvm: fix an off-by-1 boundary check
      wifi: iwlwifi: mld: fix an off-by-1 boundary check
      wifi: iwlwifi: mld: don't parse a notif before checking its length
      wifi: iwlwifi: mvm: fix the FCS truncation logic in d3
      wifi: iwlwifi: mld: validate reorder BAID
      wifi: iwlwifi: mvm: parse beacon notif per layout
      wifi: iwlwifi: mvm: validate MCC header before n_channels
      wifi: iwlwifi: mvm: validate sta_id in TLC notif
      wifi: iwlwifi: mvm: validate sta_id in BA window status notif
      wifi: iwlwifi: mvm: validate mac_link_id in session protect notif
      wifi: iwlwifi: mld: clear tzone on fail
      wifi: iwlwifi: mvm: fix sched scan IE sizing
      wifi: iwlwifi: pcie: null RX pointers after free
      wifi: iwlwifi: mvm: d3: validate D3 resume notification payloads
      wifi: iwlwifi: mld: validate txq_id in TX response handler
      wifi: iwlwifi: add support for additional channels in NVM_GET_INFO
      wifi: iwlwifi: mvm: validate TX_CMD response layout
      wifi: iwlwifi: fix pointer arithmetic in iwl_add_mcc_to_tas_block_list
      wifi: iwlwifi: validate payload length in iwl_pnvm_complete_fn
      wifi: iwlwifi: mvm: ptp: free response on success path
      wifi: iwlwifi: pcie: validate FW section counts in iwl_pcie_init_fw_sec
      wifi: iwlwifi: mvm: fix out-of-bounds tid_data access in BA notif
      wifi: iwlwifi: mvm: add a check on the tid coming from the firmware
      wifi: iwlwifi: mvm: fix a possible underflow
      wifi: iwlwifi: adapt ND match notif sizing to fixed matches array
      wifi: iwlwifi: bound aligned TLV advance in FW parser
      wifi: iwlwifi: dbg-tlv: bound aligned TLV walk length
      wifi: iwlwifi: acpi: validate WGDS table revision index
      wifi: iwlwifi: uefi: bound PPAG revision bitmap shift
      wifi: iwlwifi: validate SEC_RT TLV minimum size

Enrico Zanda (1):
      vhost-net: fix TX stall when vhost owns virtio-net header

Eric Dumazet (6):
      ppp: annotate concurrent dev->stats accesses
      net: hsr: fix memory leak on slave unregistration by removing synced VLANs
      ipv4: icmp: fill flow parameters in icmp_route_lookup decoy lookup
      ppp: annotate data races in ppp_generic
      drop_monitor: fix size calculations for 64-bit attributes
      drop_monitor: perform u64_stats updates under IRQ-disabled section

Fan Wu (3):
      wifi: brcmfmac: make release_scratchbuffers idempotent
      wifi: brcmfmac: drain bus_reset work on device removal
      net: hip04: fix RX buffer leak on build_skb failure

Gal Pressman (1):
      net/mlx5: Fix MCIA register buffer overflow on 32 dword reads

Gaole Zhang (1):
      wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin

Geliang Tang (2):
      mptcp: pm: userspace: fix use-after-free in get_local_id
      selftests: mptcp: userspace_pm: fix undefined variable port

Georgi Valkov (2):
      wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
      wifi: mwifiex: replace one-element arrays with flexible array members

Guangshuo Li (3):
      dpaa2-switch: put MAC endpoint device on disconnect
      dpaa2-eth: put MAC endpoint device on disconnect
      wifi: mt76: mt7925: guard link STA in decap offload

HE WEI (ギカク) (1):
      wifi: mwifiex: bound uAP association event IEs to the event buffer

HanQuan (1):
      sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid

Hariprasad Kelam (1):
      octeontx2-pf: tc: fix egress ratelimiting

Harshaka Narayana (1):
      vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets

Helen Koike (1):
      tipc: fix infinite loop in __tipc_nl_compat_dumpit

Hidayath Khan (1):
      net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

Huihui Huang (2):
      wifi: wilc1000: validate assoc response length before subtracting header
      wifi: at76c50x-usb: avoid length underflow in at76_guess_freq()

Ibrahim Hashimov (2):
      wifi: mac80211_hwsim: reject undersized HWSIM_ATTR_TX_INFO
      mac802154: hold an interface reference across the scan worker

Ilia Gavrilov (1):
      rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled

Jakub Kicinski (17):
      Merge branch 'fix-broken-tc_act_redirect-from-qdiscs'
      Merge branch 'net-fix-two-issues-in-sk_clone-error-path'
      Merge branch 'pds_core-fix-use-after-free-on-workqueue-during-remove'
      Merge branch 'selftests-net-add-missing-kconfig-and-settings'
      Merge branch 'amt-fix-use-after-free-of-the-skb-head-across-pulls'
      Merge tag 'wireless-2026-07-22' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2026-07-21' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      MAINTAINERS: add nci tests to nfc
      Merge branch 'net-bridge-fix-vlan-range-dumps-starting-with-a-pvid'
      Merge branch 'add-missing-facility-check-to-ptp_s390-driver'
      Merge branch 'vxlan-geneve-require-cap_net_admin-in-the-device-netns-for-changelink'
      Merge branch 'net-mlx5e-report-zero-bandwidth-for-non-ets-traffic'
      Merge branch 'tcp-validate-rst-sequence-in-syn-received'
      Merge branch 'intel-wired-lan-driver-updates-2026-07-17-ice-idpf-iavf'
      Merge tag 'ovpn-net-20260720' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'mptcp-misc-fixes-for-v7-2-rc5'
      Merge branch 'drop_monitor-take-care-of-32bit-kernels'

Jamal Hadi Salim (1):
      net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

James Raphael Tiovalen (1):
      vxlan: mdb: Fix source list corruption on a failed replace

Johannes Berg (3):
      Merge tag 'ath-current-20260713' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-fixes-2026-07-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'mt76-fixes-2026-07-22' of https://github.com/nbd168/wireless

Jose Ignacio Tornos Martinez (1):
      wifi: ath12k: fix NULL pointer dereference in rhash table destroy

Jun Yang (1):
      sctp: don't free the ASCONF's own transport in DEL-IP processing

Justin Lai (1):
      rtase: Workaround for TX hang caused by hardware packet parsing

Kalpan Jani (1):
      mptcp: fix stale skb->sk reference on subflow close

Kuniyuki Iwashima (3):
      soreuseport: Clear sk_reuseport_cb before failure in sk_clone().
      net: Call net_enable_timestamp() before failure in sk_clone().
      mpls: Set rt->rt_nhn just before returning from mpls_nh_build_multi().

Kyle Zeng (1):
      openvswitch: fix GSO userspace truncation underflow

Li RongQing (1):
      net: ipv6: fix dif and sdif mismatch in raw6_icmp_error

LiangCheng Wang (1):
      wifi: brcmfmac: set F2 blocksize to 256 for BCM43752

Lorenzo Bianconi (5):
      wifi: mt76: connac: fix possible NULL-pointer deref in mt76_connac_mcu_uni_bss_he_tlv()
      wifi: mt76: mt7925: fix possible NULL-pointer deref in mt7925_mcu_bss_he_tlv()
      wifi: mt76: mt7996: check pointer returned by mt76_connac_get_he_phy_cap()
      wifi: mt76: mt7996: fix possible NULL-pointer deref in mt7996_mcu_sta_bfer_eht()
      net: airoha: fix ETS channel derivation in airoha_tc_setup_qdisc_ets()

Luis Lang (1):
      net: stmmac: dwmac4: mask interrupts when stopping DMA in suspend

Manikanta Pubbisetty (1):
      wifi: ath10k: fix skb leak on incomplete msdu during rx pop

Manivannan Sadhasivam (2):
      wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET

Manjunath Patil (1):
      net/mlx5e: Use sender devcom for MPV master-up

Marcin Szycik (1):
      ice: fix LAG recipe to profile association

Marco Baffo (2):
      ovpn: fix use after free in unlock_ovpn()
      ovpn: use monotonic clock for peer keepalive timeouts

Markus Breitenberger (1):
      net: stmmac: intel: skip SerDes reconfig when rate is unchanged

Matthieu Baerts (NGI0) (8):
      selftests: af_unix: add USER_NS config
      selftests: openvswitch: add config file
      selftests: ovpn: add IPV6 and VETH configs
      selftests: ovpn: increase timeout
      selftests: drv-net: increase timeout
      selftests: drv-net: add missing kconfig for psp.py
      selftests: netconsole: ignore busywait errors
      mptcp: fix BUILD_BUG_ON on legacy ARM config

Maxime Chevallier (1):
      MAINTAINERS: Add myself for stmmac ethernet driver maintainance

Michael Bommarito (4):
      mptcp: only set DATA_FIN when a mapping is present
      amt: re-read skb header pointers after every pull
      amt: make the head writable before rewriting the L2 header
      ila: reload IPv6 header after pskb_may_pull in checksum adjust

Michael Grzeschik (1):
      mailmap: fix wrong canonical name for mgr@kernel.org

Michael Walle (2):
      net: phy: marvell: fix return code
      net: dpaa: fix mode setting

Michal Swiatkowski (1):
      ice: pass the return value of skb_checksum_help()

Minhong He (2):
      mctp: check register_netdevice_notifier() error in mctp_device_init()
      phonet: check register_netdevice_notifier() error in phonet_device_init()

Myeonghun Pak (1):
      net: mctp i3c: clean up notifier and buses if driver register fails

Nazim Amirul (3):
      net: stmmac: xgmac: fix l4 filter port overwrite on register update
      net: stmmac: fix l3l4 filter rejecting unsupported offload requests
      net: stmmac: reset residual action in L3L4 filters on delete

Nicolai Buchwitz (1):
      MAINTAINERS: remove Rengarajan Sundararajan from LAN78XX

Nicolas Cavallari (1):
      wifi: mt76: Disable napi when removing device

Nikhil P. Rao (7):
      pds_core: reject component parameter in legacy firmware update
      pds_core: fix deadlock between reset thread and remove
      pds_core: fix use-after-free on workqueue during remove
      pds_core: yield the CPU while waiting for the adminq to drain
      pds_core: order completion reads after the ownership check
      pds_core: fix auxiliary device add/del races
      pds_core: check for workqueue allocation failure

Nikola Z. Ivanov (1):
      ipv6: Change allocation flags to match rcu_read_lock section requirements

Nikolay Aleksandrov (2):
      net: bridge: vlan: fix vlan range dumps starting with pvid
      selftests: net: bridge: test ranges with PVID VLAN

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mvm: validate SAR GEO response payload size

Paolo Abeni (2):
      Merge branch 'vsock-virtio-collapse-receive-queue-under-memory-pressure'
      Merge branch 'net-stmmac-l3-l4-filter-bug-fixes'

Paul Greenwalt (2):
      ice: fix PTP Call Trace during PTP release
      ice: prevent tstamp ring allocation for non-PF VSI types

Pavitra Jha (1):
      ovpn: fix peer refcount leak in TCP error paths

Pengpeng Hou (1):
      Bluetooth: btusb: validate Realtek vendor event length

Prashanth Kumar KR (1):
      amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN

Qing Luo (1):
      sctp: auth: verify auth requirement when auth_chunk is NULL

Qing Ming (1):
      ovpn: avoid putting unrelated P2P peer on socket release

Ricardo B. Marlière (1):
      selftests/net: Fix tun IPv6 test addresses to avoid 6to4 range

Rishikesh Jethwani (1):
      tls: device: push pending open record on splice EOF

Rosen Penev (1):
      wifi: mt76: fix MAC address for non OF pcie cards

Runyu Xiao (1):
      raw: annotate lockless match fields in raw_v4_match()

Ruoyu Wang (3):
      nfp: Check resource mutex allocation
      wan: wanxl: Only reset hardware after BAR mapping
      wifi: mt76: mt7915: guard HE capability lookups

Sean Wang (1):
      wifi: mt76: mt7925: fix crash in reset link replay

Sergey Temerkhanov (1):
      ice: use READ_ONCE() to access cached PHC time

Shahar Tzarfati (2):
      wifi: iwlwifi: fw: validate SMEM response size
      wifi: iwlwifi: mvm: fix read in wake packet notification handler

Shelley Yang (1):
      wifi: brcmfmac: fix 802.1X-SHA256 call trace warning

Shihuang Liu (1):
      amt: fix use-after-free in AMT delayed works

Shiming Cheng (1):
      net: gro: fix double aggregation of flush-marked skbs

Shuvam Pandey (1):
      ovpn: hold peer before scheduling keepalive work

Stefano Garzarella (2):
      vsock/virtio: collapse receive queue under memory pressure
      vsock/test: add test for small packets under pressure

Suman Ghosh (1):
      octeontx2-vf: set TC flower flag on MCAM entry allocation

Sungmin Kang (1):
      net: slip: serialize receive against buffer reallocation

Sven Schnelle (2):
      s390/ptff: Export ptff_function_mask[]
      ptp: ptp_s390: Add missing facility check

Tristan Madani (6):
      wifi: ath6kl: fix OOB access from firmware ADDBA window size
      wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      wifi: carl9170: fix OOB read from off-by-two in TX status handler
      wifi: carl9170: fix buffer overflow in rx_stream failover path

Vikas Gupta (1):
      bnge/bng_re: fix ring ID widths

Vincent Chen (1):
      ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV

Wayen Yan (2):
      net: airoha: Fix potential use-after-free in airoha_ppe_deinit()
      net: airoha: Fix DMA direction for NPU mailbox buffer

Weiming Shi (1):
      tipc: serialize udp bearer replicast list updates

Wentao Liang (1):
      wifi: ath11k: fix refcount leak in ath11k_ahb_fw_resources_init()

Xiang Mei (1):
      wifi: mac80211: tear down new links on vif update error path

Xiang Mei (Microsoft) (3):
      gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
      nexthop: initialize extack in nh_res_bucket_migrate()
      bpf: tcp: fix double sock release on batch realloc

Xuanqiang Luo (1):
      rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()

Yael Chemla (1):
      net/mlx5: E-Switch, fix zero num_dest in prio_tag egress vlan rule

Yehyeong Lee (1):
      net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

Yingying Tang (1):
      wifi: ath12k: Fix low MLO RX throughput on WCN7850

Yizhou Zhao (1):
      tcp: initialize standalone TCP-AO response padding

Youssef Samir (1):
      net: qrtr: ns: Raise node count limit to 512

Yun Zhou (1):
      net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM

Yuxiang Yang (2):
      tcp: challenge ACK for non-exact RST in SYN-RECEIVED
      selftests/net: packetdrill: cover RST validation in SYN-RECEIVED

Zhao Li (1):
      wifi: cfg80211: guard optional PMSR nominal time

Zhaolong Zhang (1):
      bonding: fix devconf_all NULL dereference when IPv6 is disabled

Zhiling Zou (2):
      sctp: avoid auth_enable sysctl UAF during netns teardown
      sctp: close UDP tunnel sockets during netns teardown

Zhixing Chen (1):
      gtp: parse extension headers before reading inner protocol

longlong yan (1):
      selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()

vadik likholetov (1):
      net: stmmac: enable the MAC on link up for all supported speeds

 .mailmap                                           |  11 +-
 Documentation/netlink/specs/rt-link.yaml           |  40 ++---
 MAINTAINERS                                        |   5 +-
 arch/s390/kernel/time.c                            |   1 +
 drivers/bluetooth/btusb.c                          |   4 +-
 drivers/infiniband/hw/bng_re/bng_dev.c             |   6 +-
 drivers/net/amt.c                                  | 101 ++++++++---
 drivers/net/bonding/bond_main.c                    |   3 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 174 +++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h           |  27 +++
 drivers/net/ethernet/airoha/airoha_npu.c           |   4 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   1 +
 drivers/net/ethernet/amd/pds_core/adminq.c         |  12 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c         |  17 +-
 drivers/net/ethernet/amd/pds_core/core.c           |  22 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   6 +
 drivers/net/ethernet/amd/pds_core/main.c           |  14 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  11 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h          |   1 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |   8 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h |   2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |  50 +++---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |   4 +-
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h     |   2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   1 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |  17 +-
 drivers/net/ethernet/google/gve/gve.h              |   3 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  34 ++++
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  11 +-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h      |   2 -
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |  21 ---
 drivers/net/ethernet/intel/ice/ice.h               |   3 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   3 -
 drivers/net/ethernet/intel/ice/ice_lag.c           |   2 +-
 drivers/net/ethernet/intel/ice/ice_parser.c        |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   7 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  14 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  20 +--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  29 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  15 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/esw/acl/helper.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   4 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_resource.c  |   3 +
 drivers/net/ethernet/realtek/rtase/rtase.h         |   8 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    | 197 +++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  31 ++++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  24 +++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  28 +--
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  96 +++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  35 ++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     |   6 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   1 +
 drivers/net/geneve.c                               |  27 ++-
 drivers/net/gtp.c                                  |  17 +-
 drivers/net/mctp/mctp-i3c.c                        |  11 +-
 drivers/net/mctp/mctp-serial.c                     |   2 +-
 drivers/net/ovpn/io.c                              |   4 +-
 drivers/net/ovpn/peer.c                            |  16 +-
 drivers/net/ovpn/tcp.c                             |   6 +-
 drivers/net/pcs/pcs-xpcs.c                         |  34 +---
 drivers/net/phy/marvell.c                          |   2 +-
 drivers/net/ppp/ppp_generic.c                      |  82 +++++----
 drivers/net/ppp/pppoe.c                            |   1 +
 drivers/net/slip/slip.c                            |   4 +
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  22 ++-
 drivers/net/vxlan/vxlan_core.c                     |   3 +
 drivers/net/vxlan/vxlan_mdb.c                      |  30 ++--
 drivers/net/wan/wanxl.c                            |   3 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   2 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   3 +
 drivers/net/wireless/ath/ath11k/pci.c              |   4 +
 drivers/net/wireless/ath/ath11k/qmi.c              |  11 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |  11 +-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |   1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   7 +-
 drivers/net/wireless/ath/ath12k/hw.h               |  16 ++
 drivers/net/wireless/ath/ath12k/mac.c              |  10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   4 +
 drivers/net/wireless/ath/ath12k/peer.c             |   3 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  33 ++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   6 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   3 +
 drivers/net/wireless/ath/ath6kl/txrx.c             |  12 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              |  20 +++
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   7 +-
 drivers/net/wireless/ath/carl9170/rx.c             |   7 +-
 drivers/net/wireless/ath/carl9170/tx.c             |   2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  14 ++
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   6 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  46 ++++-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   6 +
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.h    |   1 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   3 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  33 +++-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c       |  28 ++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  64 ++++---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |  10 +-
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  46 +++--
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  55 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  10 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  25 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |  43 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  45 ++++-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c    |   9 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |  18 +-
 drivers/net/wireless/marvell/mwifiex/join.c        |   8 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |  14 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   2 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |  24 ++-
 drivers/net/wireless/mediatek/mt76/Kconfig         |   4 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |   6 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   5 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   6 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  18 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  19 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   5 +
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |   6 +-
 drivers/ptp/ptp_netc.c                             |   1 +
 drivers/ptp/ptp_s390.c                             |   6 +-
 drivers/usb/atm/ueagle-atm.c                       |  17 ++
 drivers/vhost/net.c                                |   8 +-
 include/linux/bnge/hsi.h                           |   7 +-
 include/linux/mlx5/mlx5_ifc.h                      |  13 +-
 include/net/bluetooth/rfcomm.h                     |   3 +
 include/net/pkt_cls.h                              |  14 +-
 include/net/tcp.h                                  |   2 +
 net/bluetooth/hci_sync.c                           |  13 +-
 net/bluetooth/rfcomm/core.c                        |  17 ++
 net/bluetooth/rfcomm/tty.c                         |   7 +-
 net/bridge/br_netlink_tunnel.c                     |   3 +-
 net/bridge/br_private.h                            |   6 +-
 net/bridge/br_vlan.c                               |  10 +-
 net/bridge/br_vlan_options.c                       |   3 +-
 net/core/drop_monitor.c                            |  18 +-
 net/core/filter.c                                  |  17 +-
 net/core/gro.c                                     |   4 +-
 net/core/sock.c                                    |  10 +-
 net/hsr/hsr_slave.c                                |   2 +
 net/ipv4/datagram.c                                |   4 +-
 net/ipv4/icmp.c                                    |  18 +-
 net/ipv4/ip_gre.c                                  |   4 +-
 net/ipv4/nexthop.c                                 |   2 +-
 net/ipv4/raw.c                                     |  23 ++-
 net/ipv4/tcp_input.c                               |  56 ++++--
 net/ipv4/tcp_ipv4.c                                |   8 +-
 net/ipv4/tcp_minisocks.c                           |  12 +-
 net/ipv6/ila/ila_common.c                          |  12 ++
 net/ipv6/ip6_gre.c                                 |   4 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/route.c                                   |   4 +-
 net/ipv6/tcp_ipv6.c                                |   2 +
 net/iucv/af_iucv.c                                 |  17 +-
 net/mac80211/cfg.c                                 |   3 +
 net/mac80211/link.c                                |   4 +
 net/mac80211/rx.c                                  |   2 +
 net/mac802154/llsec.c                              |   5 +
 net/mac802154/scan.c                               |  11 ++
 net/mctp/device.c                                  |   4 +-
 net/mpls/af_mpls.c                                 |   8 +-
 net/mptcp/options.c                                |  17 +-
 net/mptcp/pm_userspace.c                           |   7 +-
 net/mptcp/protocol.c                               |  34 ++--
 net/openvswitch/actions.c                          |  19 +-
 net/openvswitch/datapath.c                         |  25 +--
 net/openvswitch/datapath.h                         |   2 +-
 net/openvswitch/vport.c                            |   2 +-
 net/packet/af_packet.c                             |   6 +-
 net/phonet/pep.c                                   |   2 +
 net/phonet/pn_dev.c                                |  30 +++-
 net/qrtr/af_qrtr.c                                 |   8 +
 net/qrtr/ns.c                                      |   4 +-
 net/rds/ib.c                                       |   4 +
 net/rds/ib_cm.c                                    |   4 +
 net/rds/recv.c                                     |  15 ++
 net/rds/tcp.c                                      |  12 +-
 net/rxrpc/ar-internal.h                            |   6 +-
 net/sched/cls_api.c                                |   6 +-
 net/sched/sch_api.c                                |  24 ++-
 net/sched/sch_cake.c                               |   2 +-
 net/sched/sch_drr.c                                |   2 +-
 net/sched/sch_dualpi2.c                            |   2 +-
 net/sched/sch_ets.c                                |   2 +-
 net/sched/sch_fq_codel.c                           |   2 +-
 net/sched/sch_fq_pie.c                             |   2 +-
 net/sched/sch_hfsc.c                               |   2 +-
 net/sched/sch_htb.c                                |   2 +-
 net/sched/sch_multiq.c                             |   2 +-
 net/sched/sch_prio.c                               |   2 +-
 net/sched/sch_qfq.c                                |   2 +-
 net/sched/sch_sfb.c                                |   2 +-
 net/sched/sch_sfq.c                                |   2 +-
 net/sctp/auth.c                                    |   2 +-
 net/sctp/protocol.c                                |  21 ++-
 net/sctp/sm_make_chunk.c                           |   6 +
 net/sctp/sm_statefuns.c                            |   2 +-
 net/sctp/stream.c                                  |   6 +-
 net/sctp/sysctl.c                                  |   9 +-
 net/tipc/netlink.c                                 |   6 +-
 net/tipc/netlink_compat.c                          |   4 +
 net/tipc/socket.c                                  |   5 +-
 net/tipc/udp_media.c                               |  56 +++---
 net/tls/tls_device.c                               |   6 +-
 net/vmw_vsock/virtio_transport_common.c            | 165 ++++++++++++++++-
 net/wireless/pmsr.c                                |   5 +-
 net/x25/af_x25.c                                   |   8 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/tc_qevent.c | 113 ++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_qevent.c |  23 +++
 tools/testing/selftests/drivers/net/config         |   3 +
 .../drivers/net/netconsole/netcons_cmdline.sh      |   2 +-
 .../net/netconsole/netcons_fragmented_msg.sh       |   4 +-
 .../drivers/net/netconsole/netcons_resume.sh       |   2 +-
 .../drivers/net/netconsole/netcons_sysdata.sh      |   2 +-
 tools/testing/selftests/drivers/net/settings       |   1 +
 tools/testing/selftests/net/af_unix/config         |   1 +
 tools/testing/selftests/net/bridge_vlan_dump.sh    |  23 +++
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   2 +-
 tools/testing/selftests/net/openvswitch/config     |  16 ++
 tools/testing/selftests/net/ovpn/config            |   2 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |   4 +-
 tools/testing/selftests/net/ovpn/settings          |   1 +
 .../net/packetdrill/tcp_rfc5961_rst-syn-recv.pkt   |  61 +++++++
 tools/testing/selftests/net/tun.c                  |   8 +-
 tools/testing/vsock/vsock_test.c                   |  87 +++++++++
 264 files changed, 2774 insertions(+), 887 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_qevent.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_qevent.c
 create mode 100644 tools/testing/selftests/drivers/net/settings
 create mode 100644 tools/testing/selftests/net/openvswitch/config
 create mode 100644 tools/testing/selftests/net/ovpn/settings
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_rst-syn-recv.pkt
