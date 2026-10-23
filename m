Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788013;
	b=qnkWz4OUKwxGfnZxWG9lLv4U3mWgTRmRty+Ph3d258kw4wygQsCOZ7t7kVpAUvHSXrxy
	 cDoAZzaaQ9Ck5us35D553LAm9f2WM6QbI5BLO5D/1/q2atlwaLXiW2L8nh/FqNefzOe9i
	 MUIX9qh6A1JyUATXL1JOcmLRfT52fGyQUDGsgklYYMzTUbr1sfAuIKYkWgaFoKAKOUBje
	 GKQGOi+EhApg72o3RG+D0FU0O2ixixo71xpKJqGG4k3SDPby72FlBjMN1cMmS4ot+H4d7
	 FtvV/oxsQ7BXpz5Pt1AKv76wSMNpzgn0H6Sp/lfYMlkhLDhO0twriDAQWkacYkdKE0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788013;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=spQ1YFgdgF3QQcBHq5siBsyaf73EG36ED6cxTRnBmN0=;
	b=MNR/QGAGTP/nB33vk4DYgxVoP5ZwHTpquqHffxiMmMfP6I3oaaRRBb5zsNZcGSFZIXNn
	 /4XRnLsW+kGnnMmTx3u/ae3tgAvwph6ymRphMcdzZynJQqUQKCFt6rzgYuPXcqxQHycvp
	 G6fqUnypohM0ScNAeKor34AEY/5pdB4u7IdeQLFdh/P9VOdWuK2PRtHoLZOZShY/DnJ2U
	 U1DkmGbYUm8DS53umh5g/ggoR7HHb030fpcmAoHgszzl+1eqcVff2oC04JlXj2SnqS4vy
	 3ZltyrEQC3oL6Bp/QJOINVKJQjfsoVQ0e+LzT6LRuQeHZOY8R4RZbfJyN/Oe/UnnR/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=DW1U+tha;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C6606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=DW1U+tha
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792788008;
	bh=spQ1YFgdgF3QQcBHq5siBsyaf73EG36ED6cxTRnBmN0=;
	h=From:To:Cc:Subject:Date;
	b=DW1U+thatCsumRGdRJ4aFAAnfD1V5Cu2bKi0nE4D97sXE3A9/FlJSxHGfix9Pr09y
	 cFDtvFEL+KEwKCLXnKnvlqpYrlf3baZ08ffnE3PAvMD2gcaEE/dc/viHqPCi983kj9
	 jncYIVwX6kgPcdJ6/UqaAEfXmWahxUbjuhWTOKWg=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A069680F; Sat, 24 Oct 2026 04:40:06 +0800
X-QQ-mid: xmsmtpt1792788006tjdz4ycs0
Message-ID: <tencent_6030CC520C02054D1B2925AEEF6FA92DC30A@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnR9JXFx3xhPbBgRN1QbgFBdErrLaGoJPZRWXL77lxm4DEs/8tofQ
	 Q8ccRTswKuQKrrZJo6HHDf9KMurHQ/GbQy2my5HfZlkWHVG4fnLkBS8k6A8xmkUcXKVZ5HWD5Z9i
	 IufwkMSwEVsRqyARj84Z2BVA2ZdwtdmoPZs/CTmOuj4FY5LrxVPi+P+GDzdRbL5S9WPTi4Aw+r/6
	 FH844nt9e09JdpZp+brPUEBqlFcZCLTAVc82h7Zi07lXD/HYCq4MOT2YkcJqj9uUfR/sFFylkCap
	 msA0Vr4plIqGuZcnyy2NLNntUm/e608RO0FRnqWNl/wcRqLrVezNooE2VuVLhgjFiU5nqjTELKDF
	 yjYhUfrgRFH21V9l4DqVXntJJ9s0vted5DDZ7HPjUIy4l33G98/JmgWdvsy5ZKTxxp1OR3MLKIp0
	 DI96gkG0PyoVmtBOAQiW9doSVlI4rTW9UjSpFr2JpsJf3vX+BgmgSD93ZbDfYxK2WiLGHsLiFlzM
	 fVPVgU2UM649g4kY7nhND2NgAX7d9wuFnXIgVhaCksf2cPZb75yv0OmsTWff0qv9rj3q7fNUkVmn
	 Jz7DD6Ol8X6Dlxa/kRzTUnEc1/Tt1UuoZtlELd/9jzQjHwYtLC8GOZqC1iosneeAXJ4Kr26jBGqo
	 PyuTWKjCqrucB6jk5SF8FAtrYBYKKYQWgb8IIpxAdoUUmH8h5QZEfWxbqxKzT+G1XG/tuIq5KGmE
	 Qd8O0u2DCVoeBSUgYwNjtfWnBU5Tj1m1dbvC9uGtIzf/TIpiPCZK258PsEzIFjR0n6oFkurrmr8Z
	 qlF3wB37M1LHAjI+k5KcRRLJ3mxwF+q+qfBaHugphCvKC+yDBkRDYVk1/pqgrGHDRlGvvdLGwwFI
	 ac7ddtl/2oPCgptKidIrYizHONaqWFUZbKCEAh/r6eqxOKa5eJhWEm4YsToumCcmnZdiIa3t/Yso
	 0PCWwDhZGmQMjs0T0s9Tnl2wH55hjkDJSs8gOeIbCNmN/3xehJzrcfeLq7efAwm/TILWBgcfCKLH
	 M/lZZr1glIOtiOObuLQcO/dbOKhtM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org
Subject: [PATCH net v2 0/2] net: dsa: mxl862xx: bound FDB dump walk and validate BRIDGE_ALLOC ids
Date: Sat, 24 Oct 2026 04:40:04 +0800
X-OQ-MSGID: <20261023204006.24923-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Here is a v2 of the two mxl862xx robustness fixes, reworked after
the sashiko AI review.

Changes since v1 (https://lore.kernel.org/netdev/tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com/):

- the walk limit is now checked after the "last" test: the walk
  needs one read more than the number of entries it reports, so
  checking before it rejected a correctly ended walk of a full table
- macro name, error message and comments say "conservative read
  limit" instead of "table capacity", which the exact value is not
- the "growing kernel memory without bound" wording is gone:
  entries whose port id does not match never reach the callback,
  which is exactly why the walk needs its own bound (the netlink
  dump skb never fills)
- BRIDGE_ALLOC validation now also rejects 0xffff (INVALID_HANDLE is
  documented but never defined; the MaxLinear GSW API uses 0xffff)
  and ids already in use, closing the duplicate-FID collapse
- Fixes: tags added (both issues come from the bridge offloading
  commit), self Reported-by trailers dropped, and the comment hunk
  that v1 carried in patch 2 is folded into patch 1

Base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984

Zhang Hewei (2):
  net: dsa: mxl862xx: bound FDB dump walk with a read limit
  net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 1584 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.c     |   57 +-
 drivers/net/dsa/mxl862xx/mxl862xx.h     |  343 +++++
 3 files changed, 1983 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h

-- 
2.39.5 (Apple Git-154)

