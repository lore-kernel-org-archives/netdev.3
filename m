Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB121CC51;
	Sat, 18 Jul 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360206; cv=pass; b=s+8lErXtS3hYYvzuNWnXCfJqWWmQcBpCt8GfRlEQnhFlO/ufYPlXGuONe6RVYqWO4JeSyh16yOZ3NmBagLEu3ASHPSMMsMefBzfunkEanbJ6bBmaNZvYP+z7bMQev6flr8Sc8mChaXZx8hWGNsVk0dpoghiTSDcRAYwIk08mNvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360206; c=relaxed/simple;
	bh=w1w1hQb2DYGiJV9eme4ZWG1Sn4wyHmb3HO4zGqK9TTg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Y86l5NTU09Ing2D+oQyzYq2dS8Z1UhNFr3aJmK2YInqO0QU9SAGRgwqoMk8YKfAa38YgaIToT/nJ55jlJ5n2+uBLJCJpLv6Ju5aiI1/ecUUT9FbgY2HYOWOMBqzMwDanvl87UyqjPkcig99tsa9FmAhfonJZs74pHAaXX6GrQtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Kz59Pf5f; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=eYhhsw1X; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Kz59Pf5f";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="eYhhsw1X"
ARC-Seal: i=1; a=rsa-sha256; t=1784360145; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XnLp6kQafvvcrPtQSrUrPrJNApT6uBo2LHRnelxGeTA6JwujNWe02VI8DamIDk0ymO
    VS6GH+ZBOgpYi8J0RWzHxrIjwS7UwgtPXS6JcdH+SprdRersgKzSafpcN7ECaxXFBYqB
    ByxG/8/+N/LoSKYtYKYhpfwL4rs2an/yvXTe+jTPxjzWiJ8FGHLulhP+9h4L7jwMj1QX
    0tapS8MAfpAGEwTgpJLFBooV5UUWBcT06SyGahlN/A8PDu/hTpRWNgJfoE+hq0H8jDD/
    LXECvuTkmVSw3BMbWenxBj5oU75+C+JfrPyYfdVFuOGnmPhJxaddsk5ejuKtMFltsTdI
    mBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=UQURTbKAQMo2aRbfC3Eb5apJJuLsX8UgEeIW8HKLNUU0CZnE41zmYQDY2fh/g96hUV
    IZYeqUtPZj9AIKeTKrOwP8v6zeM4P9B3AYR5TqwSrQQBT3PB/p8nuWI6k4VtDd542Zn/
    el2pQzwziv68KHPCEHuXBf75/wH0BV9Ujb8HCN1+YwokMyeiiigkQMop8UiA4OX1sNHl
    2aw4E9v0OL/bDqBjuiVrIuOT2DtjTZdndawgNWgshkHoGFGzHL4ZbtrwVBqpLE27oV/L
    yA4UPDfU2sPvcQnxCAfaEagJr8KXpvkPSmxdn67ZLSFbh/9SNjDJ2JQslnThLh8thpYA
    kLkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=Kz59Pf5fw17gMvs35TbI1Kb6Qt4Oe6B4yGC4tuqMXGSw8CHLh/H4fKotbSsTzHNijL
    4nipaigkOWoygx8IOpbPcUUf8Q/OwwqnE8bN7Rac/HSThTxTYxBU8d5zLIyv6u96O1Ys
    wrXQ2fTv+IUyBnByD+p2Lxf/hZ8o1VQZ3p3NjkHkDGdRePQleAOpzlllh6yXQjJARQTy
    qPgmnrN/od+gJWUQJ2bQY8HY7mhvRubTj5BVUoiyuzYzU0TPKZpgMCbAU5XTbblguKcG
    kCBghQKOHcoiI+wvb6UkCLJnD50hSXRw7YgUJHaI580njBCJX9KUN44RACVogfJmGW24
    8ocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=eYhhsw1XzSlIip4reBkH1uEggHyh2HahxZ5PBmQY73W+u054FVCJwFJ0BRAl+qpkBU
    idf05c0mWWramUvB9wAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jns36WDHmkHWjM34E2akzSGSaC3yEQATR5mHs="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee26I7Zj18x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 18 Jul 2026 09:35:45 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net v3] net: dpaa: fix mode setting
Date: Sat, 18 Jul 2026 09:35:34 +0200
Message-Id: <A0ED8202-B2F7-4EDC-8BC5-0E89018111F2@xenosoft.de>
References: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
Cc: Michael Walle <mwalle@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abeni Paolo <pabeni@redhat.com>,
 Christian Zigotzky <info@xenosoft.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Trevor Dickinson <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 hypexed@yahoo.com.au
In-Reply-To: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
X-Mailer: iPhone Mail (23F84)

On  17 July 2026 at 11:11 am, Sean Anderson <sean.anderson@linux.dev> wrote:=


=EF=BB=BFOn 7/17/26 09:20, Michael Walle wrote:

---
I didn't grab Sean's Rb tag as this is somewhat different.
Changes in v3:
 - keep the mode setting also in .adjust_link().
 - reword the commit message, to be (hopefully) more precise
 - Link to v2: https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@ker=
nel.org/
Changes in v2:
 - the setting is/was based on the maximum speed, not the current
   speed. thus, move the setting into mac_config().
 - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@ker=
nel.org/
 .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/=
ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..b8d70c0ecb6c 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *co=
nfig, unsigned int mode,
 {
     struct mac_device *mac_dev =3D fman_config_to_mac(config);
     struct dtsec_regs __iomem *regs =3D mac_dev->fman_mac->regs;
-    u32 tmp;
+    u32 ecntrl, maccfg2;
+
+    maccfg2 =3D ioread32be(&regs->maccfg2);
+    maccfg2 &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
       switch (state->interface) {
     case PHY_INTERFACE_MODE_RMII:
-        tmp =3D DTSEC_ECNTRL_RMM;
+        ecntrl =3D DTSEC_ECNTRL_RMM;
+        maccfg2 |=3D MACCFG2_NIBBLE_MODE;
         break;
     case PHY_INTERFACE_MODE_RGMII:
     case PHY_INTERFACE_MODE_RGMII_ID:
     case PHY_INTERFACE_MODE_RGMII_RXID:
     case PHY_INTERFACE_MODE_RGMII_TXID:
-        tmp =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+        ecntrl =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+        maccfg2 |=3D MACCFG2_BYTE_MODE;
         break;
     case PHY_INTERFACE_MODE_SGMII:
     case PHY_INTERFACE_MODE_1000BASEX:
     case PHY_INTERFACE_MODE_2500BASEX:
-        tmp =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+        ecntrl =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+        maccfg2 |=3D MACCFG2_BYTE_MODE;
         break;
     default:
         dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
@@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *conf=
ig, unsigned int mode,
         return;
     }
 -    iowrite32be(tmp, &regs->ecntrl);
+    iowrite32be(ecntrl, &regs->ecntrl);
+    iowrite32be(maccfg2, &regs->maccfg2);
 }
   static void dtsec_link_up(struct phylink_config *config, struct phy_devic=
e *phy,

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

Christian, can you test this patch with ethernet at 100/1G speed if you stil=
l have
access to those P5020/P5040 boards?

- - -

Yes, I will test it as soon as possible.

- Christian=

