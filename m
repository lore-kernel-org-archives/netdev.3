Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630103;
	b=E5ofM1hi9phnXhHMZ7d/elIhSneZQwMZMHvSOsZBHgylvFVgrdS/4XplYh2ejgxur4Br
	 v7KfnEoyXKutOtRg0biJP0Wz7bO1doObU2+zRp0XK61gzVIMXpONvsxWkwGAuAxBJ465m
	 25/aJ7GpYOsSeMLME/KZSLWFWl7Tx0B1EMsLIMNsafIGlBdHCFpxEUsCDMbOXjalUiHw4
	 tAHBtdmygNnmWWM0DipO4ttHN4NMnNj5DtKOzGSBnyr2IPLPYL9KszIS+x1R6gPZIZElG
	 AUJd7pjnIg/Jyc3YZRJ6MpKdMfl85cwdbphE6cfmJaayO5OgE1Qq3mL9MEk3jsvaEww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630103;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:References:X-Mailer;
	bh=ySq05dm8z4HzqOaVAbxN2km0h5tMf6U4qj8TQGG2fbg=;
	b=0Qc0wCOpCPwMMkKQE7ztfhtMNrlErqIAore7+oqBSCLj3IDUcSRieckaI7e1pZI5ODzd
	 3yhhmTTTVF2bZsXnwjJq9UN5J2cRHXs4DaizaGuXG1xNw0IeA/Lzbkx6gGga9Gg9lzDuO
	 7SWa54IKN1yljqt3ZeFbRNY0HYZ24+Tt28jhbq/BBrBAMwMLQTqoeI4aWwdhOzcd+7oLP
	 JTnqBe72y9vLhS9wgf6lPJq2XXw2QYhD7wjTH21r6K/T00Ar4v9Zf6mxq2jrj9HxZRDrL
	 eu9Ctl4zY9j014nHf7P9QeO54XjEf5L/7ufchyxZBShPMzMTLQFNmWPo59sDUxyJXRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=IvQXBVr8;
	arc=none smtp.remote-ip=66.163.185.147
