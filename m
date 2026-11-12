Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504678;
	b=PLX+8NdybcuXMwL4z46UyvvWyqO5qvFle4WVY4olQKyDrnss0TNy2sS9nhnjNAu9zTJN
	 zDSbaBoG0t5oTQoGLJyc34nZPwY5gVccvBW8sw4PUWksOslHRQLjhwzmDig41BmIx+jWl
	 bZ/vVrpmVD9eqYk7RL1WPuh+n26xfAdysVruqVn555ZgR5BPtfDQ4Gwq1Jry5QLFe14lk
	 kaUDqhRltrapEqGFs50PHtNABhdKdj7qpT0tvSCPO6P6V4u8XvS44CrPaUYAjFd0J1P9V
	 MMa+UA2oojMC9BMLawMveLs5sdAyjfsWmNrBD0rk2au+kTtFOBUNKgNht6LpyAj70oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504678;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:References:X-Mailer;
	bh=oiG+KlHFITrKKR2mt5l3jxLTkWx/X9TR2LiYbZOvJy8=;
	b=se3RSgCSE08igHz41vBTYhFJolqi7uShNc87x2vBKB/mnNcRd2DwqwmTR1yGRGwOue7m
	 QbffVlQ+yTh7m4hJPFqvOvf9ho4WoCWBg1P6bk1lWHkOmUiMbgEVN7JaKYVBtUOP6gCJx
	 aoela7/IhdtvKPK+IEsw5lUE6jkctt6Ems7UiPFAm1fX9sxCqEjwPig4WKazTPPxeiOn0
	 GPJzmDJMN23jAj7OGKQaUxQ38vQEcYWsy22dg3KoFXxUZsyTKy8NL8mCFEbu0MzSnydwZ
	 Cg/TPeTaqL+OzBkW5kpi+hRbtosMsmT7nNIZCFDbtLydemdvKSGoSo5FOr/BFhc7IHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=lfUtyDgj;
	arc=none smtp.remote-ip=66.163.184.43
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4088606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4088606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=lfUtyDgj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504677; bh=oiG+KlHFITrKKR2mt5l3jxLTkWx/X9TR2LiYbZOvJy8=; h=Date:To:From:Subject:Content-Type:References:From:Subject:Reply-To:Content-Type; b=lfUtyDgjmDnkNoUpCGzJi39LcYfBqYGjDhbT1tMXHPDsZULloX8Tl2sPV/TJRS9OjNx47EdpTXMtc6jypFqHYfHy4T0D77YafI+ixE3Gy5AyvCBs/umVowDUtVEGCp59B6iNRZuMrHk4KdQZuILsUeuPPeBpAsdhQHcZFtCbN8dBexkC4KDEOK7uH8R6FfYhhGKZ5j6m8CGk8WXM10XThVMAhe9Mx1WaIcLJ/+jpvgk9gj0eaFfY+125xdytiPt9r/ogb+mi+FlHOAEmLSc/L8eMJYWWLI12ZqoBzpeQZWeY/0b3mC5GjaVWfpgelHJN8Z71f0Sc/Zx86OykJGuQSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504677; bh=SUVfIHsR+WDoVQPupMccwpTBuk+ELRZE5FqL7TRatwZ=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=lG5b3ohXY/LMeC5tCDKvBqv8lcfvBhcjmusn0TmPxdiAuwH9JcHVwfeJdmwwUWXr4KDMpIUHXd22EyotLbn5M/dBOUvC/IcC7DzwvpBnT7plERk1wIfhSvOb73NPQ18DffRYxDVgI5LNgIkci3lJKa2jASd23yweFu+Zub9QC1hwrKx2BvQtgHlKscd4fFm8NC2+HEdaAtUpvRpA2PhKZ9ffq4VOkcoX5CImgcG+MP9cKxlrMNQ/E4ltWNXKUkb83NcQVDzDG6oXu4mByVeUyS02FBvpSxv7IrwEEizhBaobOq8aoCBTJQBmygRooXtAIbJwD5+cZFSSni3zsQPFcg==
X-YMail-OSG: KttgUhMVM1lPDWPVqy9TFYfJKjmNaJfx1WA3P12Sj7ewDXZ8FmKt07GWz.OZnlY
 MywQ4qt5Z1R3BKifGcAiNEUhPZLQzoMUGh10GAMadm5T_kRde9Anoom_H7THij9eAwgroNZsmc2.
 IJ_vTaA1XXhkbui2hZqto2RKNPJIicQctSoiQoentSHngLQ_vzh2UO.ZZ1YnqMRZEGM4KVbKCNbZ
 Men2WDCYGafQwbn337WqlXmjADiGsgrf.NaN9kwAzT7oeMUwLRHxlbRtroZuq0HLFtMldKtYCca8
 MDjx6eOEUGah.LXDOfIiIqyvlRUb5FaJFoFmcxaRVH.es.IAdnN_L46o4NdgOXRgubt1l1oyvKmN
 w5.IzDmjW3kp0gaPuq_pAsF._mEWaD9AlO15588Zapvu6UclaJwo5nyRV2gI0aTOtI8QS2nmL_HD
 hgrH0kkhCgN7jCKD7mvjpqMNdCb85Rrsyyi7nNSW3U76Yk1XnjkjIYMywc1XNQBZ7160iRPHnnhG
 sdACItzVcPls70eIvjCx3.23z4OJXwdLkA8YuCVp.NQEzBjsU0XMpuXlzXoRHLLp2jXhva0zeM5t
 PJxMmBaQVUXJSpj92sV4Mpuh6XhKjjqprKbm652CV5fJjuX57MABFxW8noBp9NDzuAQZeHcGGgRW
 pBI9bqZe9e4dstxYus4d6NlwoMrpl0uE7AAfFje4Wk__4uGT.HfhJtRnCsFqXltCZJRG584VNo2U
 GLxOuZ.xPwgamdM9qSTs5IMsnyDYQ.YB5cyEuuz8.zR74qwIReI2PkuLDW4rgVejuEFZAaReQD9J
 4gI_mk8Gxyd2cKa7N7vXov4aTkJHJ5t6XeIVmVS5X04NS6hZDEjqpsH52C4JcZtkFR7D25Ksl_Yb
 sAXEcbJUy.XY7DDjKOHWsOb3xQRAPOGK6wD.lQrjFTFwOVJe_DHDcyojBfK9L.f740TQGDh_gi06
 qs8y03bRx_ZP4iTxIwZUw04Y7OoW_hZaxfGPvNMz5LQ0uNpK0AynanrjmfT2KapatxkBABBfHsQO
 XzOeteC.0ElGMAJowL9gKPNz6lNMhOUVAxE97ukOTuzkLNxcpeHwXcGr9VSjFJq8g4E9xgZNMfI1
 kgpYNLQs6bVaY.DQptEUYiRqyDDgyd9ho90LcmdIliS9P8DbInSNk4YiIaX3AkiugnHW2v2jFloV
 D2SzGSZjn8cKziRw3JHyz6xMpxv2E1ZLPJGdIfHKdxFBHGJ2W.i75FmUzlPa1Iaq7LrgMEkHXJob
 .vJ4ZE491iHh9pKMDemAISWIx0tZoGMbky0upj5.59hD6yMyf7hEc1Jf2TUVuXK9At1Ypuu0zOjJ
 8IoN9.cZF7ybHTIWbbrUY0HOIEtL1M3Cnu6a8wDvQ4UdxWi3lyHiK_BsJy0lvY17mLUYBexXCLkk
 0hsAVUjYd0.JsIw8MTMyLTzedTWbp_SeAZ.u77N9QNYA7T5NjY11dtkY8ZaoU1IgkT6ZtluA8Dd7
 czLw9wsYQbZTtaNQrlLcxtODsIXIdzP.94kMMVAQlxqOgkqNkeALcXrtZMo.zmvJd8chEbwiuOnY
 8M.jCQ_I4WAg_0SJh_LBX4AUwpCAToM7tv4PjhxDLvgKRypuP_u78.wGdAQXEOHfPcHqzFBUB184
 SjdP3eQtD5HmcWzP91_YnMSyAqdEeAnT3S22ruP6Ar1_zWftdhwyXWdd3yxJ6yBBF0cPgh9Wyyol
 5NXAKVjxb8s.oc2JBeXQxXPIE8Nk8gG081QuEBYzxovUZJwYg8Q7opoo.w3uJdd.XonawANl6sss
 SG8gLfHz1lOEl_OvOo11vguK8cRjo5pTM88zILsrkowz.PLJf_xHi1a6gkCDyKQrsAgLG1tHKGWn
 8H2AC2B1j.kjm0x_Wi4TrOfYvoBVm7JtVWz8At01ZYqWZWkcTeOjQrBI9Y1MqX78gJNtdDvx0Ggl
 o8mF6_GKBl7SmvxiItgv47kvANUWtBHliGyH1JJpWctLwuu0MvCMc58rvdivlesFnjY2yfzPRsrm
 GVlVZ49uF0T_iW5qE_rdt6GZq4gC.QthO2AFyEU35Ky9XbBhE_yyaIXdGgQOXrLJswQGb6hEqoA7
 DfOVG5aS.ydJeiMQ3vWhIch98bOaJL_gLJD23r.oXPxhgcsAKeHbmlXv1QdgfuvUPdvvxjG5Hu0e
 ug0RSTL4Uzz6G5IFjUNQhbVB4wdk3D2UvN5HvF9GfcJyj85AoDcFOp8vYEtaqpfPnzrRPQCGuNJJ
 bHpIWWedNZAkUjinqh8jAGqw_yZDpt7tYTogUJ4ha_Cr4exZuGg4OZlVVfSNfIEK.OlhYHWpIUMy
 Em4X8He2zzMD2XqY79kn7gX3DbyIA0e1k4A--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 7335a935-b0a7-4c1f-b740-1aa0168568f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:31:17 +0000
