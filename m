Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B7394E93
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461961; cv=none; b=H7yeJxsOuch6S2f9IOlJyrK/k8PatShefpAOu6J76wh2pyUdVE0MIf6uzWB7t7AwxTsUtF6UrECcFL17+5uddpfWkdUbB00EWUKgO5/bsIik6VCozvY1SawGaKb9nsFXKkSt4n0LZUc3bDYKYghzvqeFbBPPFFTKupllu2QjCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461961; c=relaxed/simple;
	bh=320r+oyW/T9Tuyz19NvqQ0SNTPSmOrOd0AWXb3S8GTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R77ywZUfNrLQ1YyOWXRJYJNmemEGtJS40A1E+tlP76QaQgqVaRTgKsKNyJuutBmdKyNUsPPOhdmMkunRJVNsfKnmaTgjmzja3uflo2dxV7jBbtwArtpkHrJsomHSI/qUCigufDBFOor6QfR94JURuwCw48/db9h1taLIc3c1jrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4ZtyRe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4ZtyRe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789461958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaalKZpGXSdogpAvoEIeBp287a70gtQtS3ba2TJDkjw=;
	b=I4ZtyRe6/RiSlBrRItX8gk+WzLGUewb8HgC1ccG+UehEszQVv3H0ZZu6mh6pH+jXkm0MY4
	Kz1kh3mp1lglVF4qitSRtDWEHpSfmGAKjLsa3C6zs8/D14c2FSSs4xl3Hxw6eIeHJAPnmc
	iiWO31Y/FBS94+xXe9LrIoVWvMDYIp0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-Pppr5pa7PTWckKt1QuduCQ-1; Tue,
 15 Sep 2026 04:45:52 -0400
X-MC-Unique: Pppr5pa7PTWckKt1QuduCQ-1
X-Mimecast-MFC-AGG-ID: Pppr5pa7PTWckKt1QuduCQ_1789461949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B013E1801214;
	Tue, 15 Sep 2026 08:45:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86EF3180035F;
	Tue, 15 Sep 2026 08:45:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	alexis.lothore@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel@esmil.dk,
	minda.chen@starfivetech.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jan.petrous@oss.nxp.com,
	ovidiu.panait.rb@renesas.com,
	Jose.Abreu@synopsys.com,
	nb@tipi-net.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	david.laight.linux@gmail.com
Subject: Re: [PATCH net v3 1/6] net: stmmac: selftests: Support running selftests on DSA conduits
Date: Tue, 15 Sep 2026 10:45:30 +0200
Message-ID: <20260915084530.75251-1-pabeni@redhat.com>
In-Reply-To: <20260911212028.1497613-2-maxime.chevallier@bootlin.com>
References: <20260911212028.1497613-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: selftests: Support running selftests on DSA conduits

The patch wraps the selftests' dev_add_pack()/dev_remove_pack() calls in
new stmmac_sft_add_pack()/stmmac_sft_remove_pack() helpers.  When the
interface is a DSA conduit, an ETH_P_ALL packet_type is registered instead
and a proxy handler, stmmac_sft_filter(), compares the ethernet header's
h_proto before forwarding a clone to the original validator.

A few questions below, one on the commit message and three on the code.

> The ARP offload's packet handler is left alone, this feature is just not
> implemented in stmmac and due for removal.

[Severity: Medium]
Is this description accurate?  ARP offload does look implemented in two
places:

drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:
	static void dwmac4_set_arp_offload(struct mac_device_info *hw, bool en,
					   u32 addr)

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:
	static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
					     u32 addr)

dwmac4_set_arp_offload() is wired into dwmac4_ops, dwmac410_ops and
dwmac510_ops, and dwxgmac2_set_arp_offload() into dwxgmac210_ops and
dwxlgmac2_ops.

stmmac_test_arpoffload() only bails out early with:

	if (!priv->dma_cap.arpoffsel)
		return -EOPNOTSUPP;

