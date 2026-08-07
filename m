Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7D34E74D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128538; cv=pass; b=hCBMAe9pdOjQ/MWF5wVJ6pIyb6jjhvAq4I5fkLKekbZL21gHxhjmgsOsi9jQO4GC7IkKq/SNoFwfGP1os5Kfog4v6uakXSEre5f4m7F3yCbeyB5zuARJQOzGd/0OQaR5xEmjjYXM6inOdPkskr3S2ASZb+b89icwKxbKH/e6b+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128538; c=relaxed/simple;
	bh=K/AYQ0slGtGh2aGVAcbd5Ml309uD9bp7iupPakzq76U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX+0RL4D8u3vHCAgyp7bRTelKIjiB1ptdM5rr0U4t7Dlw+3lwpEsPLI2PQL2+46op3A3XiKC8Tqk5ePoenaZZLxQv+pQsZNG/l7Bw1AltraU0hTnS+j6FeHvKi5qjWMDKglh8TaVzYKA1hxswFks0NQDaa061YoimrTUWYQF9F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMhAf9U6; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMhAf9U6"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-977fca41f52so1229079241.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786128536; cv=none;
        d=google.com; s=arc-20260327;
        b=iTLhg20LaDsu2Xckws9nFPn0LKxH4C+64emjBiFsXLZ7K+v0mwDbGpLe8/nddkZLut
         zWQG8UqEld79sK3oHygoKFxgihP82rpJ2usA6LHKGz+uVavo0zZ5w7Hy1JpDrE4JTnzd
         qTEq8bJtKqLseb4Y1l6SN33ELyDTRSGBDnvWCOFZN9Cs6KpO9JCXzQHtDZ900eO1YCOU
         TxeuM48RTvyJzGBfCthNzm27x03OXvv4FtQI6N7D+1k40mCCZbCgoyd/gfOf2/nIvaTD
         kEkQbdHc7SzyQjpmcCxRUgWiMKntQRxlBNCZV5fv5M+maBjo9duFsoxoBshgKd0BYxU+
         U4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQbEMAEah3Uz8h1TWdBCzAeaWUqz5MbVi1G2fYGojfc=;
        fh=CPipSGvTyhll6KEr+LsbLymGDrprXKbw5w8ytHYsz5Y=;
        b=H+G1PeLuKks/MNnQBNrWFTRZrwNalxEIiTVs3bhgWAW0s8l+7joMxmjHPWNdrFP6B1
         aU/cwczCENxOzZ3sb3mT0qhTEqAMaHnIG1OQu0qOfLyS27nH3KUd1qHYeKZaeS628YSK
         0j/ijg78vaxbsUAwV1rqolU/PgMgtInL9zXIv7flQqbTBnNk8eiLzfxwS4z/2HjH3fEA
         RhEUiFhYSdcnzASVZ9CHdbwyzlpZXIPEEuEPB1pKN2OwXKIs9xt5i6vuy2pXMbAZ//xU
         RmP0e2aGbxAj+af4harWw4XPZPLW7bjCMAX7DWjw2NKbv8Xgch9qBC7hwMdZ0iAb56pF
         +iUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786128536; x=1786733336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KQbEMAEah3Uz8h1TWdBCzAeaWUqz5MbVi1G2fYGojfc=;
        b=JMhAf9U6dfKednfqd8dtBUk7canj9LAv/awGpDra4tmFHbTMPNxvWLr/DfJrtG8c97
         9hJVeN/TeZyWUTCIuV4DzT24pirlbAMO/6d8LUUcbTE9+CYJPFNGg1xbXIioOU+s9ivj
         6bGpOZkeqm5/IUdN8B1ppTs6+LHS1etEvWyTW29++Dnp5n+aSsJ5pyATaWiV6n78hTu/
         YahRabBsWrv+w5ZXW0J9Ihb/iTBVpgb68gfubkVhRkBwZ/X62EsJRJAh5M9HJqONTCtl
         oTArV8811sAguAjw2X8utuSMXJjRog8tEJk1fSp0tHgQk9fC/yV+xGrrin3qMktPmV46
         jSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128536; x=1786733336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQbEMAEah3Uz8h1TWdBCzAeaWUqz5MbVi1G2fYGojfc=;
        b=hgqDy/sL3fS8Z4wrmKlKKhc/K1/CGuZAG1CPvq6lc/69GmtgsCF8opVJ04XZTl1A4M
         0oyj3KqR3/wQtVo1Re4QXQtrMJD+4ZIROBrAmvkxZ8j6M0IF9lnlxND4gPobEdQvL1IT
         WP/Kn+occJoCYeAi2ryQ+Gis0QqpOrERf0Q7M7/Gm8npp96PqI/YFn9U9ZX8ffplQUBw
         nwxVydKJbP8iqAl5aoKqjgx75EKCY/PaoDPPC/71DGdi3uHM+gAsZnuzAxyU5pQ6ppwc
         shPs/nM/MTb7VACRaYN1XOh/dCapQ5y9KbCT6utlLWK/y+LRa/NWjDULAnfvf2/pKO5r
         byHQ==
