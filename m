Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BF4ADDAF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088440; cv=none; b=oOCJBlSlFk8IWWdL43unaMEZtmxZXQUKF6Jsl3JMzheWBM2XJPv4JpPJF621Tkfhn4pjyLSU6NuKTw+34v26Q9XQziGmURuMhRaNWF1aNoQAC3BybpmUWQk1wDWbCcImVaW7sTXJhDdvItx6S3QAPybCaxE7loCtdamKRkW0Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088440; c=relaxed/simple;
	bh=cNsCaAiyMSC71nT8JGaQxRwOoTTxzgq9htUBVnX4oq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWgDSOB6UHYAmx6RaR8YtZqooYNeRhnZf5+n9f8EjMGfbNjFnaRObs+Al/aIgxBMuPP/rwMboWSjXu2oVSzk2VY0FaO06b2cHwCfCMaTfP+0KSWyR6AN4MXcvMwmMmGOjZ/LxzgVJSG/TWb8tY5+aQQ4iGhuH8B8hF7RD5nGyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQL+NV/e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQL+NV/e"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab39b111b9so30108555ad.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778088437; x=1778693237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PEVltZsn31WcLHjZc3d910sZos9grkTj6lR1cPeZe4=;
        b=PQL+NV/eIyxwpj975M4bpcI63zxgeLH9gibjTfnBF/PvQhsicHGcvyfju8rTdAxAsZ
         gtUAX6NzBDCuLjeXRThM3KZVubae3s4H76aoxjxxCOZs5jQD2y+55WrHFeFcwGg7voL1
         WTl8qWEWyqMtF1ALWHO1P5rm4XFoXrlu+yVMWeCZuy0QHeb8ZAAJEHh+f3JraS+fkRsf
         5q+f2j8uMNlbmuKzPHmD7tOn3nW7IqMQGtBtUmql68xwtGHyrkrujuPiWcaPqY35e9Im
         eIZDLTrpAJAWqDA0nlR8zE/PseuVGZ6JRSUDooSqSM7B7qJHukDZy2Eew0Q1s287Wy0f
         p4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088437; x=1778693237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PEVltZsn31WcLHjZc3d910sZos9grkTj6lR1cPeZe4=;
        b=HQrTZUAXcVEtxFrzIlE+qJ9HIIExR2lAMaT681zN3W0aBiKhMvrF40GEE8V6cQL4dZ
         Yz9D9lFIxteReywMtVpFztSh5eXbxs96mkZ0v0dSqLNa2Jz3vwAW9CZdn/OU7VJvgY5h
         /COW2zGliEnLSC5gNlNynZL1zey7mQz+I2YcHkF56RFyRdKiuaKJ8B10NBjPELvAVuYE
         jUgdaOpnDOeM+hoG8vcwtn7RZMOcJtjTDPgm5Igeu1NSGlwHDomndJoHRO/7wTMPYzOl
         lF1VoH4YDDtjeVWSHyVm3DgWfZ/23J2w4MhYgsL2l9SkavFSBWJlf3VRlTXDmPCttyJa
         /Niw==
X-Forwarded-Encrypted: i=1; AFNElJ8TKLKg+BBspR6HiLo7CwnhOgN7+I4NCXvqfq1W2wgniXfCzP53Dr5735TcReI/Zf2zP8ylLf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVGY7Ey5p5bUktFJBsn0VD5HwMGKU9513ug0l6JqqMz6Zk9rs
	Mfy8835jG0P90jGhnDg9QrCInyVZ506hfQ5tUPUpQ1iJp1CuzyhwcaDudpkUU9qs
X-Gm-Gg: AeBDieuJ8/ubVhA/PXVPqxW1/zA0fqMBOZ4/PkdULTBHqGPCo+9vMWpOIdhdBjMmirB
	a1rWeKaYmj8XM7MLKDnhoQnCy7fGLpoanacLmN+5Tn62sTg0d6mS3x7YCQnYhr9kepbcxi3RYCa
	BExDPUpsh3QQAn/ylDbzpePINXhqH4JNQvH3qBllUC8dJsfCo5mo6Ce6IxyLageX3SsL+9YU/B9
	1encl8CzeN3+gUe36tfbKaUqlwrRLgX0iwzsxxeWF1105MOxi861g899z9AJ5QNGZvDeRcE6avV
	dN9MXXvZ5xd2T5uYGrw4fqKbWOYSzt/S8Rymekt5AvfxF66rs3OoBLp866SVZR8BCkVTP22XQ+D
	rWqpylDWHS1T909IF8R5b6J7L/YYGZYoiAOdSyInWn73ia344b2b54lrdkNBUDJgWpRe8PccR9p
	+DgFiKzoof7V4mr8Gh3aj8j/AkrNqEBs9CuxtKjhQzfvpnnhikjS3FM+cKTSoB8VAyabGiJ5Ppq
	8m6M4PIp/V/Fh4=
X-Received: by 2002:a17:903:13ce:b0:2b9:fc68:d8bc with SMTP id d9443c01a7336-2ba7881ba37mr47008655ad.0.1778088436995;
        Wed, 06 May 2026 10:27:16 -0700 (PDT)
Received: from arch.lan ([2409:40e1:300a:7d12:5c:b984:20b1:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca244dasm28828955ad.72.2026.05.06.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:27:16 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH net-next v3] net: bridge: replace simple_strtoul with kstrtoul
Date: Wed,  6 May 2026 22:54:47 +0530
Message-ID: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple_strtoul() function is deprecated. It does not handle
errors or overflows correctly. Replace it with kstrtoul() in
brport_store() to ensure that invalid user input is caught and
returned as an error.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
v3: move change log below the line and add Acked-by.
v2: target net-next and simplify by reusing the ret variable as
    suggested by Nikolay Aleksandrov.

 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..cdecc7d1260c 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
        struct net_bridge_port *p = kobj_to_brport(kobj);
        ssize_t ret = -EINVAL;
        unsigned long val;
-       char *endp;
 
        if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
                return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
                spin_unlock_bh(&p->br->lock);
                kfree(buf_copy);
        } else if (brport_attr->store) {
-               val = simple_strtoul(buf, &endp, 0);
-               if (endp == buf)
+               ret = kstrtoul(buf, 0, &val);
+               if (ret)
                        goto out_unlock;
                spin_lock_bh(&p->br->lock);
                ret = brport_attr->store(p, val);
-- 
2.54.0