so on those cores with arpoffsel set the test really runs, and it is still
listed in stmmac_selftests as "ARP Offload".  Since it keeps the raw
dev_add_pack(&tpriv->pt) with pt.type = htons(ETH_P_ARP), does it still
report a spurious failure in ethtool -t on a DSA conduit, for the same
ETH_P_XDSA reason this patch fixes elsewhere?  Would switching that pair to
stmmac_sft_add_pack()/stmmac_sft_remove_pack() cover it as well?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 6372ec7c3f317..6503678b646ef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c

[ ... ]

> @@ -237,6 +238,9 @@ struct stmmac_test_priv {
>  	struct stmmac_packet_attrs *packet;
>  	struct packet_type pt;
>  	struct completion comp;
> +	__be16 packet_type;
> +	int (*func)(struct sk_buff *skb, struct net_device *ndev,
> +		    struct packet_type *pt, struct net_device *orig_ndev);
>  	int double_vlan;
>  	int vlan_id;
>  	int ok;

[ ... ]

> @@ -316,6 +320,50 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static int stmmac_sft_filter(struct sk_buff *skb, struct net_device *ndev,
> +			     struct packet_type *pt,
> +			     struct net_device *orig_ndev)
> +{
> +	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
> +	struct ethhdr *hdr = eth_hdr(skb);
> +	int ret = 0;
> +
> +	if (hdr->h_proto == tpriv->packet_type) {
> +		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
> +
> +		if (nskb)
> +			ret = tpriv->func(nskb, ndev, pt, orig_ndev);
> +	}

[Severity: Medium]
This compares the on-wire ethertype against the value the test registered
in pt.type, but for the VLAN tests pt.type is the protocol *after* the tag
has been removed:

__stmmac_test_vlanfilt()      pt.type = htons(ETH_P_IP), frame is 802.1Q
__stmmac_test_dvlanfilt()     pt.type = htons(ETH_P_8021Q), outer tag is
                              ETH_P_8021AD
stmmac_test_vlanoff_common()  pt.type = ETH_P_IP or ETH_P_8021Q

On a normal interface the core removes the tag before the taps run:

net/core/dev.c:__netif_receive_skb_core() {
	...
	if (eth_type_vlan(skb->protocol)) {
		skb = skb_vlan_untag(skb);
	...
	list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
	...
}

but on a DSA conduit skb->protocol is ETH_P_XDSA, so eth_type_vlan() is
false and no untagging happens there.  Doesn't that leave the driver as the
only tag remover, and isn't that conditional?

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_vlan() {
	if ((vlan_proto == htons(ETH_P_8021Q) &&
	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
	    (vlan_proto == htons(ETH_P_8021AD) &&
	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
	...
}

NETIF_F_HW_VLAN_CTAG_RX is placed in hw_features on xmac cores, so it is
user-toggleable.  After "ethtool -K <conduit> rxvlan off", or with
CONFIG_VLAN_8021Q disabled where neither feature nor hw_vlan_en is ever
set, the frame should reach the filter with h_proto == 0x8100, the
comparison against ETH_P_IP fails, the frame is freed here and the C-VLAN
tests time out.  Would matching on the inner protocol (or skipping any
VLAN tags before the comparison) be more robust?

> +
> +	kfree_skb(skb);
> +	return ret;
> +}

[Severity: Medium]
This isn't a bug introduced by this patch, but the validators reached from
here derive header offsets from the received IPv4 ihl field while only
checking for 33 linear bytes:

stmmac_test_loopback_validate() {
	...
	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
		goto out;
	...
	uhdr = (struct udphdr *)((u8 *)ihdr + 4 * ihdr->ihl);
	...
	shdr = (struct stmmachdr *)((u8 *)uhdr + sizeof(*uhdr));
	...
	if (shdr->magic != cpu_to_be64(STMMAC_TEST_PKT_MAGIC))
	...
}

With ihl == 15 the shdr->magic read lands roughly 90 bytes past the checked
bound.  The same pattern exists in stmmac_test_vlan_validate().  This was
already reachable before the patch through the ETH_P_IP ptype registration
on priv->dev, and the read stays inside the RX buffer, so the practical
effect is stale bytes and possibly a wrong verdict.  Since the new
ETH_P_ALL tap widens the set of frames that get here, would it be
reasonable to add a length check on the derived offsets along with it?

> +
> +static void stmmac_sft_add_pack(struct packet_type *pt)
> +{
> +	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
> +
> +	if (netdev_uses_dsa(tpriv->pt.dev)) {
> +		tpriv->packet_type = tpriv->pt.type;
> +		tpriv->func = tpriv->pt.func;
> +
> +		/* DSA conduit will report ETH_P_XDSA, so our packet handler
> +		 * won't match. Let's register a ETH_P_ALL match and filter
> +		 * manually in stmmac_sft_filter.
> +		 */
> +		tpriv->pt.type = htons(ETH_P_ALL);
> +		tpriv->pt.func = stmmac_sft_filter;
> +		tpriv->pt.ignore_outgoing = true;
> +	}
> +
> +	dev_add_pack(pt);
> +}
> +
> +static void stmmac_sft_remove_pack(struct packet_type *pt)
> +{
> +	dev_remove_pack(pt);
> +}
> +
>  static int __stmmac_test_loopback(struct stmmac_priv *priv,
>  				  struct stmmac_packet_attrs *attr)
>  {

[ ... ]

> @@ -928,7 +976,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
>  	 * HASH values.
>  	 */
>  	tpriv->vlan_id = 0x123;
> -	dev_add_pack(&tpriv->pt);
> +	stmmac_sft_add_pack(&tpriv->pt);
>  
>  	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
>  	if (ret)

[Severity: High]
Can an incoming frame from the switch oops here?  The handler is now
installed as an ETH_P_ALL tap while attr.dst is still NULL:

__stmmac_test_vlanfilt() {
	struct stmmac_packet_attrs attr = { };
	...
	tpriv->packet = &attr;
	tpriv->vlan_id = 0x123;
	stmmac_sft_add_pack(&tpriv->pt);

	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
	...
	for (i = 0; i < 4; i++) {
		...
		attr.dst = priv->dev->dev_addr;

and the VLAN validator dereferences packet->dst without a NULL check,
unlike stmmac_test_loopback_validate() which guards it with "if (dst)":

stmmac_test_vlan_validate() {
	...
	if (tpriv->vlan_id) {
		if (skb->vlan_proto != htons(proto))
			goto out;
		if (skb->vlan_tci != tpriv->vlan_id) {
	...
	ehdr = (struct ethhdr *)skb_mac_header(skb);
	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
	...
}

The ETH_P_ALL tap runs before the core's __vlan_hwaccel_clear_tag(), so a
received IPv4 frame that stmmac_rx_vlan() stripped into the hwaccel fields
with vlan_proto == ETH_P_8021Q and vlan_tci == 0x123 passes the h_proto
check in stmmac_sft_filter(), passes the vlan_proto/vlan_tci checks, and
then calls ether_addr_equal_unaligned(ehdr->h_dest, NULL).

Before the patch the core cleared the hwaccel tag before ETH_P_IP ptype
dispatch, so foreign frames were rejected by the vlan_proto check and this
window was not reachable from the wire.  Would setting attr.dst before
stmmac_sft_add_pack(), or adding a NULL guard in the validator, close it?

> @@ -1022,7 +1070,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
>  	 * HASH values.
>  	 */
>  	tpriv->vlan_id = 0x123;
> -	dev_add_pack(&tpriv->pt);
> +	stmmac_sft_add_pack(&tpriv->pt);
>  
>  	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
>  	if (ret)

[ ... ]

> @@ -1293,7 +1341,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
>  	tpriv->vlan_id = 0x123;
> -	dev_add_pack(&tpriv->pt);
> +	stmmac_sft_add_pack(&tpriv->pt);
>  
>  	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
>  	if (ret)

[Severity: High]
Same ordering as __stmmac_test_vlanfilt() here: the tap is registered, then
vlan_vid_add() runs, and only afterwards does the function do
"attr.dst = priv->dev->dev_addr;", so tpriv->packet->dst is NULL for the
whole window.

[ ... ]
-- 
This is an AI-generated review.

