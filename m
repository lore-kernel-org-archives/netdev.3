Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF414A619;
	Tue, 25 Aug 2026 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621769; cv=none; b=oZws5npk6QgGrYKJwAIwp1ViUgLOMAAIp8uN3GXBVMr1mWgGAgSmAlDMA/gmlhE9qV6t+n+PuRKi/Kc3THysBzoLiwqUBCRQPr0RZxUpoQoR6/qc47LjLfec+k3sZ6GE0xXjP1wQQuoax7K26EODfIWSpRfIwS3C1OmPUghmX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621769; c=relaxed/simple;
	bh=MzDT6pJ1ccI1c9yYIcAhAkVjgi9wAsGIOtuubV9WvFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCx8aNIJu+KW3ElrJjoNzxzLrC1gMn0+0a41KqIP0gRig5FRZYUgvtdo1NpeIoVqTogZTFpq6gBe3a2pJOi7h43DthvMf89dlfPZ8Fvm6UIhSfGMlQZMrdjdbS05UJqup+Pdn9B9ZI9mSqNZ9cFh0lmkHGOvemfIrLZSTQq9AuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntv7xNaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntv7xNaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F0A1F000E9;
	Tue, 25 Aug 2026 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787621768;
	bh=wsIuAZzq1jqYKDou0egY/KRUSSpPLas/Hb4UQZNMHiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ntv7xNaZruTJsJq+5pl52HTUZl1i1PAjFX5lDQCY7vI+CS9sjmkzSzz4fHPfUsRsJ
	 qiZF5MmUHrUfr/XX6bsbmrVNTAItBxjAezza5lNw8vhFoMl1AU2PhPi6d2xqVOI80D
	 Uhc3ObWp1U0pZqOGlOQDdl/XSiafqFNmx762cRl5RG3ZeAqyUSZHtRxZWVkV3JAzIT
	 pu+xc7UAysOLWYY85VVqn4NOKEVLsobo3bKgSEv0mdXLOgwRGS3APSAvZ7QZ5xDBMf
	 Qr3EbXUmX2MJ/oqmyaxPD6tG/x6e0zpsyBiZSHpXjBolLD1wGyzbt2cOXSpofapyOZ
	 udAQUU2pvEZ6A==
From: Jakub Kicinski <kuba@kernel.org>
To: hilalrahmatullah11@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: nl80211: add sta-info nested attribute
Date: Mon, 24 Aug 2026 18:36:05 -0700
Message-ID: <20260825013605.2932861-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-work-v1-1-6a4ca4a92ee6@gmail.com>
References: <20260821-work-v1-1-6a4ca4a92ee6@gmail.com>
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
wifi: nl80211: add sta-info nested attribute

This converts NL80211_ATTR_STA_INFO in the nl80211 YAML spec from an
opaque binary blob into a proper nest, and adds the sta-info-attrs,
rate-info-attrs, sta-bss-param-attrs and tid-stats-attrs attribute sets
plus the enum definitions they reference.

A few questions about the new definitions below.

> diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
> index 802097128bdae..cc5ef34f8decc 100644
> --- a/Documentation/netlink/specs/nl80211.yaml
> +++ b/Documentation/netlink/specs/nl80211.yaml
> @@ -211,6 +211,76 @@ definitions:
>        - ht20
>        - ht40minus
>        - ht40plus

[ ... ]

> +  -
> +    name: eht-ru-alloc
> +    type: enum
> +    name-prefix: nl80211-rate-info-he-ru-alloc-
                                    ^^^^

[Severity: Medium]
Is the he- prefix here a copy/paste slip?  The sixteen entries below match
enum nl80211_eht_ru_alloc in include/uapi/linux/nl80211.h exactly in order
(26, 52, 52p26, 106, 106p26, 242, 484, 484p242, 996, 996p484, 996p484p242,
2x996, 2x996p484, 3x996, 3x996p484, 4x996), and those constants are spelled
NL80211_RATE_INFO_EHT_RU_ALLOC_*, so the prefix would need to be
nl80211-rate-info-eht-ru-alloc- to describe the uAPI.

As written, this definition and the he-ru-alloc definition a few lines
further down carry the same name-prefix but assign different values to the
same suffixes.  The HE enum has value 2 == 106, while this list has
value 2 == 52p26.

Since the generator builds constant names from name-prefix:

tools/net/ynl/pyynl/ynl_gen_c.py:EnumSet.__init__() {
    ...
    self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
    ...
}

wouldn't a --mode uapi render emit two conflicting definitions of
NL80211_RATE_INFO_HE_RU_ALLOC_26/52/106/242/484/996/2X996?  The spec is
installed for user space via make install-specs, so the wrong names are
directly consumable.  I checked the tip of the series and the he- prefix is
still there, so it does not look like a later patch corrects it.

