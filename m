Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE436AB77
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231399; cv=none; b=tqItYZoJEpq136xiOUWDHpB6zlMYbPUDPwJ83nPQP9io7egrX6E/H8/QyWGZhVOc1eTFjlJMM9FLUTM2t2JaV4ReT4YIy/U5+eP/l7jQqD6/vcNE2Y8wmAAW/f8OFq8Gmi5t82+KTGVCM+BPoMhYp4y9FCwKAlsdxv+dIYIwEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231399; c=relaxed/simple;
	bh=l6RX8V5AxSi2OKrTuyHA8kLJYArUSwSSfBUXc0OrY9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuHq/QTfbcaHRRSrDRmmlp5lHDCAp6egXbGaFpnLN8uG84ZdBKmY7dBasVoE7Odfsd59x6JpG+1JuF7SZjvrneCJ4fTXfBP7TF639N8JtJV0KUCsXbiHY7Q6FviwGgiaaVqb6hG3QKYI3grORh7PPv2LFCAOxJXaedty8l5I738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Twry3mfe; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Twry3mfe"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac8a2ac52bso2509237b3.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1791231396; x=1791836196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nCiUSXl1sTqT+a31rbofdcXjLxgQuX1RkjO3vSRBV8Y=;
        b=Twry3mfeBuVaW93Ic7Xvmn/GaTIgoq5OHkN/nggcz5U5w/EsCdQXpiODpkSztb/Nnd
         oTwL5AGgHez+mX4GhrQKqEZRuZbNQRmfukFFOL4VEGf9YU33V8Cb2xvSisPS6dM9h2tt
         nyz7K9Nr9+GXe8TnSbwhKaAnsHEzUWgR1mWJljb4yPjFJm+PAFkTLXHjzQkvb2/FPQ4r
         ab/KZcqewgzauqN6SCChujIHvZU6c8XYJbDxKept1D+7uw3WMOht4HtTf5jWZ6twZ696
         SRyAhWVxWJoshmckeJ0ah3WHC5NAOoIk+VFhnL2hyNYfdmDZ73oDYEHzeSyBwGFXDaJG
         b7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231396; x=1791836196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCiUSXl1sTqT+a31rbofdcXjLxgQuX1RkjO3vSRBV8Y=;
        b=PrB/UVRJHjYhXPNbN4EYF+kSHqi0S+wsin7qygsfYV+P3BaIEUah04jggujmfYc7DW
         zJp1JItR7TwEHF+27T0PLgHx0K0UylS2W6TyTYDm9zGFs63PuFAPafoYWDI54ZSqH2+/
         PcBUjX8pwThAYZzTUuFW1+uzC/quGUKr5NI6AzuMaMeiWZeydl4yWKkeMmSP0i+bXTCG
         Rgwhk1TGvOaRXHFTbxvef4llgLLf6dEpL6hHOqqQw2a/+8tP6tpnSXh7wquZ1trvuDZ9
         uGFy7wdfggGKmcFKgZ6qXgfiG552JqjW9PRPEFHMMHyoo7J+GErHuTyevPvPLvGbpv14
         47Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzh5ezdg/S8EKz1dpj+gak+UmxiLrxuXIr+wU9QU+mmKQRpKe/isJXTz4ZoJjfVylfDxP/Fl/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdlqPSZzGd/WoPFT22YY0NOx2FI9pygv3F62DGSJoA1ZZU5pVN
	BhXR+vvqPWisNvf6n7mgNcfVMH6ElEd9MGgqaSCCW2aV4Nt+OLfCDi6Y+Jnxt8OCcMo=
