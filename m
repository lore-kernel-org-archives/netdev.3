Received: from sonic309-22.consmr.mail.ne1.yahoo.com (sonic309-22.consmr.mail.ne1.yahoo.com [66.163.184.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC328CA6B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763711; cv=none; b=e6TyR0pto85d7zHxdjWMs9tiOiJl2v7hWUlJSeGkoMUlNJLovKT/5DARP1QpqGUib2nhX6voNzNmp+9MCAsmRaqhO6RBsvR31f+EVJPN5O7E+irPPgjwqDUwjdVvTNLqygYBP9bCetzsL5KnYwlv4q6I2Ei5dIpKvC9BiWUWLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763711; c=relaxed/simple;
	bh=y6VO/zk9PRwxW59Yv1vfAjhh2T4muVBfhBf0Gy8yeuw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=NOltPPCVpPG9A/1ISL3YGMDZEyFnqK78NgDBeztx9BU6zWU1sjJ9+M/A0Yd5zaroBrgsHhkRsAPCUA33+mC2pA/5cG8tx9rwyDMW+t5fVZ0dHaOnsDd0cIH6xwzcDklpbr4scHzAgnNUE9n+Nm2VCMp6BR4W96RrSDWEkmqrWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kMyUH/OF; arc=none smtp.client-ip=66.163.184.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kMyUH/OF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763703; bh=+qyH/Do5H7HZZ3VkNFuAM6orXFG9Bv3NRX1B278lplU=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=kMyUH/OFYnf/YuoWHD0WJJUHN+TuwFGEqI8P36G6uSnmaNKLGrDI55VvFx5FELlgf3sNKFIPod7fXE6T2m8OQHUz3hHY0uTgR566fNS686UQoASC7TN0TXIuDcxbpK4bu0KyKsrR/FU2BrRLYdix9iHF6nEq7YXQNg9w1D/nHOiLJb+MPikBFPAKI9g1s5pgeCsB7ZtvBWsJ+8TbKZHIrSy2fec5mkmbFzuNPJf5b/i6sCgJDh9cqM4Jpm1n97YyWlD/7nnixWqawLjj9ZlBMTMvYxjNuoako5l504zUG8SG2Q8K8NpbucmrFJTSh45ON9ebgbbOIctD6EKqCxynFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763703; bh=6h+zAeuxqjjMQmhOLtOipx28j65aW5X+wWWpCEMg4da=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=QzNtjxAPfVcQKaVuscOUuyrt9lW6x+Vyng7Ibpr8yZh0AeDDnSbRwjP3LCyvpzmgIHbKpNe/TW/3L19zhG+sh4wk5w29B16v9ye4lf0EqAy9zVSGzyIzVMKs9mX1ZwNTsC/9wqwyN0TP3aItqF+P43lzK/M5teNRYeC2/YK+Tu6rM0h0qgWzjA9UrYookUuEetb/xCm056RF0INtPwYXxIzoKVV5Btwdid44dSbpU+RMzQk6SSmlF75tEY62LPyygsorS/SeNY7mq3r6uoLfA7p6Ci7grNVWr6DhOiC7/FEvcuC1m+3CyhJOywHp6FvnSeBguwgC6ttjcX85cEb/Bw==
X-YMail-OSG: cbLZuEIVM1lsO4.mBVKfZcxXKGizzdQWaRrW1vcGxx8ASTH7IZGUmQFtWWS2_cZ
 Ja520MgqJalRWy2en1uAgp6RIr0H0NNk8gbk0LSkA2Ts18GC7qh3hXwH_VUK91C_tOQaudlHoVLL
 Z_P3t7G9iSN6L._Bwmwm8eXLcl74zg6lYJKCtlAIKz0CBpLvVICM_PpH3j07DzDwfuqhE37bGG1X
 mYz0Z79vsnjA.GQ3c6j5FOn6XRdLotKe0bScpWKIoy3Ft_FqTIISK2vhOUJBAXrmrcR_EfK8lJgq
 4P9RAs8XwjeQbHKuRaRMZzjfdUWrxFgR..JeaITl8NGYowq_OVzsI7xJu9gNz30YjEpk..C530WP
 Mc.sset_qkGLUlHwZ55h1cRqJ6XQbjxA0MZu9vEUyI52kTI6wD5rZYnnYURgoK1r07BniYTd.ZMt
 rplL2kKHhuTzhRKCKpQ1rT46uSe0Skfpwe1OfK3nzamqGk6nHjnPv2zSSViRvX.CG40qVyb_UP..
 QbUGGwKDpgBRFXd6ybqqegVggbaTKFbb4Ge2Sfz9zaPqNy809gcaf1pqGqS6g.ts9NAYVb17SVMl
 ZN8kvZKFmtPn4wE25A6lS_qDO4OXEHfJKyhMIQKMjHR0rxMK4bjhvB9dltkU0saQwFFOVOSMmy84
 ncN2htl4wBfmZwWdkN.3h0XPDpAjmGY5DHI1EISV3wnBa7aK3c1Qw2J7whAXAyGIeMPEWtGFPZ3n
 YQqWHl5cdqhNnjbF4.hAGzDQFPlxZf6HVMkV8gXkCvSE0Wi3blDMW2xELYc_U409lfNGwetNiYBo
 QT59oIPhv3HSsOMYqiGXxH.ifbreekQSEWH9e2wl0ukBLTZEM4WrGDL34wla.ueAIWSf_TsuT5dT
 zziGGKF5sxBHssh2hZlhZMB2qn9SLUdb4WqZGbW0tRvk5.u71fI10cUPVOpnK.Jg4ifSEaIL8HGf
 qyPcpxG3lrWdZSBxU_mXu_..mEjNhSN0JQH0YM5XM05SLvXQ0GSJarxPgzH8QSTYKzoqV8ZXgsxI
 l5kVtm3Ic0pvXVJcBc7kAa.CbunxE41ieDpgvRETjXcC9lFWo76Eg9FqQQfFWVH0QJoRWcS57PxA
 T66D5Gai5fiRRQeTqG03iti9QihK4GAZC_PyFLYLp0ubbeMQKbD.wj2qeLeqthWVwcnHzJDQT0lz
 ILZplBYGwJf4JQ1wDp3jYnycrRpLeTgO_gOjJJuJqNdSwibRUY1l_EqryILNHi4PRuVlvtVOm1Tr
 irIodsPy0SjPSCcjM36nKBvCNe4T9Jl89J_Nb.2cXP1cJnzXLeHn.509lwsGXmRPfpXxGIzApciC
 gDEh2M8kbHT5psLsGnMe9e5T3xTL53kKg_55jAY.lUThF0lS1xSBdcfXTTMBON1T8l5JHyoWLLV0
 bk4ZtONVz7k15N0hX0vWDt2vDc0uMc64KWSfGmuM4etJ6FkBM0X.AitYOpIJ69Lsrra.65bHb6_2
 qZ6ZRIvd98bXlv_oiiW_Bn5B4r2jgWI0goIarmv42KWPhBJDMAGL3BuxCgSAt7R_weKq5Ouj.jgL
 Mx26HK0_NiiggfcPXaczI7teS.4j27jMbAck3Eb4k.S6PxHrnVrgo14GW4gOUNqyF0JmsFsMCVoS
 UR1Zp4zgQL0VSMEz9nkXM1uHqZ5GuHe9Cg4fl2tfP5m1qOWQaDfl6U1wnt5D2e7iMH4SLnE6Tt_x
 ZxyYY11zeywn9mFjvKj.OJz0vEQC5y6h8RKCaXGKM4qtEMB5zbqSsPP.CgEK1s1iS2g2F4A2BNt_
 9SJQ14F5IwUsfSAZT8DJxmFkpI8CSW7GLP.1g4ClelFuebrHGI4GeTYcMFOYXEu8uEzEuIGlhek2
 sTMYtAY74.cMfM_OpwdJhrnY2bxGwHgx2o1vbNcSipGwejctaN8cJg_Sa26u7lqU64qUyQE1ynMJ
 .ZxpK0CdlQpcPWgtCaZzqSfY9BV9e__Eo1o3SZRJLdWZVFXZU3Hquy_radrPLIa.C8.uTV3amuOt
 8TnmxGRHWF1lyeAFQlwEnoGJuGlSWQebsYf7voNpb19QiCs9dVcueuxFBxBdyDxMraNXAqgNI81.
 5vJudKrF5NkbJSOmWlaRMZGqfqDKJMbpJiKrs3Om6Xgatt8HcSr1F2iFZYHVcwu96J1odOHo1.KF
 WFXUtU5.dxZCxGVp.w.IoFIHU2N5ipSl7I_v_oi10pjvocdoN39vk8GtLHqS_mg4pYwt3cvAozxa
 7.ILpqSHv_JkUgyT.CpQBfG0UFIjHOk7VHaSUMlGLuuwmCYnOOPboaTlX21zcSH41df_vCy5sS0O
 .ab5qKFVtXejrZKTG.osbF.4USCwxcyrcP3L2EQ0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b74c2256-2bd5-4182-89a6-0baaa9f2e254
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:08:23 +0000
Received: by hermes--production-bf1-6d6877594b-7jv57 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID db64741de0d526f52593e5ac5ff791a8;
          Mon, 12 Oct 2026 00:08:18 +0000 (UTC)
Message-ID: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Date: Mon, 12 Oct 2026 02:08:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next v4 0/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <38872e6f-1264-4a93-9f81-8212173e909d.ref@yahoo.com>
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
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. RGMII and
SGMII modes have not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v4:
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
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 700 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 377 ++++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 5 files changed, 957 insertions(+), 137 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

