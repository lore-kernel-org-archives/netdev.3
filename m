Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513661;
	b=q7rC6Xm0VBWhuBRa0sdytAIcnmpGFpPkBIX66OQmvVuU5Gf76x+yr4a/bK60N2e0nMtF
	 SIEDs1POfafuB7yvR4ILvIzl8MzxHui5C3v5Ug2Uzdi0FAr/0l7iGxhRVHQt2LqgdfVLW
	 UqJtu3pLWX6dA3MRvU6gsiJTEgnzxLW+BJgLVAJOFrY6BT7qF4zpP2orVBsKsQW3nPTri
	 Ec3CzJs6hjWC978pZ/lq0QqHVwyeGzqWsxF6qvA2jIJ0UNjEbYBPh2AA7Avs8VkxPH75i
	 ecWQMtv9njfqu5DwAbybnNAolDyTxLwPlflk22FRBu4G57RVmUXQFFHXe0SWej6TTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YZfN8QFtoa2oVDONbEX5nKZ94ch012TpGAt9WaKn9JU=;
	b=egPLapQsmUkA+3pyd/nnsvmhKJWv7nhvQDOjxL3SBpClBSSc4ormTsgG4Z6kCyIkHH4b
	 LuUcBDGcwJRUnZ709b1OrSQHuTWfQ2ATJsyf8WskUzFpi8vs9kLOZ8eSI/MhNi0QOfZBS
	 7BO+CVxudXLJ0uuBHIT8vibk6CnvPRyubfdyI4eXNn76r8rM9IWJn9qnqMYcdi+eLO/kx
	 ASCQcbcA4IQXBT1L6578vrQKC+C55pAH2YSYSmQaQrKEGb510Hphe+54w3hkTATG+hYOh
	 5Jxzdd3mTtuJFLuM6GHU75pg5mddxW+iG+jpJCIeAxZ2ybB0iaN8+tjCPGgW03H2xmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M87YTSgj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397260A261B;
	Thu, 12 Nov 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M87YTSgj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A171F000C7;
	Thu, 12 Nov 2026 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513661;
	bh=YZfN8QFtoa2oVDONbEX5nKZ94ch012TpGAt9WaKn9JU=;
	h=From:To:Cc:Subject:Date;
	b=M87YTSgj+MdJBY2Xma7OEDIW4Z03wdUPKgq6t5wfmCEUwW+BvEt4/QBd1Tjf2ZUHu
	 zfjJVPuaPvypmGbhkPPg3WTVfQsYbGhFz2cmOWE1N8EqhNj1LPrYfvurmkd4m5I4/f
	 44xMh/PahaheAVxib/z31wjA76RcVfjsp9Ii/rMOQPQM1bZQNs+U4TS4xuy+oEvD35
	 YBF7HizJEwqah1lCQZfy7hsWXMQDnsbhXNfy1pyA+KWCaBYTmhfECJV1+FdP01s68K
	 8PEqH1402H7mu5R/iKpujrKliutV6i08Tb9pwUYJaYnB1TBaff7EOQRr9tA/hbzGw6
	 0IIeBhCV0xUvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.4-rc3
Date: Thu, 12 Nov 2026 12:01:00 -0800
Message-ID: <20261112200100.519879-1-kuba@kernel.org>
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

Hi Linus!

The following changes since commit f66469d9905b39d2c260a15d7d6db450f4db67c1:

  Merge tag 'net-7.4-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-05 18:00:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc3

for you to fetch changes up to dee3429e94d8089713645706df678ec54a049e13:

  Merge branch 'nsh-limit-recursion-in-nsh_gso_segment' (2026-11-12 11:25:31 -0800)

----------------------------------------------------------------
Including fixes from netfilter, wireless and bluetooth.

Previous releases - regressions:

 - tcp: rate limit receive queue collapsing

 - raw: fix ICMP unreachable sent when receive queue is full

 - eth: bnxt_en: take RTNL before netif_close() when aborting FW reset

Previous releases - always broken:

 - tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND

 - gro: invalidate frag0 after a pull

 - gro: avoid parsing headers from shared fragments

 - cipso: stop modifying live ip_options_rcu

 - tcp: number of fixes for TCP Fast Open

 - udp: do not use a cross-family sk_rx_dst in early demux

 - fou: gue: check IP version of held packets for direct IP encapsulation

 - skbuff: preserve fclone lifetime when freeing stolen heads

 - eth:
  - mlx5e: fix crashes on queue stats access to queues without stats
  - mlx5e: SHAMPO, disable end padding when relaxed ordering is
    supported, avoid data corruption

 - eth: ena: keep the RX buffer mapped if skb allocation fails

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexander Duyck (6):
      fbnic: Take the instance lock to restore filters after a FW crash
      fbnic: Fix service task races with ndo_stop and PM suspend
      fbnic: Disable PTP completions during the Tx force-flush
      fbnic: Suspend phylink after taking the datapath down in ndo_stop
      fbnic: Wait for the outbound flush to complete on mailbox teardown
      net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist

