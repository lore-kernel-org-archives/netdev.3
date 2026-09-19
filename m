Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC13C0630;
	Sat, 19 Sep 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781199; cv=none; b=ccjhrOGAmXpBguEigiN0yGKNLaEZLNZJ6cbMVtmDJh1aOhjk7WzxvyXNI1TAV2XCOyKKMW7E0K9j1djbYvzuEi02Kf2EPbGxnf3n3z88d6YDZM1FSszqpnJXc/uepIp8tK9+dp3ZMLk6g5h9tIQqdoc7P/v+MSbb29RbBgfUBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781199; c=relaxed/simple;
	bh=35JNc40Bi4obdL0mbfayL3AkGVUVthHnwREvO8g5RNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0RODDJASoOIPhT5i32wcFN9rluOswmKfpyDRbfl6wxIX5t9D47mqZMgnA3swmP9Ffxma0XVMBBOVSfFOpGv+dj7WFjPK4gunXXrwjfJAo7M8OGY9pXf7gYmW53CJ26SQFVraa7KgRmPZA5IWxG6/OpA0DDNrWDLQv7LkIxGxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZp3qH7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZp3qH7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17991F00899;
	Sat, 19 Sep 2026 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781197;
	bh=79f/8siwZR2lIbJSBmcnzjvhAy8WLlKtBtDTxTDng3A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EZp3qH7Zb39cFBM0OwqPaegvYoKtfdKwje4Yd0InBIPLivHxjfO3fCXsHTqXPApfn
	 zPzjmJ3xwRiFUS07IXjeyqn6wiT7v2LvqMha5G4nxV6WdMT4KzL/dNYe9zKYqGXZXv
	 Cn/AwDggEHqghjMF9AntKIYRjYA8ZdgOWdR7TZjju72i89p/WJyjDoTGOdTR8V0YJH
	 opoeY+OMvxhKYtQm0EtyvavWOyubW2ZK5QdmtDM4OQtb8oROaDLmvyX/CjyJwj0o/B
	 +FKu2bPrhxenrrEELBspZfGQrEkyvtX/XW8ryuPwnX15q3HvJavvvk303ykEBb1Tqa
	 n7Bih742fjxTw==
Subject: Re: [PATCH net v4 4/7] net: stmmac: selftests: Capture all packets
 for vlan checks
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@esmil.dk, minda.chen@starfivetech.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, jan.petrous@oss.nxp.com,
 ovidiu.panait.rb@renesas.com, Jose.Abreu@synopsys.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 david.laight.linux@gmail.com
Date: Sat, 19 Sep 2026 01:26:35 +0000
Message-ID: <178978119552.22033.8274605013973486182@kernel.org>
In-Reply-To: <20260917215339.2022523-5-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-5-maxime.chevallier@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] The "Means filter did not work" branch that this patch newly
  makes reachable encodes a detected filtering failure the same way the…
- [Medium] Making the VLAN selftest handler an ETH_P_ALL tap exposes the
  test's unsynchronized shared state to arbitrary concurrently received…
- [Medium] The VLAN validator now parses untrusted frames with an
  attacker-controlled offset and an insufficient length guard.

--

net: stmmac: selftests: Capture all packets for vlan checks

This reuses the DSA proxy mechanism for the VLAN selftests, registering an
ETH_P_ALL handler so that frames marked OTHERHOST still reach
stmmac_test_vlan_validate(). The destination address check inside the
validation function is moved earlier since external frames can now be seen.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index de02c0da56dc3..43b8411c51120 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c

[ ... ]