Received: by hermes--production-ir2-5dd9bf4598-fvbwk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84cbe93e9020ce292073c05d265ece84;
          Thu, 12 Nov 2026 17:31:11 +0000 (UTC)
Message-ID: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Date: Thu, 12 Nov 2026 18:31:09 +0100
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next v10 00/12] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <d9da17af-f49e-4878-a8dd-59a8919e6930.ref@yahoo.com>
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN and L2 table layouts, speed/RGMII
configuration and SerDes (SDS13) handling.

Patch 1 documents the chip in the devicetree binding.
Patch 2 adds the chip family infrastructure, with the per-family data
(port count, init jam table) in struct rtl8365mb_family_info (no
functional change).
Patch 3 moves the external interface force-mode configuration behind
the family info (no functional change).
Patches 4-5 add the port speed and RGMII mode configuration for family D.
Patch 6 moves the VLAN 4k table accessors behind the family info (no
functional change).
Patches 7-8 add the VLAN 4k table access (dynamically selecting the IVL
learning mode from the filtering state of the user ports for family D
only) and the raw-VID PVID handling for family D.
Patch 9 adds SDS13 PCS support.
Patch 10 refactors the family C L2 MAC handling by introducing shared
pack/unpack helpers and reaching the family C serializers through
function pointers in the family info (no functional change).
Patch 11 makes the L2 (FDB/MDB) table access work on family D, which
has a 5-word entry layout, narrower table access fields and no EFID,
and where a VLAN-unaware bridge (VID 0) is handled with an SVL key.
Patch 12 adds the RTL8367S-VB chip table entry. It comes last, so that
no intermediate commit exposes a family D chip with incomplete
handling and the series stays bisectable.

