Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C2175A7B;
	Tue, 25 Aug 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621770; cv=none; b=CUg+2AWZ/XNe6EdfqnLcDpwKNJ36nM+iNCC0bbmG5rNnQ3T7yNLKO9rCKavZQbOyEJTWgL1RqfyjvcT0H3pvDzf0XuwtuZDHgfM4BwcU+YCBVH3x62Jmz3N1RLX567thhj2X6Zf5uL1AOs8JW2YU191bvwP3ZdwIPRFY+cHBeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621770; c=relaxed/simple;
	bh=AY5GOXzINHi8gN/NizRRTAFFntrf+A+oI1/TpzeF20g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKX/euHZPVbhmPPit6WuW6qZk3Ei3sheIDgT2Y5aL8JXvlNH3keXnd3VpVGYCzQfWvQ7Gh/FW4nuzqUJgAt5/BrdHA2IEFn9kvSIcc2A73QKZXFkC1PQ/Dnr0chfIPJgLlN9tvadpQcjC3SCT+tpM/C4eJoxIXjvgzSEKp2NjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ0KMAbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ0KMAbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0428F1F00A3A;
	Tue, 25 Aug 2026 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787621769;
	bh=BfE7viPV8FJfAYGP3HgNPcGDfJ3eDE0bViABvssmfiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZ0KMAbg69e78nABHT8mWrWdmCrhy6G+X1ls6fmrx77r7eXGSkq0/631Cqm0d0m/d
	 A3yYU3AwZHNQ0A8wxACEfpyaiLH8iUEQ8QdlSzKO5uNSFuRopo4QN6wpX7C6hk04sB
	 UX4hyfiBPtnvckgeJ8BEz3L79PDJv30JzTrJ7P8z1CSszamWonKVSl2IS7NC8G3U+c
	 9cwjKezCHMQ1yWjL5ZuVRI43fK6zHxaJSNp7fj9sb8hVnm7lQLWcbEPgC/3nByxUud
	 iQ+swB3PSd4yx/zEqf1tt0GCuBk0U/3oihroro3xCk5I5RaJK89nYOCVkHjg0GKs0O
	 BnValdbpJ6LvA==
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
Subject: Re: [PATCH 2/2] net: ynl: allow u8 sub-type for indexed array
Date: Mon, 24 Aug 2026 18:36:08 -0700
Message-ID: <20260825013608.2932927-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-work-v1-2-6a4ca4a92ee6@gmail.com>
References: <20260821-work-v1-2-6a4ca4a92ee6@gmail.com>
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
net: ynl: allow u8 sub-type for indexed array

This adds u8 to the list of sub-types accepted by AttrSet.new_attr() for
indexed-array attributes in tools/net/ynl/pyynl/ynl_gen_c.py, so that the
nl80211 chain-signal attributes can be described in the YAML spec.  Without
it the generator rejects the sub-type outright.

> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index cdc3646f2642c..7373a48d5516a 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1158,7 +1158,7 @@ class AttrSet(SpecAttrSet):
>          elif elem['type'] == 'nest':
>              t = TypeNest(self.family, self, elem, value)
>          elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
> -            if elem["sub-type"] in ['binary', 'nest', 'u32']:
> +            if elem["sub-type"] in ['binary', 'nest', 'u32', 'u8']:

[Severity: Medium]
Should this patch come before the spec change in the series?

The preceding commit cb06a9dc93de ("wifi: nl80211: add sta-info nested
attribute") already adds chain-signal and chain-signal-avg to
Documentation/netlink/specs/nl80211.yaml:

      -
        name: chain-signal
        type: indexed-array
        sub-type: u8

SpecAttrSet.__init__() in tools/net/ynl/pyynl/lib/nlspec.py calls
new_attr() for every attribute of every attribute set at spec parse time,
regardless of which ops or generation mode are requested:

    for elem in self.yaml['attributes']:
        ...
        attr = self.new_attr(elem, val)

so at the intermediate commit AttrSet.new_attr() takes the else branch and
raises 'new_attr: unsupported sub-type u8'.

nl80211 is part of GENS in tools/net/ynl/generated/Makefile, which globs all
specs and only filters out conntrack and nftables:

    SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
    GENS_UNSUP=conntrack nftables
    GENS=$(filter-out ${GENS_UNSUP},$(patsubst $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS}))

