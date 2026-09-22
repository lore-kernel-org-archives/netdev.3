Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B23546ED;
	Tue, 22 Sep 2026 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038736; cv=none; b=qF4c81GlaUNC+9+vT3gLaDS9BMkHiANPb7FCk1caCGf7015lbLo3Udk5sCZfVPzMKXNY9WwJYTGN2/zMiDYMbddTmnMDz5CwpoaTZdjFQstGhZAHCUQR0QPsr2rs3OgYVZzvBuPvuOIGc/SKRaCyA/HBhGzqgQ6YlEH5NPzwM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038736; c=relaxed/simple;
	bh=8XHsDEdXLcnk+nnPvSiAj0PHOSHLiFLxQVcrONptJYE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbMHS+bgYhxSnFz0teBYpLkWw1LicrsK7TXZ6GtZyYUkQKQgNVKytfNmJKO5zlVpF+WH6tFlF1owsBVE4TMczDE4Z7OBT8Gi4DfVVTju/Fv/L2A3drU3I4M2KTAHmFRJoIVC4id8vsDkpd4moYhtLXibfGNUcq8yMz+4xMYg6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwZOoE1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwZOoE1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8091F00899;
	Tue, 22 Sep 2026 00:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038734;
	bh=VH73kCxCtAR3SnqZhgoqjYc7pV+x8YfFMPJuAB9Nq6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WwZOoE1ofeZz586zr0momMVjduNX7NHVcIlfnlSN2BQUlDZHv/r35aFBn+SdZEsUP
	 utKA7jkHN3kwfFYgAsYVZdkFUXKvDfBwyDCAQ3BiItr+mc9LRzwxcX/MoApo6xj82N
	 Sg0adfC9lN2mV6cjVrGJOj7qPj6oaZ/n3B3rG0BR1RJBRM2NNuS7LASiLBBu/6vFtP
	 WVWzWgex+YkY2HSZYvcO0fGBS69MYcBFkD84fKGD3xB+pEFVmQHBUm6ZJ9LEFyuT29
	 Ejt+J+q4pj1joSBsm+F4fbOuObOqIR/Z/q3re6N4OicaWcoG8oReb6v6N6HcQosh1n
	 JNDCyRjs792eA==
Subject: Re: [PATCH net 7/8] net: bcmgenet: zero-initialize Transmit Status
 Block in bcmgenet_add_tsb
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:53 +0000
Message-ID: <179003873336.2160803.15332109108263126617@kernel.org>
In-Reply-To: <20260918000732.276506-8-florian.fainelli@broadcom.com>
References: <20260918000732.276506-8-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bcmgenet_add_tsb() now unconditionally writes 64 bytes into
  the skb head (memset(status, 0, sizeof(*status)) at…
- [Low] The commit carries no Signed-off-by: line and includes
  tool/Gerrit-specific trailers.

--

net: bcmgenet: zero-initialize Transmit Status Block in bcmgenet_add_tsb

This adds a memset() of the 64-byte Transmit Status Block after the
skb_push() in bcmgenet_add_tsb(), so that fields other than
tx_csum_info, and the whole block for packets without CHECKSUM_PARTIAL,
are no longer left holding whatever was in the skb headroom before.

Two observations below, one on the trailer block and one on the new write.

>     Fixes: 9a9ba2a4aaaa ("net: bcmgenet: always enable status blocks")
>     Assisted-by: LLM
>     Co-authored-by: Cursor <cursoragent@cursor.com>
>     Change-Id: I6935e24408ea10f68eb61dce4cced9b0ead5c005

[Severity: Low]
This isn't a code bug, but the trailer block has no Signed-off-by: line,
and it still carries a Gerrit Change-Id:.

Documentation/process/submitting-patches.rst requires the Signed-off-by
(Developer's Certificate of Origin), and Change-Id is normally stripped
before posting, so as-is checkpatch/b4 and the netdev CI will reject this.

Can the Signed-off-by be added and the Change-Id dropped, here and in the
rest of the series?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 90ca4f220cc7c..3a6a2f0759598 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2084,6 +2084,7 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
>  
>  	skb_push(skb, sizeof(*status));
>  	status = (struct status_64 *)skb->data;
> +	memset(status, 0, sizeof(*status));

[Severity: Medium]
Can this memset() scribble over headroom that is shared with a clone?

The only unsharing step in bcmgenet_add_tsb() is keyed off available
headroom, not off ownership of the head:

	if (unlikely(skb_headroom(skb) < sizeof(*status))) {
		new_skb = skb_realloc_headroom(skb, sizeof(*status));
		...
	}

	skb_push(skb, sizeof(*status));
	status = (struct status_64 *)skb->data;
	memset(status, 0, sizeof(*status));

A cloned skb that already has 64 bytes of headroom skips the realloc
entirely, and that is the common case because bcmgenet_probe() does:

	dev->needed_headroom += 64;

bcmgenet_xmit() calls bcmgenet_add_tsb() without any copy-on-write of its
own, so the memset() lands in memory shared with the other clone.

Clones of one head do get transmitted on two devices concurrently, for
example bond_xmit_broadcast():

	skb2 = skb_clone(skb, GFP_ATOMIC);

and tcf_mirred_to_dev():

	skb_to_send = skb_clone(skb, GFP_ATOMIC);

If the second device's transmit path pushes its own header (VLAN tag, DSA
tag, tunnel or USB-ethernet header) into the same headroom bytes, do the
two writes overlap and corrupt one of the frames?

Before this patch the driver wrote 4 bytes (tx_csum_info) and only for
CHECKSUM_PARTIAL packets; the memset() extends that to all 64 bytes for
every packet, which widens the overlap considerably.

Would skb_cow_head(skb, sizeof(*status)) before the skb_push(), with the
allocation failure handled like the existing skb_realloc_headroom() path,
be preferable here? That is what the sibling driver does in
bcmasp_csum_offload():

	ret = skb_cow_head(skb, sizeof(*offload));
	if (ret < 0) {
		intf->mib.tx_realloc_offload_failed++;
		goto help;
	}

The missing copy-on-write predates this patch and the same pattern exists
in bcm_sysport_insert_tsb(), so it is not newly introduced, but the larger
write makes it more visible.

>  
>  	if (skb->ip_summed  == CHECKSUM_PARTIAL) {
>  		ip_ver = skb->protocol;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