Family C's functional behaviour is unchanged. The L2 table access and
FDB/MDB code is shared; the family D handling is selected at runtime
through the family info and rtl8365mb_is_d() (patch 11). The RTL8367S-VB
has 8 ports, described by num_ports in its family info (patch 12). On
family D, FDB/MDB offload is available, but there is no per-bridge FDB
isolation (no EFID), so only one bridge is offloaded
(max_num_bridges = 1). Further bridges are forwarded in software and
isolated by the port isolation masks only (patch 11). Standalone ports,
software-bridged ports and the offloaded VLAN-unaware bridge share FID 0
in the LUT.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018, with the UNIPHY mode sequence run at GMAC probe) with
bridge VLAN filtering and per-port PVIDs, by Oleg Gavrilov.

Tested on family D by Gustavo Foletto Mora on a TP-Link EX511 v2
(RTL8367S-VB, CPU port 6 over 1G SGMII to an IPQ5018) on a live network,
with a VLAN-aware bridge (tagged trunk with VIDs 10-40, access ports on
VIDs 10 and 20) and a VLAN-unaware one: VLAN table and PVIDs, tagged and
untagged traffic through the CPU port, VLAN isolation, FDB and MDB
entries, VLAN add/delete churn, moving a port to a second bridge,
traffic in the switch and through the CPU port, a conduit down/up and
reboots, with no FCS, symbol, drop, fragment or jabber errors on the
checked ports.

