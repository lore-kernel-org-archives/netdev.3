Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428493;
	b=IRogoOrMFv4QfGmpyQ61H0uDmqMKi3r9w78DW5UmH8ThBE3qYO3aN8Kz2lxw+DAOwM3x
	 IrCNzTMWYZbkJlw7bJEl6Id25Gc7yjIZo9k7l4GUM8UiwpEOF3SoB4Sicn5Ypos+VCFS1
	 oVtbVk9pMDa9awu45E88oplzWo8uPDVeak+7XTebGAtPdwLj/Na70d9v3A74JGFSgztkR
	 hrN0D/3MlKyDEpk6Bv2s7D5tggfpkmn1AiW5uPieyw59X5zjBKb0s0o9G2MN+k4llPsu+
	 svjLgPBZT/bYtYpe7FGD00PPIfWY7JcRs0IIdKA+I4uXHaG30HrmfZVDquCJZwrwz/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K0hIN0bpC6Dn/BvmYWqGKn3KF1sCzO0zF6mJDzHB458=;
	b=tV5dFGys6ROB97jGrx73uuXB4oUBeoj7g637n3cKzfYXQr8NfJcgKOu5Gxhpqggnc66q
	 Y1R4tbpVg7ZG6xUyiB/0SM451BGD3qtpZVXiBAJEv1xab6FXtx4N9MVWbGon9bc2AhvcX
	 jNIKx7uNItKhEP50fXj28yZKlxIqctg/jisq8Mc6uUnoBknDRypXm/ZblApHCXMyxzKUq
	 JDHmLdM/u1o8Bct69TH6Nb8q0N6tOfbQaxM68zRZJTpQMCgcDUb8Z0lQ1jqrgIlEF2KcW
	 wAK6knWeZtSOHwJXMD8jqSJRuisYOITy2aSNcdNx5TpgfSKTGLRfM/ftBe382deuXKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF260A382F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AF260A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so836036a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792428492; x=1793033292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0hIN0bpC6Dn/BvmYWqGKn3KF1sCzO0zF6mJDzHB458=;
        b=DG1mFAzqzk//JGRpK3JU6J14rFrJ4QtDaVkglqrhU6wEfWqolUPPw5Z8HMkCspI+tD
         xK9hw4tFIbgjwmr0S7g0MSXc1R4XHOvL/4MILmzy6ySM2gYxhlqczlY2qf37GOWBeiHk
         v/qTdaCYoBmuDbGUTumGRl20WKbfGS74YmusNCr2OmLB8iFB2euomw080uAem/Cx6Utt
         wFxXQ3lREh6EgSZ1eCo4yWskR4xYcBZpsg1rPWyCOCcRFKVpd6qqJl5rzlSu/yw94RjG
         Yg67PpyEgUX98fb0IWFvobz6u7nXPBPboIc+faHIijungrnrgA6vzu93k+WI6bJaZZUH
         eOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428492; x=1793033292;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0hIN0bpC6Dn/BvmYWqGKn3KF1sCzO0zF6mJDzHB458=;
        b=y9L29DnsulfuXW3w+UQqcKHpcXIWTBkbXZHY+xsGLGA6R9LhLjOyNfQdxiwrChzAhE
         VYfFLlIMMV2dVD46dCLNNRyMy1Wtg+tUwX2NWOEaOP1AAeT9DWMKhoU329aRQQ9jH7wd
         31OMqCWsGfsSwdiCbnFPrJwmaQx3WnhS/KuD9/sBauoGge8nbvjqNBUNheLdZMn4IPgs
         +k0xl1i+0iue0EUGOhgD+mJgI1SBc8TXfaGhZiC7kTVQ2t81kp2y/vR0PTSni6Zb5YdU
         kRyNBQ3I2shdWnJiTQCmdBmPcn03rHC8YlgOrOEyAFOlARqIIjyMFFb+/ZN+wA4zZEsH
         nfZQ==
X-Gm-Message-State: AFq9FYIL385nZUWhSGt2rUAhsTo/Vq9a2QAs2B5HjWw6HhRdIoMBOaB0
	kapjDFRCSY4YE2KVgfD2SVlw18mph8pwFXsq8zJpMz7Rux1Ku7jEI7ilW2oEj91Df9o=