Alexandra Winter (1):
      MAINTAINERS: Add Hidayath as net/iucv maintainer

Alexandre Cassen (1):
      net/mlx5: HWS, fix flow meter release on FTE update

Alexei Lazar (1):
      net/mlx5e: Fix false WARN_ON_ONCE in flow steering cleanup on RX init failure

Alexei Starovoitov (1):
      ipv6: Check the Home Address option again before its address is used

Anandu Padinhare (1):
      net: stmmac: count XDP_PASS frames in rx_packets on the XSK zero-copy path

Andrea Parri (1):
      hv_sock: Report no unread data before a channel is available

Andrey Misiurov (1):
      sctp: fix ASCONF address change on single-homed hosts

Anil Kaushik (1):
      netlink: Do not call the unbind callback with the table locked

Antonio Quartulli (1):
      udp_tunnel: don't treat IPv4 sockets bound to an address as wildcard

Arnd Bergmann (1):
      net: octeontx2: fix building without DEBUGFS

Avi Weiss (1):
      net: ena: avoid RX copybreak for multi-descriptor packets

Baochen Qiang (1):
      wifi: ath12k: don't advertise EHT-MCS15 to firmware unless we support it

Benjamin Berg (2):
      wifi: mac80211: do not switch to invalid link
      wifi: mac80211: find STA for beacons belonging to non-TX BSS

Benoit Masson (1):
      wifi: ath12k: assign device id from the WSI index

Breno Leitao (2):
      net/mlx5e: Fix queue stats access to queues without stats
      net: ena: Keep the RX buffer mapped if skb allocation fails

Bryan Cochrane (1):
      bnxt_en: Take RTNL before netif_close() when aborting FW reset

Carolina Jubran (1):
      net/mlx5: Use only loaded devices for PTP clock operations

Cen Zhang (Microsoft) (1):
      netfilter: xt_recent: do not call remove_proc_entry() under recent_lock

Changyul Lee (1):
      net/mlx5: macsec: Don't remove fs_id when adding a rule fails

Chase Hiltz (1):
      ipv4: route: don't blackhole in-use routes when retiring fnhe routes

Chengfeng Ye (2):
      ipvs: Defer application parent freeing until after RCU readers
      ipvs: fix protocol data lifetime during namespace teardown

Chenguang Zhao (1):
      i40e: xsk: fix multi-buffer XDP_PASS skb construction

Chris Mason (2):
      net: skbuff: uncharge trimmed zerocopy frags on error
      tcp: Drop any segments if DEFER_CONNECT is set.

Chuck Lever (3):
      tls: Consume empty data records in tls_sw_splice_read()
      selftests: tls: Skip the zero_len tests when TLS is unavailable
      selftests: tls: Extend coverage for zero-length records

Cosmin Ratiu (9):
      net/mlx5e: Release IPsec root table reference on RX setup failure
      net/mlx5e: Serialize ipsec encap reservations with eswitch operations
      net/mlx5e: Take HCA devcom lock before esw->mode_lock
      net/mlx5e: Fix E-Switch races in uplink unbind
      net/mlx5e: Fix ipsec core device access during profile changes
      net/mlx5e: Block E-Switch mode changes during IPsec policy creation
      net/mlx5e: Block E-Switch mode changes during IPsec state creation
      net/mlx5e: Serialize TC and IPsec offload exclusion counters
      net/mlx5e: IPsec, don't match upper proto selectors in crypto offload TX

Daniel Machon (1):
      MAINTAINERS: Add myself as maintainer of the lan966x driver

Daniël Trujillo (1):
      ipv4: fib_trie: prevent speculative out-of-bounds child access

David Carlier (1):
      wifi: mac80211: fix unlocked STA statistics fallback

David Yang (4):
      net: dsa: motorcomm: Reread port flags on bridge joining
      net: dsa: motorcomm: Fix extack message on unsupported TC actions
      net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
      net: dsa: motorcomm: Delete the ACL rule of the port being unbound

Davidlohr Bueso (1):
      mctp: accept MSG_CMSG_COMPAT in recvmsg

Debarghya Kundu (1):
      gve: Fix backward stats when interface goes down or configuration is adjusted

Edward Cree (1):
      MAINTAINERS: remove and replace myself as sfc maintainer

