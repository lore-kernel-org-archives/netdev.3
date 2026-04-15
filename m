Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7263242CF
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245974; cv=none; b=uaSFXLx8+RK+uMXtJQSRWR36VKZ9Ng88FKviuhp1MUhrPvPyK5cG+AwfDdZezqO7XVzqyCGxvSshFtm2L69AKzqwkMRwDTE0XfCTrfaRlnWmlFpXchq335NDtLtRgSSrKxgtX92PU4jLYiEI6uWrK+lpDRQlN9O7+QABZ4bFBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245974; c=relaxed/simple;
	bh=IE/wFKrBh0t+EGfYLJfkCLHJUyNnOYhBFTtA6ZYlxXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nD6ZNK5oZR/cWLU46Z8/SpXNdFE/Df69X/cNBfk6DKj3nU9xBOWSGelxSJQuKAfVh1vOgQCDoHvhjSTOPCwxwDS3AHAZWus1i1Dz9sY4xFpbV4deDd+Oy+doeVuqZzVhKi+UTO4Yfyg6x/SYwGpa2lSUkc9RwlfozgnMuD7UdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxLj3eko; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxLj3eko"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so54933255e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776245972; x=1776850772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wylQeg5hHwxb0C8yLQih5rfZGnRs2oIeCOYLEHEm7MY=;
        b=mxLj3ekoEoZMvYXmI76RRwDVJYQYGkv0irWTzttsRlUfHgjjxgLfVS9OOfn+tFIGeG
         aJBCSkQOTUzIIY3XLooUivoU7EubHgskqaWxBSMU2QbYmczDNlZTyuFOjPWWvmTmh45M
         IVaSeQlo6SoDELeoJBewdtKXf4b6h8dcxXlVf8W27+HW0ROG0MOKKwfDMM/BX/IVzy6O
         rhRG/pIhnjysjVohwSUx4sco3OxoHX/o+d0ZCJltasZKde84dbhnvWm69/QsKBYVKDw3
         AfaRZzIS1hRhDSG3t7aIAvSO9sgt2w+710Vs0D+Cu+LqVdB7skDrhcOSqH9DV5O7VbKw
         BCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245972; x=1776850772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wylQeg5hHwxb0C8yLQih5rfZGnRs2oIeCOYLEHEm7MY=;
        b=miDvBurkRsJId2VRf5yydufYw2IuFAhT2cePnudZagoFYGOo6ngWvtr7+UrHaeV7m2
         RTy2o0j6WOhwbFHHTijYPsUIXPxWcsOxCPXJiC7Iu6PdEdMgDBSaRXOsL+6k0ELgUqxR
         KlJH5u9nltUt1rLRwwygO65i52zzlr6Aq5Poy1bNsZfwWhY1BQMBWbF5476bKd0qdloC
         KtmLiABWjewMlU7p3Cs6igOF+v64kRPOQ6+a4aZ++uiBXcnjVPpii2xCJt6n5Pcgueun
         huEswZoMdWMhMXA7BPe7R8B47KlQ7ABxyhaDJ/x632VSTUDgJhRJLsek7pQEf63tP7Ta
         zo1w==
X-Forwarded-Encrypted: i=1; AFNElJ/q14a7aRj5AGQCmocEruFwqyp4hjRHxXb6VNNe46rMrUancFvHnp+ICAQBNdnLom8OCYsnxlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGNoEe4IzFJl6IrojjVv72q+ydn7LDNMHllhm6O8klHAFar+S
	KqD+KtHgMlhjBsj7p1DJcTdR8Xr6BvEHD5Bj+X95KByyzLBcg4zuZvheqg2aV0nxgttnrCMh9kI
	ryzJReVWTywBGXDDQiA==
