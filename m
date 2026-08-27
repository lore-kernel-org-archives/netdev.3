Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC963DD536
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874915; cv=none; b=s6iliuKaD1UZkySU+NiLOmRqcOWKMam4vIM+xCh1IMKePxiZxFrRLxJs02ymAivBeggaPNz3wTCMDbTF+0TOa08uLrZXm3cFPbpSuLhiFl1JpT6Q8HiXw7KxAen6uKEa7rbXFQ+VGBl6wNohqrqauGp5MeLUd6VgS+UGyAgglho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874915; c=relaxed/simple;
	bh=h27YVKK/TYuusXE6taFKqIAn5VyxSn/kotJtG8PpEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzoyD0s6LgvXIXaGMhDFvjQ0gGtoSD0EdVbrg23qPGVttunG4q9jCjFA0bJ/env1mQ9W6gINNUf6kJtzRGFVMaO9tsvnBe13Bbz6iZfssrNDKlQrDUdZHmDLF8Ns7a8joDwFtZpE3OVZhCYU7mEFlOMm5FuzNO1OFBkBj480E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLQV9XvF; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLQV9XvF"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66cf1f9965dso306023d50.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874913; x=1788479713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=kLQV9XvFAFdSVgqCBBMav4u7yyVUl9B106WF7pEaIjoaVjR36RWCvJOyFkKOYLwSYC
         XeTjjTaHxmqjDWR9V3NPoLvqLmtt6Z43dU/wjEfOtshfAXQrZ0acatlEscg6uy2h714x
         d7uiB1SffbO0UaJvTFWYOFBPnyVgYBphj5pkPEBwhX/fFUGSzugmKjvacgX+ztmQvtuD
         5kPA4sjnGAaHD9jPPMTaJ80IMryuuWysV95/8WfYDlQusgtTTyXCjA9yWJOkeI3A/v8h
         rPXPUvsw2q0lK1W8YWFvsCKJspoHf5e1LYwy3zt/R37idJBkGJfnZ+Id4DHjwD2a/gK+
         yCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874913; x=1788479713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCfWHkIpmLvJEZNt0kO4ZWyCArHHxMdSOeCJ5Kkvn7k=;
        b=oFMAQPlE3NEdoZRXXIPXH0f9eCwfXMJdlBzABCROF5vDYkea/Z1lypFEz4oRi1uSj7
         JfJGC8axStjVmv4xWK95c2rUVxMMPbeD+E6boXK1ib8x7huleJn7MhInkB+0Mu3uONUR
         6AGTemk9E5fRY4Me/tAsLIBK4PNKgIb3sqE9wh0r0C6HHZwN3knAAPsHtlAkljbrJCKv
         die7UWV7jVAgUsowUuGOrFxrarwVlyoxJqCRBe67M6xsFky5yXNIUfQiC0ZzDjZuabxo
         tqne3aeyj4y1Y12bKxbAWwGu3lm4c+hl8wkhJ9CuyyiGeODbBE5w9vpd28vYq28mwTEu
         Ombw==
X-Forwarded-Encrypted: i=1; AHgh+RphDpTYM9Yy20X0BSnSEA7+7UiswSMWp+8jBOxDardVHd5J2Jc4owE6I/e0AF4ZXsKQqSHMEfc=@vger.kernel.org
X-Gm-Message-State: AFuF++lzhcnOrbNmIeiMxEwGC9JqKnI1VR99lCn/oHTYxRkb8raVLkLl
	uMLSE/y1qFrqAKbRu7FMmNnIw7BX64gmdvAwDcezMkpUoN564ZkhZXra
X-Gm-Gg: AR+sD10hYpeO9IxmzVtNeG5i/7OT67CJsxyLUbyqGDtERX+COlrcPjKvyyIOtIXhn++
	+gKX+wuDiYbIcHKWOUPpNRswyhTIWwgF8NEUsLofQ1nWp0PPcbIr4+b3rOnVNMTDgcWnpw4OFFs
	NixoX3zcylXyq37Gxwsmh+cFQ5CeVK7+GoYrXC2ELtuN5Q0fWxXHmu4c+F0bWZzKAaxk44bzY7t
	ZJ9NbxU64hiLbjUKitd8Q19hQytz1EFZOA/xrvJGOR36InzhQUJ9/799LVXOjlXl5cMWFpN7Erz
	iItnvoG0ot7OsOhJ5Oz/O2LqlIcC8twrJTe5Z0gy0E+MQ/aUXf89FS3EIkBeDKhGnutxBRUVULc
	oyZ8QlP0XB19Vg2yzBVgU5KFFPnEc+3RMagY1gX9F4mFXObVkpCyIrnU1lbIXpYIj21peYnT74f
	UuQFwD/QhrAbZE9GXuqyV4IYFsQlUDktazm0HmZoh3SN+y7eXjX3l+SCqcqGTRwYM05n0=
X-Received: by 2002:a05:690e:428b:10b0:66c:d353:948a with SMTP id 956f58d0204a3-66e4c7645d8mr742101d50.39.1787874913018;
        Thu, 27 Aug 2026 16:55:13 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Thu, 27 Aug 2026 19:55:09 -0400
Message-ID: <cover.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
struct_ops congestion control made icsk_ca_ops point to dynamically
allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
the pointer and free the old object while either reader is using it.

Patch 1 fixes the TCP_CONGESTION path by copying ca_ops->name to a
stack buffer while holding rcu_read_lock(). It also uses READ_ONCE()
for the lockless load and annotates the relevant icsk_ca_ops stores
with WRITE_ONCE().

Patch 2 fixes the TCP_CC_INFO path by keeping the READ_ONCE() load,
ca_ops->get_info lookup, and call inside an RCU read-side critical
section.

Changes since v2 [1]:
- Fix the TCP_CONGESTION build failure by loading icsk_ca_ops inline.
- Drop the unrelated WRITE_ONCE() conversion in mptcp_ca_reset().
- Add READ_ONCE() to dctcp_get_info()'s icsk_ca_ops comparison.

Changes in v2 [2]:
- Add READ_ONCE() to both lockless icsk_ca_ops loads.
- Add WRITE_ONCE() to all six explicit icsk_ca_ops stores.
- Include the data-race annotations in the UAF series as requested
  by Eric Dumazet [3].

[1] https://lore.kernel.org/all/20260826171344.4133-1-blbllhy@gmail.com/
[2] https://lore.kernel.org/all/20260821182449.79785-1-blbllhy@gmail.com/
[3] https://lore.kernel.org/all/CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com/

Cen Zhang (Microsoft Security FORGE Labs) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c           | 18 ++++++++++++++----
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  4 ++--
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 5 files changed, 20 insertions(+), 10 deletions(-)


base-commit: a3dee9bb902ee4357fa02e49b415d7724ee0140a
-- 
2.43.0
