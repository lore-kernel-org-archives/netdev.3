Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.190.148.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944079;
	b=iXvmPMBw+4AexK/jK4La4EqjW8hslWT2+G2PFkAwkrnyOEX/9dcIbfBOJmH0BdmfQ/mw
	 uDDNG9k+7BImt0nt+MSyQjlgqWT8Ig4dkkQDkucL3H5QuLP+vNps3JgJSpQxr0KfZp6vW
	 EAul2HhCcHGa6r+Uduw+jVI1G33L+RFO+czEhU4ts8R52T6H6d/hSB+hQG2suJsa3r6qZ
	 hdpGIN9sphHfSC/+s9n4Zfw1bcTeIWg/CQ8umwQto8m7FUK6spPGXw6N1W35UucnihNc1
	 fN00A8m18dUdqLR+86hJWMDwQykaRc5a6xcHY0ngLsXlJNPLrSTLfPtMfY4xX2oQIlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944079;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5ff/g5VJO2BFNc3k44pYPtI7CiOZMDpxwK2zGNrDIUg=;
	b=iJJy0h7SZMYbTzH5j/uZ0AZioukaW8c7LCVypNQvRE8Jazme/tWQxrzDKrcig7Hyin/c
	 NcMTq/7kRIhgx6wHqNgeDeEpjK/On5O1D/JsORVv9EyeGbLKBzJNUIYFUPLr2JGZuiPYO
	 h9ENgtXA2xiroGNJQUg9jrlQLwn1w0C3A3yqBNQy1lVnCKev0djMOaLMxb3Rspx0TSy5r
	 YeQl/kj1TFKokCEep3zSPcfwCTOtlBl8kBYRyUfOj+GCFakTwuy9cvPq+rb7RtVdsdoIN
	 D/WC72TTPn9UlyQID+oCd9prTfcyv1D+1xVEcHxX4KfouYvFWe8vL1D+feE2OJ/8gMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=foundata.com;
	spf=pass smtp.mailfrom=foundata.com;
	arc=none smtp.remote-ip=195.190.148.227
Received: from hera.efm.de (hera.efm.de [195.190.148.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FC606A331;
	Fri,  6 Nov 2026 05:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112FC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foundata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundata.com
Received: from hera.efm.de (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTPS id 4BD58413304F4;
	Fri,  6 Nov 2026 06:47:56 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by hera.efm.de (Postfix) with ESMTP id 358BF414F1D79;
	Fri,  6 Nov 2026 06:47:56 +0100 (CET)
Received: from hera.efm.de ([IPv6:::1])
 by localhost (hera.efm.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id IT0rOaAAUZPt; Fri,  6 Nov 2026 06:47:56 +0100 (CET)
Received: from tpx13-pf5nr32.fritz.box (ip-037-209-109-094.um11.pools.vodafone-ip.de [37.209.109.94])
	(Authenticated sender: ah@foundata.com)
	by hera.efm.de (Postfix) with ESMTPSA id CDD7B413304F4;
	Fri,  6 Nov 2026 06:47:55 +0100 (CET)
From: Andreas Haerter <ah@foundata.com>
To: chandrashekar.devegowda@intel.com
Cc: haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	tim770802@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: mtk_t7xx: resume after power loss reported as success, modem stays dead
Date: Fri,  6 Nov 2026 06:46:27 +0100
Message-ID: <20261106054629.203092-1-ah@foundata.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

After system suspend the t7xx module on this machine can lose power and
not come back. The PCI core notices, but mtk_t7xx reports the resume as
successful and keeps its ports registered. Userspace is left with a
modem that exists and rejects every write, and only a reboot recovers
it.

I have seen this on 4 of at least 13 s2idle cycles, on Fedora's 7.2.5
to 7.2.15. Line numbers are from current mainline.

  Machine:  LENOVO 21RMCTO1WW (ThinkPad X13 Gen 6), AMD
  Module:   Rolling Wireless RW350R-GL, 14c3:4d75 (2099:3552)
  Firmware: 81601.0000.00.29.25.05_DT
  BIOS:     R32ET20W (1.03), and R32ET28W (1.11) for the latest one

From 7.2.15 on BIOS 1.11, on the first standby after the BIOS update:

  PM: suspend entry (s2idle)
  mtk_t7xx 0000:c3:00.0: Unable to change power state from D3hot to D0,
    device inaccessible
  PM: suspend exit
  mtk_t7xx 0000:c3:00.0: Write error on MBIM port, -19

The driver logs nothing else about it. Config space then reads all ff
(on 7.2.8 it still did seven minutes later), while /dev/wwan0mbim0 and
/dev/wwan0at0 stay present. Runtime PM is not involved: power/control
is "on" and power/runtime_suspended_time reads 0.

The root port 00:02.5 sees nothing either: SltSta shows PresDet-, and
LnkSta shows DLActive- and Train-, with 2.5GT/s x16 on a port that is
x1. So the link is down and the port is not training.
The ACPI power code for this slot (\_SB.PCI0.GPP7, P0WW) is identical
in both BIOS versions.

From the code, not traced:

1. __t7xx_pci_pm_resume() reads T7XX_PCIE_PM_RESUME_STATE at
   t7xx_pci.c:586. From an absent device that gives 0xffffffff, which
   matches none of the PM_RESUME_REG_STATE_* values.
2. It reaches the else-if at t7xx_pci.c:632, sends FSM_CMD_STOP and
   returns 0.
3. t7xx_port_send_skb() returns -ENODEV for MD_STATE_STOPPED
   (t7xx_port_proxy.c:345), which is the -19 above.
4. t7xx_port_wwan_md_state_notify() ignores every state except
   MD_STATE_READY, so the WWAN ports stay registered.

The next system suspend is then refused. On 7.2.5 two attempts each
hung for about 37 s until t7xx_pci_pm_suspend() returned -110, and
systemd-sleep gave up, leaving the machine awake.

Checking pci_device_is_present(), or for an all-ones read, before
acting on prev_state would make the failure visible. The L3 branch
handles power loss but needs the device back on the bus first. What
should the driver do here: fail the resume, or remove the WWAN ports so
userspace notices?

This looks separate from Tim JH Chen's series "fix DPMAIF data path vs
system PM suspend", but I have adjusted CC in case it overlaps.

Thanks,
Andreas

--=20
foundata GmbH
Steinh=C3=A4userstr. 20
76135 Karlsruhe

Web: https://foundata.com=20
Sitz der Gesellschaft: Karlsruhe
Registergericht: Amtsgericht Mannheim, HRB 714807
Gesch=C3=A4ftsf=C3=BChrung: Andreas Haerter
USt-IdNr.: DE284122682
