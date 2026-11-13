Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583087;
	b=laIvvNCn2/pKsKnSSnUprIAXi7EZpDwQVwGtc/6RhSBRbrCr08qpmEKEVp/r1sEwQGFI
	 hfdkJOQtlnCHfqlIRmcFjk+7Eqw//iaRxCSfsYDa+//THe3t3Pj6j0n9Kqg6jmvgSh2IG
	 d7h5ORSWPXxs5WTKQRzkwZK/l7/T5aX/xar2TWlM7BJkM6V3spDiXDuAf+rQOQBWr2m7O
	 QiU7wGHBGLP81Sv1bupkJXEGSmE1oT5cBigIoC8gy5ox6jw+09pJtBL6ykxiGNmZhbZdY
	 AR7/Ee9zjqIe0mn73DNjJlX6fYlD9CS35kZ1IcxI+ERyZYi5GU3YcnXO1MimZJVFJBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583087;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=cAIGF/N/dcgGFqkWqmHvmxdGrhlHqENgdut6TKmMIms=;
	b=mOMJRE7WDiPJHtCO+jAcMF9HcuSvxqd3Gs9KkxLK5ek1/CT7sOOryeuK1ywQNqPv+lqN
	 VtigJKLCMW5TPS2ZjlGirTi9lFkGkfPbmc6js7IZbY0d/k2BzBaitl9q1nIxkNdhW2lyv
	 86OfA8nTgGQbRwohTRZ1ecxtGKhWoqhgKL1nSqB3lyi5ySCLQVmjsB4CefSDEyg2OwjFY
	 dUwDle3o1evN64wEzKxoDziCluwkREG7kJ68uugd0PHTJivg3KXnemsqCwYkiaE42dj9I
	 TBfVM7zmHfoL0mcFEZsRy3BXZM2qNSXGFPPbyXf5nxFxAlnYit+GM8p8z1v4rpqbCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=GblbfX92;
	arc=none smtp.remote-ip=173.37.86.77
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661B606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C661B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=GblbfX92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1629; q=dns/txt;
  s=iport01; t=1794583086; x=1795792686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cAIGF/N/dcgGFqkWqmHvmxdGrhlHqENgdut6TKmMIms=;
  b=GblbfX92o75YxLT5i3+IuNa3fKsCYi/xLtY/G27eFpB9lY2kUWBjkrA0
   EdHYuEdFFn5pP55lDmpweS8WBcZZhUkSvkoDYxVPXMHzqF5PUY+BFMSyU
   wHN/MxH9yyORyI8q3zqTzYPQ/TRADneLhxqiYXpjwoGGzKhaQiwydqrea
   2z97jprSce+p6og0U98v8/5tAaUlUzSxxVtU177ayvTvuukujIzX4ImLe
   ZwfoqflA7UzBRBkMy+tYv5/DwCDZ86xpQ+8u7JBI08gqvcC/ZIbGTolbu
   /fqMDzk/MFloU0p735Fpl0lgm/TaEUxsEKS0ZIWis7ADV6xZgo1SQcKkh
   A==;
X-CSE-ConnectionGUID: fFS/OjccTTK0iwMW/oNSbQ==
X-CSE-MsgGUID: AbZBe0ZIRbmCFJ4UcS1XEg==
X-IPAS-Result: =?us-ascii?q?A0AnAADQKPdq/4z/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBhCtDhSCIG4lZA54iFIFqDwEBAQ9RBAEBhQUCjh8CJjQJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQEwEBAQIBIw8BRgULCxoCJ?=
 =?us-ascii?q?gICVoMbgk4nA7pCeoEygQHeR4F0FYEKLgGFc4JuAYUDdoR9JxuBSUSBFAGDL?=
 =?us-ascii?q?D6EKmaDD4JqBIIigQyXd0gKeBwDWSwBVRMNCgsHBYElQwM1EioVI0sFLR2BI?=
 =?us-ascii?q?yEdFxEeWBsGBRIgKkBDW4ESgQVdgSsoXQECH0YtFYF1AoJRgSNdAgFJQQ4HR?=
 =?us-ascii?q?VMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxbDAgDGgUaJgIfCAILAgx0KBEQE?=
 =?us-ascii?q?x0eJC8FGiY+GwqBDgUYDUgRLDcVGQQ9AW4HlRwPUBMVQgEiCRJEcQkpAk6TJ?=
 =?us-ascii?q?SIHPJIFgTWKQ5UZhCqBaJ92GjOEBI0UmVqZCKQOTYRqgWg8gVkzGggbFYMjU?=
 =?us-ascii?q?hkP4H8mcQcCBw8Ck3EBAQ?=
