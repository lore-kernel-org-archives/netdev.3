Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542667;
	b=5Bj9bbEV5nxUUowiaFsbPM+H2PtBbd3BOD8fgFuUYUv7kSfAydJf/eMLTTLvl9sKhnJi
	 ZCjQeCTZWnWTAgxkbV66iq+v3VGa09/PapiPFpoLj1E4ZKexHTga9JSuvF5iudKW763vc
	 JoA7RzhcQfh6mw3cHuQcvqEJ7a9hex5Gp2WGxNwoESBMFdmJnYgMmAiDiHUrNa7e3NC3Q
	 eEUxIiuT2OdiJz4KEHb4+drmQkWvv5cZslhrqRXIZXRD5hV7YU5AppZs+e2dQPhnO3GCr
	 +JnIRXAAMHdoKy7GO8rdsmrXJ2VTMP2st8iSQTdXEQEj+eObNgADWGwcnURsZQ9fP7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542667;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=57DmukFLZB01phZ4vQIdjoDtd8HsgiDCMp0GinM7/oY=;
	b=nlyHs79eFvqZnHAgOJzzaYEpCjGAMTKO11zXpcbBgnE2dBxHmngZPtygyV6WtJ5YG8x0
	 Z1tDUlBtjMQja1483XwCMHs8iSN4hjWJ8D2arh9RVfmT5/PHjwvbWy7bkOOflAH3Klz6H
	 abU0JvLTtfCCT1Gw7FPhmisOi1IIH+qtoWlx79ssLLrYBSang7Ekt38h8GbCL8TdcCvoF
	 zHU8AbBf8rH1gveSjoTrDGzLmmAFjQOWH+5fvOPOV4olJtXuu72ff33OasZmZaM7YnVIx
	 3BGQWxT5jXXYwLDpIyhtNEeYNEVm/hRYXnOCbpuhZN1yv/csLk7QdM6p7Sz07IFPt8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=fnxTw+S5;
	arc=none smtp.remote-ip=173.37.86.74
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C5606A31A;
	Wed, 21 Oct 2026 00:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=fnxTw+S5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=445; q=dns/txt;
  s=iport01; t=1792542666; x=1793752266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57DmukFLZB01phZ4vQIdjoDtd8HsgiDCMp0GinM7/oY=;
  b=fnxTw+S5Gf1efJ4hMr+HpxnHYpK1aUWWvswmfNpBf5YbvkbM+Px3YSeP
   OHdOF7ACxcjKyB+cQLgI3CgPk+s40c8xHJ6rjjzd0lNVFNVhucn0I54sz
   FP7K9YFZwMO+qarPWghW0roNh7BlnAgWNLu5XoA0KME7JODYbwpVNe63K
   TxAS88Vs3zQdBhMvQ4YXl3LL4cSPxtzaC78/Cysd4C89xfveOiErvAniV
   B/Sf9VpdMeqLx3KqqxkAxQsy2IVEzAd+pzt2+hkbJOpWVEcnmA+mdo2td
   d44TJidwSz1zpwnepPaJ69v/I/2mE0OHTsfFRf+o3CnwOKaIYAFID8MFk
   Q==;
X-CSE-ConnectionGUID: oPFaomWnTiae4PwXhAvqiA==
X-CSE-MsgGUID: GE3SAhGrShKIDTPEIJwQ/w==
X-IPAS-Result: =?us-ascii?q?A0BfAwCsBthq/4r/Ja1QCh4BAQsSDIIFC4QsQ4UgkXSeH?=
 =?us-ascii?q?4F+DwEBAQ9RBAEBhHsKAo4VAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZckBMCAQMjDwFGEAsaAiYCAlYGAYMUgnUDtTd6gTKBAd5Ig?=
 =?us-ascii?q?XQVgQouhXKCbQGFA3YbhGEnG4FJRIQIOD6EFgmDf4JqBIIigQyJD405SAp4H?=
 =?us-ascii?q?ANZLAFVEw0KCwcFgSUQMwMgCgsSEhgVAhQNEBIPBBYFLR1wDCcSDx0XER5YG?=
 =?us-ascii?q?wYFEiAqQUMyK4EZIxk2a4EJXYErKWABAh9GLRWCAgKCUYEjXQIBSUEOB0VTC?=
 =?us-ascii?q?SVDEkcmIggSCQETGi4LgRo4PAkoQRUMXAsJAxoFGykCIggCCwIJB4EBGhgNS?=
 =?us-ascii?q?BEsNwYPGQQ9AW4Hk3MBgkSBAXlkpSuLeJUXhCiBZp92GjODcQGmfZkII6NoT?=
 =?us-ascii?q?4RpgWg8gVkzGggbFYMjUhkPoWEBvX4nbwIHAgcOAwuReYFtAQE?=
IronPort-Data: A9a23:AfOY+6JOWiRAPqz2FE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS32BTm
 mYeWWHQM6uMamGjet4iO9mz9EkB7ZDWydU3HVAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8g2Qsajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1pNG8/Oogn/Np2CGwSz
 eMoKBkTdxGq0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBVLAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Sojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeO9boGJIYTULSlTtmm1/
 Vnv/0vjORE5FfCj8Rek0G2VwfCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa90GxSNT5GRqirxasvhkGXsF4EOAg7gyJjK3O7G6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3GtaYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz3k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:XwxcWKB9cGbeFVXlHemK55DYdb4zR+YMi2TDGXocdfUzSL3+qy
 nOpoV+6faaslgssR0b8+xofZPwIk80lqQFhLX5X43CYOCOggLBR72Kr7GSoQEIcBeQygcy78
 pdmtBFaOHYPBxdkdvw5hW+HpILxdmK973tuMLlpk0dKz2Dr8pbnn9E4sHxKDwOeDV7
X-Talos-CUID: 9a23:YkkPVWwbBqB2P4d4SjXOBgUTIu4sdXjiykvRKkLkMXlZSJSLUF65rfY=
X-Talos-MUID: 9a23:RLhPtwVKbN/igdvq/BDB3wpLNOhy2KSNKWwxqbgnmda9cjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,169,1787011200"; 
   d="scan'208";a="538634306"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Oct 2026 00:31:00 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 583FB180001E2;
	Wed, 21 Oct 2026 00:30:59 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Satish Kharat <satishkh@cisco.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Aravind Dhanasekaran <aradhana@cisco.com>,
	Reese Faucette <rfaucett@cisco.com>
Subject: Re: [PATCH net 0/3] enic: fence DMA ownership and identify V2 VFs
Date: Tue, 20 Oct 2026 17:30:58 -0700
Message-ID: <20261021003058.2214487-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
References: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
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
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-01.cisco.com

Thanks for the review.

I have been investigating these findings and am preparing v2.

The revision will focus on the admin-channel DMA lifetime and VF mailbox
source fixes. I will drop the generic datapath quarantine changes from
this series and address that work separately, including the page-pool
lifetime concerns.

I will explain the disposition of the findings with the revision.

Thanks,
Satish

pw-bot: changes-requested
