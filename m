Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06548CD72
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781903; cv=none; b=g+p9LnzHaK3P+cv6a5rASmcke2ZfNMynXRtLuMc471kXXwhpXyrlVpnJWiBiVqUQ0a7qiUmDD3DYJQ4kqpIR+k+nxe87tf9FMUKFYBCmE+1lF4cvozGfq73rPc9UdWgHWYBDj4dX+KvMO6DspL1W6XEXx6a1G/gzKV5uUdK2KnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781903; c=relaxed/simple;
	bh=mUOu4prFbH3IaF5Zx3eYa4vcy/qKSL+mXorCQl1XPlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6uAibezkhykKulws+u/XowLGyTskllqrcd0fF3P1ntjaHSXmTKAgB2GRjenu+GAXMnJwTj5uSQHV1fgby2NzzPqE0zdoMWcVMsbKQCxxLnwTdD8mO9cqgln8p0Temsu0m5CgO0VIfQuXGd95q5S7lojNt0h37ByRvZFPuSIjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso217395f8f.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781899; x=1788386699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YabbSQ2ZCljuR5SzDy1HfG5T6nOzAXlSelOf65B5pQ4=;
        b=D021jTE23jY88mN12kD/PJB9QLmCV5tVKlsMHu+35Gl4E77NrmsETRxqBSsxx1l6nu
         X8PJiV/9OOP4Ee8PwNlSwDvdb09I640V5cTKmCklTRwJ3RrMKdq4crEGLU45LPrIR8kT
         shJLy6hsCtd1DecqpI7nCCGPKY9fxdv2BkmZ68zxiacYkyyMmAcLhbbAMr4RBpN4nEcW
         rspjDjrbQYRLyeJNgYA2kb5kfSdD8uO0lWL/s2Wlk4szJ2RjZ9fj+NyhzM2kusUfJKo6
         4h1cZn2/xV9JZnOF81M24lsUx+6+JgzaVBH2J4gf+1PmbkQrbNYo0QbjT8a+EpLyFtWP
         KstA==
X-Gm-Message-State: AFuF++m9XTr9DanEW88999Ldy66WSvw/9e8f7izSSNgjoWbJtqNFDxuY
	1ssnOXLb9FIiedmmDq10eIb1utdPtReNXz0EpzgEpKkcUzWEcs5yufWzO11gVzHd
X-Gm-Gg: AR+sD123oFJZHBURuhxBytDbOeNED98g0i50e8Tb/U/2MvpftKXBrG71ZbwwZPvif37
	kyt4rcJZ8rE928K1qYiSScipb73hd9FA8naxjzC7JNeB9I9DeOiShlwRwks24H3ZJHyPmUhqRey
	2z5hlzhTC5+6/mfDWTg8goLYK7UMQW4++/4LnfeHjtVQ4JL/rU/PmUf2OUyIjY4950/9CdaI40F
	t0jVxHO8t799UCvhdwTNjXcqFtHQU6onZHLwUxil5Bjm9+iPBAQGgKWiwyn6XzBrrd86XgroqWc
	zhgAUbGLDTkaCvryVKqtf0yE7kl3qwRXTCc6lRM0V/LEUf6AcD5nCNcFkRqL2JactY2WdsesA83
	2OoU1nvcQ1NplVdGi8+cYAGudMYObk24NuGHMmUqUhy3yQ7q2ZMLnxHzUTKkKs0sQxuacoIlpvY
	hmh23dz3mFnKS3BsGNAWZUn3i6ErYCN+dP0Vv+qZXUPZtYQlwG5Zy9V0a8GYfMqVRD7I9CBaa1/
	VdTm079pPXg1GwaqQ==
X-Received: by 2002:a05:6000:40e0:b0:482:ee81:f0ca with SMTP id ffacd0b85a97d-482ee81f321mr819706f8f.12.1787781898817;
        Wed, 26 Aug 2026 15:04:58 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27a9f0esm4446370f8f.10.2026.08.26.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:04:58 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] netlink: specs: add missing mask attributes for conntrack dump
Date: Thu, 27 Aug 2026 00:01:12 +0200
Message-ID: <20260826220444.4054714-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826220444.4054714-1-i.maximets@ovn.org>
References: <20260826220444.4054714-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'mark-mask' and 'status-mask' are defined and supported by the
conntrack dump, but missing from the list of arguments.

While at it, the order of the arguments should follow the order of
their definition in the enum ctattr_type.  That appears to be a common
convention for other spec files.

Fixes: 23fc9311a526 ("netlink: specs: add conntrack dump and stats dump support")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 Documentation/netlink/specs/conntrack.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index 6ba28cb1c2ab..b1eb102ab843 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -604,10 +604,12 @@ operations:
           attributes:
             - tuple-orig
             - tuple-reply
-            - mark
-            - filter
             - status
+            - mark
             - zone
+            - mark-mask
+            - filter
+            - status-mask
         reply:
           value: 0x100
           attributes:
-- 
2.55.0

