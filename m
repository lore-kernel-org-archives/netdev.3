Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636248;
	b=TWrvCR4R6kO1w0m2MW/A/z9uYmrzZext8DX0x9W/QmbX/i/orCs9pjFEGm4SVLQiE2AA
	 nuMheRzJEaqkAuvAh8qZ1iprG45a8Z2hHSiXlK0T4HySEgPSr/ZlieKOAupYWePQbwa8G
	 8h03UsssWqe2y3T5h05KmP8zZBOOY9JCtAodlwPrJj8aotTTlS+d7BU+karHl6kg1kbzQ
	 uGn7Q24T15q2bjjYQJ3U5aVByVoA52hyYelQeM/fjsESjU9HSdP9mud8Am5b8DGOebg/p
	 AGp9/+4jX9/OY8ErdtVt2V+Yuecx4Vs+MijrwgJ7id6tgwC09vRmI3aAZ0ejyCa8BVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636248;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sQ4T+b16Ti6+mg2ejejZKdmeCXOYlBVVk4FdYTSpBjg=;
	b=Sq9glSCmogqx2PMPRPowjqaY76U1Mt94IAhI7iplb100AnE+TbkmwKn9liPW0a2fJc7n
	 NV+ReiddYzFawCYD4s9ScZybp2Z7zS+b956S1lQTQpiMY9Zk48K57PwYOMPQMBTS6WX7N
	 KGuTU75ZomrORAS7or3ZIme06te+CQTmYrYWWRTy1Xdji2ikwYHlX4Ns5rqcT4MIjykdV
	 X9tTnSD226/8hEFnUaM+UMFOIOcW/7E7xzsnA31gd8w1QOjlGJ+BCCzByHEblYEMJfyyC
	 Zl2LBUM7LMuv3FhAgGDIcSBWDWKvGxEoIk6hnaEQUP2F0ksNAGKQy/omVREOdiLVMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChoCscwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAA606AB88;
	Mon,  2 Nov 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChoCscwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D27C1F00A20;
	Mon,  2 Nov 2026 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636247;
	bh=sQ4T+b16Ti6+mg2ejejZKdmeCXOYlBVVk4FdYTSpBjg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ChoCscwvUb8H/au752uRMGege38AvkMz6RfCL3trMS1vzmjN5ZndvlpGp21zQqNQo
	 yfWp15FOL/ZEcVaABLMIIv9pnxj5Z0QE5OHLUne+GB/AwB6c7KOBw+iUBwJ0jXbtst
	 COMxk0Qa1Gsuiw8oM898imohkLzN5Ojri21/0RD/IGnusGAOOdpvl69fRV9kXimg0y
	 bBMXrGYlQ1rwCWxu6N15Uwpbji7hnOR/zvEKdIqamums7r2PgMryeZ6mQYiMFAkEGe
	 Py/bhAgugemPc+grIhnnUMnjmzEMnaqwX82HpVMzJoizLwUrpyDTIFDbj4PQn6NsOp
	 QP3qvFEm0KWUQ==
Subject: Re: [PATCH net] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, cpp.code.lv@gmail.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 16:17:26 +0000
Message-ID: <179363624604.3131.17678557171151335962@kernel.org>
In-Reply-To: <179328922134.76862.10417963652853801970@gmail.com>
References: <179328922134.76862.10417963652853801970@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete for non-first fragments.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but OFPIEH12_ESP
  is never set.
- [Low] This problem wasn't introduced by this patch, but a single
  Destination Options header in the final-destination position is…
- [Low] This problem wasn't introduced by this patch, but repeated Hop-
  by-Hop headers are not reported as OFPIEH12_UNREP when the first one…

--

openvswitch: advance by the real header length in get_ipv6_ext_hdrs()

get_ipv6_ext_hdrs() used to move past every extension header with
ipv6_optlen(). That length is wrong for AH and Fragment headers. This
patch advances by sizeof(struct frag_hdr) for Fragment headers and by
ipv6_authlen() for AH, so the OFPIEH12_* bits come from the headers that
are actually present.

Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/

> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 1c4f3a0790443..a1c60d2f552cf 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -372,8 +372,13 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
>  		if (!hp)
>  			break;
> +		if (next_type == IPPROTO_FRAGMENT)
> +			start += sizeof(struct frag_hdr);
> +		else if (next_type == IPPROTO_AH)
> +			start += ipv6_authlen(hp);
> +		else
> +			start += ipv6_optlen(hp);
> +		next_type = hp->nexthdr;

[Severity: High]
Can payload bytes still set the exthdrs bits when the packet is a
non-first fragment?

The IPPROTO_FRAGMENT case in get_ipv6_ext_hdrs() sets OFPIEH12_FRAG and
never reads frag_off. This branch then always advances 8 bytes and
follows hp->nexthdr.

RFC 8200 says every fragment carries the Next Header value of the first
header in the Fragmentable Part. Take IPsec AH transport mode with
fragmentation as an example. A later fragment shows up as
FRAG(offset != 0, nexthdr = AH).

The bytes after that Fragment header are payload from the middle of the
packet. The next loop iteration still parses them as an ipv6_opt_hdr:
payload[0] is taken as the next type and payload[1] as the length.
Payload bytes such as 0, 43, 44, 51 or 59 would then set HOP/UNSEQ,
ROUTER, FRAG/UNREP, AUTH/UNREP or NONEXT for headers that are not there.

