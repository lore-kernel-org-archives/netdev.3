Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289933;
	b=zpcrCk8GMirZjT9fDM+HMPWl6Z2vGaF8mvV8KiIrjBaiPEqNAySh3E8IlfLMY1R+XG59
	 lfl5b+LNR4zbgxFi9D0D9wiXLmdmqXrd1oXQSiOTji9BIZ22KpeDipDvt1kMfYT/1xPc0
	 MPRmime4OTZXo1YxeOZNdy0G0sE2oviasNPAFlBJOXx9uy9vh5Wr92qHC5HLyJ65DNImx
	 MGrMLlVaj5Imj1S0NyfQ2cgqSxHCeSTg42Ccm8bbuGTLqjJarf/8FiHSo7cHj9k0d9dSn
	 4IhI/i+CO9AqCUAO0K0qgpA0M9nsguApmFxHjf+FCVGJreEL8TwNRydr509jIfDE/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289933;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MIME-Autoconverted;
	bh=4JZAEtYqPFrwC/8qAirNEgHSzMtDW3/O5Apnst+Mdk8=;
	b=YupcjnPBoDRHMyfKZEkx/TlDikcq5BIDOOJN0xV7dsHcNa3S718Pbw+5lhTlsV4cVpPM
	 O3BKrQZ5LW459IBizY+2sRE69g8EOoAWUpImz4bc+5YL0kU+lxo+OHkMUBSqhQbBS719u
	 ENjYfEe6nq8W42s8veJHaJBzInz00cirSW61074ASGWl4E6vmbCuwz7xOFQRwnzzKbYCN
	 hIq9H5eptD9xLidpS90kMi6QDucRyncGp63VwLxXQi8Dwyq0OhjTTm49+vGLPUm6lN/MJ
	 kwj7y6eI4WnVnMURuJi0dHl1j4lrP5wX3LNbH1bu3YnJ7x1HuIKE0C7HDl+kyF6B2bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=c127.dev;
	spf=pass smtp.mailfrom=c127.dev;
	dkim=pass header.d=c127.dev header.i=@c127.dev header.a=rsa-sha256 header.s=purelymail3 header.b=bjIABIrG;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=BXnCPBwS;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B5606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D7B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=c127.dev header.i=@c127.dev header.a=rsa-sha256 header.s=purelymail3 header.b=bjIABIrG;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=BXnCPBwS
DKIM-Signature: a=rsa-sha256; b=bjIABIrGKK6lXPOCsOrXraQ3IRlEgp7dZSpQPQVVFgYU7xc983rhMYQUYs1oEivRD2BU8x6PUnqF/C7KygmlOvjfQMPjYryLgDFEuhTMF7rVj23l8Qh5Ajs+u0JAaiSVTT1tqmnqA3PJn0A+eAFG9A5uFtFGgHo7S3LU58lq4BVYAQwq+6eu2bhL4b9wgBa/uU7sSbrB8QutKOe7eUhA0V4+rgXDKJ9g35iClV5o4SwjkuRg4ikJFkSdkdVw3TKa+vbdNZ+O54QyTL/dcgroC1eCbvQkzfpHSc1ilbVP8OdmttLfQO84hbkws/zxJmQmL8jGBi2imzVzWxW9SU2XLg==; s=purelymail3; d=c127.dev; v=1; bh=K96Fskd4Fd0L1SPd3ZPv0ae4Ff7EzA/lbaX3fURV3dY=; h=Received:From:To:Subject:Date:Message-ID;
DKIM-Signature: a=rsa-sha256; b=BXnCPBwSQbaYXyWxWkc6WLJ8O4CVk0zsYmSw5HuJATvbdANo31RuyKtwMDFxFKIsJwZATCTWcmOHhMvT/YI/NUnVSa8XAAQPx4+rNSFMaSfOfWg2BlN2u/soIKX7p3RTWWiNJeQs9un42NmjsilqwO8PRB05ihejKzRfD1ViSL0AlQwiyb9pmC2/ASgXqWNspHO3/4JcoKcUaPpL/EDWqApUInovfzB1p+pL9fO0ZoHuCOObdyDVn28y3Ie7XGc5z7nEMpFjLY04ZHHbW3BVRhBxRFKHKtiu1/d+82paPJYi8zRaQ/wPMsFcZ+XXNMrprg8W6GLkoY/1kEZ7Ycts+w==; s=purelymail3; d=purelymail.com; v=1; bh=K96Fskd4Fd0L1SPd3ZPv0ae4Ff7EzA/lbaX3fURV3dY=; h=Feedback-ID:Received:From:To:Subject:Date:Message-ID;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -969220285;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Nov 2026 05:51:33 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>, alvin.sipraga@analog.com
Cc: gabonpivovich@gmail.com, linusw@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gusfmora@gmail.com, kuncy7@gmail.com, fabianotassotti@gmail.com
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
Date: Tue, 10 Nov 2026 00:49:04 -0500
Message-ID: <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev>
In-Reply-To: <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com>
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com> <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com> <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev> <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Mieczyslaw, Alvin, Oleg,

