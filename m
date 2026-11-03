Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692526;
	b=aqG/gcB3OWbeKeb/kxSRqVlDi/ihjNrAqEN6Yq28XSDce0jeX8GRlDxg4ImmU3yB6I5/
	 6NqBQx+LQuruuCLlneCKlUIP5kFKr5Nf5ATF8DeWj7qcSXkQ8DgjOEVIYH1i79Jmdy8lp
	 Zsl0QsOAe4EiHZb1vKH4fSTyrvhz7USweKAF5RS7SB7YDatUs4qiiaGpGuZocEt+2nKYb
	 FiAkKMaJ/dEEHj+8O3TZUO3rCfwXZORr+LJBqZ9oaXQgcR2/rinmVI4loR6b7VKUPj6Vk
	 k6WjsNUs3jUDpS57Bc8oLkxv5F3hc3jUuhh2BG0LSrv0T+A4vld49xszp61jOJiUgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692526;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bb6BgZSBzPk54W//sDNNb8p0kiKtn/n37kN4ZJY96f8=;
	b=tGB3B8qP0mUS97XR89ztUtidFQVxmwrqbeWRRj0bvGNqo7PwpCQQqhq9SA52br1d3mxP
	 h9VD+I4eJnNSX9p/4VepmsDrVhVMD9J6SjmjT98TV7i6xnUE79Fgdb0b1zzL7SPvgrtBD
	 x7EHn0q6GB7FTGmPWcOcI0u2GWpUr65He6V4jbRHUvbzfhmuIaSloDC7wv+SNbLiemdDw
	 Zx+Yh/rYxE0v/9maKyrPxQ2u2hu0+yR6PScqaha/+h+4YadOZ6ftLjx2jDeekEuNQ5snB
	 VCsGpBcC9hgiS2dTyhbU8KaXzTHE1P5LbtMHq4etkWF04vYhkBgHWgIa2q/BmFcWOiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMfDg5n5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C3606A329;
	Tue,  3 Nov 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMfDg5n5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B251F000C1;
	Tue,  3 Nov 2026 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692526;
	bh=bb6BgZSBzPk54W//sDNNb8p0kiKtn/n37kN4ZJY96f8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dMfDg5n5ZpSq9zWJs/Z3rxKBJtLSmEL1qvhU8Oa5ge0xDb8QHtK9NYBMfzywS+awC
	 ij3hiL1YwHx/yHYBWBLYHpTwT94CpD0OTLYaPaec3EBLtZoZ7Opl4EyJvUJ0SbvBHF
	 Rkd8EJTRw9Pn1vwrIj2Q+u2ET+ICKU6HW8h5gNad1Xgf9c3MeI0/hVd5cZsyfCqASs
	 425ed0id3H3lRYA3bSiaTt7chrYYcPoMvLOG2cVd4Dr4/WSwtt3qIm9YzwmzBMpXLR
	 OlF9oPamKs04CCxEcrYNFmH9g86xOU1Ga5MtM/v//pBD/o6GjLOSYsic5RYKyfjP+B
	 2C8Qy2fkJuEnQ==
Subject: Re: [PATCH net 2/4] net: dsa: motorcomm: Fix IPv4/IPv6 address key
 dispatch in flower
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 07:55:25 +0000
Message-ID: <179369252510.488856.6603340329074881644@kernel.org>
In-Reply-To: <20261102071119.3435180-3-mmyangfl@gmail.com>
References: <20261102071119.3435180-3-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit replaces the used_keys presence checks with a
  control.addr_type check, and this introduces a regression.
- [Medium] The commit message describes a bug that does not exist in this
  tree.

--

net: dsa: motorcomm: Fix IPv4/IPv6 address key dispatch in flower

This patch changes yt921x_acl_rule_ext_parse_flow_entries() so that it
chooses the IPv4 or IPv6 address block from control.addr_type. Before,
it checked whether the matching address key was set in used_keys. The
commit message says flow_rule_match_key() reports both address keys
when only one of them is used.

> The IPv4 and IPv6 address keys share the same storage in struct
> flow_rule, so flow_rule_match_key() reports both as present whenever
> either one is. As a result, IPv4 address rule may generated bogus IPv6
> address bins, and vice versa.

[Severity: Medium]
Is this description accurate? flow_rule_match_key() is just
dissector_uses_key(), which tests one bit in used_keys:

