Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217B282F17;
	Mon, 27 Jul 2026 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116811; cv=none; b=f5RtlDiwH6x18XQXY4Y7XKQ7Mjqn8ZlLDQ4xXb58frieAm9tO1noSAEAr9cNmmsRgjwj/U0+5LCF0wKU42ZWk2C4yNXzMJAN7qOqZTQKJCM8m91rSEoV29Yqc1Nkxc7R6JtpBmoBGwpaK+L7DrEgaywdwluV1somWL3b2m+8DFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116811; c=relaxed/simple;
	bh=6rHE4yr9lgbWbrm8s9YVncuI0jtPTtiWmb7JprgDTnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBz7RYavnGFHwBinPFCgh/Tm8N574B+Zai2xCe5nSPzmtMoUhflTY/21u4+66H08sIK0LjpfJ+PDjaM+X86Diis016IOk8Rq6OwHQlG5D9Y4vndlNZugG7Ju6b1LOvuB8bDdOji/ngdsajM/Uc1ckcXKW/1KFVXBuiaGn29k0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=iWzU3suV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="iWzU3suV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66R1jGBf92742567, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785116717;
	bh=6rHE4yr9lgbWbrm8s9YVncuI0jtPTtiWmb7JprgDTnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iWzU3suVOggYEP2CUuAZxO6/6ypJZqiBCAATZUjilK7N9R7sYmvF1L1wrVDnJzc09
	 +40Gk4EkYHSUFTg4xax/JrRE/en5UyqUQyK0F7FsJX+sRXpP7Eht1ugvxTduLxRmgK
	 hD5IUbc/1LqYg5bBBFIpHOETPWT2ZLSqK3yeemJ1cBl8opvWU6tMd8szP7e5obiWTg
	 Yz1c9iiyRhWw1o2dN/nAMVTPCbvCoZ/k9yl+XwqJ2uykwjIy3UD3YiHkRIB7rMb8kE
	 hDcaq+yhFRs6SoiM6M7LXdJB4jwU+uQHzfNATt3c+ib8me9PI6+s/60L7YfjJpkLfa
	 xWP2PCTzW4yPQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66R1jGBf92742567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 09:45:16 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 09:45:16 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Mon,
 27 Jul 2026 09:45:15 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Chukun Pan <amadeus@jmu.edu.cn>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, =?utf-8?B?6aG+5pmT5Yab?=
	<freddy_gu@realsil.com.cn>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "nb@tipi-net.de" <nb@tipi-net.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v10 5/5] net: phy: realtek: add support for
 RTL8261D
Thread-Topic: [PATCH net-next v10 5/5] net: phy: realtek: add support for
 RTL8261D
Thread-Index: AQHdGLgFnWqKo3yoJ026TnnGe+U6QrZ48LqAgAeu6XA=
Date: Mon, 27 Jul 2026 01:45:15 +0000
Message-ID: <bb782164800a421397c2085f7e58aff4@realsil.com.cn>
References: <20260721022410.1391-6-javen_xu@realsil.com.cn>
 <202607270134.66R1YOaT41072024@rtits1.realtek.com.tw>
In-Reply-To: <202607270134.66R1YOaT41072024@rtits1.realtek.com.tw>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQo+DQo+SGksDQo+DQo+PiAgICAgICAgICAgICAgIFBIWV9JRF9NQVRDSF9FWEFDVChSVExf
ODI2MUNfQ0cpLA0KPj4gLSAgICAgICAgICAgICAubmFtZSAgICAgICAgICAgICAgICAgICA9ICJS
ZWFsdGVrIFJUTDgyNjFDIDEwR2JwcyBQSFkiLA0KPj4gKyAgICAgICAgICAgICAubmFtZSAgICAg
ICAgICAgICAgICAgICA9ICJSZWFsdGVrIFJUTDgyNjEgMTBHYnBzIFBIWSINCj4NCj5HaXZlbiB0
aGF0IHRoZSBSVEw4MjYxIGhhcyBtdWx0aXBsZSBzdWZmaXhlcyAoQi9DL0QvTiksIHRoaXMgbmFt
ZSBjaGFuZ2UNCj5jb3VsZCBiZSBjb25mdXNpbmcuDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNr
Lg0KVGhlIHJlYXNvbiBmb3IgdGhpcyBjaGFuZ2UgaXMgdGhhdCBSVEw4MjYxIDEwR2JwcyBQSFkg
c2hhcmUgdGhlIHNhbWUgcGh5IGlkLiBUaGUgc3BlY2lmaWMgaGFyZHdhcmUgdmVyc2lvbnMgYXJl
IGRpc3Rpbmd1aXNoZWQgYnkgYSBzdWItcGh5IGlkIGluc3RlYWQuIEFuZCBpbiBwcm9iZSBmdW5j
dGlvbiwgd2Ugd2lsbCBwcmludCBvdXQgdGhlIGV4YWN0IGhhcmR3YXJlIHZlcnNpb24gZXhwbGlj
aXRseS4NCg0KQlJzLA0KSmF2ZW4NCg==