Eric Dumazet (17):
      tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
      calipso: do not charge request socket options to the listener
      tcp: rate limit receive queue collapsing
      net: gro: do not undo remote checksum offload on merged packets
      net: gro: invalidate frag0 after a pull
      net: wait for in-flight device unregistrations before netns dismantle
      inet: frags: bound the wmem charge of the socket completing a reassembly
      bonding: fix slave_cnt leak on XDP enslave failure
      fou: gue: check IP version of held packets for direct IP encapsulation
      tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
      udp: do not use a cross-family sk_rx_dst in early demux
      net: gro: compare skb->protocol in gro_list_prepare()
      net: virtio: fix UDP tunnel GSO header of VLAN tagged packets
      tun: clear stale skb->protocol of NAPI frags skbs
      net: virtio: validate outer protocol of UDP tunnel GSO packets
      nsh: limit recursion in nsh_gso_segment()
      selftests: net: add a test for NSH GSO

Erni Sri Satya Vennela (1):
      hv_netvsc: Stop PPI parsing on invalid metadata

Fernando Fernandez Mancera (2):
      netfilter: nft_reject: prevent unbounded recursion in output hooks
      netfilter: x_tables: check target name before accessing verdict

Filippo Falezza (1):
      wifi: ath10k: Stop unanswered temperature reads

Florian Westphal (1):
      netfilter: nat: zero newrange before filling it in

Gal Pressman (1):
      net/mlx5: Bridge, fix bogus MDB offload errors

Hamza Mahfooz (1):
      net: mana: report RX checksum offload for IPv6

Hangbin Liu (1):
      mailmap: add entries for Hangbin Liu

Heyang Tan (1):
      wifi: nxpwifi: validate monitor RX extra-header length

Hyunwoo Kim (2):
      tcp: do not coalesce segments after FIN
      tcp: fix request_sock use-after-free during Fast Open accept()

Iustin Stolniceanu (1):
      net: phy: c45: select BASE-T1 type for the forced speed

Ivan Vecera (3):
      dpll: notify about a reference sync pair only if it was added
      ice: dpll: serialize changes of the SyncE CGU registers
      ice: dpll: set the SyncE divider only for the port driving the output

Jakub Kicinski (20):
      Merge tag 'nf-26-11-05' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'xsk-zc-mbuf-fixes'
      Merge patch series "net: gro: fix frag0 and remcsum handling"
      Merge patch series "ipv6: ignore link state in gateway check"
      Merge branch 'net-sched-fix-short-skb-metadata-and-namespace-boundaries'
      Merge branch 'fbnic-fix-fw-crash-restore-stop-path-and-mailbox-teardown-bugs'
      Merge branch 'sctp-fix-i-forward-tsn-handling-with-user-message-interleaving'
      Merge branch 'net-mlx5e-fix-offload-lifetime-and-exclusion-bugs'
      Merge tag 'for-net-2026-11-09' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'tcp-small-fixes-for-defer_connect'
      Merge tag 'wireless-2026-11-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'gve-fixes-for-issues-discovered-via-net-selftests-and-sashiko'
      Merge branch 'net-psp-preserve-skb_ext_psp-across-packet-scrubbing'
      Merge branch 'ice-dpll-fix-updates-of-the-synce-cgu-registers-on-e825'
      Merge branch 'net-dsa-motorcomm-acl-fixup'
      Merge branch 'net-virtio-validate-outer-protocol-of-udp-tunnel-gso-packets'
      tls: Break the connection after a burst of empty data records
      selftests: tls: Cover the cap on consecutive empty records
      Merge branch 'net-tls-break-the-connection-after-a-burst-of-empty-data-records'
      Merge branch 'nsh-limit-recursion-in-nsh_gso_segment'

Jamal Hadi Salim (4):
      net/sched: act_ife: encode configured zero metadata values
      net/sched: act_ife: require a full Ethernet header on egress
      net/sched: sch_teql: reject qdiscs from another network namespace
      selftests: tc-testing: teql: cover each attach rejection on its own

James Clark (1):
      net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2 ioctl

Jann Horn (1):
      cipso: stop modifying live ip_options_rcu

Jean-Paul Sergent (1):
      net: dst_metadata: fix memcmp overread in skb_metadata_dst_cmp

Jens Axboe (1):
      net: leave O_NONBLOCK to the sendmsg and recvmsg syscalls

Jerome Mohm (1):
      vsock/virtio: clear vqs[] to avoid a UAF on a failed PM restore

Jesper L. Nielsen (1):
      net: ethernet: ti: am65-cpts: keep port and direction when matching PTPv1 TX timestamps

Jiabin Deng (1):
      net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported

