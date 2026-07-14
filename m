Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46956442135
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039414; cv=none; b=saAWT0/8jalUVYP48LDY5o6auyKSDALnNLmEVaP55w0nIwKfm0ZZQmSPwPtHBup+I1E5sSZEcnYNodwf3WmSCzTI23Xe4OeHOkQMwukxicarIDTRhIRGeLxQyfH3HyNwb6Fw1o0f2t36yw4jCABCM8Tk7svd2MsMvMPMpCiznJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039414; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7JG0Flvsg1awyWhV96ELeATrpc+XOqVUfH+a6jkBldh/vZGmIMyKz6ZVfhujlUW3C1B4MJLPctLziC5mbT1hDY322NZeOHocpPLmvOjR6Ty4OmvM+7tTx323y5NpcpF/Nx9T3UEWzd6hP02NrQZopgLp9COeiVjJ2OjX0BX52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tIplLQKz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="tIplLQKz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so579537f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039409; x=1784644209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=tIplLQKz7ETUgWcKFbHl0CWUrXenVkiXEyO3ng32niwGV71m/oIlqG0zutHaXUDmTn
         YXtlbK43Zle+QsSGZvahavbXjyKpupb2yhLdTwQbwyu+aE9aBLPKB3MzuH0tBTFbi0Fo
         w28wbfwUYeOoAbbs+DS1Ue++EkO7RQuVFmDxcSdN4t7lZTR1biPzQzSHco/so5vimC5y
         l0qcL1mvsChAugvRgeaMTPj6i43RpPrLaqRnILoJihFe1XIWbF0x3xz0Ge0wsW+I1E4d
         TGcE3lOQNqAJlhvSQ+hwOpokRo4GvE9inrTL/mcdyaB1TF1T59c/Ci8fOGj0LoYRID2V
         AgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039409; x=1784644209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=JW18SaXoJ1kzDrzapGPkFDWFjGXxZZ/RMPfZaeDESNNPrT4QrHXIJ5bgBoRGa8UMWT
         sEgp1bpO30o221STtAGxUgMeLlL6ZqnL8BGVhS+AluLS3qpAsvy3RP+xAMldn0nY53NN
         xngL3PuCZMbydzBQbIgZkHAI48/DTXTpRQjgFKRXU8EuftiZlnGzXeOcaYVYBWQelD7x
         fuygaOaOf3EyIVo10tEX2l9cU6vuGJeFfFgSFa24qtmJUlKaePvUCxnsfA7uTFAExsL3
         ocNmyXGGMOQDTWz5e5OiarPsDG7Qh1ROirjpT8WX2rk/8u9l5Kjwq6C1sdu9v5Gfk7zY
         SlGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpleWmN7cK1ITqxdrhX650Dic4IvOQtyiU+XSvHbVUgmQuG6KKc9g0eVh13wSYu4Ysxy0EuynI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhCWQQqwUFFI9dVTv2CTUtJN8CAL79k8gfH7srDrjKVST9VXF
	rOEIN+Qqhc7PGZqEkAaNMAV0EZQHGjd3Y8+x5dNnF6v2W6eaL9hLN3gcQjktt2o8V90=
X-Gm-Gg: AfdE7ck0mhUTRdgxHkPYeZVFsCPhkskQyA/NatYC9b/Ye6M1XvOuqTLT1aOGEjth7MD
	STbxJ4Jgoa8SFj26sOgCTz1itXd5xOJGFpWZCBQ6nP13wzYcHkxzF9ng+uaiQlOQFByW91T+Ygo
	p3XsuzCs8ozdFKlKXaOhSI/PQ1PQ76FvRGUt6J18l68zoQ+NJg3aK5DjE74PnHbc+mrWqCikVCT
	qq337VAfObxaviQ2IJpUlQRca2mmx5HGD75NzCnvkujfCZOxaAhkbVqZsWL+xfqUvWy0Nvd3j56
	hDv44EPwWfG3sfrqmv37MGRLYia/8Y4yj0a8oVJpQaaPiAhXBbDZyFFj2Qf7Oyf0YHKphIArit1
	0dc5q58jICqQaTNnYcI30SIsV0AkUcL8lKHJY+zcXHZa55H3z3G2/HVMRGpwK6zvDz+DQwFT2Ev
	+gEuO8KDAY6peZ6l0a8cj2iQ==
X-Received: by 2002:a05:6000:480b:b0:46f:1b89:999 with SMTP id ffacd0b85a97d-47ef69910b9mr23198373f8f.30.1784039409490;
        Tue, 14 Jul 2026 07:30:09 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm9292456f8f.7.2026.07.14.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 10/14] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Tue, 14 Jul 2026 16:29:23 +0200
Message-ID: <20260714142927.1298897-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document that SELinux ibendport labels use a global (device name, port)
key, so same-named RDMA devices in different net namespaces share a label.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9af31d1d9d70..a82c46965416 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -700,6 +700,12 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	/*
+	 * SELinux labels an endport by (device name, port) from a global
+	 * policy. If devices in different net namespaces share a name, they get
+	 * the same label; distinguishing them would need net namespace support
+	 * in the policy language and tooling.
+	 */
 	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
-- 
2.54.0