Does that mean make -C tools/net/ynl and ynl-regen.sh fail for anyone who
lands on or bisects to cb06a9dc93de?  Reordering so the generator support
lands first, or squashing the two, would avoid that.

[Severity: Medium]
Does the scalar indexed-array path lose the entry index that
NL80211_STA_INFO_CHAIN_SIGNAL relies on?

Documentation/userspace-api/netlink/genetlink-legacy.rst describes the entry
attribute type as the index:

    The ``ENTRY`` nests are special and have the index of the entry as
    their type instead of normal attribute type.

nl80211_put_signal() keys each u8 on the chain number and skips chains that
are not in the mask, so the emitted index sequence can be sparse:

    for (i = 0; i < IEEE80211_MAX_CHAINS; i++) {
            if (!(mask & BIT(i)))
                    continue;
            if (nla_put_u8(msg, i, signal[i]))

Sparse masks do occur in practice, for example ath10k_htt_rx_h_signal()
sets each bit of status->chains independently based on per-chain RSSI
validity.

The generated parser for scalar sub-types in _multi_parse() stores entries
densely and drops ynl_attr_type(attr):

    elif aspec.sub_type in scalars:
        ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.sub_type}(attr);")
    ri.cw.p('i++;')

So a message carrying chains 0 and 2 is reported as _count.chain_signal = 2
with the chain-2 value sitting at index 1, and TypeIndexedArray.attr_put()
would then re-serialize it as index 1:

    for (i = 0; i < {var}->_count.{c_name}; i++)
        ynl_attr_put_u8(nlh, i, {var}->{c_name}[i]);

YnlFamily._decode_array_attr() in tools/net/ynl/pyynl/lib/ynl.py has the
same loss since it appends item.as_scalar() to a plain list without
recording item.type.

The lossy path predates this patch, since only u32 indexed arrays were
allowed and the in-tree u32 user arp-ip-target is dense.  Is it worth
carrying the index alongside the value before routing nl80211 chain-signal
through this path, so per-chain values are not attributed to the wrong
chain?

>              else:
>                  raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')

[Severity: Medium]
One more thing on the spec added by the preceding commit of this series, in
Documentation/netlink/specs/nl80211.yaml.  The new eht-ru-alloc enum
declares the HE name prefix:

    name: eht-ru-alloc
    type: enum
    name-prefix: nl80211-rate-info-he-ru-alloc-

while include/uapi/linux/nl80211.h names these values with the EHT prefix:

    enum nl80211_eht_ru_alloc {
            NL80211_RATE_INFO_EHT_RU_ALLOC_26,
            NL80211_RATE_INFO_EHT_RU_ALLOC_52,
            NL80211_RATE_INFO_EHT_RU_ALLOC_52P26,

The same patch adds he-ru-alloc with that identical prefix:

    name: he-ru-alloc
    type: enum
    name-prefix: nl80211-rate-info-he-ru-alloc-

The generator builds the C enumerators straight from that prefix:

    self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
    self.c_name = c_upper(self.enum_set.value_pfx + self.name)
    cw.p(entry.c_name + suffix)   /* render_uapi() */

so uapi generation from this spec emits
NL80211_RATE_INFO_HE_RU_ALLOC_26/52/106/242/484/2x996 twice, and the
EHT-only entries (52p26, 106p26, 484p242, 996p484, 996p484p242, 2x996p484,
3x996, 3x996p484, 4x996) come out under NL80211_RATE_INFO_HE_RU_ALLOC_*
names that do not exist in the UAPI header.  No in-tree build runs
--mode uapi for nl80211 today, so nothing breaks right now.

Should the eht-ru-alloc prefix be nl80211-rate-info-eht-ru-alloc- instead?
