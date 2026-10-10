Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86D26FDAC
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614898; cv=none; b=q8naHeBPh32ax19LNgJ7FJd11IZRcKAMakD56T76VeoqQro8W31ufwZRTpn/yJ5gzPs8RQHqk4EirudddMcHvkqGn6bKQS4JKisFa+lD/j7keM6SeJRmn0TaGGvQ1iT52apKuTy7ljH2VOXWyLi0JQA2qHV0wuvac6VRL6404Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614898; c=relaxed/simple;
	bh=5L5DxwVvnvUWNH5IP02RQY8g/fqYMrFIez+ufoPDWCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KER6b9l0OHTYApQDOxPwHLk23Tr5KATWu8a7mGsC6g53fFeG1sNUS2/lI0NYSY9Ueg49pgBd+QWuAZeWOiST6vii1VuK7UEgQC5Kcx/34UpMrBxo8WXuXwQVQPgRNApIEm2EzYGq2+xUXdZ1G0UbjNqSgEYjRgSy5Mcv5HUa/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eomXT2Z/; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eomXT2Z/"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so164797a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791614894; x=1792219694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R3rH/D6qM7voVS6XyaxzTyltsiNIVflM2CckMW9LdmQ=;
        b=eomXT2Z/zMb0XUYnzXPpEVw6gZbc+qXYi8jPIseSscmUR21AqGq/PM3Ib71m/0TVx0
         ScHzwZYB6i9gguXwugb8QiZ0fP0O4JbronAwLignYtXs8nms2aslyjobxy+qwIowusqR
         HurYbkeppW2LZqbEt363C/Z9yQbEIhGPUHeaDqsmcV0pblRXW0h6wPzsi6OpcAYODB6o
         3KB1rpUR3B6rse9BLjGQ4MSly93AK5hs+uxkWFVHpf6KYxgp5bXd1h0JTf2pJSun7nFX
         Bowp7wJI7XKUKMd4NslQOFH5CddSfUVdKfFi26ic5eamkZgkMKdv25pwGEJwSqzYhe+d
         qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791614894; x=1792219694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R3rH/D6qM7voVS6XyaxzTyltsiNIVflM2CckMW9LdmQ=;
        b=zMyAYTp5jwKcuFulKJmvvsOREhQEQXk7zdSodEIxz38cFoB2jtGSWErTvuiHA/vkGj
         bX3x09T5azTPGN4ODT2sPwpNn9INNTDHZo31czoCRLYiW0Cwo7HgWfwouJsyzDTArb1L
         NIeRe0TdCWw7/eex2LlV8sng0FaEvaxCxMIJ3+RUz/Rw5yrL1ixtGa3jUSMCZcgk04Ya
         HZH1rCRDZsAzHVjVSwCyrVR/3CfIzwcM9xz3X/CdycT4zVtsTm/lVEhCvdgCYINNG8NK
         DZqVLiFtF66f3twkxZBGRDa0GL6TIPr0V3OJMO9BN1tDyEynism5LeZ8MD+78BRvTeqi
         XsmQ==
X-Gm-Message-State: AFq9FYKTkyFR2oH0rszE8CFd+Dd8IcXVhVvHCnU+3Zd+hxrTwZ/COqqz
	e+GMNKg4u0gGuXik1zhc+kn3xX1LOOTKVZQzVuLr6aR/nBbmk5aTb0bq
X-Gm-Gg: AYBFou0qfV0P6j8fqcvLx4aJRHXyzGuatZeuzCip81rW/fbI1RdvvAejTS8piVWSvyA
	91gB78ruRkQHW9TJx+HgNQpNY7EBYTX9opfoPgqFElI+Io5ZQIrEq7Gv0zARukRDuYI4HmPXwpY
	w3awOuaMkLlsw9KKbsXCFVAscN3jtJeB1pbdBKDA229jBV2jzjYT8bN0GB825rI6nbvgQdY1ZUE
	akRLeSEf9SZlWeqDoFh1Mn02m9b8jx8w47/HH51HW7TDmaCH7dCtcTfAQ5xwog+W0i6PnF144Yx
	x88guQpjyfMtj2qPdwB9Oimkkw79UPxACQrFfpITuVbINB7n0YNaBCU45DKQNb3x75isoRX177M
	pIfbxgSg9oiQrSFxFZN+08F4F7yXn3W03eRCBlXkvcuhAc1EgyAXOco60zbo//WmMXpQ5ZEuqAo
	z9j8jB55r7DqIl6hQjlLdTPaByDeNwwZWa8Jtru1RuhQa/F0rgAyvFDlnecWHd+YrfNGHC8TEkA
	A8kwH9fiJ7XxI0433NvuaVcKHLNLAtUZFHQCccTrq+7iJ+w
X-Received: by 2002:a05:6820:16a1:b0:6ca:5f4d:318f with SMTP id 006d021491bc7-6ef0d8173bfmr2975799eaf.30.1791614894240;
        Fri, 09 Oct 2026 23:48:14 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.41])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385ba23csm3864752a34.7.2026.10.09.23.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:48:12 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vxlan: reject appending a remote to a nexthop fdb entry
Date: Sat, 10 Oct 2026 14:48:02 +0800
Message-ID: <20261010064802.2741221-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_fdb_update_existing() guards nexthop entries against nhid
replacement (nhid && !f->nh) and against nhid-carrying NLM_F_APPEND,
but the plain NLM_F_APPEND branch for multicast/zero MACs never
checks f->nh: vxlan_fdb_append() happily links a remote onto an
entry that is backed by a nexthop group.

This breaks the "nexthop entries have no remote list" invariant: the
xmit path consults f->nh while dump/notify/delete walk the remotes
list.  Concretely, the appended remote is invisible in fdb dumps,
yet "bridge fdb del ... dst <ip>" removes it, and once the last
remote is gone the whole nexthop entry is destroyed, silently
dropping a forwarding binding the user never asked to remove.

Commit 98fc57d167446 ("vxlan: reject dynamic fdb entries that
reference a nexthop id") closed the sibling nh/state mixing vector;
this is the same invariant violation through the opposite door.

Reject NLM_F_APPEND on nexthop-backed entries.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..aff450ff6aea7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1038,6 +1038,11 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	if ((flags & NLM_F_APPEND) &&
 	    (is_multicast_ether_addr(f->key.eth_addr) ||
 	     is_zero_ether_addr(f->key.eth_addr))) {
+		if (rcu_access_pointer(f->nh)) {
+			NL_SET_ERR_MSG(extack,
+				       "Cannot append a remote to a nexthop fdb");
+			return -EOPNOTSUPP;
+		}
 		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
 
 		if (rc < 0)
-- 
2.43.7

