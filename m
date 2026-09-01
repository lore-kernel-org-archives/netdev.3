Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC138F926
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264458; cv=none; b=b0gxqdVA9mlK+IoojEdCxP8ngsAykvbfVBD5ZwSLCZ+aOE7U9JzcMtWBnxF3v1C0R2sD71zy61IMHJB6rQVjKeaHq4G+Xq+vlqp9sFrxbk2sERIs6XJwE2xzy2h48P6a7wxQHbRLXOcmo4bgGczAUQ07w2mvycE5zHu/Y0L23So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264458; c=relaxed/simple;
	bh=ksAbz+B0pS2tsxtSwHB1iSS9zQwp+Us2OZCC04wZCHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RUlzLYjFllxKiiHgkpHe3NYY80J9J5Ww/oystTmcIjnS2JWAjQ3j0oTro0swU8bB6vCcF5QxAvEfFqdpzhvjqIqb8hDIDYd29KSuVcHnJT9OhLooFpLKBiAbBjw4UraEf4WNzL5/sY2XgAwA744lzSC4KS8cZEa1jHs4kwTlC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Fu0ooPSp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Fu0ooPSp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e2fdf5abso2241234f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264454; x=1788869254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SlLlvMrdns+nyLoZQvdODsJ4s6K6WZzEbSlSJroGQQU=;
        b=Fu0ooPSpBRWMHI8XHn+SE9zfSzSxq9ZiYZmX5AvzapXne62wN4bnrtTnZioe8O02jg
         R4HUHKfpGjzYEdVDzL3CTwKJ7u7SlHvkxDGiVlAqG6kABwEXszv8ajeDqduyF0EgoxP3
         DSlYELmvoXEcfthak64u6oNNfG5/U0huigiZqR75A72oEcJH8B2XbqWqtKT/N14ZFAR9
         PLho7zRCposXDYHSPynWfgqRglI1k9NZA3VQTjCqpEFlVmsxvIKgfqR5wz5uCqq+HRGT
         iruxiXZ2JlPXqepTt7P7KY9Uja8wJ1B2ljXYiRUbunFMw/niwFXCLoPhLU4BAUZZvIoM
         8XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264454; x=1788869254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlLlvMrdns+nyLoZQvdODsJ4s6K6WZzEbSlSJroGQQU=;
        b=T+nOknSArDeTg9+iX2CFEUYDSd9WTv6X4JiecuTIqE22sc+Cr6WhD7pPJpoo3wEURL
         BH/47yaXqWFSO6/B/pj63tj6mAiKryrfZa4A6RjHAX+RZ1VDRgLvze4QD6B7gEiUs0t3
         uS/fjaT1dNebQis7JHJjZ7+RYbBy12VrdGOa6GDazN2+hr8/348woarYFAc2f5q9dpua
         5jt1GCxQjQZ4NapLZDZJTKe/tEmjvBl2YcFkuePagrK8T0n/R5weSivmYJHAr4RwRB6K
         zmVRABAveK4Hc0f3w8H3R3LTaIUWK8gFU83fmO9mDkj7vnR10aC1MASuEIYaqchoOv0l
         3jYw==
X-Gm-Message-State: AFuF++mWntkBNXtbatTtCDXyB3thIKZlTLm3n72kjAfF/PnaQTyzhfxR
	4Rz4wtR+a/4Vuf4sQ1aq2VWwFzHt+BrH7AUhKVxFzVAsUD20fjQ7onHLdjbQpYReogFXwPpUG1v
	B1DdbIgZjRA==
X-Gm-Gg: AYBFou1/NIvl+ZMLeHTtfDyW7BzFcPi5G9uwITFKfLiGqzO0/MrkeSGFVjhy9lY3y2q
	ZU3UVUCJsR6nfmxVnq0ouWTAmq0xezt668V7uPG77SpBnE7iEiJrthIo1aRWC3VbwhKGBSIT4ky
	NphWv9fIxTrAEpkRstikIWRTjTITz1PDj+9NqdpzWAuYPn+QlGOgfi23ivxiFe29AUDka0Li/oc
	44EhRgTX5pyKsqPgh+nNSM50h9o5F4j2YuyHJ4gq6wLlKAw8+jvDg6qh9ie4yyLKj8V4xswcdAM
	9LBJUSj37Rqldy0ylDTiAH8G0bnWFcryDdNdad4eZOg4Cqez6gSlOfyVJE/b5zdVvU+tftfB8Z3
	kb9h94MHYakhJp79Br5drz5DIFLu5j0OThkwYzrNIxRbq5YjKQ/9Jo7p7vKafoAalFpIuw6MHdp
	/TFsH1l9Wbi3hBLXi8tX+UV6wIYtBQXWin2+Roz51iCMmhX+gCyewr/zn3RI5l8uJ8ePxNcFr+Z
	u9aYjrl2Sw=
X-Received: by 2002:a5d:588e:0:b0:484:3d59:5df with SMTP id ffacd0b85a97d-4843d5908e5mr20598245f8f.2.1788264453640;
        Tue, 01 Sep 2026 05:07:33 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d7e70csm4278875f8f.36.2026.09.01.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:30 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/9] net: bridge: vlan: minor cleanups and annotations
Date: Tue,  1 Sep 2026 15:07:12 +0300
Message-ID: <20260901120721.747908-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
In preparation for a complete vlan fast-path re-work, this set cleans up
a few minor things - removing legacy code barriers that don't help,
                     annotating lockless accesses and using proper helpers.
No functional changes are intended. Sashiko will find many pre-existing
problems, none of them are related to this set. I will try to fix
everything pre-existing separately in -net, there will probably be a few
critical items. So if there are missed places to annotate, or if there're
actual functional changes, these obviously should be addressed in this set.

Thanks,
 Nik

Nikolay Aleksandrov (9):
  net: bridge: vlan: drop legacy memory barriers
  net: bridge: vlan: annotate lockless pvid use
  net: bridge: mst: use br_get_pvid helper
  net: bridge: vlan: annotate lockless vlan flags use
  net: bridge: vlan: annotate lockless use of private flags
  net: bridge: vlan: annotate lockless use of num_vlans
  net: bridge: vlan: annotate lockless use of msti
  net: bridge: vlan: add missing tinfo.tunnel_id annotations
  net: bridge: vlan: use br_vlan_get_state to get vlan state

 net/bridge/br_arp_nd_proxy.c   |  6 ++++--
 net/bridge/br_mst.c            | 12 ++++++-----
 net/bridge/br_multicast.c      | 18 ++++++++++------
 net/bridge/br_netlink.c        | 10 ++++-----
 net/bridge/br_netlink_tunnel.c | 12 +++++------
 net/bridge/br_private.h        | 16 ++++++++------
 net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
 net/bridge/br_vlan_options.c   |  6 ++++--
 net/bridge/br_vlan_tunnel.c    |  2 +-
 9 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.47.3