Jiahao Xu (1):
      net: usb: cdc_ncm: don't underflow the NDP room check

Jiayuan Chen (1):
      net: raw: fix ICMP unreachable sent when receive queue is full

Joas Antonio dos Santos (3):
      netfilter: nf_conntrack_sip: fix OOB read in ct_sip_parse_transport()
      openvswitch: advance by the real header length in get_ipv6_ext_hdrs()
      gtp: free the skb after handling an echo response

Johannes Berg (7):
      wifi: mac80211: mesh: don't linearize SKBs unnecessarily
      Merge tag 'ath-current-20261102' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: fix use-after-free on TTLM disconnect
      wifi: nl80211: fix ERR_PTR use on wdev disappearance
      Merge tag 'rtw-2026-11-05' of https://github.com/pkshih/rtw
      Merge tag 'mm81x-current-2026-11-05' of https://github.com/MorseMicro/linux-wireless
      Merge tag 'nxpwifi-fixes-2026-11-03' of https://github.com/nxp-upstream/nxpwifi-next

Jun Yang (1):
      net: bridge: use one headroom snapshot for ND replies

Junyoung Jang (1):
      igmp: use the joined device when leaving a multicast group

Jérémy Jean (1):
      tcp: fix authentication bypass via unsupported TCP auth options

Kalpesh Solanki (1):
      tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK

Kang Yang (1):
      wifi: ath12k: set MSDU payload correctly

Kuniyuki Iwashima (6):
      af_unix: Convert unsigned long to u64 for GC.
      af_unix: Remove gc_in_progress check in unix_peek_fpl().
      net: Fix memory_allocated leak in __sk_mem_raise_allocated().
      tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().
      selftest: packetdrill: Add test for DEFER_CONNECT.
      tcp: Pass req->rsk_listener to inet_csk_reqsk_queue_drop() in tcp_check_req().

Kyle Pepper (1):
      Bluetooth: reject invalid LE supervision timeout relationships

Kyle Zeng (11):
      macsec: reject frames that decapsulate into runt Ethernet frames
      ipv4: keep XFRM headers out of corked skb lengths
      net: skbuff: preserve fclone lifetime when freeing stolen heads
      net: protect negative destination advice with RCU
      net: require a full socket in sock_confirm_neigh()
      ipvlan: make outbound skb headers writable
      net: gro: avoid parsing headers from shared fragments
      mptcp: reject DATA_ACKs against a reversed send interval
      udp: check frag_list IP family before using skb_segment_list()
      net/rds: Do not unpin a page after a failed atomic pin
      sctp: avoid requeueing pending control chunks

Lachlan Hodges (1):
      wifi: mm81x: report non-1MHz frames on the 1MHz control freq

Laveesh Bansal (1):
      netfilter: bridge: use DEBUG_NET_WARN_ON_ONCE in nf_ct_bridge_refrag()

Li RongQing (1):
      team: fix promisc/allmulti leak in team_port_add error path

Lorenzo Bianconi (1):
      wifi: ath12k: fix decap of MSDUs spanning multiple RX buffers

Loïc Kassel (1):
      wifi: mac80211_hwsim: use CLOCK_BOOTTIME for the beacon timer

Luiz Augusto von Dentz (1):
      Bluetooth: Fix not updating of hdev->commands[] after reset

Luka Gejak (2):
      wifi: rtw88: move the bmc high queue decision to tx.c
      wifi: rtw88: sdio: limit the high queue to DTIM delivery

Maciej Fijalkowski (8):
      xsk: fix list corruption in xsk_buff_add_frag()
      i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
      ice: xsk: fix leaking Rx buffers in multi-buffer path
      ice: xsk: do not free in-flight frags on XDP_TX completion
      libeth: xsk: do not free in-flight frags on XDP_TX completion
      xsk: do not clear frags flag when acquiring a buffer
      ice: xsk: free stashed Rx frame when cleaning the ring
      idpf: free stashed XSk Rx frame when releasing the queue

Mahanta Jambigi (2):
      net/smc: fix lgr/lnk lifetime vs diag reader race
      net/smc: fix link group ownership in handshake abort

Mark Bloch (1):
      net/mlx5: Lag, free steering resources on LAG destroy failure

Mehmet Fide (3):
      wifi: ath9k_htc: do not start ANI before the first channel is set
      wifi: ath9k_htc: start ANI when an AP interface begins to beacon
      wifi: mac80211: abort chanswitch when leaving an IBSS

Miaoqing Pan (1):
      wifi: ath12k: Fix failure to create ath12k_dp_peer on MLO reconnect

Michael Buesch (1):
      wireless: Remove me as ssb maintainer

