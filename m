Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656179;
	b=0HIo01T5IIr/Xtxho7QRQqkMAtFUMZ7RvyEktlzEH3G0vHUAWWBD2LOWY+ClknrRiq86
	 V+93VOuMnws5hTozYW0gPyNsEtk8WFDgSrl0NDro5TzBQXDK1WSXBVT7tQAQ5ux/9B6j3
	 JkwhQQyFepPNrrVR+4w0LpZOFHWOk1hxPXkx9nDurh9kXzti3T5brRRJuSMhBYiL359tP
	 gicQVrQWZSDDBXQ7f2/SdLHhV5VRvXN3mP05yp09uzRBmbg4lVo50ERQMmwRgCRvpTnXu
	 oByuZsYXL/E1gKRGBn/nnt72abBAMI69GIS2fa+JCL3MY0YOSHbWX91hqfp5Y6HxxFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656179;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=6Q5a2xUO39v77POem+TTCk4xnpDmiOALJGJI1qwVmFc=;
	b=39l/3BAXqpXSJNuaMjJBSGmiYd9uaZprnYgUVmPJB4cAq2G1D0SgVKZxBg0oZlbxdxpg
	 AniXwVPwy1W7PUz5V1L9q1dELmtMXDpeNuR/3HnddoCoVtxFUesVT5n+JEYIn5oyM6vh9
	 ibpfrkN38nGaNprB2f81FkVJu+YgSrruX4hmWjQ4qNjVcPz4S3LsCcMBr1JkuzABKhUjj
	 GaK63mzpjyymdu9dGu+4DW+e4+mLh4BwDbtmCXNwGIgkVrzbhAvD6/7m6nyhY6N0D6zSB
	 zuatjRp21AIXYm7NA0/DzYJ5TgBOFtWtdEWDYptN2pufMQis5Q6/4byDRuNQQwU31zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rijvu1Zd;
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6326606A327;
	Mon,  2 Nov 2026 21:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6326606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rijvu1Zd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793656178; x=1825192178;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=6Q5a2xUO39v77POem+TTCk4xnpDmiOALJGJI1qwVmFc=;
  b=rijvu1Zd6Ufs848eulZ0WMG9E0a/wT7GKHatkPOIKO0dG2kFQKAyNp1+
   PqqE0M121BIyXpZ+ruMnB4oD5lar/4IaYeW01aDy5qdCahu+XqHuZDqq6
   23le/6RSLwn9+6b41GCXEcm3X7EqeMNmThh1Ej8FoX0jKDnr8EqChb87b
   JeHEJqtqDdxfGviHwWFxCMFheWc8viRo3NmTH4EMTWFkOnWx7Ue1Bz9KB
   +ro1DwUBMXGRs7DqtyLNGSYZWxeTEzyRU9Kf1IwcqeH6/AUgQnEUfbHM+
   q3tu3Fic+0woZ8NGCDXAIPqMVUMUM3EjaY9++f2wfP8l7wmtPkgoj9a5q
   w==;
X-CSE-ConnectionGUID: ISbOo7rEQqyAW7I/m/6ezA==
X-CSE-MsgGUID: 5vkqLfBAToCWC65PVe2ffA==
X-IronPort-AV: E=Sophos;i="6.27,192,1787011200"; 
   d="scan'208";a="32920958"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 21:49:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1024]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id da486bd7-4b4b-4e5a-b155-9370e3643b8d; Mon, 2 Nov 2026 21:49:35 +0000 (UTC)
X-Farcaster-Flow-ID: da486bd7-4b4b-4e5a-b155-9370e3643b8d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 21:49:35 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 2 Nov 2026 21:49:32 +0000
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
Subject: Re: [PATCH net-next] net: ena: Fold header containing PCI id
 definitions into driver
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
In-Reply-To: <20261102110907.356621-2-u.kleine-koenig@baylibre.com>
References: <20261102110907.356621-2-u.kleine-koenig@baylibre.com>
Date: Mon, 2 Nov 2026 21:49:24 +0000
Message-ID: <179365616498.28818.15452478866037209509.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 02 Nov 2026 12:09:05 +0100, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> The file ena_pci_id_tbl.h is only included once. Fold it into its only
> consumer, simplifying a bit en passant.
> 
> Note that I took out the trailing comma from the expanded value of
> ENA_PCI_ID_TABLE_ENTRY() and thus these commas have to be added when the
> macro is used improving readability.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Hi Uwe,

Thanks for the patch.

I'd prefer to keep ena_pci_id_tbl.h as a separate file - ena_netdev.c is
already by far the largest file in the driver, and I'd rather not grow it
further when there's an alternative.

You're right about the missing definition though, and I think we can fix
that by adding #include <linux/pci.h> to ena_pci_id_tbl.h instead. Would
that satisfy your check script?

The rest of the cleanup can be applied to the header instead:

 - drop the #ifndef guards around the PCI_DEV_ID_ENA_* defines, nothing
   defines those names anymore
 - drop the PCI_VENDOR_ID_AMAZON fallback too, <linux/pci_ids.h> has had
   it since 4.18
 - keep the trailing comma change, that's how the other drivers do it
   (mlx4, e1000, cxgb4, qlcnic, ...)

Would you mind respinning along those lines?

Thanks,
Arthur

-- 
Arthur Kiyanovski <akiyano@amazon.com>
