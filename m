Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D0243956;
	Fri,  2 Oct 2026 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790917409; cv=pass; b=NQwkOULiDqDk7Y66UwwN5U4hHXtRE1shn2uiZ1YjbZuqvU5Y2RMRPlNSTvWeveHJ0kHKMskxFV735sNzj33K+DnG0fOJ+DMc0dW6UXYZ9TiRxVye1PghHOhC0W6uBlR6QeVf+zIlukLahiWLl1JcGE0BZp+QZUrtYECDEkSu7yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790917409; c=relaxed/simple;
	bh=BLMNrDgxACzGi99l170eKJbmjXh9J3cRiHm4aJWe0HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKyobOkK/6AoRxlKgsLT1XuLmFz6HRBrjqnuMyz1gCSjsxzspDgtiSiUkxmMXw9B3R3S5WPqUEi0OZFZKnVfskXOlCOtDw+SkaQAEJTdKsql+IJ2sLJOPA+bo5kP7DMqubgyMJmXoKiFfH+jym8GYXeax5U4MmRU8AdVMTaHNEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=WCvTyV3e; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="WCvTyV3e"
ARC-Seal: i=1; a=rsa-sha256; t=1790917388; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Aoc0mfBRfnPpzyEWolhA1gknLafd51H0Qg0/uH6xi7jsyKdo+a60mudz7c2/N0ohkpGGiGyQXiK5YjakFKP4NAWJBYf8Ob2Mleo9Do7WqGckNBXu6OhSa7xCPchw6Q6KsZbotpUgvos+n59CXeeq1cRC+rLpXphGrEqke1eWEFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1790917388; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BLMNrDgxACzGi99l170eKJbmjXh9J3cRiHm4aJWe0HM=; 
	b=fMNmI2Y74oxfoys0be5wp8FVA43Cw/KcNC1S36ufxY7dUZKKgk1FbIMUcntSLOQNP68zOYeQKpPABYbCVFdu0ZHLtSjLNnwiWp/SVH1aygprgrOPQJ80I6j5jiIn72xumkd26wp6hisNGLYRl38KSmkRpYWVuZAReG5xZR+LL/g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790917388;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BLMNrDgxACzGi99l170eKJbmjXh9J3cRiHm4aJWe0HM=;
	b=WCvTyV3efuAN7hyElToowKuAF+JRAv0rNjM6XlJXaEqC7jLr4ODEaxur2hgGzkfp
	YXrMdup89y9D9/ur5V9Pf2XmFs4u2lUU2X5HURSOr6yMOk5SvINnuAXdxuDZ2Pvhg9m
	6ocRp2oJ5qKZLCNwkdqHj0/4EgpnMVwB+LILknNs=
Received: by smtp.zoho.eu with SMTPS id 1790917386036309.6963347801815;
	Fri, 2 Oct 2026 07:03:06 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Igor Velkov <iav@iav.lv>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Fri,  2 Oct 2026 08:03:04 +0300
Message-ID: <20261002050304.1331175-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002043548.1302145-1-iav@iav.lv>
References: <20261002043548.1302145-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Cc Rafael, who acked the commit this fixes.

--
Igor Velkov
