Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79B371D11;
	Fri, 11 Sep 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116063; cv=none; b=mXRyvXxFQuBdnXUitsorNV4fp4A1a31SRurHrSz9hgpH/mrRC+KeABkdozG3rd7VLvWrkyubgQ6Vdg7pjy6VKuMYtQrRRNZLrYomOApXFDlQKnG7oiInc7nkSyX0sBQrbExviUMppVxLpt59bibc6/l/+MFU32cRjhDgAVgPUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116063; c=relaxed/simple;
	bh=cUgVQ4+F5cAwRNZPY67atToeNj2pgrvmmSO+g+BtdYg=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=eJpJwEECFosU023K1Scddg+FPcCz6oFk+Xb0qohTdvAYFzMu5x7HLmQYIZAGGrbqtvdsCCZNKbtw96ehE2Opw+GWawiwC7O+mCHTyudcu5UVu0o1aEUaq56sLbqLiH80nM4JimCEQjpw9k/N0ji9fUDiQTqmDgjzu7iGhJRmdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=o3Lvynnx; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="o3Lvynnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789116041;
	bh=cUgVQ4+F5cAwRNZPY67atToeNj2pgrvmmSO+g+BtdYg=;
	h=Date:From:To:Subject:Mime-Version:Message-ID;
	b=o3LvynnxeZxNeY1XCZ1VNh3ZewlPJMYh6QO/ALVKAkMJVSMsO/aBLVcBkSb4fuvGE
	 6P8g/Pt6dUHfx3UVfwNYu9nAuInk6coDnvo9Hs3UsH8D86Bb5zLs4IIoBt8H6mBBxy
	 2iNQu5n9JNqnStyUdtKGCOfkMQLpnEfDq3WYYdqU=
X-QQ-mid: zesmtpsz3t1789116035tc893fa95
X-QQ-Originating-IP: Wwf56ac9Ab6dxRwpm+dyowsf4y9gEc8/p6o//X7O6Kw=
Received: from PEN002676 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 16:40:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14537747011413877646
Date: Fri, 11 Sep 2026 16:40:33 +0800
From: =?GB2312?B?1dS98MP3?= <zhaojinming@uniontech.com>
To: maxime.chevallier <maxime.chevallier@bootlin.com>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, 
	mcoquelin.stm32 <mcoquelin.stm32@gmail.com>, 
	alexandre.torgue <alexandre.torgue@foss.st.com>, 
	jose.abreu <Jose.Abreu@synopsys.com>
Cc: netdev <netdev@vger.kernel.org>, 
	linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: fix stale descriptors and DMA mapping leak on Tx map failure
References: <20260910-stmmac-fix-vlan-desc-leak-v1-1-6b07dca5e5e8@uniontech.com>, 
	<4a07a3d6-b515-43b6-918d-87806c479430@bootlin.com>