> @@ -344,13 +345,15 @@ static void stmmac_sft_add_pack(struct packet_type *pt)
>  {
>  	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
>  
> -	if (netdev_uses_dsa(tpriv->pt.dev)) {
> +	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
>  		tpriv->packet_type = tpriv->pt.type;
>  		tpriv->func = tpriv->pt.func;
>  
>  		/* DSA conduit will report ETH_P_XDSA, so our packet handler
>  		 * won't match. Let's register a ETH_P_ALL match and filter
> -		 * manually in stmmac_sft_filter.
> +		 * manually in stmmac_sft_filter. This is also useful for
> +		 * VLAN tests, to capture packets otherwise marked as
> +		 * OTHERHOST.
>  		 */
>  		tpriv->pt.type = htons(ETH_P_ALL);
>  		tpriv->pt.func = stmmac_sft_filter;

> @@ -943,6 +946,11 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
>  		goto out;
>  	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
>  		goto out;
> +
> +	ehdr = (struct ethhdr *)skb_mac_header(skb);
> +	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
> +		goto out;
> +
>  	if (tpriv->vlan_id) {
>  		if (skb->vlan_proto != htons(proto))
>  			goto out;

[Severity: High]

With the ETH_P_ALL registration the vid comparison further down in
stmmac_test_vlan_validate() becomes reachable on non-DSA devices, since
the ptype_all walk in __netif_receive_skb_core() happens before
__vlan_hwaccel_clear_tag() and skb->vlan_proto is no longer zero:

	if (tpriv->vlan_id) {
		if (skb->vlan_proto != htons(proto))
			goto out;
		if (skb->vlan_tci != tpriv->vlan_id) {
			/* Means filter did not work. */
			tpriv->ok = false;
			complete(&tpriv->comp);
			goto out;
		}
	}

Is the ok = false encoding here distinguishable from "nothing was
received"?  The callers in __stmmac_test_vlanfilt() and
__stmmac_test_dvlanfilt() do:

		wait_for_completion_timeout(&tpriv->comp, STMMAC_LB_TIMEOUT);
		ret = tpriv->ok ? 0 : -ETIMEDOUT;
		if (ret && !i) {
			goto vlan_del;
		} else if (!ret && i) {
			ret = -EINVAL;
			goto vlan_del;
		} else {
			ret = 0;
		}

For iterations i = 1..3 the frame is sent with VID tpriv->vlan_id + i and
is expected to be dropped by the hardware filter.  If the filter leaks the
frame, its tci cannot equal tpriv->vlan_id, so it can only take the
"filter did not work" branch, which yields ret = -ETIMEDOUT, and the else
arm then rewrites that to ret = 0.

Does this mean a real VLAN filter leak is reported as a pass for every
i > 0?

Conversely, at i == 0 any tagged frame addressed to our MAC that passes
the hash filter (the in-code comment above acknowledges false positives)
also lands in that branch and aborts the test with -ETIMEDOUT.

Would a distinct state, for example leaving ok = true or adding a separate
"unexpected frame" flag consumed by the !ret && i arm, be better here?

>  		}
>  	}
>  
> -	ehdr = (struct ethhdr *)skb_mac_header(skb);
> -	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
> -		goto out;
> -
>  	ihdr = ip_hdr(skb);
>  	if (tpriv->double_vlan)
>  		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);

[Severity: Medium]

Now that frames from the wire reach this parsing code, can the offset
arithmetic below read past the validated data?

	uhdr = (struct udphdr *)((u8 *)ihdr + 4 * ihdr->ihl);
	if (uhdr->dest != htons(tpriv->packet->dport))
		goto out;

	shdr = (struct stmmachdr *)((u8 *)uhdr + sizeof(*uhdr));
	if (shdr->magic != cpu_to_be64(STMMAC_TEST_PKT_MAGIC))

The only length guard is:

	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
		goto out;

and STMMAC_TEST_PKT_SIZE is:

#define STMMAC_TEST_PKT_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
			      sizeof(struct stmmachdr))

so it guarantees 33 bytes after the MAC header, with no allowance for
struct udphdr and none for the extra 4 bytes of the double_vlan path.
ihdr->ihl comes from the wire and can be up to 15, so uhdr can sit up to
60 bytes past ihdr and shdr->magic can be read roughly 84 bytes past the
network header.

The proxy itself does no validation either, it clones after an ethertype
comparison only:

	struct ethhdr *hdr = eth_hdr(skb);

	if (hdr->h_proto == tpriv->packet_type) {
		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);

A 60-byte frame with ihl = 15 and protocol = UDP addressed to our MAC gives
skb_headlen() == 46, passes the 33-byte check, and then reads about 30
bytes beyond skb->tail.  Should a pskb_may_pull() or an explicit
remaining-length check against 4 * ihdr->ihl + sizeof(*uhdr) +
sizeof(*shdr) be added before these dereferences?

The same unchecked ihl arithmetic already exists in
stmmac_test_loopback_validate(), so that part is not new, but this change
is what exposes the VLAN validator to external frames.

> @@ -999,6 +1003,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
>  	tpriv->pt.dev = priv->dev;
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
> +	tpriv->capture_all = true;

[Severity: Medium]

Does the 4-iteration loop in __stmmac_test_vlanfilt() need a
reinit_completion()?  init_completion() is called once before the loop and
the loop only resets the verdict:

		tpriv->ok = false;
	}

With the promiscuous tap, unrelated received frames addressed to our MAC
can now call complete(&tpriv->comp) from the vid-mismatch branch of
stmmac_test_vlan_validate().  Every surplus complete() leaves done > 0, so
the next iteration's wait_for_completion_timeout() returns immediately
without ever waiting for its own frame.

Also, tpriv->ok is a plain int written from NAPI softirq context in
stmmac_test_vlan_validate() and written/read from process context in the
loop, with no common lock and no READ_ONCE/WRITE_ONCE.  If a softirq write
of ok = true lands after the process-context reset, the caller can observe
ok == true in an iteration where a timeout is expected and turn that into
a bogus -EINVAL.

> @@ -1095,6 +1100,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
>  	tpriv->pt.dev = priv->dev;
>  	tpriv->pt.af_packet_priv = tpriv;
>  	tpriv->packet = &attr;
> +	tpriv->capture_all = true;

[Severity: Medium]

The same two points apply to __stmmac_test_dvlanfilt(): the loop resets
tpriv->ok without re-arming the completion, and the verdict encoding
question above applies to its identical ret = tpriv->ok ? 0 : -ETIMEDOUT
handling.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917215339.2022523-1-maxime.chevallier%40bootlin.com