X-Received: from wmi10.prod.google.com ([2002:a05:600c:20a:b0:480:6ceb:eb1b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:609a:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-488d68a10d7mr293106775e9.31.1776245971456;
 Wed, 15 Apr 2026 02:39:31 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:37:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG5c32kC/3WNyw7CIBQFf6VhLQYufcWV/2FcFLhtiRUUKtE0/
 XdpXTTGuJyTzJyJBPQGAzlkE/EYTTDOJhC7jKi+sR1SoxMTYFAywUoqjdXoqcVxMPZCVQ2cMwm
 trHKSpJvH1jzX4On8YY/3R+qO29ibMDr/Wk8jX9a//cgpo7pRKAupatHCsXOuG3Cv3JUsrQibn 7P6x4fkK6YFVJoXuSi+/Hme34ss4isCAQAA
X-Change-Id: 20260306-binder-netlink-c82110b2fb74
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2339; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=IE/wFKrBh0t+EGfYLJfkCLHJUyNnOYhBFTtA6ZYlxXU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp31zHSWyxY/7Yu5JlXYhq6gV3s2bmSeei2UZPp
 y7vinKoe82JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCad9cxwAKCRAEWL7uWMY5
 RsGnD/9RDu36LVp0jfJ+/mkIL8DHa3ilX1GGGzubgXByF4dOdVplrkytaRaHMObCnboxQwnW6/a
 skIz1h8ikL0TBcNXAv6+/aeXbQNLgaNfyN8a47THd1daADxsCoMML6P/QCc96NVWGHIF+6YWQ/F
 YWMyTjsPhyOJ0RsWgJY542iopqNZRo26MdkcTjDLVNtF9Fllln8HVh0mEBcJrWJo9Oi2eo950No
 WyxfqToSzOe8rdwQBszC2DnTjUdWNC9KUcPQNAkXuXN7s7o4Je3bNugR+KSKxv01gW08JpGko6S
 kBM4qXqLei6+EdqrRARVgsMR+npatqd1mRl5kR3F/NmE7JGvyL0XjjrttjH/gLmGORQLw0LbIIP
 rYkegJcjwlJ+9PYBlQDFDh0OxEZimbcgMB7EE7yFxeoQtsPv/vzEa2XcmlnAhtaevBmHPtpgSff
 5mBO5QvhzqxJ6TpT+MoFnvHFuA2Y35RxsEFP5oRRhOMKSvplnlfwwZzsC5NddgEsMZFUokSONKK
 z3OWUfk8TU1v3ruRAHz7uAlvSONuuR27TZ4JE3mg7BJRLr7FBfwD4fQoAXjr5B5UwNSQ1DeCD44
 sgvRZVoM1hRcP4SEO2KBzY0RZR0OZCHvsKEuD2gHm1rCFmrI2mbGW+4CKF+NmD80aY4bkDqW0g/ kS9GQxhhWQwwcvA==
X-Mailer: b4 0.14.3
Message-ID: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Subject: [PATCH v3 0/4] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The C Binder driver exposes messages over netlink when transactions
fail, so that a userpace daemon can respond to processes with many
failing transactions.

This patch series adds netlink support from Rust, then implements an
equivalent API in Rust Binder.

As Binder only uses broadcast messages, I did not add support for other
kinds of messages.

Based on char-misc-next.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
Alice Ryhl (3):
      rust: netlink: add raw netlink abstraction
      ynl_gen: generate Rust files from yaml files
      rust_binder: add generated netlink.rs file

Carlos Llamas (1):
      rust_binder: report netlink transactions

 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 113 ++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 +-
 drivers/android/binder/thread.rs           |  10 +
 drivers/android/binder/transaction.rs      |  40 ++++
 rust/bindings/bindings_helper.h            |   3 +
 rust/helpers/genetlink.c                   |  46 ++++
 rust/helpers/helpers.c                     |   1 +
 rust/kernel/lib.rs                         |   1 +
 rust/kernel/netlink.rs                     | 329 +++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 tools/net/ynl/pyynl/ynl_gen_c.py           | 139 +++++++++++-
 tools/net/ynl/ynl-regen.sh                 |   2 +-
 13 files changed, 690 insertions(+), 5 deletions(-)
---
base-commit: 0990a71f678aa0f045f2c126b39b6b581844d3b0
change-id: 20260306-binder-netlink-c82110b2fb74

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

