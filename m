Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC17311C1D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112413; cv=none; b=NWGnILTTt0Lga6M65PfWSsvEKEEu2TG7arBTjQzKVyeWktoR8/j0h5RhT7w18HVhdAk+bKrg037RDaoMNpVZPa5+evi9uwlN3Pg1dmrXiikFr30W3SSU8F7j67KjkhLmeDow0t+VTxARpx4/CcJ70xYhi00eqoSwpvpbKLxCTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112413; c=relaxed/simple;
	bh=v78cvzPqXV7xNzgbGa1gcaYgu1nJjKCtHmxwdQGPtAo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=i/W5/XC3GbFCm7v8PGbOfdxAyuGRIZNqI9YzmqNLMGOF0QE8y6g3Hbqjz8XjRwiXFyAFviPaPvdytvXhtS/jBuP2BcUjHkFpf3GT7NYU9fYRQCvL6jZXdPxokDp5Z+MteXIB0RE9TUoH8ENVKkn/49/GMg1usag4EpNgSRqvh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JAvsbM5o; arc=none smtp.client-ip=66.163.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JAvsbM5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112405; bh=RrgTPv9jyhxEJFw+qdb6E1EehsMtqZ33ZJfqZP9TMJg=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=JAvsbM5oKpLH7JVcr2SQ0tuwpocSRXj3MJFx3TDM2+oUIbj6mb+qL8B1rQca3TohdrisCQKsx7CubnIXXeVI3n4Eyr2CvGsk484kSAY/Dl1Vki/WABjLcfEgzVAbpiRfvfG4IwWqW0BrPjxgpq3OG0ruStf0yGGawrfsJXo90vVbFFaDMAAybB+r5mbffLh4gZhl3eq22U3hBueEn3innfZEPr3aXrp5aadUZ9lbTmr+H0YlfaLIdKLOTE0PSOsHgfMlabDZFnQ+kQ+amERlIQkOg6vVrmqSZ/Qufta/OxVwH1MjLBjbxu99H/hqI4IXD3eLffWc0iOXDU6HZ/D7FQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112405; bh=ACEJQp6tPtvv7A4ashozl+3spBhXAWb+jCamFM76ZMB=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=kQq0ouuqMfHxZWtwu9pKXvYZ2pKQyChABpHPvKBCN1Boxkar3C3j2HjKKG6Itz2MMDx84oDC95MpzCptpqmV6EMwvdIlindyya6pRmNC3fytazzfC+xX02fJfFVDq5wQVoeoa8G9bpi5zu4vAeKN9v/tbaTpLE1uVR3Hg47tnTLOtTJMtfQ5/h6YNeIlUjnDkzU8v4riT31qum+SmpmLoQEQ8gO6y4HGTmRrXjlm3j2LJtGVN1/FFwhCkUlIbtjDVwV7jCaf4p8+wuH8BOBDMUaSr5WlNYT+sFXE+vPrNv6r2Oonn1lG6nDMHllhitZ9Ad6ToMQQ3ES1QYdQWLfvVQ==
