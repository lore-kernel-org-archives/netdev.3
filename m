Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432C4A8FD9;
	Thu, 24 Sep 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271370; cv=none; b=e1SC+OF6vH48Ic9BM9kOMm4tCuicQ9HX3VhxyPd+IwWPBJv2ubAZP9diVbBkcWHr13Yjd3qcLdHEPaMvX847UVmrGo8kJcBjSdWvO3GsG93UfiCM28Z66DKpm9tYgWwYQTfjsijFSmB/VFhKFlLiVxuxvQpAQu5hjm2q6XNnhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271370; c=relaxed/simple;
	bh=9Gf+SrEO7AdCsZYicS8z7ED348jsQsSe/Jjco0svQSI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2LneP7kNVi9p/b+YmzYMCz2dJsP78ACN52zMFD7ylA7+9gEz3aBb1C4iQYzQdQeOdGnxHWY8HgZ6ru2XCrWaLRrxhmShWVfUxaarqYoAFswHcwHmW7ympXht5DVj2CvNAEoiPX3pCwR3OATYs7NRr+CVRZftCV9IkWHV7/8GUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZr0UU0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZr0UU0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D0C1F000FF;
	Thu, 24 Sep 2026 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271369;
	bh=Cv+SG0uZ2ekeOvIBJVHP5F3IubEKnpbND8T7lhCAmaQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iZr0UU0JFbxL8fJFv7Al79/WTCk8fgxq3Mmb033r8nA2T2Esnuh0R2UZF+BW61ts9
	 5vvlax39ZP3Vp14O9YpyuoqBVX18erGWlFPEmwznhFPP95pxkfz8Nw+YbTo3perYS4
	 kIouHwJujmCsEMqMY5leBrlmZrbORD99GiWizc1HaVobdKWLU73YSdeAxPNdNc9EZ7
	 MuZ04yJbNun2+Fp3MIwWddMi81wWSqiJOZdUAIXDgUO37zCu/sh8wRbGOwsVHC2/26
	 IWCfYW4r626dcd056TtVZW7KCe0Uxtf30LzSdJPoDTnZ9c/wHIixhRwdZZIDwhiMJx
	 hv8ac8hpFmwTA==
Subject: Re: [PATCH net 1/6] net: bcmasp: fix mib counters struct alignment
 with ethtool stats
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:36:08 +0000
Message-ID: <179027136810.2160803.5519251364954584171@kernel.org>
In-Reply-To: <20260922221630.3864427-2-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-2-florian.fainelli@broadcom.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message overstates what the bug did.

--

net: bcmasp: fix mib counters struct alignment with ethtool stats

This commit removes the leftover edpkt_* fields from the start of struct
bcmasp_mib_counters. They were left in place when the matching
bcmasp_gstrings_stats[] entries were removed for asp-v3.0. Since then the
struct layout has not matched the order the ethtool code indexes by.

> Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() index
> into struct bcmasp_mib_counters sequentially based on the order of
> bcmasp_gstrings_stats, this 16-byte offset caused hardware statistics
> to be written to the wrong struct members and software counters to be
> read from incorrect offsets (and reading out-of-bounds at the end of the
> struct).

[Severity: Medium]
Is the out-of-bounds part of this description accurate?

Before this patch, struct bcmasp_mib_counters had 17 u32 members (68
bytes), and bcmasp_gstrings_stats[] has 13 entries. Both loops stop at
BCMASP_STATS_LEN:

drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c:bcmasp_get_ethtool_stats() {
    ...
	for (i = 0; i < BCMASP_STATS_LEN; i++) {
		p = (char *)(&intf->mib) + (i * sizeof(u32));
		data[i] = *(u32 *)p;
	}
}

So the highest offset either loop touches is 12 * 4 = 48 bytes, which is
inside the 68-byte struct.

The hardware values also appear to have reached userspace correctly.
bcmasp_update_mib_counters() writes them to raw slots 0-4, and
bcmasp_get_ethtool_stats() reads them back from the same slots. The only
members overwritten were edpkt_* and umac_frm_cnt, and no code uses those
by name.

The part that looks broken is the software counters. Code increments them
by name (intf->mib.alloc_rx_skb_failed++, tx_dma_failed++, and so on).
They sit in raw slots 9-16, but ethtool read slots 5-12. As a result:

  - "RX SKB Alloc Failed", "TX DMA Failed", "Multicast Filters Full" and
    "Unicast Filters Full" read fb_* members that are never written, so
    they always showed 0.

  - The next four strings showed the values of the first four software
    counters.

  - filters_combine_cnt, promisc_filters_cnt, tx_realloc_offload_failed
    and tx_timeout_cnt were never shown at all.

Could the commit message describe this as shifted or mislabeled software
counters, rather than as an out-of-bounds read at the end of the struct?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922221630.3864427-1-florian.fainelli%40broadcom.com
