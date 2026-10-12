Received: from a3i436.smtp2go.com (a3i436.smtp2go.com [203.31.37.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7948C3F2
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.31.37.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816821; cv=none; b=HZCMlU8U11vnHshB166pk6OlAJAexJEDbaym0VNFZBsUK4KtLWdomicjRkUQ72UjTDqvsy3bdE+eY8Vy++KU6y3RUCMfRTOE0Y+3kRF+peCBRUS5MP6ZwFGv0eR7iseQ9J41RKZ85TygQInEkLefnXKJ8eFc9DstaGnZ3Q0rZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816821; c=relaxed/simple;
	bh=FKU4UThzTxxjR26EL+IhLJ5in54K0kxZMsLQN7UToYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RbROczNiRUmc5vu8X7RjQxCOEEYA2WyCOVUsnoWtVX2+ZsC+ut9qr6idWKkDqj9stk9U5JIDKPv48eju71gwLnGXFX1rMWxTleVUL5TgvyYc3GqdiV7JkgiGGtq8fgOpxfH1V3F19tG/LvcULrlKcrpYXHGBpo8/ZUg2Vxvkp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dilluti0n.com; spf=pass smtp.mailfrom=em840244.dilluti0n.com; dkim=pass (2048-bit key) header.d=dilluti0n.com header.i=@dilluti0n.com header.b=Ava3RLlH; arc=none smtp.client-ip=203.31.37.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dilluti0n.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em840244.dilluti0n.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilluti0n.com header.i=@dilluti0n.com header.b="Ava3RLlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dilluti0n.com;
 i=@dilluti0n.com; q=dns/txt; s=s840244; t=1791816818; h=from : subject
 : to : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=FKU4UThzTxxjR26EL+IhLJ5in54K0kxZMsLQN7UToYc=;
 b=Ava3RLlHoMaZuHpxhNGZ59p7MI1WdNXlS5mb0+Ck9Fn2Up8g/iGiU+38ZK7HM9B0LE1al
 EVqC30XDQGEqn7VLEiFixm+TY3FL9QRjbXxYkfRbTpdbpnO0FHRX6MOKl/O4zPpuZr7qxb4
 T6fXczfp7UO+DMRaRVJotibST49OqqQJQhTHTOq5nC/og7CCFrGhKAjFuyCKF8mLWZUWa3R
 kQldd2p/axOMXhK0ik8jvIM7Vd/MBJbjssF+mcBHd38raz5WeEknfheN89+WSxsi780lHwn
 KZzwhNcDNoK1D6uaZElbFJOSUKhQE1kWWbu73ImBI7CJ5LEeoSlGIghDQDyA==
Received: from [10.40.244.132] (helo=dilluti0n.com)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
	(Exim 4.100.1)
	(envelope-from <hskim@dilluti0n.com>)
	id 1xGHP4-AIkwcC8oQGV-X8Dv;
	Mon, 12 Oct 2026 14:53:27 +0000
Received: from localhost (<unknown> [10.42.0.2])
	by dilluti0n.com (OpenSMTPD) with ESMTP id 5f66ac95;
	Mon, 12 Oct 2026 14:53:12 +0000 (UTC)
From: Hee-Suk Kim <hskim@dilluti0n.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, javen
 <javen_xu@realsil.com.cn>, nic_swsd@realtek.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: allow Giga Lite fallback on RTL8168EP
In-Reply-To: <aszgerrI8yoLTaX0@makrotopia.org>
References: <20261010135356.85454-1-hskim@dilluti0n.com>
 <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
 <4435b286-1638-464a-821c-f486b647c9f7@lunn.ch>
 <aszgerrI8yoLTaX0@makrotopia.org>
Date: Mon, 12 Oct 2026 23:53:12 +0900
Message-ID: <874ierc6nb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 840244m:840244atORciv:840244sMJrnW1qeB
X-smtpcorp-track: rGH7Iypcbke7.bDCZPJYJ2HIE.UXWNwgxqjnl

Daniel Golle <daniel@makrotopia.org> writes:

> On Mon, Oct 12, 2026 at 02:46:27PM +0200, Andrew Lunn wrote:
>> Please add ETHTOOL_LINK_MODE_500baseT2_Full. Make the PHY report this
>> link mode in it features, add the speed, allow it to be negotiated,
>> reported in ethtool etc.

Will do in v2.

> While at it also consider ETHTOOL_LINK_MODE_1000baseT2_Full which is
> supported as "2.5G Lite" by the RTL8221/RTL8226 2.5G PHY family.

Happy to add it as well, but I'd need to know what PHYSR reports for a
2.5G Lite link on those PHYs, as I can't test it myself. Do you happen
to know?

Thanks,
hsk

