Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957F4B7A39
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023809; cv=none; b=i23DlFQqlL0NlJbExIFNmNpUFGCTJrMzmuOiQS5rClU3Nlbw/tqtbfesTY86Qs3fmmc196Z4PgxPtkO6qrtPQYFrUv5csf+pgysZd8phoh1HcVaRXQ0/wo8tlJ1OlV4fSAeYK3hH5mhf2QNe4kM0I74DO/aJ6mEAbgnGC+In8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023809; c=relaxed/simple;
	bh=EecgGsss6L1NYXP25zaBsDg09bcIdlxZKPLaNWLTMRo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzlXJV03h+wpadfcuFAMfOXjB6PDlojN3KQ3AcMi6LkbO22J50sfWn1DFTRiLDv7KWWUF9fwh1UL4CifsKY88/8K1zbFNZqqIubeR3+AskqUE7/i8gNJHKkRmwb7mU5Oe5fQoLXNjw52KS2NFjOKs+eyoQ1+XHSottkmCnG7B3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSOgJ4k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSOgJ4k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A271F00893;
	Mon, 21 Sep 2026 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023806;
	bh=/Y73nXPX/HtsiRzjBqZO3yo338pdC+0D9xf1HVB669U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PSOgJ4k3CtqpwVGzO4WAuVSadE+O3UyDD+6zzLMyKs/cs5goIYzoa6IC8TvsFlRgt
	 ypKI+mvQMu5teh4DmdltwPT80xLyEE/8IfGdg5LqWoBQTvPV6vLTrRwnPP1xVimLF5
	 ns1z78s6bsEEri5RvP7+jfHPrgV4y0g/l258EdbM+QzbokrHMs7xqkuFS3GjW/GxJ5
	 aF0gY77MknFlx4xePn92jWK/a1bVwgnOg2btnCflg9g7OsFXEdCPluFTmSfPiZZwcp
	 iOKOkDDswR7NyfmG6ClJOzAkUYlm9ldnbHP32J6IpG5QhtV8hj1PRk4MbIpvsndrnN
	 VNZtDTxyfmSIg==
Subject:
 Re: [PATCH net-next v2 3/4] net: core: resegment oversized TCP GSO skbs
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 dev@openvswitch.org, andrew+netdev@lunn.ch, jasowangio@gmail.com,
 willemdebruijn.kernel@gmail.com, ncardwell@google.com, kuniyu@google.com,
 alice@isovalent.com
Date: Mon, 21 Sep 2026 20:50:04 +0000
Message-ID: <179002380484.2160803.13955762820082413555@kernel.org>
In-Reply-To: <20260918084651.3022878-4-wang.zhan@smartx.com>
References: <20260918084651.3022878-4-wang.zhan@smartx.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Bounded resegmentation can emit GSO skbs whose L3 length exceeds
  65535, which inet_gso_segment()/ipv6_gso_segment() then silently…
- [Medium] Changing gso_within_device_limits() from skb->protocol to
  vlan_get_protocol(skb) (net/core/dev.c:3842-3848) silently alters the…

--

net: core: resegment oversized TCP GSO skbs

