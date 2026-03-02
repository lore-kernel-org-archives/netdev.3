Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F524201004;
	Mon,  2 Mar 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433185; cv=none; b=XMm1izO85bl7FiaX5lr2Mn+ebndhE4cxHIzV5T3rIalJYyxvEpXRclbXNl991TfVNmrqaEWz+BMQoN2CuW7wUVk7VBkqnJBYD1ZLMaJDtJS47UINK6rfd217OZSq7xSJIPhdNhTcuKTKVvhK2LujJtGW98DnRVAvCucxxSEvq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433185; c=relaxed/simple;
	bh=c9SSdhO3Wl8s/ddS3L2HnPLBUajvgHxFrbOlc/09IgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jYH8QDB5kGnRsHheza18klTnQ0Fimn76ycNm9azGPfk4QHTK5ACt5dlIHkpumfkHO35kFEaJf0trfQylpcGoO6D7SoI10tJN1YbF8fJuAO3S9Fn6EW2Eb2gPa5ccZ6LXQjcX8ZczkXjX+IU1+ZfCS0YiRiwc9OZuRZyieugY7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dehp0gDF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="dehp0gDF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6226WRvK42520766, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772433148;
	bh=4lKf5zgaM0gMJIfRsAC+1XlnpyH+VpMadasx17jvFX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dehp0gDFoeTf/6FXVI38TUPozMzvIhjzRxJDghw3UUhCyAyacjMKckf6GOEAOOoMW
	 vm2h0bg3eJtLMYdAnyJNjRD3AeIEC6q+ydPYY4cUGgt6bOo2pmN/w4IqLTdHK+J/Gv
	 uoapdmyTCaEmU9uey8qyuI36MeJvoliyJUThr45EY2JYkmWroz4Fu93quSgC//D8wO
	 RYWz8ObhWVN/lITUvub0S+1E1ZcGUgzNtDCSlyB9bOU2tbprXPJr3+fcMSgInEkq2D
	 sIBCILahGzfF7zZLEJvzzQwuhy6c03PHEVu8ZlbgGzfQR9UpoV/JqxvuvrOEmuXjik
	 9YCXmgKsCBlfg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6226WRvK42520766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 14:32:28 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Mar 2026 14:32:28 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 2 Mar 2026 14:32:28 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/4] r8169: add ltr and c10 support for RTL8116af
Date: Mon, 2 Mar 2026 14:32:10 +0800
Message-ID: <20260302063215.1790-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch add ltr support for RTL8116af, enable RTL8116af enter
l1.2 state. Next add sfp mode for RTL8116af, which helps build link for
RTL8116af. The last patch move other function to d3 state to enable the
whole system can enter c10 state.

Javen Xu (4):
  r8169: add ltr support for RTL8116af
  r8169: add sfp mode for RTL8116af
  r8169: move DECLARE_RTL_COND()
  r8169: enable system enter c10 with RTL8116af

 drivers/net/ethernet/realtek/r8169_main.c | 207 ++++++++++++++++++++--
 1 file changed, 188 insertions(+), 19 deletions(-)

-- 
2.43.0