X-Forwarded-Encrypted: i=1; AHgh+RraSh5o+jl+OmgWjy2g52hS8M9mrHbHVTFvinnA1VuL10peFD4NaLK6pm2OQ9pOmHZb07IRZQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGI5RlC+Oh+AgTBzXbxXG4PFyydv3DlTF8eCBXLRU9wTaNtbE
	ZQ42MZmHezEIGTKfAILtCn/udsJrBiqRqJ2qWrHG5lvhb8gk8XaZtwx3XWT7e27KsP+p5y4c7PE
	lI+Em30qLYUmMZi0pG6LWwlAWrFJ87lo=
X-Gm-Gg: AR+sD10p+fkJmgtOY9RccEgPMUcYhX4WR/B+r2xXA6RUi5B+HzPx1v3uiEIXF8kqGfq
	9sZoHBuBsfzxyQCFlO9lzaCAHOv+VmrGtsd6zm7J+ZuX+qnmJMOwk73O48D0xVwqUkPVWivB0l7
	QwL9QNZFFVjHbpyCl2wCoeqqeU3A+FVPEGncN44UykIj2sWqocANJvya9JJBhHpWe16TPWW1Y6S
	SP6n+nyxfYxNdYLSm2Axy1k+A0h306+Z39xjKUiGqdAihP+V8UtR3a5Czbkb3AxjK1Sf8D5RPnw
	A9okYUPPnFB+Sm0LkFqkKVeWSDPSbsV67wLV3rY5b7ZiT9U7OTD7K3zmA6Ch/yJCbm2CjmK8YV7
	OqaFxs3DtnQ8pcXXnuVl2O28F1Zpgxvp2Dg/Lpaoc9xIpB6r4fwEhQoOquQOm0Jm2ZXnOg48USs
	Nh6tI9EFhuPoao+GpRMpC796pyeeiuGnBWWos9mdwllLi/pSc=
X-Received: by 2002:a05:6102:41a1:b0:73e:9fae:5845 with SMTP id
 ada2fe7eead31-764e1c5f6d2mr939262137.0.1786128535635; Fri, 07 Aug 2026
 11:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch> <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
 <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch>
In-Reply-To: <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 12:48:43 -0600
X-Gm-Features: AUfX_mzkWefaGr-yvRIWAT7-WpS4J20YFg4GvupbZl2AqZK75NjTjLSVgtv1IY8
Message-ID: <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I guess it can also be used like this for live dt modification:
>
> A guess is not good enough. Give us a concrete, in kernel use cases.

I searched the current tree for callers of the OF changeset and
overlay APIs and for OF reconfiguration notifiers. I did not find a
current in-tree path which adds or removes a child below an already
registered MDIO bus.

There are concrete existing kernel mechanisms and DT descriptions which
could become users. lan966x_pci already applies an embedded DT overlay
from a PCI driver, and the FPGA region code already coordinates
in-kernel overlay application and removal. Mainline also ships overlays
for TI J7 Ethernet expansion cards, NXP LS1028A QDS cards, and other
boards which add PHY nodes below existing MDIO controllers.

Those overlays are currently normally applied before Linux starts, so
they are not present-day live MDIO users. If an in-kernel line-card,
mezzanine, or FPGA manager applies one of these topologies after
detecting hardware, adding or removing the PHY children below the
persistent MDIO bus is exactly the operation this notifier supports.

Likewise, a driver which identifies a PHY or retimer package from an
EEPROM, NVMEM, or firmware and then enables the matching child nodes
would use the same mechanism. The kernel already uses OF changesets for
analogous late hardware selection in other subsystems.

> > AFAIU the patches other than the last one are still relevant regardless
> > since they are fixing a bunch of generic mdio safety issues in code tha=
t
> > has users since MDIO maps already change at runtime through non-OF
> > paths(i.e. SFP insertion/removal).
>
> Fixes are fine, but please word the commit message around real things
> that can happen in todays kernel. If it is a race condition, such bug
> reports often show the call stack of the two racing threads.

After auditing those paths, I would qualify that statement. SFP, AMD
XGBE, and Airoha all modify the MDIO map at runtime, but their known
paths use subsystem-local lifecycle ordering to serialize removal and
attachment. I do not currently have evidence of a reachable race in
those particular paths.

They do demonstrate that the MDIO map cannot be treated as immutable.
Its safety currently depends on every producer and consumer arranging
compatible external serialization, while the MDIO APIs neither express
nor enforce that lifetime contract.

I found more concrete current interleavings elsewhere. For example,
PXA168 can scan and attach from ndo_open while its remove path
unregisters and frees the MDIO bus before unregistering the netdev.
BCM SF2 looks up and removes PHYs belonging to another MDIO provider and
can observe that provider while registration and OF population are
still in progress. GENET ACPI and Davinci also cross lookup, reference,
and attachment lifetime boundaries.

> Do you have a board with an SFP cage? Can you test your change.

I do not currently have an SFP-capable board.

>
>    Andrew