X-YMail-OSG: zue_BGIVM1np4S34eEzcztUteQJ4ZSWuz.LhTw0mwBJmKrzUNgB3FnL3NKvfR9q
 ZNZK4Qr_Q1i849zvr1d7_WhzbguwVIUX7I1rAAJ07OeC8MfuDfKxlmcedJ1v4.zE8aESNHFRcMHN
 klS7d8cucRTfjtQ4_14tmJk4fjFcvaRLhD._lZ7mkTCpzH5vdJ4UaVqIQ5vADR..sde9qxbySR0M
 FzspsaadJIDhk.zXUpeRQ9rEK1lJ.8nM5GSQWUAQ0.5SFrj.lBGvl5pZMQ2oa1Mce0YNbrQM0RnB
 _WZAm5H5dSbzpirQYv.cVkaKl9nXJy6iTNvMPZ1U7qT1n349tuchGeImBpHU.jnxS9SDb7NbeKjx
 pnckj.sB2ezi6qmFxaGN.ZJwNHvKpLC7xsD9xjLp46JV0SAGRjsP3YB9g7lavPWy0ixuNnhhIcfC
 QizTmfaHA.jDLf0UQtGBMWGsIJ.7Aoo9Ow1CufPD29KU_vvFzyt8fx1IY9ahdwlpybkfGP4J2Ktw
 QSNgczoargGWWPTS02FeA4X7Y0s5lbN5EW.01.F9Fx9wNyMXo.E6zmgHsZxNLj96GR4YlqGbnLij
 pqITmDdw4bDIT18wf8hnhWWzVEZtZV__RL1sRfPoq05UX0dCINlp.wGMSz7TV0lV7_2nZ_Grwlwa
 4Ug7XXMzZ3OlfjcviiAHzVKVwhzcujlIqwXlhf5rvOi6jvK95BUOsxY4vJMqwwbfzuJ.ReFcV8GR
 yOMu5eIrlPgCqBd8LZSXyo4_GP7BaGNo8C8HCafh8Ng7_tU38GlxZp1GruN9VXQJ1FB9DYLtzjtF
 ebziPHGgZWeGAVXBLOeacgg16aHnwJLk8u.Pac_I5qvzBOlPfqZ_uYx8ihF7lG9xE830a.N0Rol8
 C11vYA3ezQ6j3V2knsSTo7OHZmC_qrDxWQpkOdbYZOhiAKVMUVgu.2hecII57gVI6bTVM62ujFAz
 Dzh5Q.4Nnnup4_S9Yyhg43qVQTkBkbp14SOLhYPF1FRSHk72SIsPojlhKJ1bCV0dhXKNI4unbLIj
 wD14Qkf49vh4j6rC5AO6Gkuz9o2Y.f0wlEoHmAm3i2ehMS.393snQorS3eOBeajb_J8jUsQAEUqM
 LjIOQjU2Mypw1be7n_b0l8S4fDhZqaU5D6x852a3YK.yumZ4WpTfIJi_eS1vNF_Lh.A6TIfFUYJ8
 k7E3ctR.0jrVoYA0SMi7HzXpws0Prndje3ZfNMvYtNZ7m67kB0Q_216GkdDaxA7IDIolbKXrgksq
 VGs7xm2wJcuByDeRfVEXAV1M1cBOvO4kTMTjxTY4MeK.gGqw8eJ5fFFHdTeequ53tGZh4qbDIJkn
 9XRLNc0b3mU1OZUf7JahQ0.1dOoZKIB3uXTHc4KKjHIrA7HH72r5otPQ7uAlhqchHcbwJ__XQr2k
 TME7PtQ0riIuVOV0NS6L8ArabliDBSH4RWBpjy3V09gupgYqwPYmjjxjh_gjXZbR0FEabWO_M1Ou
 arRRWEi.5ZZZ3ccVSrxUYPd2OtxAmpRKUZtleAGMlHgCut350OcNaWFkA1SDef4qL6ZCZuY6N1cS
 yAAAntsOwjDICr21SyDRKjzHkoDAQi9gvCKl5awXpBJe6jjeUMEnTHZRN4aQj6ZmJT3IFtOuHNI.
 w4BKNMhW3_2ExNp.pehcI5Ntl37VxaKIVHOzz7hho9RbLqbzG2QJAsoDp3MJuxGAuUdaPCl490Xb
 crhvVVQr2CvfO1Bm2oaz6fnPP3tTbYrpq9DCppFaGtDOqs4Wi6qyFxplJUboU1POkQFJMd.6fzAL
 zqcdfUTrZNmv8ARfeAZnPTuFLa.QzQWiY380zRc8Gl3uWey7fz5o1SBwjfdjv5RCnJ0eoXTAa4yh
 OdmYrUaISPerHHQxJ_UePfBopJofHhkR3FUQWEnmYoXPfZ1IMS4oKN5OUMz.4Ok.RaGPBQi9WpIP
 YWpiF9vA5KuDyJzAt5mGegYwBEDFQzGxxp1F.YB145yp3BPW497plVlGuruPcy0m1dB1Nqk4FcT7
 .vAJPS7nYPTG6GShi0BvA0du8Gc7WjwI1itNO5dlcwqqB25wqsTwEnWnSP.He2QqZOkoHc1klyzc
 OPElcWJNyR4EVwKOJenrdJpj8JMdmBslHUY_9S0HG0.OuPtdhVv86qAxv_JyKLyQ6mpv2o0Oiu_4
 KKe4QQOZ.K7sAunlZXfUCExsetYcJ4W4POzDG07TKmIV_nzzC7A5NKd4orNzqpd9VBid4wK86C2m
 kQmqkQstS2DCKySY3tp7POE4LrOZCAMu7_E8PAYLUb7LJA0YTIxngGRIpZ_73DBqbhcYBSJMD7Ni
 aSU8zgnIhNZFLHcOR9STfimebJDcY
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 143c820a-6568-4798-8868-72633afe5de2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:00:05 +0000
Received: by hermes--production-ir2-5dd9bf4598-z289g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a363b13cdc903bcd8d8bf162a90921b7;
          Fri, 16 Oct 2026 01:00:01 +0000 (UTC)
Message-ID: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Date: Fri, 16 Oct 2026 02:59:58 +0200
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
Subject: [PATCH net-next v6 0/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04.ref@yahoo.com>
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

Family C's functional behaviour is unchanged. Changes in a shared path
include a mutex serializing SerDes register access, as well as
.pcs_disable in pcs_ops and .conduit_state_change in dsa_switch_ops
(both bail out immediately on family C). The port count is capped at 8
for family D only (patch 9).

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v6:
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
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 813 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 366 ++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.h      |   1 +
 5 files changed, 1057 insertions(+), 139 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