X-Priority: 3
X-GUID: E3B0AC8C-D1BC-47B3-B037-15EC2C348CE3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.375[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <E92AD2C7F9C27CD6+202609111640319095245@uniontech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N9XwYzVBzkV5m9c1QUiHWJJO5fvKRK2tarLk0J98hTLAxsLxHObabz3l
	38hlw1iCfYGCMrjaYXZp27DL39wkvkib3vxpXz2CHf+PTFpvuRsL7e38yGq7kJ23kPCxGEZ
	+6tOl63gNGwRpwaCRn7OJ4pd1ziH5Onj097FGFkF1I+quK5E0iR0nkAHHsYZagx+rk879s5
	yRIr95PX4CWg2aNUvVGZ5/g2FtIzgyOg7Ci6vFnhJol+eGLtnl8PDSTu8BEjcy7v+VfiHjt
	PszqveQ2OY2qYYArmw2iS5EEGAILh46aMy+DTnRP5GZoJzs1bqnRJX/BddOAF80KumWb1mm
	lOIMHFXQz5yuEcovfUjsAlkvTBBzuhNxayQ2xW50lxl9kBOPv0nni99soQKZI18Fh3peUrs
	seO6EG8lXvzAw5KebPmRf55u5FG1Up43M8Nvs/6pZIdOwkj/KY9pO27X1sv6yTmf4BqO1mY
	ybR0R1T7U8SLdq0JFBoqANlIjdLRv9KCBmeOLMFdw7CXY2eIDYdqIopQB4aKQzBO0DcY5ne
	t72oQLH8Lt/vs0QwIavUWUq9cf7HHbM0JLcvY3TXp+pZWcfLKDhuF+yuMmWc+oNye42FfxP
	/VjAYbz+YB93xFlcge8oMO5KUkeBbh88+FXj9zt7BRD8WI2iAezOhKIiex3eQoPgUYVONfE
	GxHzd/V47joxNini6r44Tj+kkRwPRYdYw62ja1sHPXN8o/JBbRmYNvdgKqJD5Oj+Vp5Rbbj
	qAkfY66pfrksrN97gE6Jo2lFibeA8CR6sPfkXZLSWNOQuBkzHgOQxtBaKu4ZZQ7tvyeB6tM
	z6zhH+gSDTjS520IJEz6Ny+hOlueaqu7K7p+kb5JYDDpT25PvPjpDZE4rBR5IJcEc2bbrlT
	Cy0MMoEkrNWL/a1AY0Lp3sXHiJlbI5okjCUL0FJOCxIyvQL9ZhHua9DLbpy1a3bdKrwdkoz
	IZG9DpWvkYu4vSMf9We0B5D2xLZrDN6HyzHbVWQI8B9/3s2H9i+a1HyYlsqctx/E163A=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Cgo+SGksCgoKCj4KCgoKPk9uIDkvMTAvMjYgMDc6MTksIFpoYW9KaW5taW5nIHdyb3RlOgoKCgo+
PiBJbiBzdG1tYWNfeG1pdCgpLCB3aGVuIHRoZSBETUEgbWFwcGluZyBvZiB0aGUgbGluZWFyIHBh
cnQgb3Igb2YgYQoKCgo+PiBmcmFnbWVudCBmYWlscywgdGhlIGVycm9yIHBhdGggb25seSBmcmVl
cyB0aGUgc2tiLj8gVGhpcyBsZWF2ZXMgYmVoaW5kCgoKCj4+IHRoZSBETUEgbWFwcGluZ3MgYWxy
ZWFkeSBjcmVhdGVkIGZvciB0aGUgbGluZWFyIHBhcnQgYW5kIGZvciB0aGUKCgoKPj4gZnJhZ21l
bnRzIG1hcHBlZCBiZWZvcmUgdGhlIGZhaWx1cmUsIHdoaWNoIGFyZSBuZXZlciB1bm1hcHBlZC4K
CgoKPj4gCgoKCj4+IFRoZSBWTEFOIGNvbnRleHQgZGVzY3JpcHRvciBwcm9ncmFtbWVkIGJ5IHN0
bW1hY192bGFuX2luc2VydCgpIGlzIGFsc28KCgoKPj4gbGVmdCBiZWhpbmQgd2l0aCBpdHMgT1dO
IGJpdCBzZXQgd2hpbGUgdHhfcS0+Y3VyX3R4IGhhcyBiZWVuIGFkdmFuY2VkCgoKCj4+IHBhc3Qg
aXQsIHNvIHRoZSBETUEgZW5naW5lIGxhdGVyIGNvbnN1bWVzIHRoZSBvcnBoYW5lZCBkZXNjcmlw
dG9yIGFuZAoKCgo+PiBhcHBsaWVzIGl0cyBzdGFsZSBWTEFOIHRhZyB0byBhbiB1bnJlbGF0ZWQg
ZnJhbWUuCgoKCj4+IAoKCgo+PiBSZWxlYXNlIHRoZSBkZXNjcmlwdG9ycyBhbmQgdGhlaXIgRE1B
IG1hcHBpbmdzIGluIHRoZSBkbWFfbWFwX2VyciBwYXRoCgoKCj4+IHdpdGggc3RtbWFjX3JlbGVh
c2VfdHhfZGVzYygpIGFuZCBzdG1tYWNfZnJlZV90eF9idWZmZXIoKSwgd2Fsa2luZyBmcm9tCgoK
Cj4+IGZpcnN0X2VudHJ5IHRvIGVudHJ5LCB0aGVuIHJvbGwgYmFjayB0eF9xLT5jdXJfdHggYW5k
IHJlbGVhc2UgdGhlIFZMQU4KCgoKPj4gY29udGV4dCBkZXNjcmlwdG9yLgoKCgo+PiAKCgoKPj4g
Rml4ZXM6IDMwZDkzMjI3OWRjMiAoIm5ldDogc3RtbWFjOiBBZGQgc3VwcG9ydCBmb3IgVkxBTiBJ
bnNlcnRpb24gT2ZmbG9hZCIpCgoKCj4+IFNpZ25lZC1vZmYtYnk6IFpoYW9KaW5taW5nIDx6aGFv
amlubWluZ0B1bmlvbnRlY2guY29tPgoKCgo+PiAtLS0KCgoKPj4/IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMgfCAyOSArKysrKysrKysrKysrKysrKysr
LS0tLQoKCgo+Pj8gMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgoKCj4+IAoKCgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNy
by9zdG1tYWMvc3RtbWFjX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL3N0bW1hY19tYWluLmMKCgoKPj4gaW5kZXggMjQ2NTZiMzUzNTBiMTQ0NTRmYjEwZGVjZWQ2
NTE2ZWI4OWUyYzBjOS4uMmUzNmMyN2UyY2ZiNDM2YWYzNTY2Y2YxYzNlNzBkMzJjZTk4MzBhMCAx
MDA2NDQKCgoKPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3Rt
bWFjX21haW4uYwoKCgo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1h
Yy9zdG1tYWNfbWFpbi5jCgoKCj4+IEBAIC00NzY5LDEyICs0NzY5LDEyIEBAIHN0YXRpYyBuZXRk
ZXZfdHhfdCBzdG1tYWNfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KQoKCgo+Pj8gCXVuc2lnbmVkIGludCBub3BhZ2VkX2xlbiA9IHNrYl9oZWFkbGVuKHNr
Yik7CgoKCj4+PyAJdTMyIHF1ZXVlID0gc2tiX2dldF9xdWV1ZV9tYXBwaW5nKHNrYik7CgoKCj4+
PyAJaW50IG5mcmFncyA9IHNrYl9zaGluZm8oc2tiKS0+bnJfZnJhZ3M7CgoKCj4+IC0JdW5zaWdu
ZWQgaW50IGZpcnN0X2VudHJ5LCB0eF9wYWNrZXRzOwoKCgo+PiArCXVuc2lnbmVkIGludCBmaXJz
dF9lbnRyeSwgZW50cnksIHR4X3BhY2tldHM7CgoKCj4+PyAJc3RydWN0IHN0bW1hY190eHFfc3Rh
dHMgKnR4cV9zdGF0czsKCgoKPj4/IAlzdHJ1Y3QgZG1hX2Rlc2MgKmRlc2MsICpmaXJzdF9kZXNj
OwoKCgo+Pj8gCXN0cnVjdCBzdG1tYWNfdHhfcXVldWUgKnR4X3E7CgoKCj4+PyAJaW50IGksIGNz
dW1faW5zZXJ0aW9uID0gMDsKCgoKPj4gLQlpbnQgZW50cnksIGZpcnN0X3R4OwoKCgo+PiArCWlu
dCBmaXJzdF90eCwgcmV0OwoKCgo+Pj8gCWRtYV9hZGRyX3QgZG1hX2FkZHI7CgoKCj4+PyAJdTMy
IHNkdV9sZW47CgoKCj4KCgoKPlBsZWFzZSBmb2xsb3cgdGhlIHJldmVyc2UgeG1hcyB0cmVlIG9y
ZGVyaW5nLCBmcm9tIGxvbmdlc3QgbGluZSB0byBzaG9ydGVzdAoKRG9uZSBpbiB2MjogdGhlIHZh
cmlhYmxlIGRlY2xhcmF0aW9ucyBpbiBzdG1tYWNfeG1pdCgpIGFyZSBub3cgb3JkZXJlZApmcm9t
IGxvbmdlc3QgdG8gc2hvcnRlc3QgbGluZS4KCgoKPgoKCgo+VGhlIHJlc3Qgc2VlbXMgT0suIEJ5
IGFueSBjaGFuY2UsIGRvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciA/CgoKCj4KCgoKPk1heGltZQoK
Cgo+CgoKCj4KCk5vIHJ1bnRpbWUgcmVwcm9kdWNlciwgc29ycnkuIFRoaXMgd2FzIGZvdW5kIGJ5
IGNvZGUgcmV2aWV3IC8gc3RhdGljCmFuYWx5c2lzLiBUaGUgdHJpZ2dlciByZXF1aXJlcyBhIERN
QSBtYXBwaW5nIGZhaWx1cmUgKGRtYV9tYXBfc2luZ2xlIC8Kc2tiX2ZyYWdfZG1hX21hcCkgY29t
YmluZWQgd2l0aCBWTEFOIGluc2VydGlvbiBvZmZsb2FkIG9yIGZyYWdtZW50ZWQKU0tCcywgd2hp
Y2ggbmVlZHMgSU9NTVUgcHJlc3N1cmUgb3IgZmF1bHQgaW5qZWN0aW9uIHRvIHJlcHJvZHVjZQpy
ZWxpYWJseS4KClRoYW5rcyBmb3IgdGhlIHJldmlldy4KClJlZ2FyZHMsClpoYW9KaW5taW5nCgoK

