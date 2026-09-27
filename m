Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC1350298;
	Sun, 27 Sep 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790485858; cv=none; b=fjr7mQNdF06/xoXZuPbaG8YuPtC/5Mm1sTToghd4o9N/4mHvamEA6mV+s0yxaXXjiBQ+ov7R2nht6zHdhhdh5ybu5o0lSYPxjV4q+Tobgw/zLgIYJLRHWaRP0l8no1mC/nopGq3aXJjuGf1fbP/BCuAYzNCKO4wJwEsQYXAm3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790485858; c=relaxed/simple;
	bh=VSaqCwmdgw4zEq64XsGySiKl+BDauDQmoCCdTeBnXEo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZBCgbumbdeyzUwDoLKMxdXLdNCVV35L0pTsFs8NSTVecchWy+nsFO/VBs+xP6TwW0wUJMUqeiy4czHI5X6BeuVHwcdzCT/y2rzMRYXJgwuB4psUIkgC8QlEimVGxkhuNB3A8dy1q8km9Xm78PyEX7r7dRVNvi86xJfJrb1KXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtQdJYH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtQdJYH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8001F000FF;
	Sun, 27 Sep 2026 05:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790485856;
	bh=wB4Y83HrU5R7uYVDpiRV5wyAcrv1RqlEI7idRPirndc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RtQdJYH+jNCeVHGVJKpDRWln3tw8WMBzZWeKUzSQ+JUu62BzzWLQ4Y4uTsbBGFxpI
	 azsycVbN3+CpZTdjnHM4PegFYsYsh7H0sMPTTXQxDK/nAYd80f61e9lLt80oH/7sqk
	 m4Lb07lcP4XYqzU0lW7cNgAItkuKaLt21ENbwmdR0Seqp3LlBJrr4lxqSVUN16NE2B
	 eFqaEzZW9WuCTdrIGIuWxlko5cwGDyciY4oBkV9dQFP8eILxC0hmBiGNISqAeor7ik
	 FXDVGNBTmGuazVh7zxBSKXUsxDd6DQ3Ync2nNbI1BLS8xvYyXREGFoatcowRK2LAkV
	 HNRj56tv2RzKQ==
Subject: Re: [PATCH net] seg6: fix HMAC validation when an extension header
 precedes the SRH
From: netdev-bot+sashiko@kernel.org
To: yuya.kusakabe@gmail.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, david.lebrun@uclouvain.be, amsalam20@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 05:10:55 +0000
Message-ID: <179048585564.2160803.7331664213685103969@kernel.org>
In-Reply-To:
 <20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com>
References:
 <20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the misread header "is covered by the
  pskb_may_pull() in seg6_get_srh(), so the result is a wrong verdict,…
- [Medium] The code change is correct, but the commit message describes
  the bug only as a false drop (a 'wrong verdict' that rejects a…

--

seg6: fix HMAC validation when an extension header precedes the SRH

This patch passes the SRH found by the caller into
seg6_hmac_validate_skb(). Before, the function derived the SRH from
skb_transport_header(). On the seg6_local input path the transport header
can still point at an extension header that sits in front of the SRH, so
the HMAC was checked against the wrong header.

> The HMAC is therefore computed over the Destination Options header,
> and a packet carrying a valid HMAC TLV is dropped when
> seg6_require_hmac is set.

[Severity: Medium]
Does this cover the whole impact of the bug? Before this patch, the
mismatch could also let through packets that should have been rejected,
even with seg6_require_hmac=1.

seg6_hmac_compute() only hashes saddr, first_segment, flags, hmackeyid
and the segment list:

net/ipv6/seg6_hmac.c:seg6_hmac_compute() {
    ...
	/* saddr(16) + first_seg(1) + flags(1) + keyid(4) + seglist(16n) */
	plen = 16 + 1 + 1 + 4 + (hdr->first_segment + 1) * 16;
    ...
}

It does not hash nexthdr, hdrlen, type or segments_left. A sender who has
captured one SRH with a valid HMAC could:

1. copy the captured bytes into a Destination Options header and set its
   nexthdr byte to IPPROTO_ROUTING. ipv6_find_hdr() sizes this header
   with ipv6_optlen(), the same way it sizes an SRH, and does not check
   the option TLVs.
2. append an SRH of its own choosing, with segments_left > 0.
3. send the packet to the SID from the captured source address.

The old seg6_hmac_validate_skb() took srh from skb_transport_header(),
which points at the Destination Options copy, so the captured HMAC would
match.

get_and_validate_srh(), decap_and_validate() and end_flv8986_core() would
then act on the SRH returned by seg6_get_srh(). That is the
unauthenticated SRH.

A similar splice looks possible with a leading routing header that has
segments_left=0, because get_and_validate_srh() passes IP6_FH_F_SKIP_RH
to seg6_get_srh().

This patch closes the hole, since the HMAC is now checked over the same
pointer that is processed afterwards. Should the changelog describe this
HMAC bypass as well as the false drop?

> The misread header is covered
> by the pskb_may_pull() in seg6_get_srh(), so the result is a wrong
> verdict, not an out-of-bounds access.

[Severity: Medium]
Does this statement hold for every header that can sit in front of the
SRH?

The code change looks correct. However, the same root cause can be hit
when a Fragment header with a zero fragment offset, or an AH header, sits
between the IPv6 (or Hop-by-Hop) header and the SRH. ipv6_find_hdr() steps
over both of them:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
			_frag_off = ntohs(*fp) & ~0x7;
			if (_frag_off) {
				...
			}
			hdrlen = 8;
		} else if (nexthdr == NEXTHDR_AUTH) {
			...
			hdrlen = ipv6_authlen(hp);
    ...
}

So seg6_get_srh() pulls the real SRH further down the chain. Meanwhile
the transport header set in ip6_rcv_core() still points at the Fragment
or AH header.

In a Fragment header, the byte the old code read as srh->hdrlen is the
reserved byte, and first_segment and flags are Identification bytes. In
AH they are the payload length byte and SPI bytes. The sender controls
all of these bytes.

Take reserved = 255, id[0] = 0 and id[1] = 0x08. With those values
seg6_get_tlv_hmac() passes both its hdrlen check and sr_has_hmac(), and
then does:

net/ipv6/seg6_hmac.c:seg6_get_tlv_hmac() {
    ...
	tlv = (struct sr6_tlv_hmac *)
	      ((char *)srh + ((srh->hdrlen + 1) << 3) - 40);

	if (tlv->tlvhdr.type != SR6_TLV_HMAC || tlv->tlvhdr.len != 38)
    ...
}

That reads 2008 bytes past the Fragment header. With a minimal 24-byte
real SRH, the pskb_may_pull() in seg6_get_srh() only guarantees about 72
bytes of linear data. Can this read go past skb->len, and even past
skb->end?

For AH, the misread length is larger than the real AH length by four
times the AH length byte.

The pre-patch seg6_hmac_validate_skb() called seg6_get_tlv_hmac() before
it looked at seg6_require_hmac. Wouldn't this read then happen with any
sysctl value, including the default of 0? If the bytes there happen to
match, tlv->hmackeyid and tlv->hmac would also be read out of bounds.

This patch does fix these cases, because it now passes the SRH that
seg6_get_srh() validated. Could the changelog describe the out-of-bounds
read reachable through get_and_validate_srh(), decap_and_validate() and
end_flv8986_core(), instead of saying the result is only a wrong verdict?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-b4-seg6-hmac-transport-header-v1-1-3ae85dc0fdb9%40gmail.com