> +    entries:
> +      - "26"
> +      - "52"
> +      - 52p26
> +      - "106"
> +      - 106p26
> +      - "242"
> +      - "484"
> +      - 484p242
> +      - "996"
> +      - 996p484
> +      - 996p484p242
> +      - 2x996
> +      - 2x996p484
> +      - 3x996
> +      - 3x996p484
> +      - 4x996

[ ... ]

> +  -
> +    name: he-ru-alloc
> +    type: enum
> +    name-prefix: nl80211-rate-info-he-ru-alloc-
> +    entries:
> +      - "26"
> +      - "52"
> +      - "106"
> +      - "242"
> +      - "484"
> +      - "996"
> +      - 2x996

[ ... ]

> @@ -1601,6 +1672,111 @@ attribute-sets:
>          name: nan
>          type: nest
>          nested-attributes: frame-type-attrs
> +  -
> +    name: rate-info-attrs
> +    enum-name: nl80211-rate-info
> +    name-prefix: nl80211-rate-info-
> +    attributes:

[ ... ]

> +      -
> +        name: eht-ru-alloc
> +        type: u8
> +        enum: eht-ru-alloc

This is the attribute that picks up the mis-prefixed definition above, so
the spec currently describes EHT RU-allocation values under HE constant
names.

[ ... ]

> @@ -1631,6 +1807,172 @@ attribute-sets:
>        -
>          name: end-freq
>          type: u32

[ ... ]

> +  -
> +    name: sta-info-attrs
> +    enum-name: nl80211-sta-info
> +    name-prefix: nl80211-sta-info-
> +    attributes:

[ ... ]

> +      -
> +        name: chain-signal
> +        type: indexed-array
> +        sub-type: u8
> +      -
> +        name: chain-signal-avg
> +        type: indexed-array
> +        sub-type: u8

[Severity: Low]
Does a ynl build still work at this commit?  AttrSet.new_attr() only accepts
three sub-types for indexed arrays and raises otherwise:

tools/net/ynl/pyynl/ynl_gen_c.py:AttrSet.new_attr() {
    ...
    elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
        if elem["sub-type"] in ['binary', 'nest', 'u32']:
            t = TypeIndexedArray(self.family, self, elem, value)
        else:
            raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
    ...
}

tools/net/ynl/generated/Makefile generates for every spec except conntrack
and nftables, so nl80211.yaml is processed and make -C tools/net/ynl would
abort here.

The following patch in the series, "net: ynl: allow u8 sub-type for indexed
array", adds 'u8' to that whitelist, and at the series tip the list reads
['binary', 'nest', 'u32', 'u8'], so only the intermediate commits are
affected.  Would swapping the order of the two patches keep the tree
bisectable?

[ ... ]

> +      -
> +        name: tid-stats
> +        type: indexed-array
> +        sub-type: nest
> +        nested-attributes: tid-stats-attrs

[Severity: Medium]
Should the TID index offset be recorded somewhere here?  The plain
indexed-array model says the entry nests have the index of the entry as
their type, but the kernel does not use a 0-based index:

net/wireless/nl80211.c:nl80211_send_station() {
    ...
    for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
        struct cfg80211_tid_stats *tidstats = &sinfo->pertid[tid];

        if (!tidstats->filled)
            continue;

        tidattr = nla_nest_start_noflag(msg, tid + 1);
    ...
}

and include/uapi/linux/nl80211.h documents it as "the inner attribute
number is the TID+1 and the special TID 16 (i.e. value 17) is used for
non-QoS frames".

Because unfilled TIDs are skipped, the array is also sparse, and the C
generator throws the entry type away:

tools/net/ynl/pyynl/ynl_gen_c.py:TypeIndexedArray._attr_get() {
    ...
    get_lines = [f'attr_{self.c_name} = attr;',
                 'ynl_attr_for_each_nested(attr2, attr) {',
                 '\tif (__ynl_attr_validate(yarg, attr2, type))',
                 '\t\treturn YNL_PARSE_CB_ERROR;',
                 f'\tn_{self.c_name}++;',
                 '}']
    ...
}

so a generated C consumer fills a dense array in encounter order and reports
per-TID counters against the wrong TID.  The Python library keeps the raw
index as a dict key, so there the offset is only undocumented.

Note the same construct two attributes earlier is genuinely 0-based:

net/wireless/nl80211.c:nl80211_put_signal() {
    ...
    for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
        ...
        if (nla_put_u8(msg, i, signal[i]))
    ...
}

Can the two different index semantics be distinguished from this spec as it
stands?

[ ... ]

Cross-instance finding from sashiko-gemini (68565e9f44913e1546bdedfd69f80fe6b57cbeb2edfb4bc54f79467c320b20e1):
[Severity: Medium]
The `pad` attributes in `sta-info-attrs` and `tid-stats-attrs` violate the netlink YAML policy by using type `binary` instead of `pad`.
-- 
pw-bot: cr
