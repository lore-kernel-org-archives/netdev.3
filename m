Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B54252B4
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977397; cv=none; b=ReRpnRa39ApgOCv027duZREFe1s5RhiwIjC9ZiPeAEdWyDMmLtmiWun2lxRS1wPBsAuvQ0YqSMDNZdhY5mns/bvfw1m6VLnzhm1qF5qhiP6+6G9ZgLhzk3q0LK8G3RKEXeJ0Mo6lwNSvotwVL104kBU5oVfm0t5s2vL7ZYe670M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977397; c=relaxed/simple;
	bh=WRRnItr7pg26V/wsrPUd/63682Kla4MReH7VKQppslw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0Iw1IdBDAPS477otUzvJHzg+FsVe0oOhuj/9a4uEqgznzI0yb8dz635qESDmwQzUxmHf3QNvDNWdlbOAHLcr58SuyhLrsdN1F5TDudISRz2rNQr9vB30wHY25sHOMPyn4faVe4ptsO+aRIW/YcXdYrLNeUnyl1o4GJogLcggZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=i5OuUp2Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="i5OuUp2Y"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2891892f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786977394; x=1787582194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/5GT416qLvLcakCe9GiPOyaENUM/ilgobKMMfIItiY=;
        b=i5OuUp2YFPzPRzB+RwPgCqSlbEl1kvKTQLx/ZImRcJCpa5CBmqy5/5LEqBRByJb02K
         3+rc+tJK5GQw4/py8Ahqf0ZtE3dbyDMFpo6xFnZLF6TCk1jYDg0SOsLGc8vICNUkdEui
         tSJgEAFLMNkCCScQhL7YHWabrEQmAXhcpnoRXSNWEfErr/R6n7jtsxl+uQV+Wy2gQcND
         pA5xCSJUSxCerkiA73D4Zq7WQDcRPwtfhy8gt6NBvSznnlyyefH5PPwhubQTixy9wMn8
         mSzJaKaCUbRByJhV+xZ+UTwdCrLwktChlB7EWtB4adYWPiIbVlPJX99HtGcwyxurFOm0
         vdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977394; x=1787582194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/5GT416qLvLcakCe9GiPOyaENUM/ilgobKMMfIItiY=;
        b=Lib74VHA5EWTV4MC9pS3ReEFz+h0x8jqTPgp0HVzhrDY674KlFkEpBtxqmUjaI5aTe
         651OCY3Zh01yhxncy+Mbuaa+MHog75JLMYQOPV6+rUpXPY7Ye2Bop43YaX3Nr24fqYto
         Cz50TI0RosKe9AU20tCLj+ekcoMegub/MR6f4AucVlFLCh4CaHZb3dgKBrt/sbwRvoIn
         kDaoJ4cUmb1NJG8Ef5u5eGh21VxN8uQ2JslRcuBcWQ5hgPnz/nZdlszIlcGzZVkHZmov
         XF6PIFqxjdKxcS7epvEFTDfBRQNv6jUrevVAwwGHCHf1P0yiZMlGTBIoNUrztnO1Tz09
         VOzg==
X-Gm-Message-State: AOJu0YwnanOIA6lvoOBO07hqZqqkanlsug95lB7SoYujA55MoQier2ah
	Kgr3eKhSLkSz29XwB4t4yjw/WtDDp+7CF5/hwSNeXlYgSQ7PU0VPhNDgTT5F80SJHM/q4vk3C6q
	OC1+1
X-Gm-Gg: AR+sD12uEHCCpekpJmfQsOBxyCa01WIwj75HIUpNTPvnaurnuuaUg/FYrEpUlEfQ9iq
	OzVZHwaQOPobCk6LWxqCqmSyL6W+KHLDm/az7giqGcjEnYXBNkjYbQ1I6YJQKW27+WTYAqik+DM
	A9pxZXh8tPgVqvivSssGy40TihsGLeDTmQDhrKwiXbTPlio3WCgAaQ5YR8Q77Lkf5NvkqmSu6xZ
	sKVMETQSUnLFlSj4yuLIRUR5qreOKGdMr+jQdo6PUkL8/hUsU5opPWp056hPoOr6BaTfjLxKItD
	P5Rwn0l+Sj5UciR8dtnHiLnSkOiGdrtM6weYQpUCnuOxYzeWds4BSgonZ0i5KorgPVom6HnbYRA
	Oc7sjNNPh0vgwN5NXlBY8C8Glw/26uK1csBMo/pXkcy1GjtyGmHgPMTJ0rKNSlsNxFTiy3NSF91
	CLFN6DNj86YfEv5teP+T6JgaiFi/8UB1kEFkdSGclAiEnqxCn29zEkniDttNY2ZTqVFiZBegqxR
	hDGhfyZ+xY=
X-Received: by 2002:a05:6000:65b:b0:47f:943a:45fa with SMTP id ffacd0b85a97d-481607c0725mr40944539f8f.29.1786977393558;
        Mon, 17 Aug 2026 07:36:33 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5b816f7sm4128002f8f.34.2026.08.17.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:36:33 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without synchronization
Date: Mon, 17 Aug 2026 17:36:11 +0300
Message-ID: <20260817143613.685769-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Neigh ha address must be read using the seqlock to get a stable snapshot.
Both the bridge and vxlan read it directly and can see partial updates.
I reproduced both issues with running neigh updates and exercising these
paths in parallel and saw partial addresses, e.g. updating between
neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
in the bridge, then checked vxlan and its arp/neigh_reduce functions have
the same bug, route_shortcircuit is doing the right thing already.

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: arp/nd proxy: fix reading neigh ha
  vxlan: fix reading neigh ha

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.47.3

