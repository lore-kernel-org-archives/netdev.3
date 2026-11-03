Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748418;
	b=FwJ0WuakxQJ0v04l/ejKuRta02l8Tyh1NgZKHo83XYPjObTneyV+x/zMt9v3YvPmv33u
	 xQiuhkYM3u6/9o4LbgJEzlF2Lb3JHNOVzbZ6fIdCRMeKlu0D+GD+/TUVKDn27B2OrHt0G
	 +HKQCV+hOXeYeCoS4e7Q8yF25XmuBrKm8atqPaUGfa5CnzhEfUTv5wwRfmxTLwsiN8SHB
	 WTlhVO1RscNXpgUh4Zsqcb8Dry8AQ2+tuvIOSRraPnQMGIcnT4VsnYhHZWBPyDNEzJiTP
	 N+VLeqggToLTd/ALBv4Ug/2ZvQGXgB5ei1lSVk9+VPuTR50VygbG2Mp4s7eDq/uq2Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748418;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:References:X-Mailer;
	bh=zOlHjC+a0mdWzEXYAR6t54fyvhTX8GPmYj9cMafv0q8=;
	b=quFrSEftpbTD6V8N6XleOMfVbALhMkcpVDcLSwPmRQcm7zgv8JNpQ4b/kTQ4dE/1pWqp
	 EJPDh3ZNzEnMsNqU5oaefAPJa2hrX/CajXh127Ngl1D1Kv6+0dFBIvjJ7tmB6PsooJdf3
	 bqMhtjPktCdnoABvMUs/6A5I8gnDcRIY0H549TToYA10hIOjKLlVDozIP1YnKn25ITFPl
	 lZK7KeVnVxeBOkmF6wy7J6Y89ekmoYynbgs6tvhn2WN6Q8dqzIFlCHAw4HeRmjYWuewDk
	 SYHvG8lV8MHcTXIDX2qfwIzJu0N0sF6zTagCcNu5w1y3F8CjlU/YWAWcJaIkbKeKQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ANJcshWV;
	arc=none smtp.remote-ip=66.163.185.32
Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD78606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD78606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ANJcshWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748416; bh=zOlHjC+a0mdWzEXYAR6t54fyvhTX8GPmYj9cMafv0q8=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=ANJcshWVEbqZsZcM3Jo8rroUrPgA741rr45zg8K1WCNQKuZ4mfSS7agXLuRtejQIAE56dJSI99srvqfhbOAvy7VRTQlw9lcGcRWzHly0HgVDHgEA5IELLPrCNXlJ46UB9acJ4qdGCsy0Cs0XUN5qJcXW9BOcHTS1yuwbTiT/rl2atFyYGZlnf7FWmPJ4nCc/F7sDgHGcQS+X3XBJevMucfKs4UKTlEWdJpsZNqWNH6qI1LJj/6UckK0R1mTJCA1Vf517EZraheK/dF5WRxcQLMwlgdK6yBnudLd/uZBkGz096ZPbrdhOYrg1bIWEeibtDHJ7BrLKyLG9Yiu5DEoOHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748416; bh=WxYPzQbQEnoJ/GAEucsaRPV9ll1CxcNG+PJT0kos4aA=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=a3NeXiRNKXtfm+1w3nQZgda2AVUG1p2DxVLHml8Uzn3jidnvRctl6/VHUigXz1kSyeRSTaznt6k5ZzoUvcn5wIuGfgraTSSzxDRcyYwCx4IxFs5FlA3eruAgEV51Xa3qFqDlgBoBMHzdVZODsTrtt+w3r/QQEuh/IzlD5jwBMi5tu3LY11slua9IFOXVxPWF6BXldKUbqwTt+s5ZtMW9p/Z93z2Io3s6w4Qn0b3tol69SzZVJjUlLhyCbrIC3JbIUiZjvWfaCaFaq7aAD97WXGYjWZpmbg3B+n+LSlqXZZga9NgyrIMYzyNZK0EGQ5lrBou+f5fnbEbSuq7FOXFUkw==
X-YMail-OSG: yi2n.FMVM1nPObA4nQ6tbplN6eGyywM4mntyx0PqaRMhvoZkUFISCCmyrip3r05
 6P0h8dIe7Hm36XMwGDct45Gk.59axix4LYci.tLje0gYlEn_Ke3_bLejGtI1iDv.mIAGbRXSMlqK
 cSYIG5ogTRgaPb1nZiibUqxV1TU1oAy_o5zCYt9qLCDJJjULBPrTuqnii0L_3vV5s5X9y3pTDaZz
 gCemJG.u0NMkIpYU4v5lIvNT5ahYY1_jLcIZHZJYNdKKnkbc3w.Sn7ntjAnrFJZKI9YC0ov93SCz
 nQtof81.I7ItSqbx6ysHYPWLIy0PnWrXiG.umCmXeBZvcEKRKsbAYoJu5pwg.hPS6N.0mUSkIgKq
 zY4V3Avl5ya0eu0q86mteI0c8gAmQq2EVofLmnyBIIaHebrOSs7Xfo8hYDuvVZfNaKXiBT2vdRAA
 FRr_4kCiDPa13KiSjKzfnztkNbNJx7Ojy7H67ZseiuJ2CgTz64jpLBUSU5GKZu8sEM6ZzIZEyDyB
 yWQao.SZzICAU8MREr1Gm3C7Cp.IHH_BfrYeu_OjM4WHJQq1FZBQwnK6zsmJoCkutJoH3J2g_PA.
 Tx0P9cTVXCGKAObS3fWzJ8FHhuChZWZkYloN1Q5bBqR4LJu13m0KVrCWT.iYLxcelz4qSW0ECvaN
 RdFa7UsMSmqWYpQWHU61AtUi6CWmQUObcyN6b6cmHQCADkKVNAixogO3R3hl0jS5uoVG8e75BLCV
 DYFjL_PdDT8YNtf0HHHdsP6C4G8uvd4ZFlmfupLzJqopRE476ZF0B3GsrJWxvBTCVRoDQQcGp_Ht
 qqoVFkwVRzLqr9of2c_gcyI29.zukydPgQb4L4A0hGVRUmjaUg7gGUULKOj3OAmK9C7kYeNKB54J
 Oab1IIMubbFUKlOQVuLuAjQ0AT8hYFOSadlusMAOjMbs6zUXrcS2tNFO2FdpIJ6IbBsMOUibxVsT
 xJvTcuUypjFCMxnXPRTPhTWBQHPfrOUEFwL.qCh.de.AnPxVNEe7x24PfBp9LBpRqHY0nQ53PHZS
 M_51wQc1zwboODkfElmxojTYdGXGekSOzkeopyXuaXfCIczyjkeSil2fpvtWTFMIL8Y1QYq9BKnU
 WF7LZvqfjyaLYyZrm8KQXYqylplI08GBNglXUYxVvYJhy8rvikWeeZ0ZE_Ivutwfix0LmJxCFWJL
 bw4IBc.Wgm09l3KbiuaootyZyhue_x_.UTZCwUP.f75bOhn6DPXhBrZp_png7USyYFSdOZzFy87U
 iJSCelE5B9Prvt8mkqcfdxuE45EqH.5RCpJtT23Nwl1lxLZHl3s59AihN7Wi.zkBc4M7bcSmvRQe
 qj.yvCmIoQKWsFV73B0wCO5.2kisIsR0z6OarXJwrrF.L0ZpJ73_0gSkzSrUd_8oZ9KJgF5c.Whb
 xJZ7NKBMWX5dT1k9yYxSjsQJfXknB.LAHYkw6mVBS9vMWWQs85rAAJav4WlUBsjEWHPBRqoPAcnD
 3G.V3HsyM.LDp54Tr3T6N9vZFbJuuNZEH0RET4jN2WEysMjce1yh83lKpYftv4pSDQeZc9CyhCwZ
 rJeQAtgZmAunSfIOdvH0HLgazlz_kSCxHZFuh0tdZdkvi5SkCPmjo4IZR33qxOTUyt1.M3Z82tGl
 odvNh8iCKstDa7dBvtSK3jk6cHLPFN.BnbN7_8qhFIeHppPIUXXfbxrQdCKlrCcHHESd3AGm76ed
 r8fCszPj1pHd5tTn9__pCDPxphcdHV8BUkEHA2QtXkTOOBMlXOXb6j4gmXSLS7w2bWrAA31RfbBW
 49fE9_IXIT6oj_9A1KSu5DLX1b3Cuorzd4Sshj72b.wovbaUvUP9okXcSkTPv.ihK1_geIm3926U
 QljKGPgSU1oXBz8gM0XSkqaB39mOTsjwPr7ronBZh.LccIkw0LhMyDLxdK_Y2grioAVISPi4Wu1K
 Sl97Faa38_LnBlZry_HM0QfVQ967xjSTbkvakMOB_7UhpVJtpPtmauzPwU8p04vCMrRF9rsLjCIj
 H_D1er6bSERCzD6D.X2rIUx2kweB09JFaFuE4FCPB3A.IcVbfDtCl0jBzUkG8WHpc0mEMS3WTb4X
 cGh7j5HxRZL_72mH0v6rzT0r77QJgwRmj_eX35xOOEZGIDpDSIu.ZkhczvKazsPJtF4Ow6gA5rS7
 T_IX3YYBEfOzrlzldAV2fE5SrIfWZOzlYMGhG5pQqbGX3FiNyXZxzpN9hkQGnY9TYjAfh9JsUKgH
 Qj2u_bMxuLkln_fGj84DvOTmMQCul2gsHDvSmL1PWs7KrPE6pxcAJBr6x5EcQ4ua33W14o93DKKe
 qAjqPLlprHmwt5HPDnYuyIny2cL.skLroe8BL3g--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 6c487609-e5c9-4720-972c-26395c2e21ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:26:56 +0000
