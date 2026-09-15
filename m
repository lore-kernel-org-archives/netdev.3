Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5039792B;
	Tue, 15 Sep 2026 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467145; cv=none; b=P3KkmxM8GDwM8SU87Tw0D+mjIGH9Ti/ZxgxvWvA4cxyutvhz6rz6jDru5THadfafDRSKLPgArJJTEvkm+DMYgjvGsuaac7bhO2NfZg7JGvHsSEiiKY+eDUurZxHr1ur3fLxqGmxiGhiMnlfzrCcH22UnUYZSsgT+bVuQMfAnfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467145; c=relaxed/simple;
	bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID; b=uKfQ8vCpTtshVKrila4f8udF4uMj3cAqfMA6wf5TtV7IAq3acxXV6TsmbXv7D1jhoyEP0xJz+yvuTGyCm+Lj03LpEdu8YuYHru+UlQ+2j+bnZ5d7luQLZvWnCWXEiXIhuV5+XM/vkHl+L1ZhGgZNaFyPfKAp8JY066dLw3ZXN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DwmM9Wkw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DwmM9Wkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:MIME-Version:From:To:Subject:Date:
	Message-ID; bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=; b=D
	wmM9WkwbqD6wf+DfxVcx/AiH0NUxH820D/BT0haRQXWkDRBjvjM8JDck/wzDVFtV
	FPkOvqnsxkAe8g0wOYQDhL1puByb7XnZdMSebxQE2zjMbpQtVZxD44xk3m5ttVXn
	E0lbfpRPup0bcDMlZZuaIfPQR7KgjdZtOjPlAEDl4M=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tian Run <15503232150@163.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] i40e: fix VF queue mapping collision with PF queue 0
Date: Tue, 15 Sep 2026 18:11:18 +0800
Message-ID: <178946707899.849053.3626754711268331752@bigrain>
X-CM-TRANSID:_____wBn+6vHGalqxkDoAg--.261S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDWF15WrWxtry5Wr1xXwb_yoW8urW3pr
	WUCryYk34kXF4rW3yjga109Fn3Awn5KrW5WF4ftwn09a9IkF4UXF1UKayagry8ArZ5ta13
	tFZrArW7Cr4DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb189UUUUU=
X-CM-SenderInfo: jprvkiqtstjiivq6il2tof0z/xtbC4Ap9cmqpGco7ggAA3M

