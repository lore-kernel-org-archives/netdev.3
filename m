Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B333122D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608496; cv=none; b=ABsXmN0Z3Hy/OZghupoTJFb0GennB4b+CMcHU7L/yEUNM6AHigoKREw9bMT2dob3jH/s3btGHJBrhT78oZh/CvbaJ927BpQZDNE8TFQ69yk+IgH7Oko9oOSoiv356M73LOkqki/DujBh0sxGSBDocTvIPZBw2YJkpgBCAQ+gzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608496; c=relaxed/simple;
	bh=d7ycfxtxHAQH+Xa/U4MUsWEejn6XkK0ig3Qeh+LOugY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM3zzyzIOzi1t6H/ZsOPTJVOWvVTKJydEvrMDBFJF5ngwrlQznbIEBFHVS/+XoFWtDjqAgGpG1gcJBkMNIRnT49U+huUC3WiO/2qAkgJkKU4h2Uv93B7HMcwTxRhdEJrOlE+55Df64etubIkAa5bdb1UuikyetTHtbnSP4Jci7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPERMQ2o; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPERMQ2o"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3930515a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608494; x=1773213294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jcGv8G2dzteYqN5jx+LlxWUvFTHSalp0bozKSnOTzM=;
        b=MPERMQ2otb7xfLF3YBl5Qzhy76HXX2rr39LWUpy+8PSz18GsBWnqY8rMf8lECEE5UO
         hMgDVKbqR2ixZpUtVVRIEiw7E4wHV4224e1Rffd8nl/DfvHKWCJkq+bGuZCtXCboZpko
         VxLfUbuReznmVLm4/Y307C3RMM1X8rJkunwK0VxVNvpnoZXbgirVlkwf4offns807+kq
         MWzbSlf+c74KqgtidYUx5IgaWUbshlE3rqj0ywdQzX6tcdUtMH9U3n+zQXaDrc5YP5kn
         0YUGqAgzmRUd+gz1lcYu6IuRRzHE+QOLzUCiKTrfCPdf/geRPSJgB1/OZJK1A19t2XNT
         KOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608494; x=1773213294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jcGv8G2dzteYqN5jx+LlxWUvFTHSalp0bozKSnOTzM=;
        b=n/NO/axzPy8kHUYMOHvy1cksE+9eK9GVrTxqpKgMXcPmk7CKa6uxLyiLGyW5hgkLgw
         vDbljZSeJdvLmMggEx6oceWOySaMF/FEOeIWdBOANPkVHYvfvirDNk92smjs6RwXcKH9
         dBDDdfrjOhOAr4Rd9Pu/xWaIke+1kwaIHnhZnFtiDyuAaGvl3nTQBmMe6Buh813Virx+
         +NuAcWxobUJ+fdNueCoa/8IuGGtFDOm4oX6CFoaX44PgHiz4/JD/SOZXgEFEe3SNiVne
         LSD8xSknVnChqAD1vohISbCuXEsorXHn/Pv+KXmjPGUkzsi+5fyRITI/2f0uKRbtf9V2
         CLbw==
X-Gm-Message-State: AOJu0YyJlSZPwfbk/GQrS6nTMPs5C9Tcd7xzdVnQxXrQQJkh4mJRO6JN
	Cj/XJzfJovrPEAI7IlhahSPcUpX35f/PObrZ7UeFgTkgznDCgUJPqCzS
X-Gm-Gg: ATEYQzzSlz/hH1KmVRC4fJr7w39LqLJs4JexPro+d0p2MAGWkQ6C8uJSrJrVLc87jwm
	S0nh8zNGUdajg7u+aX0HOITvgbpuCEBZSALYv6GrBfXwCUM8Riff624xhO7G/qbIuRWwtw6hVL1
	MCmBvcAgEr3NPV32uaMDHwymEJjF8U5cmIFduO6um/sE5KuljnVlmAwWEGPVuyUxBkPYsSlFQu4
	M7NDvcEbnm1kNtyRMr7e7h/GZOzyQoqU8/NPJxjknSU3JGRnloLUTREOzJCapSAseQqzaRb0Rc/
	Y3Bvp0/rHKYG7Ip+arFKAI/EH8thxvmDplIiTDmV0i8I5gvCRB+U1hpwBiOYTySiTOboEOKV4TV
	9My86HEMaEK+ZkMgNtDSavqObuobqqbDiB/KOUxpAT5+bKln4yWPmuDt/60ksgbQ6plsnSt+Tk8
	RzpLtBum981/irCSZWt28sXlaoI9p71dl+fZvIV0LPc69KDx7KYVXEKIZocAac4CuuMPtCJUnhb
	cUHR7JKuaThsSLWAqZShhZqNN1kFeSaM6T2wLoE1Xcg8Q1y6i8O
X-Received: by 2002:a17:90b:4ac7:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-359a6a9fa39mr1234013a91.33.1772608494443;
        Tue, 03 Mar 2026 23:14:54 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:576b:6b60:293b:552b:9870:28a3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa3ebb2csm85731a91.12.2026.03.03.23.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:14:53 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 04 Mar 2026 15:13:53 +0800
Subject: [PATCH net 1/2] bonding: do not set usable_slaves for broadcast
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-b4-bond_updelay-v1-1-f72eb2e454d0@gmail.com>
References: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
In-Reply-To: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jay Vosburgh <jay.vosburgh@canonical.com>, Liang Li <liali@redhat.com>
X-Mailer: b4 0.14.3

After commit e0caeb24f538 ("net: bonding: update the slave array for broadcast mode"),
broadcast mode will also set all_slaves and usable_slaves during
bond_enslave(). But if we also set updelay, during enslave, the
slave init state will be BOND_LINK_BACK. And later
bond_update_slave_arr() will alloc usable_slaves but add nothing.
This will cause bond_miimon_inspect() to have ignore_updelay
always true. So the updelay will be always ignored. e.g.

[    6.498368] bond0: (slave veth2): link status definitely down, disabling slave
[    7.536371] bond0: (slave veth2): link status up, enabling it in 0 ms
[    7.536402] bond0: (slave veth2): link status definitely up, 10000 Mbps full duplex

To fix it, we can either always call bond_update_slave_arr() on every
place when link changes. Or, let's just not set usable_slaves for
broadcast mode.

Fixes: e0caeb24f538 ("net: bonding: update the slave array for broadcast mode")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14ed91391fcc..93a32a368d31 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5069,13 +5069,18 @@ static void bond_set_slave_arr(struct bonding *bond,
 {
 	struct bond_up_slave *usable, *all;
 
-	usable = rtnl_dereference(bond->usable_slaves);
-	rcu_assign_pointer(bond->usable_slaves, usable_slaves);
-	kfree_rcu(usable, rcu);
-
 	all = rtnl_dereference(bond->all_slaves);
 	rcu_assign_pointer(bond->all_slaves, all_slaves);
 	kfree_rcu(all, rcu);
+
+	if (BOND_MODE(bond) == BOND_MODE_BROADCAST) {
+		kfree_rcu(usable_slaves, rcu);
+		return;
+	}
+
+	usable = rtnl_dereference(bond->usable_slaves);
+	rcu_assign_pointer(bond->usable_slaves, usable_slaves);
+	kfree_rcu(usable, rcu);
 }
 
 static void bond_reset_slave_arr(struct bonding *bond)

-- 
Git-155)