Received: by hermes--production-ir2-5dd9bf4598-jnk89 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ecba18203d91ecda6c8d744d40d0b8a7;
          Tue, 03 Nov 2026 23:26:54 +0000 (UTC)
Message-ID: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Date: Wed, 4 Nov 2026 00:26:50 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next v8 00/11] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <08611959-c555-46d9-8e7e-20b85d0c4056.ref@yahoo.com>
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN and L2 table layouts, speed/RGMII
configuration and SerDes (SDS13) handling.

Patch 1 documents the chip in the devicetree binding.
Patch 2 adds the chip family infrastructure (no functional change).
Patches 3-4 add port speed and RGMII mode configuration for family D.
Patches 5-6 add VLAN 4k table access and raw-VID PVID handling.
Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.
Patch 9 refactors the family C L2 MAC handling by introducing shared pack/unpack
helpers and splitting the serializers (no functional change).
Patch 10 makes the L2 (FDB/MDB) table access work on family D, which has
a 5-word entry layout, narrower table access fields and no EFID.
Patch 11 adds the RTL8367S-VB chip table entry. It comes last, so that
no intermediate commit exposes a family D chip with incomplete
handling and the series stays bisectable.

Family C's functional behaviour is unchanged. Changes in a shared path
include a mutex serializing SerDes register access, as well as
.pcs_disable in pcs_ops and .conduit_state_change in dsa_switch_ops
(both bail out immediately on family C). The L2 table access and FDB/MDB
code is shared too; the family D handling is selected at runtime with
rtl8365mb_is_d() (patch 10). The port count is capped at 8 for family D
only (patch 11). On family D, FDB/MDB offload is available, but
per-bridge FDB isolation is not (no EFID); bridges are isolated by the
port isolation masks only (patch 10).

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested. FDB/MDB offload on family D has not been tested on
hardware yet.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v8:
  - 2/11: declare the rtl8365mb_is_d() helper as a global inline function
    in the new header
  - 9/10: split into two patches to improve structure and address reviewer
    comments:
    - 9/11 (new): introduce shared MAC pack/unpack helpers and refactor
      family C serializers without functional changes
    - 10/11: drop the confusing _any() suffixes in favor of clean
      symmetric dispatchers, switch to the global rtl8365mb_is_d() helper,
      and fix the memset size in family D serializers

