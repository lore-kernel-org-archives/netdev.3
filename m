Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6430BB9B;
	Wed, 11 Mar 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236139; cv=none; b=ggC8uzaAbudajQJNbtE92rJu1ITu/MYmnUFefZG2SdGsTh2Wm6WK0hmz0B5Ovk7wNXmj70B3OMthGMmIUaeZhU2o3spZJOmIxrxmUuoe1lMevtCNjyRyzmzE103b2ZPdKuJsPByOdNKOA+kcdGyiR0QHFMogv9DXivUb11OSzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236139; c=relaxed/simple;
	bh=IOPgxwcda5It1nkM8ihhdlHT/lxW3cnJh5hRHGy/S1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHFQr8Intpmwko0mpyyLe9aW7ByUBAkMPBQgdpYGBBEXlVaCjbPPxgQl4F7f/35L09KxtGZ2OaVmVxyKYxz9LRLWVF4jiFLJIv+8gnh8g6fMh1uKklaO5r3sBH9pGQ1Ol7cwcGbk/FSO7+TWEN1v6fSEBIOFNJNRecQ/ja6uzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=4uSJQybJ; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="4uSJQybJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1773236126;
	bh=6M1HPyNsa7O1ciqD+dWRsxj4btytBjdW/LVJCRIjIss=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=4uSJQybJOGZSi6B0MPyo2kaDnnFX2jEghDqow3S5+EcDqAVF+jAkGFtG1U9QHVGL0
	 eocCQPSgOJpMOkZHjJm0KZbpu2pb5hrn6TC0hmnRIXZE1V6oTEmb5Uptwxy9fH/FWN
	 FB5RXQW/ZWXIJOSp8tIVYh8oRMkCyBIOcO8pPDUc=
X-QQ-mid: zesmtpsz9t1773236125t917d890e
X-QQ-Originating-IP: D705FB7mzJbduPHxxwD2irNmx9F7WnWvsS5FBBLbHTA=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 21:35:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11469337621530296752
EX-QQ-RecipientCnt: 13
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH] netlink: update outdated comment
Date: Wed, 11 Mar 2026 21:35:19 +0800
Message-Id: <20260311133519.688-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NmeX1U/Q4+1CzY4yTj2UP+ogv02si8iAWPq3Gsq5uB94T0f0v7Yp2iac
	lsspMrIpgmRGtkH/gekrMo7JxdH+bbVjgBQs2c4IESAk/qgG4PiDZyW0g1NnJ7nGbbLv8wp
	eCYVqF+6yAtrdzdPKbximesEU5NiR7DojG1uydAsTg4rN2eWkBqmDR8+RZl4vuERyPHs/ki
	pmPjTZ8RwS7Df6PhjzsO2E2LyBPAz5CQvx36XBCA7dOeR4ZfsOf+jI9El3zGlNGyYKivybl
	w/LFW0voxIhAntVyFKczCCbUM3OP9U0wZ/A4Q8cQCVxuL9uFQRtc2Ka1Q8SZvdylSTakRSr
	V1hvUXcjRnfGyE20C/h71X7zzDBR9tN772zRXVkH9rjgUYi2Q/1OPjDNc+KTYi4C5KHoOak
	YbCxDo3OMkAKYzjJ5CKcQeDLMZCRZbNAk2osUijIZJKcnLTQWGyxMe4AusRnWuEAuiK18CO
	bOsME6M69EeBjp18svUrnwUn8pzAopcF/4Wipj1ton6yHG3rvtK/e7Ou6LhbjCbUc3wgfkx
	sBTz9UxUoD6CeVcUji9u4K7BI8OwYHYmF9+DlOnhSey5TAAEq5h4pBpSzepn9RMvfnclShj
	FQi7lWtOjmyTCYVheMpwss0EgvbukPI0XEGxK0PdN+AH2ALFoJ+W2bR+DPjcjva1sdTwdkv
	4nLReGizRg3/3JPIT8dKAy6bV2LlqEe2YCgJhDJl9UY+msALNA73fMajxCwIoIy6l0+EjOj
	TNlN9WQ7vc8RMXABDZ1XndAy+Sje7t+fK9WuMmvL4Jro/PkjgpJFXQn4Dyqie+TTefHS7qm
	JtJ7JlEo+SHJRpWZjNbsiDALiJeeGN/HsE91Bd481Dg8WYdykhUJ1yXjdgO5G4FmDgk6SJO
	JZ/Dcinu5fwJNYBHX85KbAlIBBgO8cw6y2JCOIcPnBK86gFgo/eapFH0ex+JT79B6ymyz+h
	soRx1y/UYca4sBRHxkYCCm7lgIGD9hW5V4mCtwuYZstOFQKmxKtF+yXNt/wYxq7Hjam2GLS
	9O/20TbQrwOoZcvi0KxLzv8EikiaeC+djXkPHbRKzeq11dO5wNqs1k9V0f8HIa6sIu8Lx4h
	BDtglKGc/3qxhsugmFBmeQfbYjJtyrbmGGQcAuPittKrcqpurvfzl0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The function netlink_clear_multicast_users() was removed as unused
in commit 2173f8d953e7 ("netlink: cleanup tap related functions").
Update the comment in netlink_change_ngroups() to remove the stale
reference, replacing it with a general description of the behavior
while preserving the warning.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 net/netlink/af_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf406..018d33af25ad 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2108,8 +2108,8 @@ int __netlink_change_ngroups(struct sock *sk, unsigned int groups)
  * This changes the number of multicast groups that are available
  * on a certain netlink family. Note that it is not possible to
  * change the number of groups to below 32. Also note that it does
- * not implicitly call netlink_clear_multicast_users() when the
- * number of groups is reduced.
+ * not implicitly clear listeners from groups that are removed when
+ * the number of groups is reduced.
  *
  * @sk: The kernel netlink socket, as returned by netlink_kernel_create().
  * @groups: The new number of groups.
-- 
2.25.1

