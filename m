Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233844;
	b=1vHUOJL3GABttgHAW7YfGnna8mafjDlRPCzDqCR9YiWEsqaO/gSOHp0V7XzDV3kWgWjT
	 FoYXkP4SzrruTKKN1oUIMpPKwUCpu6hmZjtT6oyladxj64Ebi8KCCs35ncUCwgvkoC45O
	 qpPJccmqfkqv1I3oF52Q7fEVyCGPAeGgsZSwwCzGPRX8H9CYy363meb+FwgxYBNiWA4c2
	 0k5UEEJSb/LUfcFRJ9A/wSlQ8eynGfqYQrXe8z4/29KIP2IjOaXVYCxkjkeSEv5UeOQzN
	 EG/YWgtUrvOZsgFho3i9aUIOngvJ0L7RLMm0gn9IeueG5SSSuYIbxEa++9PqoPjhKKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233844;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:Received:
	 From:To:Cc:In-Reply-To:References:Subject:MIME-Version:X-Mailer:Date:
	 Message-Id:Content-Transfer-Encoding:Content-Type;
	bh=6Cc6btvaFSiQLVCWvXGv6R3b5//OwzX3r5axgusNC6Q=;
	b=hYYnPpnY6HvdaIIFt+grN4aFZ7Sw2mb5QSyDp0uoH31mgMZQqiDdp/5pornghUMMeNjL
	 WWUKVYwKkxoDQmv5ezV385rYW9oyveKIe3yueKrLdhZC5S3Q7I1MDzDmNhDJ3EwyoAFAY
	 MO644v+xagNcq/04aB6DZrblwr5AbhNjCLBm5yJra9NN6Z/fHw4iut12wBE9+K0noxoyc
	 F4S1WRPrKubk7KPsZdaPfQgv+W1DD7MJ7YAKHE24lgPLEFiO2oGrc+nLFyLOJPDmsrEIa
	 duBMtW0INOsIpxBCVOuGNWlYnsGuIAqfL3Yf3jboAjciKYSG8E/IWhm1z8iab2l6snQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=0upti.me;
	spf=pass smtp.mailfrom=0upti.me;
	dkim=pass header.d=0upti.me header.i=@0upti.me header.a=rsa-sha256 header.s=mail header.b="SkAM/Qs4";
	arc=none smtp.remote-ip=31.44.14.16
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [31.44.14.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A9606A31C;
	Mon,  9 Nov 2026 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0upti.me header.i=@0upti.me header.a=rsa-sha256 header.s=mail header.b=SkAM/Qs4
Received: from mail-nwsmtp-mxback-production-main-33 (mail-nwsmtp-mxback-production-main-33.yp-c.yandex.net)
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 2C6FF81282;
	Mon, 09 Nov 2026 17:17:13 +0300 (MSK)
Received: from mail.yandex.ru
	by mail-nwsmtp-mxback-production-main-33 with HTTPS id 5HSrZ90Zua60-LVUykiD7;
	Mon, 09 Nov 2026 17:17:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1794233832; bh=6Cc6btvaFSiQLVCWvXGv6R3b5//OwzX3r5axgusNC6Q=;
	h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
	b=SkAM/Qs42vKQqU5Yn7s/VS2m6RPENicoJdSnhFjeA7bHVwRkZ8pCDEiyVvscqJQBr
	 7Dyc2nZQg5M9wPyr+JJT4fnJo45NTFeCj/xil4BfBmRR98c94+gOucSVhquD+N7C3c
	 2tAE5W6ot2wLS1+z+lx8NYJp9olXgEHQG15oc3pM=
Authentication-Results: mail-nwsmtp-mxback-production-main-33; dkim=pass header.i=@0upti.me
Received: by mail-sendbernar-production-main-38 with HTTPS id f31c56bbefb1cac15fb6585d3fc447df;
	Mon, 09 Nov 2026 17:17:12 +0300
From: Ilya K <me@0upti.me>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
In-Reply-To: <93881792559683@cb540089-648e-4f63-be25-5737cfc54c1c>
References: <1767631788532094@64c4e675-cd08-4a74-816f-886742f9bfcd> <529a79bc-dab7-aa41-00bd-c47ecbefaa00@candelatech.com> <471221788538289@323ca970-5bd2-4c6b-b52d-2b863a718615> <3acf531c-bcc7-412b-b3bb-665069260e46@candelatech.com> <2028561788553569@f088f4ec-f441-47a1-b7e4-75a1052aa4df> <2418461788691106@84aa39c5-f501-4e64-8418-6a8b6eb88e21> <eb405366-6574-4e4c-a89d-363751ed848b@candelatech.com> <4175721788798939@f00554c7-d809-471c-9bcf-78e5d8eceab4> <1556871789207706@7dc9deb3-4292-4932-8568-de9b411208d8> <1443771789748846@4a8ec5ae-80ed-44bc-b7d3-6bc660c90136> <211851789913261@df1900ea-d467-4ed7-a7f1-de68a4c3e6dd> <143991791036721@40be7595-980b-4665-ba66-1601e10a0899> <c4286904-2a9a-41fd-93ce-be57964909f6@candelatech.com> <221941791052355@558b3e58-c2b1-4e14-91fe-beb5649d18f6>
	<5955851791966910@d362902e-9931-4ad0-8e86-72401cc67703> <04b8b928-b671-4236-a792-1141cd81a34b@candelatech.com> <93881792559683@cb540089-648e-4f63-be25-5737cfc54c1c>
Subject: Re:[bug] Triple whammy of mt7996e bugs on 7.2+
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 09 Nov 2026 17:17:12 +0300
Message-Id: <463591794233832@bdca924a-ebf7-49c8-bd40-0c3aa4d8de31>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

OK, so this fell off my radar for a bit, but here's some more testing results:
- somewhere between 7.2.12 and 7.2.15 something is causing the system to spend way more time in IRQ handlers, this looks like it's not actually wifi related, but it does make the whole thing very slow and annoying to deal with
- 7.3.3 + board specific patches that don't touch mt76 at all still crashes
- tip of Felix's mt76 tree + same patches also crashes
- rebasing my previously-working 7.2 frankentree on 7.3.3 also crashes

That last one got me some potentially useful logs though: https://gist.github.com/K900/0f4be7064903880f0c409adc168cb59e

The tree itself is here: https://github.com/K900/linux/tree/bpi-r4-73-ct

I really need to filter it down to whatever fixes it on 7.2...
