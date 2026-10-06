Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3384A8A35;
	Tue,  6 Oct 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312259; cv=none; b=sMmNSnf/Dps94XO9LgJIUf+D3YS8bXFQ+lW3rnc2Qj4vxcA+A87EiWE8GL08GmhTHeKTANTTLN7xLk/i7xO5NN7XYbdkqa2wHir3uPnUv2o3MIhkLAPU7aJOqxZII+nmuhdAfudlS0ovqMTBE7x075k4tJsDtN+rnE2oZa8QvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312259; c=relaxed/simple;
	bh=hnjyQyoQKx0QqYhJeh/NWA7hgjLnITEXc6y/oxouJNo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGD+pTE8Ih4PCGiiOLHFG2/5VI5g2wwXlzgX0cdcP6NXp0eHZUje1cky3QSCcVF8IJdGd6/Q8sPLXp5mrnfDMS5+onjGUdImfapjWhwsYQ4dwTcq7JKvBuRPm437YQ1g6aCa4Qp3rDWc2azgxXsmsr6W2VOY9w3npvFi7IzBLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1gk+pmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1gk+pmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E165D1F0089C;
	Tue,  6 Oct 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312251;
	bh=3902MVaoy7oxRPS2bpzRRIlv4HX7rnx5iKoibWtn3kE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P1gk+pmk6/FPNinPoIiEF5bzYp67Ge2vQ+4pByDpEPthFFqH6PIK+IG5nATmZa6HN
	 xMxSiKhtkV4HlVPF/TzMI0KeOvijZHKdgD1jowSrT3WXB7XAi9AVYKp9m9JetV2D15
	 tgPwcR+EbvARyYSSAOit1PciE+VaMIvu42heNuIMBaEq6jaKvYVcNe4u6y/DoSfe5s
	 feN1RPavzp9fZ9LWBBPzlnZc6zgXPYkZEdbJC/aXkK4Q1lVL8h39Ao5EaYYZqQUPZM
	 MP6bPuK43za3c6acC7Nq9Re92z1GTBtbQtYfZQx+hDehp2x7Vd/WAe+bK3WhiJXyjq
	 DihetGFuIIqkw==
Subject: Re: [PATCH net-next v11 6/7] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:10 +0000
Message-ID: <179131225045.434549.15006490929783226716@kernel.org>
In-Reply-To: <20261002173706.1225502-7-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-7-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: dsa: tag_yt922x: add support for
  Motorcomm YT922x tags" is one line ('Add support for Motorcomm YT922x…
- [Low] Concern: yt922x_tag_rcv() never sets skb->offload_fwd_mark, so
  the software bridge would duplicate frames the hardware already…
- [Low] The new NET_DSA_TAG_YT922X entry in net/dsa/Kconfig is indented
  with spaces: 2 spaces before 'tristate' and 'help', and 4 spaces…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  yt922x_tag_rcv() calls dsa_conduit_find_user(netdev, 0, port) and so…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This commit adds a DSA tag driver for Motorcomm YT922x switches. The tag
is 8 bytes, EtherType based, and uses the same EtherType as YT921x
(0x9988). The commit also adds DSA_TAG_PROTO_YT922X and the Kconfig and
Makefile entries, and updates the existing YT921x MAINTAINERS entry.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3011f995437fd..1a48e4570c698 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18433,11 +18433,13 @@ F:	drivers/net/phy/motorcomm.c
>  
>  MOTORCOMM YT921X ETHERNET SWITCH DRIVER
>  M:	David Yang <mmyangfl@gmail.com>
> +M:	Kyle Switch <kyle.switch@motor-comm.com>

[Severity: Low]
This isn't a bug, but the commit message is one sentence:

  Add support for Motorcomm YT922x tags with 8bytes. which includes
  ethertype field (default to 0x9988).

It doesn't mention this new M: line. The existing entry already has a
maintainer and covers drivers/net/dsa/motorcomm/, the DT binding and
tag_yt921x.c. Should the co-maintainer addition be a separate patch with
an ack from David Yang?

