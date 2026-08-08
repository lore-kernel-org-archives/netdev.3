Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD833B2FC7;
	Sat,  8 Aug 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218509; cv=none; b=FFvwuiANBTY08zLav/4WIpxzq44betH261cxr/sAnq7Cdw9RrxIzC8pXO0knqPVihjEpIkBSUBAZeEfahRdlfQ3Xh/v/ba5BYeZLOs0Bul6dYJL43zj4QM17YTiQsQ+Xgclynr5R2w9L+VWDq3r7Eg235G38d/RU2dJ+wnkX3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218509; c=relaxed/simple;
	bh=S0/ksoVWu4eMG2NtgvzRC4h/zxjU87B5+OQhvo2ceZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJXCXvvfjB8k3TqBDVzO+H6FSTOth1qM/apbDnqXQjH9De/wfT/mL8azyeu2CC5XRTmMnRP4JNscu5T8PWu56K4rukGoQkCD2zfuEuzzkXU37oSJhUGLF905Y4NHOeW/KyfiZ8gf1/0ht6MTeLBbaRfEFT1CliGpPYEQoix4BTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQJ5N09t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQJ5N09t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD7E1F000E9;
	Sat,  8 Aug 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218507;
	bh=QT5V9DnroqFF7LhVXu5utoVefBI3jbPAXKoqn/bo8rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQJ5N09t9DuXBthTGuDN63DLQj81u7xaV1bbKBf6q7Jrw39/ys395wzOXO6nfTIVL
	 0mtz6gs1hgi0wiy/YnboNKyzelnRwq+vNlhWlMrZC4EJzjB3rTefTl3EvAkZ/JAqMl
	 ms4+lNojvOnD2tNPOPruH+YIpSLWBzalTeKlZ+8E44hpBUGTbZwtCURmbNympGHeMJ
	 Qzz9PJRdZ7RVj2UJTs+jVOnLr61fHAlX1SLan9tkVxFs9aWQZlmObWP7TNAib+LBT9
	 r0ExVQLVx+xcZFj8OTRdXNODVTcrYXmN187Foc4XPjOcMymd2gFOrQ0NOMxa1sVbHw
	 mCyWwTzQP5+Pg==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 09/20] net: dsa: tag_xlnx_tsn: add skeleton tag protocol
Date: Sat,  8 Aug 2026 12:48:26 -0700
Message-ID: <20260808194826.132977-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-10-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-10-nagadheeraj.rottela@amd.com>
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
net: dsa: tag_xlnx_tsn: add skeleton tag protocol

This adds DSA_TAG_PROTO_XLNX_TSN and a new tag driver for the AMD/Xilinx
TSN Endpoint Ethernet MAC, which carries port classification out of band
via a METADATA_HW_PORT_MUX metadata_dst instead of an in-band CPU tag.
The tagger is described as a no-op, with the PTP TX intercept deferred to
a later patch.

A few questions below.

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index d5e725b90d78..8ca48ce46ec1 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -221,4 +221,13 @@ config NET_DSA_TAG_YT921X
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Motorcomm YT921x switches.
>  
> +config NET_DSA_TAG_XLNX_TSN

[Severity: Low]
Should this symbol sit between NET_DSA_TAG_VSC73XX_8021Q and
NET_DSA_TAG_XRS700X instead of after NET_DSA_TAG_YT921X?  The Makefile
change in this same patch does place it alphabetically:

  obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
  obj-$(CONFIG_NET_DSA_TAG_XLNX_TSN) += tag_xlnx_tsn.o
  obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o

so the two lists no longer correspond.  This ordering is still the same at
the end of the series.

> +	tristate "Tag driver for AMD/Xilinx TSN Endpoint Ethernet MAC"
> +	help
> +	  Say Y or M if you want to enable support for the AMD/Xilinx TSN
> +	  Endpoint Ethernet MAC IP. The IP does not insert an in-band CPU
> +	  tag; port classification is conveyed via metadata_dst attached on
> +	  RX by the EP MAC driver, and PTP TX frames are intercepted in the
> +	  xmit hook to be steered into the per-MAC PTP TX register window.

[Severity: Low]
The help text tells the user that "PTP TX frames are intercepted in the
xmit hook to be steered into the per-MAC PTP TX register window", but
xlnx_tsn_xmit() added by this same patch is a bare pass-through with no
ETH_P_1588 classification and no tagger_data->ptp_tx() call, and the file
does not include <linux/dsa/xlnx_tsn.h> yet.

Would it make sense to add the second sentence of the help text together
with the later patch that implements it?  The commit message itself says
"A later patch adds the PTP TX intercept", so at this revision menuconfig
describes behaviour that is not present.

The mismatch does go away at the end of the series, where
xlnx_tsn_xmit() gains:

  net/dsa/tag_xlnx_tsn.c:xlnx_tsn_xmit() {
      ...
      if (eth_hdr(skb)->h_proto != htons(ETH_P_1588) ||
          skb_vlan_tag_present(skb))
              return skb;

      tagger_data->ptp_tx(dp, skb);
      return NULL;
  }

> +
>  endif

[ ... ]

> diff --git a/net/dsa/tag_xlnx_tsn.c b/net/dsa/tag_xlnx_tsn.c
> new file mode 100644
> index 000000000000..de352aa3d9a8
> --- /dev/null
> +++ b/net/dsa/tag_xlnx_tsn.c
> @@ -0,0 +1,33 @@

[ ... ]

> +static struct sk_buff *xlnx_tsn_rcv(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	kfree_skb(skb);
> +	return NULL;
> +}

[Severity: Low]
Could this drop be documented and made visible?  The commit message and
the Kconfig text describe a "no-op tag driver" that "has no tag bytes to
add or strip", but xlnx_tsn_rcv() destroys every skb it is handed, with no
drop reason, no counter and no comment.

The hook does look mandatory for the design, since the conduit RX
interception only happens when .rcv is non-NULL:

  include/net/dsa.h:netdev_uses_dsa() {
      return dev->dsa_ptr && dev->dsa_ptr->rcv;
  }

but that rationale is not stated anywhere in the file.

For frames that do carry the metadata dst attached by the EP MAC driver:

  drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c:ep_dma_rx_cb() {
      ...
      skb_dst_set_noref(skb, &ep->port_md[port_id]->dst);
      ...
  }

dsa_switch_rcv() takes the METADATA_HW_PORT_MUX branch and never reaches
this function.  Anything else falls into:

  net/dsa/tag.c:dsa_switch_rcv() {
      ...
      } else {
              nskb = cpu_dp->rcv(skb, dev);
      }
      ...
  }

so a conduit frame whose metadata dst was stripped, for example by a tc
ingress action on the conduit, disappears without showing up in
ip -s link, dropwatch or drop-reason tracing.  Would
kfree_skb_reason() plus a short comment explaining that the hook exists
only to make netdev_uses_dsa() true be preferable here?  This body is
unchanged at the end of the series.
