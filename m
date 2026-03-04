Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516534D907;
	Wed,  4 Mar 2026 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609196; cv=none; b=IkaOz7f8/abNTbsa/GQX/1oLCNzHaZLsu6xmEmf/pvVhFWyFfBh2Ys4zdCBkmswshLBczei/rkEU0iQoWZeNi+Mn+bMifHRrtji+7Fhl6Qw0F+2M2lkFJec2zPIOzQOR23OVXMFR+1b8ZWX+dMoX3eT8Oqdc9xoDddhRTDfYvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609196; c=relaxed/simple;
	bh=ZR7JanFqGwsEU+eVdemdOmJHuhYJMpgpUzstcLswt70=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=TK9H3K3wK0Y6G4+riNsMbCxpe22cOYFAi/O3YSb7mpyLG+GdL5K/v3hxDIXwL70M3KpD8FPdMdABKt/c/ezmbRZFz/Az2MKMSSYYsPJwZJc56VKvUY7krgUyI+lPIuZjOzd4+m9dE32QV/tC+4BJmS04YlUyYQXEYzdvMig1s20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1157588|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.195383-0.00812595-0.796491;FP=9254858517572092112|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=16;RT=16;SR=0;TI=W4_0.2.3_212518A3_1772608678116_o7001c49u;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_212518A3_1772608678116_o7001c49u] cluster:ay29) at Wed, 04 Mar 2026 15:20:44 +0800
Date: Wed, 04 Mar 2026 15:20:44 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "pabeni" <pabeni@redhat.com>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <34c4ed3f-fef6-4c4c-8b0f-9951fedf580c.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHY1IG5ldC1uZXh0IDExLzExXSBuZXQvbmVidWxhLW1hdHJpeDog?=
  =?UTF-8?B?YWRkIGNvbW1vbiBkZXYgc3RhcnQvc3RvcCBvcGVyYXRpb24=?=
X-Mailer: [Alimail-Mailagent revision 1106][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com> <20260226073840.3222-12-illusion.wang@nebula-matrix.com>,<b8f71f46-735b-4b1f-8df8-01a532bc7964@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjE1LVJlbGVhc2UuMjYwMjI1MDAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <b8f71f46-735b-4b1f-8df8-01a532bc7964@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Cj4gPiAraW50IG5ibF9kZXZfc3RhcnQoc3RydWN0IG5ibF9hZGFwdGVyICphZGFwdGVyLCBzdHJ1
Y3QgbmJsX2luaXRfcGFyYW0gKnBhcmFtKQo+ID4gK3sKPiA+ICsgaW50IHJldDsKPiA+ICsKPiA+
ICsgcmV0ID0gbmJsX2Rldl9zdGFydF9jb21tb25fZGV2KGFkYXB0ZXIsIHBhcmFtKTsKPiA+ICsg
cmV0dXJuIHJldDsKCj5yZXR1cm4gbmJsX2Rldl9zdGFydF9jb21tb25fZGV2KGFkYXB0ZXIsIHBh
cmFtKTsKCj5CdXQgdGhlbiBpIGhhdmUgdG8gYXNrLCB3aHkgYm90aGVyIGhhdmluZyBuYmxfZGV2
X3N0YXJ0KCkgd2hlbiB5b3UgY2FuCj5qdXN0IGNhbGwgbmJsX2Rldl9zdGFydF9jb21tb24oKS4K
CllvdSdyZSBhYnNvbHV0ZWx5IHJpZ2h0LiBIb3dldmVyLCB3ZSdyZSBjb25zaWRlcmluZyBmYWNp
bGl0YXRpbmcgZnV0dXJlCmV4cGFuc2lvbiBmb3IgdGhlIG5leHQtc3RhZ2UgbmV0ZGV2IGNvbmZp
Z3VyYXRpb24uCgotLWlsbHVzaW9uLndhbmc=
