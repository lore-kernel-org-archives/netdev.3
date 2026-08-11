Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE31F12FB;
	Tue, 11 Aug 2026 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407272; cv=none; b=CF7hFu9BLWfHBLYlju8pgF9ncibrwbOMC8vGK3KySu470Bcysu62jkXoJx75MnT92J5+b/AIIWhXx7zwkZBqt3xZefM6vzMzizAhmoEBu5ACEhqqu8/kGKXl2GCFuurTs7KczrLurcmtt6Jiz3TS0eRULp4MCOR7ol/PC7uytDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407272; c=relaxed/simple;
	bh=5CQj7Q/E9qIkGd5bbV6wqba1O1+CMuJ0RDAVHeybA7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1GSjaPOht+qekzR2U20lHOL0maCAKx7XYNfgvT+fCB65FIeHNLDU2+RF7flP9mKxo5JFf6pJbvlA4OyNCb+hAXVmXV6m3cPzvqHuqeDza+Uz30XDAbQbfslzv+hPqu2GlSgxQVtZZ7z4lmKhYJYQGrr9QzjlEMQXAvJjWixGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWzfarV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWzfarV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB01F000E9;
	Tue, 11 Aug 2026 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407269;
	bh=RtSI1lkxUoksjCybS1dSucCSM8Cyan7gFYzEXHnUfuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWzfarV90QRXYM727vcTIYD4OUiLg2TTpClfR9KmzGZ/9Rh7tYgQlo2nphvC4VFMp
	 zV2tOezs7Rz8Es5wBf2QDiwfMSPih/Kdu5SWnsxttVm5x6ymAPT1iyhKmxQ286qJUw
	 YWcwBQ/pcljYYDEk3v/ZPGYoLAzBZzjebIQyog0GjcQyzk+tDYi13Tlknew0339/BC
	 oR/IG9Ichz1yga9pNQ/RrENT8aa69J+OvkX8CGF+pOikfq+5rZ4dJKQZxp6FOUaLj5
	 OVI0//5GrfJpPJzmg9byBTIBgf7w/rNl2PVky3ZjwtUcpYwP7t0cYVkhiVfRwJwuIf
	 jAzL4NLCadhaQ==
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
Subject: Re: [PATCH net-next v2 1/2] net: sfp: allow prefix matching in quirk lookup
Date: Mon, 10 Aug 2026 17:14:27 -0700
Message-ID: <20260811001427.1036657-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806074308.1996917-2-tillo@tillo.ch>
References: <20260806074308.1996917-2-tillo@tillo.ch>
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
net: sfp: allow prefix matching in quirk lookup

This adds a prefix_match flag to struct sfp_quirk plus a
SFP_QUIRK_F_PREFIX macro, and teaches sfp_match() to compare only the
leading strlen() bytes of the quirk string when the flag is set.  The
motivation is clone SFP modules whose vendor PN field is padded with
garbage instead of spaces, which defeats the existing full-field length
comparison.

A couple of questions below.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 6c25b73c668a7..dfb2b883d7616 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -516,6 +516,14 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
>  	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
>  #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
>  #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
> +/* Like SFP_QUIRK_F, but matches as a prefix. Use for clone modules
> + * that fill EEPROM trailing bytes with garbage instead of the
> + * SFF-8472-mandated space padding, so sfp_strlen can't trim the
> + * field down to the legitimate length.
> + */
> +#define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
> +	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, \
> +	  .prefix_match = true }

[Severity: Low]
Should the commit message describe what this patch alone does?

At this commit SFP_QUIRK_F_PREFIX has no users: every entry in
sfp_quirks[] still uses SFP_QUIRK/SFP_QUIRK_S/SFP_QUIRK_F, so
q->prefix_match is false for all entries and the new branch in
sfp_match() is not reachable.

The commit message describes the end result, including the user-visible
symptom:

    The kernel then honors the module's spurious TX_FAULT signal and the
    SFP state machine eventually disables the module.

That symptom is only fixed once the follow-on patch in the series, "net:
sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI", adds
SFP_QUIRK_F_PREFIX("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron) and
SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron).  Splitting
mechanism from table entries is fine; the wording just reads as if this
patch fixes the modules by itself.

>  
>  static const struct sfp_quirk sfp_quirks[] = {
>  	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly

[ ... ]

> @@ -629,13 +637,16 @@ static size_t sfp_strlen(const char *str, size_t maxlen)
>  	return size;
>  }
>  
> -static bool sfp_match(const char *qs, const char *str, size_t len)
> +static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
>  {
> +	size_t qs_len;
> +
>  	if (!qs)
>  		return true;
> -	if (strlen(qs) != len)
> +	qs_len = strlen(qs);
> +	if (prefix ? qs_len > len : qs_len != len)
>  		return false;
> -	return !strncmp(qs, str, len);
> +	return !strncmp(qs, str, qs_len);
>  }
>  
>  static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
> @@ -648,8 +659,10 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
>  	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
>  
>  	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
> -		if (sfp_match(q->vendor, id->base.vendor_name, vs) &&
> -		    sfp_match(q->part, id->base.vendor_pn, ps))
> +		if (sfp_match(q->vendor, id->base.vendor_name, vs,
> +			      q->prefix_match) &&
> +		    sfp_match(q->part, id->base.vendor_pn, ps,
> +			      q->prefix_match))
>  			return q;

[Severity: Medium]
Was it intended for the prefix relaxation to apply to vendor_name as
well as vendor_pn?

sfp_lookup_quirk() passes the same q->prefix_match to both sfp_match()
calls, so an entry declared with SFP_QUIRK_F_PREFIX loosens the vendor
comparison too.  The macro comment only justifies the relaxation for the
PN field:

    /* Like SFP_QUIRK_F, but matches as a prefix. Use for clone modules
     * that fill EEPROM trailing bytes with garbage instead of the
     * SFF-8472-mandated space padding, so sfp_strlen can't trim the
     * field down to the legitimate length.
     */

With prefix set, the vendor test reduces to "vendor_name starts with
q->vendor", since sfp_match() only checks:

	if (prefix ? qs_len > len : qs_len != len)
		return false;
	return !strncmp(qs, str, qs_len);

The vendor strings used by the entries added later in the series are
short, SFP_QUIRK_F_PREFIX("FS", ...) and SFP_QUIRK_F_PREFIX("OEM", ...),
so those entries accept any vendor_name beginning with "FS" or "OEM",
such as "FS.COM".

sfp_lookup_quirk() returns the first table hit, and the table already
contains vendor strings where one is a prefix of another:

	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
		  sfp_fixup_ignore_tx_fault),
	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
		  sfp_fixup_ignore_tx_fault),

Can a future prefix entry then claim a module meant for a different
entry and run the wrong fixup?  sfp_fixup_potron() masks TX_FAULT and
LOS and extends T_START_UP, so a mis-match would suppress genuine fault
and LOS signalling on an unrelated module.

Would it make sense to keep the flag scoped to the part field, for
example a separate part_prefix_match, since struct sfp_quirk currently
has no way to express "prefix-match the part only"?

>  
>  	return NULL;

> diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
> index 879dff7afe6a4..867e45efbf3f1 100644
> --- a/drivers/net/phy/sfp.h
> +++ b/drivers/net/phy/sfp.h
> @@ -12,6 +12,7 @@ struct sfp_quirk {
>  	void (*support)(const struct sfp_eeprom_id *id,
>  			struct sfp_module_caps *caps);
>  	void (*fixup)(struct sfp *sfp);
> +	bool prefix_match;
>  };
-- 
pw-bot: cr
