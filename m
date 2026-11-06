Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934733;
	b=gmEZAhNVeCQYPLHzyTRU2Oh1eJ1hdALZjIFPYB99ranz+qdMAVcqBF3HZJJOTyF6p5yj
	 u0E6NhrvESNFfdB3B++721C3uHXlQQasi8Lb5BdiOVJweR4dsl8Rz/PTyZ1fH90cXKLWw
	 QAOxKZcs2p/3WZ1hlOb4XHulCVDsr24CqP5qm5ZcbdGs975imJGqdEGqPg8rQ3QKBEh5f
	 t9Ea2PbLH4n2Erya/4rjNZw3JVMZd0xX6Hm5DQfhLoSXPzW4ZQoxmixTdUlDhHPGSNvqq
	 fq8PCHqfrapZOSyGIbGIVhC1HNqg/9orJsGA684ZtnJ5lVSIM2XPjM2gqIogqWe9fAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nGsBSBPX9KKurF0+UuE2NDcT8hZiC4p6rQEs+X/1G9I=;
	b=x2WnpAGK5MWDgWRNofvXWdTkt2Uij0+6rJhUtT5uLVLgac5DXotht7Hdg2U4aHqud25U
	 G6Nm2iyrAeE77qtLKSq+upm+idh3gpdlJJmEruKqvv0mScWvFvrVkO9C8utqR9uwWmmCi
	 crLu7uGh60mPwt06iAs144GkO+MVZe/bQPjRhpOrz+S+t1JBBxDKrtmHML7mmaH6Z65ip
	 ZYbbVAai+9IKxHraA2ASnfSYQy/u7Kk57N1XBCya6fJy7ZFPU35ZpzxJ40CpkvNXvmm+0
	 8YUYAzvT9Am3WNSbseRiJ9g/JbGizNuGombbuXicqtzLgftAptRhD3YFezIKv2Jijnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGQPQsHP;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F6606A32F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452F6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGQPQsHP
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed0b03ce3eso595205ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934732; x=1794539532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGsBSBPX9KKurF0+UuE2NDcT8hZiC4p6rQEs+X/1G9I=;
        b=mGQPQsHPf2ej2s2Hl9o3MhzXyEQFnJqt4mwZdCOit/z2MxeWxV/v7bptBK3zngysh6
         8x0T61zDpiZP44j1RoHylY7XUjks2qlDagVDaawixSLxHaqrRpA4w2O0amtckhsqAiUl
         mx8df/MmyvjRaDXhRlLPA5Vc9hKfmS4BXtquKXtl3ibmoX0KpxzaTsT8jm5mCeyHi54E
         GXlOd6kUoYsxI41EtKcrq51Kfevy1jp3zzqPCai6cjQbOLBJWIfSCYaWgy3l3AySGYK1
         QSKke0VEnhjIxMZtqF6d7K7l9tdX2G/9s0taMlPSax/g0eU+EHTX12Kh4p2fFLa/aFpt
         AR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934733; x=1794539533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGsBSBPX9KKurF0+UuE2NDcT8hZiC4p6rQEs+X/1G9I=;
        b=iqdQZ1vuw+KPrur8fcdgqHuLgmaZemz4YH1aGmqViUoKh69+D+JleOBa5dCJSJXqsd
         Xz8UP6B4vnyL6N1vKFpoUmguJ4m/Wu9Ot0nA+yxYA3vamYmb9EfL/PmWUYhcra9kVSYl
         pTW2LVYvWPDPMKXhDIaABjs/u/rpaahVtRnMoEIF198cOwAYPmIWbGvkPNTbwgB2ijNa
         m03oxu9JsTopMPfVkSUCuBLQ9rExKRgA2Op81BVe/LgjTJeImK6M/oWACe1oXGimEpT1
         R6s3padUxv+KVlRBBcb6iTuEJxMtm0vkR+mDvsS5rJW/dODBzyyDUfLrXPOp/jYAcED6
         QCzQ==
X-Forwarded-Encrypted: i=1; AL+hErGEL0xtQgbndKd0zpomgcFGLbJzGidDan4YeIUQ7YppR1kCh5l1nhBAHtUwhWU74F9HYrJ8v1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZDiATIhkjRx0zOHx63D6gTqb9WEL0UP99EBEqGyxkFORBbza3
	XfBny0zjX2boSuB3r5TLi6oU806uNAR29vRmLLBIV3tGiMfsba3pso+k
X-Gm-Gg: AYBFou1RZvzrSGq8bH4+y5xdzyWV/oIr5Oq044YCaO9OMwWDd9pnIkCPeIKScAYFARZ
	jhImUSmKhWZZWzoksOiIdAR9AmWJ2E7kwF31N2ekkhcQ754K/5reoCQTvxgO4frJB94wRJK3t39
	k10PUva0BNWNiKOYLlFvxWmuBiB2DTc8pL+L4HLG5D/ncysnQ28uYQ+zQtZ63uvIyk7WcfCV0ZN
	CHfYnHc01QM/Fb2LYj72JdDccn4bN8l2AIqEjRVuekKZ12S7+YW1ehLEAjjnjWoMDDAsYf966Rq
	D5j61ErVi/Jd53kziYl233hQ6teE4Jt9AqwAZFlNERU2bPzDsZVUGC++DSgC/H+UFAqdRujI8Q8
	K/tHfy324aD36YMMcNmeL2z/6UZb9gJEjDzCxzpqerNv3/t0MULGhR14qS3adZUBLrtj3oBj3bE
	tdSy6X7jfhilKYJeyQGhK+/KTp82JduMb3jmy9vni9ikyohHN2cZ3aXkWdn36m2iD83GL7KxeeY
	eLfBOmXY+hPaXAkSYtsEdS4E0JhLfRC7L6TH+JyFvMAUS4/p5izx/1O1AXS1q3MvybqDOWr1jlV
	dCylJkd32EPRyDvK545+XgTOkAirD2HxmWo=
X-Received: by 2002:a17:902:ec85:b0:2e6:1a6c:abcd with SMTP id d9443c01a7336-2ed405eda1dmr18188195ad.3.1793934732585;
        Thu, 05 Nov 2026 19:12:12 -0800 (PST)
Received: from localhost ([2a03:2880:7ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a9994sm972685ad.19.2026.11.05.19.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:12:12 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next 2/3] selftests: drv-net: hds: perturb settings via ioctl in ioctl_enabled_set_xdp
Date: Thu,  5 Nov 2026 19:12:07 -0800
Message-ID: <20261106031208.465456-3-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
References: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

ioctl_enabled_set_xdp never calls _ioctl_ringparam_modify(), so it
does not exercise the ioctl path. Add the missing call.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 tools/testing/selftests/drivers/net/hds.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index af34dc9ce749..7f052c319603 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -274,6 +274,8 @@ def ioctl_enabled_set_xdp(cfg, netnl) -> None:
     defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
                             'tcp-data-split': 'unknown'})
 
+    _ioctl_ringparam_modify(cfg, netnl)
+
     with ksft_raises(CmdExitFailure) as e:
         _xdp_onoff(cfg)
 
-- 
2.52.0

