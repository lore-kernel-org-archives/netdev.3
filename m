Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308430;
	b=Q3kLLBedKfcfMjggYUbCpnKiiLmC2ZfoXFzOzOETPDW7WOz8Ic4NhcqLRVyZKaQ26U0R
	 I/+YiUpkfzA8ohcTLaeNYuts6qs0UNGS1KvDao5vR6ZdTy8MiHx3f7ojr+h9SBEDArAcf
	 QqDmrNCP+4MS4cYRlhiofcYxD4BYSikBGe5rIK0CMP63GXezuccP8E+h7deXuQzr2Mi6u
	 27MWWk/ro+TRsO2qPEnZ6KrmsZWVDVQ5oGkKgnMICMztTE+gdADAcwX5xRmyTN3+1fPUu
	 UBvhFBFSlU9zBoSZyaw0Ilk3toCAolFHLpJvcMX5GxfQWUjb+SWB5FM2vOKnI4NHnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=VbVGUB3IRAFoe3Oztm5dCzRoAL2gir1+wqkvM8dJQDg=;
	b=B3A7+mUHiu/O5K+IFntz/gVmX4+w6n+oskMXZxw4RVDWAu41RwJ9YycX9vgAcP5QqUrS
	 z9jekN8RGR965n8e69cnpoj5g9BYasqJvPrCv3elDwwYEOWT5I8Aw+4dfU8kFuXvNXiPn
	 Szhel31U9wWIe2Ihqr846+FL5XRpcbJiU+TBF8T/Cv6rG93bjDAgZs6pbo9U5pRTQeZiB
	 +AIn1Peu3vzWHrDRIyVAnyfrAEhBWlwnKIuAjTl2DxgmxGK0R1v9jk/YiIxBzkyeluVZ1
	 9ycyGwQMH99oShK5xh62oQOVWtUo9oqam671eAfshSB0jG6uOoF9SDs6USPiqGr5Zgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dECL2K89;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBA60A2602
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBBA60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dECL2K89
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so1329241b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308429; x=1794913229; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VbVGUB3IRAFoe3Oztm5dCzRoAL2gir1+wqkvM8dJQDg=;
        b=dECL2K89EqGowjtmI85fE1kGXTnL5DUZVS2wH51Rwra2wZRbiG0W8bu8tMMkigTC7U
         awRTsHAOB285Gdu1rbosZ7/4APLkYRQhFtagGq1XTpo/z+toUUaI2p4RkbrZdeGmn68j
         m+5Ci5V9wFQPF06o6KfXcpkOC6lr9uUPcRyvNTBQ1XQxGqSfoPQeOeGhB/WuI/ymDPRe
         s8rUbIIqqFqUUL4UloiNOjCgAuntR46wZeHIjWTrUfFUSoyZ6vabDBMBotOG8EAilzH+
         66N6JtHLCZSe/6KOg2mh81PjYmyjW9wcN53gLi+dKBOkQlJmMvo8ZTBsF5Gk1zLbvFEs
         V44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308429; x=1794913229;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VbVGUB3IRAFoe3Oztm5dCzRoAL2gir1+wqkvM8dJQDg=;
        b=WFffUjVoub6FR/mYSezjn1EQIFv1COeT1Gz3SlaOkUlKocorIxALKBzEp8ebY+fLuk
         QlWz6PV1wi21SsnMFjPkNLNTsqJ7uymIIBmrLyUthf686BR3h4hVBLuDgM/xE3RL/4SJ
         IoyieylchwCfPQ0tcyMIZ5aL2UGQXEA4JJ20LYF0WC2KRTALzX4abx3+gbq143QLfoFA
         4B0IhTmMUoUrPbuJeUx20bJTwpNQ1nMxOLnyydDp0FrPgQFYVcsiNqrXtZ8ScMXdxCUT
         IjVvBrKktHdKqk6lmdlKImXOZ3qe6WAfxez0q0fUrcyIA0bV3MOoFLMTyUpw8aeVlpjU
         ztuw==
X-Gm-Message-State: APuU4Z9j7w1D897kOK2oXVYe7ERFlK0RZQBYKyBMWtnudqEHwxB66DIV
	qvYpDjwGwBPsXYHJri1UDRldSzBrKWrlD23pcHncArfxyHas7PDfB7jZ
