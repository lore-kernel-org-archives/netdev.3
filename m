Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53B258EE9;
	Tue, 11 Aug 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407276; cv=none; b=CuDIbbxPnEBGF9adiusEGiuFMU3UEFF29Z7UMpD6w6VeQhuTvtOeLlmGei+dnNT90FKNuuRrRPvHzUVjs+HtY1U6T15uwkOFph2mhV4OnMDqYCZy+osTWqpFw/pT8MrLwCUDqnBM9u1tnIBJqDAWkXK7CHhn98Pt8efB0qGd+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407276; c=relaxed/simple;
	bh=2BOV8mQNbjbWs2FioTo1BxQOBXqYMLOmtiDlJwQ2um0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ful1OPp7HTWIv0g6eFXOEWMUaTkLypQLW9ejXUzrAYCOq/M3kLpsN/HvuhkiwYBE6zxEqdEJ+sJUYq0hT1z5VGfnZ0H4EArNXgG4uQfwMKN/0wjCu07FOId2xCR42cS8GGeEdznizH7GKvLYpFPdYW0URJaG5kIKaXPk0FHNewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA7YnB/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA7YnB/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844181F000E9;
	Tue, 11 Aug 2026 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407274;
	bh=ggt0CUGiayoEYZMB/yqTBSEvLLSn8nTvLdMoXY55vBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PA7YnB/7+9qXGwMgYz9dwR1pmZ4IeNM4gMPpQXdP80ZIxBA6vYxYGIEEZ050PYtKY
	 iSmSsVAE5Z5k7BfAmVBL8+ocE+CKztJPwYb15VWcEiqLGX6GMGrmO+CsaDkdxId6A9
	 Gv8f69HQhKJ+t4bsrnUI9qiafatBTLPkOckff7MZa0hPJa9Nw17R+aulf1I/GRUpzb
	 lFcU57CHqOkAPjrx1pCs68VkBragkZHAX/vLYVeT4l9n1yZPx+fae5pNPT5lky2hAK
	 OVng9ijgoVgZxZyUbymba9+9Kg0ZkWSx38Ihmt+WCSrGv4Naxd8tzWx1UMbGEpWMuv
	 PV9X/rRMjFkWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: tillo@tillo.ch
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
Date: Mon, 10 Aug 2026 17:14:29 -0700
Message-ID: <20260811001429.1036686-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806074308.1996917-3-tillo@tillo.ch>
References: <20260806074308.1996917-3-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

This adds two sfp_quirks entries applying sfp_fixup_potron to XGS-PON ONT
sticks that report broken TX_FAULT/LOS and need a longer T_START_UP. Both
entries use SFP_QUIRK_F_PREFIX so the vendor PN field is matched as a
prefix rather than by exact length.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index dfb2b883d7616..4d8219e5ed599 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -556,6 +556,13 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
>  		  sfp_fixup_ignore_tx_fault),
>  
> +	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
> +	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
> +	// mask both signals and extend T_START_UP via the potron fixup. The
> +	// EEPROM vendor PN field is not space-padded past the legitimate
> +	// string, so match it as a prefix.
> +	SFP_QUIRK_F_PREFIX("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),

[Severity: Medium]
Can the prefix behaviour make any difference for this particular part
string?  "XGS-SFP-ONT-MACI" is 16 characters, which is the full width of
the field it is compared against:

include/linux/sfp.h:
	char vendor_pn[16];

sfp_lookup_quirk() bounds the computed length to that width:

	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));

and sfp_match() then does:

	if (prefix ? qs_len > len : qs_len != len)
		return false;
	return !strncmp(qs, str, qs_len);

With qs_len == 16 and ps <= 16, "qs_len > len" and "qs_len != len" accept
exactly the same input (ps == 16), and the strncmp() covers all 16 bytes.
So there are no EEPROM bytes left "past the legitimate string" for this
entry, and the part comparison is identical to what plain SFP_QUIRK_F()
would perform.

That leaves two possibilities for this module.  Either the PN field really
does read "XGS-SFP-ONT-MACI" and SFP_QUIRK_F() would have matched just as
well, so the commit message statement

	"a plain SFP_QUIRK_F entry would silently never apply and the
	kernel would honor the spurious TX_FAULT and eventually disable
	the module"

does not hold for this entry, or the field really does contain garbage,
which then falls inside the 16 compared bytes and neither prefix nor exact
matching can ever fire, making the new entry dead code.

Which of the two is it, and could the comment and the commit message be
adjusted to describe what the code actually does here?

>  	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
>  
>  	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
> @@ -616,6 +623,14 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
>  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
> +
> +	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
> +	// LOS indicators and slow startup, just like potron. The EEPROM
> +	// vendor PN field is filled with non-printable garbage past the
> +	// legitimate string instead of space padding, so match it as a
> +	// prefix.
> +	SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron),

[Severity: Low]
This isn't a bug, but both new comments and the SFP_QUIRK_F_PREFIX macro
comment justify prefix matching purely in terms of the vendor PN field,
while struct sfp_quirk carries a single flag:

drivers/net/phy/sfp.h:
	bool prefix_match;

and sfp_lookup_quirk() hands that same flag to the vendor comparison:

	if (sfp_match(q->vendor, id->base.vendor_name, vs,
		      q->prefix_match) &&
	    sfp_match(q->part, id->base.vendor_pn, ps,
		      q->prefix_match))

So for these two entries the vendor test also becomes a prefix test on
very short strings, and a module reporting vendor_name "OEMTEK" or "FSCOM"
now passes the vendor check.  The PN still has to prefix-match the full
model string, so the practical widening is limited to close clones, but
since sfp_fixup_potron() masks both TX_FAULT and LOS, an unintended match
silently hides genuine fault reporting.

Would it be worth either noting in the comments that the vendor field is
matched as a prefix too, or splitting the flag so prefix semantics only
apply to the part field?

>  	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
>  	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
>  	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
