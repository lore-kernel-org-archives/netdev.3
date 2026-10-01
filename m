Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440E41D20D;
	Thu,  1 Oct 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870806; cv=none; b=bHTHp/fNEYu0JxO8cQ00T2d2LZm17R2yDDtPbnguHKKADlKU388uTX6fUFPfREZeUVrBhpaj77XcjY+7MM4tNlpUiCZG0jWoM11IpY760H9UrZmTNM4P2TdIO0iKQze/VefLgCSMVw2HMj2JV2QNcl8tLndv5IiTMwsQO8nouEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870806; c=relaxed/simple;
	bh=4IWRLO6vEa/v317CWZJtM6rw09SecBdoUiinK0XJyfc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBKhBJuEkfKEb4XXhHLAwcZ/JC8qCYcG+8Asa9DzkVbCRrW4B3mAhl/p0D355BfPeP2lrAN7VHz0R6cQ9m12ZvpQg4WxVqmZoLqej6qRNQShQJfUPYsFKb18PtJXGLciAyHdTMuxEPaigcb+AZroXpDZjZVd8E9djK1PD123IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOZCRaHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOZCRaHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317231F000FF;
	Thu,  1 Oct 2026 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870803;
	bh=Q9nuTfEyiN5KeCOhafl/3XYAMJkgmMY8XUrkYuUK91M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IOZCRaHP+1fEf7cop8TcNWerkvamIJOhhE41r33vOlhAiNDVdEef05gAvJwtTaboj
	 7sHXqANUgnyVyVhpaSu85POHoQenxjg8y4CSp49EGrM05ZxuR7BfbdHTAn+S+0j+pM
	 mWtEAsVblnB609DNPeZxs/tNkZYXlp3Eglpex3phOgp3WR0Hbp4R6N+zCsCsuUKFe7
	 09I4eV/kpkqBL9ieC1wF6TS3CQ84Zn38XbXxzkSCqN2C8TZWUrjCTvq4THdTL1hrlE
	 +YlkszWQFqSILssUH0H570NIyJ2QK9/nYk+2IyH9Ucz04bCindZnLSFJMh/wwGvMia
	 MFg84uSehzqLQ==
Subject: Re: [PATCH net-next v15 1/7] r8169: prepare for multi irqs and napi
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:42 +0000
Message-ID: <179087080270.434549.3382269342371672972@kernel.org>
In-Reply-To: <20260928070423.202-2-javen_xu@realsil.com.cn>
References: <20260928070423.202-2-javen_xu@realsil.com.cn>
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

- [Low] The commit message for "r8169: prepare for multi irqs and napi"
  says "there is no functional change", but the patch changes some…

--

r8169: prepare for multi irqs and napi

This patch replaces the single napi_struct embedded in struct
rtl8169_private with a dynamically allocated array indexed by IRQ vector.
It also adds helpers that request, free, enable and disable the IRQs and
NAPI instances in loops. It prepares for RSS support, and irq_nvecs and
num_rx_rings are still fixed at 1.

> Currently, irq_nvecs and num_rx_rings are still hard-coded
> to 1, so there is no functional change.

[Severity: Low]
Is "no functional change" accurate here? There seem to be two changes
that users can see.

First, r8169_init_napi() now links each NAPI instance to its IRQ:

drivers/net/ethernet/realtek/r8169_main.c:r8169_init_napi() {
    ...
		netif_napi_set_irq(&tp->rtl8169_napi[i],
				   pci_irq_vector(tp->pci_dev, i));
    ...
}

The old code never called netif_napi_set_irq(), so the netdev netlink
napi-get dump showed no IRQ for the r8169 NAPI instance. After this patch
the dump includes NETDEV_A_NAPI_IRQ.

r8169 sets neither rx_cpu_rmap_auto nor irq_affinity_auto. In that case
netif_napi_set_irq_locked() only stores napi->irq, so the datapath is not
affected.

Second, the probe message in rtl_init_one() has a new format:

	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d (%u total)\n",

As a result, the dmesg line looks different on every probe.

The v13 changelog lists the netif_napi_set_irq() call as a deliberate
addition. The commit message itself mentions neither that call nor the
new log format.

Could the commit message mention both, so the patch isn't taken for a
pure refactor, for example when backporting?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
