Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3C175A7B;
	Sat,  3 Oct 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021822; cv=none; b=fwT3HSs9pZKpv7ModF3PssIIeMswMWMGPs4wa66hy04sxJFPg+Gq4bmBsHhzGwYxLbg7uEe8sl7EEEAJmr5Y8fiN2DiQ2iFbXuJyfOkbILj+/g3NqaC/X8t2t/fkKJkAUEQVGT3/elcuzludNoLKJKELLuG1rEQAuIipROYnOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021822; c=relaxed/simple;
	bh=Jr3okiaE3RBJxV1oWQFpydhuwl5Od9qAR73o0ybtWXE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n/BlNpKhx+S8SLrewYy0Zf3GQmsL/t2GkucBCmaRRbB53MEWk3Z53X/5ruXyU+b42E/FcAfOV91bqbufuJHY4rVHwsd6i8R7vXscWZ0JaILmx+fltXNJW8BFbp89y8FY2wfyZOADZJOxgdwI4UKCjlMpWueebyOsnLU5fIm3iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=w/z5HQry; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="w/z5HQry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791021812; x=1791281012;
	bh=rLn/eEOE1WAFsXtM+d5FgbyY7J8QW9wsYSIgaUTcJnU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=w/z5HQrytrgNBz9s9HJNaONnnPFKGJpucG91QgpKU89g1r0kVNCaC1VETRpLqMU3O
	 TmfCRwNEyPARnB0BTmxF+/OA7VMXoFmZQX3YLVLrBUvmxGenKgmCVZAzr23rDFxBKO
	 mhOGde5MBg/NY1eXrZy6Qsr1bHPbOUOKh3UyN8JS/yH1wQ94YpSD7IN4fUVXaskD7V
	 ieW7/8VsOimcXCkJNK/vaKWZPZH1UlnmAubbHbAktc5d9Rxsa8k6EQoekMIAfPFPa4
	 aTr8x46q9AQZUnouanU/HQ9PQ1QqglLsb5mHRijWmeLq2QfrOWrgsR9qSVuefNBAd6
	 kgEaqIJnI6JXg==
Date: Sat, 03 Oct 2026 01:53:07 +0000
To: netdev@vger.kernel.org
From: iugfdin <iugfdin@proton.me>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net] r8169: avoid 2.5G EEE by default on RTL8125D rev.a
Message-ID: <1790992231470.a13eda14-d725-41c1-9022-7ade79b3c2bb.r8169-eee@proton.me>
Feedback-ID: 225708956:user:proton
X-Pm-Message-ID: 5432ebe235fe844bc2c1bc42329c09fa07708d59
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A reported RTL8125D rev.a (XID 688, PCI rev 0c) loses packets,
including gateway ICMP, when 2.5G EEE is active, without
reported NIC error counters increasing. It uses rtl8125d-1_0.0.7
firmware and a 2.5GbE switch. Disabling EEE on the unmodified
driver removes the observed loss while retaining 2.5Gbps.

Default this revision to advertising EEE only at the lower supported
speeds. Preserve 2.5G EEE capability and allow userspace to opt in
explicitly on compatible links; do not permanently mask it using
phy_disable_eee_mode(). Ordinary 2.5G link advertisement is unchanged.

Pass the matched chip entry into MDIO registration because D1, D2
and other chips share RTL_GIGA_MAC_VER_64. Change only the entry
matching XID 688, leaving the other revisions' policy unchanged.

Fixes: f75d1fbe7809 ("r8169: add support for RTL8125D")
Assisted-by: LLM
Signed-off-by: iugfdin <iugfdin@proton.me>
---
RFC because this is a conservative default-policy mitigation for one
reported card/switch combination, not a demonstrated LPI signaling fix.
Review of the scope and a feature-preserving root-cause fix is welcome.
The observations do not distinguish a NIC-side defect from a peer-side
defect or an interoperability problem between the two PHYs.

Hardware evidence:
  - Original r8169: EEE enabled-active at 2.5G, packet loss.
  - Original r8169, EEE off: 2.5G retained, no loss reported.
  - Earlier hard-mask candidate: EEE requested on but enabled-inactive,
    lower EEE advertisement, NetworkManager reports 2.5G, and the
    reporter says "no packet loss it seems".
  - This revision uses the same initial advertisement but preserves
    explicit opt-in. Its exact binary has not yet been tested on the
    affected NIC. No measured packet counts or duration are available.

The verified Realtek Windows 11 package 11.031.50 selects an EEE
ceiling of 1000 for generic RTL8125D and offers 2500 as a user setting.
That is an INF default, not an observation of this machine's Windows
EEE state. Realtek Linux r8125 9.018.00 allows 2.5G EEE; the reporter
has not checked whether EEE was active in the working vendor run.

Comparing the source did not identify a different standard EEE timer
or advertisement mapping. The vendor additionally clears MAC OCP E052
bit 0 and PHY OCP A442 bits 12/13 and A430 bit 15, with a conditional
PHY MCU patch handshake. Upstream does not explicitly perform those
clears, but the affected device's live values and firmware effects
are unknown. Could Realtek advise whether that initialization is
required on D1? Blindly copying undocumented writes would not establish
a repair.

Policy verification extracts actual chip dispatch, MDIO registration,
phylib helpers and C45 get/set/negotiation routines, with modeled MDIO
hardware. The hard restriction fails eight capability/opt-in checks;
this revision passes all 164. Ordinary 2.5G and other chip policies,
EEE off/on retention and explicit opt-in are covered. The two earlier
TX regression matrices also pass 85 and 102 checks. These tests do
not simulate physical LPI timing.

No Tested-by is asserted for this exact revision.

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index ae8ea0d8..ded31ead 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5425,7 +5425,8 @@ static int r8169_mdio_write_reg_c45(struct mii_bus *m=
ii_bus, int addr,
 =09return 0;
 }
=20
-static int r8169_mdio_register(struct rtl8169_private *tp)
+static int r8169_mdio_register(struct rtl8169_private *tp,
+=09=09=09       const struct rtl_chip_info *chip)
 {
 =09struct pci_dev *pdev =3D tp->pci_dev;
 =09struct mii_bus *new_bus;
@@ -5486,6 +5487,13 @@ static int r8169_mdio_register(struct rtl8169_privat=
e *tp)
 =09=09phy_disable_eee_mode(tp->phydev,
 =09=09=09=09     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
=20
+=09/* RTL8125D rev.a can lose packets with 2.5G EEE on some link
+=09 * partners. Leave it available for explicit opt-in.
+=09 */
+=09if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_64 && chip->val =3D=3D 0x68=
8)
+=09=09linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+=09=09=09=09   tp->phydev->advertising_eee);
+
 =09/* Keep EEE off but the version stays EEE-capable so that link-up
 =09 * still clears the MAC TX-LPI bits.
 =09 */
@@ -5796,7 +5804,7 @@ static int rtl_init_one(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
=20
 =09pci_set_drvdata(pdev, tp);
=20
-=09rc =3D r8169_mdio_register(tp);
+=09rc =3D r8169_mdio_register(tp, chip);
 =09if (rc)
 =09=09return rc;
=20

