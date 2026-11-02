Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625390;
	b=ese1Wk+vur6gxlHw1sZGCJlTaf2qg5MEhzxtb1nv/gifJBrV3cKEH/9YHFgjzEkPzaZ9
	 Uck1zEJBLEVVDI3EtUvQCaewse0iQmkQn6QHZ1pWQa/3W6XuzNgT/rmeDg6/6Q0vUVJTv
	 Ulr6foUPOalIp1l4uU4fQZIwRgvjn91bNJOrVlb6IchvhWQYgoXH0Rokw1gzopzEEno1C
	 lfsBOAHd3+UGa7ZN10K8M4+O2SRCgrmZidXFaIXvGFInp7kzgKVYPEElqITjjJzasygyY
	 yLEly1De/QWCVed5LZuBAMud2pm2LL8Y7c2qyHbdEgVe7t3qYNVOHHDqcUG40FTkK3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625390;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+RBEZku2BTxh2Tsuk9qsqTna+uYNy6fFCXJNUfJkCC0=;
	b=HYWLjgEBNfvW9LlwlfSEqGtggHVlOaIMNQ9X6OG+NA/j9SueZJU8QIoNwF3FZhP3DDOn
	 V3aeAVLfMd5ZClnUqXZ5SslPzntTHJl995BlzXxFTvkirzjRZHsSyvaGruiHPn98cEOyA
	 hdbmi+PDfxHKeIE8NYX+I3Ryq2TERftBooYvuyhaFiYFqfhaJ8cdk3yXF1rOZXnmDX0wT
	 0CN/RcKkAoE9EvEi3F/LMbyoJinrEzgimXLpvnhcfJrp4AjJv+E/SaHvoz0++p25T93p0
	 bmeD81QIjDym7aRpZoXnlwUy6MsjdLRUUI3IsnkxrwVVB0Kx74rEe6+shsiEFJWgrcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PtwM7tcN;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DC606A324;
	Mon,  2 Nov 2026 13:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C2DC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PtwM7tcN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+R
	BEZku2BTxh2Tsuk9qsqTna+uYNy6fFCXJNUfJkCC0=; b=PtwM7tcN9iMAa8ztLR
	riJbkErUthBGBAHlkaSUJIuWARtDTbaLXQVKHWbMaQ+U5Vr0EjpTRV/nHu/LQglq
	1oqklTavkU+XghOqhbdWCE8XXAhSAcbpGu+wCMMTFvOCQFkbeA1LsnIkRA/h8fcm
	V8b8EUeGtgHZgIqZmJFk2rAXY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3dz_ajOhqBgW6CA--.35094S2;
	Mon, 02 Nov 2026 21:15:07 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next v2 0/2] devlink: do not dereference a missing param item or shared buffer
Date: Mon,  2 Nov 2026 21:15:03 +0800
Message-Id: <20261102131505.611343-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3dz_ajOhqBgW6CA--.35094S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18Gr1fZFyUWFyxuFyUJrb_yoW8ury7pF
	W5WFn8Kr1DtrW0vr4kZF4xZFyY93W7G34aka4rtw1Fvan8C3s2qr4jqw4aqF1Yy393Kw1U
	tw13AFs5uFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULo7NUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRsuBWrojNtRpAAA3F

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Two devlink helpers look an object up by id or index, warn when the
lookup fails, and then pass the NULL result to code that dereferences
it. A driver mistake (a param_id that was never registered, an sb_index
that was never registered or is unregistered twice) therefore costs an
oops instead of a warning.

  1/2 param: devl_param_value_changed() hands the missing param item to
      devlink_param_notify() -> devlink_nl_param_fill(), whose first
      statement dereferences param_item->param.

  2/2 sb: devl_sb_unregister() runs list_del() on the missing shared
      buffer; list is the first member of struct devlink_sb, so it
      reads and writes through address 0.

In both cases every other user of the same lookup already returns right
after the warning, so the fixes just align the remaining callers; there
is no change of behavior beyond avoiding the dereference. The param side
follows the example Jiri set for devlink_param_unregister():

Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/

Both Fixes: tags point at the commits that introduced the unguarded
WARN_ON pattern; the current devl_() functions are pure renames of those
originals. No in-tree caller triggers either path today (the audit is
part of a defensive hardening pass), so both are aimed at stopping
out-of-tree drivers from turning a driver bug into an oops.

v2:
  - retargeted from net to net-next, as Simon suggested: with no in-tree
    caller able to reach either path this is hardening rather than a
    critical fix. No code change.
  - collected Reviewed-by: Simon Horman on both patches.
  - the Fixes: tags are kept so that stable can pick the commits up
    once they are in mainline.

Link: https://lore.kernel.org/netdev/20261030033332.3685172-1-xiaolinkui@126.com/

Linkui Xiao (2):
  devlink: param: do not dereference a missing param item
  devlink: sb: do not dereference a missing shared buffer

 net/devlink/param.c | 3 ++-
 net/devlink/sb.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