Thanks for holding off. I could reproduce the symptom here and I'm now
fairly sure the cause is on the SoC side, not in rtl8365mb.

Setup: Mercusys MR80X v2 (IPQ5018 + RTL8367S, family C), CPU port 6 at
2500base-x, booting from NAND with a real config in a reboot loop. A
boot counts as broken when CPU port receives nothing, or frames with FCS
errors, while both ends report 2.5Gbps/Full. Both flavours happen.

Results, same rtl8365mb code in all of them:
- OpenWrt 6.18 stack (stmmac dwmac-ipq5018 + the qca-uniphy PCS):
  18 of 51 boots broken.
- Older stack (qca-nss-dp + qca-ssdk, 6.12): 0 of 16.
- 6.18 stack, switch SerDes brought up only once the conduit is up
  (the OpenWrt ordering patch): 0 of 16.
- 6.18 stack, UNIPHY mode sequence moved to the GMAC probe, nothing
  changed in the switch driver: 0 of 32.

The bootloader hands the UNIPHY over in SGMII (1.25G line rate), and the
qca-uniphy PCS only programs it from pcs_config(), which on this board
runs at the first ndo_open of the conduit. The switch
brings its SerDes up in HSGMII at DSA setup, about two seconds earlier,
so its receiver trains against a transmitter at the wrong line rate.
I read the UNIPHY mode registers at probe and at each pcs_config() on
every boot: SGMII until the first open, SGMII+ after it, identical on
good and broken boots. About a third of the boots end up with a
receiver that does not recover when the far end later switches to
SGMII+.

Some checks that point at the switch receiver, not at the MAC/PCS:
- Broken boot: A full UNIPHY re-sequence on the SoC side does not cure
  it. Unbinding and binding the switch driver cures it every time.
- Switch SerDes brought up against an already programmed UNIPHY: 21 of
  21 good, even with a UNIPHY PLL reset one second later. The PLL
  reset on a settled link is harmless (12 of 12), so I don't think the
  10 s health check in patch 8 covers a real case.

So the "far end not up yet" in the commit message is, at least on this
SoC, "far end up at the wrong line rate". Once the far end is in the
right mode before the switch comes up, the receiver latches on the first
try and nothing needs to be re-latched. The two second gap in the
reported timeline (5.27 switch pcs_config, 7.72 eth0 configuring) is the
same window I see.

This is a family C board and I can't say whether the family D receiver
behaves the same. But the reported log is the same SoC with the same
OpenWrt stack, so the wrong-mode far end is present in that setup too.
Oleg, could you check this on the AX55 before the first ifup of the
conduit? A single register read tells:

  devmem 0x98218    # UNIPHY MISC2: 0x70 =3D SGMII, 0x50 =3D SGMII+

If it reads 0x70 there, patch 8 is working around the same thing.

The fix on the SoC side is one commit in the OpenWrt PCS driver, about
50 lines: run the mode sequence at GMAC probe, before the switch
probes. Rebased on current OpenWrt main, so it should apply to the
AX55 tree as is:

  https://github.com/c127dev/openwrt/commit/50e49862d2ba1abd0c93b64403c776a=
f200323fb

Oleg, if the AX55 can take it, a reboot loop with that commit and
without patch 8 would settle this. I'll open the OpenWrt PR once that
is confirmed.

Neither dwmac-ipq5018 nor pcs-qca-uniphy is in mainline, so none of
this can be reproduced on a mainline kernel. That's why I'd rather not
have the workqueue, the extra locks and the reboot notifier in
rtl8365mb for it.

Best regards,
Johan Alvarado