Michail Andreas Michalopoulos (1):
      netfilter: flowtable: extend ct timeout of offloaded GRE flows

Ofri Zangi (1):
      tls: fix async encryption race on weakly ordered architectures

Omar Ramadan (1):
      amt: tear down every amt device on an unregistering lower

Or Har-Toov (1):
      net/mlx5e: Add missing Ethernet multicast octets to vport_rx_bytes sum

Orgad Shaneh (1):
      net: mana: fix XDP_REDIRECT of pre-allocated RX buffers

P Praneesh (1):
      wifi: ath12k: fix IRQ disable imbalance in AHB ext interrupt handler

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix memleak when rule deletion fails with hardware offload

Paolo Abeni (2):
      Merge branch 'xsk-fix-multi-buffer-tx-software-checksum'
      Merge branch 'net-fix-mac_len-of-skbs-copied-by-generic-xdp'

Pin-yen Lin (3):
      gve: Fix race between stats query and queue reconfig
      gve: Block invalid ring sizes when device options are 0
      gve: Fix link flap after ethtool ops

Prathamesh Deshpande (1):
      net/mlx5e: IPoIB, Fix QPN lookup race

Rishikesh Jethwani (2):
      tls: only install push_pending_record for a TX context
      selftests: net: add TLS 1.2 hardware offload tests

Rongzheng Wang (2):
      xsk: defer software checksum until the skb is complete
      selftests/bpf: cover AF_XDP multi-buffer TX software checksum

Shay Drory (1):
      net/mlx5: E-switch, Restore host PF enable for ECPF that isn't E-switch manager

Stanislavs Nilovs (1):
      Bluetooth: qca: Disable SoC debug logging for WCN3950

Stefano Munari (1):
      net: usb: lan78xx: resume phylink on non-reset USB resume

Steffen Klassert (1):
      MAINTAINERS: Add the new IPsec list and patchwork instance

Tapio Reijonen (1):
      net: dsa: microchip: initialize the IRQ access mutex

Thomas Fourier (1):
      net/mlx5e: TC, Fix double free of branch in failure

Tianyi Gao (2):
      net: fix mac_len of skbs copied by generic XDP
      selftests: drv-net: ping: test generic XDP redirect to cpumap

Tim Budding (4):
      sctp: abort unordered partial delivery when its message is skipped
      sctp: report the partially delivered MID in PARTIAL_DELIVERY_ABORTED
      sctp: fix I-FORWARD-TSN handling of fragments on other streams
      selftests: net: add SCTP I-FORWARD-TSN tests with message interleaving

Tristan Madani (1):
      wifi: nxpwifi: validate scan response TLV sizes before indexed access

Umang Pokhriyal (1):
      tun: delete the flow entries of the moved queue on detach

Uri Dar (1):
      net/mlx5: Lag, Return error when enabling MPESW without LAG support

Vishal Gupta (1):
      wifi: nxpwifi: synchronize scan cancellation state

Wahid Khan (1):
      wifi: cfg80211: don't truncate the merged MBSSID profile length

Wei Wang (2):
      net: Make PSP skb extension survive packet scrubbing
      selftests/net: psp: test bidirectional data transfer

Weiming Shi (1):
      sctp: reset stored flag for each association

Wenbo Sun (2):
      af_unix: Inherit SO_INQ in unix_stream_connect()
      amt: use ipv6_hdr() in amt_mldv1_leave_handler()

Willem de Bruijn (1):
      docs: netdev: fix iproute2 process documentation

Xia Yan (2):
      ipv6: fix cached route reuse for control messages
      selftests: net: exercise SO_MARK on connected sockets

Xingyuan Mo (1):
      netfilter: nft_set_rbtree: check catchall_sync return before queue_done

Xuanqiang Luo (1):
      net/mlx5e: kTLS, Fix missing error unwind when enabling RX offload

Yaroslav Dudkov (2):
      ipv6: ignore link state in gateway check
      selftests: fib_tests: Add carrier gateway test

Yehyeong Lee (3):
      wifi: nxpwifi: guard the 11ax response handlers against a detached command buffer
      wifi: nxpwifi: read the 11AX_CFG extension ID at the right offset
      wifi: nxpwifi: bound the TLV lengths in the 11AX_CFG response

Yingjie Wang (2):
      tcp: free saved_syn after an RCU grace period
      ipv6: reject routes without an inet6_dev

YuanZhe Liu (3):
      Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
      Bluetooth: btusb: fix use-after-free in force_poll_sync
      net: usb: lan78xx: let unregister_netdev() stop phylink

Yuho Choi (1):
      ptp: kvm: x86: Leak clock_pair page if changing its encryption fails

