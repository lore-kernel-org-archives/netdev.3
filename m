Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0515366562
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788589346; cv=none; b=K4UYKEkHTDSq0ulsse46UGxeK7hlx/H8aMCs/kXHJGLGbvZH3Zoar7hbOzeF1h0c2GGl2ptmqo/wu9mKzeEYN7VkP3yBqajioFGQhcFWlLTtBzB4RVtowu5at2N1axHrgG2kAD/cMvq2YcRK4j2GBfR4ZM5JHX7PIhj7cfzix0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788589346; c=relaxed/simple;
	bh=5A2DXfLvOuztE0W8xwBhWwJAwffc3mOvguOK2Ayp/kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3ivQdoE2rWl5J02o/R4xvnSa8XQxizFPkWHTqPNpBR/istc9IO2s3PhezCNIkLNuYg+1Y22mRYuQbrTJLzKXnQJewzdrb1qn4t7CQS6U7WoFDGD1Ih63aX7Dgo15Cq6U6E9Ecsvbxsrkon6ZJfKzGzT5+6t3gxydEuYum2NDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3Dw0Bhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3Dw0Bhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A81F00ACF
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 06:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788589344;
	bh=5A2DXfLvOuztE0W8xwBhWwJAwffc3mOvguOK2Ayp/kI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H3Dw0BhvbgIDKrZ7WLMSQH8TkTOqZnCo7Xu79F7tLZHLeCti8E/CbnuZd6mPjAtuG
	 rygHtNfF/Aj7PNLTdZ1h5RSror8m9lQOgx0kVbekRPCNpeFcq0BnVhLtovqHqopJIk
	 7xc1NN3IoJ7slHk83Zyj2j+gSyosY/YHaRx+04bDIcBybNNmI8N92xy24b+ATU9eJv
	 rfNmmO2RmM/KMu58iQAMevYHR7Oqammr6+cD/3zR0b9o753R2mdvkxT/tLD39KYomR
	 ryvUfgOesgbGDUIgr1cCIGQeaC5wRcxJhuxqlIR4/rV6DMC1P9qJVvkQ+XnbSTFcCe
	 atARB/r89/l9A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b4af4be667so1714511e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 23:22:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBynf7aj3x5qkxqnbiatuemnoTIoLy7kJzI3l/7sNszOHRYTGlnFS4tr5nMGha0haRm/fd6Hj4k=@vger.kernel.org
X-Gm-Message-State: AFuF++kF4dyHxDpPyul6JqDmhpuQpIhXLBcIy/z11gSYG2x5yd6Y0X1g
	yyN08wdqaD6JBeaPjSbpDg2ivQu8M/Wc2E9bz4JW7QGMatunbFngvbJmgzJoGcbe+fc4VUBOp14
	dRf8rUiUjHCNeq3n8HuXcm6xJbnlo2W8=
X-Received: by 2002:a05:6512:3b0d:b0:5b6:183c:5c94 with SMTP id
 2adb3069b0e04-5b6183c5ecdmr1369894e87.50.1788589343322; Fri, 04 Sep 2026
 23:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
In-Reply-To: <20260904-ksz9897-sgmii-port-v5-1-9bd4a0381aa8@vaisala.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 08:22:11 +0200
X-Gmail-Original-Message-ID: <CAD++jL=2U-at=iDwkQ3yNfk97xQc1mGS3uSTRdheMYwT_7YGWw@mail.gmail.com>
X-Gm-Features: AcwNN1Ur2s0ncXM5BZAkSfX08tc-OATaVAVH71F_Mih3jw8yqeqp5DWO2pNSju4
Message-ID: <CAD++jL=2U-at=iDwkQ3yNfk97xQc1mGS3uSTRdheMYwT_7YGWw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tristram Ha <tristram.ha@microchip.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Jerry Ray <Jerry.Ray@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:03=E2=80=AFAM Tapio Reijonen
<tapio.reijonen@vaisala.com> wrote:

> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
> entry never set .sgmii_port. ksz_has_sgmii_port() is therefore false,
> ksz9477_pcs_create() is never called and ksz9477_phylink_mac_select_pcs()
> returns NULL for port 7, so a phy-mode =3D "sgmii" or "1000base-x" link o=
n
> that port cannot come up.
>
> Only the KSZ9897S has that port; the KSZ9897R has a second RGMII port
> instead. Both report chip ID 0x00989700, so the port cannot be enabled
> from the chip ID alone, and enabling it unconditionally breaks the
> KSZ9897R badly: ksz9477_setup() propagates the failure of
> xpcs_create_pcs_mdiodev() on a part without an XPCS, so the switch as a
> whole stops probing.
>
> The variants do differ in the read-only bit 7 of the port 7 XMII control
> 0 register, which reads one on the KSZ9897S and zero on the KSZ9897R.
> Compare the KSZ9897S data sheet DS00002394C section 5.2.4.1 with the
> KSZ9897R data sheet DS00002330D section 5.2.3.1.
>
> Read that bit in ksz_switch_register() and use it to select a KSZ9897S
> chip_data entry, which is the KSZ9897 one plus .sgmii_port =3D 7, with
> port 7 no longer marked as supporting MII, RMII and RGMII. On the
> KSZ9897S that port is permanently an SGMII port and only its
> differential pairs are brought out, so advertising the xMII modes on it
> would let phylink accept a mode the driver never programs:
> ksz_phylink_need_config() skips the XMII control registers for the SGMII
> port. The KSZ9477, which also has SGMII on port 7, is described the same
> way. See DS00002394C section 4.11.
>
> KSZ9897S_CHIP_ID selects that chip_data entry and nothing else.
> dev->chip_id keeps the KSZ9897 chip ID that both parts report, so no
> other chip ID comparison has to know about the variant,
> ksz_check_device_id() is unchanged, and a device tree naming the KSZ9897
> keeps matching whichever part is fitted. No binding change is needed and
> existing device trees keep working.
>
> Tested on a KSZ9897S with a 1000BASE-LX fibre SFP on port 7: bit 7 of
> the port 7 XMII control 0 register reads one, the switch is identified
> as a KSZ9897S and the PCS is created. The port advertises
> 1000baseX/Full, clause 37 in-band autonegotiation completes against the
> link partner, and the link comes up at 1Gbps/full duplex and passes
> traffic.
>
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
> Suggested-by: Jerry Ray <Jerry.Ray@microchip.com>
> Suggested-by: Tristram Ha <Tristram.Ha@microchip.com>
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

I think this approach looks good.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
