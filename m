Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392748097B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944895; cv=none; b=rZjFIyVjOI0n/RqjiAEpCY0JFj0z8bVuBUSlsZSGFuUH+BhgTSRbRkNWF/wo+Zn2UYQ1ALTur0V5dSbF07XzhL/Erp8DhM6KTu9daTx+SopCVUGeCmzvTyUf+02dQIpL6ak6eEY9USmkgiM8A5UsR93+UnROknZlzrXl64WmvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944895; c=relaxed/simple;
	bh=68qYbczBueHVv/P6+UWfWaOWkPxS/jHnPq9HGdYVNCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hN5p7ZZT/s8xpH0woXbPXp1yU8H0fUSjnIalIjVR5ZfkmkZWFNSrTF2xYPo+m1OSF2ljcKV0c6W2kYl11L072C4Hf/awtv9EtgSTAPQaMw2sHtlek/SRQK0yhmOl07hK4yp4Lo+ZBCyb7uXVVHf+WOlF7FsSHZaDwdwR1GxmSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=hfum0goS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="hfum0goS"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed073fed0so15640587b3.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785944891; x=1786549691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9L9rwIOD/mR/CCIK6jMEVGbHhQt3xSkLQZawApQTovE=;
        b=hfum0goS38xCiaNrnoqIzBZ5BA+/NB/PXKbWPhZr1PvTblCARiHnjPf4pIWP5tNR56
         7NW4bUBHVbqVfLGvhWfdruYHo1b1S1xLPGJxl6nQ4PvRJqIGUVnJyJJZsLkXZL9RLj4m
         uP996GeIMop5FvNqVIjNAo/jfZC4Af3jkBKxxtTC6Dg05SLkK64NQJwkV5yn6fX1dwMh
         jkJVBKdn7YFRWClFWZAQ8B4ZJq+0mVnrUx6gZUPdEmKsYXISGjSNS1KoHdl7UthpTf0u
         sL8ggXZxsLNBcBazd9+2GxbteLh1uW5ywfvrSnIwf71SafdbXcMr4et9PLvHnBZYnaek
         jk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785944891; x=1786549691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9L9rwIOD/mR/CCIK6jMEVGbHhQt3xSkLQZawApQTovE=;
        b=pRcywEmQr7jplTFoBbO96GSDTa/iYhKU9XRMfIJbDVp/0mO2P3G3xBDJBpy65xtuuI
         i99oo8qaNVK+f5oUs1zwhPN1Gy6CcJVBBTixBj+6Z41hYCOnchCs3xJby3qSCh8SrFYf
         4CvLk/yAUf8vFJqzW9+SFUX1HUGAZVuPZ/xy6p6J9avynINaWS1cbmLslqNTtMDGdvh5
         cucdoCVDKRZ30Jba9hhedk7DkaxBHsRpBUsSV9OI27kwbuT5xCNYgM57XwprZ8A4Woib
         6Yc6a1GhoHH22axYDITJPJQmoZguxd87mV3ZEYJYbR6TJv5mC2nXKOjTQH5ehY4y6AJp
         kwyg==
X-Gm-Message-State: AOJu0YwnZ9DQOVICjHj7vNRke0rGL9WXOdTABMThItL0mqpa3T/meuj6
	5K1BW3YMAN0aHPTCC2Einipg6Lfdy5FSQJpZt78JNJlMMs4Cxw/pJp7Zy9zfLESYWPUqk+GddEa
	i2DCS
X-Gm-Gg: AR+sD12hFdmXewtL5Ylja5rxc6UZ456XyvjOQytO77Ta4mAQM+Mt30w+DGQ4b5GV4ZW
	rGTW5htF7nt4dzECMhAhVInynHMhFu8bybBH9NW4lxwd3uAQcvLuSoL9fQVKQ8aFZGVSGe24Nb3
	xmbw/cGGuPDQ/2bCyq8xVZO6AEp7vnBiES1Y4ASyTsaUHw2Ec5VKyeT36OuQ7++P7a38O0J5fXq
	jwLCcD8xbtWfQseHXMskyPtbPAN1U/qg1zr9oNCIhO08KIGj/CZferK18gDyjzBY7oYuCYe7rm5
	N5O+wWR2MCzTs1ai7R9VFJFDlzVfqQpZD/XSo+W9T6T4D8KHsWj/qaRZIg9f5YVJyU5MimQZzY9
	j80L3TVborl8UtMJ899+pfBcTdZwI4XQCrkjYgyAciYhzVi5fYOnqkmJ1F20MqGoA9Ox2zBiBBZ
	6WFxDWWVnAQ9m7fLUqQ+EH+dQiTd5Hma0Rs/nEdm2RH54R09OocVx0U3AFwUu7X4VpvtS75oBQY
	n30HI3zQwZocOisZ6+5kfZ+mjU=
