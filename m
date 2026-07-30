Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D713F9A15;
	Thu, 30 Jul 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403158; cv=none; b=YHkB7rI1GhXPT61IdwkmWXtT3vV+BL1e1+33gOFf0IqWeBfPZZEHE4vSe1nUnXSrAQupbbIW0wiizm0IZBa0+KAD9zo7oJJjNRHcLuPG9RLsNANqrghzOcHg2bBe9VA0X6IpI+cVTTyTeNQMovy426vLTjTploQnu/BhGP04YIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403158; c=relaxed/simple;
	bh=5T8GKf1pKPYzSmL+lREqbbGaw+D+o3ymbDWgAVOQBKI=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=D6JkwCnrojOY53ELRlN4+psBVfYPjtEhLht3f8I/g0TucgmJT4aTmj1M4x2mTb1Zbyu0L2Jjz/Jy/sgD/yQn0LjT7BmOy+omq5Xi1nSp7rnenM0JKbhho0vosVK1PwoK0liPGsCSJ2+WBU/YOQAdyWnYBVULMkWUyQsLa9kNu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2336563|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0367904-0.000889557-0.96232;FP=11994032418279405200|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=18;RT=18;SR=0;TI=W4_0.2.3_0B531016_1785402868265_o7001c138e;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_0B531016_1785402868265_o7001c138e] cluster:ay29) at Thu, 30 Jul 2026 17:18:45 +0800
Date: Thu, 30 Jul 2026 17:18:45 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Illusion Wang" <illusion.wang@nebula-matrix.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
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
Message-ID: <f42bb9df-2f69-49c9-a43e-c609f430c692.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHYyMiBuZXQtbmV4dCAwMi8xMl0gbmV0L25lYnVsYS1tYXRyaXg6?=
  =?UTF-8?B?IGFkZCBjb3JlIGRyaXZlciBhcmNoaXRlY3R1cmUgYW5kIEhXIGxheWVyIGluaXRpYWxpemF0?=
  =?UTF-8?B?aW9u?=
X-Mailer: [Alimail-Mailagent revision 107][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>,<20260723040110.91410-3-illusion.wang@nebula-matrix.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjIwLVJlbGVhc2UuMjYwNTE0MDAyKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <20260723040110.91410-3-illusion.wang@nebula-matrix.com>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

CihodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0Y2hzZXQvMjAy
NjA3MjMwNDAxMTAuOTE0MTAtMS1pbGx1c2lvbi53YW5nJTQwbmVidWxhLW1hdHJpeC5jb20pCk9u
ZSBjb21tZW50IGFza3M6IAo+PiArdm9pZCBuYmxfaHdfcmVtb3ZlX2xlb25pcyhzdHJ1Y3QgbmJs
X2FkYXB0ZXIgKmFkYXB0ZXIpCj4+ICt7Cj4+ICsJLyogQWxsIEJBUiBtYXBwaW5ncyAmIFBDSSBy
ZWdpb25zIGFyZSBtYW5hZ2VkIGJ5IHBjaW0vZGV2cmVzLAo+PiArCSAqIG5vIG1hbnVhbCBpb3Vu
bWFwIC8gcmVsZWFzZSByZXF1aXJlZAo+PiArCSAqLwo+PiArfQoKPnNpbmNlIG5ibF9od19yZW1v
dmVfbGVvbmlzIGlzIGFuIGVtcHR5IHN0dWIgZnVuY3Rpb24gd2l0aCBubwo+aW1wbGVtZW50YXRp
b24sIGlzIHRoZXJlIGEgdmFsaWQgcmVhc29uIHRvIHJldGFpbiBpdCAoYWxvbmcgd2l0aCBpdHMg
cHJvdG90eXBlCj5pbiBuYmxfZGVmX2guaCksIG9yIHNob3VsZCB3ZSBkZWxldGUgYm90aCB1bnRp
bCBhIHN1YnNlcXVlbnQgcGF0Y2ggYWRkcyBhY3R1YWwKPmNsZWFudXAgbG9naWMgdG8gaXQ/Cgoo
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwNDEyMTI1NzI4LjY2Mjg2Ny0xLWhv
cm1zQGtlcm5lbC5vcmcvKQpUaGUgb3RoZXIgY29tbWVudCBxdWVzdGlvbnMgd2hldGhlciBvdXIg
aW5pdGlhbGl6YXRpb24gYW5kIHRlYXJkb3duIHBhdGhzIHNob3VsZAptYWludGFpbiBzdHJpY3Qg
c3ltbWV0cnnigJRldmVyeSBzdWNjZXNzZnVsbHkgaW5pdGlhbGl6ZWQgbGF5ZXIgbXVzdCBoYXZl
IGEgbWF0Y2hpbmcKcmVtb3ZlIGNhbGxiYWNrIGludm9rZWQgYm90aCBpbiBydW50aW1lIGRldmlj
ZSByZW1vdmFsIChuYmxfY29yZV9yZW1vdmUpIGFuZCBhbGwKZWFybHkgZXJyb3IgdW53aW5kIGJy
YW5jaGVzIG9mIHRoZSBpbml0IGZsb3cuCgoKSSdtIGEgYml0IGNvbmZ1c2VkIGFib3V0IHRoZSB0
d28gU2FzaGlrbyByZXZpZXcgY29tbWVudHMgb24gUGF0Y2ggMiBvZiB0aGlzIHBhdGNoc2V0OgpX
aGljaCBwaWVjZSBvZiBmZWVkYmFjayBzaG91bGQgSSBmb2xsb3c/