IronPort-Data: A9a23:sRKWhqjan+/g1IYjGFGiX4O+X161oxEKZh0ujC45NGQN5FlHY01je
 htvCD2COP3ZZzejc48laN7loR8H7cKAnNM2GQM9qH1gRnljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FHwdOCn/SMhvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeAULOZ82QsaDxNsvvY8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUW1N0wJmNF/
 sAkC2gMcTW8wOWQ+7iCH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg9/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9J4DVHp8IwhnBz
 o7A103zMDsXbO6+8zCA2VyO2tLEpnrLdY1HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVXBCipnOA+BkGVLJ4EPAw4SmOx7DS7gLfAXILJhZHZcAqudFzTzs2l
 USAhNPoBjtHs7CPT3+ZsLCOoluaMC4ZN2IdJikJUQcI/fHnvYc1yBnPJv57GaS4iNzdAzz8w
 zmW6iM5gt07i8MX26il1U7IjijqpZXTSAMxoALNUQqYAhhRfoWpYcmsrFPc9/sFdN3fRViat
 39CkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:1BillK8rFtMJ2Dzho5Nuk+D+I+orL9Y04lQ7vn2ZhyY4TiX+rb
 HIoB17726RtN9/Yh8dcLy7UpVoBEmslqKdgrNhWItKPjOGhILAFugLhrcKgQeQeREWndQz6U
 4PScVD4aXLbWRSvILd/BSyFcomzZ2s9aClgvqb8lJWJDsaDZ2JK2xCe36m+oocfng+OaYE
X-Talos-CUID: =?us-ascii?q?9a23=3A6hWqoWqBS3CIWFz+/JfLWAzmUc4LSTr6znzbH3O?=
 =?us-ascii?q?bUWd2bYLSTnmr8poxxg=3D=3D?=
X-Talos-MUID: 9a23:YJ1WHgqSICk65GgQUVUezxhoBu1lu5aPMkoIursk5/SPDnVAFjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="547325471"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2026 15:17:59 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 34C401800061A;
	Fri, 13 Nov 2026 15:17:58 +0000 (GMT)
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
Subject: Re: [PATCH net v7 1/2] enic: retain admin-channel DMA until queues stop
Date: Fri, 13 Nov 2026 07:17:22 -0800
Message-ID: <20261113151722.3116868-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179450328635.2199510.2101319582570477640@kernel.org>
References: <20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-0-30ca6f467673@cisco.com> <20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-1-30ca6f467673@cisco.com> <179450328635.2199510.2101319582570477640@kernel.org>
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
X-Outbound-Node: rcdn-l-core-03.cisco.com

Thanks for the review.

> enic_admin_channel_close() can return an error after releasing the graph.

Agreed. The QP_DISABLE result and the direct queue-stop checks describe
different outcomes. If both complete disable helpers succeed, the resources
are released and the state becomes DOWN, even when firmware rejected
QP_DISABLE. The partial-open caller can therefore print a misleading
close-failure message. The queue-stop proof and resource handling remain
correct.

> The quarantine check can close a PF and prevent its reset.

The ownership check deliberately remains outside enic_has_admin_chan().
Disabling SR-IOV clears ENIC_SRIOV_ENABLED but can leave retained admin
resources with unresolved DMA ownership. Clearing that flag must not
bypass the reset guard.

I agree that PF reset and reopen policy need to be consistent. PF
admin-channel activation is dormant in this series because
.sriov_configure is not registered.

> A failed internal reopen can leave the interface marked up and allow
> repeated NAPI teardown.

Agreed. This is the pre-existing datapath lifecycle issue acknowledged
in my earlier replies. Adding dev_close() directly after failed reopen
would invoke another stop and can encounter the same problem.

I will handle the pre-existing datapath lifecycle issue in a separate
fix. The PF quarantine and recovery policy will be addressed before PF
SR-IOV activation, and I will follow up separately on the close-status
diagnostic.

If there are no further concerns with the two fixes in V7, would you
please consider applying the series to net?

Regards,
Satish