Regression-tested on family C by Stanislaw Pal on a TP-Link Archer
AX55 v1 (RTL8367S, CPU port over a 2500base-x fixed link to an IPQ5018),
on a tree that also carries an 802.1Q-based tagger for this switch:
three boots (after sysupgrade, a reboot and a cold start) and traffic
between a LAN client and an 802.11s mesh in both directions, with no FCS
errors, drops or driver warnings. Family D paths are not exercised on
that chip.

Not covered: RGMII and real Wi-Fi stations.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v10:
  - 8/11 of v9 (SerDes re-latch): dropped. Johan Alvarado traced the
    symptom to the SoC side: the bootloader hands the UNIPHY over in SGMII
    and the out-of-tree qca-uniphy PCS programs SGMII+ only from
    pcs_config() at the first open of the conduit, about two seconds after
    the switch brought its SerDes up in HSGMII at DSA setup, so the switch
    receiver trains against the wrong line rate. Running the UNIPHY mode
    sequence at GMAC probe, before the switch probes, fixes it with no
    change in rtl8365mb (0 of 32 broken boots, versus 18 of 51). As neither
    dwmac-ipq5018 nor pcs-qca-uniphy is in mainline, the workqueue, the
    extra locks and the reboot notifier are not needed in this driver
    (Johan, Alvin)
  - 2/12: say "family-specific" in the comment on the init jam table
  - 3/12 (new): move ext_config_forcemode() behind struct
    rtl8365mb_family_info, the existing code becoming the family C
    implementation; no functional change (Alvin)
  - 4/12: only add the family D force-mode implementation, instead of
    is_d() branches in the shared code; no functional change; say in the
    commit message why the function is not static until the last patch
  - 5/12: log an error instead of a warning when RGMII is not available
    on port 7, and say in the commit message that port 7 then has no
    supported interface
  - 6/12 (new): move the VLAN 4k table accessors behind struct
    rtl8365mb_family_info, the existing code becoming the family C
    implementation; no functional change (Alvin)
  - 7/12: only add the family D VLAN 4k accessors, instead of is_d()
    branches in the shared code; on family D enable IVL while any user
    port has VLAN filtering enabled, independent of the port being
    configured (so the CPU port cannot reset it); document that IVL_EN
    (bit 3, versus bit 14 on family C) is refreshed on the next
    port_vlan_add/del of the VID, not on a vlan_filtering change; say in
    the commit message why the accessors are not static until the last
    patch
  - 9/12: do not advertise 10 and 100 Mbit/s on the family D SerDes port,
    as no SerDes rate is programmed for them
  - 11/12: do not delete a dynamic unicast entry on family D; correct the
    commit message about standalone ports (DSA programs no entries for
    them without fdb_isolation) and describe that FID 0 is shared; name
    the vendor function that writes the LUT aging value
    (dal_rtl8367d_l2_init); say in the commit message why the family D
    functions are not static until the last patch
  - 2/12 and 12/12: restored Reviewed-by from Linus, reconfirmed on the
    list after v9

