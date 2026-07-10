Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52003546EF;
	Fri, 10 Jul 2026 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651544; cv=none; b=lVEgswm5xd1i8+p0BmiUXYtDjCu8S8gtCFwwXUETiezYtTNHQH5NjFB55NrnlPA49oXVYeTqNchspLo9G6PVX8zgPDj0SmZAXCeDTm2tzIHzu6IbMXZli8jhNJaHC9T+Na472X/JeC2bGHpRC/lX1vhyf2XyykT2Zw0z9w2VxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651544; c=relaxed/simple;
	bh=UWLptllgMKcsc4QRHADo/DDa/GmezgtR1eVvljV3t5k=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=rwCxhXtNx5fPbv4OdHdQ93MoAfQv/A+au9sUk5q6uPl41LFwij8qMpz2FtbBpT9ydVmVemCPbxfIp6mURdEOy2UKlGACOmh0L5VdO2a58pOt5djTNL1yQYXsvkHsiIdswY7Pt4d+9ZFXZ3fjUpdYSykBvjCDJ7UthT+5dL3+vF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2274032|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.468193-0.0146381-0.517169;FP=17038026415964094180|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_21252303_1783651412036_o7001c52b;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_21252303_1783651412036_o7001c52b] cluster:ay29) at Fri, 10 Jul 2026 10:45:15 +0800
Date: Fri, 10 Jul 2026 10:45:15 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Breno Leitao" <leitao@debian.org>
Cc: "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "horms" <horms@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <25d3ffc3-6f45-4baf-9c3c-ff075de14778.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYyMSBuZXQtbmV4dCAwMS8xMl0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBtaW5pbXVtIG5ibCBidWlsZCBmcmFtZXdvcms=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com> <20260708064742.35391-2-illusion.wang@nebula-matrix.com>,<ak5sjL21NQSWDB9S@gmail.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjIwLVJlbGVhc2UuMjYwNTE0MDAyKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <ak5sjL21NQSWDB9S@gmail.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Pj4gRnJvbTogaWxsdXNpb24gd2FuZyA8aWxsdXNpb24ud2FuZ0BuZWJ1bGEtbWF0cml4LmNvbT4K
Pj4gK1N1cHBvcnQKPj4gKz09PT09PT0KPj4gKwo+PiArRm9yIG1vcmUgaW5mb3JtYXRpb24gYWJv
dXQgbTE4MTEwLU5JQy9tMTgwMDAtTklDLCBwbGVhc2UgdmlzaXQgdGhlIGZvbGxvd2luZyBVUkw6
Cj4+ICtodHRwczovL3d3dy5uZWJ1bGEtbWF0cml4LmNvbS8KPgo+RG8geW91IGhhdmUgYSBsaW5r
IGZvciB0aGUgc2l0ZSBpbiBlbmdsaXNoPwoKPlRoYW5rcwoKU29ycnksIEkgd2lsbCBmaXggdGhp
cyBpbiB0aGUgbmV4dCByZXZpc2lvbiBvZiB0aGUgcGF0Y2ggc2VyaWVzLgpPdXIgb2ZmaWNpYWwg
RW5nbGlzaCBwcm9kdWN0IHBhZ2UgaXMgYXZhaWxhYmxlIGF0OgpodHRwczovL3d3dy5uZWJ1bGEt
bWF0cml4LmNvbS9zbmljX3MxMDAwX2VuClRoZSBTMTAwMCBzZXJpZXMgcHJvZHVjdHMgYXJlIGJh
c2VkIG9uIHRoZSBtMTgwMDAgY2hpcCBmYW1pbHksCmFuZCB5b3UgY2FuIGZpbmQgZnVsbCBOSUMg
cHJvZHVjdCBpbnRyb2R1Y3Rpb25zIG9uIHRoaXMgcGFnZS4KCgoKCgo=
