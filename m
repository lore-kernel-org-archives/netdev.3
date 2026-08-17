Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA523741
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949457; cv=none; b=n4lmo2QkSOSvqhp6ucg/GI4FRNVDXKO15RJF/UyA2n3anlHCYixoueIp4BK1COwdiUCwuO/LoF5hL02K1rEHtPlnB94nAHLM9htf1pKigJ4omtSRf3jNuSj44Uvn4eZbp1Qs2EShKEEkVup2MGe9/o6AUQ1m27LUqpxMqDpfKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949457; c=relaxed/simple;
	bh=5aFcyaOqzui+kkMIepTV3BRgh8RG6wj+uX6aw4Rafn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CovY9PKLp0ftOjiC5CPWeqLqlr+FjNry1qP65D5Hj8JNg6aGXab5jYq3cxU9uVySLUyj/MjQKtv8buLb8/xfIX98Mm12mxo1t5EKqfpgSrPMZaDR7AfBTfkOR+jXncIsYbGnL4JctVaJcoud8kostCTeVQO6n8AKe+KBs0bH/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jLwHGhwx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jLwHGhwx"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67H6ooFW33730148, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1786949450; bh=5aFcyaOqzui+kkMIepTV3BRgh8RG6wj+uX6aw4Rafn0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jLwHGhwx9S/9Q313p8f9jlfdgix7AMri10c/D4O1RIsan2GYXb4poV62fnfdwEYqW
	 xwBwywUmSIlTFw9kjUX9KzkccmkGJHp2ioOrU/Ql236w1KKEPMczrIma4csrSDZGta
	 Ax1j4THE3okm3AvDAaAv14iwxR8wTLdWOISXyQXXnzv4/0IKln65ZicXL6nkcQkoB3
	 ioC6K5pr1crFrafXhvkQwNU4VBKmsv6Ho443LGMKPIPMtNXoinH7P0nCxg+vg1Vdwh
	 aaVQZBEPkfJn3tnOlTaQ54ZmzFRMxKl9HeJREnnR7ShPBLvUyUfZEdmmyiHzQdHlVL
	 msuAl8FfETM6A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67H6ooFW33730148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 14:50:50 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 17 Aug 2026 14:50:50 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8d70:ec96:b42e:3c54%9]) with mapi id
 15.02.2562.043; Mon, 17 Aug 2026 14:50:50 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: =?utf-8?B?0JzQsNC60YHQuNC8?= <rizlirizlirizli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, nic_swsd
	<nic_swsd@realtek.com>
Subject: RE: ATF support for r8152 driver
Thread-Topic: ATF support for r8152 driver
Thread-Index: AQHdK94f4ULwiTsV1EW0SJkUk82HuLahz+CQ
Date: Mon, 17 Aug 2026 06:50:50 +0000
Message-ID: <52ce36a7757141c0977d593b2c9c3088@realtek.com>
References: <CA+0KmMsGysTkd0oUytRnkH7+Wjmxx4OzRV1v2NGWWuHr89GvjQ@mail.gmail.com>
In-Reply-To: <CA+0KmMsGysTkd0oUytRnkH7+Wjmxx4OzRV1v2NGWWuHr89GvjQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

