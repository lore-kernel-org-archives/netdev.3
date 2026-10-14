Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711F4CDDCA;
	Wed, 14 Oct 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968206; cv=none; b=TAOd1C2AIIKdm4Zm1J3/72RCWir/RR6A5nF0yhg/q2MS1t1ZYsLdkHg/ImfdSM0o/YlJA0V+uLuocFvXQ3Bzl3XfoOuLZJVkeYfFhx9Qtybk6zu0KMGgtTzcw9z3CpnBeXsrHksZy17gv84ag+QR0eBcnJ3QMwCyBIOv7dmGBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968206; c=relaxed/simple;
	bh=H0w0OG1vIHKv47bHpVo8UZ6a2SJ74I3y3c+BFMCMHFA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmxXXox7Hx+AO/jPKPhdXJNQSIs7Hh+X9HEBRBa2Jwnvl1jt6MLbp6DrqQRsGkKoTTMZg47l1Y3uK814eauLYoDX18MZmTI9NAQlNk1IM5ngDwaNgSvWv1+f3r8rsc7cX/3VANbdjXws6Ga/4sCYV1riQTLKbsVIwuAznQPkCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViFokWcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViFokWcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E261F00893;
	Wed, 14 Oct 2026 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968204;
	bh=rkzimy4u0HbdYF5TBexOZiQj2oOgraCKe2OWEa8q8rs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ViFokWclnMoovEx17DHVRsG5Xmc1xaY33l7T1r2jZk/7YCsMFdSlm1T6JqeyugJN8
	 CloeQJgIqxCE+086crxj9//IXbgpQa2+mGTjkzuDkA1mAYWxOuUk1Hoe7dYMzxY9Zw
	 tfc1vseElGNOdGcNwcmHaHSYQDz2sPQfD0iyr7QOdmWw0yjHKqnva4CL/zy6SPcbQD
	 zDGdd6hqmykt2BAF7xHrxbNmKNZREcECnTWMyJZJMLuzpKC15yOI6YphxptQsn0zux
	 tTM/C02t1ml8Eus7lm+cILDsU4F/t6ZQ8hUwgbj4vZ5U5xxfXy0TtuJM9HdDHin+A0
	 +AvFnG2S9NvHw==
Subject: Re: [PATCH net-next v5 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:56:43 +0000
Message-ID: <179196820369.434549.3311360668196397160@kernel.org>
In-Reply-To: <cf383ead-d169-4679-a4d0-028ea04d8a11@yahoo.com>
References: <cf383ead-d169-4679-a4d0-028ea04d8a11@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On family D, rtl8365mb_vlan_4k_write()
  (drivers/net/dsa/realtek/rtl8365mb_vlan.c) sets…

--

net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D

This commit gives family D its own two-word pack/unpack for CVLAN (VLAN 4K)
table entries, instead of reusing the three-word family C layout. It uses
a narrower 2-bit FID and drops the priority/meter fields. On write, it
forces both the IVL_EN and SVLAN_CHK_IVL_SVL bits to 1.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffadce926..c2cfdf194aa9e 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c

[ ... ]

> @@ -244,36 +290,61 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
>  	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_LO_MASK, vlan4k->untag);
>  	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, val);
>
> -	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, vlan4k->fid);

[ ... ]

> +	if (is_d) {
> +		/* The chip supports both IVL and SVL, but the caller (see
> +		 * rtl8365mb_vlan_4k_port_set()) never requests SVL, so both
> +		 * IVL/SVL selector bits are forced here rather than threaded
> +		 * through from vlan4k->ivl_en, which family C does honor.
> +		 * The vendor CVLAN API leaves SVLAN_CHK_IVL_SVL at 0, see the
> +		 * commit message.
> +		 */
> +		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
> +				      1) |
> +			   FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK,
> +				      1);

[Severity: Medium]
Should SVLAN_CHK_IVL_SVL be written as 1 in rtl8365mb_vlan_4k_write() on
family D?

The commit message says:

    The vendor RTL8367D CVLAN API leaves SVLAN_CHK_IVL_SVL
    at 0 and only sets it from the SVLAN member API; the value 1 has not been
    verified against the hardware with the bit cleared.

The reason given for forcing both bits is that the only caller always asks
for IVL:

drivers/net/dsa/realtek/rtl8365mb_vlan.c:rtl8365mb_vlan_4k_port_set() {
    ...
	vlan4k.ivl_en = true; /* always use Independent VLAN Learning */
    ...
}

That explains IVL_EN = 1, but does it explain the SVLAN bit? The vendor ties
that bit to SVLAN membership. This driver never configures SVLAN, and
RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK is the only SVLAN-related
symbol under drivers/net/dsa/realtek/.

Even so, every bridge VLAN add or delete on a family D port sets the bit to
1:

rtl8365mb_vlan_4k_port_add()/rtl8365mb_vlan_4k_port_del()
  -> rtl8365mb_vlan_4k_port_set()
    -> rtl8365mb_vlan_4k_write()

This also covers entries whose member set becomes empty after the last
port is removed.

rtl8365mb_vlan_4k_read() never decodes this bit, so the read-modify-write
in rtl8365mb_vlan_4k_port_set() can't preserve whatever value the hardware
had.

If the bit has any effect, for example on how S-tagged traffic follows this
CVLAN entry's IVL/SVL setting, could learning or forwarding for matching
VIDs differ from what the vendor code produces?

Would it be safer to follow the vendor CVLAN path here? That would mean
writing SVLAN_CHK_IVL_SVL as 0 and deriving IVL_EN from vlan4k->ivl_en.

A related point about IVL_EN: on family D, rtl8365mb_vlan_4k_write()
ignores vlan4k->ivl_en, but rtl8365mb_vlan_4k_read() decodes it:

> +		vlan4k->ivl_en =
> +			FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
> +				  data[1]);

That asymmetry only does no harm because the single caller sets
ivl_en = true.

The code is unchanged at the end of the series, so this behavior ships with
the RTL8367S-VB enablement in "net: dsa: realtek: rtl8365mb: add support
for RTL8367S-VB".

> +		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
> +				      vlan4k->fid);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4%40yahoo.com
