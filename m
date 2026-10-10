Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B64B486B
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661018; cv=none; b=hqePMdVTI2WQ6kbJTL4A+x5Qxxd6lDlbIRMvljLjAJMHVldwrQ2jE7/p45jhef8NE7mASI+Xpc0W8+kWxrPqhcnFjpOQd9DEpnz3azfq06i2EdThGz31ncuqal+cqrrtbxIPFuTxs9Es8flZKAgVYtrV/gtDjtTJvV1zib22ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661018; c=relaxed/simple;
	bh=D5M9+31XeXLJHrnkNLGMx6gVKfwG3qeawuHxoqsAmdY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=BfVAMWZIYVgVjWzcnRW92n4c2sbQiYcRlzHi8XmwPqnq0HxKklXtDBroYTCqtPrmZlm5bs98uPoCRP2niN70KlH+Sa7TIQP0rImF8MsKodJhcra8G6r91F72nsBzubjHUxKG41gtR5/L3hauaOo0mVyMO5k3ssDAY0tRLgF6z8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EzKxIJfB; arc=none smtp.client-ip=66.163.189.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EzKxIJfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661009; bh=PMFSbBd03q5NVfUMHDXaGYFQ3uX9A1H8j/qddGRNT3o=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=EzKxIJfBU506TPB0jXQOZp852TaWk27I+ekWcrfx3xEx+TYfav0FrPiuEGMhIxnQyLD5BFQ/j6pPR0P7Shzdn/8ajJ1jmYOSOGSqu4PZGWxACksBWXtUhOz2kG7ofJ6/EFGSM6/SNwKTd/o76ymaQNJtC7LM/ZsJdwlyoQrJG8i2AnR1qz0fHifS53cniNuSTZEjHLByR4Mv57VBUI6GD7dVgoTkZGvXYhDsQU7T1uYqGhtM9ckZGojjQ14DUboEo9GOYL642eKjXZZZShSpiwfXR6qSpo8wK5X54OiUwMP1AFYsTucvKFBaNz1fvDdYtZQpzk1vncN3mEgw1zdTJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661009; bh=AnGCYFI8SzDwa39fZ9B8jHttlsUvrIHAqnVx9x86+7w=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=gDWuC/b0+V/kO7pZ1DMzsaGOJEfIPZWmoQcixUD2OPYCfFWlgNEEPZek9mLq2tNNsGimroCNn5U1+0Gmf2M7GSw3GKeJwZtjlt5xSNL+8dk7FJ9mosOlHYo+FwGWwgRdIBMaLHuxGoaL/o+ffFXQAv5hFx1x9oclYghDApX8/Y1WNVvKPXnmWKTH0cKkIQDLqEFWBquvnHPILtyQ9VNgdwTTGQLOS5Amfby8ok5cCC1XauSyFMPkIe8+dKiqw/HgdxIqH4Y+ojgC/M55JlfyXL+hmk/KEbvVh6N4pN3Pmm+orPaqZlyv3tVk9eDl/Y6vVq+q1iU7oHlJJ29w1DRw4w==