include/net/flow_dissector.h:dissector_uses_key() {
	return flow_dissector->used_keys & (1ULL << key_id);
}

FLOW_DISSECTOR_KEY_IPV4_ADDRS and FLOW_DISSECTOR_KEY_IPV6_ADDRS are
separate bits.

In flower, struct fl_flow_key has separate ipv4 and ipv6 members (not a
union). fl_set_key() fills in only one family. fl_init_dissector()
registers each key on its own, based on that key's own mask:

net/sched/cls_flower.c:fl_init_dissector() {
    ...
	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
			     FLOW_DISSECTOR_KEY_IPV4_ADDRS, ipv4);
	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
			     FLOW_DISSECTOR_KEY_IPV6_ADDRS, ipv6);
    ...
}

fl_hw_replace_filter() then passes that dissector to the driver
unchanged.

In nftables offload, nft_flow_key does put ipv4 and ipv6 in a union.
However, nft_payload_offload_ip() and nft_payload_offload_ip6() only
set the bit for the family being matched.

Is there a path where both bits end up set? If not, the old code looks
correct for these inputs. The patch has a Fixes: tag and will be
backported, so could the commit message be corrected, or could it
include a reproducer?

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 8835907366bf7..5a4459507582d 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -603,8 +604,15 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
> +		struct flow_match_control match;
> +
> +		flow_rule_match_control(rule, &match);
> +		addr_type = match.key->addr_type;
> +	}
> +
>  	/* Entries */
> -	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
> +	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
>  		struct flow_match_ipv4_addrs match;
>  
>  		flow_rule_match_ipv4_addrs(rule, &match);
> @@ -630,7 +638,7 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
>  		}
>  	}
>  
> -	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
> +	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
>  		struct flow_match_ipv6_addrs match;
>  
>  		flow_rule_match_ipv6_addrs(rule, &match);

[Severity: High]
Can this program bogus IPv6 bins when the IPv6 address mask is all
zero?

fl_set_key() sets addr_type whenever an IPv6 src or dst attribute is
present, whatever the mask is:

	} else if (tb[TCA_FLOWER_KEY_IPV6_SRC] || tb[TCA_FLOWER_KEY_IPV6_DST]) {
		key->control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
		mask->control.addr_type = ~0;

fl_init_dissector() only registers FLOW_DISSECTOR_KEY_IPV6_ADDRS through
FL_KEY_SET_IF_MASKED. Take a rule like this:

  tc filter add dev swp0 ingress protocol ipv6 flower skip_sw \
      src_ip ::/0 action drop

It ends up with addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS, but with no
IPV6_ADDRS bit in used_keys.

skb_flow_dissector_init() memsets the dissector, so
offset[FLOW_DISSECTOR_KEY_IPV6_ADDRS] stays 0. skb_flow_dissector_target()
adds that offset without checking whether the key is present. As a
result, flow_rule_match_ipv6_addrs() returns key and mask pointers to
the start of struct fl_flow_key (meta, control, enc_control, basic, ...).

With that layout, mask->src.s6_addr32[2] overlays control.thoff and
control.addr_type, and the addr_type mask is 0xffff. mask->dst.s6_addr32[2]
overlays basic.n_proto and basic.ip_proto, and the n_proto mask is 0xffff
when a protocol is given.

Wouldn't the loops then create YT921X_ACL_TYPE_IPV6_SA2 and
YT921X_ACL_TYPE_IPV6_DA2 entries keyed on addr_type and the 0x86dd
EtherType? The hardware rule would then match only IPv6 packets whose
address words happen to equal those values, not all IPv6 traffic.

Other matches such as ip_flags or dst_mac can add SA3/DA3 bins in the
same way. The extra bins can also push an otherwise valid rule into the
"Rule too complex" error path.

Before this patch, flow_rule_match_key(rule,
FLOW_DISSECTOR_KEY_IPV6_ADDRS) returned false here and the block was
skipped.

The IPv4 branch has the same structure. It is harmless today only
because offset 0 hits the meta key, and the meta mask is zero since META
is rejected in used_keys.

This also looks to be still present at the end of the series. The
commit "net: dsa: motorcomm: Delete the ACL rule of the port being
unbound" keeps the addr_type-only conditions.

Would it work to keep the presence check and add the addr_type check on
top of it? For example:

	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS &&
	    flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {

and the same for the IPv4 branch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102071119.3435180-1-mmyangfl%40gmail.com
