Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6F3D3D12;
	Thu, 24 Sep 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216488; cv=none; b=ezylKA2HaBKfgjnAb+A8lrytdv2jr8Kp+SLmr/HAOGmY6Xew/E1cAmH2sTuGqxnwAbs8eAGO2/gtSxvlCz2ivrR1sLJH8TwwhKX38v7wa2DuibRuuniW0sb5+k52CL+9GmSlsvVQGXGY9LCX7Qzli6442bENOWZ7VrmZeOa3wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216488; c=relaxed/simple;
	bh=z7NCQoyygUx47aIw9vRxnYaF8djmuSYz9xcNhZrXWhw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4JB13Zxyj0S+/W1DRADKnBv8qqJXTMqXckWuY5HWBHJ/1iwENGQLLJyFyrrAKyqZWUKqJGOMVEot3W6lyYPRmAsr15OkaIzlHH9z0KRjVDPs397gA0QPFptlegXEw8jO7HCcc+2zT2w9u3MD+Z+w+rgIa2ZbryDMPZ4qbGvfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHvmSOX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHvmSOX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1841F00899;
	Thu, 24 Sep 2026 02:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216485;
	bh=WG+bOE6VyJ5CrloRYDowYtl/G/DKIFrpOMS2cE1jdNw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kHvmSOX9IwIyrh/xZixUDG9IIlv7o7wjWzG4PiRRaskZzE7ixQyDkQ/ZdVVPFVQmr
	 LeqdcOgrz9DmdEkRL8Mrh7sMZmLP8u1Wq5nV6jQ2qNNRliMW2YkBwTWI46HKHin72i
	 /rqcZEF8Ho0npUFZQuT5ZHQ7dH5eXZpQodd6ENyuPUG8GV8j1OgLSJqQMJ8YK9Y5nX
	 Kmp0x8WaFoiHVvbaOZwdYE7UpBwYXMYvsjsAmh2oFxriZ0meQZ1ADCaot76FpE+da2
	 eYGbg1iHyeMrkhRsXKtqKivGpTVe9uND57InDrM+1CoSDWNNoYCSK+OoXWXe5vPoSq
	 UPXFUIMFh4pOg==
Subject: Re: [PATCH net v2 05/10] net: systemport: Fix RUNT MIB counter
 register offset calculation
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:24 +0000
Message-ID: <179021648477.2160803.4907842757640250855@kernel.org>
In-Reply-To: <20260922232440.598918-6-florian.fainelli@broadcom.com>
References: <20260922232440.598918-6-florian.fainelli@broadcom.com>
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

- [Low] The commit message for "net: systemport: Fix RUNT MIB counter
  register offset calculation" says the old code read all 4 RUNT MIB…

--

net: systemport: Fix RUNT MIB counter register offset calculation

This commit changes bcm_sysport_update_mib_counters() so that RUNT MIB
counters are read with an offset of 2 * UMAC_MIB_STAT_OFFSET. This covers
both the RX-to-TX gap and the TX-to-RUNT gap in the UniMAC MIB block.

> In bcm_sysport_update_mib_counters(), 'offset' was only set to
> UMAC_MIB_STAT_OFFSET (0xC) for all non-RX counters, omitting the second
> 0xC gap for BCM_SYSPORT_STAT_RUNT counters. As a result, all 4 RUNT MIB
> counters were read from unmapped gap register space.

[Severity: Low]
Is "all 4 RUNT MIB counters were read from unmapped gap register space"
accurate?

The loop reaches the RUNT entries in bcm_sysport_gstrings_stats after 29
STAT_MIB_RX and 29 STAT_MIB_TX u32 entries, so j is 0xE8 at that point.
With the old offset of 0xC, the four RUNT reads went to:

    UMAC_MIB_START + 0xE8 + 0xC = 0x4F4  rx_runt_pkts
    UMAC_MIB_START + 0xEC + 0xC = 0x4F8  rx_runt_valid_fcs
    UMAC_MIB_START + 0xF0 + 0xC = 0x4FC  rx_runt_inval_fcs_align
    UMAC_MIB_START + 0xF4 + 0xC = 0x500  rx_runt_bytes

The TX-to-RUNT gap covers only 0x4F4-0x4FF, so only the first three reads
fell in the gap.

The fourth read, for rx_runt_bytes, went to 0x500. That is the real
rx_runt_pkts register. So before this fix, ethtool -S reported the runt
packet count as rx_runt_bytes, not a gap value.

Could the commit message say that three counters read gap space and
rx_runt_bytes showed the rx_runt_pkts value? The code change itself looks
correct and matches the 2 * BCMGENET_STAT_OFFSET handling in bcmgenet.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
