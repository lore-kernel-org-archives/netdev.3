Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125091;
	b=l03+ri/WE+KZTOutPEBpOwUqSREo3SKbZANRlBux4pM23srJ8Mgfk7WFmGrj8KO9IIWn
	 Kb930TmsQRMJSBJtthG7ZdzLH2ZuKuu03pVecwmZmsmcKAHD2aYOubS8dOJAxAS6Z7GiL
	 jdvWRIWCUUI3SRFNi7/DwpbNJLViH69VF0M/Bx3EckcZ6OkOYeLM0uuPDZGrYsdspd3Wd
	 kbtlz+U/y96Qh9yCMkx0WD5+ydKuVwA3EINgeTR/3T3V6Kix8Is63Wnu9TzqmgErWamYG
	 W0KDITEI/26YlObhZJVyx7h9GIaxEr9tF6wnXDkF8VQ/6qFB5dzRJWErRztUUnorYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125091;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:References:X-Mailer;
	bh=PciAWZR4ADMt33cSg5f2vxxVLVhZ0NL/mGjcTEABiaA=;
	b=f7O3EbCZNPZSOJvciRjljPR60O3GegXlHR87FG391AdmRp2KE9Ku2yBX7yt9buzEiGpS
	 FIGKjzGEEhNG7nSaiPI7zcBr9hwN7fP2lflJu5et8krNvKJUHsI0egS7Uj0d68c/xV7cK
	 NtK7WAaYb076l2q+4BGRJIT7RkbWYsvYq6IOWWlx2iUJyqe/bUF4ty2iaIQKXPwmdBBuv
	 zocQD9sOFEIQ6u3TLsYbLypoyxVn9FlINC87uFDkYFkv6UKSG7Wio93zqMrv/eyKGcvY9
	 EPhXaOIXDmx6OW/7IeZoeM2yM/FWjvXFVKoqnFAcednXH1O6nbpnrFmesc3wzii035g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=RoOTTfxv;
	arc=none smtp.remote-ip=66.163.190.148
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAA606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DAA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=RoOTTfxv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125089; bh=PciAWZR4ADMt33cSg5f2vxxVLVhZ0NL/mGjcTEABiaA=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=RoOTTfxvjH5g7fMBwhvLSXnLLG1tTng1werLb5NqD8aSWfbYTxlnRgqx6CXNYuRU4t3FH30M1X0NczFsNeA4GvE4lx7XaHbl00vpy0H6GvUIkbPA6aP9X+JK6rcEWkSMUXoL1mmlbzMEF5ejqyWoHTiP67kl/qt/dwhDRCtgOK06QBt87RSHIjY/IKDovrqDcSSWg2T4+G+Zt6uPfx0BLJieq8gL6ybW2gEMPyNrqgiOrDB5aioK5coUUbdVjAGz2xEbC/QMHerOM6m+V8TEHiZrUMErcpLOX4aEB7nyOQDDfel2EXlvUDQErAq5mlX2Ut5O/umdP2pK+AKgX2mTkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125089; bh=5hCPodCHQN8Hlz3dWHhB/vh/cCZWQfg2A/DtVmRPWFn=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=X4dxBbIvgf0HoI1qQ1wz0QYujsCDpZvb4P1TKiJbr7DrwJ4aAs3jDTsjSslbrPOQBHoOA3l1u9VMGa6RBJa/5sVorcX+RWw0kK/OnQn3JVpYiCr9oB8idWHPBEI4pdPaqXXK8b9hru+49G71Qb7nT+bjpa4iwtVFfm9ZFn8EL0INHudc8RQhAga6c9ih/S8DGgLpVGf0Af9cXCrgkU1+soGXqZadQOV17LmEXSWfV3qPoCka+mz/h1GkML2z4vx4wMv/9obWo0wNwO11jgubmI9P5xcCkMzcdryyNh/NpgN5HJb9zlm7jLAzMmNkVcjMgXVgOGo9c6jAtkzy5Mo8sA==
X-YMail-OSG: i7cYJB4VM1m.f9FO5eH49__ysi61D.niyq5pgUxBrQfrcwe1xj_3YTPgTTL5XiY
 HS5NSy5.4ElRetwYRPosUskeWzv2HIbAsj5qvc8hOlboBKi6EGJ7CmmEbZIfH.1GNjeAICCARk0I
 QGJKtH97oXTlHfNsitSbW1PdiKGhcL0gbNjMe666a6MoaXM1qOdzH3e.dY68jGP9_LndJBEjczsX
 V.KLdWE36Fg9b0lBTVfAFXex89E88vSqjpNLkebL0sVWyQw3J7qe0oasVD5ahDeRvltbM1ShySm0
 0qYdjIRyypZ2DAGyS7nzpa4Lr9Gk.VGMnMxeM5Hjq_ionNZLDM.VvZW.hbMXfle18bAs3geNnV7l
 BYeWekDja0ym7rIdrb9OUmcPkSK2GvW8lAZeMAuQJCXFJiMXuFABJnEFoCj3rUPi44TkEnuWOIa5
 cJOT_LxdUbw6OAtxnkpLma6H0250u..Gr63AF48hfKhLQptL44vXtPZO5c914QAk.nlyTjx7fHRA
 cv0f5Z3SX4la.6qoPzcHOjgXcygEaY.8HvOdBbegsE04H.Nh7onpB03pRm6z4SJO9t5bFFWmfEYx
 3sXRG2xH5d7IGTtpPuKLGcEjgTQ1bckEYT_jTFH9Ha1XQfieX.ZQ_ZedEUXXBAEL9TP6mxZwN146
 HPzzs3aivWgTJfFruHCrZFUAZ4A0bQpA7rTSyQ3bFa1pH.qzf9hzhEoMqmirukxCY7jzQMwsSo9_
 XJbmFlt.IbLQiJxLOyg7XQ7yOEI.vrSgy8D9UHMuFwdMt5GY2VlL4H4c.JflswHX1ZLYGdBCs_sk
 r0i_hnNMZPzA6jQw35s1OG2ulz65Qnr_z37oWOKGWKURiXzHM_pNqc9xCh6.yDHit6.EqvP6zj9H
 1ItkVi7.EdSGVs_2DQbU4Z5eGBctAQx_XDInqBsrDJ4dn2wAW1PirG2qHnrFLrMPk5OI1BX6igfX
 fq_o.pHstm8kMRgax9REW6v3ymY.U8KyX8zEMQz.g0npCsP0FR.cSXC6AanYc8aNIFa3UvV2w_AS
 Qs.8wbB5D509hUksmi5BXMzZK180nFrludC4t6q8ThsemU53UC_IAi3w_PzB.pQ.8En322EzbwAB
 jjCuaJ3aVRgU70ocUXjB4u7Gp2.5HWaUW8GLy.6d73JOmyITfaa70hSs7BjRCPa_QeprCmx5hYLF
 o7qw.rUH5Nz1H4RZirWPQzw9KzVBOy5CJ9vunCYU_qMqNcnIU8yGAzKnf1.ZLafVD3fipzmT1r3e
 guc_dNQaEQ789F2jINkC6oyDs0KgKbTI0vWoa2XllP6Ifxr9cL4hZAeTDk.x0I7I7q0FSuR91T.j
 oZVwVGWOZgHEZX.AAH0ZcDZy6EsyAyjLhUe1UJ_1XlTNtzNdb7w0t_2UBMLEjDJgPNYumZtijc0T
 CYYoxljGHHcHM5ZZZmFKjJKbKyD3_RB0V4J3.B4sO1Jyx0HAXRnIsI6lCRKOBfDcWxYLYiGzsZ9g
 sbQTL3trqkEe_ufBUi4rEB66HVrtt.5eRAls.SHlpo3rWvd7ib6V6aVcsQe6qqEW2VBsVCbyNoYl
 ANAQ8cWSn9cXNLcqdeDWexXTtRwjQ.D6IUMMWPAEHDxsjPW2RFYECuDrlTjjYcKAzxOxAYhxiWSa
 n1gUy72nm7iX6Cwrj670C565RrYtsKvadHerFe_7UYJzHZ0XHGzJNcej4pSZzL2C.Bj3gFV4IKrP
 0fl.mPpORTZh3IrT4CvaFLAht1_PG5lxFK0IsqzIQm63TV6gSsCRErRjzNNzE4wZnnLhigdkraEO
 H9Y4OC0i2L09WqC8kCA5GaEAIba2mcvI1_y5cVe9bO.Wm1fB6lKH3pZyrdCa4zHSnLRn8ah8TwKm
 _tZgXQ1muuxcXa35CaFygUmx4sb9h_ksDEBe6Umy_Aq0WE1Dq20SOBlQTUsvLMFwK1HhBPHJxlL.
 BBq6afVq09jTcgEZowwDCPdHP72YXWqEDM8hrUHRa41TuxLkOqhHy0WWO8uLGYow6_v5pmfPF36A
 0BBJLEb5W.xgtdXqc28fEGeq4ZvRAZXsYfyIyFmCtGJnY8qcA.DjjEGeH20JUNQ9aTY1fjuYVQB6
 e_nfZIRwN7fQvcbeS.N8B7sYEr7b304ckVpEcy6RVkw8REatngiq2gq_1H0qWzCx21_5dGg_onhz
 VDtKn49N1ohbxnRRF_6hZFFbJ3vqhpbkBQQlQEG1ZtcoDclQq2U.7hFe04vkfbD.6pjf5o6mIVi2
 lg1AELUIeIylXnVNhOHk81bBHZAoLJ.fqQN4X2_rE4g3MYb1pJ44c_a49Y0ZaIBVm7L0NhFPkxWE
 AOdLA53I1HkK3MmgGRiciCp_SzcqGZo7aNFZjstdAsg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b32e7a7e-9196-4c27-8ada-f18554461fb7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:04:49 +0000
