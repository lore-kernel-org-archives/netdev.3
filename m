Received: from sonic305-20.consmr.mail.ne1.yahoo.com (sonic305-20.consmr.mail.ne1.yahoo.com [66.163.185.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD713B14B7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880422; cv=none; b=cjQFOdogDQIb4qt+r4jESWxnJGcB+AYIorkwfxNSv3GkfB6ZyY1SAS7+oQvY07z23rGbSI43CiWqIORtJFFrCUjqBrPmo69Ra1yloRzibNMCU0NAl4+pn9OGgF4qMClihZ+ZXLfRbvfmzMpa/52D82Ktm5V3Zzv5Gj6lCRqYQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880422; c=relaxed/simple;
	bh=LNVUGoX2TtbQ2b1becXONvjKYa53L7alF8Q6jqQxnbY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=PUtYia9RdZ888EkxCR7nyYpMcWFpDAsGu8Mxju6+K8h47Hnod0frK+3DL3HbGRquuEQD1CENuAbl9Uune8fKS9qevyQO0L/C0/WkNJdlPTEA6lSKsHRE7iC8bXsahLs5y0ToAozWRX5BxqH9bRFyfK7VBHJ3E/YNG4JQmiViToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o0FbzmpF; arc=none smtp.client-ip=66.163.185.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o0FbzmpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880414; bh=fSxAcjabgPykV0rUYep0vWoTF3X5tvhCz6tqDQ+xtXE=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=o0FbzmpFr8jLzn9TxXINPHIGvP+I+H0LphcG4XqVZKDOz9xKHdEkL/ElMsehmcttRCUjzJ5gBT9JT5wB3MDyiagJFPEuDjDWKLJfKc8VJQg90tq2X8gkBYByUYbv9A7p9odRlfw+n3yPLOC30anKABSPpP9BffEiY6txhc4UiHwDl5ZunvUQgpLUmdtNvec2aH7alsgi3zGZpAR3Fw3UVFlQycMJO17QfnxpI/jZtLRWkJeaEUcpwf/XR3BzfkcJMZclcGND+YbarzT4CjtETIhskMX4oadqiLKsvXr8XWEri34ey+nFkjvFjc4gmk72yFIb9hmjQnwul0WquuDVkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880414; bh=CM/QKG4oU47QqEJjDrd7iem9TeFiOTbxWl671eVi6Jd=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ME+vT4vBa44pQMO4KxIsXDhBaQ65kPSmSXQhEhkNWDueiIDF6O8UFGZu5wBgR0JDxoyEiRabYp33WRuuBy1Qe12nT/aYROg9ybM4gjIGu9w0GYnkQrXcFrm3hfh1/aN1B68e5A4KpKUo06eAiGxYFrN2MxcYLeKeDiaxyP5hk0jt4Dlkw70VRlNoDPOI2WjAgENbG3mfrFN3NHQIM6vVvGATbMNB3MSGaVOoxgnoD0xrhIcEXZleE0qD0zdt5heEMuRgC6jByDgkmFsJsDijPNA4wY+PJbMoVUiO2EK6xavALEpgQVpENvdjtv/uoiYtwFua87oROvBJTs9kY4wJRA==
X-YMail-OSG: NJQmNkgVM1mX7ZLwTEUC_HVV7LwOiXctXOATeF75L5cAqkxSHkyE9bOmM076Z.f
 BlAJF47Jc01J3SuWjrsxIZ.P3qod15v96enSVwW5qB71YRri1g0ni7E5tzlDRggxvWUOlnnis7.b
 jQyVmYAu46OZSdJwJcGfXaTaeRQ7_yiWuBws_vg.M.ZWL_Q2GnWvMKEYXYEx.dh_ppu0eA42YeYp
 utA78gW_VHOwNvtMfk2JP7R7ylCvpFtjfgVZvIIzxzOvOnT6HMvwgMrLEorCHkStBSoFwheCEmr3
 3PeacKL0.3Gg4i0WPmgpWtVdxeAef1AT4mX7HJAM3BuD1.Ah2o8673Ngpm4w5vfl792BgmpuBCSC
 cGu96bntPgC2y3KUPLmsIFbChiGvo.Gd4avvxfiJoRHco.sEH2PXuO5l69vqtb1gCrq44ZZGnDBT
 jZVQazTu.rtpxuvzB910wusLBi9J5LQAVTN.Ntv3c0H0hEhO_QV.566WZ4xZFqjKmbo4120Mr6WG
 yJsv4iuIhI9V2Ak4WEzvJFdxwy.wKoj1MRZ1ucwz1BZRDU4sQAQn3_LuMCG0EayMgw2GPA2.zYKQ
 xyVL5AdEfwLx5H2YNEVxvLgE12i8v62dKVhZocqwcNAUfk.VhwFtupeuicHPgOa0wIFgka3_T6KF
 LUG640XdwaQpkzY5P5.LRNwQypm2HqyL12RK3BYw75d06OnQFoHEADv8YurU8u1Ljdpk01WT56Ta
 A2vYRRaBwzEX85XJl7rrz.bizAYK5yS7neZFLq1tbj7aZ2w4rCUlZ82CeaAvsDY2U7kwvps9sNDu
 _MsBfzNPEFLDjPc3jfkDmnK3t53aidvNBEmrkvxRPQA2SQmcM29W4LjWy_7PyNRsSqCJ9dOK5fdo
 iYV5AngTY.83Vi1tXiBq6QMI2YU7UnsVU2LsqmFJNGW7.sSJN21P9J.b7w7vgfa0C3txsmb7tfZP
 Mg3OnlERn7aedbIhQgfQ4abI3oHDqKjF7oUCqAP2GSRk0JRqDaxBGbkrQ8YRYRfo0rQm2MFGSV2l
 wm0YhZqVeVgqaBMRqazAB54jHzfBUTiXXnbsQiSY7mK..vA_2bQec_YqWaM8_gqXmIoWV1W1dfR.
 iLfj79t9nm0uRYhi5XQ9b7uCnXNuTUJnXbF_8ehSYJH2Nm.31dk0pfAK8P6lwr3SJVVcOcThg_QK
 hh83HF330Ag86ioZiQoEvmM.XNrJXt_kXb.ouDSXfNIVpl9hfQ2x_0iCP0I4dvMfo583LEQdbs3x
 yWx9RChOorm_T6RB9LwM_MrnHb7j2.WbDDf3.wP1npmmjUbVR6DiX6_6wr_gMiWImxn.s0xQJ4ZH
 9SQ3Zori_xkRqIQXRGFGk5p2kRoBWU8wlzN3OdTPPP9X1BNHGUZyWqURXDom53KD4X4JafS9LEKT
 Ayg5LnU7UcHEoXBxfpXPuKvJ1CoJ85XTOepMHHmvl1CH8K55bmLHvefaxMlpvH9t3tru.n9iB5nJ
 gCrQS7p82vGoXmGc_WDMVlGRfePE2j6kXuf4i4U2D41sInk0vgV2E.DdtqV2H_TnJB4x0DTSaCjm
 m5lhXnqOfBCIbcD4JjpOVIpWPTNNAy_r6Jf3gTbJslMmO2w4ZuBH.N4SzepnkTjwDZK5.kHF9NML
 lDPla.vjR9.F58P7ONmB9.thCX1GrSRzKgxIOVxlkWkWc0hSGYNsndlGz.ybHXA9XmA9SRif4u6a
 vkXnYu0vCbs5aVUGHxMlQ2Y6l4YHH6Qv0s62Z8LCtE6DO_AFZD9aHKQnRGSVCP3aVKfVjGmX0a6E
 0R8kRlSHc2eejsmablYbl2p3il7LMpIpmRjN5SvubCVuxSZHg7Ebp_NDN05HNTSP13eRgUrdS8fE
 RDfP_Rk.QEuxK7ZVz_BOInmkov.qDcEbfoDXWVxY_MkdZLZQN5SPEW2pw8A2AjMuMZ06B_7RRyKU
 ggnit6QsJqDjOwCaZrEzx7g7jPQ8oUgEiMPy5DTa2ulUVHjhrtIkxDM87a7vMomzuksk4QU0SEH8
 8k12FkSjKy68egVo77ABQkehWNuxrFVIZKoEisxvceyNyGy6oG_S3T0CXFKbsQ8LnD3604E9huA_
 xpVOlJ_s8IRMuiskP1ZR.Q2WDEGZRegMp5UpRl7dReiVfeKCOC5Vunw0b6mhDqZQWtzH_ftQyI7g
 VC6FMohsEXf4w_81iZ8b9O27lQR7kEC0Fg.hrTcvsgrrE0pmL9oDTueClI2DsshEy5vxiFx0EwqQ
 Ylv1evpZPCeYuYmfcQFMZvI76.LLXN8WdOcjLtuEqmfC1eyzkFVEczyjzYruK.1rHFK_FujK4Zpj
 56XeGNbcD5qKVp5U-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b02017d3-a1b3-4bad-81cd-9fe3bc0d65e4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:33:34 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ddb5766b5ec1a95793060e378163700d;
          Tue, 13 Oct 2026 08:23:15 +0000 (UTC)
Message-ID: <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Date: Tue, 13 Oct 2026 10:23:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next v5 0/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
Content-Language: pl
In-Reply-To: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN table layout, speed/RGMII configuration
and SerDes (SDS13) handling.

Patch 1 documents the chip in the devicetree binding.
Patch 2 adds the chip family infrastructure (no functional change).
Patches 3-4 add port speed and RGMII mode configuration for family D.
Patches 5-6 add VLAN 4k table access and raw-VID PVID handling.
Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.
Patch 9 adds the RTL8367S-VB chip table entry. It comes last, so that
no intermediate commit exposes a family D chip with incomplete
handling and the series stays bisectable.

Family C's functional behaviour is unchanged. The only change in a
shared path is a mutex serializing SerDes register access, added in
patch 8. The port count is capped at 8 for family D only (patch 9).

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v5:
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

Mieczyslaw Nalewaj (9):
  dt-bindings: net: dsa: realtek: add RTL8367S-VB
  net: dsa: realtek: rtl8365mb: add chip family infrastructure
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: use raw VID for PVID on family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
  net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

 .../devicetree/bindings/net/dsa/realtek.yaml  |   2 +-
 drivers/net/dsa/realtek/rtl8365mb.h           |  14 +
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 741 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 380 +++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 5 files changed, 998 insertions(+), 140 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

