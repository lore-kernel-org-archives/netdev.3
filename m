Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466564;
	b=nbXLxER5Dcp4X4/l2/Zt7Rk1aVIviHKW25W1YrgxZGk+YbbyTXE/REJbeIxizr/rTvpY
	 ZIlLqDz+IHboWD/etuGkNNV/beMETf4a4NrYriBJDg3ZGQEGB+0I6kSGipTn1Epz8/hRR
	 OGPLQFejarZfG+5ORf11hHouylwTjRdUWfHOJhyIeDpajzHyzCwSQ3s4mS7nDnhXfAkW/
	 4a6jBtJ/uWMFYBgHjgJOhwC9AOCgOFV1NxhTZ0IEGWPdTBQ1dBYVpITCgKl2/HOmRqqae
	 Jkaa7TFGPkVRmhuixq+EnlBuMDwbOuryyICs0z/mMktWaARs14KEs6ULUSbT8ENkZKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466564;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=orTk+cCRojN6jAERdRAtmuhY/zheZD2z69ZfmXakmaQ=;
	b=i/GIwQRTySVY03y5PTIgPqESXRDFQFORuJPsIEFcL0w8IeLrGhrMMfoAM12j2DOTq6Bp
	 eYiqpC9DcbHgFAHIPvacFjT/ltNGodrFY7/Za0fNxbZm+qNPRZjzkvoitKiBADhGIZT4P
	 kVy+yqSvlK+TKNqdZLtV6ztT1WMtPAvNbfLM5Ujo/w/MiAlo7yihZ+E36MTWb/QXvpCmw
	 i9HBTX0311Lo+tLGOQijpSZ8d8tELEOKiH6D4k0bVgbdkoJpX9PqOISxoKtohtXS9qIJB
	 cpEVMhPPlELiPFUeWEWaomNs3CAneoeGhdHobbCK/INyAvevA+gPItxKMvbAUbHEhbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SQ4XpjV+;
	arc=none smtp.remote-ip=220.197.31.6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F7606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B0F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SQ4XpjV+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=orTk+cCRojN6jAERdRAtmuhY/zheZD2z69ZfmXakmaQ=; b=S
	Q4XpjV+vWyuE0M06YbIRuv2yI7tdqnfb6B5/jpuk0yLCrTWZ3gaHipu6gMwrKs6K
	eZ6XjoYpVS7Hpdgz1yaIhyJ80pEJoH+I5qk/7G9c2JMaaUwxT0llvzpwPXy2KRJ4
	MG6XTPWDtF+boBmlncebBPlCr/poqEhlKI+uHvEKhg=
Received: from chenaibingfly$126.com ( [2409:8720:4a00:1405::326] ) by
 ajax-webmail-wmsvr-41-103 (Coremail) ; Thu, 12 Nov 2026 14:55:49 +0800
 (CST)
