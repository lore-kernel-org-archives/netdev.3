Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586865;
	b=ghnpa+BN6NoqJliAOJWPRESZ1IUw3U5hK3bnwfYH6+HYlTK8P5OnI48WI/3Qq51A1158
	 wDzqUNsR4k9p9EChujktHz79RqaRvjprVMHMl1wS7Vsxq31aGrlVPHOaYqNflZ+TIFtXI
	 5FAKAhlEG7Eoq3AG1iadnZRRpe1cgp49TkpWASYBEBQZdxhnEQlqKTnh4Axz4Hh8AWe+N
	 CwZyw1omz3AOdWWDPWhxwC/XNEGny8OtXg2QOVqGJTCogWh+TVNsTt496lA+9zIXoeZFI
	 N+COxFwu5RrQiSxgXHqKIeqFG2CmMUi7mcXmivtKA3NoUYazzjzT/ag10EV/WqYcMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=jcXZeohxAIFBM+DT+2XS+2Cn8sRbyJyVTv9pyoAeGjc=;
	b=M4zAM88U0Mb/QGOZHgPfzTuQPnIhviXuB6vD8qrRJOt0litopshOd4hBibA/FkfP3qtu
	 TaVz8nNPl61Jrc6ANU8g+9u2BFqzZ1O48z7cm1wXmzFXungLTUxZunfHMVVejAFqTOnu9
	 kWNZ5LeIJzmqBTBU05B09n5f7zbXexNr2Mt92c5IS4c6jpUMk9Kix/6kjeReS4CgTdfQE
	 43n5vykKi8QbAzrvAKFDG4/DzVJK0wfpyiPJy5FGJRhWMnqUzCsoAIWFSU+WbxzlXRS2F
	 0yVe9QgRZBUbwi2Zx2YYU7y7hJoJhf/ILo2rm5+wBv7OC6Uq92scwGpZAG2FU6gk7BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZNbBgyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080EB606A324;
	Mon,  2 Nov 2026 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZNbBgyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF23B1F00919;
	Mon,  2 Nov 2026 02:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793586864;
	bh=jcXZeohxAIFBM+DT+2XS+2Cn8sRbyJyVTv9pyoAeGjc=;
	h=From:To:Cc:Subject:Date;
	b=mZNbBgyQBohyGjZP6AUIDgdJ78BGJP3ZgtfLnzOsIV0ovUWGWdYidVgZLpu4b54fU
	 w9mH4RmfywXwNQnb4hJm+oNgGRXaZyZkvKAqz1h5tfjNZ64xNi+v/g/2mVFZcOAnwL
	 QqhawVGC2D0rl+eysO/hrErx7vZwV3EAqwPAXXU3w40D3PUFcoLXzQ9ArR45lwdRJF
	 0fD1sn5XZRCw0YMp3i8LaCxrzJvJnr9zQNDxaIOc8MzdYTszICk1YazVPWwDC4cV7Q
	 Upxt6SNArZ/cU/mzNC8aqrpbtwBhSGSUAqIN3J8Gm7eNOG9g9QcpbtELvg0JfVWykS
	 T0WWtgDy+0hbg==
From: Thorsten Blum <blum@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: Thorsten Blum <blum@kernel.org>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rust: netlink: remove unnecessary bitfield transmutes
Date: Mon,  2 Nov 2026 03:33:03 +0100
Message-ID: <20261102023301.206989-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=blum@kernel.org; h=from:subject; bh=bRm8U3vpmT6DJ0TbkT6MnWE0+weMgPJUFtHCSGNaBy8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnPv8WGlvndczVjmL76WdMN94+CV3kF9Jo7apO82L42P Gl/GWPYUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNRP8jIcO3b3v1XulKDYiZf 7fyh9rlAvi26fG5lj3xcqvob4YKb3xn+6TRnKL3acdXQ1sPd2XrLdve55ydG/SjazfGcmTFtyel ETgA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use __BindgenBitfieldUnit::new() to build the bitfield.

Since the generated type implements PartialEq, compare the bitfields
directly in test_family_flags_bitfield().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
test_family_flags_bitfield() still passes.

 rust/kernel/net/netlink.rs | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
index 2f8733a694a9..d0c79a254f12 100644
--- a/rust/kernel/net/netlink.rs
+++ b/rust/kernel/net/netlink.rs
@@ -180,8 +180,7 @@ impl FamilyFlags {
         }
         // Convert from little endian to the target's endianness.
         bits = u8::from_le(bits);
-        // SAFETY: This bitfield is represented as an u8.
-        unsafe { core::mem::transmute::<u8, bindings::__BindgenBitfieldUnit<[u8; 1]>>(bits) }
+        bindings::__BindgenBitfieldUnit::new([bits])
     }
 }
 
@@ -335,11 +334,7 @@ fn test_family_flags_bitfield() {
                 }
                 .into_bitfield();
 
-                // SAFETY: The bit field is stored as u8.
-                let b_val: u8 = unsafe { core::mem::transmute(b_fam._bitfield_1) };
-                // SAFETY: The bit field is stored as u8.
-                let c_val: u8 = unsafe { core::mem::transmute(c_bitfield) };
-                assert_eq!(b_val, c_val);
+                assert_eq!(b_fam._bitfield_1, c_bitfield);
             }
         }
     }
