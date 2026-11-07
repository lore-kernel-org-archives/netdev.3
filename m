Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074376;
	b=Yjh4A+ch8t44nRU8JlcQjWFe6jeBXNq1l8lFFnKEbDD3gGq0LEi270TuFRFEMdMaDyqi
	 /uZace+VQzRAjdsqXvXbdU+Yw8OAtFOiRJt2MZ13yB4WZEImQsJ/8yR9cXKWGKTLfmVW7
	 4cgEHZpFoWWWb6azUku/Jv891NloJuKkJ4BD/LVl+7byCzFNkvyokX8dYT0WNRxzg1g5q
	 zgzJuQQmSubmiGfWGjVYAxCtiOJujdIUtVQBWIihA4sfhpR70lUnekvLE2RXdBfw3Cr32
	 RXBuSs2pM17ez7/3XNW9jFd22zUOftq2chwoxBTsEvlphGvbCPS21FLWHl06rmppvUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074376;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=3YIZbDWLhjFZp3TZcUfe8N0OzJoM90vuAbv+FC37iQs=;
	b=v+yM8j7i3UTlRyXcPnwH3bhSGE8nPanfNZWdSDx25ZUvq5jGY4OeBMpDMXo3wTNW+XMs
	 RrfdX3bev30jZXd0gh8y4Oj8bSWKZ4y5K+fd3XYcsKiPzFEsALNtod3t025o/GRMDxc0g
	 N/X0L97Za1s5LTHrVpyEU7QHY/mv5w9MvCOKleh1bHp+DTpsXt39dqjUgfkMIwf9ZyKNd
	 ALh2rgnpnG7lbE2dKf+TECeDAF7lL6S1QcrMScMuxeWNN1TFZiFUghx+IvM5eCeGAtDst
	 J58wNvAB2tTZOwzYB88I6vLHNy1VDcWhADLqO1qvj3ZMFL8dUM80XHSNdrhIF9U+25g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=h893Es9s;
	arc=none smtp.remote-ip=173.37.86.73
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DA9606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 17:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1DA9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=h893Es9s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=949; q=dns/txt;
  s=iport01; t=1794074375; x=1795283975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YIZbDWLhjFZp3TZcUfe8N0OzJoM90vuAbv+FC37iQs=;
  b=h893Es9s1SBnqchaNy+rYapw77HS/Lfo83R7cyAXPCdJlMqd6dsJXzBY
   GC08eYqbKBUdRzLZpsO4nJ1UAEOrRHY9osiMaA90z+t+NZo60luQmPHi+
   eM3LvheVUjhYzeeffRVU8WtXml4+Mqdi8iHzdskLaCGvRLSsGi9N4QgIC
   xb/RTPLIqqjJ5RVjK5Ef6/PbzL++qgPfwTz9NRWvW1xpXo2BevbDHAcnG
   0gdiN4SXOOw0nXqw1WYD5Xu7L78Qjec7ODgsyrwBFQzEI9hEnbReKrA2S
   L4syBZyrQxR947a/GCOKifOVsk8yvKMYV6JzYWrBlNPr1N2A7toin6DcU
   w==;
X-CSE-ConnectionGUID: +O9UwdB2QmulNn2ZLZEB8A==
X-CSE-MsgGUID: O5QgWalCT5uqXsb7HqtRkA==
X-IPAS-Result: =?us-ascii?q?A0BfAwAhZu9q/5D/Ja1aglmELEOFIJF0niSBfg8BAQEPU?=
 =?us-ascii?q?QQBAYQEAYEAAo4dAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZckBMCAQMjDwFGEAsaAiYCAlaDG4J1A7w0eoEygQHeSYF0FYEKLoV0g?=
 =?us-ascii?q?m4BhQN2hH0nG4FJRIRAPoQfcYMPgmoEgiKBDJdASAp4HANZLAFVEw0KCwcFg?=
 =?us-ascii?q?SVDAzUSKhUjDzwFLR2BIyEdFxEeWBsGBRIgKkFDW4ESgQddgSsoXQECH0YtF?=
 =?us-ascii?q?YF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCAMaB?=
 =?us-ascii?q?RomAh8IAgsCDHQoERATHR4kLwUcJj4bCjYYDUgRLDcVGQQ9AW4HlU0ILIJBJ?=
 =?us-ascii?q?ikQlAqSBYE1ikOVGYQqgWifdhozqnGZCKRbhGmBaDyBWTMaCBsVgyNSGQ/dZ?=
 =?us-ascii?q?SZvAQEHAgcOAwuBaJARgW0BAQ?=
