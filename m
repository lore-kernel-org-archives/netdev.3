Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBF3F5BD6
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855680; cv=none; b=Flhfsr40T5LzmIEokICWYSownrYSkZy5YNDjnI25xR4groB9ziP8mIaYn31hfWr+ubZKAn34vXpAxIvGXTfmBvgN6Gh+UyxTukkIqNrFjBkL2WVQQ+RgLw5CGUt47sl2+TbSCZyySELdRPLCWTTKsoNF+bGzUeieALdFF9lQ4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855680; c=relaxed/simple;
	bh=bmDQFHlz/V1xrOoM+m5eZPHU+sGE2Duy5mQffd/Sc+o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFQKiECfbQzvJUJL2eQbEWfqOBwQ4ol7O52og3ztkq3e2vvq+FDy2rWi8EXm3wHpN1h9Ef2IpgpyEGiieaNy9JZkfDkoBHPTTy54u2dIAVG2aFW/dW9a3jPhtSzY86lg8ZEMUqX/2TVahO/ZLmaIO0cZSx2CHKlWLZNfDX5Qb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5j1UzOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5j1UzOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA01F00A3A;
	Tue,  8 Sep 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855678;
	bh=skQB5yJNhMnJwfttbyCxMuZ2XsPZYmA4O8t+atcg1Ac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j5j1UzOC5TBIzy/vAr4Fuesfj4sh8BFZfYB9KM8PRJ1A9yedx8kHy/iLj61kqWiDo
	 kgKnT5hTqxhWiq4FjzfhACC9h3OfQh6FkG0Tv24WK7/sxJsMjumlnejmC2l0SaSnxR
	 3oUJ5yxB3HeeLdi+J59kRBkAZO9WLtBb+1Ay8t0+mbG5Ks1kZv4kxHfIX35qx+mvrR
	 CkjS2M6ZIRpE4scAIiF3acGmNvk7h2Km0EzmDwcf+kxfSjPlIr1Tlhs6JL3gCkuua4
	 cEwejiEf0OHJdc2GQRMc9MrLdDIIQ3T6xVN+J6MpTouk97Y4ml3eQN24VBQkLN4ukE
	 bAO3TPYUhxf9w==
Subject:
 Re: [PATCH net] openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
From: netdev-bot+sashiko@kernel.org
To: echaudro@redhat.com
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cpp.code.lv@gmail.com
Date: Tue, 08 Sep 2026 08:21:17 +0000
Message-ID: <178885567772.219967.14568180746659022844@kernel.org>
In-Reply-To:
 <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
References:
 <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
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
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

- [Medium] Undisclosed second behavioural change in the IPPROTO_AH arm of
  get_ipv6_ext_hdrs() (net/openvswitch/flow.c:299-309).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `case
  IPPROTO_ESP:` arm of get_ipv6_ext_hdrs()…
