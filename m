Received: from outbound.st.icloud.com (p-east2-cluster6-host6-snip4-8.eps.apple.com [57.103.76.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E624C0419
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928580; cv=none; b=oWMWJgmdSBfwNCrAhnb1ZejrH2xf2A7Nl9MhiQDyN556IIdMNjDSNELzOWxFclusX8rXP4Xv4tNWp4rV9GwFpeL5I5qnPNT+1JHTfmmGXslISISDaxjzLJADuuVBfmgTrRXAoRQhyoulbUXAoYMLB1ThupSBFzEhjXR3EBhJszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928580; c=relaxed/simple;
	bh=oBluO8Go7Ada5MaFGlyMK2kizMewkK5Ba1uEF5uWyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APepN46ixaN6nXCn9e20w+5SNZzDm48jHSh8BmFNethB8T773hU7+2fVtxS3iSrw/se/3xqrjkT5B2ER0ER9QlifJ8Erp48Ts/KoHZP0QF4RxKDp2yMEsIwpxzVMblUyQVyUMIgEPzQ5ecWic6hivhBwzgRbnC13GWG1TTkYinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catnip.supply; spf=pass smtp.mailfrom=catnip.supply; dkim=pass (2048-bit key) header.d=catnip.supply header.i=@catnip.supply header.b=mAECChIo; arc=none smtp.client-ip=57.103.76.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catnip.supply
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catnip.supply
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catnip.supply header.i=@catnip.supply header.b="mAECChIo"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id A62011800228;
	Wed, 01 Jul 2026 17:56:14 +0000 (UTC)
X-ICL-RepId: 019f1ed3-085d-7f8e-acf0-fba0e7747b5c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMFWwVeCEgHQwVaAFBcHA4HVgVyE1gMXQRHRUEFSQhfFBcNVk1aGUcDXhscA0wIQwFOS0ATBEkHTV8OXh8EF0YZVQRHHl1WQBkZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwODlYfXBlJVkAYRxteCRkVWgkKVwBAC04DWgdaA0cMTQZaGV0KQApVAkBdClwwWhlHA14bHANMCEMBTlUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catnip.supply; s=sig1; t=1782928577; x=1785520577; bh=oBluO8Go7Ada5MaFGlyMK2kizMewkK5Ba1uEF5uWyBk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=mAECChIo4zyIE0v0DnJ7q6dawJowZ6VKp3cX9mZ5up6esnUtQ11tgmX/tOl35GY30R/M65UWxxA5MQNi3cjOs41Xm1ljndMum5md7JOVvPEt3yLA/bMzDijh1ivLXQI8cdJhqq6wnQSp4zDKk57pohnQy8Im0z8QvAtZdIaZS9+vIFvPWyL8apJtchfdUtTG8UTF8C0TYfVbv0nHJTvnD8qkWDbBE6Fk4LL5QsDK68VWk+JM8ZcGNQbarsjZoKEgSG9DNPkx7mSmLOXUGX/T8uBUth71s7W9dQvLvVeKbNT7cNWcR6vLIbecoaD3bz9l3VfwSNu8EJL8IKgCALD/cQ==
mail-alias-created-date: 1779453914251
Received: from jan-pc (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id E0D4D180158B;
	Wed, 01 Jul 2026 17:56:07 +0000 (UTC)
From: Jan Kot <jan@catnip.supply>
To: sashal@kernel.org
Cc: alex@exolabs.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-6.12] net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk
Date: Wed,  1 Jul 2026 19:55:57 +0200
Message-ID: <20260701175557.6803-1-jan@catnip.supply>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520111944.3424570-19-sashal@kernel.org>
References: <20260520111944.3424570-19-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _g_xjTsoEF11gaND9dDj2vQmtmwVDbbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX5w5hSfh3QXnj
 woZ2A7uWowp8a9yDJ7KPZLilXu8bMQi6hv/x9jXSE6vfzLEmv32FZzJanreP4HdByjNA8kuu6jT
 tLMQM/ocQuIsSsATUFt1B97Bge3mfKbWAwIz0UVRWCYLpYjUU5k2tAvaWY7Zt6O9fQvK8GpzM3R
 Y/aACP3Soy3LycOfmGIeDwycbom0+GVVZHHd3eEsZU0WyPuluacvDYoDEaN5AJM60khfgPgxob7
 oDp9kK08yhkt3ZQzFxV8C+8DJD1KcXUpj/5XG1TwnojCe53e+rIrUn/VL4DPNKpvzf8qC/tAt8E
 CgR3jNmNJQ0/T5jJZ2QIVthgYbd9+QF4zq/s85LvA==
X-Proofpoint-GUID: _g_xjTsoEF11gaND9dDj2vQmtmwVDbbu

Hi,
I noticed that there may be more PIDs for Apple Silicon Macs.
My M1 MacBook Air uses PID 0x1903, not 0x1905.
Looking at libimobiledevice/usbmuxd for reference, they actually define
a range of PIDs from 0x1901 to 0x1905 for these devices:
https://github.com/libimobiledevice/usbmuxd/blob/master/src/usb.h
I guess the whole range should be added to the id_table as well.

Best regards,
Jan Kot