aTQwZV92c2lfc2V0dXAoKSBsaW1pdHMgdGhlIHF1ZXVlIHBhaXJzIG9mIGFuIFNSSU9WIFZTSSB0
bwpwZi0+bnVtX2xhbl9tc2l4IGFuZCBmaWxscyBpbmZvLnF1ZXVlX21hcHBpbmdbXSBvbmx5IGZv
ciB0aGF0IG1hbnkKZW50cmllcywgbGVhdmluZyB0aGUgcmVzdCB6ZXJvZWQuIGk0MGVfdmNfZ2V0
X3BmX3F1ZXVlX2lkKCkgcmVzb2x2ZXMKc3VjaCBhbiBlbnRyeSB0byBhYnNvbHV0ZSBxdWV1ZSAw
LCB3aGljaCBiZWxvbmdzIHRvIHRoZSBQRiBpdHNlbGYuCgppNDBlX2NvbmZpZ192c2lfdHhfcXVl
dWUoKSB0aGVuIG92ZXJ3cml0ZXMgdGhlIFBGJ3MgcXVldWUgMCBjb250ZXh0CndpdGggdGhlIFZG
J3MgcmluZyBhbmQgcmUtcHJvZ3JhbXMgUVRYX0NUTCgwKSBpbnRvIFZGIG1vZGUuIFRoZSBQRidz
Cm5leHQgdHJhbnNtaXQgb24gcXVldWUgMCB3ZWRnZXMgdGhlIHF1ZXVlOiB0aGUgZGV2aWNlIHN0
b3BzIGl0LApyZXBvcnRzIGEgTWFsaWNpb3VzIERyaXZlciBEZXRlY3Rpb24gZXZlbnQgd2l0aG91
dCBhIHZhbGlkIGV2ZW50IElELApzZXRzIGJvdGggUEZfTURFVF9UWCBhbmQgVlBfTURFVF9UWCBh
bmQgdGhlIFBGIGVudGVycyBhIE5FVERFVgpXQVRDSERPRyAvIHJlc2V0IGxvb3AuCgphbGxvY19x
dWV1ZV9wYWlycyBpcyBzZXQgdG8gcGYtPm51bV92Zl9xcHMsIHNvIEdFVF9WRl9SRVNPVVJDRVMK
YWR2ZXJ0aXNlcyB0aGUgZnVsbCBjb3VudCBhbmQgYSBWRiB3aXRoIG1vcmUgb25saW5lIENQVXMg
dGhhbiB0aGUKUEYncyBudW1fbGFuX21zaXggKGUuZy4gYSA0LUNQVSBndWVzdCBvbiBhIDMtQ1BV
IGhvc3QpIGNvbmZpZ3VyZXMKdGhlIGV4dHJhIHF1ZXVlIHBhaXIgYW5kIGhpdHMgdGhlIHVucHJv
Z3JhbW1lZCBtYXBwaW5nIGVudHJ5LgoKQ2xhbXAgYWxsb2NfcXVldWVfcGFpcnMgYnkgbnVtX2xh
bl9tc2l4IGxpa2UgaTQwZV92c2lfc2V0dXAoKSBkb2VzLApzbyB0aGUgVkYgaXMgb25seSBvZmZl
cmVkIHF1ZXVlIHBhaXJzIHdob3NlIG1hcHBpbmcgd2FzIHByb2dyYW1tZWQuCgpGaXhlczogMTU2
M2YyZDJlMDEyICgiaTQwZTogRG8gbm90IGFsbG93IHVzZSBtb3JlIFRDIHF1ZXVlIHBhaXJzIHRo
YW4gTVNJLVggdmVjdG9ycyBleGlzdCIpClNpZ25lZC1vZmYtYnk6IFRpYW4gUnVuIDwxNTUwMzIz
MjE1MEAxNjMuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9t
YWluLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jCmluZGV4IGFiYmM3MWU4MS4u
MjkzNDg2MmRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0
MGVfbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWlu
LmMKQEAgLTExNDQzLDYgKzExNDQzLDEyIEBAIHN0YXRpYyBpbnQgaTQwZV9zZXRfbnVtX3Jpbmdz
X2luX3ZzaShzdHJ1Y3QgaTQwZV92c2kgKnZzaSkKIAogCWNhc2UgSTQwRV9WU0lfU1JJT1Y6CiAJ
CXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPSBwZi0+bnVtX3ZmX3FwczsKKwkJLyogaTQwZV92c2lf
c2V0dXAoKSBsaW1pdHMgcXVldWUgcGFpcnMgdG8gbnVtX2xhbl9tc2l4OworCQkgKiBrZWVwIGFs
bG9jX3F1ZXVlX3BhaXJzIGNvbnNpc3RlbnQgd2l0aCB0aGF0IGxpbWl0LgorCQkgKi8KKwkJaWYg
KHRlc3RfYml0KEk0MEVfRkxBR19NU0lYX0VOQSwgcGYtPmZsYWdzKSkKKwkJCXZzaS0+YWxsb2Nf
cXVldWVfcGFpcnMgPQorCQkJCW1pbl90KHUxNiwgcGYtPm51bV92Zl9xcHMsIHBmLT5udW1fbGFu
X21zaXgpOwogCQlpZiAoIXZzaS0+bnVtX3R4X2Rlc2MpCiAJCQl2c2ktPm51bV90eF9kZXNjID0g
QUxJR04oSTQwRV9ERUZBVUxUX05VTV9ERVNDUklQVE9SUywKIAkJCQkJCSBJNDBFX1JFUV9ERVND
UklQVE9SX01VTFRJUExFKTsKLS0gCjIuNDMuMAoK

