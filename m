Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802403148DA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049673; cv=none; b=uhD5MmNz6KL/CDVcvuRBAuIL7Ewj7cVeLXMwLcVHxb8Fm+/EJWYAnd9fSVM5PtCcts03VfITFX8fztdj2OR8G0vlylNbfePmy0aJ8cL5yOwSvNEgPgxDIZi6SKkz+qqjerBsHHC3VRTbnhehSIDc+/qgXc+p2f2EUn097yqQJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049673; c=relaxed/simple;
	bh=gEY9FBlfW2ywiPB1a5DMZW3Mfmw2DyFww1nU2GoqSKg=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=BJD6eUuw3BByJTw7IF1cMRf0l5qmIbtqvBB/xiuYGc0y4v2yi0AlhOm/Oo2g6WxTxv5OMJwOEEQGvYgyu8W1o9US/N3T/BQpEASw6Dq3v8nojY8HudrUsmtBQ9qgj5N37OAEnFxlKzf2uYQCKFz7Hf+39Ugct4w1ShACbBv7tXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=W0r4AdVf; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="W0r4AdVf"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADMAawDfKsBQ6nOp56VEcaqc.3.1783049345624.Hmail.220255722@seu.edu.cn>
To: Elad Nachman  <enachman@marvell.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFtFWFRFUk5BTF0gUXVlc3Rpb246IHByZXN0ZXJhOiBjbGFyaWZ5IGV2ZW50IGhhbmRsZXIgUkNVLWxpc3QgY29udHJhY3Q=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <BN9PR18MB42518A2E98E06D2AED326816DBE92@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20260627135002.4060912-1-runyu.xiao@seu.edu.cn> <BN9PR18MB42518A2E98E06D2AED326816DBE92@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 3 Jul 2026 11:29:05 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 3 Jul 2026 11:29:05 +0800 (GMT+08:00)
X-HM-Tid: 0a9f2604c57d02f2kunmab500afb1abc
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5GfO5Omku9T/6BrnRlHEXAyMQMJfF4WZB3hWdN6nWl6ZY8J2Cs
	02iQ+9uR8DWRwtKuQZPniMBORckwb8scA9D0Y=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSB5PVk9LSE9PSU9PTUNOHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEtPQ0hVSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=W0r4AdVfgtzDJkSg4jBdkfcpPyTXcI9RNHCivibbp+Mggf/CYXJ7fhq4bHnMlhDuX2fIj7hIKC8qJOj5+e2DglX+N+xOta5FzMs3bcmIwjErBUmLxa0WWw6l/X6Ts1O+JZpyCvSIbFFsGPkIim7gNX1fL+nA8816c4XJcJTT6+w=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=gEY9FBlfW2ywiPB1a5DMZW3Mfmw2DyFww1nU2GoqSKg=;
	h=date:mime-version:subject:message-id:from;

SGkgRWxhZCwKCk9uIE1vbiwgMjkgSnVuIDIwMjYsIEVsYWQgd3JvdGU6CiZndDsgSSB0aGluayB1
bmxlc3MgcHJvdmVuIG90aGVyd2lzZSBkb2N1bWVudGF0aW9uIChwZXIgIzQpIGlzIGVub3VnaC4K
ClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uCgpVbmRlcnN0b29kLiBCYXNlZCBvbiB5b3Vy
IGZlZWRiYWNrLCBJIHdpbGwgdHJlYXQgdGhpcyBhcyBhbiBpbnRlbmRlZAppbml0L2Zpbmktb3Jk
ZXJlZCByZWdpc3RyYXRpb24gY29udHJhY3QgKCM0KSwgYW5kIEkgd2lsbCBub3QgcHVyc3VlIGEK
cGF0Y2ggZm9yIGl0IHVubGVzcyBJIGNhbiBjb21lIGJhY2sgd2l0aCBzdHJvbmdlciBldmlkZW5j
ZSB0aGF0IHRoZQpjdXJyZW50IGNvbnRyYWN0IGlzIGluc3VmZmljaWVudC4KClRoYW5rcywKUnVu
eXUKCg==
