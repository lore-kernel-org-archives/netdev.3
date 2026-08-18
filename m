Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE544236B;
	Tue, 18 Aug 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072856; cv=none; b=DP+LLpGk1BD2nVZ2u9qw3A7zS3joECUSeJxGEHv+pLMkVEubllkdgg2fDm8xgl5YRLHsyhMsTIWzwA3EOpRfv9zU2Y47OuDplx/Gl/1AVJNxORahTRnHz49Sy4AWBqP60FJeClj+kqPnEvbLVQ9lT0oOWcEIMg4iDzSr5+6x/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072856; c=relaxed/simple;
	bh=T8X9lA/uZ9W7+jIzJTm8jcF0aLcalCaDsLQUvyfcG/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He0jIruzY7CQGIEyZcQ7in3uR0BKeQXYbv/llybumU6I/FKCRddtvQBkWUI+0Wvu01zmhJ5/Sui4A/Lfa6hnQFihKTzTAl7LWMy8SPs0yxYqHZmtyDVDsv/oJ1r9nT347PDpKahaFvphKoX+u4ygwozEKYWxWkhL/NmVDL3Wa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXuBAOEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXuBAOEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346C71F000E9;
	Tue, 18 Aug 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072854;
	bh=Qdn57lS9lolJqr1u+vqomb4IaPvN+6Q0PfGEoYMz0A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXuBAOEAHeokjV0P93mc/SIAIVFrOzsaUZvlfusEjxvjtt263rWVM5s/+FlQyC1JT
	 907pSUjbClXF3HZ9vc0o50pQW7WrekflQBFTshrWV78qA/F+aE7l0AFgGEm4pCHgga
	 B9uuRWfZC3VQt0yv7oHaa/hJNPrmrvc5c+vOGXIwLUvwsgvz5b1HbKXlR5dokQQXFm
	 FevVjgUPQ5F0ao9V2z7VfxWABhayfv9eqCuJCNloK/3tpiDUE/E1AwDxCTeaavs3g4
	 LieUE/Q3njEwsaRdixX9eyfvhvhkINSrYzbARmlOKq95YvdDBHn4+tqxkDqO5SwX3h
	 lX+DvRxJDFD8w==
From: Jakub Kicinski <kuba@kernel.org>
To: hilalrahmatullah11@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested attribute
Date: Tue, 18 Aug 2026 10:07:32 -0700
Message-ID: <20260818170732.4018358-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
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
wifi: nl80211: document sta-info nested attribute

This converts NL80211_ATTR_STA_INFO in the nl80211 YAML spec from an
opaque binary blob into a real nest, and adds the sta-info-attrs,
rate-info-attrs, sta-bss-param-attrs and tid-stats-attrs sets plus the
supporting enum definitions.  A few questions below about how some of the
new entries line up with what net/wireless/nl80211.c actually puts on the
wire.

> diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
> index 802097128bdae..4ad391db4a76d 100644
> --- a/Documentation/netlink/specs/nl80211.yaml
> +++ b/Documentation/netlink/specs/nl80211.yaml

[ ... ]

> @@ -297,7 +361,8 @@ attribute-sets:
>          type: u32
>        -
>          name: sta-info
> -        type: binary  # TODO: nest
> +        type: nest
> +        nested-attributes: sta-info-attrs
>        -
>          name: wiphy-bands
>          type: nest

[ ... ]

> @@ -1601,6 +1666,102 @@ attribute-sets:
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
> +        name: 16-mhz-width
> +        type: flag

[Severity: Medium]
The set stops at 16-mhz-width, which gets implicit value 29 and lines up
one-for-one with the enum up to that point.  But enum nl80211_rate_info in
include/uapi/linux/nl80211.h in this same tree continues:

	NL80211_RATE_INFO_16_MHZ_WIDTH,
	NL80211_RATE_INFO_UHR_MCS,
	NL80211_RATE_INFO_UHR_ELR,
	NL80211_RATE_INFO_UHR_IM,

