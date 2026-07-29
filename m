Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8F4086A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306020; cv=none; b=pi5Q3JQVKv2wZnH07vrXsWpj8S0Jej1McKbKq6layXsLr3aEzWI1to1hcIQXDtQ+COg65iiaPD+FwAvSSWYWREcTPSoesBA/UjnE7svcugRyI8TGIKddjOQ5PSPLHQJ6eExh3g0FxhwpKSwUD+4epi0Q60pqHOF2ktHlAChoDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306020; c=relaxed/simple;
	bh=vqUfW8R57wpzoimmnG9EQD32bSBIxArjcgipnUgBXyE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=fu7DdT2A9WusImACeQCGDSC5h2nGVEFWkDJEvRmOm134vg3wJMUJHrg5XZoMX4wc+7jJajIdhnNsAMNkOjFCFg2T/n6znGEfBXhCmfSmKJfvMFSf3RTzBiwHUJe/JXMsw/WFsUmaC7Znd8htP2vZamxCj6QcHsGc9Oh2E0kJV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WQfaEIQe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WQfaEIQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:MIME-Version:Subject:From:To:Date:
	Message-ID; bh=vqUfW8R57wpzoimmnG9EQD32bSBIxArjcgipnUgBXyE=; b=W
	QfaEIQemYyTWJgNqkEZbJLkMsB/OCc6d11dOMrpjcltNiadf6grsCVazmQ5Rj/UG
	G6JlspD9fei36IhbzdEwuBPN92dM+dWikHoOZNZcz5F21pvXdKe7LEqP7AxpeuzM
	q2pZpK+EpHuxkhXDpuLC7Cr9Oc7dGB5/UFrlq9qbck=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHZexlm2lqxX13MA--.20617S2;
	Wed, 29 Jul 2026 14:19:21 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: Re: [net] net: openvswitch: fix stack exhaustion from unaccounted clone_execute() recursion
From: yang zhuorao <alexyoung0@163.com>
To: aconole@redhat.com, i.maximets@ovn.org
Cc: echaudro@redhat.com, security@kernel.org, dev@openvswitch.org, netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, edumazet@google.com, davem@davemloft.net
Date: Wed, 29 Jul 2026 14:19:16 +0800
Message-ID: <178530595663.1425354.11834745902748968831@163.com>
In-Reply-To: <f7tse52x1zz.fsf@redhat.com>
References: <178521875706.803907.3226960398667307795@163.com> <f7twlufw4js.fsf@redhat.com> <a56fe38b-5fc8-4845-8d68-d199d753dcee@ovn.org> <f7tse52x1zz.fsf@redhat.com>
X-CM-TRANSID:_____wAHZexlm2lqxX13MA--.20617S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1UJr4rXrW5JrWUCF1rWFg_yoW8GryfpF
	W5Kr15trWDAFyxZr97G3W5WFy8Gr4kJw43CFn5J395Jay5G3WrJFZ0krW09a1fKrWkJa12
	gr40v3yfCF4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg9NxUUUUU=
X-CM-SenderInfo: xdoh55prxqwii6rwjhhfrp/xtbC5An19Gppm2mLAgAA3U

QWFyb24sIElseWEsIHRoYW5rIHlvdSBib3RoIGZvciB0aGUgcmV2aWV3LgoKPiBUaGVyZSBpcyBh
biBleGlzdGluZyBjaGVjayBmb3IgcmVjdXJzaW9uIGluIG92c19leGVjdXRlX2FjdGlvbnMoKSBh
bmQgaW4KPiB0aGVyZSB3ZSBoYXZlIGEgbG9nIGJlZm9yZSBkcm9wcGluZzoKPiAuLi4KPiBXZSBz
aG91bGQgaGF2ZSBhIHNpbWlsYXIgbG9nIGhlcmUgc28gd2UncmUgbm90IHNpbGVudGx5IGRyb3Bw
aW5nLiAgQnV0LAo+IHNpbmNlIHdlIG5vdyBoYXZlIHR3byBwbGFjZXMgd2hlcmUgdGhpcyBjaGVj
ayBvY2N1cnMgKGFuZCBpdCdzCj4gY29tcGxpY2F0ZWQgYmVjYXVzZSBvZiBob3cgZGVmZXJyZWQg
YWN0aW9ucyBpcyBwcm9jZXNzZWQpLCBtYXliZSBpdCdzCj4gYmV0dGVyIHRvIGhhdmUgYSBmdW5j
dGlvbiB0aGF0IGRvZXMgdGhlIG1hbmFnZW1lbnQ6CgpHb29kIHBvaW50LiAgdjIgZXh0cmFjdHMg
dGhlIGVudGVyL2V4aXQgbG9naWMgaW50bwpvdnNfZXhlY19sZXZlbF9lbnRlcigpIGFuZCBvdnNf
ZXhlY19sZXZlbF9leGl0KCkgaGVscGVycywgZXhhY3RseSBhcwp5b3Ugc3VnZ2VzdGVkLCBhbmQg
dXNlcyB0aGVtIGluIGJvdGggY2xvbmVfZXhlY3V0ZSgpIGFuZApvdnNfZXhlY3V0ZV9hY3Rpb25z
KCkuICBUaGUgbmV0X2NyaXRfcmF0ZWxpbWl0ZWQoKSBsb2cgaXMgbm93IGVtaXR0ZWQKb24gZXZl
cnkgcmVjdXJzaW9uLWxpbWl0IGhpdCByZWdhcmRsZXNzIG9mIGVudHJ5IHBvaW50LgoKPiBUaGVy
ZSBpcyBhIGRpZmZlcmVudCBpc3N1ZSBoZXJlIHRob3VnaC4gIFRoZSBleGVjX2xldmVsIGlzIHVz
ZWQgYXMgYQo+IGNvdW50ZXIgZm9yIHRoZSBmbG93IGtleXMgZHVyaW5nIHRoZSBjbG9uZS4gIEFu
ZCBpZiB3ZSBpbmNyZW1lbnQgaXQKPiB1bmNvbmRpdGlvbmFsbHkgd2hpbGUgbm90IGFsbG9jYXRp
bmcgbmV3IGtleXMsIHdlJ2xsIHJhbiBvdXQgb2Yga2V5Cj4gc2xvdHMgbXVjaCBmYXN0ZXIgd2l0
aG91dCBhY3R1YWxseSB1c2luZyB0aGVtLgoKQWdyZWVkIHRoaXMgaXMgYSByZWFsIGNvbmNlcm4u
ICBBcyBBYXJvbiBub3RlZCwgbW9zdCBkZXBsb3ltZW50cyBuZXN0Cm9ubHkgb25jZSBvciB0d2lj
ZSBzbyB0aGUgcHJhY3RpY2FsIHByZXNzdXJlIGZyb20gdGhpcyBjaGFuZ2Ugc2hvdWxkCmJlIG1h
bmFnZWFibGUsIGJ1dCBkZWNvdXBsaW5nIHRoZSByZWN1cnNpb24gY291bnRlciBmcm9tIHRoZSBr
ZXkgc2xvdAppbmRleCBpcyB0aGUgcmlnaHQgbG9uZy10ZXJtIGZpeC4gIEhhcHB5IHRvIGxlYXZl
IHRoYXQgYXMgYSBmb2xsb3ctdXAKc28gdGhpcyBzZWN1cml0eSBmaXggc3RheXMgZm9jdXNlZC4K
CnYyIHBvc3RlZCBhcyBhIHNlcGFyYXRlIHRocmVhZC4KClJlZ2FyZHMsCnlhbmcgemh1b3Jhbwo=

