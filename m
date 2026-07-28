Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C103769F3;
	Tue, 28 Jul 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221421; cv=none; b=BFCcJe64CP84J+dQZJ/BAtjlvDG/7ZeW+7U7evbW2CoAeQa9BFVXrigDCLxkgU+DR1ZzHv2TuPVL3LdqnUzQJFKBdg8y06jpzS/AWhTVkL1ART9FPL1zxXsMmCDiZXmKHEC0ncUCiOR2+N63K4p7UZjoxW4uWHMoEsvnJVoroTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221421; c=relaxed/simple;
	bh=E3U6heDmd0asduBrsFL8/Az+Rgql10lpHxdlstdStVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0oNWrS3WPCo46lbu032GtN+kPG4wFdRvvrFkeulPLGcublU2x9yZ3vHWjipX3pd4WPcECVQL138O12aFHVbgUDKWWgChoZgnGeH/K7LXJr3OrjuQqbefw90TZLRRNBG1o5fpBydKgdcb38MdPQRRoVvaUIhDHr9vgPHES5hUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [14.220.232.116])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d4ad4a2;
	Tue, 28 Jul 2026 14:50:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: javen_xu@realsil.com.cn
Cc: amadeus@jmu.edu.cn,
	andrew@lunn.ch,
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
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v10 5/5] net: phy: realtek: add support for RTL8261D
Date: Tue, 28 Jul 2026 14:50:01 +0800
Message-Id: <20260728065001.1487282-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bb782164800a421397c2085f7e58aff4@realsil.com.cn>
References: <bb782164800a421397c2085f7e58aff4@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa77cdfb603a2kunm484bb00d122f7f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxpJVhhNQ0sdHU8eSE9IT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVUpKTVlXWRYaDxIVHRRZQVlPS0hVQkJJTk
	tVSktLVUpCS0JZBg++

Hi,

> The reason for this change is that RTL8261 10Gbps PHY share the same
> phy id. The specific hardware versions are distinguished by a sub-phy
> id instead. And in probe function, we will print out the exact hardware
> version explicitly.

This is only printed during probe. If I'm not mistaken, the PHY IDs
of RTL8261N and RTL8261C are not the same. Perhaps you could name it
something like RTL8261C/D here?
