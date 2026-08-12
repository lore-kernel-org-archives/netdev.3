Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BC383312;
	Wed, 12 Aug 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547567; cv=none; b=NJ8AbPT+o6/t8MZGIJE7ny0qzDv1JeOlqm37v0rN4xqABco4eoo2YYYDpFcN2xUyVonVOpXdmq9Y9Di5lIYofOT++QxbJ5cEEoP+MILqe7BXAhJNMwjDhyYNRvlpbZhw1Nej/eGhwroWsl0Oj1fwGC8v8cB9dKNhP1qt3CVfKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547567; c=relaxed/simple;
	bh=OPJq2XC5bX9iyo53+wufhLzHBFppkfd7P1OU1Og3KRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2GLz8g+Lhj36wQeInts2wovKdwdDbuQvfSVajKJ/naxIUHvIHnYU5soErvo9uvqGte8FjQ4VFkkgx5avz/XUVcATaD2Unb/b+5PAibr6fhIIy6UzDzFm582B0YS1eQUTlUExVzn1ZthHsERn3RU8NBqiUCMaoplY5yEUomNeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=o4VALzhn; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="o4VALzhn"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786547554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPJq2XC5bX9iyo53+wufhLzHBFppkfd7P1OU1Og3KRg=;
	b=o4VALzhn+uWl8lSNLsd3Y3g3nwQch2qqyxYf/nYLpn55Zibx5VMjcpYCchDB4+SPzhasm5
	MFDgnVTj33cRNAauVW+3HpV1WEB6LVqnDpeK8JQsjDvcS7ukwVivWfXHrWExELhpDDk8+t
	HKmj7gnrw/IZaQTAsxRuY2d0DHaTPwfno0ik3BREdUIOKWlK/8DRB2+EgXGhWqqCKtyren
	b0SUDZ0A01IjIz9S6WwU0U//NXSCJ+lF8k74XHs99xwo96ASDqxnn43gG8BifvUV9MZ8X4
	0RUXauFLijJcN3bBvxjzCD8cd/9awlz/0JZpG2bf0/hOfJbFgL2OvpwSYgy+2w==
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: sfp: allow prefix matching in quirk lookup
Date: Wed, 12 Aug 2026 17:12:25 +0200
Message-ID: <20260812151225.1146669-1-tillo@tillo.ch>
In-Reply-To: <20260811001427.1036657-1-kuba@kernel.org>
References: <20260811001427.1036657-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 17:14:27 -0700, Jakub Kicinski wrote:
> [Severity: Low]
> Should the commit message describe what this patch alone does?
>
> At this commit SFP_QUIRK_F_PREFIX has no users: every entry in
> sfp_quirks[] still uses SFP_QUIRK/SFP_QUIRK_S/SFP_QUIRK_F, so
> q->prefix_match is false for all entries and the new branch in
> sfp_match() is not reachable.

Fair point. I'll reword it in v3 so it describes just the mechanism,
and leave the user-visible symptom to the patch that adds the entries.

> [Severity: Medium]
> Was it intended for the prefix relaxation to apply to vendor_name as
> well as vendor_pn?

No, it wasn't. The PN field is the only one I have ever seen garbage
in, and your Hisense-Leox/Hisense example shows the vendor loosening
could bite for real given the first-match table semantics.

v3 scopes the flag to the part field only (part_prefix_match, vendor
comparison always exact). As it turns out the FS entry does not need
prefix matching at all (see my reply on 2/2), so the only remaining
user is the XGSPONST2001 entry, whose "OEM" vendor string then matches
exactly.

Thanks,
Martino
