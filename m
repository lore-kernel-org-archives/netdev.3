Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331249;
	b=FtXx+CKoLO3W8Yj4L7TyHhNE+RvCeyqGQ3bijwrQeCcdZZ22KGVAH4/1XlULK5er1ryt
	 bwFgRWk2kRcmIabUJURL7AmLc7i3H7teiClVoP+PUP3Gz7pscLpDwOLLFoAzHj/Ld339X
	 YtdagHjXaxnfdRX/igR/MySAbqWH8DpcWnIau8QVN8g9L49cWQCnp6xUnBjaex2UOOeGj
	 wwwqaZkCGCLesNfOij63QMe7z1DTAe8lFdiX6udbgSMVER2VIiWjyhyPU6WT3+3Iw3yqd
	 9hsvDGLEeV+epuX749Z+384MlzsDGooqrVIySdV0Z5tnPG+FsYooX0h70zWVivnyHMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331249;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8ktqWfSef3AXz7FND5pOxckiQELIeSzD/uEmAhKFSN4=;
	b=hwPbdNaaHlRS0HIpe6MYlZibY3U58wDYcIfe+tE7czIY0nB/PLpMzNktZEABREUcoE0i
	 urYTLXM7iHI0MEUcfiYAOn5npPf2gPe5mKz1FZSv11K2w1jpx90HKA1M2cdVz/7xEuNLq
	 FJVtywXtFOp3jjZHYEkGOGcgibcdSF9+byEfw/IQP3swBL5GXKUxsjOTLfDIP3cCD8xSO
	 9YcdCrM2/QjkhzSzgIh5uS/kKG6I/v7XZtMzpixWl3VjqemlcOW3ld2NiDybDw6HN5c8T
	 a7keR/e9hS9Fo63qeeNY3Yg+JpV1TRKxLSFw/jjRHRB63GOfpIO9CRl8GxrzmOCrUDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eh60Onbl;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7E606A31C;
	Fri, 30 Oct 2026 03:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eh60Onbl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8k
	tqWfSef3AXz7FND5pOxckiQELIeSzD/uEmAhKFSN4=; b=eh60Onblv4hinnKmq+
	YfoZV0QfX/RDhb18lG1RCyvaFKBzAvcsxNrAdtosecIXoTCWm1uWhTuIr7D5uyzR
	oTI7NEB6zyj14xYkwulAoEZN+fVnLd3Rc/iIURZYXAm/idPzvrr4QlSysBrqIXBT
	hCJFEQ89z8ES25/gGnJUcdgYs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXv+kOEORqy4KnCg--.7858S2;
	Fri, 30 Oct 2026 11:33:35 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net 0/2] devlink: do not dereference a missing param item or shared buffer
Date: Fri, 30 Oct 2026 11:33:30 +0800
Message-Id: <20261030033332.3685172-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDXv+kOEORqy4KnCg--.7858S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18Gr1fZFyUWFyxuFyUJrb_yoW8Ww1rpF
	WYgFn8tr1DtFWvvr4kZF4xZFyj93WxG34FkFyrtw1Fvan8C3s2qF4Utw4avF4Yy393Ww1j
	qw13Zan8uFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULo7NUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlQ-asWrkEA86OwAA3h

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

Linkui Xiao (2):
  devlink: param: do not dereference a missing param item
  devlink: sb: do not dereference a missing shared buffer

 net/devlink/param.c | 3 ++-
 net/devlink/sb.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

