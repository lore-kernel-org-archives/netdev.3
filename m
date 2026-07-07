Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C813D525F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418825; cv=none; b=cXe3fe/iF9eBqLOWWv+Qt1JAt1sMP+/dElYn1h/ABBIbK1sYW+K+G9yAsChvEoPbwwvwuXVc7oS5+XA2fFdcPq4dn3pqZg8xOrhVd5evgP/BV2Uu4OkhrM/6mnDg6CWPi1h70D3J4ibCMvKICsNLdUmdK4HygZiDJzRtysHmx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418825; c=relaxed/simple;
	bh=ibBmGBhfW6rIKCn04NAkVmYQINk93YZeqpdh9lOrogU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EnzrFWuTSO3YkjJiDvRN06nMZmYrzzwf2s9I1MFIHDRPGx1quGKi7iJ88snjAOUkhaLTlfLfX4k/E3hFL/WmD+cJ50dsY4XFG4ICmVktRtftfib0Glx/zrbPyUWjIhgmp4Z2zY/p5FkJnsRKpggVln3X34OSwensEMBX2AZvCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxAfHasM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxAfHasM"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so22857445e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783418821; x=1784023621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oR7EhmXRRRVQ13/iX6VaF2jbV+1nBAD6trvmWWXjfg=;
        b=FxAfHasM8p5XrvckSJoFuxUx2NVCW5zxYO4oDRMsBiQIjxWQK61HqK94t8nM5rYMSN
         EMCoOYYQRmeXScaDQ14uBywZXibz7Prsm18r0D3EAHQ82/JxxMZEl0mtgE7dEfdRdgKM
         yDUwoZ1ff1b+Fvv32Vgihby+wOxZMen6W5oSFWXh1j79dt9gcaUBDbYMzZMgn6w42efP
         LDO42Z4BgtRPMjXmjd2nO90Pslpo3c59EJ7ifpvBzaSFeTZu9M4huSizM4/hvucbku+4
         iWMnrnA4qshAMVtvnFvsXdQBHEqiGCbkUXat9A8Q9dHlFBbCPKIBk8uKYQLgH5XSEM0Y
         VFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418821; x=1784023621;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oR7EhmXRRRVQ13/iX6VaF2jbV+1nBAD6trvmWWXjfg=;
        b=qeaYj87icb2pvird+t2E6fx/oTGYbfOcVU0H48Ll2URtZBtYuGLeBYMqWfRGl+Yi+Q
         Xw+LyYdrNfppSPXBvwJDftLjkTN6N49/IoWVGTgXvVXjNe0tVQArXn9h5XIgXNWZVTnU
         pQR5sIrkSNwHXnfrYmFJwNBUN8bu8x9PQyzSGe+FB2rrSIVqXJ6SofNLxi/N72ouM3Gn
         Cqeix1t0G/63cxIMMWh8n/ClM4uHSQTt0LCOJzHXOyIR6LcY4OpH+lCusMi4vLpCJb+d
         qBQAvqXZpofyVg99KzQXVxDQnUOxhvcLGkbX7zEjkkWxJY0/aTAgUUKhECamihqmdJjn
         BsmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhfnfyY1MZRUPpp30KbuUQCRZUTSQhnIlcLGOje7bl0kfv92tsti3QqFIOeTzT0DrOhAiQ9C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydrp0BhCk5CWee9XhgKyxIUhy+d4uAe2U32ZU3jTK+byPKrU3o
	fQjmfhjvl/e2nys858f3aoLL5j+XW7qa4Opo8yvhI262PUtVZm6BQt7usxb4XsNvyYhNUYmEKmx
	erfcocdUeIJhs24I9Xg==
