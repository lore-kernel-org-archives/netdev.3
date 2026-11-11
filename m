Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393178;
	b=mv/oWwCMPIebF9Gz34i+ENfjYLj9C74Y19xiUWdXxKjA2U4OkPNVpGOgzN8CFG96MvQ+
	 IxXpG+36NoOB5G/NflPQo6bHkYnynBU6Ii/kjpfwnF7mlIXma4z1g+r5VdnG5eeSL2tdH
	 TOM99lngQE+F3UVFvtLOdG0DuRjHjsaqzST3LFA48oRcop63wSeQByjFxaMfvc4bkR7Xn
	 Sb4dNlyu1JQo8yNQymFFAuBxg9WHimzvr5yvFMbP3T6uWLfWMfenBys63gzQdD6MWfwov
	 w0QDdV9VIDSfN+AHM3XIPD+yStk6TllM/dgbnyEi6yJ83g6WFuAjEvdluw4qE6SGW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393178;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5LxVGBk0nGoYs31KnbsVJCWarpNoNytCYPFUuR+hl2o=;
	b=rvqJ8fO56QKQd5UVF3/hOPbd8xYKSkEzzQLrdHMAiWp5sx9rZoBsmh7i0g4+o5tv+tX3
	 MdAlynVe8HG3lYUPycc3anPy82vnugxLt3z3wNuBM+PU40hO6fHrr5IWjFa/7+2s7Y4Vd
	 I5Ic6/mhpsCcA9sKOO8gwY9shzKyoQOz4kFnovC4rMIz4GyCXol5e8QUJ50iz+dkq/7CK
	 gPs7ZWTIM1HK8L3thKIsXPEPCOVlqlMN5ewK99OZrQE8iicqlMsvuwoQuLtBSV0gYyjN8
	 FizVEkDOhVPT7nOdSne6oibaXdZu64bSj1Kg5rIo7IUpkeMTE8qvjLafbVGKrowpJ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gfI0vyH7;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF61606A31C;
	Wed, 11 Nov 2026 10:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF61606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=gfI0vyH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gfI0vyH7pOB8czxqaryCpXcOBP99ohzOKmBD2emZCTRp6Yhy7gZdlmlI5eqc64hgvQ1y55j0ceWfn
	 HrF4uwLu9EU1fRdVUqJXMdoTgyl8icTLhY64s3LhZsOB/TPRdQy6iwk9O2oDUEJKdvulUsUXFXAxjJ
	 u72q/41jhoX80ISg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af4445671f-d90bc;
	Wed, 11 Nov 2026 18:32:54 +0800 (CST)
X-RM-TRANSID:2ee76af4445671f-d90bc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af44454467-d960e;
	Wed, 11 Nov 2026 18:32:54 +0800 (CST)
X-RM-TRANSID:2ee16af44454467-d960e
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	jan.kiszka@siemens.com,
	diogo.ivo@siemens.com,
	haokexin@gmail.com,
	horms@kernel.org,
	vigneshr@ti.com,
	m-malladi@ti.com,
	jacob.e.keller@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in prueth_probe()
Date: Wed, 11 Nov 2026 18:32:51 +0800
Message-ID: <20261110161000.3143-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
References: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The netdev patchwork cc_maintainers check reports that some people
listed by get_maintainer.pl for the files touched by this series
were not on Cc:

- Vignesh Raghavendra <vigneshr@ti.com> (original contributor of
  the ICSSG driver code this series fixes)
- Meghana Malladi <m-malladi@ti.com>
- Jacob Keller <jacob.e.keller@intel.com>

Adding them here for visibility. They will be included directly in
the Cc list of any future revision of the series. No action is
required from them.

Best regards,
Xiangwu Lai


