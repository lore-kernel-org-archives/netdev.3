Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D253F23DF;
	Wed, 23 Sep 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198281; cv=none; b=GzVSW5zBy91wv0lCAlruGpV1yMVHxlsplyDuVR4xP5LjE8SB6P46VfxwdRSVr7uhNUGxPOR5GP2ZEh5P98yutEd4u4FIcetgm1XBqa6BpimhRNBrRyKJmxVmykWJj7XneuN02D+OsNwfHLmd5jJRAlSt61kUJR1jBLxV7dohLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198281; c=relaxed/simple;
	bh=6N6wbwHRUjuPLhXPo+/Z6YohLZpy6gk4Vf2BBjSB+nU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WaQA997H4D1OwHfsLouiRIwVilhSa8+dsy3o6fPJW1QeVxEWVIXZp/P3wly4sAIP8/QVqSIq2dcnwJq5BzoKs5SqxFPunmaaLbkvQmcM9XYvoIl7K78Tbu6aiggwH0EvX/Ai9zoqVSHtTkdMwfGWQfjhS2xrvyjKQoSAOOB/w2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GboHwgPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GboHwgPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892AB1F000FF;
	Wed, 23 Sep 2026 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790198273;
	bh=4Szv5469VQix35nfvNo8j5NGVQ29K0ZwUurSLIe4Ew0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GboHwgPJ0rYZySJGBLnrmBSkXENxS+Hkxa8iltDeXnRXWlv/XTp942rfQutXXoHOz
	 yT8Qf3l0pmqdZWvCsQuGx2LxDHOxdIMIjWdR6iRcNPEl4/4DwQDzTB4V5OMb0nrtY+
	 zgyNyEstTkayiEIXWipE0O9KTHrlcbGqxZ9DE+a14Vm8kTUOTzrR5onqJSTuUMMHON
	 Bsrq/CYav1hro2U0ObCe0qocu6vpjQWvadvEwQN4Bpl5nX3BQBQukv5Cc4h6o/MofV
	 8P1dG9pinoprkma9UXiiEjnGbBAriLJXnH7eHH7EHh1tF7RuyWJqtT4zhLO/6/Vud4
	 SZEMDmzODPZ+w==
Subject:
 Re: [PATCH 1/2] Documentation: dsa: b53: fix stale tagging-support section
From: netdev-bot+sashiko@kernel.org
To: chrismelnu@gmail.com
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:17:52 +0000
Message-ID: <179019827202.2160803.3779708917982788607@kernel.org>
In-Reply-To: <20260922211439.369917-1-chrismelnu@gmail.com>
References: <20260922211439.369917-1-chrismelnu@gmail.com>
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

- [Medium] The patch deletes the whole "Configuration without tagging
  support" section of Documentation/networking/dsa/b53.rst, including…

--

Documentation: dsa: b53: fix stale tagging-support section

This commit moves the 5325/5365 note into the tagging-supported section of
b53.rst, because b53_get_tag_protocol() gives them
DSA_TAG_PROTO_BRCM_LEGACY_FCS. It also deletes the whole "Configuration
without tagging support" section, including its single port, bridge and
gateway VLAN examples, on the grounds that it no longer applies to any b53
switch.

Link: https://patch.msgid.link/CAOiHx==_ixY-VNWX=XxqCFoJvE-80i+r2y6SNnxwQe9uZQJL6w@mail.gmail.com

> diff --git a/Documentation/networking/dsa/b53.rst b/Documentation/networking/dsa/b53.rst
> index 1cb3ff648f889..b67864b2d3144 100644
> --- a/Documentation/networking/dsa/b53.rst
> +++ b/Documentation/networking/dsa/b53.rst

[ ... ]

> @@ -35,149 +32,7 @@ Configuration with tagging support
>  The tagging based configuration is desired. It is not specific to the b53
>  DSA driver and will work like all DSA drivers which supports tagging.
>  
> -See :ref:`dsa-tagged-configuration`.
> -
> -Configuration without tagging support
> --------------------------------------
> -
> -Older models (5325, 5365) support a different tag format that is not supported
> -yet. 539x and 531x5 require managed mode and some special handling, which is
> -also not yet supported. The tagging support is disabled in these cases and the
> -switch need a different configuration.
> -
> -The configuration slightly differ from the :ref:`dsa-vlan-configuration`.
> -
> -The b53 tags the CPU port in all VLANs, since otherwise any PVID untagged
> -VLAN programming would basically change the CPU port's default PVID and make
> -it untagged, undesirable.

[Severity: Medium]

The commit message says:

  "The section and its config examples no longer apply to any b53 switch,
  so remove them."

Is that accurate? In drivers/net/dsa/b53/b53_common.c,
b53_get_tag_protocol() still falls back to DSA_TAG_PROTO_NONE for every
chip family. This check runs before any per-model tag selection:

	if (!b53_can_enable_brcm_tags(ds, port, mprot)) {
		dev->tag_protocol = DSA_TAG_PROTO_NONE;
		goto out;
	}

b53_can_enable_brcm_tags() returns false in two cases. The first is when
the CPU port is not 5, 7 or 8, which b53_possible_cpu_port() enforces. The
second is when the switch is stacked behind a Broadcom-tagging conduit:

	case DSA_TAG_PROTO_BRCM:
	case DSA_TAG_PROTO_BRCM_PREPEND:
		dev_warn(ds->dev,
			 "Port %d is stacked to Broadcom tag switch\n", port);
		ret = false;

In that mode the driver still behaves the way the removed text describes.
b53_vlan_port_needs_forced_tagged() keeps the CPU port tagged in all VLANs:

	return dev->tag_protocol == DSA_TAG_PROTO_NONE && dsa_is_cpu_port(ds, port);

and b53_vlan_setup() does this:

	ds->untag_bridge_pvid = dev->tag_protocol == DSA_TAG_PROTO_NONE;

After this patch, b53.rst only points to dsa-tagged-configuration. It no
longer mentions the untagged mode or links to dsa-vlan-configuration.
Boards whose CPU port is not 5/7/8 and cascaded Broadcom switches can
still end up in that mode.

Would it be better to keep this section and change the stated reason?
Tagging is disabled because of CPU port placement or stacking, not
because of the chip model (5325/5365/539x/531x5).

The follow-up patch in this series, "MAINTAINERS: add missing entry for
b53.rst", only adds an F: line and doesn't restore this content.

[ ... ]

> +Older models (5325, 5365) use a different, legacy tag format, but tagging
> +is supported.

[ ... ]

> +See :ref:`dsa-tagged-configuration`.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922211439.369917-1-chrismelnu%40gmail.com
