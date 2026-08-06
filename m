Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B468248B
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986998; cv=none; b=CbYbl3cnLNqRfKMYT5jbIDOjS/QBYzkODMAP/OC6lQpR7+099XVQhLklDr1GAy7Yl/VzC81MiREN784LCCF+aKprqrYrpvgtPJsLMf8OSil4cB+e8dG33pm1HmyQ0/JmgKK58MfF6QkW3YzpCmrkCpC+X3ckGG1JY0lue6Jk+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986998; c=relaxed/simple;
	bh=mNTeb8AhLdndI9x9cRA+xL4uJ7EvUDo1kPf4fhiiAtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RpouOG8wLF6qfHHHz/OeQTz6diXTy9cHjnoLS2d41W0td0a7RdJ+fJ4Hmo3nml/FLN1qKychAnknQG8YJYb3No8lgSeQtWmbKUi9ArAR6vzpM6CWEmt2jR4mh88g4kEJAZqW2+QGUmvzVqvvlka6fAi76JOhk/JK/7cJL3tstZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDdrnaW3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDdrnaW3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1496650a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785986996; x=1786591796; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KR6lwebD1jjbs/VxzPpKtBdIVfW3eDGBZKaYrDvtd84=;
        b=KDdrnaW3MLR0P3mTqJ4gjVae97PhHcaVgrm6VScBMEBkh1Q77yGbPiva72G/Y6NYZf
         TBsWwyFULz6NlUY8X6QV3SivUyJZ7EISpVO8JfDZkBqQwR1rtfq6LQj2oxdi62nGSabj
         7EuFKdHWbabv2+M9J9PGjZ8m6tPqF5Kq+nEp0DCL7eAf2MFO7EpEvH/lY41DN2zph/l4
         zakoa727Py/5lCxhevYI/R50WjM/KKNfIJXKGxHWKfBDerVahRN6vrqYlQZhp5SIBTPt
         Yp6ytUN4rxwzJUxEA2buCtms13X5oVvnjJh+1hVmRxGn7TPs2CvMiXEaWbuz/Z4j1ZGE
         UEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785986996; x=1786591796;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KR6lwebD1jjbs/VxzPpKtBdIVfW3eDGBZKaYrDvtd84=;
        b=iKul0t7vWwn803LxskpW+Ot2eDBWOwW956nwKlkkpk+XYoVsMOXhAz76hvtTl6Uxyu
         IPhYWFACfnI6dieoSvrc7Q3l1/fU3eU8DoTnhInqjDGS+qoNOz0elJfO+yWltk6VqqsB
         z86cXLQG+5rGNdzj11r9CUa4tQgzoMWSt4Ib9P/slnW02rqsKSrzpthNXS1EnnlgL/+3
         cjWFYbZ39Aw+lU6L3uTF1ytU5Btnr5OElmew9o50Mro9IQX6EwVOHuAoFUXTdp4Ygvbi
         CjDtsBwoiZcJD6qSr4SatmeRhrUcV77ymuqwgIeIKw3CVxbbp+hgB9z0Thc61UZYVezs
         mO8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpOTFgMBavcuCIVQ7zZNcYOWJr1eFmIlxAUCDUFgPkPWtnO1dmG91aO0fIxcVF7JrEv7qqLAo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSbE/mYZrUNd01CUk8lDOPXeYFVe1kDgbelB94AelDHYq+sOG
	EC0jyRadwc2g85H8LD3igZqbePb/wZcoRXD+iwQGyHHzbR/aO/m5bxBk4BnJiA==
X-Gm-Gg: AR+sD13usxhRxl+EEBDqNvuzlkuW5bDWrfeBAH2JFSDUmIqsPht64kG45K/HxN9XUhU
	/fADx/r0EAhIG7CdtoCUhCxPVDUHOo2p1mxmB85BhVu4bjcyN+wKrnngJaCj6sBEWzk8csSkscU
	s9DY7yWw4UzPOdgkbEHM1+3EauD+8SlUVTkwl4Jd5AKld7Nch1Huv0u0ELGX8cKmg7k3qYxPRHK
	K+DG96Q0tCzqhN8is/jQ4jkmHOvhZ+G82lJU6rtZ8gtxYm8klzFnAi3r4+xJTJ5phNtV7ok5M/1
	3Ersv+Gs4lBWj6XuCY/4X+4ejt3szS7SZIR2CVsACiGU8Oa2/JNKT2H/EJ4J0ryJT3IKGImmRfk
	pN/TzVTqzQu1zH2Fdvr1Y67Y7QKfa7qBNk/KvJiC0fc5pQLMBtTWy5EHJBCrNV7YTZcCLWnTyAh
	Rn/80j1IJKlt4uUcUZw5N/qfVQ9HIt2OCgta0tppNTBYe0GZG0gNtVG2Chjgi6gSBopwNnVRcah
	znDesPnxnyMpR3sVcb8qabM1lQJXVQopQ==
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-3903c5501efmr10058987a91.3.1785986996091;
        Wed, 05 Aug 2026 20:29:56 -0700 (PDT)
Received: from [192.168.110.119] ([216.236.36.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2cb6bsm573371a91.9.2026.08.05.20.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:29:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 06 Aug 2026 11:29:28 +0800
Subject: [PATCH net] bonding: fix wrong extack attribute in ARP validate
 netlink error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-bond_arp_validate-v1-1-3ae005657ef9@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBPMcNCuEhGWUw2EhYYE0d2Tl
 m/x/wOJIlOCrnogUubERyho6grmzYWVBPtiUFKhNBLFdAQ/uniO2e3s3UWi1VYZixpRWijdGWn
 h+3/2EOiC4X0/D36MwGgAAAA=
X-Change-ID: 20260806-bond_arp_validate-359289656609
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Toppins <jon.toppins+linux@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

The attribute of netlink error message should be IFLA_BOND_ARP_VALIDATE
when ARP validation setting fails.

Fixes: 2bff369b2354 ("bonding: netlink error message support for options")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 4a11572f663d..7dc31b2551c4 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -372,7 +372,7 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 		int arp_validate = nla_get_u32(data[IFLA_BOND_ARP_VALIDATE]);
 
 		if (arp_validate && miimon) {
-			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_ARP_INTERVAL],
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_ARP_VALIDATE],
 					    "ARP validating cannot be used with MII monitoring");
 			return -EINVAL;
 		}

---
base-commit: 2a33516f9ef59ad11844d4fc152f889449b5daf3
change-id: 20260806-bond_arp_validate-359289656609

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