Received: by hermes--production-bf1-6d6877594b-nlk4k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a4f4f0fad67e262b84d5323a1773245;
          Sun, 08 Nov 2026 08:04:44 +0000 (UTC)
Message-ID: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Date: Sun, 8 Nov 2026 09:04:37 +0100
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
Subject: [PATCH net-next v9 00/11] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <9b73858d-fc09-4988-8bab-fd7b88db9412.ref@yahoo.com>
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN and L2 table layouts, speed/RGMII
configuration and SerDes (SDS13) handling.
 
Patch 1 documents the chip in the devicetree binding.
Patch 2 adds the chip family infrastructure, with the per-family data
(port count, init jam table) in struct rtl8365mb_family_info (no
functional change).
Patches 3-4 add port speed and RGMII mode configuration for family D.
Patches 5-6 add VLAN 4k table access and raw-VID PVID handling.
Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.
Patch 9 refactors the family C L2 MAC handling by introducing shared
pack/unpack helpers and reaching the family C serializers through
function pointers in the family info (no functional change).
Patch 10 makes the L2 (FDB/MDB) table access work on family D, which
has a 5-word entry layout, narrower table access fields and no EFID,
and where a VLAN-unaware bridge (VID 0) is handled with an SVL key.
Patch 11 adds the RTL8367S-VB chip table entry. It comes last, so that
no intermediate commit exposes a family D chip with incomplete
handling and the series stays bisectable.
 