The commit message also doesn't say why YT922x needs a new tag protocol.
It uses the same ETH_P_YT921X EtherType and the same 8-byte length as
tag_yt921x. Could that be explained?

In net/dsa/tag_yt922x.c, the only description of the wire format is:

  /*
   * To define the from cpu tag format 8 bytes.
   */

The to-CPU layout isn't described at all. tag_yt921x.c, by contrast, has
a full bit layout diagram. Could both directions be documented here?

Some examples are that bits 5:2 of tag[2] carry the RX source port, and
that bit 15 of tag[2] selects TX port 0. It would also help to say why
the RX path doesn't check a valid bit, restore the priority or decode a
forward code.

>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
>  F:	drivers/net/dsa/motorcomm/
>  F:	net/dsa/tag_yt921x.c
> +F:	net/dsa/tag_yt922x.c

[ ... ]

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 4f44bf3ede238..86802058678c0 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -233,4 +233,10 @@ config NET_DSA_TAG_YT921X
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Motorcomm YT921x switches.
>  
> +config NET_DSA_TAG_YT922X
> +  tristate "Tag driver for Motorcomm YT922x switches"
> +  help
> +    Say Y or M if you want to enable support for tagging frames for
> +    Motorcomm YT922x switches.

[Severity: Low]
This isn't a bug, but this entry is indented with spaces. The
NET_DSA_TAG_YT921X entry just above it, and the rest of net/dsa/Kconfig,
indent attributes with one tab and help text with a tab plus two spaces.

[ ... ]

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 0000000000000..3c9fef651cf51
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c

[ ... ]

> +static struct sk_buff *
> +yt922x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{

[ ... ]

> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[2]);
> +	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);

[Severity: High]
This isn't a bug introduced by this patch, but the new tagger inherits an
existing race in the DSA receive path. Can dsa_conduit_find_user() see a
NULL dev->dsa_ptr here?

dsa_switch_rcv() checks the pointer once, before it calls the tagger:

net/dsa/tag.c:dsa_switch_rcv() {
    struct dsa_port *cpu_dp = dev->dsa_ptr;
    ...
    if (unlikely(!cpu_dp)) {
        kfree_skb(skb);
        return 0;
    }
    ...
}

dsa_conduit_find_user() then reloads it and dereferences it without a
check:

net/dsa/tag.h:dsa_conduit_find_user() {
    struct dsa_port *cpu_dp = dev->dsa_ptr;
    struct dsa_switch_tree *dst = cpu_dp->dst;
    ...
}

Meanwhile, teardown clears the pointer under RTNL while the conduit can
still be receiving frames:

dsa_unregister_switch()
  dsa_tree_teardown()
    dsa_tree_teardown_conduit()
      dsa_conduit_teardown()
        dev->dsa_ptr = NULL;
        wmb();

The wmb() only orders the store. Nothing like synchronize_net() waits for
receive callbacks that are already running.

Suppose the store lands after the check in dsa_switch_rcv() but before
the reload in dsa_conduit_find_user(). Would the NET_RX softirq then
dereference NULL->dst? Every tagger that uses dsa_conduit_find_user() has
the same pattern.

> +	if (unlikely(!skb->dev)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Couldn't decode source port %u\n", port);
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}

[Severity: Low]
This isn't a bug with the series as it stands, but yt922x_tag_rcv() never
sets skb->offload_fwd_mark.

That is fine today. yt922x_dsa_switch_ops in
drivers/net/dsa/motorcomm/chip.c has no .port_bridge_join, so
dsa_user_changeupper() falls back to a software bridge.

yt922x_port_setup() also isolates each user port so that it can only
reach the CPU port:

	ctrl = ~priv->cpu_ports_mask;
	res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port), ctrl);

If bridge offload is added later, would this tagger have to decode the
hardware forward or reason code and set offload_fwd_mark, as tag_yt921x
does? Otherwise the bridge could forward duplicate frames.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
