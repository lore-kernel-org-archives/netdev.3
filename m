Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA83B27E1;
	Tue,  1 Sep 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232603; cv=none; b=ZrnINEJqWH8/QeeHRFz8lQp2SYV+qcOyfbdQsmLto+6HC8OPcAiaMuUBZkiduEUH/jgvOtGrpXzrY56E9P40knO9xdkbWKfkAexu59fVCUrxfhRaeuzEN6LQhIvRpDtTFNEB5QTQ/DJ3ksjT6x9oNN0Sa0G/YW+rj8fl0C4/ZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232603; c=relaxed/simple;
	bh=Ytl2M+qa/0+QnTpnwIuFjTlg5VxWAylXYCHQdT7xo1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG5N6r7bDsk676Yf3CHZJhPQx/CRzW4Iy2suP56ZIp5vhxptiFcEKJQBZt/UYM7ThKsAyZ9Oktr2NK2NZQbTqh4u9KcA+kjKjYqXMeocE2eihr9lc1lJEZ8m+zgiX0h7DYV1Cya1lrTDI10cAKFt7kzgY9gR/9I84ebtOz4xfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=Y/r32CD+; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="Y/r32CD+"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c0a8eaf9;
	Tue, 1 Sep 2026 11:16:35 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Subject: Re: [PATCH net v3] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Tue,  1 Sep 2026 03:16:23 +0000
Message-ID: <20260901031628.1376347-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831230835.1436976-1-kuba@kernel.org>
References: <20260831230835.1436976-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05af7f5d403a1kunmd63b52cc1545dd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE9IVkwfGhhPTxoZTB4aTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=Y/r32CD+S6ax2D37afcIxTj0fDlJKOqQlG8f2KEFic8apO6saOxExtyoU79WBYGU9eTV6wNkbKcAyCNqIvklhyylWqc7ZAZ5ARJGkk8MKtScT2jMnYi+gFlIAy/s0OsjDw79HILvTTNuSF/VOeK1/lkiFNZw+t1GaH2uMYghZCE=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=Ytl2M+qa/0+QnTpnwIuFjTlg5VxWAylXYCHQdT7xo1c=;
	h=date:mime-version:subject:message-id:from;

Thanks for the review.

You are right that the ordinary bindgen accessors take &self. Calling them
through (*phydev).link() creates a temporary shared reference to the
complete bindings::phy_device, which is not appropriate for the C-owned
object wrapped in Opaque.

For v4, I will use the bindgen-generated raw accessors link_raw(),
autoneg_raw(), and autoneg_complete_raw(), called as associated functions
with a raw pointer. They retain the bit positions and endianness handling
generated from the C layout without creating a Rust reference to the
complete phy_device.

I will also update the SAFETY comments to describe the validity of the raw
pointer and the callback-context preconditions. The raw accessors address
the reference-formation issue, but do not themselves provide locking,
READ_ONCE semantics, atomicity, or memory barriers.

I do not plan to add a C helper, since the generated raw accessors already
provide the required raw-pointer access. A plain C field helper would not
add synchronization semantics.

I will also add ordinary #[inline] annotations to the three small
forwarding methods touched by this patch.

The v4 patch will be posted as a separate thread after the required 24-hour
interval.