Family C's functional behaviour is unchanged. Changes in a shared path
include a mutex serializing SerDes register access, as well as
.pcs_disable in pcs_ops and .conduit_state_change in dsa_switch_ops
(both bail out immediately on family C). The L2 table access and FDB/MDB
code is shared too; the family D handling is selected at runtime through
the family info and rtl8365mb_is_d() (patch 10). The RTL8367S-VB has 8
ports, described by num_ports in its family info (patch 11). On family
D, FDB/MDB offload is available, but there is no per-bridge FDB
isolation (no EFID), so only one bridge is offloaded
(max_num_bridges = 1). Further bridges are forwarded in software and
isolated by the port isolation masks only (patch 10).
 
Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs, by Oleg
Gavrilov.
 
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
 
Not covered: RGMII and real Wi-Fi stations. The re-latch in patch 8
only arms for 2500base-x on family D and was exercised only on the
AX55 v1 (RTL8367S-VB) tested by Oleg Gavrilov.
 
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v9:
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
 drivers/net/dsa/realtek/realtek.h             |   4 +-
 drivers/net/dsa/realtek/rtl8365mb.h           |  36 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c        | 246 +++--
 drivers/net/dsa/realtek/rtl8365mb_l2.h        |  18 +
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 964 +++++++++++++++---
 drivers/net/dsa/realtek/rtl8365mb_table.c     |  44 +-
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 364 ++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 drivers/net/dsa/realtek/rtl83xx.c             |   5 +-
 11 files changed, 1434 insertions(+), 253 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

