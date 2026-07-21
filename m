Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E04313E38;
	Tue, 21 Jul 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599118; cv=none; b=V/4K+l5ZMd9E6fhByk2idOGA8NKDm06/DBv343TpqTYzBmTE9XJ8d0Q/GsCgIzannw9Yh10yDOzCmX394EBjlJpMmqk/SFaW0uM1n/+Dmkjko/ENsBmOLZ2HaC8ey22t/OnJBA3mC+U7EiAYNZZu3QOo/uSctwaK5cfYSDv/Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599118; c=relaxed/simple;
	bh=kkaXHXCYzlkxsMqu5aMpIsortni2YjoH/rB2+vAkVms=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-Reply-To:
	 References:Message-Id:Date; b=qxvWREVNv4EjTCEyAzew5J1j8RXz7YsU0wie1dImMs0DlE/qR1yqOufM9zo2WwzZFxa1+VOyLWplWpH4bJ/B8j76hwljRkvO20bVhpG7i5GyY3ovHP8rCbghbj8aiwREBZyaOmTKZ/h2cys4tl/KwXM9ubq6zZpeMQBfUM2WR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pOubn6Yi; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pOubn6Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
	Message-Id:Date; bh=kkaXHXCYzlkxsMqu5aMpIsortni2YjoH/rB2+vAkVms=;
	b=pOubn6YiJmclF2Fo4qWD6EqR04VUJzVol7BL0qQp7+TTy4WnIGzOKeqRcWYX1P
	xKqhSPHT322ynkcUQ0vSA2PGhwqyFvPGeO5s4/u2vBLZfkYBrJ1dS+o/f1yqEwp/
	KS5agLKtgz6ORteMrtdGtIaawEoy4RN79PAKGYOdQJw3w=
Received: from [127.0.1.1] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfwa0l5qXCtEIw--.23396S2;
	Tue, 21 Jul 2026 09:57:46 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Weimin Xiong <xiongwm2026@163.com>
To: intel-wired-lan@lists.osuosl.org
Cc: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: =?utf-8?q?=5BPATCH_v2=5D_ice=3A_parser=3A_use_kcalloc_for_table_allocation?=
In-Reply-To: <28460003-47ee-4706-ad95-7fba87d36509@intel.com>
References: <20260716025100.118145-1-xiongwm2026@163.com>
X-CM-TRANSID:PigvCgBXhfwa0l5qXCtEIw--.23396S2
Message-Id:<6A5ED21A.2B234A.06153@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr13Ar15ArW3Cr45GF1xKrg_yoW8ury5pF
	WkG340kF1Sq3Wxur4DX3WFkFZ8Xay8Gry5WFn8WFZ5Z3ZxAw48XwsxKryY9ry09ry5KFW3
	tF1jvF1SvryrXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jESoAUUUUU=
Date: Tue, 21 Jul 2026 09:57:47 +0800 (CST)
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzhrsfGpe0hoz6AAA3j

RnJvbSAzNzZkZmRmYzc4OGE4NTNjNzlhODdjNGJmZGQ5NGRjMWVhNjc4YzQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXZWltaW4gWGlvbmcgPHhpb25nd20yMDI2QDE2My5jb20+CkRh
dGU6IFR1ZSwgMjEgSnVsIDIwMjYgMDk6NDY6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIIHYyXSBp
Y2U6IHBhcnNlcjogdXNlIGtjYWxsb2MgZm9yIHRhYmxlIGFsbG9jYXRpb24KVG86IGludGVsLXdp
cmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnCkNjOiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRl
ci5sb2Jha2luQGludGVsLmNvbT4sCglUb255IE5ndXllbiA8YW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20+LAoJUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPiwK
CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsCglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLAoJ
QW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD4sCgkiRGF2aWQgUy4gTWlsbGVyIiA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4sCgkiRXJpYyBEdW1hemV0IiA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT4sCglKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiwKCVBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4KSW4tUmVwbHktVG86IDwyODQ2MDAwMy00N2VlLTQ3MDYtYWQ5NS03ZmJh
ODdkMzY1MDlAaW50ZWwuY29tPgpSZWZlcmVuY2VzOiA8MjAyNjA3MTYwMjUxMDAuMTE4MTQ1LTEt
eGlvbmd3bTIwMjZAMTYzLmNvbT4KClVzZSBrY2FsbG9jKCkgd2hlbiBjYWxjdWxhdGluZyB0aGUg
cGFyc2VyIHRhYmxlIGFsbG9jYXRpb24gc2l6ZSBzbyBhbgpvdmVyZmxvdyBpbiB0aGUgZmlybXdh
cmUtcHJvdmlkZWQgaXRlbSBkaW1lbnNpb25zIGlzIGRldGVjdGVkIGJlZm9yZQphbGxvY2F0aW9u
LgoKdjI6IFVzZSBrY2FsbG9jKCkgaW5zdGVhZCBvZiBremFsbG9jKGFycmF5X3NpemUoKSkgYXMg
c3VnZ2VzdGVkIGJ5CiAgICBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGlu
dGVsLmNvbT4KCi0tLQoKdjEtPnYyOgogIC0gUmVtb3ZlIHJlZHVuZGFudCBpbmNsdWRlIG9mIDxs
aW51eC9vdmVyZmxvdy5oPgogIC0gVXNlIGtjYWxsb2MoKSBpbnN0ZWFkIG9mIGt6YWxsb2MoYXJy
YXlfc2l6ZSgpKSBhcyBzdWdnZXN0ZWQgYnkKICAgIEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2Fu
ZGVyLmxvYmFraW5AaW50ZWwuY29tPgoKU2lnbmVkLW9mZi1ieTogV2VpbWluIFhpb25nIDx4aW9u
Z3dtMjAyNkAxNjMuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
cGFyc2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3Bh
cnNlci5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wYXJzZXIuYwppbmRl
eCBmOGU2OTYzMGYuLmY1YWU2YzA3MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9wYXJzZXIuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3BhcnNlci5jCkBAIC0xMDIsNyArMTAyLDcgQEAgaWNlX3BhcnNlcl9jcmVhdGVfdGFi
bGUoc3RydWN0IGljZV9odyAqaHcsIHUzMiBzZWN0X3R5cGUsCiAJaWYgKCFzZWcpCiAJCXJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOwogCi0JdGFibGUgPSBremFsbG9jKGl0ZW1fc2l6ZSAqIGxlbmd0
aCwgR0ZQX0tFUk5FTCk7CisJdGFibGUgPSBrY2FsbG9jKGxlbmd0aCwgaXRlbV9zaXplLCBHRlBf
S0VSTkVMKTsKIAlpZiAoIXRhYmxlKQogCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAoKYmFz
ZS1jb21taXQ6IDk1ZTI0ZTkwYjU1Y2U2ZDlkMjY2ZWQ2ZjIwNTE0ZjM3YzkzMWM3NTEKLS0gCjIu
NDMuMAoK