X-Gm-Gg: AYBFou2ZqotR8Stj7zS/75uOf3WjYLfmr4Zes90P0UbK3gALA4e5qH/o0UyDE+mkvkD
	c0nKbhG1dFSBNBX3td/ztMxojGxl7iaXISzj2nEt2P4A3gZdiMox+FL7M8QU5QCYb218tj3L7oD
	qrCoXCXXIAmNz6Vick72XxpPCXg3HeH6ijQej+i3M8ha0ghI6qeJft+AqI8T4ZuPKtoNqiY+2Nv
	iwkrJ/czWCP7wStNbP08kwKrSq2t/0COiYsLIacFR7dLscLM3uYMGlbhuH12GRGPL+5Uz1Ycw82
	B3bwxNHGSSBnhyq+5c1gEnSR6GE5+J3Yr5eQN79lUIoEcyMitKAujGCbk8Nq/w2oUZx5775wYGo
	IzeYspdOYjrvy/NwjC5FqawhKOwKh/ue67b4AWucXmWfWR2S0aC28nM+DYcjxIirHHnEX1chnd5
	A7lbZWV2uc8cVwXtTYTgdSDCGRNAZws0mLfJ+5yQtvVSVdKjd2MzZW6CIWdbJndSQ6CpqJu/06c
	Z31JouO0W2W4I19w5zz1duyjFov76PtmAfcig==
X-Received: by 2002:a05:690c:7448:b0:8ab:3938:dfbd with SMTP id 00721157ae682-8af721149cdmr3487907b3.31.1791231396588;
        Mon, 05 Oct 2026 13:16:36 -0700 (PDT)
Received: from toolbox ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af515d034bsm12664527b3.42.2026.10.05.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:16:36 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:16:09 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <fustini@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
Message-ID: <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>

On Tue, Sep 29, 2026 at 03:10:11PM +0200, Lorenzo Bianconi wrote:
> stmmac_update_subsecond_increment() ignores the error returned by
> stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
> addend and system time programming errors, always returning success. A
> failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
> system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
> leaving the hardware timestamp counter in a non-running or partially
> configured state while the driver keeps operating as if timestamping
> were up. This matters for TAPRIO/EST offloading, which derives the gate
> base time from the hardware timestamp counter.
> 
> The same hooks are also called from the PHC callbacks: settime64 and
> adjfine drop the error and report success to clock_settime() and
> clock_adjtime(), so a dead PTP reference clock goes unnoticed by
> ptp4l/phc2sys.
> 
> Return error codes from stmmac_update_subsecond_increment(),
> stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
> settime64/adjfine callbacks instead of silently returning success. On
> failure, roll back the partially applied configuration so the hardware
> and the driver bookkeeping stay consistent, and report the reason
> through the devlink extack. Also guard against a zero sub-second
> increment, which would otherwise divide by zero when computing the
> addend.
> 
> Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
> tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializing
> timestamping, so a failed init does not leave TX/RX timestamping
> enabled on a counter that never started.
> 
> Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to generic HW Interface Helpers")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v3:
> - Do not run stmmac_config_addend() in
>   stmmac_update_subsecond_increment() error path.
> - Return error from stmmac_adjust_freq() and stmmac_set_time().
> - Reset hw ts configuration in stmmac_init_timestamping().
> - Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com
> 
> Changes in v2:
> - Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
>   routine.
> - Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++++++++++------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
>  2 files changed, 84 insertions(+), 32 deletions(-)

Hello, I'm noticing that after this patch was merged into linux-next,
boot seems to hang when ip=dhcp is used because ethernet isn't working
on the TH1520 Lichee Pi 4a. These lines get printed in a loop over and
over

IP-Config: end0 hardware address 72:ca:a8:eb:27:[   24.872982] thead-dwmac ffe7070000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
f2 mtu 1500 DHCP
[   24.900412] thead-dwmac ffe7070000.ethernet end0: PHY [stmmac-0:01] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
[   24.912780] dwmac1000: Master AXI performs any burst length
[   24.912801] thead-dwmac ffe7070000.ethernet end0: No Safety Features support found
[   25.010229] thead-dwmac ffe7070000.ethernet end0: PTP init failed
SIOCSIFFLAGS: Connection timed out

I suspect that this has something to do with the error codes being
discarded in your patch/some particular quirk of this hardware where it
doesn't support these PTP related bits.

I've CC'ed the linux-riscv list, in case anyone here is more familiar
with this particular board and knows why this is happening.

Regards
Anirudh Srinivasan
