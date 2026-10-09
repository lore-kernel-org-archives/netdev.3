Received: from sonic305-20.consmr.mail.ne1.yahoo.com (sonic305-20.consmr.mail.ne1.yahoo.com [66.163.185.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9373D1AA6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522738; cv=none; b=HYX0ia7fkR/jMUabn9i9pZab7dANCIATsBIm3WvU9pS+tlrOFFGS7xN0oiMfhAJeg3vW+K3ToM6K+skqDoHh+7KNk2AbMVTCIfwcmxblehbYqeIvGmNICB39uvwLTNvjLRemRrHvBHA+yFAyzcrLF+4GwTx29vXDDjSJBBXUTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522738; c=relaxed/simple;
	bh=prRi1J/oFfoSjIEG7m6UE1NN9163bU02Tazi5DD3Htg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=m+YBIkg+q7kcjpyMIJlxd9GOAx4wEvu41c4/STmVHyfqcYXJPqeHVEd4oES32iaEZ9I4q+poF9kZyIDspzQyR1XM4NhoDivCt0t4XQ3E2uRaSY6VcLOVGjIXyTRWUcDeaNarlGZ0wThhOS8RgAgJSp0gpa7xacPoPolyoFV/ZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BF/zzNmG; arc=none smtp.client-ip=66.163.185.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BF/zzNmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522736; bh=MwIGqkIReRqsobJZ6pfKU32ZH9+cdTqFh9ppZfFfdOk=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=BF/zzNmGGeoD69EDANj2QDxl290cxCh2CKpDYIZp1KE5u3LtXJTAJ+gnvVwKcjTEqqE3Hz7A3VWUXbuVe2Bc08IDJ6iJE2ed8MGrf694yplc+0QXWKRJc0HaIKJ3cSQBgits0N0C51lkerTkJry+kdvD48gh8td/GCTCi5yr5Zfjvub1OL81xGmQtVJPAm86OtRYrQ7dfuVE2fTNWcBHOkxID+14FSN6d9Esp+yn5S+h2oyvKYbwAZbnqxxzn1ZU+rg/cJH709hRDJIh7TxYESF2Q1jEUv2Y6+Fc5Zo10p+x6/yRN8a7KCrTbbORT/3ITG93icWFQgRZebVPz/jMrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522736; bh=tC53u2iZ4c24h04V2cFAjse6je8St6Hza8lB5cRUman=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=Xkr5k3uTOEbd5+ezJAvP3ElL9OBpsdwcm7k8AGu9+LFzwzKqK32A32nS1wqvi/a9GhNK75uuHlAmkhDVnnWDcJDAnIlL4iewRW1M8H+9qj5YyugOihHZr+RqQnqd/1yhxPdglmSynxD0PryM8zOPC9tJAPDPDpppY7mb9wcN5tWxGhICkvnj75PxPIvAdQwPqI4JLi5V1UxM4Jhx54gvtnjsz/ibbB5fxJoJ6VRo3/8TA79ip9GCmbH8S1qq3aB7soLcipstMjQJS4Ay1ibvLpUcOrFQxPOx762FwdVgooANaCGq9ym2hoQY6vSY2FQsRAulThaIkacmF5uTPNbkAg==
X-YMail-OSG: KroRkc4VM1nzeo7tJ8SB_uqjMDSyfCf.xqZI3fSXGBSaPfjXFynTHmlcQk807R8
 d179aLUWapB6vbzvOjeDX0B2AY7Tswn1PT.ZVrEtJHGpzeasuzO_D3DWeC0MPaDRO4EQ5FL60lHd
 sSjcb8w1z1oq5K4cBMeKMJR08A6mHwFwLh7v5R1ixzZ_isqm.2u4cdvjz8hPIvxixE6QRQ1x4x2k
 CB_ues6u3bEyPz9khID3TVQH3kIAdC4Zg6WwwG0i5MZuy2dikbAK9ZE7Ho4ZsmBStNgsBJ7QMmx6
 8M3PtzXOtUSnRv0c3PTX_yfieB4.UPJ4ajp2zlE2tVrWWENg2YwUCuXf1Nc7V_21sspVPmsA2dLg
 O_NAdfd1gF_2IK3jV7a3Y4VlPVI8AjoGZBRtkZYGzgtUvrJ6AmuBs9hEccLjRYUVhXLP6XpnI8YH
 Q99ia0H9Tip.FFJAIOicZAZ.xyVbZgE2ySCPwQZ7AIqjkcQfreeVAESmbdfKAocq_4Io2PUcN8lj
 uI9FEzRFZyoHg.N2DM2oDyAJOXhlkucUJaAMXjb1m4TSOIr.pD0SOxcaO1icYFv_tJ1PoSrZy1_y
 ywt1IwHCZGOxSnbS0HDkgfnyQV3Y7voqzlyiojdjdHxWoBMODfWMO5FIKLiPXErtKxnzeT2PcZ3_
 HTZX4epqMInG3hBWlvsmVEslzFo6pw86Mp5HyG.KmzgI6pMififVVOerz8Bs9Vn.17tCjT8aafF6
 3e3alXfciSe.A8YH2oCuYofrRkDUqLiRzZ.AqbQDftHjBZMSP5Ag71TyMfycHbaQlqxMsIM9d5tI
 LMk2YeKtTWbrDD1wIqj.3cNFsaPxcXaWmrmZGEW3mn69_rcjj0Hvu5cmKVN9.F93h_4Vh4qScTs5
 COAWxdQquD61M3XmzsYYEPLZfYIPsvEu1qpWE4joXlhHsrDtlVNlGVSwIawDM2DfFSbh0DYKOcku
 Oa.ZBaYzncWPpXfAl4RVrkzBA6YDNIqTz4TDfEvS9gYUwgfIhpPBnCjpKkibGl1G7hgX4IRK0u6K
 l0C7_rcj7PUzT2Jp41DYbm7PspYwG4APjXEINS8Ggrz4kWGsHCdaLTMQOjV7MWSplT5v5.lmDweM
 qiC3i7Yzf3PdCxttDUdynimh_dFNahse8lqhCqMqmxIMpoXYHHDBZxezGhbqvWwiOBC7WhlHTuSm
 b7HvVCYfdYj__yWj._iXa_xB_605mbJ2xxQIxIieWWPf1LaRC_nOg0J4RdnLidF8KkjR2DT5CS8R
 GVNgcnQQ6oFo16xKIezJMQXxkxLq6plnZZDVqbIPsird6kQCVoyWoPND.J52CTviCcdpmbo_82Ha
 21H6.QzH9_gF6k4aeay8ExDXXA6Kx.a8kwc965QPZhLmaiZs.J21NdjHX3lymUOs1H0spFeRk8NQ
 HC5B2p1whlli7_2gDkgulJB7yuVJI8xen6n9VCS0nxquDND4gmSeJA6PhCCQxXEw.uGzn2KIdtgU
 WYjj_yZbzJehS3OPgpMUWI.DWEBv7GiBloBMeQXHA79MwaU8w67a6lZ5gOjCZvBr2rzqJLCoN9kk
 GTtqK4Owylv6dNSQhr9WQiZSTlKhpXK6cBu1KBJxS0PQl_.Vm4hxIsZVLYewGrUmPJYQPUOG1oZk
 xTzclRF.WkviPCKDVPEn0pmdoqP9igzICAiRc4OYa9K1SZnVxmQT_5.FOUaFuFW4Y_fZxIbg2IXy
 5bF5wwPdVSx0MofOIYczKoLiQE762YDimodzmXJBk7fuyXbkU53B.4562UftniQTTKaRiucYH1Vh
 KAR909dSr1DRVf8EsnY3tIkE3bv.rR3Kp_1LznyM6wvkBz8VleT_pOox_FjaAXr_sQnU._9y8Wgj
 4rtXpUdSEcbHHW7xfgKV7ZnZxl4a5KMe70z_9N9bLPOQfGPNf3F2RbTFOKTiz3zLH9e5vmMOon2i
 NHBPQ40_butlAfjs5Xs_spXj0zINwrerZV0l6nQXovZDua2K3m4APN8nwvbLmdt7sRrj1fxa0OOg
 xjQtndaW4JPl22.rYD9v0QiB.icCeeJXQryvPFJduxlnVIdBCbvo20KGQPkJ4zghp3oXVhf8NEuD
 PYP445597cstyiOFu69lNFAQsp.vq9zmRSI1ZWiNp.vIAX6VQZLp_9PrXDDp4nnnsRVCISDgj0N4
 Z1yCrhUm0euFXSi4kkwhpDNhiTGrSZIjDcfX66GcPq3Fo7eocHaegB80ItCgbC2d.iF_HLbokfku
 LCvleYD1I2K6wzbqc6Dyg_v4hZAzFfpPVmUB8CYdlPIzQkMGqq.hIb9GMrJ5XHAlul6w3a3rSmHD
 0ydrYffCEocLzoY9493efe4pLF1EpaTJomQ9CdSEo9Co-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a6041476-afb6-4d53-9c7a-5352afd66818
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:12:16 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a54c59b562274ccda4c00a304aeb8e06;
          Fri, 09 Oct 2026 04:51:34 +0000 (UTC)
Message-ID: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
Date: Fri, 9 Oct 2026 06:51:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next v2 0/8] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <28382f3f-03c1-4606-9b11-86f118abeafe.ref@yahoo.com>
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN table layout, speed/RGMII configuration
and SerDes (SDS13) handling.

Patch 1 detects the chip and introduces the family D branch.
Patches 2-4 add port speed, PVID read and RGMII mode configuration.
Patches 5-6 add VLAN 4k table access and PVID set/clear.
Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.

Family C's functional behaviour is unchanged. The only change in a
shared path is a mutex serializing SerDes register access, added in
patch 8.

Tested on TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII to ipq5018)
with bridge VLAN filtering and per-port PVIDs.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v2:
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

Mieczyslaw Nalewaj (8):
  net: dsa: realtek: rtl8365mb: detect RTL8367S-VB
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: get pvid for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: set/clear pvid for family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

 drivers/net/dsa/realtek/rtl8365mb.h      |  14 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 555 ++++++++++++++++++++---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 304 ++++++++++---
 3 files changed, 761 insertions(+), 112 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

