Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629387;
	b=2Chek7pf6UfqOO2PthGEs8RX+xwol/hVGZGVp9OchNOBCwcIEx/FhNexKwF59HlsJfIJ
	 360hIimbj8ZufZctaOfkp77VanAFIOPffNMgaDkVkHkKMr9Qav6rNl0ZAE24MLyUTkeK0
	 2zkCQU0JUAKpX+S6w07bHxdljSAk9rxOtk1uS4J5i5ns1GzV/HMYFcKUjpwxDdWh6p7ta
	 tVN1KiGrd2BPd0QeAuPpfSe02WHd/xlMvmv/V/kUu+uehGQUuy72Txg8CbMpQBFCCzMd4
	 YMNl+g9/9Glr+fHbWrqC56lKpvxAm71NhoGMb5NzhBxImMmDrw2HGbxqU1adeLLu1Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=33fNufN6J4OClTS1Du1UDknamLb+kOZ8wd0azYoYamM=;
	b=cP+fRNFZjOyuas7kYNHTy/qxDXRdLs7Y1F2DYpUSRknd8xKBE48fPV7lKuF+wxu+wMk9
	 bdOQNcpfQ1SSalm/GUOlPw59gbJNuj0KSUEhINz3kFhEjJqAI79CUocW3YcBX0q9TmoCf
	 4hPJ08K7+MCOq5i34Kl9lZ6EM30z1vu8+jzhjetzP0S0nwW/siLRtjm9wo+Hson4rQJec
	 HpcNvOMKIpF3xFHDJfSzDR4pckGDWs177v5WQVeE/LY1vA77y5jIzAJo3oWmKrdqEqKEf
	 LlWlsxw3Kd7fUnkf9wGYkIwDfiVdhqIOrrI/e12On7XhhTF43V135pbtU9vTE2ypWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S6A2Xi/L";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27931606A32D
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27931606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6A2Xi/L
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492690dd5daso1921633f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794629385; x=1795234185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=33fNufN6J4OClTS1Du1UDknamLb+kOZ8wd0azYoYamM=;
        b=S6A2Xi/LXuCFkKwROypO0c3cn89KvuCCBgwHpH6yE+mMnsA8kxIzYltEY5urVlaxNH
         6P/iWoz183vYHE0sDmjf7eYtNqb2bh0Dm14ikLaOKFjxahwDbLcCoSv3Z/78sxfloGuc
         NPlULsM9gV1wwSLEhlwuc0SonBRKOr6p/vRLuz+gy3LkCN3/E63UXWcfUVE6RIJ7rc0Q
         QNw+EgNU4IKQ3ZBEoAc8prQETiG+b/4rwdHveCErOwUGqTrTZAgNynRDSUVnDTZF+14d
         LIfsa+CrKPExtY/CC3ckyBjOKPxtrvOfw1+RtRpSabANdkBi4N1UWkdFA2I8eQiFMLye
         vaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794629385; x=1795234185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33fNufN6J4OClTS1Du1UDknamLb+kOZ8wd0azYoYamM=;
        b=sZv/quzg/1oqtcLuNopWFG5bkEHPiNFW40RSQTir2MHvgHLVb4plKwTYOgH2XKFH/Z
         FFo8LkHxXlIt6y3bLuFM1vXPbWGYCw5ch1mb010yZKcpfZfSGuGxDSiZ8aqatjS+rVlZ
         7uxTC4G4nMbsqb2MdIdIuQwIDRgmeWwDQjF4CBFV0YlD8Fxr9me7CWc8sdlco2KtpFLC
         dL0hIRGa+18BtOpGhSvnVsWwDMQEtQ91Sp7fcyKjYjX2lL7pMEYExkdIGqVgjUwAlIBS
         Zsx24HVWDZKQUwB/kzuvYYu4s6K3TceGUtVkg0RlKM+yiGc2bWcEPzQxilV4i3QJFbOR
         25ww==
