Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07632B13F
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789322651; cv=none; b=ZqtQRsOEYkpIKH05EzA4WXlI9kGC+3Ak5TNOMHa46meiPDW5cb9HqQWs5vP+DEuw+02lDZhrDnuVgqjLPIxvU9qvqU7hD5H881HL+7eWlXyY7L1073cN+sxbkS8zmSSivmvK0paOzd6V/Ls2NHT2Q/r3nkhuk5uGRouV+CCa5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789322651; c=relaxed/simple;
	bh=FpXuibbgunUKWku75TCdJBzKVddhMIdiIekGxKU8ED4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBHG9HNq2LPuAPZ8GAXPl4mLUx9DMk7HSJjlH0qTE8bfvaZUB+x5otJUXKki01Vee+JtXaARlBP4PTiw0n7+xAZ9aDgMIRPu8Oohq12xaKojpoxFnCxjSdLw51F6ZUBB4njd1ezMuk3XnjwFYJ+fftxm8Vm8p52w1E4wxRauxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOWRQMoG; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOWRQMoG"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39d78580bfdso2039755a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789322650; x=1789927450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A8Z4lHNbz+UeURqdjUe4LqKVsnHKdKejzDleunOFUKQ=;
        b=SOWRQMoG/GFtg8k5PH4k9x7bPTQZOjW9Lba7CBH9mGFy6a6/bTmnC70LbsxRFcBHmc
         Y3n9o0YyEs7KURAtLmEo8Z/dGftKqwqBxa2jVRIqIvKn6/ZUOs7d+comna7A6h14q9f1
         HNUi+VxU+wdHvKWmpyMIftHma/15Z3q2R4jlS9lr9gF7YUGWFAVTO0ovf7obirfElJI5
         4RO61gt5nKyDACzWx7JaMoBg87azmhEeCxJQ7iPSYh5149nQGyF6cICAAqk923ZuYTZj
         5+xTxF0jMnNdxuV0VDuwKFK2UDBxR21t7kH3eIbyvEIt97hDcGnHAsDTUxW08m8wzvEn
         i8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789322650; x=1789927450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8Z4lHNbz+UeURqdjUe4LqKVsnHKdKejzDleunOFUKQ=;
        b=VT0hPvZATg2uIHznN8Lzrc5aX15mAhu6Uc/2YK9h7uLnXm7GQWEnfXTyGD5bjytlEl
         jMC0znN8xbbETyFsGhbL3ZG+hgOIf8ctwmQv3I9yPxJN1pLTfOjNbTDGBLMfLxy+cQ7/
         sIQFDnRHS1CO4vrKqhJYzsgV5PYfQ51SXx1LXZAdawKXw41yne36gXnCe1nxUCpAO8l6
         xEhb2BAd/k1MIMG/V0qovUjRH5pJpE+Nc4/8Yh+fzP6SsCDtHNDi6V1QI++ftS2ZTYj4
         joB4uE1OHXzlqqu3J9M6uWzMxclet1v2Cw/jIv5zuyMJT0XgZm1qcv3nOeldrR/G9xw6
         1+NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR3phFhC3cNESEWN6J7c0fP2QDuW8tpuTqjC7hbfkADg+PZmS0yfQJjplAuXgtNkmmaWakwFA=@vger.kernel.org
X-Gm-Message-State: AFuF++lHglgzc9M+2th78uvBfVZ1FMQ4TbZoLfigboiqguDiB/Nl3lNV
	1xwIG0VYGG0d2m6dJFIO3LC9RpenBXyAbUB8QWpVQlf6v6957mvjb8c=
X-Gm-Gg: AYBFou3bqWxqhb6+8FcGSi4CjXUmCo7TIh+kmLRoZKGXi+VEtj2wMRwOHdoUYdZ6VKI
	PEnzkspNKFFE0jrmSc/ObkHuY/JOOpP68HuT+xI03O8EumdgTD7S7f3rQ8EgaEbi7UC04q6oDF9
	I+Kbs2UVsDCMrEatqRNkaDvvdra6rUlfBlO6l/6lWPzgFMO0AtDou+CyglVUn3L8gzKb+OITCxf
	ou4HkMNNQPf9b/1n4scJcm6qz7K0d+mGJmmfdtdV2NAyLJD3RFUOdNanDG82ygWloJCxwPKZQHG
	ipXupL8NdBMVTvZSPIZngdSC5eCt/DhNNU5S+S+j+qLs1SR18kfm9ABYcJfK/uvNGgqHB1KCYTr
	NSf91Q+UrflvgpGhTi/7lcYdTTwFtED1p4H2FfHe21L2Bd1s0oKqbYVVtcmzxIKYtloRj5xmWY7
	apAt7bWuxCx3k+LEPJv4NzIpwm9SyQSfnlB8LBu1hkrED6+9uZudgTv3K3ggXaPvdabtBVOzr6X
	p7mGkv8kp+Duvc=
X-Received: by 2002:a17:90b:3ec3:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39dbc6f44d5mr15199601a91.22.1789322649797;
        Sun, 13 Sep 2026 11:04:09 -0700 (PDT)
Received: from murali-Aspire-A515-58PT.. ([2a09:bac5:3b24:1a8c::2a5:ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm20636958c88.3.2026.09.13.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:04:09 -0700 (PDT)
From: Murali Krishna <muralikrishna2444b@gmail.com>
To: mani@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Murali Krishna <muralikrishna2444b@gmail.com>
Subject: [PATCH 0/1] net: qrtr: fix coding style issues flagged by checkpatch
Date: Sun, 13 Sep 2026 23:33:41 +0530
Message-ID: <20260913180342.8948-1-muralikrishna2444b@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is my first patch to the kernel and I am still learning the
process, so please forgive any mistakes in formatting or etiquette.

This patch addresses a few minor coding style issues in net/qrtr/
that I found by running checkpatch --strict:

  - Fix missing space in a pointer cast (ERROR)
  - Move trailing "*/" to its own line in two block comments (WARNING)
  - Add parameter names to a function pointer declaration (WARNING)
  - Remove an unnecessary return at the end of a void function (WARNING)

After applying, both af_qrtr.c and ns.c pass checkpatch --strict
with zero errors, warnings, and checks.

I would be very grateful for any feedback or suggestions, even if
the patch is accepted as-is. I am happy to send a v2 if anything
needs to be changed.

Thank you for your time.

Kind regards,
Murali Krishna

Murali Krishna (1):
  net: qrtr: fix coding style issues flagged by checkpatch

 net/qrtr/af_qrtr.c | 12 +++++++-----
 net/qrtr/ns.c      |  2 --
 2 files changed, 7 insertions(+), 7 deletions(-)

--
2.43.0