Zhao Gongyi (1):
      net: netns: fix INT_MAX nsid cleanup

Zhao Li (15):
      Bluetooth: L2CAP: Only accept LE responses to outstanding requests
      Bluetooth: L2CAP: Clear request identifiers on incoming LE connections
      Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel
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

Zihan Xi (1):
      netfilter: nf_dup: preserve guard across NFQUEUE reinjection

Zijun Hu (1):
      Bluetooth: hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path

Zixuan Chai (1):
      seg6: validate state in netfilter continuations

 .mailmap                                           |   3 +
 Documentation/bpf/bpf_devel_QA.rst                 |  30 +-
 .../networking/net_cachelines/tcp_sock.rst         |   1 +
 Documentation/process/maintainer-netdev.rst        |  35 +
 MAINTAINERS                                        |  12 +-
 drivers/bcma/driver_chipcommon.c                   |   2 +-
 drivers/bcma/driver_chipcommon_pmu.c               |   2 +-
 drivers/bcma/driver_pci.c                          |   2 +-
 drivers/bcma/driver_pci_host.c                     |   2 +-
 drivers/bluetooth/btqca.c                          |   1 +
 drivers/bluetooth/btusb_main.c                     |  10 +-
 drivers/bluetooth/hci_qca.c                        |   5 +
 drivers/dpll/dpll_core.c                           |   3 +-
 drivers/firmware/broadcom/bcm47xx_sprom.c          |   2 +-
 drivers/net/amt.c                                  |  61 +-
 drivers/net/bonding/bond_main.c                    |   9 +-
 drivers/net/dsa/microchip/ksz_common.c             |   1 +
 drivers/net/dsa/motorcomm/chip.c                   |   8 +
 drivers/net/dsa/motorcomm/tc.c                     |  88 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  15 +-
 drivers/net/ethernet/google/gve/gve.h              |  12 +
 drivers/net/ethernet/google/gve/gve_adminq.c       |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c         | 243 ++++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  37 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   4 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  11 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |   4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   8 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c         |   8 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  19 +-
 drivers/net/ethernet/intel/idpf/xsk.c              |   5 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   5 -
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   5 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  99 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  90 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  19 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  21 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |  15 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  48 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  15 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  88 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h  |   2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |  26 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 248 ++++--
 .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |   2 +
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    |  38 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   8 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  16 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  43 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  10 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   9 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  18 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   2 +
 drivers/net/ethernet/ti/am65-cpts.c                |  31 +-
 drivers/net/gtp.c                                  |  22 +-
 drivers/net/hyperv/rndis_filter.c                  |   6 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   6 +-
 drivers/net/macsec.c                               |  15 +-
 drivers/net/phy/phy-c45.c                          |  46 +-
 drivers/net/team/team_core.c                       |   9 +-
 drivers/net/tun.c                                  |  21 +-
 drivers/net/tun_vnet.h                             |   5 +-
 drivers/net/usb/cdc_ncm.c                          |   4 +-
 drivers/net/usb/lan78xx.c                          |  21 +-
 drivers/net/virtio_net.c                           |   2 +-
 drivers/net/wireless/ath/ath10k/core.c             |   1 +
 drivers/net/wireless/ath/ath10k/thermal.c          |   9 +-
 drivers/net/wireless/ath/ath10k/thermal.h          |   2 +
 drivers/net/wireless/ath/ath12k/ahb.c              |  11 +-
 drivers/net/wireless/ath/ath12k/core.c             |   3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   8 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  17 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  32 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  30 +-
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
 drivers/net/wireless/morsemicro/mm81x/mac.c        |  20 +-
 drivers/net/wireless/nxp/nxpwifi/11ax.c            |  67 +-
 drivers/net/wireless/nxp/nxpwifi/scan.c            |  52 +-
 drivers/net/wireless/nxp/nxpwifi/util.c            |   4 +
 drivers/net/wireless/realtek/rtw88/main.c          |   3 +
 drivers/net/wireless/realtek/rtw88/main.h          |   5 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |   3 +
 drivers/net/wireless/realtek/rtw88/tx.c            |  59 ++
 drivers/net/wireless/realtek/rtw88/tx.h            |   4 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  64 +-
 drivers/net/wireless/realtek/rtw88/usb.h           |   5 -
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |   4 +-
 drivers/ptp/ptp_kvm_x86.c                          |   7 +-
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
 include/linux/mlx5/driver.h                        |   8 +-
 include/linux/netdevice_xmit.h                     |   4 +-
 include/linux/ssb/ssb_driver_chipcommon.h          |   2 +-
 include/linux/tcp.h                                |   7 +-
 include/linux/virtio_net.h                         | 181 +++-
 include/net/bluetooth/hci_core.h                   |  13 +-
 include/net/bluetooth/l2cap.h                      |   1 +
 include/net/cipso_ipv4.h                           |  11 +-
 include/net/dst_metadata.h                         |   2 +
 include/net/gro.h                                  |  18 +-
 include/net/gso.h                                  |   2 +-
 include/net/inet_common.h                          |   2 +-
 include/net/libeth/xsk.h                           |  10 +-
 include/net/mac80211.h                             |   3 +-
 include/net/mana/mana.h                            |   5 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netfilter/nf_dup_netdev.h              |  35 -
 include/net/netfilter/nf_queue.h                   |   1 +
 include/net/netfilter/nf_recursion.h               |  42 +
 include/net/netlabel.h                             |  11 +-
 include/net/request_sock.h                         |   3 +-
 include/net/sock.h                                 |  24 +-
 include/net/tcp.h                                  |   9 +
 include/net/tcp_ao.h                               |   3 +-
 include/net/tls.h                                  |   1 +
 include/net/xdp_sock_drv.h                         |  11 +-
 include/uapi/linux/mdio.h                          |  13 +-
 include/uapi/linux/nl80211.h                       |   2 +-
 net/bluetooth/hci_conn.c                           |  18 +-
 net/bluetooth/hci_event.c                          |   4 +-
 net/bluetooth/l2cap_core.c                         |  87 +-
 net/bluetooth/l2cap_sock.c                         |   3 +-
 net/bridge/br_arp_nd_proxy.c                       |   6 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |   2 +-
 net/core/dev.c                                     |  47 ++
 net/core/filter.c                                  |   5 +-
 net/core/gro.c                                     |  31 +-
 net/core/net_namespace.c                           |  17 +-
 net/core/skbuff.c                                  |  46 +-
 net/core/sock.c                                    |   4 +-
 net/core/sock_reuseport.c                          |   9 +
 net/ipv4/af_inet.c                                 |  10 +-
 net/ipv4/cipso_ipv4.c                              |  16 +-
 net/ipv4/esp4_offload.c                            |   1 +
 net/ipv4/fib_trie.c                                |  14 +-
 net/ipv4/fou_core.c                                |  12 +
 net/ipv4/igmp.c                                    |   2 +
 net/ipv4/inet_connection_sock.c                    |   8 +-
 net/ipv4/inet_fragment.c                           |  61 +-
 net/ipv4/ip_fragment.c                             |  13 +-
 net/ipv4/ip_output.c                               |   8 +-
 net/ipv4/netfilter/arp_tables.c                    |   5 +-
 net/ipv4/netfilter/ip_tables.c                     |   5 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |  12 +
 net/ipv4/raw.c                                     |  15 +-
 net/ipv4/route.c                                   |  23 +-
 net/ipv4/tcp.c                                     |  16 +-
 net/ipv4/tcp_input.c                               |  70 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_metrics.c                             |   3 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/udp.c                                     |   5 +-
 net/ipv4/udp_offload.c                             |  10 +-
 net/ipv4/udp_tunnel_core.c                         |   6 +-
 net/ipv6/calipso.c                                 |  12 +-
 net/ipv6/esp6_offload.c                            |   1 +
 net/ipv6/exthdrs.c                                 |   5 +-
 net/ipv6/exthdrs_core.c                            |   7 +-
 net/ipv6/icmp.c                                    |   7 +-
 net/ipv6/ip6_output.c                              |  13 +-
 net/ipv6/mip6.c                                    |   9 +-
 net/ipv6/netfilter/ip6_tables.c                    |   5 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |  13 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |  13 +
 net/ipv6/raw.c                                     |  15 +-
 net/ipv6/reassembly.c                              |  13 +-
 net/ipv6/route.c                                   |  10 +-
 net/ipv6/seg6_iptunnel.c                           |  46 +-
 net/ipv6/seg6_local.c                              |  55 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/udp.c                                     |   5 +-
 net/mac80211/airtime.c                             |   2 +
 net/mac80211/ap.c                                  |   3 +-
 net/mac80211/driver-ops.c                          |  14 +-
 net/mac80211/ibss.c                                |  27 +-
 net/mac80211/ieee80211_i.h                         |   3 +
 net/mac80211/iface.c                               |   7 +-
 net/mac80211/link.c                                |  13 +-
 net/mac80211/mlme.c                                |  35 +-
 net/mac80211/ocb.c                                 |  23 +-
 net/mac80211/rx.c                                  | 102 ++-
 net/mac80211/scan.c                                |   5 +-
 net/mac80211/tx.c                                  |   6 +
 net/mctp/af_mctp.c                                 |   2 +-
 net/mptcp/options.c                                |  12 +-
 net/mptcp/protocol.c                               |   5 +-
 net/netfilter/ipvs/ip_vs_app.c                     |   2 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  12 +-
 net/netfilter/nf_conntrack_sip.c                   |   4 +-
 net/netfilter/nf_dup_netdev.c                      |   1 +
 net/netfilter/nf_flow_table_core.c                 |   1 +
 net/netfilter/nf_nat_masquerade.c                  |   4 +-
 net/netfilter/nf_queue.c                           |   1 +
 net/netfilter/nf_tables_api.c                      |  21 +-
 net/netfilter/nf_tables_offload.c                  |   3 +
 net/netfilter/nfnetlink_queue.c                    |  17 +-
 net/netfilter/nft_fwd_netdev.c                     |   1 +
 net/netfilter/nft_set_rbtree.c                     |   3 +-
 net/netfilter/xt_NETMAP.c                          |   4 +-
 net/netfilter/xt_recent.c                          |   7 +-
 net/netlabel/netlabel_kapi.c                       |  24 +-
 net/netlink/af_netlink.c                           |   3 +-
 net/nsh/nsh.c                                      |   7 +
 net/openvswitch/flow.c                             |  19 +-
 net/rds/rdma.c                                     |   5 +-
 net/sched/act_ife.c                                |  13 +-
 net/sched/sch_teql.c                               |   9 +-
 net/sctp/sm_make_chunk.c                           |  17 +-
 net/sctp/sm_statefuns.c                            |  16 +-
 net/sctp/socket.c                                  |   2 +-
 net/sctp/stream.c                                  |   2 +
 net/sctp/stream_interleave.c                       |  38 +-
 net/smc/af_smc.c                                   |  21 +-
 net/smc/smc.h                                      |   1 +
 net/smc/smc_close.c                                |  14 +
 net/smc/smc_core.c                                 |  86 +-
 net/smc/smc_core.h                                 |   6 +-
 net/smc/smc_diag.c                                 |  12 +-
 net/socket.c                                       |  11 +-
 net/tls/tls_sw.c                                   |  93 ++-
 net/unix/af_unix.c                                 |   1 +
 net/unix/garbage.c                                 |  31 +-
 net/vmw_vsock/hyperv_transport.c                   |   3 +
 net/vmw_vsock/virtio_transport.c                   |  16 +-
 net/wireless/nl80211.c                             |   6 +-
 net/wireless/scan.c                                |   3 +-
 net/wireless/util.c                                |   6 +-
 net/xdp/xsk.c                                      |  24 +-
 net/xdp/xsk_buff_pool.c                            |   2 +-
 security/selinux/netlabel.c                        |   5 +-
 security/smack/smack_lsm.c                         |  14 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 141 ++--
 tools/testing/selftests/drivers/net/hw/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   2 +
 tools/testing/selftests/drivers/net/hw/config      |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c      | 908 +++++++++++++++++++++
 .../selftests/drivers/net/hw/tls_hw_offload.py     | 321 ++++++++
 tools/testing/selftests/drivers/net/ping.py        |  27 +-
 tools/testing/selftests/drivers/net/psp.py         |  22 +
 tools/testing/selftests/net/.gitignore             |   2 +
 tools/testing/selftests/net/Makefile               |   4 +
 tools/testing/selftests/net/cmsg_sender.c          |  21 +-
 tools/testing/selftests/net/cmsg_so_mark.sh        |  22 +
 tools/testing/selftests/net/config                 |   1 +
 tools/testing/selftests/net/fib_tests.sh           |  40 +
 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c   |  19 +
 tools/testing/selftests/net/nsh_gso.c              | 126 +++
 tools/testing/selftests/net/nsh_gso.sh             |  71 ++
 .../tcp_fastopen_client_defer-connect.pkt          |  61 ++
 tools/testing/selftests/net/sctp_ifwdtsn.c         | 699 ++++++++++++++++
 tools/testing/selftests/net/sctp_ifwdtsn.sh        | 233 ++++++
 tools/testing/selftests/net/tls.c                  | 353 +++++++-
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json |  36 +-
 319 files changed, 6067 insertions(+), 1448 deletions(-)
 create mode 100644 include/net/netfilter/nf_recursion.h
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c
 create mode 100644 tools/testing/selftests/net/nsh_gso.c
 create mode 100755 tools/testing/selftests/net/nsh_gso.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt
 create mode 100644 tools/testing/selftests/net/sctp_ifwdtsn.c
 create mode 100755 tools/testing/selftests/net/sctp_ifwdtsn.sh
