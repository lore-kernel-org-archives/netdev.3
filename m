Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25941687A;
	Thu, 24 Sep 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269660; cv=none; b=BsElb9o0f7qgcmpWlpNgGX7uorc5ISk3JXlA2CM+lr/bZGlL1/n20NRjCFjtdvbpjMLQvFINUYtvnOBv8UuYw9wkoyY2VlxU5X3Fe3Q6ynAsdaQokqsF1+6NUIa5V0Sjq9jYEuZvSecvMDPOM2XsbnD4qQMTiiVhgcnx3zHVSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269660; c=relaxed/simple;
	bh=ihz1ntbdHPW9fqmSVzX2ee1AZaUziQsH6sIjMB/vqVE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sl11KKQknHxbz9zaZFOeEVg7zkQS82vwa4fDv9R0i9av8NL+K4/lzg2EX/2GiJe+uy2c/jkT0ij+lD6h7vlKmuHZJXVbbpgI1s2SP/GtYYQ2pF6ymcscr/QZyUx2+YVh+BGDTvk3Lp0HNarG2TI3q4sVwJCtXUTuAsn4s2U+yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTQWlPJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTQWlPJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5081F00893;
	Thu, 24 Sep 2026 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269658;
	bh=SpBMzErNw0cWm8zox9i5TvYfiTxgo+A3ydYt55FEMsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gTQWlPJyWHxok6wj9evOj//KN8i+oZucaxYFLxAh+GGGKiroJH+1ecpP8MgvGyxiW
	 NrPoSGaMytJjsEnLi9iknkQLTdQKBTsvbAVXQfbLWT7RG3N8bbECCZfLY0fdOtiF9m
	 gCQSPBiiaJy2YvKvbfmhkVXGupI8QsNCu8fkMiwdKxtIyrYonlF66wYUSAM4Q7V8fR
	 3/XFrKBXhPy5ZTK6pClDTK4xOHmVdeYXwkBxVCNeri1gV94eBxShw6sXk+UOtUOSP8
	 PuMVE7AT8Xl5XbxtQkLYzShlwMQO9Xt0kN0BsBb+fSI86LHW1Fn/Vuv0p2aYfrYc+F
	 1rZSqFesk+tCQ==
Subject: Re: [PATCH net 06/12] net: systemport: Fix RUNT MIB counter register
 offset calculation
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:37 +0000
Message-ID: <179026965728.2160803.17267080010642967969@kernel.org>
In-Reply-To: <20260921231305.394773-7-florian.fainelli@broadcom.com>
References: <20260921231305.394773-7-florian.fainelli@broadcom.com>
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

- [Low] Commit message inaccurately describes the pre-fix behaviour of
  bcm_sysport_update_mib_counters()…

--

net: systemport: Fix RUNT MIB counter register offset calculation

This adds the second 0xC UniMAC MIB gap to the register offset used when
reading the BCM_SYSPORT_STAT_RUNT counters in
bcm_sysport_update_mib_counters(), so offset becomes
2 * UMAC_MIB_STAT_OFFSET for those four entries.  The register offsets
produced by the new code look correct to me.

> In bcm_sysport_update_mib_counters(), 'offset' was only set to
> UMAC_MIB_STAT_OFFSET (0xC) for all non-RX counters, omitting the second
> 0xC gap for BCM_SYSPORT_STAT_RUNT counters. As a result, all 4 RUNT MIB
> counters were read from unmapped gap register space.

[Severity: Low]
Is "all 4 RUNT MIB counters were read from unmapped gap register space"
accurate?  By the driver's own table it looks like only three of the four
reads landed in the reserved gap.

bcm_sysport_gstrings_stats[] has 29 STAT_MIB_RX entries and 29
STAT_MIB_TX entries, all u32, so 'j' is 29 * 4 + 29 * 4 = 0xE8 by the time
the first STAT_RUNT entry is processed.  With the old offset of 0xC the
four reads were:

    UMAC_MIB_START(0x400) + 0xE8 + 0xC = 0x4F4, 0x4F8, 0x4FC, 0x500

The annotations in bcmsysport.h put mib.rx.rcrc at 0x470 and mib.tx.uc at
0x4F0, which places the second 0xC gap at 0x4F4-0x4FF and the start of the
RUNT block at 0x500.  So 0x4F4/0x4F8/0x4FC were gap space, but 0x500 was
the real first RUNT register.

That last read was stored into the fourth STAT_RUNT destination:

	STAT_RUNT("rx_runt_pkts", mib.rx_runt_cnt),
	STAT_RUNT("rx_runt_valid_fcs", mib.rx_runt_fcs),
	STAT_RUNT("rx_runt_inval_fcs_align", mib.rx_runt_fcs_align),
	STAT_RUNT("rx_runt_bytes", mib.rx_runt_bytes),

so rx_runt_bytes reported the runt packet count rather than gap data.

Could the changelog also state the user-visible symptom, i.e. that
ethtool -S reported bogus values for rx_runt_pkts, rx_runt_valid_fcs and
rx_runt_inval_fcs_align, and a mis-assigned value for rx_runt_bytes?  That
would help anyone deciding on a stable backport.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
