Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.38.203.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802551;
	b=yZkxX4Xt7auIRJk0XA/4GyoFcL0KkQNSm4ujXFNLevEpN/MuoyDXKHM2DODdDhbSf0CY
	 krmMA3FLnSlWI8tnaNEPEXgcbbWjK8kCOKfGWgaD+mfnylakUM51hnNklmQF1kZvjh6SR
	 OjRDow8FvX0MoDuoGWvju+Iq4l1Oztpg/BntYK8jzlO0UBpHx7rZgtUWuRYLt9i2s78MA
	 UjCFbIIq7dtQhNqOtojeJTby3Za21y1FboWEsiCPZkc4U4LaLzCWvNkC1H4FJBQsqTVG3
	 idM3QXQdS3d++EQK13x/biHYPNddBFg1jY6md6jIAbOfi9K7t/0twkYHrry27WrWRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802551;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=0r1uTmPU3LqRDCM3e20DUd1ZXUi9qmzpYUpmFSn4U9E=;
	b=1yzir1SLqhZhR7eiseTN50owckMrGXR63PohSUkPZc3/WUVZUZm4fVFDyNsEmCZwn4tR
	 1d4pnsxh5RQVO7CpLt0niJoPRnHnsAtQGtqq6TtxFFuttPsRUyq3rd78ZMaCMWsUEQA4B
	 keOzIrtpvo5l8KEK5vZxHoglsR7Nz9++jbOYF/RXrTBoEdOvIUjARM2TV0BCT/ymVnb9k
	 nNYEPxXrJUugrOAgKAvY5q4OVv6HjamgEvaQ3DKxzukImrlHAmmQGwNE9F6+uS0BPmI6k
	 5YKKCBJB3rKmLCM0rWcWJczZ0HzVKaJiamJJby3yqRYuc/p9lpCXtsdhkodPkiGoASg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=PD5TvT8I;
	arc=none smtp.remote-ip=173.38.203.69
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC1606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDC1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=PD5TvT8I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=575; q=dns/txt;
  s=iport01; t=1793802550; x=1795012150;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:content-transfer-encoding:mime-version;
  bh=0r1uTmPU3LqRDCM3e20DUd1ZXUi9qmzpYUpmFSn4U9E=;
  b=PD5TvT8IIfldWAFWVDYTkjF9cbT/6qz6hJ+LVk+Nqu6UMz3skSDD9V9i
   qiEST1GJ/QYzcU2hncgvTszpsIggDFIcdrGMt06KdiC/hu3ryhDonbX+A
   z6DHLZ6u7J54naYPuiTZl/eETBYXllrjvpvc3vPEVFjF7JXXOOzK4YrUQ
   ZsE6niLOL4I2xY2jhkm7vGgudA2B3hmvEvOgPpX/g1pxSDkZwUdpcdobZ
   Qmk1p07AunutIkOdOh/v64sVEzmNjYo0oZUN3HJ1lrnAcxFbQSzwGzBak
   3ApKMv8uPgTVeoOEILeoxNaJ6me2PDwpHH5byMMF0CORITyTbWZ549c/E
   w==;
X-CSE-ConnectionGUID: TZvVYeUEQ62YkX8Z8EV2Xw==
X-CSE-MsgGUID: lqo4WUKYTKGncgk5whqD3A==
X-IPAS-Result: =?us-ascii?q?A0DGBACYQOtq/85K/pBaglmDTGBDSYgmjiWgIg8BAQEPL?=
 =?us-ascii?q?g8UBAEBgVEBgzMCjhwCJjcGDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8NkBMCAQMBOT8QCzYQJy8GE4MDgnQDEbtBeIE0gQGEftlLgW4GF?=
 =?us-ascii?q?YE4iF8BhXkbhGInG4FJRIFHgkgxPoJhAQSIIwSCIoEMgl2UXFJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBJUMDgQYjDzwFLR2BIyEdFxEeWBsGBRIgKkFDW4ESgQddgSsoXQECH?=
 =?us-ascii?q?0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxbC?=
 =?us-ascii?q?wgDGgUaJgIfCAILAgx0KBEQEx0eJC8FHCZAGwoUbT03FRkEk2CDay8ZGIEaa?=
 =?us-ascii?q?BelHqF8hCqMJI0+iBYzg3ETjRSGSZMQmA0VZo4KmzqBfiaBWTMaCBsVeAUGV?=
 =?us-ascii?q?oFJUxkPlnzJY0YyPwcCBw8Ck3EBAQ?=
