Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D414399F2;
	Mon, 12 Oct 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790889; cv=none; b=l3YwYwdDCrE//Sdw6Fbqn7fDYul0jhaFlnwcD/PDbFy0EPw4cYcxTJ9LMWrx7pTHv+biuCf/i6ACHebd3wR07/XlkBWoHxQQO1c4Inmoo93w28aXKYXqW7R4pN3BU35vHmBGrc9bH2dOiOizOv3Mo76uYlFKGI86H6NC/6tV/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790889; c=relaxed/simple;
	bh=9NQy26vlzeCjQwUFJzSh4rboLyqpjRt+h9nrDGIG6v0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcBp91OcEDhlRP6GsdvOZdaNVauZkV+R035NrPGaLam3egfJ5A+bs3U+UmkuD+YSa4hH5e4QOaVnGLDac3JLVuJhF0SQxCshz/rw4f0MwiZ2zkSA3h4jgzDRTiAEdtDxao3ibYEQL6hfSvyFORt75zh03dDoJzOjaCXFsYLS5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFNoTyQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFNoTyQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653D1F0089C;
	Mon, 12 Oct 2026 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790888;
	bh=pvTVYyVuEgJNEQYtQ0bJhgCodEZLBb2zu/T5Sk/wJHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CFNoTyQ4MPdRSTWWUw5qyOfTGyTkl15aHpQF5q6LQpWMUIF1f6VxSGesKn6sbhSor
	 NpcOhLN3Vb+FG1dsVfgEmy+7vzx3DfTIjbDKCOosuyLeNINkskJCRs6rBIfdFJoTld
	 60IhcWIG9ogirJ37EhTisBgYgH83oUqVj7IF51EeI/UJdCHquhRzyuxKe8MqePtw4V
	 SbRMkMWIQJNVTDtjEabzmcsmvQOoReS7xebLQDJVZFr1f85PbFx6jZc5NTBBwcVzqG
	 YTv7qDd9PdrEjrIRp+x+X/MHq2b58hmF+i2O/tsKslTnyxeCo2tKiEQNOuXyAcmHx9
	 0+jl1+oTHgNvQ==
Subject: Re: [PATCH net-next v16 4/7] r8169: prepare for new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk
Date: Mon, 12 Oct 2026 07:41:27 +0000
Message-ID: <179179088719.434549.13908904367971772664@kernel.org>
In-Reply-To: <20261008065722.1026-5-javen_xu@realsil.com.cn>
References: <20261008065722.1026-5-javen_xu@realsil.com.cn>
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

- [Low] The commit message understates what the patch changes.

--

r8169: prepare for new interrupt mapping

This patch adds rtl8169_hw_enable_vec_mapping() and calls it from
rtl_hw_start_8125_common() when more than one IRQ vector is in use. It
also moves the RX counters in rtl_rx() and rtl8169_check_rx_desc_error()
from dev->stats into new per-ring u64_stats_sync protected counters in
struct rtl8169_rx_ring, and rtl8169_get_stats64() now sums them.

> r8169: prepare for new interrupt mapping
>
> This patch enables new interrupt mapping for RTL8127 and add error pkts
> counter per ring.

[Severity: Low]

This isn't a bug, but could the subject and body describe the stats
change more precisely?

The subject only mentions interrupt mapping. The patch also moves every
RX counter in rtl_rx() and rtl8169_check_rx_desc_error() out of
dev->stats and into ring->stats. Those counters are rx_errors,
rx_dropped, rx_length_errors, rx_crc_errors and multicast.

The phrase "add error pkts counter per ring" suggests new counters, but
these are existing counters being moved. Also, multicast is not an error
counter:

drivers/net/ethernet/realtek/r8169_main.c:rtl_rx() {
    ...
		if (skb->pkt_type == PACKET_MULTICAST) {
			u64_stats_update_begin(&ring->stats.syncp);
			ring->stats.multicast++;
			u64_stats_update_end(&ring->stats.syncp);
		}
    ...
}

The stats change takes effect right away on every chip the driver
supports. The vector mapping only runs when tp->irq_nvecs is greater
than 1:

drivers/net/ethernet/realtek/r8169_main.c:rtl_hw_start_8125_common() {
    ...
	if (tp->irq_nvecs > 1)
		rtl8169_hw_enable_vec_mapping(tp);
    ...
}

That can't happen until a later patch, because rtl_alloc_irq() still
requests only one vector.

With num_rx_rings == 1, the values reported by rtl8169_get_stats64()
seem unchanged. The only problem is that the description does not match
the diff.

Would it make sense to put the stats conversion in its own patch? If
not, could the subject and body say that RX statistics accounting
changes for all r8169 chips?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008065722.1026-1-javen_xu%40realsil.com.cn
