Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740235E1D1;
	Thu,  3 Sep 2026 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468136; cv=none; b=KdBH3N0dOCY1w5ck1f/X73PCGAQ3ly1pJfQpO3mtKd84H9PCJ6TJ3YuCjyrWL/hp+dKUTXTbZvuaHND9NHzUa1r8BdUdcgY3cRK9y9YMVU8NbEp5/9tWWaENopWi9zUWp26CN7yTs9I+OuzcwMOJvsjABeGcdFz3Afguo2MKHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468136; c=relaxed/simple;
	bh=n7n6elQmCbAPLr9l0LotdZO2iDN00v4sBf05YZcA26A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3Qaps2qMwy2bpuh3iWDx4E/8H6tbaAuzHy7MGftV0O4X8WJnpZrxVG/TQRTD6dALOHQZ5RoZ9LUVGiXWmLUTdQqvNkhdbLX1LE2hiWaVfvKTuXtgXNcJT4wHostX70xY29lD/IGEPvySrmb19NwMypFWEUC13G2wPFSs76vdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhTMeShk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhTMeShk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C31F00A3E;
	Thu,  3 Sep 2026 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468126;
	bh=t1D9BR9tu6yXS78I2K5p3DEoo/wybJyAHmBcvIJxTjg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhTMeShkeAI5odW9ZdWLqmRt1QhiAgbZ+xdOvnT9+WcXrp+VBhccw7gSapcIS+5zg
	 Y53YSLKH7FNED/iqYNfei/1a5I1Xt0ZmlWSnVQosgDYQsRmX7s0nUIJMxZQ9iS3RRH
	 227pQx6adp+WH7AqPE+aZz8yJm2RNLHWt+xVQJemWAWX1FKUXC48x72acuVfcWr1rv
	 G49E8okNKyvSXFBUQSiK7f8SPgLQDpMIjRu3+zeE+AbpIrZRKPjxYKimLxQE9/Vz3v
	 waExELnSmx4ZfZ8Mmlxv2jIQ2eWIleRn4I9AcErkMiqRlrbNXvfH8DJMHSuLqOKjoS
	 8XNljiHyPVleA==
Subject: Re: [net-next,v12,4/7] r8169: enable new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:05 +0000
Message-ID: <178846812511.3394541.7303604411927231954@kernel.org>
In-Reply-To: <20260831053940.620-5-javen_xu@realsil.com.cn>
References: <20260831053940.620-5-javen_xu@realsil.com.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message claims "This patch enables new interrupt mapping
  for RTL8127", but at this commit the new hardware write in…

--

r8169: enable new interrupt mapping

This patch sets the new interrupt vector mapping bit (INT_CFG0_ENABLE_8125)
in rtl_hw_start_8125_common() when more than one IRQ vector is in use.  It
also moves the rx errors/dropped/length/crc/multicast counters out of
dev->stats into per-ring counters protected by u64_stats_sync, summed in
rtl8169_get_stats64().

No Link: tags are present in the commit header.

I looked over the per-ring statistics conversion and the new vector mapping
enable path and did not find regressions to raise.  One item I initially
flagged turned out not to be a problem, noted inline below for the record.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ca6be1e38408..1798a98b860b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -3947,6 +3966,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	RTL_W32(tp, RSS_CTRL_8125, 0);
>  	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>  
> +	if (tp->irq_nvecs > 1)
> +		rtl8169_hw_enable_vec_mapping(tp);
> +

At this commit rtl_alloc_irq() still calls pci_alloc_irq_vectors() with both
the minimum and maximum vector count set to 1, so tp->irq_nvecs is always 1
and this call never runs yet.

The later commit in this series ("r8169: add support and enable rss")
switches rtl_alloc_irq() to get_min_irq_nvecs()/get_max_irq_nvecs() and
raises tp->num_rx_rings via rtl8169_set_rx_ring_num(), so this is just the
usual infrastructure-first ordering within a series and not a defect.

>  	/* disable UPS */
>  	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
