Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074362;
	b=QMVu/qOCOA9oxSAwqlrRvyyQcoiyvLkNdOseux63ke/mT/ArCuGw7kHRccCNDdz5O8Ck
	 e2nXBTtWdnaOX+qp8uc1hVMy/JSWGfyMHdpV24ehLYfMc/TryM+mSYdKGIPmejmYnpgh+
	 OHwmLC+colLHn3liMtQlAYeXLHjFVRqnD7gjYETAUCUBnW4hMkN0qfA22TvEVe5rF1JER
	 8MdDoNsoilcYs+kYp1juZtLFVAuZ3o8Ko4wDVPbLg0lBxuPJg3WuNzf/0MR/7FAPGDIfK
	 fL2MmNMUrmFqLgXV+JCUBjxVCyvREIaSztflVzMflAlgaOZdz8jEwe+zxB9EsgRtkAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074362;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=uzOkJBvscllzdmZvCvzTDAl2OdOIWmkjqGhipcTCGck=;
	b=l1uhZA79M3A+cZv7miba7jMdQI+QAOzNJ48ec87G6sil9XuXLwDqPc/JPNfPlmyIeCN8
	 1LhWq05Eq+XWoAPGtXh7Dyb+9k+bQ991O/+oxO52IaG88MYe9QQwG1bil9K3PxyefsK3P
	 6VHXMvOJtUsDsO1zGNZ0XiQT0+h/4jxdxO5hHMgUBd8fLdqPGSkGVRZyLXAhZY/kZsaKN
	 kspCRMqWWFBQnv/4P04TofVqSrG2eCKPVSX4xVotY5yRNJvOiYWQ0tbGSzDxm7b3DZuhh
	 cr6iyDXgnK3UFotnhqjc0diP+qHWt+BFPFOMlZc8OL7dlfUBtSM/t1nxNFqI5xHysOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=XmFWHrlA;
	arc=none smtp.remote-ip=173.37.86.79
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E5606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 17:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17E5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=XmFWHrlA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=644; q=dns/txt;
  s=iport01; t=1794074361; x=1795283961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uzOkJBvscllzdmZvCvzTDAl2OdOIWmkjqGhipcTCGck=;
  b=XmFWHrlAb00t7nt7J/4RaGWijiJLwpTqnE0dufEvEpE8DTJF0UXus2Uc
   w9Xf5Iud11WrfUz1+7YibfhDDwNpd14sdBwOvn8hdDJj0Kpx7oLUD5sJA
   tuKLt4GrJ39kLXEzLhsFrdS7awALZSxcUBWm3IG8qTPAjpZKAXz5d3LyD
   JIh2VHjBBtk50T7jcbkIp49MTezzZpE/E/4IEzibLukH9eUzbo6JLnAPT
   ovsH+VOzHpiM5VmWAgUfIXX6iyO5SKBEXz2nBmBRC1LQ0RO0QrlqkG4mB
   9no/d0Wrw1kfYqkJx7jhY4Lf9m6USv9U0JTUgtiR1QNOxHiy9vNiTfCej
   g==;
X-CSE-ConnectionGUID: Pmb33teYR0Cp9XV+8q4jhg==
X-CSE-MsgGUID: KkkY16u+RZ2dvT/U5cwjWg==
X-IPAS-Result: =?us-ascii?q?A0BdAwDVZe9q/5P/Ja1aHgEBCxIMggULhCxDhSCRdJ4kF?=
 =?us-ascii?q?IFqDwEBAQ9RBAEBhQUCjh0CJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyQEwIBAyMPAUYQCxoCJgICVoMbgnUDvDt6gTKBAd5JgXQVg?=
 =?us-ascii?q?QouhXSCbgGFA3aEfScbgUlEhEA+hCpmgw+CagSCIoEMiBqPJkgKeBwDWSwBV?=
 =?us-ascii?q?RMNCgsHBYElQwM1EioVI0sFLR2BIyEdFxEeWBsGBRIgKkFDW4ESgQddgSsoX?=
 =?us-ascii?q?QECH0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/F?=
 =?us-ascii?q?QxkCAMaBRomAh8IAgsCDHQoERATHR4kLwUcJj4bCjYYDUgRLDcVGQQ9AW4Hl?=
 =?us-ascii?q?GIBD4FmVnp5ZJJjkkiBNYpDlRmEKoFon3YaM6pxmQikDk2EaYFoPIFZMxoIG?=
 =?us-ascii?q?xWDI1IZD91lJnEHAgcPApNxAQE?=
IronPort-Data: A9a23:eHfcSqA5Qb4VgRVW/+riw5YqxClBgxIJ4kV8jS/XYbTApGx30zxTy
 jEWDG/VO/7fa2f0KdslO4zg801Tv5/cy9RmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQb9hGYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE+/BkVxoqMLwios1vUFFwt
 qwBdDINYUXW7w626OrTpuhEnM8vKozveYgYoHwllGmfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYwBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEqj+K1b4WJKrRmQ+12nUWp/
 zzbvF7LWB0ECJuilDGa8E2j07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhas/7kqmSp/6RRLQiH2ZtBc0WNdKFeA+rgaXxcL85QuFCmUaCzRGdJ89vdQ2RD8t/
 lyEhdXkAXpoqrL9YXub+q2ZsnC0NDQZIHEqYTICS00O47HLuIg5gxTOZsxuHK68kpv+HjSY6
 zaHsCQzmZ0NgsMRkaa251bKh3SrvJehc+Iuzh/cUmTg6kZyY5SoItXwr1Pa9v1Hao2eSzFto
 UQ5piRX18hWZbnlqcBHaLxl8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:yP8isqBqSe6aPUPlHemK55DYdb4zR+YMi2TDGXocdfUzSL3+qy
 nOpoV+6faaslgssR0b8+xofZPwIk80lqQFhLX5X43CYOCOggLBR72Kr7GSoQEIcBeQygcy78
 pdmtBFaOHYPBxdkdvw5hW+HpILxdmK973tuMLlpk0dKz2Dr8pbnn9E4sHxKDwOeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AG7qOs2ifHbkYk/Bb12wB4vZ41TJuSnjXlyzMLn6?=
 =?us-ascii?q?CUU1xGY2rCg+JpKFknJ87?=
X-Talos-MUID: 9a23:rEvvoAmaj4m4SXUYz2rodnpBN8RZuvqzS3o/y5kYh465aCdvOQiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,200,1787011200"; 
   d="scan'208";a="537207748"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Nov 2026 17:59:15 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 6FB6C1800026E;
	Sat,  7 Nov 2026 17:59:14 +0000 (GMT)
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
Subject: Re: [PATCH net v5 1/2] enic: retain admin-channel DMA until queues stop
Date: Sat,  7 Nov 2026 09:59:00 -0800
Message-ID: <20261107175900.1141309-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179406378503.994134.16615988654708205370@kernel.org>
References: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-1-2501d1223eff@cisco.com> <179406378503.994134.16615988654708205370@kernel.org>
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
X-Outbound-Node: rcdn-l-core-10.cisco.com

Thanks for the review.

I agree that the reset-worker comments no longer describe every close
outcome. V6 will say that admin close releases the DMA resources only
when both queues report stopped; otherwise it quarantines the channel
and the reset is abandoned.

The failed internal enic_open() lifecycle issue is pre-existing and is
separate from admin DMA ownership. I will address it in a separate patch
with a consistent datapath lifecycle fix. That work will fault-inject
the enic_open() failure points and then exercise administrative close and
device removal, rather than adding a partial datapath-state fix to this
series.
