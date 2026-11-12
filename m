Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467177;
	b=1zWjR/80diyUlkhHTBNhr2uhIIzVCCA2Y+Z1Qoz6ROkOpzpjPpkiPo62oX5xYvE0vy5r
	 QCjTJOBtQRyQ4OMKF0g/ruz1tZnhmSw5ja9t0c2PkKoewryEtugkGzd+yEMYvBlL7haZ9
	 u+ht+FyCHz473bPGUzUkXJTB8p/qyyW8W+WG8KGEZD1Pub0nG52zTfwMOofDTJvpdbkZc
	 xSxCDVql2VIODrJ9TE6Oufnzc/uzYcTZXnb+8PXZg+Efx0eGpFpW9zMcwG8lbecCYMWLe
	 A36bacHvdtDJNlfxcPpK/WmYuI3m66w5Wie+cdvqGWemrRDA6h+lFqSm+Z8itJqIzjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467177;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=TuSfXNv3tqyfrqmNJ/2xozIl8FLsikVEYsP/wgInjvg=;
	b=J8FFQGacQS+v4m3MlYdbScbPjYKe/ue1W+7s124EvjEVY+slaknqLBGZrSIgnj1BCtnv
	 qAziBq5LszTvS9kMtgEkG5p0cEiT9a0AqXExye9OfqX7ZI4AdwUt17sKKau54vDOPIvb2
	 s4Z3qqN1QCPL1IvHoHd7FeVE0arY2GQzV8HL6F8Ag7RPFj/j5vUo3eflAL3Rt+Hb5zICS
	 e0wj8JzluS98Hkrjl46DLnzaW0+YxKfU6lGCYeYRcfpyv+wUt6w/lFAgC/FHnDFjVn849
	 RuAg9enqSG0QLfYvRLiOIp5SNE8kcIENrjbprXZNc7X/YjulNScMTdgeXP4GkkWwqZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=A2CeRxaL;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B6606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=A2CeRxaL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TuSfXNv3tqyfrqmNJ/2xozIl8FLsikVEYsP/wgInjvg=; b=A
	2CeRxaLtWtcwETrugVfGpKtfA3Gl2HPRzos/+l444tdSZBdvT1sllp+vYxrHhzQE
	hg0qXrxvjgQcCn7A5L6AA0JrMFpsUqVM359jCfZSZAEC8URsSm3R4lycXml4xnlM
	72iIt4X7ol/YoA5CrpVZKqkNC3gNLFEeesMAEn9jQQ=
Received: from chenaibingfly$126.com ( [2409:8720:4a00:1405::326] ) by
 ajax-webmail-wmsvr-41-103 (Coremail) ; Thu, 12 Nov 2026 15:06:04 +0800
 (CST)
Date: Thu, 12 Nov 2026 15:06:04 +0800 (CST)
From: "Chen Aibing" <chenaibingfly@126.com>
To: netdev@vger.kernel.org
Cc: manishc@marvell.com, rahulv@marvell.com
Subject: [PATCH net-next] netxen_nic: add missing prototype for
 netxen_nic_set_link_parameters()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2SBviduEkt4iedbekfn0YSgug3WcKzvvok3YRVc+YOpQDO/y8HWHJvOVnQ+emwDg2gnBqQQQZO6f1iXaR6lLdKH7/fyceFhvtBk+kZ9w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <66745163.49c6.1a1ce93f261.Coremail.chenaibingfly@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZykvCgD3X5tcZfVq2zJgAA--.53313W
X-CM-SenderInfo: xfkh0txlel0wxio1qiyswou0bp/xtbBqByIw2r1ZVy9wAAA3k
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpGcm9tOiBjaGVuYWliaW5nIDxjaGVuYWliaW5nQGNtc3MuY2hpbmFtb2JpbGUuY29tPgoKRml4
IHRoZSBmb2xsb3dpbmcgVz0xIHdhcm5pbmcgd2hlbiBidWlsZGluZyB3aXRoIC1XbWlzc2luZy1w
cm90b3R5cGVzOgoKICBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvbmV0eGVuL25ldHhlbl9u
aWNfaHcuYzogd2FybmluZzogbm8gcHJldmlvdXMKICBwcm90b3R5cGUgZm9yICduZXR4ZW5fbmlj
X3NldF9saW5rX3BhcmFtZXRlcnMnIFstV21pc3NpbmctcHJvdG90eXBlc10KClRoZSBmdW5jdGlv
biBpcyBkZWZpbmVkIGluIG5ldHhlbl9uaWNfaHcuYyBhbmQgY2FsbGVkIGZyb20gb3RoZXIgZmls
ZXMKaW4gdGhlIGRyaXZlci4gQWRkIHRoZSBtaXNzaW5nIGRlY2xhcmF0aW9uIHRvIHRoZSBzaGFy
ZWQgaGVhZGVyLgoKU2lnbmVkLW9mZi1ieTogY2hlbmFpYmluZyA8Y2hlbmFpYmluZ0BjbXNzLmNo
aW5hbW9iaWxlLmNvbT4KLS0tCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvbmV0eGVuL25l
dHhlbl9uaWMuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL25ldHhlbi9uZXR4ZW5fbmljLmggYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvbmV0eGVuL25ldHhlbl9uaWMuaAppbmRleCAxMjM0
NTY3ODkwYWIuLmFiY2RlZjEyMzQ1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
cWxvZ2ljL25ldHhlbi9uZXR4ZW5fbmljLmgKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxv
Z2ljL25ldHhlbi9uZXR4ZW5fbmljLmgKQEAgLTE1NzQsNiArMTU3NCw3IEBAIGludCBuZXR4ZW5f
Z2V0X2ZsYXNoX21hY19hZGRyKHN0cnVjdCBuZXR4ZW5fYWRhcHRlciAqYWRhcHRlciwgdTY0ICpt
YWMpOwogaW50IG5ldHhlbl9wM19nZXRfbWFjX2FkZHIoc3RydWN0IG5ldHhlbl9hZGFwdGVyICph
ZGFwdGVyLCB1NjQgKm1hYyk7CiB2b2lkIG5ldHhlbl9jaGFuZ2VfcmluZ3BhcmFtKHN0cnVjdCBu
ZXR4ZW5fYWRhcHRlciAqYWRhcHRlcik7Cit2b2lkIG5ldHhlbl9uaWNfc2V0X2xpbmtfcGFyYW1l
dGVycyhzdHJ1Y3QgbmV0eGVuX2FkYXB0ZXIgKmFkYXB0ZXIpOwogCiBleHRlcm4gY29uc3Qgc3Ry
dWN0IGV0aHRvb2xfb3BzIG5ldHhlbl9uaWNfZXRodG9vbF9vcHM7CiAKLS0gCjIuMzkuMA==