v7: https://lore.kernel.org/netdev/3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com/
  - 3/10, 6/10: note that the family D path is unreachable until the last
    patch
  - 4/10: program EXT_TXC_DLY, the pin mux and the SerDes 1 disable
    before selecting RGMII; warn when RGMII is disabled because MAC4 owns
    EXT1
  - 8/10: act only on the conduit of the CPU port that carries the
    SerDes; queue the work with schedule_delayed_work() and rename the
    devres action to rtl8365mb_sds_relatch_disable()
  - 9/10: new, make L2/LUT access work on family D (5-word entries,
    narrower table access fields, LUT init, no FDB isolation)
  - 10/10: update the NET_DSA_REALTEK_RTL8365MB help text

v6: https://lore.kernel.org/netdev/5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com/
  - 4/9: do not advertise RGMII for port 7 when MAC4 owns EXT1, instead
    of returning -EBUSY from mac_config(), which phylink ignores
  - 5/9: take IVL_EN from vlan4k->ivl_en and leave SVLAN_CHK_IVL_SVL at
    0, as the vendor API does
  - 7/9: pcs_get_state(): keep phylink's speed and duplex for SGMII and
    never report the link up with an unknown speed
  - 8/9: start the re-latch work when the conduit comes up and stop it
    when it goes down (.conduit_state_change); serialize it against
    pcs_config() with sds_cfg_lock; disable it for good on shutdown and
    unbind