An unencapsulated TCP GSO skb which exceeds the egress device gso_max_size
or gso_max_segs is no longer fully segmented down to MSS sized packets.
Instead a per-output segment bound is computed and the skb is resegmented
into smaller GSO skbs which still fit the device limits.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 16685888b281..548db4d4e874 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3834,18 +3834,24 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
>  			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
>  }
>  
> +/*
> + * Does @skb fit the GSO limits of @dev?  The size limit depends on the L3
> + * protocol, which validate_xmit_vlan() replaces with the VLAN ethertype when
> + * it pushes the tag inside the skb, so look behind the tag.
> + */
>  static bool gso_within_device_limits(const struct sk_buff *skb,
>  				     const struct net_device *dev)
>  {
>  	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
> -	       skb->len < netif_get_gso_max_size(dev, skb->protocol);
> +	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));
>  }
>  
>  static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  					    struct net_device *dev,
> -					    netdev_features_t features)
> +					    netdev_features_t features,
> +					    bool check_limits)
>  {
> -	if (!gso_within_device_limits(skb, dev))
> +	if (check_limits && !gso_within_device_limits(skb, dev))
>  		return features & ~NETIF_F_GSO_MASK;

[Severity: Medium]

Does switching gso_within_device_limits() from skb->protocol to
vlan_get_protocol(skb) also change behaviour for the pre-existing limit
check, and not only for the new resegmentation path?

gso_features_check() is still reached with check_limits = true from
netif_skb_features(), which is an exported symbol used by the first
features computation in validate_xmit_skb(), by bonding/team, and by
qdiscs which segment via skb_gso_segment(skb, netif_skb_features(skb)).

For an skb with an in-band VLAN tag (skb->protocol == ETH_P_8021Q or
ETH_P_8021AD, e.g. a bridge-forwarded frame, or a frame after an earlier
__vlan_hwaccel_push_inside()) carrying IPv6, the limit selected by
netif_get_gso_max_size() changes:

  before: protocol == ETH_P_8021Q   -> dev->gso_ipv4_max_size
  after:  vlan_get_protocol() == ETH_P_IPV6 -> dev->gso_max_size

On a device with BIG TCP enabled for IPv6 only (gso_max_size >
gso_ipv4_max_size), such an in-band-tagged IPv6 TSO frame above
gso_ipv4_max_size is now handed to the driver where it was previously
software segmented.

The commit message only explains the change as a consequence of where the
new check sits:

  "That position is also why the limit follows the L3 protocol rather than
  skb->protocol: validate_xmit_vlan() replaces the latter with the VLAN
  ethertype when it pushes the tag inside the skb."

and patch 1 of the series, "net: core: factor out the GSO device limit
check", stated "No functional changes".

Could the change to the existing netif_skb_features() path be described
explicitly, or split into its own patch with a Fixes: tag if it is meant
as a fix?

>  
>  	if (!skb_shinfo(skb)->gso_type) {

[ ... ]

> @@ -3894,13 +3900,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	return features;
>  }
>  
> -netdev_features_t netif_skb_features(struct sk_buff *skb)
> +static netdev_features_t __netif_skb_features(struct sk_buff *skb,
> +					      bool check_gso_limits)
>  {
>  	struct net_device *dev = skb->dev;
>  	netdev_features_t features = dev->features;
>  
>  	if (skb_is_gso(skb))
> -		features = gso_features_check(skb, dev, features);
> +		features = gso_features_check(skb, dev, features,
> +					      check_gso_limits);
>  

[ ... ]

> @@ -3923,8 +3931,79 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
>  
>  	return harmonize_features(skb, features);
>  }
> +
> +netdev_features_t netif_skb_features(struct sk_buff *skb)
> +{
> +	return __netif_skb_features(skb, true);
> +}
>  EXPORT_SYMBOL(netif_skb_features);
>  

[ ... ]

> +static unsigned int
> +skb_gso_resegment_max_segs(struct sk_buff *skb, struct net_device *dev,
> +			   netdev_features_t features)
> +{
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int hdr_len, max_segs;
> +	unsigned int gso_max_size;
> +	struct tcphdr _tcph, *th;
> +
> +	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
> +

[ ... ]

> +	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
> +		  th->doff * 4;
> +	if (gso_max_size <= hdr_len + mss)
> +		return 0;
> +
> +	/*
> +	 * gso_within_device_limits() accepts gso_segs == gso_max_segs but
> +	 * rejects skb->len >= gso_max_size, so only the size bound needs - 1.
> +	 */
> +	max_segs = (gso_max_size - hdr_len - 1) / mss;
> +	max_segs = min_t(unsigned int, max_segs,
> +			 READ_ONCE(dev->gso_max_segs));
> +
> +	return max_segs > 1 ? max_segs : 0;
> +}

[Severity: High]

Should this bound also be clamped so that hdr_len + max_segs * mss stays
within what a 16-bit IPv4 tot_len or IPv6 payload_len can express?

The bound here derives only from netif_get_gso_max_size(dev, ...) and
dev->gso_max_segs. If the egress device itself has a BIG TCP limit above
64 KiB (veth calls netif_set_tso_max_size(dev, GSO_MAX_SIZE), so
"ip link set dev vethX gso_max_size 120000" is accepted) and the incoming
skb is larger still, the output skbs come out at roughly gso_max_size
bytes.

skb_segment() only tags the outputs as SKB_GSO_PARTIAL when features carry
NETIF_F_GSO_PARTIAL:

  net/core/skbuff.c:skb_segment() {
      ...
      type |= (features & NETIF_F_GSO_PARTIAL) / NETIF_F_GSO_PARTIAL * SKB_GSO_PARTIAL;
      ...
  }

So for software devices the outputs are ordinary GSO skbs, and the L3
segmenters take the non-partial branch, which truncates through htons():

  net/ipv4/af_inet.c:inet_gso_segment() {
      ...
          else
              tot_len = skb->len - nhoff;
      ...
      iph->tot_len = htons(tot_len);
  }

  net/ipv6/ip6_offload.c:ipv6_gso_segment() {
      ...
          else
              payload_len = skb->len - nhoff - sizeof(*ipv6h);
      ipv6h->payload_len = htons(payload_len);
  }

Neither uses the >64 KiB encodings the rest of the tree expects, where
iph_set_totlen() writes tot_len = 0 above IP_MAX_MTU and ip6_xmit() writes
payload_len = 0 above IPV6_MAXPLEN. Can the declared length therefore end
up as (len mod 65536), with a software receiver trimming the frame in
ip6_rcv_core() via ipv6_payload_len() and pskb_trim_rcsum(), and the
equivalent iph_totlen() path in ip_rcv_core()?

> +
>  static int xmit_one(struct sk_buff *skb, struct net_device *dev,
>  		    struct netdev_queue *txq, bool more)
>  {

[ ... ]

> @@ -4088,10 +4168,29 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  	if (unlikely(!skb))
>  		goto out_null;
>  
> -	if (netif_needs_gso(skb, features)) {
> +	/*
> +	 * An oversized skb loses its GSO feature bits and is segmented
> +	 * down to MSS sized skbs below.  A TCP skb can instead be split
> +	 * into GSO skbs which do fit the device, so keep the bits and
> +	 * bound the resegmentation.  The features computed without the
> +	 * limit checks say whether the device offloads the GSO type at
> +	 * all.
> +	 */
> +	if (skb_is_gso(skb) && skb_is_gso_tcp(skb) && !skb->encapsulation &&
> +	    !gso_within_device_limits(skb, dev)) {
> +		netdev_features_t offload = __netif_skb_features(skb, false);
> +
> +		resegment_max_segs =
> +			skb_gso_resegment_max_segs(skb, dev, offload);
> +		if (resegment_max_segs)
> +			features = offload;
> +	}
> +
> +	if (resegment_max_segs || netif_needs_gso(skb, features)) {
>  		struct sk_buff *segs;
>  
> -		segs = skb_gso_segment(skb, features);
> +		segs = __skb_gso_segment(skb, features, true,
> +					 resegment_max_segs);
>  		if (IS_ERR(segs)) {
>  			goto out_kfree_skb;
>  		} else if (segs) {

Is there anything between this point and dev_hard_start_xmit() which
re-validates the length of the resulting segments? With gso_max_size =
120000 on the egress device and a 200000 byte incoming skb,
skb_segment() computes partial_segs = min(len/mss, max_segs) and
mss *= partial_segs, so the outputs land around 119 KiB and reach the
driver unchecked, where the previous code produced MSS sized packets with
correct 16-bit lengths.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918084651.3022878-1-wang.zhan%40smartx.com