The commit message says the walk now advances "as ipv6_find_hdr() does".
However, ipv6_find_hdr() stops at non-first fragments:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
			_frag_off = ntohs(*fp) & ~0x7;
			if (_frag_off) {
				if (target < 0 &&
				    ((!ipv6_ext_hdr(hp->nexthdr)) ||
				     hp->nexthdr == NEXTHDR_NONE)) {
					if (fragoff)
						*fragoff = _frag_off;
					return hp->nexthdr;
				}
				if (!found)
					return -ENOENT;
    ...
}

The wrong bits also seem to reach the flow key. parse_ipv6hdr() calls
get_ipv6_ext_hdrs() before ipv6_find_hdr(). In the
FRAG(offset != 0, nexthdr = extension header) case, ipv6_find_hdr()
returns -ENOENT and leaves frag_off at 0. parse_ipv6hdr() therefore
sets OVS_FRAG_TYPE_FIRST and returns -EPROTO. key_extract_l3l4() then
treats that as success:

net/openvswitch/flow.c:key_extract_l3l4() {
    ...
			case -EPROTO:
				skb->transport_header = skb->network_header;
				error = 0;
				break;
    ...
}

key->ipv6.exthdrs is never cleared on this path. Flows that match on
OVS_KEY_ATTR_IPV6_EXTHDRS would still misclassify these packets. The
tests in the changelog only cover Fragment headers with offset 0.

Would it make sense for the IPPROTO_FRAGMENT case to read frag_off with
skb_header_pointer() and stop the walk when ntohs(frag_off) & ~0x7 is
non-zero?

>  	}
>  }
>

[Severity: Medium]
This is a pre-existing issue and the patch doesn't introduce it, but is
OFPIEH12_ESP ever set? The loop in get_ipv6_ext_hdrs() is guarded by:

	while (ipv6_ext_hdr(next_type)) {

ipv6_ext_hdr() returns true only for HOP, ROUTING, FRAGMENT, AUTH, NONE
and DEST:

net/ipv6/exthdrs_core.c:ipv6_ext_hdr() {
	return   (nexthdr == NEXTHDR_HOP)	||
		 (nexthdr == NEXTHDR_ROUTING)	||
		 (nexthdr == NEXTHDR_FRAGMENT)	||
		 (nexthdr == NEXTHDR_AUTH)	||
		 (nexthdr == NEXTHDR_NONE)	||
		 (nexthdr == NEXTHDR_DEST);
}

NEXTHDR_ESP is not in that list, so the loop exits before case
IPPROTO_ESP can run. flow.h documents OFPIEH12_ESP as "Encrypted Sec
Payload header present", and the bit is exported through
OVS_KEY_ATTR_IPV6_EXTHDRS. A flow matching ESP=1 can never match, and a
flow matching ESP=0 matches every ESP packet. The OFPIEH12_ESP check in
the second DSTOPTS mask is dead code for the same reason.

If the loop guard is ever changed to include ESP, the new length
dispatch in this patch would send ESP to ipv6_optlen(hp). That reads SPI
bytes as a length, so ESP would need an explicit stop there.

This patch does not change ESP behaviour. Before the patch, an AH
followed by ESP also reached next_type == ESP, because next_type comes
from the AH header's own nexthdr field.

[Severity: Low]
This isn't a bug introduced by this patch, but should a single
Destination Options header in the final-destination position really get
OFPIEH12_UNSEQ? The first DSTOPTS seen in get_ipv6_ext_hdrs() is only
accepted if it comes after HOP:

		case IPPROTO_DSTOPTS:
			if (dest_options_header_count == 0) {
				if (*ext_hdrs &
				    ~(OFPIEH12_HOP | OFPIEH12_UNREP))
					*ext_hdrs |= OFPIEH12_UNSEQ;

Take IPv6 -> Routing -> DSTOPTS -> TCP, or AH -> DSTOPTS. ROUTER or AUTH
is already set by then, so UNSEQ is set. The changelog's own test result
shows this: "AUTH DEST UNSEQ".

The comment above the function lists the preferred order as Hop, Dest,
Routing, Fragment, AH, ESP, Dest, upper-layer. Routing -> Dest and
AH -> Dest both follow that order. The count of DSTOPTS headers seen so
far is being used as if it were the header's position.

[Severity: Low]
This is a pre-existing issue, but are repeated Hop-by-Hop headers missed
when the first one is out of sequence? In get_ipv6_ext_hdrs():

		case IPPROTO_HOPOPTS:
			if (*ext_hdrs & OFPIEH12_HOP)
				*ext_hdrs |= OFPIEH12_UNREP;
			...
			if (*ext_hdrs == 0)
				*ext_hdrs |= OFPIEH12_HOP;
			else
				*ext_hdrs |= OFPIEH12_UNSEQ;

OFPIEH12_HOP is only set when HOP is the first header. Take
IPv6 -> Routing -> HOP -> HOP -> TCP. The first HOP sees ROUTER already
set, so it sets UNSEQ but not HOP. The second HOP finds HOP clear and
also sets only UNSEQ.

UNREP stays clear even though two HOP headers are present.
ipv6_find_hdr() checks neither order nor repetition, so a short chain
like this passes and the missing bit stays in the flow key.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179328922134.76862.10417963652853801970%40gmail.com
