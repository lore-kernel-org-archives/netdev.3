Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EE3DCDA4
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524463; cv=none; b=mn5c7cU9eZd90jfvjR1N2TQTmWHscCIzZPY0Tg4elJUXvEVJHVsNND7wro0ErriWce8k2k3BJJlos0X9/m/y0E+1SPz8T8WWZgbR8bN5AQ89ly1DnwYV8lVKE7RUFNcC489BSQUn9XD1scvkFaXa13Wg+eHIx7FXUYasSDMDXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524463; c=relaxed/simple;
	bh=xBQiQgaoUXVgysZwxJNM7zciXxS+od9nQKuTE7CNWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEK55vB1n/WBf1Vw2V4vhqbIpsJZuNBmZ+jBhWJIU7leiEhhq8Wg2dgXaq2ZRwLbzoIlkRP6Ij7T1oYvIHE83yhlCGKia7/hmRrAlX9tEHNl1DHOQL96kEPSGaOzVXdolOs36649Q7+XwCTbS4h7bUxXgDKiU5qGsMh8l8fzsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrN4kgGM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrN4kgGM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d032846c95so31494485ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524461; x=1792129261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Q8ZxpR+TOzA3v6duUxSwH3FZJvTsDsZ5FM8mvYvZbc=;
        b=mrN4kgGM2GBj68nW8vs4BfQtDRnaFKzjjHzZ6n0Umlfk8chrDtw5knsPB6n09tMwws
         4o14+7NavX6seGzF1kjOdqubpwAMayAm2LjO9Gln4VNrCgtJQOC+8vbaY8tVMM29zYWp
         WIPUx1C0ld9cm+vMLnzwKh+TMOVAGBBrJllUEHTZHUA7HfF1Nuc0XKcnJqgovVv56Olu
         osNfyqqesAO65bmIp/AHeMQ7hIhj/CCY4RXDNviGLBbcsdgdMnoB/1L9l/pyQM9FngmP
         HjGziyIDrsDxkaE0A5rTQDmKGJvD8pWycj8KIilYfkoASU1dk1YxHFq9Rt8Ah2GF2a6e
         ieug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524461; x=1792129261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Q8ZxpR+TOzA3v6duUxSwH3FZJvTsDsZ5FM8mvYvZbc=;
        b=hlp9CZTmbvrpd85sTbiX8lTi0v+6xsPqbWfk58UCNyYs6ulRuVYQ3Rbv13vJH8zhgl
         v4wAbCut/5gjwjk1hBz4Onuw8Cawxa8cyvjD1Uyzn2T6/n5nUOkgZ5OYBE8ky6/I9ENx
         3+mtrlRm3hNMB2aLQ9QZ3STf9vgDYUHLglVjEhuW6XFHcwBhg8aXk1hO2DN7M/PZeFJN
         tatFRG1dSC5nUb+VP6BVu5FqWOX0XDXWkWW6PZYFSK4EXOPWbIA4eP9F/6LD4gVRF97o
         0FS/wFwj2mjk7IM7bZGsCK4yemOht8mUgbICGPtcEIvXiaeO0Nec9F57rUwSxTB2vAXV
         d8sA==
X-Forwarded-Encrypted: i=1; AKwUvBxSjSam2GcH36qNvEiWr5qDs3t9RkrKaO9jFjQUTmojYJDEUPUbsqU7Law9tF/HV+PoG1iFIsw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkmRSqGtQh6BCIAO//FaOQ/3WGpgEVuFPNh2tnybIvxWtsVUKO
	RbpYGOJZJui9sWjM8oOn3XVq0AVWigecZQ84dR6gYHYk9e9J/UKsaAdB+GyDHmOQ
X-Gm-Gg: AYBFou2g036Vfuwo/mMR5aMxI1Xc1/kqUIUXS6nFf8LMQ3y8yftt4tyEQGdaZi96fup
	8WJ8JLcRBt0206dFcFuem/cpC40A8WABAZBm9qCS+IGDGIhcbJH9FR+sBMN43rtNQ8tuyghgFuw
	gLVgy8bQ2SrP1ap5h+c95PcRT6kaNd7xkoEdX2GE6tnh4NtGvjHKrto8hU3mers3mXYJL+6VioJ
	0DczbRu7HlsKdev/rPLOzNqGW1iTpNX8dHYRxTK+bolHHMYJQBx9yNVy9+nIyDva2JFL+RNQGCa
	ZHhgX7LDjiyan10/fLhmMA7Dm21gzImleO/KbHX1OuRP6gS4vqIHG6EroreTMiI2u4zqsVRJ3is
	ZrcYtpMr/ZU2Oo0Rq2m6XcJfhwBODAea/iVq2MggvjKif66I2gHFNTt8O20pOd8wyeJlrGNoswq
	n8hALbldmbbOMn59ktvVgYy7juNjR1puPlJTPDRsV6OVsMbVRsyPvAMbxbTh0N3CdmmfeiVM21j
	I3TrsiPtjiB
X-Received: by 2002:a17:90b:56c3:b0:3a9:4e51:9853 with SMTP id 98e67ed59e1d1-3ab3a9a0394mr826608a91.36.1791524461080;
        Thu, 08 Oct 2026 22:41:01 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm2028695a91.0.2026.10.08.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:41:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v3 2/3] ipv6: remove ifaddr from hash during ifdown list cleanup
Date: Fri,  9 Oct 2026 14:40:41 +0900
Message-ID: <20261009054042.272944-3-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009054042.272944-1-4ncienth@gmail.com>
References: <20261009054042.272944-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

addrconf_ifdown() clears the address hash before snapshotting the
per-device address list. When the device is not unregistered, a
concurrent ipv6_add_addr() can publish an address after the hash scan and
before the list snapshot.

The ifdown path then removes the address from the device list and drops
its last reference while it is still linked in the hash. This triggers
the WARN_ON() in inet6_ifa_finish_destroy().

Remove each non-kept address from the hash immediately before removing it
from the per-device list. Keeping it hashed through the delete
notification blocks same-address publication until NETDEV_DOWN has been
delivered. Unhashing before the list put prevents a stale hash entry.
hlist_del_init_rcu() is safe when the earlier hash scan already removed
the address.

Fixes: 73a8bd74e261 ("ipv6: Revert 'administrative down' address handling changes.")
Cc: stable@vger.kernel.org
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/addrconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 77b3b1154d591c..5a7e7129d43466 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4027,6 +4027,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		}
 
 		if (!keep) {
+			spin_lock_bh(&net->ipv6.addrconf_hash_lock);
+			hlist_del_init_rcu(&ifa->addr_lst);
+			spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
+
 			write_lock_bh(&idev->lock);
 			list_del_rcu(&ifa->if_list);
 			write_unlock_bh(&idev->lock);
-- 
2.55.0

