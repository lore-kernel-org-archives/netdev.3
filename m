Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8C501F32
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566858; cv=none; b=QMISTDeFPVOdoCSCXibRSanpfGSdG9sUE0Mpb1BtQAF8BXvuQxWraBX4FzYbhvqNRLMuGVkferBxBxZPtsMZnieRR/iXe8IThMhsVVYK5ha4bqfVr3ekiC0v6WoAfmBWLNytehL7WZTcCVPEN4iYE36by+yxMHUmXFetepGazSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566858; c=relaxed/simple;
	bh=gaP3oZ/AnBH8rs+Ktf9u2PAyvt0WSCNjXDKQ1OyNg/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjhKKrSSoIzkRohwBn49VILF6ePte9fA09bpCnHaCVgxp+wNcgLppxKmLIuf5xIVlLBt1jGvNG0ebSBZeCAc2IE1+IMJcxFPhn917Fy5jL30+w5TDr73knPrrPdY2MdBnOvb0d7osCuCK9zGhfr5N735S0KNZUlKmKm77Hyjges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOg1Udvd; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOg1Udvd"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2db33361b2fso38663405ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566851; x=1790171651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qc/rLQY/xgi48oS7JinasFyBURKLxLOAJ3bkaqo/Vho=;
        b=YOg1UdvddSDhe9z6zxDSedHQZT1oyNdfcXHU5qxjrEj/NhwU9Az0pS3lcvgR/lpqX3
         vLGndEKINmFmmFhi5e5QqxnobqeOEp7r7LgpH/xAbmyAwS/S8iTVCl2WDuHdTC3/zHNd
         ehkl4HebKmn2KPV1KJEANGEoe4OQ+ytnyTERrDTdB4iF8z0RdRbBEy4f+UCuGuk9N3aY
         nNhmetkZxci9nne6tuej87d2LIa1myqpL3gAkPmauG/AA/ais4NR5qZMpqTJ5NsW7w8m
         7khSe0Uruz2G3zwpP6FTancqnsNOVixmTnlvtsad1uMsRgEz9yOneltdaTz4zfiEQTJ0
         tAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566851; x=1790171651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qc/rLQY/xgi48oS7JinasFyBURKLxLOAJ3bkaqo/Vho=;
        b=Of/hw0VjrrlgMQEbgxh1qj6HYZpb/gt3CkA51MPRWr3TdZhHv/wojPgTw3iCBBvNhV
         MI20dp/Vq302pl1taWNdnKGzdO+RmEUwyM51KUulKUGcK7n2QrJqCNMKqZ5j/vBbX4NO
         2zmDGXyScTQ5Q8JW6i1TeNWRnPtyLHCMekG73NTGrLxKM3f5APuaT4pJ/yqUD3WhyJp8
         AlcJKgMr6V9LKjVzfRmEwiXO16jaqdDoYPbWTmqcpdNM5rclqlMkCiAB9muwDPT5N1+N
         XYUWHtf0hkzMHI92JTSugoi2dMZlqbHFPVi2KfkOVgCyTXm8V+27z+xh5QfYIjY5VCav
         k3gA==
X-Forwarded-Encrypted: i=1; AKwUvBy79FAUaMoFDl34Gfc3/v+TXMpxiVLZAFhFezJLzzm8RORE/Kg3X7bEDWo3mr1TUKIPmWBwaOs=@vger.kernel.org
X-Gm-Message-State: AFuF++kP5WNq5ejc+udBD7w3islSE4zH7aTfDSkz3WUjPiQgab3NyFyv
	OsKWmEdem6+u14JkEIAZX6Hvh7+S1fVJNYMLIvbZd0FQe7Whbyho8Lwl
X-Gm-Gg: AYBFou1rx9Y/dLZDKXmjEohfd8iHnf4L3RwU7WFkaGkKr71XBiZ3yuuHSJ4ywpTa99V
	BcU2ErVWGfbQPhC2U7YxS9zNe0GbpXt3CxiBlDMSPCU0qzLtumA4yfst1i436rijsper0nWA6zs
	aCwnP6dXPuF6+nu1uri4tbcZWOFcFFNKyu+Oxyqu0fp7ZxjrcaTGwRcMDOmsz1kWPAEgR+Sj9Bi
	fTht5KooOLYFPwOxCQG3sdilZxgzsX+FAanjmRBNXCbwssfd78QUmhlGyiFAYHN+B2S1OWEz3XC
	+P3kIqyfhyaiijk3Ikw85cgZ643Lf5p9gq4j2UxEyMVRWl8H93Fn8jzL11bxdPFwWErDyTUgO3J
	oUJzK6/woi1adyGT97VIMwdP1lyYtIdONzU7WFhzCyHW/dt8GEAqKUKbsgB3eW1n62QvBV14xWs
	/RIyW5Wvap/DRvtwREEgn0gbGa2VJS14+kMM1uNYtMfTBKsXiN8IoVbnAYRg8nprrdilYwK6wq8
	oA4SPLSbFq4n9vqxSR4qSiRh7lsZNBF1yodvB+U/fYizarKLtA=
X-Received: by 2002:a17:902:e551:b0:2d6:fee6:65ae with SMTP id d9443c01a7336-2dd8dd0a955mr59563295ad.4.1789566851371;
        Wed, 16 Sep 2026 06:54:11 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:11 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 0/2] 9p: handle long directory entry names in readdir
Date: Wed, 16 Sep 2026 21:54:01 +0800
Message-ID: <20260916135403.15789-1-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dominique,

Thanks for the review, and sorry for the delay. Here is v2 with the
changes you and Jan asked for; details below.

A host directory entry whose name is longer than 255 bytes currently
makes 9p's readdir fail with -EIO and hides every entry after it, which
is how this was noticed on WSL (Plan 9 shares of Windows drives).

Patch 1 drops the copy into the fixed 256-byte p9_dirent::d_name and
uses the string p9pdu_vreadf() already allocated, so the listing no
longer aborts.

Patch 2 then skips entries whose name is longer than NAME_MAX instead
of returning them to userspace, as discussed with Dominique and Jan on
v1: the VFS only enforces PATH_MAX in verify_dirent_name(), and nothing
can operate on such a name afterwards anyway.

Changes since v1:
- Use my real name in From/Signed-off-by (Dominique).
- Split into two patches (Dominique).
- Reworded the subject and commit message of patch 1 to describe the
  existing readdir path and clarify that no allocation is added
  (Dominique).
- New patch 2 skipping entries longer than NAME_MAX (Dominique, Jan).
- Dropped the bouncing sripathik@in.ibm.com address from Cc.

v1: https://lore.kernel.org/all/20260826064819.52523-1-853555@gmail.com/

Haobin Wu (2):
  9p: skip intermediate directory entry name copy in p9dirent_read()
  9p: skip directory entries with names longer than NAME_MAX

 fs/9p/vfs_dir.c         | 17 +++++++++++++----
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 16 insertions(+), 15 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.54.0 (Apple Git-157)