- [High] This problem wasn't introduced by this patch, but
  get_ipv6_ext_hdrs() advances the parse offset with `start +=…

--

openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

The ESP and AH arms of get_ipv6_ext_hdrs() masked out the numeric constant
IPPROTO_FRAGMENT instead of the OFPIEH12_FRAG bit when deciding whether the
extension headers seen so far are out of order.  Both masks are changed to
use OFPIEH12_FRAG.

A few questions below about the two hunks and the surrounding parser.

> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 46c1d66aad8c..868d9fdf3afd 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -288,7 +288,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  			if (*ext_hdrs & OFPIEH12_ESP)
>  				*ext_hdrs |= OFPIEH12_UNREP;
>  			if ((*ext_hdrs & ~(OFPIEH12_HOP | OFPIEH12_DEST |
> -					   OFPIEH12_ROUTER | IPPROTO_FRAGMENT |
> +					   OFPIEH12_ROUTER | OFPIEH12_FRAG |
>  					   OFPIEH12_AUTH | OFPIEH12_UNREP)) ||
>  			    dest_options_header_count >= 2) {
>  				*ext_hdrs |= OFPIEH12_UNSEQ;

[Severity: High]
This isn't a bug introduced by this patch, but is the "case IPPROTO_ESP:"
arm being fixed here reachable at all?

The parse loop in get_ipv6_ext_hdrs() is gated on:

	while (ipv6_ext_hdr(next_type)) {

and ipv6_ext_hdr() in net/ipv6/exthdrs_core.c only accepts:

	return   (nexthdr == NEXTHDR_HOP)	||
		 (nexthdr == NEXTHDR_ROUTING)	||
		 (nexthdr == NEXTHDR_FRAGMENT)	||
		 (nexthdr == NEXTHDR_AUTH)	||
		 (nexthdr == NEXTHDR_NONE)	||
		 (nexthdr == NEXTHDR_DEST);

NEXTHDR_ESP (50) is not in that list, so when the header walk reaches an
ESP header the loop exits before the switch is entered.

Does that mean OFPIEH12_ESP is never OR-ed into key->ipv6.exthdrs, and
therefore the bit exported to userspace through OVS_KEY_ATTR_IPV6_EXTHDRS
(struct ovs_key_ipv6_exthdrs.hdrs) is always zero, so a flow matching
OFPIEH12_ESP=1 can never match?

If so, the ESP repeat test above, and the OFPIEH12_ESP term in the second
Destination Options mask, would also be dead, and the kernel-doc for
get_ipv6_ext_hdrs() which lists the "Encapsulating Security Payload header"
in the recommended ordering would describe behaviour the code cannot
produce.  Would handling ESP as an explicitly admitted terminal header,
rather than relying on the generic ipv6_ext_hdr() gate, be the right
direction here?

> @@ -301,7 +301,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  				*ext_hdrs |= OFPIEH12_UNREP;
>  			if ((*ext_hdrs &
>  			     ~(OFPIEH12_HOP | OFPIEH12_DEST | OFPIEH12_ROUTER |
> -			       IPPROTO_FRAGMENT | OFPIEH12_UNREP)) ||
> +			       OFPIEH12_FRAG | OFPIEH12_UNREP)) ||
>  			    dest_options_header_count >= 2) {
>  				*ext_hdrs |= OFPIEH12_UNSEQ;
>  			}

[Severity: Medium]
Does this hunk also change the reported flags for packets carrying two
Authentication Headers?

>From net/openvswitch/flow.h:

	OFPIEH12_ESP    = 1 << 1,
	OFPIEH12_AUTH   = 1 << 2,
	OFPIEH12_DEST   = 1 << 3,
	OFPIEH12_FRAG   = 1 << 4,
	OFPIEH12_ROUTER = 1 << 5,

IPPROTO_FRAGMENT is 44, which is 32 | 8 | 4, i.e. OFPIEH12_ROUTER |
OFPIEH12_DEST | OFPIEH12_AUTH.  So the old mask here happened to whitelist
OFPIEH12_AUTH as well, while the new mask (HOP | DEST | ROUTER | FRAG |
UNREP) does not.

A packet with two AH headers previously got only OFPIEH12_UNREP set, and
now gets OFPIEH12_UNSEQ in addition, which changes the userspace-visible
OVS_KEY_ATTR_IPV6_EXTHDRS value.  The new behaviour matches the ESP arm,
which already sets UNSEQ on a repeat, so it may well be intended, but since
this carries a Fixes: tag and is a stable candidate, could the commit
message mention this second change instead of only the fragment header
predecessor case?

[Severity: High]
This is a pre-existing issue, but the AH ordering verdict computed here
depends on the chain walk that follows it being correct, and the tail of the
loop in get_ipv6_ext_hdrs() advances with:

	hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
	if (!hp)
		break;
	next_type = hp->nexthdr;
	start += ipv6_optlen(hp);

Is ipv6_optlen() correct for an Authentication Header?  include/linux/ipv6.h
has:

	#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3)
	#define ipv6_authlen(p) (((p)->hdrlen+2) << 2)

and ipv6_skip_exthdr() in net/ipv6/exthdrs_core.c picks the latter:

	} else if (nexthdr == NEXTHDR_AUTH)
		hdrlen = ipv6_authlen(hp);
	else
		hdrlen = ipv6_optlen(hp);

For a common AH with a 96-bit ICV (hdrlen == 4) this walker advances 40
bytes instead of 24, so the next skb_header_pointer() reads ICV or payload
bytes chosen by the sender.

That value becomes next_type and drives all further advancement.  Can a
crafted AH packet therefore hide real headers that follow the AH (a second
Destination Options, Fragment, ESP), or fabricate OFPIEH12_FRAG /
OFPIEH12_ROUTER / OFPIEH12_DEST / OFPIEH12_UNSEQ / OFPIEH12_UNREP bits out
of payload data, letting flows keyed on the extension-header pseudo-field be
evaded?

Should this use ipv6_authlen() when next_type is IPPROTO_AH, the way the
core stack does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro%40redhat.com