X-Received: from wmg4.prod.google.com ([2002:a05:600c:22c4:b0:492:2b56:8534])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b62:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493df06699dmr48435545e9.4.1783418820597;
 Tue, 07 Jul 2026 03:07:00 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:06:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALjPTGoC/3XNzU7DMBAE4FepfMbIXv8k7on3QD1k7U1qURxw0
 ghU5d1xyyFBFscZ6Zu5sYlypIkdDzeWaYlTHFMJzdOB+XOXBuIxlMxAgBVKWI4xBco80XyJ6Y3
 7FqQUCD02mhX0kamPX4/B19NvzvR5LbvzVp7jNI/5+3G6yHv77/4iueCh84QGfat6eBnGcbjQs
 x/f2X1rgc1r0VYeivciKGiCNFqZyqudl6byqvhWIznsrCKq//XmjdCV18VbIVFLH8Bg7c3OQ/1 viu+cIHCgCAkrb/feVd4W7yCERqPtFNAfv67rD4tSqhMCAgAA
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ibBmGBhfW6rIKCn04NAkVmYQINk93YZeqpdh9lOrogU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqTM+++Xkqedqy16KZ/zyq4sQeGvJScDPlNxX/K
 L+4uaYfe76JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakzPvgAKCRAEWL7uWMY5
 RlOcD/9Aho3RfW59BOFCUjIteQz6o8rvYcxMudS1NG85YMlY592taq465GBSCbmv4RbZtyXe6uF
 CdPD3KcUATRuWcqyiCakpNyOpXE5JyNM86vyPwAc7h0HEiIzH02sHvdYkSPhcXFXiA/O0ylWaUh
 l0PSauJcHkxsBz4pnTGCWZrxd93yUs3CjvUcjvZAU6LXllTI4+Fg+kTyNI2x52ztA3qKV0FJR/n
 H9yC3Nk+5Zk+xJO0lYfDAwETrh9W4yOPjsY1L8hx0xb48JJu7PLhbJ9AvmJamN+pYuDVrt2rz7s
 BNVq+rSKcibOBvVjzdR5pwSOwwTFPRPYDpb7Mt43PpxqcrQrqRTBYI1QQNYiNTPie/qdWl08mAu
 HAHUKFA0gRtXNZ/nM69kdUbG3UI0V0pP5RfgvoIOz1meYp/EqGHtAXaiWGOtDarEUHuvuk/A3YU
 EXfHhdZQQNmRsOsP1O9Y9TIBtxLHCPGPemOK74xWxgL5Ni7SMnGvVSUSqS+grCuZevMoCKVabYH
 Ut4IU8/93d335usieVR8HRCjf70sqkzEkqA33riGtBtdX1rkeZJ+/bxn6zOTnOb1668oXLC/bIj
 HMqTg1w1d8hwuyBCheMMmRGy4SkCraxY0aq9xOpMYt3TlQVt024HE/HfzMte/ZoCImGBhB0NodN aGDgLfN7f7DuOUw==
X-Mailer: b4 0.14.3
Message-ID: <20260707-binder-netlink-v7-0-42b40e4b1ac8@google.com>
Subject: [PATCH v7 0/3] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

This series is based on top of the result of merging together the two
branches 'char-misc/char-misc-linus' and 'char-misc/char-misc-next'.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v7:
- Rebase on char-misc-linus and char-misc-next.
- Fix conflict with commit 77bfebf11077 ("rust_binder: fix BINDER_GET_EXTENDED_ERROR")
- Pick up tags
- Link to v6: https://lore.kernel.org/r/20260529-binder-netlink-v6-0-92dd74b6a32e@google.com

Changes in v6:
- Introduce MAINTAINERS entry update for net files.
- Move netlink.rs to rust/kernel/net/.
- Tweak info.reply logic in Binder patch.
- Link to v5: https://lore.kernel.org/r/20260525-binder-netlink-v5-0-a90e2923ebeb@google.com

Changes in v5:
- Remove patch 2.
- Squash patches 3 and 4.
- Link to v4: https://lore.kernel.org/r/20260504-binder-netlink-v4-0-601b41cd25b2@google.com

Changes in v4:
- Fix typo in 'report netlink transactions' commit message.
- Document that some methods are for const context only.
- Rebase and pick up tags.
- Link to v3: https://lore.kernel.org/r/20260415-binder-netlink-v3-0-84be9ba63ee2@google.com

Changes in v3:
- Fix spurious 'return' statements in Rust helpers (Patch 1).
- Sashiko review:
  - Fix ynl_gen to handle empty multicast groups and correct multicast indexing (Patch 2).
  - Fix transaction failed reply logic to report via Netlink inside reply_inner() (Patch 4).
- Link to v2: https://lore.kernel.org/r/20260408-binder-netlink-v2-0-c0d327d15435@google.com

Changes in v2:
- Make inclusion of to_pid conditional too.
- Add note about file name in second patch.
- Make it clear that the sk_buff wrapper is netlink-specific.
- Better handle bitfield in patch 1.
- Link to v1: https://lore.kernel.org/r/20260306-binder-netlink-v1-0-daceb5bc83f2@google.com

---
Alice Ryhl (2):
      rust: net: add rust/kernel/net to NETWORKING [GENERAL]
      rust: netlink: add raw netlink abstraction

Carlos Llamas (1):
      rust_binder: report netlink transactions

 MAINTAINERS                                |   2 +
 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 117 ++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |  11 +-
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/helpers.c                     |   1 +
 rust/helpers/net/genetlink.c               |  46 ++++
 rust/kernel/{net.rs => net/mod.rs}         |   2 +
 rust/kernel/net/netlink.rs                 | 337 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 12 files changed, 566 insertions(+), 4 deletions(-)
---
base-commit: 2c7a7db3aa6370f46761b6d8eb821f5bde8901eb
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