v5: https://lore.kernel.org/netdev/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com/
  - 1/9: fix the subject
  - 4/9: refuse RGMII on EXT1 with -EBUSY when it is owned by MAC4,
    before touching any EXT1 register
  - 5/9: drop the unverified rationale for forcing SVLAN_CHK_IVL_SVL, say
    that the vendor API leaves it at 0, and note that the family D paths
    are not reachable until the last patch
  - 6/9: init prev_accepted_frame to avoid a maybe-uninitialized warning
  - 7/9: comment the write of the whole RX disable field, as in the vendor
    sequence; fix two comments that still credit pcs_link_up() on family D
  - 8/9: cancel the re-latch work from a reboot notifier instead of
    checking the driver data; fix the RESTORE_TRIES comment and do not
    sleep after the last failed restore attempt
  - 9/9: fix the description of the external interface indices. The v4
    changelog said that only HSGMII is exposed; that was wrong, SGMII is
    still exposed

v4: https://lore.kernel.org/netdev/38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com/
  - 1/9: reword the commit message (support is added by the series)
  - 3/9: document the per-port force enable register
  - 5/9: document both forced IVL bits, update stale comments
  - 6/9: clear the family D PVID registers at setup
  - 7/9: do not override the forced SGMII speed in pcs_get_state(),
    update stale comments, note that the patch is preparatory
  - 8/9: remember a failed restore and retry it first; stop the work
    after shutdown (driver data cleared)
  - 9/9: expose HSGMII only on the SerDes port, update the SerDes
    interface comment

v3: https://lore.kernel.org/netdev/e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com/
  - add a dt-bindings patch (1/9): RTL8367S-VB listed under
    realtek,rtl8365mb
  - add chip family infrastructure as its own patch (2/9), no
    functional change
  - squash the family D PVID getter and the PVID set/clear patches
    into one (6/9), so the read and write paths use the same register
    layout at every point of the series
  - add the RTL8367S-VB chip table entry last (9/9), after the family
    D speed, RGMII, VLAN and PCS support, so no intermediate commit
    can reach the chip with incomplete handling (reported by the
    automated review)
  - 6/9: fix the commit message (port p's write lands in port p >> 1)
    and update the stale kernel-doc and file comments
  - 8/9: start the re-latch work only for 2500base-x, cancel it from
    .pcs_disable, from pcs_config() and via a devres action; retry the
    SDS_MISC restore and come back soon if it fails; rewrite the
    commit message to match the code (reported by the automated
    review)
  - 9/9: document family D in the file header comment and in the
    learn limit comment (limit confirmed against the Realtek vendor
    API)

v2: https://lore.kernel.org/netdev/28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com/
  - 2/8: mask r_speed to the width of the FORCE_SPEED field before passing
    it to FIELD_PREP(), so that the family D 2500M value (5) cannot trip
    the compile-time range check; bit 2 still goes to FORCE_SPEED2
    (reported by the automated review).
  - 4/8: the commit message now explains why EXT_TXC_DLY[5:3] is cleared
    for RGMII on EXT1: the vendor RGMII setup does it, and the init jam
    table leaves the field at 2, which would add an extra TX delay on top
    of tx-internal-delay-ps. Add a comment describing the EXT_TXC_DLY
    layout (Andrew Lunn's review).
  - 8/8: document the new struct rtl8365mb members in the kernel-doc
    comment (sds_lock, sds_relatch, sds_relatch_count,
    sds_misc_target_val), which fixes the kernel-doc warnings.
  - 1/8, 3/8, 5/8, 6/8, 7/8: no changes.

v1: https://lore.kernel.org/netdev/84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com/

Mieczyslaw Nalewaj (11):
  dt-bindings: net: dsa: realtek: add RTL8367S-VB
  net: dsa: realtek: rtl8365mb: add chip family infrastructure
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: use raw VID for PVID on family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
  net: dsa: realtek: rtl8365mb: refactor L2 MAC handling
  net: dsa: realtek: rtl8365mb: make L2/LUT access work on family D
  net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

 .../devicetree/bindings/net/dsa/realtek.yaml  |   2 +-
 drivers/net/dsa/realtek/Kconfig               |   3 +-
 drivers/net/dsa/realtek/rtl8365mb.h           |  19 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c        | 273 ++++--
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 870 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c     |  46 +-
 drivers/net/dsa/realtek/rtl8365mb_table.h     |   2 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 366 ++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 9 files changed, 1365 insertions(+), 217 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