IronPort-Data: A9a23:2tORC6ozxFTvMhqM9h4UG/cxkfNeBmLbZBIvgKrLsJaIsI4StFCzt
 garIBmBOPuCN2TxfYh1adviphkEsZXQmoIxSQdl/n00RCgTpOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8jhfngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfva8Ew35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0qVQUFxR+
 dZCETUQajaF3dCS8p+RGsA506zPLOGzVG8ekmtrwTecCbMtRorOBv2Vo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LVPrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXHpwMwh7A/
 T2uE2LRJUwjO+OWzRG5r2+1tvTFwgPiRLgRPejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW7rWSCsxpaXMBfe8U59QuE4qnZ+QCUAi4DVDEpQNorqMM7W3kg0
 UPKhNryBT1st5WWRGib+7PSqim9UQAcK2MYaDBHSwYZ79T9iIUuiBSJRdYLOLa8hNDzGBnqz
 jyKpTR4jLIW5eYN2rm38E7vnT2hvN7KQxQz6wGRWXiqhj6Vf6a/bICurFye5vFaIcPBER+Kv
 WMPnI6V6+Vm4YyxqRFhid4lRNmBj8tp+hWF6bKzN/HNLwiQxkM=
IronPort-HdrOrdr: A9a23:C9hA/qqSJQoxPSh0Fhds7jEaV5oNeYIsimQD101hICG9vPb1qy
 nIpoV96faUskd0ZJhOo7690cW7K080sKQFgrX5Xo3SOTUO2lHIEGgK1+KLqAEIWReOlNK1vp
 0OT0ERMrDN5CBB7frS0U2fD8sqxsWB/eSDgOfTyGoocCRRApsQiTuQzm2gYzVLrM4sP+tBKK
 ah
X-Talos-CUID: 9a23:wNPWvW+d2dVixDR+oiyVvw0zS/06fleH9XLNJ2m+U1RNepC/GXbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AHRh5HQ/BG9bXWxTHGt7HjU+Qf+A12quRAUQmrcg?=
 =?us-ascii?q?bovmfP3NQIiunjx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,200,1787011200"; 
   d="scan'208";a="531140037"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Nov 2026 17:59:29 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 3422318000236;
	Sat,  7 Nov 2026 17:59:28 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	sebaddel@cisco.com,
	aradhana@cisco.com,
	rfaucett@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v5 2/2] enic: require DEVCMD2 and set the V2 VF mailbox source
Date: Sat,  7 Nov 2026 09:59:25 -0800
Message-ID: <20261107175925.1142634-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179406378616.994134.1586384067056474250@kernel.org>
References: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-2-2501d1223eff@cisco.com> <179406378616.994134.1586384067056474250@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-07.cisco.com

Thanks for the review.

The statistics ABI keeps the version-1 prefix stable when later fields
are added. V6 will therefore accept version 1 or later, while continuing
to reject version 0 and the PF-source sentinel. Focused tests accepted a
synthetic version-2 response and rejected version 0 and the sentinel.

CMD_SRIOV_STATS_GET is intentionally mandatory for V2 VF probe. Without
it the driver cannot determine a trustworthy mailbox source ID. A
CMD_CAPABILITY check would only detect the same unsupported-command case
earlier; it cannot provide the VF ID or a safe fallback. A V2 VF whose
device does not implement the command will continue to fail probe. V6
will state this explicitly.

I will also narrow the sriov_stats_dma_unresolved comment to the two
completion observations implemented by the code: a blocking QP command
or CMD_CLOSE.

I have made these changes in V6 and will post the revision shortly.

pw-bot: cr