X-Received: by 2002:a05:690c:e0ca:b0:821:e0a:6cd9 with SMTP id 00721157ae682-8210e0a7c2bmr9742477b3.17.1785944891012;
        Wed, 05 Aug 2026 08:48:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82012f4ea2esm23436957b3.0.2026.08.05.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:48:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] SECURITY: add threat model
Date: Wed,  5 Aug 2026 08:48:07 -0700
Message-ID: <20260805154807.48866-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some new paragraphs to the SECURITY file describing the
threat model. This may help reduce bogus security vulnerability
reports generated by AI.

This text is AI generated mostly for AI consumption.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 SECURITY.md | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index d5a7775f..7e771275 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -12,6 +12,79 @@ and are best handled via
 For other issues please report bugs to netdev@vger.kernel.org
 and include an example script.
 
+Please read the threat model below first. A report should say which
+version or commit was used, and which privilege boundary is crossed:
+who the attacker is, and what they gain that they did not already have.
+Reports that do not identify a boundary will be handled as ordinary bugs
+on the mailing list.
+
+## Threat model
+
+The iproute2 utilities (ip, tc, ss, bridge, devlink, rdma, dcb and the
+rest) are ordinary command line programs. They run with the credentials
+of the invoking user, and they should not be installed setuid or setgid.
+
+Privileged operations are not performed by these programs. They are
+performed by the kernel, which does its own capability check
+(CAP_NET_ADMIN and friends) on the netlink socket. There is no privilege
+boundary inside any iproute2 binary. Anything a user can make iproute2 do
+through command line arguments, environment variables, or its own
+configuration files, that user could already do with a program they wrote
+themselves.
+
+The boundary that does exist is data arriving from the kernel: netlink
+replies and dumps, and procfs and sysfs content. That data may be
+truncated, of unexpected type or length, or contain names chosen by
+unprivileged users in another namespace.
+
+### In scope
+
+- Out of bounds access, memory corruption, or unbounded allocation while
+  parsing netlink, procfs or sysfs data.
+- Unsafe file handling (symlink following, TOCTOU) on paths that a less
+  privileged user can influence, for example under the netns run
+  directory.
+
+### Serious, but not usually a vulnerability
+
+These are fixed with priority, and are reported to netdev like any other
+bug. A CVE is unlikely because no privilege boundary is crossed.
+
+- A command that misreports state, or that silently applies something
+  other than what was requested. An operator may believe a route, rule or
+  filter is installed when it is not. The case where the result is more
+  permissive than requested gets the most attention.
+- "ip netns exec", "ip vrf exec" and similar failing to establish the
+  intended environment before exec, so the child runs somewhere other
+  than where the operator expected. The caller was already privileged, so
+  this is a containment failure rather than an escalation.
+- Monitor commands (ip monitor, tc monitor, bridge monitor, ss) aborting
+  or looping on unexpected, truncated or unknown netlink messages. These
+  are long lived and consume events generated elsewhere on the system, so
+  losing one is a monitoring gap.
+
+### Not in scope
+
+- Anything reached only through the command line. Crashes, overflows,
+  assertion failures and format string issues reached through argv are
+  bugs to be fixed, not vulnerabilities, because the caller already has
+  the privileges of the process.
+- Anything requiring root or CAP_NET_ADMIN to trigger. That is a trusted
+  caller.
+- Anything requiring write access to /etc/iproute2, to the binaries, or
+  to the library path. That is root already.
+- Memory not freed before exit. These are short lived processes.
+- sudo or doas rules that grant ip, tc or bridge. Granting those is
+  equivalent to granting root by design: "ip netns exec" and "tc exec"
+  run arbitrary commands, and the -batch option reads a file of them.
+- File capabilities applied to iproute2 binaries. This creates a
+  privilege boundary that does not otherwise exist and is not supported.
+- Terminal escape sequences in names originating from the kernel. Output
+  is not sanitized for terminals. Use -json if the consumer is not a
+  human.
+- Static analysis or language model output with no reproducer and no
+  identified attacker.
+
 ## Supported Versions
 
 There are no official "Long Term Support" versions for iproute2.
-- 
2.53.0

