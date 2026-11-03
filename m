Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742404;
	b=ctYJu42uI48FCs25TAyG4Xg75ALbEYbS95oUh2uIUfD7Hm56aIrI4xdOCuZoHi34lA+z
	 JXjo5HE64csu6DknrB3Tnr33LH2hafe4MDf37R+m95CszUv3Czbtu5eZZoivpaxzdSRx2
	 YVOYVT+bqJPkTBcCBwTpiY2HsSVTNGtWzaHZIru6dw275eNU+t92TLLxD+mbVYi6NP96N
	 /mUi7/ihJf2lWipa7kUzWQ9yU370P41hRpoGU5qt82uKiNkQQtlPgrYSw3pNLF3aoSRRm
	 8AcQzdDeJMKQbpJSsXdZsqOlVZCHELLkaYyypscCHSe5zVkHivUrV+igASLTSDg1BcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742404;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=qyMe3yeLglJYxlv9s0/8qgPxTyiAnu+GlNhAMB8vGLs=;
	b=xT0QjkoZ0LVHjOuKEvwaMkarn881sS+jL5jnD0ngyaoxRbM+NteX603bPlu0JHvoeeMQ
	 s/ZFVsPj8OeOqVXkhUvN8EgVkPpbAcZidkkxMIv8/4a8ueNBtzCWJ2L775fF3kvMYhKwt
	 y5hNsWp/qObftzjPf3lNUe+jTqMFqdU7ofGvAIYdg2apLAn2/NyiI8u7VKpb8L0f+VgZU
	 tlQqVXsV2GKkwScai6TGwtGKLhrZx1pBkLDQo+7iPnyFFGaTredybE75xvZw6pBm46z+v
	 8e3+Ahi0LFppv/lDsmnSxKC2Gh83iY4F0UUISQv+ZAxMD/Gmc9EHZOYoPG36o4/54yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=LnutgMG7;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF4606A31B;
	Tue,  3 Nov 2026 21:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BF4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=LnutgMG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793742403; x=1825278403;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=qyMe3yeLglJYxlv9s0/8qgPxTyiAnu+GlNhAMB8vGLs=;
  b=LnutgMG7Hbe7MwgNj9NUR015udrHZLPsaz6TEYtZ+M4tKIh964Bgv+79
   lpraGoSYEjMkMcketCXnq6O4TSZjPhvUgtHIi0IE+UqBOPbB4qtzKxsFJ
   thF+5x42JyP32r5A/Mgp/vl2jPGnnLxbTZnq+2qHgK+/6edhW2cC/PbEu
   i/fka2zYwED6lElWFaKDjCtQ3gDM8OU2SUAWckwX9+Vindtp5y+K4I/4d
   AOi08nE3+qHU/WYxeQ6MVkj8rHQugS/uMLgGdupU9Uc6t86TG0/QSg2Z/
   M1UIJib8BXs8RiBvm6B4bKAfYPNe3bPPmPkB+vw4d7n+VTWgRyNw/1dkl
   w==;
X-CSE-ConnectionGUID: OpcKOVCeTNOLEd/v4qaigw==
X-CSE-MsgGUID: xHDQBtYJTQGvfA8IqPVrLQ==
X-IronPort-AV: E=Sophos;i="6.27,194,1787011200"; 
   d="scan'208";a="32787604"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 21:46:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:19740]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.155:2525] with esmtp (Farcaster)
 id 1b5c90a5-db3e-49b5-bbb5-5883027ee1c5; Tue, 3 Nov 2026 21:46:40 +0000 (UTC)
X-Farcaster-Flow-ID: 1b5c90a5-db3e-49b5-bbb5-5883027ee1c5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 3 Nov 2026 21:46:40 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 3 Nov 2026 21:46:37 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ena: Make ena_pci_id_tbl.h self-contained and
 simplify
From: Arthur Kiyanovski <akiyano@amazon.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Guangshuo
 Li" <lgs201920130244@gmail.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>, Dawei Feng <dawei.feng@seu.edu.cn>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20261103132240.442686-2-u.kleine-koenig@baylibre.com>
References: <20261103132240.442686-2-u.kleine-koenig@baylibre.com>
Date: Tue, 3 Nov 2026 21:46:25 +0000
Message-ID: <179374238505.25455.17667710690128282849.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 03 Nov 2026 14:22:40 +0100, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> The header makes use of struct pci_device_id and PCI_VENDOR_ID_AMAZON.
> Include the needed header for those and drop the local definition of the
> latter.
> 
> While touching this file drop some cpp guards and improve the coding
> style.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Hi Uwe,

Thanks for the respin, the cleanups look good.

The subject is missing the tree tag, so as you suspected this didn't reach
the netdev patchwork or the CI bots. It should be [PATCH net-next v2],
ideally in reply to v1.

On your note about the variable in a header: fair point, but with a single
user I'd leave it as is.

>
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h b/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
> index 3ecdf29160ca..72605991528c 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_pci_id_tbl.h
> @@ -6,39 +6,24 @@
>  #ifndef ENA_PCI_ID_TBL_H_
>  #define ENA_PCI_ID_TBL_H_
>  
> -#ifndef PCI_VENDOR_ID_AMAZON
> -#define PCI_VENDOR_ID_AMAZON 0x1d0f
> -#endif
> +#include <linux/device-id/pci.h>
> +#include <linux/pci_ids.h>
>  

These make the dependency explicit for your scan, which makes sense. The
header still isn't self-contained though: it also uses PCI_DEVICE(), which
is defined only in <linux/pci.h> and isn't provided by either of these two
includes.

I don't think pulling in pci.h is worth it here - ena_netdev.c is the only
includer and already has it - so I'd just retitle it to something like
"net: ena: Make ena_pci_id_tbl.h's device-ID dependencies explicit".


If you do want it genuinely self-contained, moving the PCI_DEVICE() and
PCI_VDEVICE() macros into <linux/device-id/pci.h> looks straightforward -
pci.h already includes that header and PCI_ANY_ID is already there. Note
your script won't flag this one, as PCI_DEVICE() never lived in
<linux/mod_devicetable.h>.

net: ena: Make ena_pci_id_tbl.h's device-ID dependencies explicit

net: ena: Make ena_pci_id_tbl.h's device-ID dependencies explicit

-- 
Arthur Kiyanovski <akiyano@amazon.com>