X-Gm-Gg: AYBFou0135p1stIGzjdt2GchCiyw9vSq+4Im20iSAaMRzWdEzw9RVgGNSN4f7+YKu1O
	f0mkaBwGtD8dporTxl1RtLRUK4XEaQcN6VerevFCMkKOkr+RIv/wdzdBs7U9kQJJFupQ0Tqds2b
	2FMq3gIRNhmzZnNq4VwL1rGHPFEl/tCZGoIJ2EvWXlV4qD0Txi07Pl2ETPqSI44vpz76zKZ1ijd
	mq37KCzPcAkRrSNIu5+sntNAij72OdRiJb6RcGv37iHwaTurr31B5SVEUmRpVCD97I240QbU/IL
	tTS5T8St5734IESbPZirn0GIe7E9VqLS1V1hBKfFXw+btgMh8aIAM2mRp/gH4UmiO7ZZkCDOdwu
	KxAe3JmnmfMCgygFgd6miY82boegJVv8TfxZ4M+VM8jeAavqtKSniyaSvZYFwUdCp7nWIIwc1HV
	/cvRjwmpjDyuRrOq7uDw1OL1bE6tTxCoaWQ1+yU7yLRtLkjUJkAd5/JRCbS3DtEEETt9R1yx0SI
	07JzQzqVJb9zKpbNYc+aZ61yDiI2SnhW4OQovrubmfDW2jp3drzMzPHUgqt2wYGiuW5K49t4AEh
	rvYynB+jW41jaOVTtiisBA==
X-Received: by 2002:a17:90b:1f91:b0:3ac:b3e5:426c with SMTP id 98e67ed59e1d1-3acef10e078mr6645588a91.26.1792428491792;
        Mon, 19 Oct 2026 09:48:11 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f34bb6sm37983a91.10.2026.10.19.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:48:11 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:48:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2-next] ss: remove /proc fallback paths
Message-ID: <20261019094808.1aebae96@phoenix.local>
In-Reply-To: <20261018200712.389-1-gopalmalaviya53@gmail.com>
References: <20260901144034.437569-1-stephen@networkplumber.org>
	<20261018200712.389-1-gopalmalaviya53@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 20:07:12 +0000
Gopal Malaviya <gopalmalaviya53@gmail.com> wrote:

> On Tue, 1 Sep 2026 14:38 UTC, Stephen Hemminger wrote:
> > This patch removes the old /proc/net fallback code in ss command.
> > The sock_diag netlink interfaces were all in 3.10, over 13 years ago.
> > No longer need to carry all the additional text parsing code.  
> 
> I tested this on top of iproute2-next (204a7210). It builds with no new
> warnings, testsuite/tests/ss/ssfilter.t passes, and on a WSL2 6.18
> kernel the output of ss -tan, -uan, -xan, -s and -tanpie is identical
> with and without the patch (ss -a -A netlink too, apart from the line
> for ss's own netlink socket).
> 
> One concern: the diag interfaces are in the kernel, but each one is a
> separate Kconfig option. INET_DIAG defaults to y, while UNIX_DIAG,
> PACKET_DIAG, NETLINK_DIAG, INET_UDP_DIAG and INET_RAW_DIAG are all
> "default n", and common configs leave some of them off:
> x86_64_defconfig has "# CONFIG_INET_DIAG is not set", arm64 defconfig
> sets none of the five, and Android's gki_defconfig enables only
> INET_UDP_DIAG among them.
> 
> When the interface for a socket type is missing, ss currently falls
> back to /proc/net/*. With this patch it prints only the header and
> exits 0, so those sockets silently disappear. I reproduced this for
> raw, unix and packet sockets (ss_before/ss_after are ss built
> without/with this patch). Raw sockets, on a kernel without
> INET_RAW_DIAG (the stock WSL2 kernel), with one ICMP and one ICMPv6 raw
> socket open:


I am ok with forcing use of inet_diag for this.
If users turn it off, like Android, they are in embedded envrionments
where ss doesn't make lot of sense.
