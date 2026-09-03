Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCB1DDC33;
	Thu,  3 Sep 2026 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404569; cv=none; b=IYZ/zZnMox93bm/g45wLuqgiIN1sk4sOfcfY6zatt46K6SfCciuzTt9WQI1IE03/wjQ+cHaPAXo56aVbTs4JnVi89xW9zRwAmTYeqSHDKIg5QtomjtUpyhQ1zDYMEhBva+nK6M2RKeLQ5szxhUtOirc2JSYYEe97hhM6Lf6I+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404569; c=relaxed/simple;
	bh=e8pcwYPmhYJSARoMTl3ToBSeVLD9KxiOmZ6Ov1D71II=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLikQZsFehDW+n+t9bNNMXYqyInh2JrtNBLyWWASk8cPncqydh9TSnMswXUL1fvT0FB92wN1NrvagVWSNRn//kyrDzPnzKdwd28A/gtZ8x8a8bR3R/7FZc3wAqx04iYYzmYhyxxb/Mu7pTO+v+8Z2gLIlQIkG6lqAwpR4Fu3DyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ibs6A0HE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ibs6A0HE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68332KlyC3156757, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788404540; bh=fgtKjoPi6U7bT/rFmBhlhYYPrzREZH7M4efGzNo80HE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ibs6A0HEFIesGQMiPfbZ9Y56m8IXQYmqorXFohIq501BtufXxf01EvB5gy5yS5bRU
	 HFIiykwFRD2Q6T0PWwkdW/FgnrzZX727kXlbWX1VGGoNHArvf64eY9ikWvG2W5PK1A
	 2IsV9vwBYyVI4zOpHy5Iwv2Lwunh5wp3LOgNxb6GerWKptFzz/rn20KWKL398vqIAe
	 AL8qIW7PSy/k+1FW2IMDdZGx7cJBKR0qYz49h/wfttOZaX+yG0okTKeB77u7AFUT9h
	 t4xKYTCCMq7D/2Opnl3Jb0GB5GYdcKpWFx+Ly0R0HJzz+xIRnjqgf5XoAZpaKp0zY4
	 MLYeOnozvnjlA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68332KlyC3156757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 11:02:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:02:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:02:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Thu, 3 Sep 2026 11:02:19 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next 2/8] r8152: support RTL8159 for different
 packages
Thread-Topic: [PATCH net-next 2/8] r8152: support RTL8159 for different
 packages
Thread-Index: AQHdOrpfzoLR/svszkuPY2lF0UmrGba6uQ0AgAFxhXA=
Date: Thu, 3 Sep 2026 03:02:19 +0000
Message-ID: <5952224f4bd3406b9f396b39c496d83b@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-3-nic_swsd@realtek.com>
 <0ce46ce7-2edf-4464-8029-cdc6e9b9f854@lunn.ch>
In-Reply-To: <0ce46ce7-2edf-4464-8029-cdc6e9b9f854@lunn.ch>
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

On Wed, Sep 2, 2026 8:55 PM +0800, Andrew wrote:
>=20
> On Wed, Sep 02, 2026 at 05:06:26PM +0800, Chih Kai Hsu wrote:
> > RTL8159 has two different packages, QFN68 and QFN100. Therefore, split
> > RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.
>=20
> Why does the package matter. The commit message is about answering the
> question "Why?".
>=20
>     Andrew
>=20

I will rewrite the commit message in the next version.

Thank you,
Chih-Kai

> ---
> pw-bot: cr