X-Forwarded-Encrypted: i=1; AL+hErFDZvXPHHZbH0eBHMImNVGzGOK6krMixxx0iI1Pt1Z1N4ti5jhWWQM8vksiRwB2Y3SCZOtkHwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cIwPtq69wMKWrck8/0QkpyNIfeJIxqiR3db2aSWjsUkS//LgN
	om41HmQQo/k/mFOveTWIKm/o+UuSc6KXJIMeMSdliQO2aJqiP1MDAhTq
X-Gm-Gg: AYBFou12xjGuaVH9q7rcADxe/P69VeMRMVTNxkzNpAkaaMvx4vlgfLswOEqTOjUdSCy
	1bO09X60AJ2sekB1v75alVrsxT4vqLnq8S1qzZvc17tvmaV6sB3CCWnJqUVbnxrY+EWCXtMDCD0
	jJGZR6jvEbwKiTKUUD0moC/b2ksulZn1HiPWKPkNbZYy1FTA92gFBwgQUIlw6657bTXl33EC7WG
	ySB40UDPiFiWM8iR4crwYc1bojB1Q5J6Q4Ofw6nFrRdcWBN7Ln1WJPwxfY2B3u6q++oOTTTA7ze
	zDYxBAW8g23ZPF0Tqw8XA8szqOYaxjt1mw5Zj5fH2nn7gIwo0zIHer9ulAzqljsDzCtWay73zTb
	y7s5nubSMN0or47MFvH31nVt+1NEDUEzIgpXTB94QQDkQPWw3RcimAUuC+v6jr6j9BxU7CaO83P
	IOVDHLf4/ALsa/9u4B3XPeP1tEXXvVM3gmkyHg1H9CYj+f5u2r+mase7xTg4a48h3DX/zjVKlKc
	OlNVQtiQ+37kKA4VZDJ4H98+lEnWuQkK1vw00E3uddUG8OOQCYcYlIihGp5umBDmUs3Pxv6sZ8j
	vnRw1V+C7xB8b1eAUrsSa6YI4aaGVSJphPzabfbsoMRNT5FLLD6GK4wP8NItnfc=
X-Received: by 2002:a5d:5f92:0:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-49c6d4539c8mr9740640f8f.1.1794629385233;
        Fri, 13 Nov 2026 20:09:45 -0800 (PST)
Received: from demian.play.pl (83-175-177-170.dynamic.play.pl. [83.175.177.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm8488670f8f.46.2026.11.13.20.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 20:09:44 -0800 (PST)
From: Demian Shulhan <demyansh@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Saeed Bishara <saeed.bishara.os@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: csum: Add fused copy and Internet checksum
Date: Sat, 14 Nov 2026 03:56:59 +0000
Message-ID: <20261114040943.219870-1-demyansh@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a single-pass csum_partial_copy_nocheck() implementation for arm64
and extend the checksum KUnit suite to cover copy-and-checksum across
alignments, lengths, guard pages, and interrupt contexts.

Changes in v2:
- Drop the NEON path and separate csum-copy* files, folding the scalar
  implementation directly into arch/arm64/lib/csum.c (resolves the
  <asm/neon-intrinsics.h> include issue noted by Nathan Chancellor).
- Switch the scalar loop to four __uint128_t accumulators (David Laight).
- Canonicalize 0xffff (-0) to 0x0000 (+0) after csum_fold() in KUnit to
  fix x86_64 test failures on zero/all-zero inputs (Jakub Kicinski).

Link: https://lore.kernel.org/r/20260927131838.6774-1-demyansh@gmail.com

Demian Shulhan (2):
  arm64: csum: Add fused copy and Internet checksum
  lib/tests: checksum: Add KUnit tests for csum_partial_copy_nocheck()

 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/csum.c             | 100 ++++++++
 lib/Kconfig.debug                 |  10 +
 lib/tests/checksum_kunit.c        | 410 ++++++++++++++++++++++++++++++
 4 files changed, 523 insertions(+)


base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.53.0