v9: https://lore.kernel.org/netdev/9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com/
  - 2/11: add struct rtl8365mb_family_info holding per-family data
    (port count, init jam table); use num_ports from it in
    rtl8365mb_detect(); rename the port count constant to
    RTL8365MB_C_MAX_NUM_PORTS (Alvin)
  - 3/11: drop the FORCE_SPEED_WIDTH macro and add a mask for the most
    significant speed bit (Alvin)
  - 5/11: restructure the family D checks when unpacking the untag
    field; no functional change
  - 7/11: update the kernel-doc of sds_supported and the commit message
    for family D always setting it; note in a comment that the register
    and field names follow the vendor API
  - 8/11:
    - use explicit mutex_lock()/mutex_unlock() instead of
      guard(mutex); no functional change
    - arm the re-latch only for 2500base-x on a CPU port, and say
      so in the commit message; ignore conduit state changes of other
      switches in the tree
  - 9/11: reach the family C L2 serialisers and entry size through
    function pointers in the family info (Alvin)
  - 10/11:
    - add the family D L2 serialisers to the family info, drop
      RTL8365MB_D_L2_MAX_PORT and the port checks, as the core never
      passes a port above num_ports - 1 (Alvin)
    - use an SVL key (IVL=0, FID=0) for VID 0, so static unicast
      and multicast entries match the learned ones in a VLAN-unaware
      bridge; they were written with IVL set and never replaced the
      learned entries (reported and tested by Gustavo Foletto Mora)
    - offload only one bridge on family D (max_num_bridges = 1),
      as the LUT cannot tell bridges apart without EFID; further bridges
      fall back to software forwarding
    - do not delete a unicast entry on family D if the entry
      found belongs to another port; update the l2_lock and EFID
      comments; note that the LUT aging value is undocumented
  - 11/11: describe the 8 ports of the RTL8367S-VB in its family info
    instead of a family check in rtl8365mb_detect(); mention the L2/LUT
    and table access differences in the family D overview comment
  - Dropped the Reviewed-by tags of Linus and Luiz from 2/11 and the
    one of Linus from 11/11, as these patches changed substantially.
    Linus, Luiz, could you please take another look? Tags on the other
    patches are unchanged.
  - Added Tested-by tags: Gustavo Foletto Mora on 2, 3, 5, 6, 7, 9, 10,
    11 and Stanislaw Pal on 2, 3, 7, 8, 9, 10

v8: https://lore.kernel.org/netdev/08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com/
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

Mieczyslaw Nalewaj (12):
  dt-bindings: net: dsa: realtek: add RTL8367S-VB
  net: dsa: realtek: rtl8365mb: add chip family infrastructure
  net: dsa: realtek: rtl8365mb: refactor forcemode handling
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: refactor VLAN 4k handling
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: use raw VID for PVID on family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: refactor L2 MAC handling
  net: dsa: realtek: rtl8365mb: make L2/LUT access work on family D
  net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

 .../devicetree/bindings/net/dsa/realtek.yaml  |   2 +-
 drivers/net/dsa/realtek/Kconfig               |   3 +-
 drivers/net/dsa/realtek/realtek.h             |   4 +-
 drivers/net/dsa/realtek/rtl8365mb.h           |  48 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c        | 249 +++++--
 drivers/net/dsa/realtek/rtl8365mb_l2.h        |  18 +
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 647 +++++++++++++++---
 drivers/net/dsa/realtek/rtl8365mb_table.c     |  44 +-
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 321 ++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |  12 +
 drivers/net/dsa/realtek/rtl83xx.c             |   5 +-
 11 files changed, 1150 insertions(+), 203 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

