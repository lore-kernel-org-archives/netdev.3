Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104834EF15
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122751; cv=none; b=OeofJv/oIoA20hWTsjYIz+5RHPfJXWgdVPoDQ9zdfjH8bDmJuBxNne4crp4iGAaaeYFIDlrVXXYhUhsAjRY4fdVAwbnWkg4tCCBVrwxWf0zYLafHfNFocAdRUYugaJHxmDo6KJX4h5/ftDGas/bIhgNrfVIKdi7/aG9kk9Yf3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122751; c=relaxed/simple;
	bh=U+P7L7RsU+ZSjDl/l1O5fa3pTjYSIpnPLBHuEtv26MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npeZm3pSiyyYHaYW00Rx1OYCmc2D9tFked98/yU13N8cAe2hWtgwaw5Up1rXMkZUiGEP6LK1oQ332kkRpeZ0zQnged+7flK6O7YRlH1nQEkc+YHmcVs3jSfvAmuwDc8KW2Uu4eT+F7MehHQJSylrxbWJQnK7Fkx/K/dvz6nV0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/a2lRHd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/a2lRHd"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1641617a91.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785122749; x=1785727549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtMgYKICVpCrEZZyFdSu6fL+vZ3ZRmxkhnK9ZJ4LMxw=;
        b=L/a2lRHdJnE7dVnkgVjrGCAh7dlvsO96QVqTqBByrH4p5W/qohSCxM1y1u+ZnxTABA
         c/hkeObeLkMC/XA5kWcjQLdNj1viEVzmna0xnvGk8eQ3iucYqVEwZL1t/Bf/ZPqXt/t6
         zaB2krm18MjH4S9pDCiSZqZQmBGtiSzO1qch0WR1KfgtCeHcpXZoIV9UqGT61EJp24qt
         Q9anAYEcJOhLYmVk4Ldw7aRGMFfV0z7h1awGZ/eKnFlnmDzcJR97X8IKbSrEyaSzMv9/
         CBT0C7x2Wckt/6wyphikrRW0IQExl/wPlfUFEAOKym/jjmuuBr711woYGgNtByjE0814
         chcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785122749; x=1785727549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtMgYKICVpCrEZZyFdSu6fL+vZ3ZRmxkhnK9ZJ4LMxw=;
        b=ewMMDXs/ZA/jz1MMBaxyxuqV0Yn4eQwvPdAs6LGvGpzfUeUgPEtdN5EGimnV1fnmL6
         9nP+hwGi232KJ7sz/B1z9dXasYMDcImFaBiQUtqcCMcMJk8dsYgpVck+RfjOetNauVLj
         BGm3I+wnrfAhi5Nk5Ro1lZF9o8Rk8WDyckJ+164Kfj0QdWbDZ1ItOiMFxIhhL6szfbD/
         Qqf4RDe1zoTEgc/VTNCWpsCm3iuFsUodj5EbOpJMAQujOVT2gqEvZbkvSw0c/cG5rpts
         fkTHEkIdu2NFTJK/FoWv1ohlo1Dq+ZKf5KJZfzaoL3L9vlRsFh0ff6F/FfMCoKESIMx6
         Yj8A==
X-Gm-Message-State: AOJu0YxwaGulJE6H9Sxd3u+m3u4nvcZ6VqIf6h6qY+pQUJk+XK/ASpTu
	o4DCvNzSne3xiq7YCE/6P+CV+FRp+be+a5OWt0PG4/RIt2v7a2eij73oRi/nqqXr7aU=
X-Gm-Gg: AR+sD11sohrw+RaumeOWrA/9cEY6UuWixZ5LZzfQzPvZJmgCwym3PY82IsQBfVytJZr
	LQ+iska0ke0640uTIyVAXZB3F1e7j0Oiy1/SP8Nc7yjvzmhgRBBJyiVB0y0J0O7lmcJhMoepYRc
	/JY8xYrINdh+3J0dq8panx7eB5JExgC8q3FVEmAtPUCKkXw1zm3Ry9l7LpawbmStGr5JPuBXoUX
	cHP11Ylynls3+o4POLGhWWcEhkgyiuIfEDxmfAD2idDh4f1rQ7x5swagkN5ayD5FM0Fx1KqW2IW
	jg8aIZTRwtEeVQnDFch0hbec4bYhXEP6uOLAYjpmhkIT10AAq/NMNX5kn4OR9xTwVik5mBM/Wbv
	6PbA4Xo956xBeiDnMLyHOccCpqoQUZOZzAPMUMizphyKPBkPx654HqmbWqTBpoh3XApkzBZEq2j
	zb+1mPxrS97k3Ucq1tTtdxVELN4k5xmRBOxLz9vunV9JK9An2gcbhg3fwaUJxqkw==
X-Received: by 2002:a17:90a:dfce:b0:38e:21da:9257 with SMTP id 98e67ed59e1d1-38f2977b2c1mr6617837a91.37.1785122749452;
        Sun, 26 Jul 2026 20:25:49 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951f0afsm2381571a91.16.2026.07.26.20.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:25:49 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sun.jian.kdev@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	lorenzo@kernel.org,
	toke@redhat.com,
	maciej.fijalkowski@intel.com,
	matt@readmodwrite.com
Subject: [PATCH net 0/2] xdp: fix skb length accounting after frag adjustment
Date: Sun, 26 Jul 2026 20:25:33 -0700
Message-ID: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both generic XDP and veth restore skb fragment accounting after running
an XDP program by copying xdp_frags_size into skb->data_len. skb->len is
only adjusted by the linear tail delta, so the stale fragment
contribution is left in place. When an XDP program shrinks only the
fragment area, skb_headlen() therefore exceeds the actual linear area.

In the reproduced UDP receive path, __skb_datagram_iter() copied 1024
bytes past the actual linear tail to userspace, starting at struct
skb_shared_info. The copied bytes included the affected skb's nr_frags,
xdp_frags_size and a kernel pointer from skb_shinfo(skb)->frags[0].
Real packet data was displaced by the same amount and truncated at the
end.

Maciej suggested assigning xdp_get_buff_len(xdp) to skb->len. That works
for veth, where the skb and XDP views both include the MAC header at this
point, but not for generic XDP. bpf_prog_run_generic_xdp() builds the XDP
view with skb_headlen(skb) + mac_len while the skb has already been
pulled past the MAC header, so that assignment would overcount skb->len
by mac_len.

Both patches instead replace the old data_len contribution in skb->len
with the updated one. This is independent of the current packet view and
keeps the accounting sequence identical at both sites.

Tested with a 60000-byte UDP datagram over a veth pair with MTU 64000. An
XDP program shortened the fragment area by 1024 bytes. Before the fixes,
both generic and native XDP produced corrupted payloads in 10/10 runs.
After the fixes, both paths matched the expected payload exactly in 10/10
runs.

Sun Jian (2):
  net: fix skb length accounting after generic XDP frag adjustment
  veth: fix skb length accounting after XDP frag adjustment

 drivers/net/veth.c | 4 +++-
 net/core/dev.c     | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)


base-commit: 53658c6f3682967a5e76ed4bc7462c4bdcddaec3
-- 
2.43.0