0JzQsNC60YHQuNC8IDxyaXpsaXJpemxpcml6bGlAZ21haWwuY29tPiANClsuLi5dDQo+IEhlbGxv
LA0KPiBJJ20gdXNpbmcgYSBVU0IgVHlwZS1DIHRvIFNGUCBhZGFwdGVyIGJhc2VkIG9uIHRoZSBS
VEw4MTUzIGNoaXAgKGRyaXZlcjogcjgxNTIpIG9uIExpbnV4LiBUaGUgYWRhcHRlciBoYXMgYW4g
U0ZQIGNhZ2UgYW5kIEknbSB0cnlpbmcgdG8gcmVhZCB0aGUgbW9kdWxlJ3MgRERNL0RPTSBkaWFn
bm9zdGljcyAoVFgvUlggb3B0aWNhbCBwb3dlciwgYmlhcyBjdXJyZW50LCB0ZW1wZXJhdHVyZSwg
dm9sdGFnZSkgdmlhIHRoZSBzdGFuZGFyZCBldGh0b29sIGludGVyZmFjZS4NCj4gRGV2aWNlIGlu
Zm86DQo+IGxzdXNiOiBCdXMgMDAzIERldmljZSAwMDU6IElEIDBiZGE6ODE1MyBSZWFsdGVrIFNl
bWljb25kdWN0b3IgQ29ycC4gUlRMODE1MyBHaWdhYml0IEV0aGVybmV0IEFkYXB0ZXINCj4gSW50
ZXJmYWNlIG5hbWU6IGVucDBzMjBmMHUzDQo+IERyaXZlciB2ZXJzaW9uOiByODE1MiB2MS4xMi4x
MyAodmVybWFnaWM6IDYuMTIuMTAxK2RlYjEzLWFtZDY0IFNNUCBwcmVlbXB0IG1vZF91bmxvYWQg
bW9kdmVyc2lvbnMpDQo+IFdoYXQgSSBvYnNlcnZlOg0KPiBldGh0b29sIC1tIGVucDBzMjBmMHUz
DQo+IE5ldGxpbmsgZXJyb3I6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkDQo+IENoZWNraW5nIGRt
ZXNnIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBjYWxsIHNob3dzIG5vIGRyaXZlciBhY3Rpdml0eSBh
dCBhbGwgcmVsYXRlZCB0byB0aGlzIHJlcXVlc3Qg4oCUIHRoZSBjYWxsIGFwcGVhcnMgdG8gYmUg
cmVqZWN0ZWQgYmVmb3JlIGFueSBVU0IgdHJhbnNhY3Rpb24gaXMgYXR0ZW1wdGVkLCB3aGljaCBz
dWdnZXN0cyBnZXRfbW9kdWxlX2VlcHJvbSwgZ2V0X21vZHVsZV9pbmZvIGlzIHNpbXBseSBub3Qg
aW1wbGVtZW50ZWQgaW4gc3RydWN0IGV0aHRvb2xfb3BzIGZvciB0aGlzIGRyaXZlci4NCj4gSSBu
b3RpY2VkIHRoYXQgZ2V0X21vZHVsZSBzdXBwb3J0IHdhcyByZWNlbnRseSBhZGRlZCBmb3IgUlRM
ODEyNyAoYSBkaWZmZXJlbnQgY2hpcCwgcjgxNjkgZHJpdmVyKSDigJQgdGhlIHBhdGNoICJyODE2
OTogaW1wbGVtZW50IGdldF9tb2R1bGUgZnVuY3Rpb25zIGZvciBydGw4MTI3YXRmIiAoRmFiaW8g
QmFsdGllcmksIEFwcmlsIDIwMjYpLiBJJ20gd3JpdGluZyB0byBhc2s6DQo+IElzIHRoZXJlIGFu
eSBwbGFuIHRvIGltcGxlbWVudCBnZXRfbW9kdWxlX2VlcHJvbSwgZ2V0X21vZHVsZV9pbmZvIChv
ciB0aGUgbmV3ZXIgZ2V0X21vZHVsZV9lZXByb21fYnlfcGFnZSkgZm9yIFJUTDgxNTMgaW4gdGhl
IHI4MTUyIGRyaXZlcj8NCj4gRG9lcyB0aGUgUlRMODE1MyBoYXJkd2FyZSBldmVuIGV4cG9zZSB0
aGUgU0ZQIGNhZ2UncyBJMkMvVFdTSSBsaW5lcyB0byB0aGUgaG9zdCBpbiBhIHdheSB0aGF0IHdv
dWxkIG1ha2UgdGhpcyBmZWFzaWJsZSwgb3IgYXJlIHRoZXkgb25seSB1c2VkIGludGVybmFsbHkg
YnkgdGhlIGNoaXAgKGUuZy4sIHNoYXJlZCB3aXRoIHRoZSBjaGlwJ3Mgb3duIEVFUFJPTSBpbnRl
cmZhY2UpPw0KPiBJcyB0aGVyZSBhbnkgZXhpc3RpbmcgaW50ZXJuYWwgUmVhbHRlayB0b29sIChl
dmVuIHVub2ZmaWNpYWwvV2luZG93cy1vbmx5KSB1c2VkIGZvciBwcm9kdWN0aW9uIHRlc3Rpbmcg
b2YgUlRMODE1My1iYXNlZCBTRlAgYWRhcHRlcnMgdGhhdCByZWFkcyBERE0gZGF0YSwgd2hpY2gg
Y291bGQgaW5mb3JtIGFuIGltcGxlbWVudGF0aW9uPw0KPiBIYXBweSB0byB0ZXN0IGFueSBwYXRj
aCBvciBwcm92aWRlIGZ1cnRoZXIgZGVidWdnaW5nIGluZm9ybWF0aW9uIChVU0IgY2FwdHVyZXMs
IHJlZ2lzdGVyIGR1bXBzLCBldGMuKSBpZiB0aGF0IHdvdWxkIGhlbHAuDQoNClRvIG15IGtub3ds
ZWRnZSwgdGhlIFJUTDgxNTIsIFJUTDgxNTMsIFJUTDgxNTYsIGFuZCBSVEw4MTU3IGRvIG5vdCBw
cm92aWRlIGEgaG9zdC1hY2Nlc3NpYmxlIGludGVyZmFjZSBmb3IgYWNjZXNzaW5nIHRoZSBTRlAg
bW9kdWxlJ3MgSTJDIGJ1cy4NClRoZXJlZm9yZSwgc3VwcG9ydCBmb3IgcmVhZGluZyB0aGUgU0ZQ
IEVFUFJPTSBvciBERE0vRE9NIGRpYWdub3N0aWNzIGNhbm5vdCBiZSBhZGRlZCBieSBtb2RpZnlp
bmcgdGhlIGRyaXZlciBhbG9uZS4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0K