X-Gm-Gg: AYBFou0YoCIsXmz3C5brQ69UwUWUGjmakAKfqAfvrZuQWdx2ynUmSd7hJWjYbzA6Koq
	3YUmoZnzWRrfo1RcSHvePf1VzorttTfucKuyfXw/X2YLC++ASaq2MX3eqAO6R0G5ofL3/VYN3Hu
	RS+6FFjagfozs26yU8EBWSnzHdZJoRVdt8j1zIifEINRKr62FKf/fnjnc/YgqhioNhpHpQ3bIFo
	ut/3JgjaJqoCK8VabuR+m8NrsytkNhvIaZ6uWnhJSU0UcZMaN3sqflfvgDtxHuAQikugLSw1uN8
	hLnF7ONC/574/Fluv/X3PXRHxNLDsJMZnTrN79Egno+poM/5iq2ugf6YBitZRm95yORl2cLtTw0
	HAEBvEyyB26o8UPeVG0gZArzmCBeVqIvbvYGChvOwD5sIGGB8gS+9d5wNmH/QxDoBuXt2WQqoLa
	ByWTPhS6sZoR6xMyB8CORoAD8Ad71qwy8zOrAW2tHdMwifjiiJBNRl3zUNbOOpNRA8ESRG5fe1I
	sTU9tGwyJQW2Je4fz48JJgaV56aSVMaiI19fSOvrILdT2SR52ffRB30JOSRvyRrBO66D74VVdz7
	Ggx6JEActPtHcU/qJ58j8ow9D6RBJuKmgCllunGnhvYlJRCMM89xqYQiOPdCzYX37mPyE0zPk/e
	5RyR7viHCbHzSxdTiq9NqX8FeWvWniwWqXHvbck5PmhE6gxDopu71FY9/EBmVq1hSZ+s3rtyFfd
	apJSYs
X-Received: by 2002:a05:6a00:1817:b0:89f:e64f:c34a with SMTP id d2e1a72fcca58-8ba8a6e5212mr2359802b3a.46.1794308428472;
        Tue, 10 Nov 2026 03:00:28 -0800 (PST)
Received: from [169.254.3.1] ([143.248.188.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de768fsm740596b3a.6.2026.11.10.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:00:27 -0800 (PST)
From: SeungJong Ha <engineer.jjhama@gmail.com>
Subject: [PATCH net-next 0/2] rust: net: phy: soft_reset and
 match_phy_device may run without phy_device->lock
Date: Tue, 10 Nov 2026 19:59:25 +0900
Message-Id: <20261110-exp-phy-rs-maybelocked-v1-0-3023cc9055e9@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA358moC/yWM2wrCMBAFf6XsswtNRSH+iviQy6mNlzRko6SU/
 rtRH4dhZiVBDhA6dStlvIOEOTZQu47cZOIVHHxjGvrhqJTqGTVxmhbOwk+zWDxmd4dn791Ba73
 HaA21OGWMof7GZ4ooHFELXf5GXvYGV75f2rYPOElOXIQAAAA=
X-Change-ID: 20261110-exp-phy-rs-maybelocked-ddc59993efba
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, SeungJong Ha <engineer.jjhama@gmail.com>
X-Mailer: b4 0.15.2

While auditing the SAFETY comments of Rust abstractions against their C
callers, and confirming the result with Clang's context analysis [1], it
turned out that PHYLIB calls `soft_reset` and `match_phy_device` both
with and without `phy_device->lock`, while the Rust side assumes it is
held.

No driver is affected, but it seems better for the abstraction to tell
the two cases apart. Patch 1 makes `Device` generic over a lock context,
as `device::Device` is, and patch 2 gives these two callbacks the
`MaybeLocked` one.

The audit, the patches and their changelogs were done with an AI coding
assistant (Claude Code, Claude Opus 5.5); the lock-less paths were then
checked with Clang 23 context analysis as described in patch 2.

[1] https://docs.kernel.org/dev-tools/context-analysis.html

---
SeungJong Ha (2):
      rust: net: phy: make Device generic over a lock context
      rust: net: phy: pass a MaybeLocked device to soft_reset and match_phy_device

 drivers/net/phy/ax88796b_rust.rs |   8 +-
 rust/kernel/net/phy.rs           | 183 ++++++++++++++++++++++++++++-----------
 rust/kernel/net/phy/reg.rs       |  17 ++--
 3 files changed, 145 insertions(+), 63 deletions(-)
---
base-commit: 2d916a8c307c31b433318509bf0311d52d509f09
change-id: 20261110-exp-phy-rs-maybelocked-ddc59993efba

Best regards,
--  
SeungJong Ha <engineer.jjhama@gmail.com>

