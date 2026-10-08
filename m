Received: from cvsmtppost22.nm.naver.com (cvsmtppost22.nm.naver.com [114.111.35.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2394718FA;
	Thu,  8 Oct 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449351; cv=none; b=Tdtqb272VSHD6K8ZInVu0lB5jHO6VxMVIQBmDHFCSglg3sgsCe5taZDGA08JKWKcpiwPvr0wiDplZCFGZsB6V8fczw9bMtR6DZb1PA6ab88+NTzYPAENIiRWbknDqUB3eb3ripKgmBa4/S8LtPEcWfmzS325fw9QPo2ctW00+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449351; c=relaxed/simple;
	bh=3j1CVKI9p3tOCS3C3SmQfpiGv43tPagq5sFMFIrIpUI=;
	h=MIME-Version:Message-ID:Date:From:In-Reply-To:References:To:Cc:
	 Subject:Content-Type; b=Bjp+WvASkWzjIwanSyIDbK63VtYuI1crqr+kb81mwl133+DKqzsEIJrj2/eK1zEJ/sY9D6liqMwH8pfAn1j8MqxWSD/ser/1v+kCxXiuPMU0GsI29McC5NhaGHOsUS4FSakx+L0Sk5BZEpiAvcPolHGhUAT7lBuXf/xOErrSIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=I7DcQ+Xb; arc=none smtp.client-ip=114.111.35.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="I7DcQ+Xb"
X-Works-Smtp-Source: XrYwFAulFqJCpNm/KqKrWHF0
Received: from nv1s-hmac-real-7 ([10.180.31.91])
  by cvsmtppost22.nm.naver.com with ESMTP id pzIEzCvRS+eRn9ddp0hZ4A
  for <multiple recipients>;
  Thu, 08 Oct 2026 08:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791448738; bh=3j1CVKI9p3tOCS3C3SmQfpiGv43tPagq5sFMFIrIpUI=;
	h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=I7DcQ+XbtB0MnSy+vzqgvt+4XxoKA4WnnnytXtC4f9RhUKm7LCKagtUB1npkeeA/D
	 Ir8Xegov17y/hmTv72qW1W3Jbcvv3F1+hzAuThWzPsXqMh2beMXRmMRdyNSxlPQ1+w
	 ydH2Ii8V9DxAE5BJg5PYXh7O6m1Wm2kE1tKjxUXTf1rNmX7//CpTWzxVyPLd0526U0
	 cpb1h8jf2F1V2zyyj3oDMX8Uzmaa+1HiToO1Lq0oZYDBbIltgSikdN0Q/AFolnIhN9
	 JVQJxA7NIKE2afdCYpcXSZE7mHRlqiUvkQ9MCnMpBdHQjbRTjmfM7UMZ/itu/XWFdA
	 /fnmx4NLHg4SQ==
X-Session-ID: 5507a1b6a4c68568e59ce6cd1922d90abae9a5276a3c9dd1f2aafc7bf7d7aabc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <246918dc4bb12e46eef07cfeb6b3d1e5@cweb010.nm>
Date: Thu, 08 Oct 2026 17:38:57 +0900
From: =?utf-8?B?7ISx67OR7LCs?= <tjdqudcks0424@naver.com>
In-Reply-To: <179144819826.2527009.1542482431321559008@kernel.org>
References: <20261008082518.347350-1-tjdqudcks0424@naver.com>
	<179144819826.2527009.1542482431321559008@kernel.org>
Importance: normal
To: <netdev-bot+sinfo@kernel.org>
Cc: =?utf-8?B?TWFuaXZhbm5hbiBTYWRoYXNpdmFt?= <mani@kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSCBuZXRdIHFydHI6IG1ha2UgcmVwZWF0ZWQgbG9va3VwcyBmcm9tIG9uZQ==?=
	=?utf-8?B?IGNsaWVudCBpZGVtcG90ZW50?=
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGksCgpUaGlzIGlzc3VlIHdhcyBpZGVudGlmaWVkIGR1cmluZyBtYW51YWwgc3RhdGljIHNvdXJj
ZSByZXZpZXcgb2YgdGhlIFFSVFIKbG9va3VwIGFjY291bnRpbmcgcGF0aCwgd2l0aCBhc3Npc3Rh
bmNlIGZyb20gT3BlbkFJIENvZGV4LgoKSSBzdWJzZXF1ZW50bHkgcmVwcm9kdWNlZCBhbmQgdmFs
aWRhdGVkIGl0IHVzaW5nIGFuIGlzb2xhdGVkIGxvY2FsCkFGX1FJUENSVFIgZml4dHVyZS4gQSBz
ZXBhcmF0ZSB1bnByaXZpbGVnZWQgc29ja2V0IHdhcyB1bmFibGUgdG8gcmVnaXN0ZXIKYSBsb29r
dXAgYWZ0ZXIgb25lIGNsaWVudCBzdWJtaXR0ZWQgMTI4IGR1cGxpY2F0ZSBsb29rdXAgcmVxdWVz
dHMgaW4gYWxsCnRocmVlIGJhc2VsaW5lIHJ1bnMuIFdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIHRo
ZSBpbmRlcGVuZGVudCBsb29rdXAKc3VjY2VlZGVkIGluIGFsbCB0aHJlZSBydW5zLCB3aGlsZSB0
aGUgYm91bmRhcnksIHJlcGVhdGVkLWxpc3RpbmcsIGFuZApzb2NrZXQtY2xvc2UgY2xlYW51cCBj
b250cm9scyByZXRhaW5lZCB0aGVpciBleHBlY3RlZCBiZWhhdmlvci4KClRoYW5rcywKU3VuZyBC
eWVvbmdjaGFuCgo=
