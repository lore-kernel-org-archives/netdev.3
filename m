Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754546;
	b=bk0Zw0E1gGhcGmBx+OK+x19/9WIhkdyYXT38o3waEsrK7UyFQND/NVcUEAuqNn/vfYvW
	 sY/gq46EVMTr2yXA24yKhRBzo+J9WWNwSrMMxuz9lXkzNDKl+zH+tEOSuoO5hd6grrl6Z
	 LUsRDV+UwB9Fr5OA7710GImMB8J/2sWSUuqRIe3Nb1dkXBRDvSUtZx4xhnAOil8VgWvb/
	 W7HLLwlvp/niRSfKhQInMidAx99+qR2opRSwbVEOO5WWc990FyUkog29ADLe+n1LkgItV
	 tL6YOq0rkw3eLDoIWWNbx0aNWzRhwPCiRFIkfWeJq6yLIpEX2iDr336qADEoP5WmRXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754546;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=p0TlihYYQqoSl/ttb9fRh6qgpKKXc6u8KsO4l12hhhQ=;
	b=OvXiW8fan8rs38OnIFNJklO1XNHYqOXDVnt69arbhneY8VFEgIN7uVUBT9dNQAuRVkfz
	 aQEwvQi1oK6jU/Y7ixwIL9uoMwsktjY0mMb3qq+ra7LJDILRAorHxCFieib6OZ2IMmBNv
	 6J5KQY8kaMtIu/JqrFvj7hCkmFb0Gr/t3hhz5bHXOzU/Y2CYtt5qIFu6gNfKEJ7T1U3jA
	 o1e/R6+WMrc9V+ns3GBD9YOLXOelO/NqYsDO1o1PfHA3wr0Mk9BbtmotEGvO3SfUZlh7+
	 pdnnIcsXHU/YwjR9TIBE2lmkPBvjBv+l9Cb3trnnoAvlE7hMLEvSsRqe8wgX9bOCOSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=gvQXlc0q;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C31606A31A;
	Fri, 23 Oct 2026 11:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C31606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=gvQXlc0q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792754546; x=1824290546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bf1jKkqSPO64+JjX7Tm+y62ZjvX2n1Tqkctim9DDrvs=;
  b=gvQXlc0qWVXH9Hkf4r/UF2Tai+1jnnkR0rCa+PfOmQ/I/pnTu2BVVct0
   IJzqFzgMf6NjpJJjvZrqKhk7krwa0EhKaXvZ0dG1xchO1NB7Nwj7DCCc5
   ue8nO8Xmm6F4c38dxgIeAePAzTesjPrJuL4nzi1SYwGTYIy0nOL2GPBpQ
   CJ1RVHccSZ2y4t0igOvjiAHyB4T4u1WFsOyx4vL+n6rR1PkxECnoJC6s5
   6TK5RWnZoeYpvFIjM6xDfDsl2TdNIKaQKfKWLEKoXWJYapfqteINKdZEG
   Po3GSR1ezJJFHvh7pYCQwhiO1Ym5Vn1FefKZRidRZcX7JUwV7UM7otyi1
   Q==;
X-CSE-ConnectionGUID: EPZTHebzRjWrJwg6QVAQtQ==
X-CSE-MsgGUID: Ll5NRThAStOJaameua4CTQ==
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="65461676"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2026 04:22:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 23 Oct 2026 04:22:24 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 23 Oct 2026 04:22:21 -0700
Date: Fri, 23 Oct 2026 13:22:21 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Alexander Duyck
	<alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
	<kernel-team@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dimitri Daskalakis <daskald@meta.com>
Subject: Re: [PATCH net] eth: fbnic: Correct packet header prefetch
Message-ID: <20261023112221.cqjcgqtano75hlkn@DEN-DL-M70577>
References: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>

> From: Dimitri Daskalakis <daskald@meta.com>
> 
> The existing call to net_prefetch() fetched a stale address. The data
> pointer is not initialized until after the call to xdp_prepare_buff().
> Thus, making the prefetch ineffective.
> 
> Open code the address calcuation to give the prefetch as much time
> as possible.
> 
> This was found by manual code inspection. No issues have been observed
> from this.
> 
> Fixes: 9064ab485f04 ("eth: fbnic: Prefetch packet headers on Rx")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