X-YMail-OSG: dFR66FYVM1kxOPIaHMD1oorHsDUU8c4OPQGA.Tc3OU7mqIbJsIrbqzwXncBSceD
 hWAN3C5CJjtPQC6ecKjpj_D2yEhnSyNZ8uPm8E7Kg_hUNcE1v.r97Vu6RY5BYopGoSyplfMlEGIw
 .MCddAtPgfpCiRYHHOerz9Z3aLcxOTMsbWcuIV8NeOfQ9RqNffGNBV5hAX2jlycJhWxcCycbUC3j
 Eidog9ncpiApOIALyUj1AM3lPfJTeNcpg0slpP6RAyYoaC7OoMyyNyz18nEWbpXm9Qe7vNYlMiYh
 zkpgmeIheuOLNHCJkToCsaoYAumfw5fCz0crQbdHtZzIqDu9qoT9P2LPo_VURKQhzgltzd8uqjQf
 s.rrpFNNlM7XvoLl4_Fv6weunvXLIw1QSbEXEBU0qNXG4tJPAxfc4jpno4JdEiniMuWjv14ai9p5
 hgbPJUITOVEGRSxYvgcRt7bAgkQWGcHLXgVo93x7VZq4mP1UCGEksNcvVeOtmlgBFSJ3D.OyJtTv
 iySUxELqlU7Ml1wJ_vSv7EXO1ydRhq1woPZXUjzjdjbdCppJrID8GokZKgQO.g6P2AaPO4UksNv5
 ExwNPkdl_v1eZbeNl4CxYDxL7YjFT4T0k.336knYUSEk0tPtc6gtXNazxDG2A3JCPFwL21ZYCo5m
 w_OFBme5j8XqEKRVY7ki3NQjrIv2Ji04Nv2G9ZCdsQ24ynrS7wUt7572.JN4JrQTA2nuMilOEX1S
 VEgAdXtzY1pF8lqr84fMQF_.rLoRfgpPxDjt7POPByJG4kLh0Emt7UJ4daiBeNRusn.oIrUx.Nsp
 tSSnM3n1oOOBD_u73OPL6DzAJS7q0LhgsVfR0van.OiqJGq17PrCW_ueFXokHIQOrSWfOUcdyrLQ
 8RsLhv.rOsapTmeBmONTtEnZdcRKJEU7HKy.WnrMOz1kaN1X1bQQ.vfSYvEt9yp6LLEiLuLYF0nP
 kpLyBBtn7K44qRK4KzjAKvjtULJeO_m_pIQFFO9nYi9ETK9pV..YYzxiyFKV07dhZHRRDfd6YfJV
 Cis_wKkq3.ov3fvI53ZK8Y7yImKsQ1OH7bBKnd_6vVYnYdAhcR3abbNHCIqp4Ka5L0QS89nrMTKs
 ux.88jEk0g1Gj0hBn582KeBbF0O0XsH7OVwC1XPoP4Aj10rCO3k2pxgZ6LLqCrWM7mO6urImi9Iy
 X1sEhUQcQMjqc3SlJoCvA0FEb.ldBmgQdSAy3XdAY1sa_uha2enHeMJcklW8E2KkfTgvKbf3ZqBj
 vAfXj3DmVP8uOniZ8Nfxyyb43ygQUeNLoQpxSM9q.8W3k4UMpZrVc5pBnd6ngeu_csMvnW5LNrkU
 ffkIZAgyr077P1z9l46tacY3qPnqX.ueN1JR1zmBDveHTmB8ELD7i.M_VbA0HZjz4SJc86XjfOQC
 Xa2LseFYO_OOQji9.DCsr7snRJVRjOvG1XLfdUXQz3u9AJJpqL3FLstFe6r5cJpbQe0Fa4IaZ5K0
 Z3LGlgGNsjzRKn3wBXNxeMK7e6SgMpJj4sLZfMh5rkqoPyNesBPjhJ42TvOS03KT_5LjHP5R8VyK
 6S95cFFQ58W7ZfQOGSDv7Gwhz8VA4VPHuDcUX8doD1mRPILGsYG_MWJDewt0M7N0WtmTF8muAvM9
 X7bdD.8tAbeLbHRSzW16rnNt61w09F0xXn5xHikkV8IIcnkZ7Gg8kjFlQTwhNZbu1.CChkO_qjL8
 aAznMyCDyhHcBxeOCsOyxuK9_ywDWfXkRyTjEGvycuBW2NU3UMVSkYf3hRaR3Mg3QoZRMFF10Uj3
 _cdRm.xd3e7f49q6akbL78iruNw8CTzGhlRjeQ.iNY9oNtMEzkqQ0OFUFqytdmu4V3HME_S_t1X8
 9PbNuGdpy.WGn.RO4ZU93lW6cBWjBPhda7IB5l44qtL6evTJhTVUZisY7IKYnrc.HHSRonCrovUD
 e5aNZVS6ZgG1477JEj4aspXRWnnyNnfuooCzIOpz1qZ26SW0WN_Xv0CSA6s08KKRqxqGuvzo3q3I
 6_hTXRKy2VSuEnQF.PdF1cVVFxFPH7AnEZ0j9zWMLfKmmtZu53Mhi4k3EQZQPx.GT4izNx5RTTDB
 7jTvYKSlQYAsoyqeQLzin5mI4yM2x24J37HvX50WePGEa32MuXRcjVW6C1XRkG9K2BsjcBnLzOF7
 SIV7oj5lrqvzHzvQVUTG__FOpNfLa6C9ZcOq3iegOmfiynqO0t9dOcg3IJoLtmExG0XSlCjy9XbM
 lj8GbmZpdKmRl7uXtXlikoWR3bct04BOwIqODGgpug.ryTLlo7tZdyXD5Canry7MxTUxnyVkcOCO
 owXmBj9zsZgJycJBVZRhE60JgCEB5JaUdd8Ccl1o-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: d6363499-9376-430e-affb-d7b1506ec0e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:36:49 +0000
Received: by hermes--production-ir2-5dd9bf4598-bbdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 70b06eb4eb840b21612872ae4bbea301;
          Sat, 10 Oct 2026 19:36:47 +0000 (UTC)
Message-ID: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Date: Sat, 10 Oct 2026 21:36:45 +0200
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
Subject: [PATCH net-next v3 0/9] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728.ref@yahoo.com>
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

Tested on TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII to ipq5018)
with bridge VLAN filtering and per-port PVIDs.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v3:
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
 drivers/net/dsa/realtek/rtl8365mb_main.c      | 603 ++++++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_vlan.c      | 342 ++++++++--
 4 files changed, 844 insertions(+), 117 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

