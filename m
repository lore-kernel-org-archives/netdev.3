Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B13B19A5
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484020; cv=none; b=Ce4mU11Zs6kYBsHf12Ri/P/LJERUuDvauhVErGRiJbLijT0llF9+Dbr3e+JdffFBNRql30U6/v4RTndt6lwqPxBtKVomZY7r5ie70Gcg8mK6CdRGI1Cr8brkt4nelg+/kLVv6jqR/05GHiaiVAQL+iVCnnFW+M53gioNPcy/cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484020; c=relaxed/simple;
	bh=IWl/rQwPGM5RLLR3ae5FmKgiapEO5Ii89mk7y4WpFec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFeXyqtn/qnRdq+oWeD4lOsH0g8j5G+OzzyTdNqvQdY8fVQJmylXvH+49ejQ1HXct0RTMHtiCPM5SczVMp1m4IPmYN7rJZzJYL2wZpZcz8jLa7iG6+MfFJZs0yHUS03IimXm2YnFFjsW01GF3K5DMvwoNogOp2uozQI5MzhuX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRSyNP3n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRSyNP3n"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso104946775ad.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484013; x=1785088813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
        b=gRSyNP3nbOy92ndFyGq6aP6JDaV8aAmOvPKk6h4ZEMEh+9n1MXRhN/KjKJ00rxs7Hd
         KLoCPSoxZwgxWI8xls30M7eYHu0FOR0MiRmNjhrmI4shqvn0WxeheUew5dXh0r/H5jan
         0IxTL/ohLXUqGZMkpFHvdBOTcinVnPoIVaOcMaRr2IPYLFLYYFgLlqHPsqeAwbnsHO1S
         VZUwdmWN9uuM7msnE8QYvaQyhoc1V2It5aYl8p4y/k/4i9I9UWou3ISu6o61KBH4lxv8
         l8qlx0+WDF36IK4OuqpytHCzwq2lJEnG6i620BEfTNIsK2p9RjAtq1NK4kTU4dfFluTF
         oNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484013; x=1785088813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
        b=oMMLFH8Gb7ksTrM+XSkseRpWaWvJXqF1UsBGwuHjdlcjPDAGAqvEuDDwKZxQ8m3/2O
         N6NPWA1ZnjK5DVm4iFNBFPZ2fBjdY8n+G1kkv/TIIC+aC6Vq/LQMC3rDV8o1odZudAqd
         ttRPQpiBocFnkhsU7jK+C3l9VE7x7TG9LjBJmUU5mdCKN02Po0WLdUlz3T9V9Nx3ma/8
         3Znp2v8C88l1kCRTzpw2WAuY1PTpfe3BEbRqzoVbl/bKCszR7aazRL9I5hXcY7PWuQhG
         Z6HPHmQwUiZ520WpYYdCpFU8f7cllWSi223liYs2/r3Ctdfdg0k8sfk+Zb0uDp7fuscR
         lBqg==
X-Forwarded-Encrypted: i=1; AHgh+RoYypffO0GOWJx/w3KjOFTgMk8SVIitJjq+xYrGCaWnWAmMLKIa/n3ejrioFkaUvClB5XhTcfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNTGXYAbPK+lSrReQNNJAzWQVxHX+FnFJ/DF5i9zYFMXXHCXf
	5XrO4w89TwqzVDKmarP7PQj6BUOlW1h7w0pMHRtGaOTvmtRfKyn6qUGv
X-Gm-Gg: AfdE7cmkojuvpbtS4IQrb20wutQQzWJPobTOy/DpLhHWNdYWVx8FOeRQDSvLL+dyPeF
	2XnqD4/Gm+6dYtq9CFDiKewohbNFr5mEqcbJQ4mMhGPimDBr3EkcOa0mZH+yZ6OJRHGGp066n9/
	LhAhYyXccuT8gJmNWJZO6t43QzSsIAkF9kjrYliR1qRFJ6C8uT5kKbMunmPSTkHo7q5Bf6rZVS1
	UoLBUHnAGP3tCGcf/4uD8McuuPWscRygo2WjL4zfOShecwgVp5RUZRVBXW/4Nu6J6so5J2tz6OA
	IOcLTM/SPLVeX4uOX9hDuIUttGgjS/g0zW3688Cs630vv2FzNLxBmKgpevLYT4Jqu1XxT2LkDWw
	KMefWX0C36TQHO+CFe1eipaEFfNohlj20hdaWMtwMeFBS7sY1ivZDS9IByn5iYn441A==
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2cf34821a87mr130472895ad.10.1784484013524;
        Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	bpf@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Hoyeon Lee <hoyeon.rhee@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Nathan Chancellor <nathan@kernel.org>,
	netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 03/13] net: core: add XDP_MODE_HW offload hook for knod
Date: Sun, 19 Jul 2026 17:58:47 +0000
Message-ID: <20260719175857.4071636-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route XDP program install/uninstall to the knod accelerator when a
device is attached, so BPF programs run on the accelerator instead of
the host.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit 9689730acf7d6e4d34cd677e4615be10856c709c)
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c21bc0a1e34..5ba1c969029b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10334,7 +10334,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (dev_get_min_mp_channel_count(dev) && mode != XDP_MODE_HW) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
 	}
-- 
2.43.0