and nl80211_put_sta_rate() emits them inside the same nest:

	} else if (info->flags & RATE_INFO_FLAGS_UHR_MCS) {
		if (nla_put_u8(msg, NL80211_RATE_INFO_UHR_MCS, info->mcs))
	...
		if (info->flags & RATE_INFO_FLAGS_UHR_ELR &&
		    nla_put_flag(msg, NL80211_RATE_INFO_UHR_ELR))

With values 30, 31 and 32 missing from the spec, does a get-station or
dump-station on UHR capable hardware abort in the decoder?  In
tools/net/ynl/pyynl/lib/ynl.py the lookup path is:

                attr_spec = attr_space.attrs_by_val[attr.type]
            except (KeyError, UnboundLocalError) as err:
                if not self.process_unknown:
                    raise YnlException(f"Space '{space}' has no attribute "

so unless process_unknown is set the whole reply fails rather than
returning the station data.  Should uhr-mcs, uhr-elr and uhr-im be added
here?

>    -
>      name: sar-attributes
>      enum-name: nl80211-sar-attrs

[ ... ]

> @@ -1631,6 +1792,170 @@ attribute-sets:
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
> +        name: rx-bytes64
> +        type: u64
> +      -
> +        name: tx-bytes64
> +        type: u64
> +      -
> +        name: chain-signal
> +        type: u8
> +      -
> +        name: chain-signal-avg
> +        type: u8

[Severity: Medium]
Are these two really scalars on the wire?  nl80211_send_station() routes
both through nl80211_put_signal():

	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
		if (!nl80211_put_signal(msg, sinfo->chains, sinfo->chain_signal, NL80211_STA_INFO_CHAIN_SIGNAL))

and nl80211_put_signal() builds a nest keyed by chain index:

	attr = nla_nest_start_noflag(msg, id);
	...
		if (nla_put_u8(msg, i, signal[i]))

so the payload is at least nla_total_size(1), never one byte.  The per-link
fill path does the same thing with link_sinfo->chains, and
include/uapi/linux/nl80211.h documents it as:

 * @NL80211_STA_INFO_CHAIN_SIGNAL: per-chain signal strength of last PPDU
 *	Contains a nested array of signal strength attributes (u8, dBm)

With type: u8 the decoder takes the scalar path in
tools/net/ynl/pyynl/lib/ynl.py:

    def as_scalar(self, attr_type, byte_order=None):
        format_ = self.get_format(attr_type, byte_order)
        return format_.unpack(self.raw)[0]

which has no length tolerance, so unpacking an eight byte nest as 'B'
raises struct.error and the reply decode is aborted with "Error decoding
'chain-signal' from 'sta-info-attrs'".  While NL80211_ATTR_STA_INFO was
type: binary the blob was never walked, so does making it a nest turn this
into a live failure for every station report from hardware that sets
sinfo->chains?  Would an indexed array of u8 (sub-attribute type is the
0-based chain index) describe it correctly?

> +      -
> +        name: expected-throughput
> +        type: u32
> +      -
> +        name: rx-drop-misc
> +        type: u64
> +      -
> +        name: beacon-rx
> +        type: u64
> +      -
> +        name: beacon-signal-avg
> +        type: u8
> +      -
> +        name: tid-stats
> +        type: indexed-array
> +        sub-type: nest
> +        nested-attributes: tid-stats-attrs
> +      -
> +        name: rx-duration
> +        type: u64
> +      -
> +        name: pad
> +        type: binary

[Severity: Low]
This isn't a bug, but should this (and the pad entry added to
tid-stats-attrs below) use type: pad instead of type: binary?
NL80211_STA_INFO_PAD is only ever used as the padattr argument:

	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
			      sinfo->memb, NL80211_STA_INFO_PAD))

and NL80211_TID_STATS_PAD is used the same way by PUT_TIDVAL_U64.  The
tooling special-cases the dedicated type in
tools/net/ynl/pyynl/lib/ynl.py:

                if attr_spec["type"] == 'pad':
                    continue

so as binary the filler shows up as a decoded pad field and the generated
documentation claims it carries binary content.  Other in-tree specs
(tc.yaml, rt-link.yaml, ethtool.yaml, nftables.yaml) use type: pad for
these.  Note the existing NL80211_ATTR_PAD entry in this file already uses
type: binary, so this matches an existing wart in the family rather than
introducing a functional break.

> +      -
> +        name: ack-signal
> +        type: u8
> +      -
> +        name: ack-signal-avg
> +        type: u8

[Severity: Medium]
Should ack-signal-avg be s8?  The emitter uses the signed helper:

		PUT_SINFO(ACK_SIGNAL, ack_signal, u8);
		PUT_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);

which expands to nla_put_s8(), the per-link path does
PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8), struct station_info
declares avg_ack_signal as s8, and the uapi header says:

 * @NL80211_STA_INFO_ACK_SIGNAL_AVG: avg signal strength of ACK frames (s8, dBm)

The payload is one byte either way, so there is no parse error, just a
value reported as 214 instead of -42.  s8 is accepted by the schema
(the attr-type enum in Documentation/netlink/genetlink-legacy.yaml lists
it).

Related, and weaker: signal, signal-avg, ack-signal and beacon-signal-avg
are put with nla_put_u8() so u8 matches the emitter literally, but the
underlying station_info members are s8 dBm values, so spec-driven decoders
will print them as large positive numbers.  Is that intended here?

> +      -
> +        name: rx-mpdus
> +        type: u32

[ ... ]

> @@ -1672,6 +1997,30 @@ attribute-sets:
>        -
>          name: nan
>          type: flag
> +  -
> +    name: tid-stats-attrs
> +    enum-name: nl80211-tid-stats
> +    name-prefix: nl80211-tid-stats-
> +    attributes:

[ ... ]

> +      -
> +        name: pad
> +        type: binary
> +      -
> +        name: txq-stats
> +        type: nest
> +        nested-attributes: txq-stats-attrs
>    -
>      name: txq-stats-attrs
>      name-prefix: nl80211-txq-stats-

Cross-instance finding from sashiko-gemini (9bc2ddddefa645796d23dda3f200d5d56cc1ca9a67d79f78de96c69e6ca35525):
[Severity: High]
The newly added enums (`eht-gi`, `he-gi`, `eht-ru-alloc`, `he-ru-alloc`, `mesh-power-mode`, `plink-state`) lack the `name-prefix` property, causing YNL to emit incorrect C constants.
-- 
pw-bot: cr
