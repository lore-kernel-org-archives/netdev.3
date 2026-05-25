Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E43C2B9B;
	Mon, 25 May 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693360; cv=none; b=CEAtsmJO8OnGxNFwhvC/6YjzYUr4U7Xylgv31+Xm3RoU4f9CBVScEo/GI2+Eim98oPppdom9CbFhn6VZt5+NrANVUHhoIE6OQnDE9iwsDdaa2yC2NgE0Sbl2oCWBxOCJeO+u5ln+7NrJSl/9yD81TOgRJ1SOfMrfOwfNzhmyTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693360; c=relaxed/simple;
	bh=iuBreYJvhyQV6gpmK++2GKY4uJvlatLL7aevptdtLxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQ6qj9Sd4923/9tfTln1XRWfyZTBtIakpDVvXn3oMuvAzaKKmRS2wjfuohNmeOfhDX7rRIo2X2jOkftFVIBcszDTlBbSGgReAn2LeYLJtEwMi8MiPYsy6K+5PVL1YhQF8PSuuP2iIDVp+alj7KwQY1kAC1l0WBTCSJLdgV6wrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XmMXwquj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XmMXwquj"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P7FMS30878658, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779693323;
	bh=iuBreYJvhyQV6gpmK++2GKY4uJvlatLL7aevptdtLxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XmMXwqujRpc68UMNCOaDm5hT37L4Z7BegePTCipXFEsboqDaDJo3wx4XFEka3mD6o
	 4pq5WfJutoPa1FPdlbzzYVmHQDdN5BAw5CdxQI0tRdlp8lIwPjgTizKVJ1iXHOcVHR
	 7N4SBy91GNHYjZH52rQeuPeb3dnIZ8Cn1D8rXzFs++mLi+sb5obq4FthiAnz1nMfGj
	 KOYw0eIJJyjb9+5yRzTm2K9T5t1gOd3Oy88baD2QL+H235Vs+gGAp/W3uvgPkTG2Sn
	 YUDGBkTK0hHZmDyffSfMEVyINDAXlnpY5Zk5ZcleTvVosq1Cz5sZA4KTnKgJqzw+Sz
	 eA9d0kSSNWFUQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P7FMS30878658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 15:15:23 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 15:15:23 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 25 May 2026 15:15:23 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Simon Horman <horms@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch net-next v5 0/7] r8169: add RSS support for RTL8127
Thread-Topic: [Patch net-next v5 0/7] r8169: add RSS support for RTL8127
Thread-Index: AQHc6Ab/howjqCxyx0iKqc667QCn57YZQi4AgAUZQJA=
Date: Mon, 25 May 2026 07:15:23 +0000
Message-ID: <c8edeb5447444dc49e3ee7bf18166399@realsil.com.cn>
References: <20260520031603.700-1-javen_xu@realsil.com.cn>
 <20260522092004.GJ1506108@horms.kernel.org>
In-Reply-To: <20260522092004.GJ1506108@horms.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>On Wed, May 20, 2026 at 11:15:56AM +0800, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This patch series adds RSS (Receive Side Scaling) support for the
>> r8169 ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
>>
>> RSS enables packet distribution across multiple receive queues, which
>> can significantly improve network throughput on multi-core systems by
>> allowing parallel processing of incoming packets.
>
>...
>
>Hi Javen,
>
>There are AI generated reviews of this patchset available on bogh
>https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev
>
>I would appreciate it if you could look over them and address any issues t=
hat
>effect the functionality of your patchset. I do not suggest expanding the =
scope
>of this patchset, but rather treating other issues in the context of possi=
ble
>follow-up.

Hi,

r8169_main.c used request_irq() before, but I was suggested to use pci_requ=
est_irq() to generate the name for each irq dynamically. And I find that in=
 pci_request_irq(), irqflags is fixed to IRQF_SHARED. So I want to know how=
 can I handle with this situation?

Thanks,
BRs,
Javen
