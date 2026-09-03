Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92035332EC1;
	Thu,  3 Sep 2026 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404713; cv=none; b=SaHMJqooATUyDPU4onoEp798VGLwpOeV0YtV5HSahd+GvpOsLJ5yLOW+d25Ch0PpbfUNEIs3ES1naPvp53q7Uul0YUasf1Flz3B06h6y5ogOCeo/ZUxDjbTevKQrSXnBOrv6TZKQOnNGQj6iiciYzifdoGBbYG95erxeuo+hnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404713; c=relaxed/simple;
	bh=qwi3KRn2YLBoRnHjJoyZ/YyRxsS15pVd2sf3d5F1XDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dd8oJUouq0Mq6pfNJREICClCHdgmZR+58HjkZyTcxhTdGl17EqXgw8c/IC+2FVupZOmMtevh2sq6DwplVQZ+0WX91sq4CNeK0ThvDgsfmunQYOocLLrU/0vkLXZtVd43AXdigrW8fQfgs++lXSJs0zb2XiVRqK4UxeKemoTnDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BoMG9orS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BoMG9orS"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68334jQ923157558, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788404687; bh=JA35EmqNuXqL/oeols3JuxKShNyt/O+o21+7k6i5FzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BoMG9orS4dbvu8VwuLzZcTNrMfP9mo3M2F9LUXYqAEGbAFqP05Md/St1t4meVK21H
	 87XfFYEiKxGlPdsJIofgfRU7AM5n6qtNRQuMzoEkX5O9+TpakpzIWoLWISgEQV+dCu
	 txV2TrSK3Y2+ybTnkVg4HBLtYGljPZOP+jOzKvrOEjf/zOsACTT2Hiemk4WBp0mlgl
	 cT+OYEZUUrl8RgO6g0l28ol29q3XVr0xC7S7oZBamMw/E6yrvnv+57wBwompq1Sh5D
	 86pO2OLQv0fSLw4tXhWH6oZmP0YGhOuWlulSQxxyWd5IgXqqy9E3E/iix9Wl1VdxqA
	 xTrkb+GmrvRWQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68334jQ923157558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 11:04:46 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:04:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:04:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Thu, 3 Sep 2026 11:04:44 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next 3/8] r8152: refactor rtl8156_enable, rtl8156_up,
 and rtl8156_down
Thread-Topic: [PATCH net-next 3/8] r8152: refactor rtl8156_enable, rtl8156_up,
 and rtl8156_down
Thread-Index: AQHdOrpgjmLz5RXMuUCNL/dgbNC0zLa6uUiAgAFymwA=
Date: Thu, 3 Sep 2026 03:04:43 +0000
Message-ID: <c2659bb8fc1742b69ded4bd759563b17@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-4-nic_swsd@realtek.com>
 <a9fd2210-0986-4305-b9f5-3c534e4c39da@lunn.ch>
In-Reply-To: <a9fd2210-0986-4305-b9f5-3c534e4c39da@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 2, 2026 8:56 PM +0800, Andrew wrote:
>=20
> On Wed, Sep 02, 2026 at 05:06:27PM +0800, Chih Kai Hsu wrote:
> > Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
> > ---
>=20
> The commit message has to say something. Why are you making this change?
>=20
>         Andrew

I will write the commit message in the next version.

Thank you,
Chih-Kai
