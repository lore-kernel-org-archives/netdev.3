Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096937;
	b=5FrBek1PJ9s7NE+IXEdraNpElCHumHJDu8fDOruZr0Optw4WZYNRdJ6u+RNTjmkGd5j2
	 kjmHBRx8HEmvzr1H/NCSPuHg7YP7VQupxHr1ldMQjbshed3KHRZ0oFl0AIlMq+4oRNsar
	 5GHAM0Ccbid1jKotKA81SV6Boohw6/f97x7kb2MPIDxh3XNStyQLwHVtS3BK8utsqvoWI
	 yCtDHP12r0deEbGD4LScTsGnWisjV+Sk2Gfh0Z48aPt4oAmi7B4VHsrCjmyHXqRSbZkWq
	 zJAM3/xqzmYvanmyo9+pjS69Cr/UkVtA9wTLWe7P3A0eCYzSFxmKXBT62+hynt7dVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096937;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yqedvBZFUhxFyUcRlmdBRM43DLeyO2kyhxdn8hoc8+M=;
	b=0Mu8X928PdMAPfIRe3Od9jbxzkiSzyoNs4JlubX7aWYkL6fetCHk/rR0dAy9s87AAjeS
	 Nlp5Gv/pIBVgEPGBfcV36hFy6efEwhHsA7koA8qe6Fg/xwyT/Iks7ttkw3EAZfeBjeXxy
	 8oXvC2rRgqwg1W/yzoLfjAGtb+sOLQCntj6EZeFX9EZLj07Ic0//2cCd8mZOk6619h8Am
	 KonrhfcjWWV+ikbMdYeFQzANTzi8kPGFidATM8A4BoLq8sVeVV4of8qPLGbn82vYGk4j3
	 qige/mLs7P6i/clpXZiegKItIq5wMTW50ZqJNaEWtoGkOqxOMLkRUM3/UVp5ekdQE/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1O+3jCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC6606A337;
	Sun,  8 Nov 2026 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1O+3jCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D562A1F008A1;
	Sun,  8 Nov 2026 00:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096937;
	bh=yqedvBZFUhxFyUcRlmdBRM43DLeyO2kyhxdn8hoc8+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l1O+3jCOxYSvLDSQTlDAZkvQdtFgi8onqQrJSGMudC1D5ZtzQb2+HYmKUzlm/Ldmk
	 Kb9g4yADEJjNpF7PgbG0nzo3jVxKaZS4JzOF7CQ/LbB3GQYOIGfCFgZqP66hAOk/I4
	 HESaLzp/W21YZ3R/9+hhwNBQ4GGEnuk+QE5r/lE3ee7/P8iaEWtbs+I87qRk2eeOjY
	 mU8FmpKMFe9ioHLsRTiyG+YkqM7pDp5clt0pBT70evk9ApXMsGQSGRDzrRAxw/QhxI
	 JLjltGAJ7IMT78wUtU25DWAZgub/4ccNuQJ1vUYopxcbnanNt/WO0U4qQmIAoQEwqR
	 Ibk4TzzLZCWFQ==
Subject: Re: [PATCH net-next v10 04/11] net: ethernet: oa_tc6: Move constant
 definitions to header file
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sun, 08 Nov 2026 00:15:35 +0000
Message-ID: <179409693545.994134.14195728930593325085@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-4-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-4-31b5a69b85b7@onsemi.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Hygiene and commit-message problems in
  drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h, which the commit…

--

net: ethernet: oa_tc6: Move constant definitions to header file

This commit moves the TC6 protocol constants, struct oa_tc6 and the related
enums out of oa_tc6_main.c and into a new private header, oa_tc6_std_def.h,
so other source files in the oa_tc6 directory can share them.
oa_tc6_main.c now includes the new header in place of linux/oa_tc6.h.

> To help other source files within the module share the
> constant definitions, some of the definitions from oa_tc6.c
> are moved to a header file.

[Severity: Low]
This isn't a bug, but the previous patch in the series ("net: ethernet:
oa_tc6: Move oa_tc6.c to its own directory") already renamed this file to
drivers/net/ethernet/oa_tc6/oa_tc6_main.c.

Should the commit message say oa_tc6_main.c instead of oa_tc6.c?

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> new file mode 100644
> index 0000000000000..c61672aa618c4
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> @@ -0,0 +1,126 @@

[ ... ]

> +#ifndef OA_TC6_STD_DEF_H
> +#define OA_TC6_STD_DEF_H
> +
> +#include <linux/bits.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/netdevice.h>
> +#include <linux/spi/spi.h>
> +#include <linux/skbuff.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +#include <linux/oa_tc6.h>

[Severity: Low]
This isn't a bug, but does this header need ptp_clock_kernel.h,
net_tstamp.h, sched.h and wait.h yet? Nothing in oa_tc6_std_def.h uses them
at this commit. Also, struct oa_tc6 has no hwtstamp_config, ptp_clock or
list_head members in this patch.

They only seem to be needed once the later "net: ethernet: oa_tc6: Support
for hardware timestamp" patch adds those members.

Could these includes move to that patch so this one stays a pure move? If
not, could the commit message mention them?

[ ... ]

> +enum oa_tc6_data_end_valid_info {
> +	OA_TC6_DATA_END_INVALID,
> +	OA_TC6_DATA_END_VALID,
> +};
> +#endif /* OA_TC6_STD_DEF_H */
> +

[Severity: Low]
This isn't a bug, but there is an extra blank line after the #endif at the
end of the file. git apply warns "new blank line at EOF" and checkpatch flags
it. The blank line is still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
