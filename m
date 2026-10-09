Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069D476058
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531789; cv=none; b=sOMZfqVwWOUCmje5tL6ShHU8RuuCklXYEQJerLwRBYsuKHpF67A7ZBhmFuU4y9xsCbD/7BlTmXreP12e7Ewfyket8u4hNofZ97recQ2UKa+doOv3ggKR8oaVSeneaN5umT9gI/IfVixWemQPFXxUrhEFBOzCirdcqFiHOTuLQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531789; c=relaxed/simple;
	bh=tTYCiu56WjZLaEUZm84YXG5kgInp20xIQBrWMS7xesA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+zqbnxmXup6GqMuIuu/s+sunu6YVsS/CDH0ZDLMZ0ZNXjLrENmjpFmE8qGCAJ5hMXoK5n5xbx9RAvCePy7EuHBoQl64vbf/Ny34MePP+5+JzKNGCks4VPNCSW+vVUzfJ+obDeQIm2/bVJ4CP/ZdGwyDpelhZGir3fwET8Y0WMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8CD/Azk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8CD/Azk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1249430a91.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531788; x=1792136588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwKfuoeQ35NUGbMAfIq/wI54O4pLFX7q37/ntcKq2NQ=;
        b=a8CD/AzkbtJo0q67hHOmqfwkikOtCvK2q4ddH4wrZX+iIqxRT6IctBaxm6yXA/P/f2
         3nrFblFjx5OQ6q4k2y2Ifp5LT8F6UsxT12Pjdqkq/b4QUQsd95AWMwdOQplSrEcphWXF
         tcB94tAi+fkxL0QUO6vzyIjnzWei+JQT4V67z9N9Ims6mceL3XxBVNRCL6kprFPVYp4m
         6v5LZ+d0NPeYQuMn/Hr2C5fOu50oz9BC6upVOVTd4YtnF+Jd/kCm5BAb7UNWzuzUKA0N
         R9TIibS5b97K+jnUIpkbAx8sC4ZaoTwdpPQ240mN5vcRod2MPe4dVvaT3ptKya0FjrVX
         Y8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531788; x=1792136588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwKfuoeQ35NUGbMAfIq/wI54O4pLFX7q37/ntcKq2NQ=;
        b=W0Ytq76TO1z0lyZ4WMLqxv/gorgbwtF21s8+Fo7FMc570LmVNR22qrmpQthCxgb3Zr
         r2oL1sABPtjZmPFTvKDrsdj7k5NyDjE8BB3u2JNMa2ngXYCnlRkjCwhl/dLtSsRgjiUc
         n+zHrbPsE+K8b/b2dcjVi4R2bjtR7fXSX1uJ4sV4RX2ZihyFl0c9CuwJxQFDeaXQOSAR
         2rbbhft9nLlFcoEkTJI1cNug+JNjkXOpXKXLYthfgtBNzz/Ul3CFwfYSsHVTfBH8pCjv
         0FM9KTm+GWiHcIRS4beTRsTOYhPYZPWmKEjdSFFM962DPT9Eus+LhQjuqbOZUEBWpb+G
         Tn5w==
X-Forwarded-Encrypted: i=1; AKwUvBxbvoZyHw+RMZKfmt7vX2/u3idoSQ1Iz07rsSSNNfNPofXuHGthXnbXaJt7yZwBrmNvKqyHqsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLavwzXGI/uDUHXyG3UKBxrSyCUv/5S8eTmv5LOeWgzGOfXnvb
	wr2TmzdRwVEj1XltVBDDgdFZVUpuAyoeQm99foDqCaz2D+vHyui35frD
X-Gm-Gg: AYBFou2mwQab/z5067kKsQCnE8VCicin5nHPEyBkgIRTOvxm21sL1dJtqI+1Id0vL2i
	J9jvuHokUfiKZzdIi2t6zIkwVymrDjKLvaGh/+FaHzBhrS/zmXGq0pq/5gyfKF+rOj9OYKxXzPb
	TrbwjF3COF9b2KwKjdHZq7rYJy0SZXcsygp8nd+Rpu6cmME8P59AATjVVbwyXcpKyTAnDF77Jiw
	0tXmF9MG3/v5gNNjzPwx90reP1WaxNBsog+qZxvaTyNnLBrUMwiYr69qqOm8duoaW8rmzecpwOE
	diHa/qo0ivZFj128FkEdFwNafzie9fvxlr698S03orv1z4+ZYBhKPLL2RWzLCK8a90pur1BRjJ9
	27ehFrvvmQrGNcl+Fm6mUz+nLd13aRPm8nKVOQGv0CbW3yRzvBKfQUSmZtcWywprLTFXFdrN55I
	/sxnc7hiU1MuDKmlJFyg1IK3Lyg+I1gNRQV2PI6t0898z6uPebcr3m3ySxdOIlV0/Em6LPSXvhz
	e/6KKFpguXu3Gu7zB58LV4h9EiRdo/nik+Tw6TzakKfRA==
X-Received: by 2002:a17:90b:4f43:b0:3a4:ee64:f492 with SMTP id 98e67ed59e1d1-3ab3ac8f4admr686219a91.33.1791531787321;
        Fri, 09 Oct 2026 00:43:07 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ddac6dsm2124986a91.7.2026.10.09.00.43.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 00:43:06 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net v4 0/2] sctp: re-point retained control chunks on association migration
Date: Fri,  9 Oct 2026 15:42:30 +0800
Message-ID: <20261009074244.3718-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes ownership of retained SCTP control chunks during socket
migration. Patch 1 carries David Lee's shared-key prerequisite.

Changes since v3 [1], following Xin Long's review:
 - Add David Lee's and the forwarding submitter's sign-offs to patch 1.
 - Restore sctp_process_tx_chunk() to skip duplicate visits.
 - Preserve a control chunk's existing shared key across migration.

[1] https://lore.kernel.org/netdev/20260926100359.78731-1-juny24602@gmail.com/

David Lee (1):
  sctp: hold shkey across socket migration

Jun Yang (1):
  sctp: re-point retained control chunks on association migration

 include/net/sctp/sm.h    |  1 +
 net/sctp/sm_make_chunk.c |  5 +++--
 net/sctp/socket.c        | 57 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 12 deletions(-)

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
