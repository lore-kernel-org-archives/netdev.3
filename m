Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73150C8EB;
	Wed, 22 Jul 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722703; cv=none; b=B8qW8xsS8Q1ptqzuh7cJRbgWJsHvYxG0RobqKByIPiWj24S+IlH/tSHj15VLKI9pyoayg+KRZysW/dQHI7HSNcmdAyS09G/0pzJAEV7u38I5xQ9hNS4OG7Vf5QvQQdIdSdwzVDn930jQSHnp4bxwiiBhUBl5s48edPwVKFKrGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722703; c=relaxed/simple;
	bh=l2BQQiUAZCFYQfFhXaTS0vJtj7V5SDFzmcxOKm9I/Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCGIGB7fDx3zZRyys8YEBGrbPncbwlIcdySh7iem3PNa6O/6jJI4fZRHk0H4xh0d9yj4i7vhgtczTI0sDoF79MNUC1MME2UhzQc9fotUauDbNtSzjdZmOsj3+WAS/kVPiSjVXCQJ/+Ps6tx02meYxNIdYs8AjgVGkNCssE3CKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [113.80.141.55])
	by smtp.qiye.163.com (Hmail) with ESMTP id 472a0a9ad;
	Wed, 22 Jul 2026 20:18:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: javen_xu@realsil.com.cn
Cc: andrew@lunn.ch,
	daniel@makrotopia.org,
	davem@davemloft.net,
	edumazet@google.com,
	freddy_gu@realsil.com.cn,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	nb@tipi-net.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH net-next v10 5/5] net: phy: realtek: add support for RTL8261D
Date: Wed, 22 Jul 2026 20:18:01 +0800
Message-Id: <20260722121801.655011-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721022410.1391-6-javen_xu@realsil.com.cn>
References: <20260721022410.1391-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f89c3012d03a2kunm0b4cf6501680b8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE1NVklJQxgfHxhJSRofHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVQ0tVSk9KVU5OWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
	xOVUpLS1VKQktLWQY+

Hi,

>  		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
> -		.name			= "Realtek RTL8261C 10Gbps PHY",
> +		.name			= "Realtek RTL8261 10Gbps PHY"

Given that the RTL8261 has multiple suffixes (B/C/D/N),
this name change could be confusing.