Date: Thu, 12 Nov 2026 14:55:49 +0800 (CST)
From: "Chen Aibing" <chenaibingfly@126.com>
To: netdev@vger.kernel.org
Cc: linux-net-drivers@amd.com, ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com
Subject: [PATCH net-next] sfc: add missing prototypes for ef10 helper
 functions
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2SBviduU0v7yGQYOkfn0YSgug3WcKzvvok3YRVc+YOpQDO/y8HWHJvOVnQ+emwDg2gnBqQQQZO6f1iXaR6prFtc9o0ONbP9LOw0TOOBw==
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
Message-ID: <7d3fd748.4779.1a1ce8a8dcb.Coremail.chenaibingfly@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZykvCgD3t3_1YvVqoi9gAA--.52213W
X-CM-SenderInfo: xfkh0txlel0wxio1qiyswou0bp/xtbBqRXtKWr1YvWYagAA3C
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RnJvbTogY2hlbmFpYmluZyA8Y2hlbmFpYmluZ0BjbXNzLmNoaW5hbW9iaWxlLmNvbT4KCkZpeCB0
aGUgZm9sbG93aW5nIFc9MSB3YXJuaW5ncyB3aGVuIGJ1aWxkaW5nIHdpdGggLVdtaXNzaW5nLXBy
b3RvdHlwZXM6CgogIGRyaXZlcnMvbmV0L2V0aGVybmV0L3NmYy9lZjEwLmM6IHdhcm5pbmc6IG5v
IHByZXZpb3VzIHByb3RvdHlwZSBmb3IKICAnZWZ4X2VmMTBfdmFkYXB0b3JfcXVlcnknIFstV21p
c3NpbmctcHJvdG90eXBlc10KICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zZmMvZWYxMC5jOiB3YXJu
aW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yCiAgJ2VmeF9lZjEwX3ZhZGFwdG9yX2FsbG9j
JyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL2VmMTAu
Yzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvcgogICdlZnhfZWYxMF92YWRhcHRv
cl9mcmVlJyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2Zj
L2VmMTAuYzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvcgogICdlZnhfZWYxMF92
cG9ydF9hZGRfbWFjJyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvc2ZjL2VmMTAuYzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvcgogICdlZnhf
ZWYxMF92cG9ydF9kZWxfbWFjJyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvc2ZjL2VmMTAuYzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvcgog
ICdlZnhfZWYxMF90eF90c29fZGVzYycgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKVGhlc2Ugbm9u
LXN0YXRpYyBmdW5jdGlvbnMgYXJlIGRlZmluZWQgaW4gZWYxMC5jIGFuZCBjYWxsZWQgZnJvbQpl
ZjEwX3NyaW92LmMsIGJ1dCBoYXZlIG5vIGRlY2xhcmF0aW9uIGluIGFueSBzaGFyZWQgaGVhZGVy
LgpBZGQgdGhlIG1pc3NpbmcgcHJvdG90eXBlcyB0byBlZnguaC4KClNpZ25lZC1vZmYtYnk6IGNo
ZW5haWJpbmcgPGNoZW5haWJpbmdAY21zcy5jaGluYW1vYmlsZS5jb20+Ci0tLQogZHJpdmVycy9u
ZXQvZXRoZXJuZXQvc2ZjL2VmeC5oIHwgMTIgKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3NmYy9l
ZnguaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3NmYy9lZnguaAppbmRleCAxMjM0NTY3ODkwYWIu
LmFiY2RlZjEyMzQ1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL2VmeC5o
CisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3NmYy9lZnguaApAQCAtMjA5LDYgKzIwOSwxOCBA
QCBpbnQgZWZ4X3hkcF90eF9idWZmZXJzKHN0cnVjdCBlZnhfbmljICplZngsIGludCBuLCBzdHJ1
Y3QgeGRwX2ZyYW1lICoqeGRwZnMsCiAJCSAgICAgICBib29sIGZsdXNoKTsKIAorLyogZWYxMC5j
OiBleHBvcnRlZCBoZWxwZXJzIGFsc28gdXNlZCBieSBlZjEwX3NyaW92LmMgKi8KK2ludCBlZnhf
ZWYxMF92YWRhcHRvcl9xdWVyeShzdHJ1Y3QgZWZ4X25pYyAqZWZ4LCB1bnNpZ25lZCBpbnQgcG9y
dF9pZCwKKwkJCSAgICB1MzIgKnBvcnRfZmxhZ3MsIHUzMiAqdmFkYXB0b3JfZmxhZ3MsCisJCQkg
ICAgdW5zaWduZWQgaW50ICp2bGFuX3RhZ3MpOworaW50IGVmeF9lZjEwX3ZhZGFwdG9yX2FsbG9j
KHN0cnVjdCBlZnhfbmljICplZngsIHVuc2lnbmVkIGludCBwb3J0X2lkKTsKK2ludCBlZnhfZWYx
MF92YWRhcHRvcl9mcmVlKHN0cnVjdCBlZnhfbmljICplZngsIHVuc2lnbmVkIGludCBwb3J0X2lk
KTsKK2ludCBlZnhfZWYxMF92cG9ydF9hZGRfbWFjKHN0cnVjdCBlZnhfbmljICplZngsCisJCQkg
ICB1bnNpZ25lZCBpbnQgcG9ydF9pZCwgY29uc3QgdTggKm1hYyk7CitpbnQgZWZ4X2VmMTBfdnBv
cnRfZGVsX21hYyhzdHJ1Y3QgZWZ4X25pYyAqZWZ4LAorCQkJICAgdW5zaWduZWQgaW50IHBvcnRf
aWQsIGNvbnN0IHU4ICptYWMpOworaW50IGVmeF9lZjEwX3R4X3Rzb19kZXNjKHN0cnVjdCBlZnhf
dHhfcXVldWUgKnR4X3F1ZXVlLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAorCQkJIGJvb2wgKmRhdGFf
bWFwcGVkKTsKKwogI2VuZGlmIC8qIEVGWF9FRlhfSCAqLwotLSAKMi4zOS4w
