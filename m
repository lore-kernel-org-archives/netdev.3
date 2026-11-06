Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953091;
	b=zVX9bi7uRGsBvsSoxIDyzvnZQpiAo2Dh/GZaOq0Jth7dUvRq4O88lVvEVsc37GpO4A/z
	 hoDXMBUfTw2EjArmE08FYnTm7ogxJU/mnpnyShV2SRKw1P8gswGUZ8eTL12y3ieQ2g04j
	 blsQyAcYgnJ6Lp+6b4XEQKW08jcE7VLMMnWYf5ZU64igRySs35P064hLA1qeRPaYgKCax
	 z+m2EyReDfQvCiNyGQ9JbRiClcpBD7ZOslzecKp/tMz7J1IaxnrWUD3vlJCg0Iky6XlkG
	 7XCb8mOeATfgJjI0yO6I0mB39j6lP2Asp9M2A37fqyArnKh6SaX19FhR+fCbxRss+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953091;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TPi9UkzLdeAaj7i38ZwOkvno9D+wjrj07KWA6OFjRTs=;
	b=bCG4qkOEmcCw6qntrFlelBiW+ifLGxSA7RTH+oGpejvZK0FIa2qEiEM9Nq8+jt7+M9V2
	 kZwjXW+K223NK0ZXEp0Iz1vkAmwi703EWUkO1xpdmrspjZsKjHlevlb7d9ijCHayhBucz
	 7FlwvMMwahVkcWEokx97nWKHWth5Q9ByEqvmOzHwrOfsGq/btrig2iEPr3q/tejTqHEub
	 EKfdNhy6i5N+j3ViorAEv9+vmAtBahrrthjIQmB9cTlcCFlU8pblaFIgCYlbSpUZ2IRjL
	 lYKRmtKAP2/TdR+wowceBmYITnhHsmQCxRUhDeIJyuPwNUjwi6KbpucLgzuQu1Qp58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="EAq0/Bhv";
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F9606A329;
	Fri,  6 Nov 2026 08:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9F9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EAq0/Bhv
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TPi9UkzLdeAaj7i38ZwOkvno9D+wjrj07KWA6OFjRTs=;
	b=EAq0/Bhvjv+7wnPH+/hduAxsKRHp1EEPZlirWoXRWc/AXUFMVr4PwsyVwWTIGVlQ1/luVg5u1
	4BL2kXw9cO6xHntp9ZyaWd6gRWwx4Qyf8gxFEOixxYceg230gYRfBbezSpgsKB+lxlyUEOcIFts
	Hlj/HM2BNxay70mDREpTUTQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jLX9g6Pt9z1prQ4;
	Fri,  6 Nov 2026 16:17:59 +0800 (CST)
Received: from dggpemr100009.china.huawei.com (unknown [7.185.36.78])
	by mail.maildlp.com (Postfix) with ESMTPS id A6CC140538;
	Fri,  6 Nov 2026 16:18:05 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr100009.china.huawei.com (7.185.36.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 16:18:05 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 16:18:03 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <netdev-bot+sinfo@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <horms@kernel.org>, <hramamurthy@google.com>,
	<ioana.ciornei@nxp.com>, <kuba@kernel.org>, <larysa.zaremba@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maxime.chevallier@bootlin.com>, <mohsin.bashr@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <tengpeisen@huawei.com>,
	<vadim.fedorenko@linux.dev>, <wudi234@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 0/4] net: hinic3: Bugfix for later patch-set.
Date: Fri, 6 Nov 2026 16:17:59 +0800
Message-ID: <20261106081759.25431-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <179394588711.488859.3460474784447366028@kernel.org>
References: <179394588711.488859.3460474784447366028@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

> Please do not repost the series just to address the above. Instead,=0D
> reply to this email with the missing information, so that reviewers=0D
> can take it into account. If the series needs another revision for=0D
> other reasons, please include the information in the commit messages=0D
> then.=0D
>=0D
> The evaluation is done by an LLM so it may be wrong, if you think=0D
> that is the case please reply and explain.=0D
=0D
These patch-set have been tested on hinic3 hardware.=0D