IronPort-Data: A9a23:bOQakqMpfKSWQe3vrR3UlsFynXyQoLVcMsEvi/4bfWQNrUpw1mFTm
 DEYCzrSPKmLZmGnfNF0aYWw8RkDvMWHzd8xHXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgb8g2Isawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68lcEn8HMLA1w7gtMGJ+p
 c5IBQ5XXg/W0opawJrjIgVtrs0uNozveYgYoHwllWyfBvc9SpeFSKLPjTNa9G5s2oYUQKqYO
 JZfM2IxBPjDS0Un1lM/Co45mOOlmlH0ciZTrxSeoq9fD237klYtgOe0aoe9ltqiQdxSwnmlh
 VP63Ev/CR4ZacOf0Bbe2yf57gPItWahMG4IL5W9//VrjV/VyG0RARkVUkSgoviRi0iiVtYZI
 EsRkgIrpLI59UrtTd/0RzWmrXWFuxdaUN1Ve8U85R2Bx7T8/QmUHC4HQyRHZdhgs9U5LQHGz
 XeAksmsAXlkt6eYDCrAsLyVtji1fyMSKAfueBM5cOfM2PG7yKlbs/4FZo8L/HKd5jEtJQzN/
 g==
IronPort-HdrOrdr: A9a23:qtjwVaEqRjWolYXbpLqEyMeALOsnbusQ8zAXPo5KJSC9Ffbo8v
 xG/c5rtyMc5wxwZJhNo7q90ey7L080lqQFhbX5X43SPzUO0VHAROpfBMnZogEIcBeQygcy78
 pdWpk7LsHsBl5nisu/ygy5H9E8hOSjysmT9IDjJ7MHd3ASV0mmhD0JbDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3AFxhGNGlhdjsc6JZxhW9Y1qwgae/XOUHv0knhLnK?=
 =?us-ascii?q?VMDgzeb6lGW3A1Z0+o9U7zg=3D=3D?=
X-Talos-MUID: 9a23:jbzmJQgYlo7kHDwGBEew0MMpMN5vv5uTK3ExsroAsMaHaDNwIhvGpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,195,1787011200"; 
   d="scan'208";a="62487125"
Received: from aer-l-core-05.cisco.com ([144.254.74.206])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Nov 2026 14:29:01 +0000
Received: from localhost (unknown [10.189.105.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-05.cisco.com (Postfix) with ESMTPS id DBD9F18000396;
	Wed,  4 Nov 2026 14:29:00 +0000 (GMT)
From: Jerome Tollet <jtollet@cisco.com>
To: Marcin Knap <marcin.knap@vecima.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject:
 Re: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is full
In-Reply-To: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
References: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
Date: Wed, 04 Nov 2026 15:27:17 +0100
Message-ID: <179380243798.98051.18195517640983587855@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.189.105.1];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.189.105.1, [10.189.105.1]
X-Outbound-Node: aer-l-core-05.cisco.com

Hi Marcin,

Since v3 has no code changes from v2, please feel free to add:

Tested-by: Jerome Tollet <jtollet@cisco.com>

My ConnectX-5 test results are in my earlier reply:
https://lists.openwall.net/netdev/2026/10/30/342

With both earlier mlx5e refill fixes present, the unpatched kernel still
showed RX frame ownership errors with striding RQ, with need_wakeup both
enabled and disabled. The same tests passed with your v2 patch applied.

I have retained the standalone libxsk reproducer used for these tests
and can share it if useful.

Thanks,
Jerome