Received: from sonic305-21.consmr.mail.ne1.yahoo.com (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534C606B91C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C534C606B91C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=IvQXBVr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630102; bh=ySq05dm8z4HzqOaVAbxN2km0h5tMf6U4qj8TQGG2fbg=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=IvQXBVr85tU7eStn2wOFbd4GMDPjocr2kLlNsJ01yOseaNvG6zTM18i3y00CWOyVBIJt8i8W1qSK2ZpPxHwM4/RcbZ5rje5S0494H98nz2JsJPhXhvi8ONembhcB0zrbNnX1O6KpAMCYZQwlH59/565lAlf1wOzY4gmi342hoiHcLPVI/KqLlgiHC/3S/i5CMnkzPlFT3Yesa7MNh+XvHYe+F9fg5KQt6gRf6iQgDMK1TiYFurJqKmi+wVVYdNjpL9pjx2oHf+kE4UlOW4C/o1zBQDpQdlWizIn1IT4LamagcCBfvi8yWmhcdb63hcvkeIx6Vsm4pC8VoYNv/QiuiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630102; bh=xLScX3ovoNZzXHhIeMVjmmt+hNh9BYQKVW3eGeDZubN=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=VCUmTfVGe6EuvHO4WDiegrDvNIdrZkiyieJib6LzsbFSD59ppKFEif+E4+Nwf9x3h6CaPT2LuZyePTtf2bNvvGa1vrIBFqjPauucWSlhQoqznHQeS3YRd42tewQe1nYjM/IBRUXvRLsROxDbweTZ+8BM8HXhdTzfYavj2VDPfiiQzCr9BGjLgeaLMRMxenaNvYmFmObTwL67dogpgt8qgIYbpW5tTcbK2UEaX0+WkajOP1E1n39/7sIswLtpIAVoG9xqpKC3JH7YMtoUeAfzeLJQH4porUbXfMPoaV7Kj3+Z0N5mFVMrX/u5kPNUIq9ASgecij1i4OMRLIYBz682vQ==
X-YMail-OSG: MNllFA8VM1mScRNjYclfBIdttVglK_M4bB1kIeMLIiWRkQUJQo1OBpdWhl4Hdv5
 jAabuIM_H4ZpdLlrKP1gVY0bTQudpIyyy5MyHMsxuvHJVc6hY0GHsF2Ms4rGHzxARfEcLjMC9YqK
 VJhQmM_57r_M8muwytGh7.C7Zk2J0LI7KZMl6pQM6lnITUpnvL3hgW3Tf3kO555vZYdr3Jj5T1O_
 iIDYdocS4fnVD000rJWwKoIXATSAznZod6jx83ohB5z0CSa4Ch.GAxA_GYedZyUv_z3xn6Miz2q8
 X8tbDOOAhB6Z8xFG_S4c6jYd1bVa3IKS0QO1XiSPGWGyFZeqCZHP9WLxUZYIXm0PT9U98kyeRVz7
 ZborcE28cJlBzfGZs1SHj5uepZXGZc3NLiMXllVijHh.hB4eq9eIxGeQKUnMqaklGvf.M.zQzenA
 AbPVCHxUOQJTYio6gkdzo774VJThbiXPtSsqqOetRQLpwqGuSpEf_RC.ZM.IUXe2AhG9rJwqtEtI
 j6.YeTNW1NFXvsfus6oN47emOv4ymb5efP9fYSG6j.LmikaAkNZSEx8bkSRR8Bc9VK11G72aZVdW
 QFhicsXArr.InEcKyQy1mLoL3yyRKac8pFQa..4S85m8jjT47.b.GYqn.u3m6sRSakkQioPTX7r1
 Lu1MsCXZfjD1jL6fp7cZuDiMAyet7bDZq25J7Ub.IuW03Q2R1vWKFIowtFl.dvNSk5EGsFhBzQkG
 4Vl7fRhjgRkB6WGddW5CyxwZlRN16N8OMLaIBr09hnOYPsK.8HWde6YHDyI70PUo8izwcnb4vhto
 6J80qVhk6ufxX7YJsgoD59MFQeg4169BVo_Vx3.IDIE4M1JQ5LdhsmIfLFAHwqkXJjZRTJTzpk3B
 t1Oj5CovLuhx2lPQRVZR9qPqS3lR5uTIOGl36uv0f0HaX_2IYOMM1LuqsL_6H9fC4tvo79lZUaUn
 S5Oys9IRb7R70ayAqQgh3cg9StvUGwam6U3UNGWkGPs9YBLq42_Bi.o8Way_dXGC7avzMt3AVoM1
 L49GrjfhxKE5sc1SkILCQ0j8UJR.tvh7oApRJ1L8YdU3WQ3fVb_S7BAwTqQCNXIaQtV0ewfZUfCi
 b2NKj.T7lXKXu3ec3vc6TeEp8uuEQ2OSuTsWmkaSK0.ZpY6RWc8WqeeyHmS1G7BMFDrDq4Llr_zF
 GUpZEsaDJyRrLsomcRvlBKC2rBDM13vocNKOD4USSNTWl_b2k_xZnbMylXQubi0X8jBE11lqs.Vj
 SLz8u2843GDgtEgxzlsfo_xIP8IzfhJrx86BZk7ETnrCjdGkuFlFXwpT1FALaB2BWiIVZRVU1G4q
 13GNjrolcdcPYJ43X1tEBeye.SM9SaCn9UbMDn5s9hwIhBLhUfGc7AH81reS8WUJbC5Xt1Hot6qS
 gWfuBrNsKiH0dxlzZDHw8TwZqYFAqNoaBxK9PzgcWtu66N.44s37PDO8Q3fp0UtjJMk5slEq3je7
 dAcaW5be2JX9bBsHeVKo8EsjUCxCO3kZkPEfc6IuWsuY9w9ylH854sZDYTaastS2a29tOYURyz1J
 4faEuZFGcW1Vj.ZE56QXjy2RwxFMLJ2E72i87GLE1PgA2dQ9.3ibDqYlCYDPVDwVf.nwrUzL7nob
 XDMz4gFoRqQKodnI8KU8byDQU1ka2umtcZbx0s4XcHF_.XRp3SakftcZDHcjHbgdAvoDJRkcfLsj
 louDdOal59jgN7smwBlxta2fgKZlQsYXg.15lY9GXm2oJhatz00_BIWXeZ5mXMfPnu_wXS9k4jCY
 e9HKn1YpGs1N.uu6.ZbjVz7UQ3beQ2Ru9BTmtCMPbIEfbt4Yj6OiezI2Z8e5_FObguD29NpHt5K8
 UBfM8aJhsLZYqLWltEsSRXXdgMh2jHqzTNRAq4pZBbhdRx0MVEF3zriX6WFZLaLwwqDZzH.yAabd
 epJZQ82UnN9uu8ZopjaG4TIRDbRmnetl4HeHY0Wk276m_9Z1QOnGeDknITOl3m4QFHu0fDrE0neS
 ocMsSE0P5hIJV9L7tg5bwKMHpq4lJhx39h.4ZNvrL7ILR5Z9iRQO4cDC6x31.D5CpAPro8OYDgnm
 ttxbArr3SGz3QgLejoEpNiFbLVqHEzEfrcVgahbjcR7pKp1VVD27rZfQmG3Z9yDuDpODIUGOFxst
 WNRc_CsWS.BQSCwGQ4mmxfmixfnCWf3XFeHfC0ZYxvqzGRFyqMkQKkgP4bKfXS9Rr6rJ3FhRoNup
 GtNmFo8Rep2AA5VT_Zd9ChDwDtw4A4ifZaVfjuZvthLh7uTd59JGiKc.SP7iKQB1_tXuSYEWRjBf
 0UdIwRsBxPW60lrOX49qRBsiRzHKR
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9bf6d901-537f-4f20-b35e-20d898e7b5c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:35:02 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bff483e77313253b6b6a88cc3a3c51ea;
          Mon, 02 Nov 2026 14:34:58 +0000 (UTC)
Message-ID: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Date: Mon, 2 Nov 2026 15:34:54 +0100
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
Subject: [PATCH net-next v7 0/10] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb.ref@yahoo.com>
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
Patch 9 makes the L2 (FDB/MDB) table access work on family D, which has
a 5-word entry layout, narrower table access fields and no EFID.
Patch 10 adds the RTL8367S-VB chip table entry. It comes last, so that
no intermediate commit exposes a family D chip with incomplete
handling and the series stays bisectable.

Family C's functional behaviour is unchanged. Changes in a shared path
include a mutex serializing SerDes register access, as well as
.pcs_disable in pcs_ops and .conduit_state_change in dsa_switch_ops
(both bail out immediately on family C). The L2 table access and FDB/MDB
code is shared too; the family D handling is selected at runtime with
rtl8365mb_get_family() (patch 9). The port count is capped at 8 for
family D only (patch 10). On family D, FDB/MDB offload is available,
but per-bridge FDB isolation is not (no EFID); bridges are isolated by
the port isolation masks only (patch 9).

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested. FDB/MDB offload on family D has not been tested on
hardware yet.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v7:
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

Mieczyslaw Nalewaj (10):
  dt-bindings: net: dsa: realtek: add RTL8367S-VB
  net: dsa: realtek: rtl8365mb: add chip family infrastructure
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: use raw VID for PVID on family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
  net: dsa: realtek: rtl8365mb: make L2/LUT access work on family D
  net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

 .../devicetree/bindings/net/dsa/realtek.yaml  |   2 +-
 drivers/net/dsa/realtek/Kconfig               |   3 +-
 drivers/net/dsa/realtek/rtl8365mb.h           |  14 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c        | 216 ++++-
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 872 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c     |  46 +-
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 366 ++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 8 files changed, 1348 insertions(+), 172 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0
