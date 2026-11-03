Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676979;
	b=0xSaYE0Yvo6e8Yph28OJsnvCWTdteaDRY9IGK328fVfMUgZ/sapWXxPUlzdRHw08zRFk
	 lFyLOiGPb23whAQUfToCb6vjzzJiFGcYdGZLB6vrp4o4fjzl8CK5GW3JhIBPrQWUYUW6a
	 0PxdCXwx5NtX+deBv7yNdwzAVowaBqBjG9Fu4eKK8x4z+AaD1FeB82ZSY00DN4ew1MeAY
	 HE8MJOJqt//K1cH5hZRGBWxWjSELHJX30k42dETdUyxQfo/XFWSlNTHQgAcsL/eX/1INh
	 jjwvKzEtn/u6ys+f7aElcHr3tQx8Y8S5U6SFZVF25bcnej4oNwspN1k36Q+qNFKzg/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
	b=lKvV1rlHcAjElV/r/wOTqutKB3htu2bs4w7vWF4ZvptdkC+n+0Sg/7lyRr4+Nf9ambbi
	 HWjDxzY4nKmlhB4Y1zLkrxpr4fiZzczQ/a01jYOJRKXwGiJObAZdor2Miznb/W0rT4DXm
	 pU+XBCcx2fqGDx3/Qenc9xn232E2BcECSoeo6ZFzdIxemSfBvzrsA/qxPTOBv5oYuGHH9
	 rqTZyWvLjVv2NI7fy7vUsyH9A4hx9T/McN6wYnMENy1UjK/AtdiiIqkpliZ5PnrLWajs6
	 0Vpg9fl+U9fUH37lBCAdfdvSyAr+qjasB3lot4JWPXl0QBM/yn7scOHqmXuG3Uwsdeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sc76JSK4;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB621606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 03:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB621606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sc76JSK4
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso2415348137.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 19:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676977; x=1794281777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
        b=Sc76JSK4zjl2ETNUSMOYa1pklyS18Uew1akrbZZzlCb8K9hW1lB/uHYD3GcM4cGgZn
         KqLZKHrW+2IFnD9oKBqzpbRSWOhzv9P8gEph0+Blr1rHNpOETEpr40sAzBAnHwFNnWfT
         pVsT7EegLiqt0IG2riv/99Kmj2ZTvz4BaxAYn7mWlhSn7WIbZpH4CaGW1ctemEG0OEnD
         NqEFyYQ3XWkWeOs/yCb/LLwF4Kdjx3XsGBcHWeUbeJX96g0Ff/0w3HG8D1CF8erJw0MU
         4JsSM9N5ZUfmZw+Y4nRms01IA+F1ODehxAhukDzZqmS3sYSK60+J66gaZF6604toETdF
         3L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676977; x=1794281777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
        b=1V8NQXzQHH9j/JTRoWXaqBKOBbzDX+UI4b+f3NMgakaFpWdOgK3WFNCTtNJZ/3CnRP
         kigKFwvIK+AtmvYWzhPXfI9H2T68VXI5+nEQgH/eAQuA5vl1RkhdgQ0VpR/kh91Ohuk3
         VdBHdrAsIu4UswOvymmHcq1nw81vFQc1NrBPTQ5PnD9SHAHEj7qy2UhZ/6vC7dq7OSJr
         cuzZGcztKJ3W9dfkPZTbgwGSDmBbFs0iF7G17K3EA2+J1R/0sMOHjTJj9kzIoZrauADF
         UseEmEcVYrd5Xv2LedOCetGEehn7FcYN4tpZeBL68Lo1BIHpza7rewMPtSAliTMHRq97
         rllg==
X-Gm-Message-State: APuU4Z8V1tRS5HL5AZazLoVaVzJCJ+J6n3PRscoWMkZt1IcijMB1WpIn
	CA9EBDp2kzHIvpn6D+jbbHLtNvjaRZ8NvS/6Yfzty3wDYbQ2jx5dxBCM1obCE35b
X-Gm-Gg: AYBFou3Gf5gBVGrwJxqHvWHU1U33ipmqwZQJTJLqcaKKHiYEYDkh945n/TJW2PQnfT2
	XAzFqTm2hyeX9izv6FW6f88d1rEKwEdd1OSZWagOesCFim5olQVAXiY0CdTLebxB4g5ZEl7btb7
	s9kULRFZuF7hAepNEGJYWrx81PzeJZIsrbVi++CkXTptSrpZTIWU2F05j91w9N2sl11SBw1/fcq
	X1lyV0Kb7J22p/HI0aVU/4+L6+LeTx0aGZ0zNtdbVOC1+BuJqzufwzKBuqpdwt0Ab0zQYt1vJ/q
	2gWpGB7FK0Q93c072ajt0Fl+BolHhrMsLgJHI6WBCih3qxNLRnXb+MkW9M6vv99gQlEMOh6vYYN
	PU5nRAqk8/IoKEWrLF7nPzruRqPW4WqqsW/CvN89cPwjeEWmtP9qy0zQP19b8t12QGma61STYdb
	3anDAoNXKXKBqPZEOQsxKKmF6rAascDpRUULLtyhtTLdpblhsZD26q/Lte07Ct68EusgMKHB+n4
	0AJ3swDDjK89wItowDL2oyaxVtNHTNiTetOs9kDnpHlQBYlcRQVlxbmVzMb8gGYDNfcBlyr440p
	7DgBxRNgpgiBXJzTi8aNAPML2zBNOwmHBa/mbBc9Az18Ao/lcCCt0Q/k8awbzXTqZBuBEnDLj+i
	djT1MtTZzpfJ5IuYWgr36DWbDIHCBs9AiKDlGBvcVmvq0b2pDcIKYxSLKZr3oqxhHFr3s7kuKBv
	8dVASowtZc9e+bmtBq8A==
X-Received: by 2002:a05:6102:6058:b0:7a4:da60:acfb with SMTP id ada2fe7eead31-7d072bb37b9mr3882342137.8.1793676976764;
        Mon, 02 Nov 2026 19:36:16 -0800 (PST)
Received: from willemb.c.googlers.com.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee1d1b35sm13341793241.1.2026.11.02.19.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:36:15 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] docs: netdev: fix iproute2 process documentation
Date: Mon,  2 Nov 2026 22:35:56 -0500
Message-ID: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

From: Willem de Bruijn <willemb@google.com>

The instructions on sending patches to iproute2 span both netdev and
bpf docs, contain outdated references and miss some instructions.
Address this:

- Move all info to maintainer-netdev
- Add a link in bpf_devel_QA to this location
- Update URLs to git repositories
- Update URL to patchwork instance
- Update subject prefix rules
- Add suggestion to Cc: maintainers
- Add pointer to iproute2 MAINTAINERS
- Add pointer to iproute2 README.devel

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/bpf/bpf_devel_QA.rst          | 30 ++++---------------
 Documentation/process/maintainer-netdev.rst | 33 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 4729efd657c3..888b29599761 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -304,31 +304,13 @@ downstream distributions.
 
 Q: Do you accept patches as well for iproute2's BPF loader?
 -----------------------------------------------------------
-A: Patches for the iproute2's BPF loader have to be sent to:
+A: Patches for iproute2, including its BPF loader, are sent to
+netdev@vger.kernel.org. For details on iproute2 patch submission, see
+"Co-posting iproute2 patches" in Documentation/process/maintainer-netdev.rst.
 
-  netdev@vger.kernel.org
-
-While those patches are not processed by the BPF kernel maintainers,
-please keep them in Cc as well, so they can be reviewed.
-
-The official git repository for iproute2 is run by Stephen Hemminger
-and can be found at:
-
-  https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git/
-
-The patches need to have a subject prefix of '``[PATCH iproute2
-master]``' or '``[PATCH iproute2 net-next]``'. '``master``' or
-'``net-next``' describes the target branch where the patch should be
-applied to. Meaning, if kernel changes went into the net-next kernel
-tree, then the related iproute2 changes need to go into the iproute2
-net-next branch, otherwise they can be targeted at master branch. The
-iproute2 net-next branch will get merged into the master branch after
-the current iproute2 version from master has been released.
-
-Like BPF, the patches end up in patchwork under the netdev project and
-are delegated to 'shemminger' for further processing:
-
-  http://patchwork.ozlabs.org/project/netdev/list/?delegate=389
+While iproute2 BPF loader patches are not processed by the BPF kernel
+maintainers, please Cc bpf@vger.kernel.org and the BPF maintainers for
+review.
 
 Q: What is the minimum requirement before I submit my BPF patches?
 ------------------------------------------------------------------
diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index df220a965438..51669d66c272 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -363,6 +363,39 @@ to the mailing list, e.g.::
 Posting as one thread is discouraged because it confuses patchwork
 (as of patchwork 2.2.2).
 
+Co-posting iproute2 patches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The official git repositories for iproute2 are:
+
+- iproute2: https://git.kernel.org/pub/scm/network/iproute2/iproute2.git
+- iproute2-next: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
+
+Patches for iproute2 must have a subject prefix of ``[PATCH iproute2]``
+or ``[PATCH iproute2-next]`` to indicate the target repository where the
+patch should be applied. If kernel changes target net-next or bpf-next,
+then the related iproute2 changes need to target iproute2-next, else they
+must target iproute2. The iproute2-next tree will be merged into the
+iproute2 tree after the current iproute2 version has been released.
+
+Patches are tracked in patchwork under the netdevbpf project and delegated
+to 'shemminger' for further processing:
+
+  https://patchwork.kernel.org/project/netdevbpf/list/?delegate=7961&state=*
+
+Send patches to netdev@vger.kernel.org and always include the iproute2
+maintainers in the email Cc: list. See the MAINTAINERS file in the
+repository for email addresses and other details:
+
+  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/MAINTAINERS
+
+For patches that target iproute2's BPF loader, also include
+bpf@vger.kernel.org and the BPF maintainers.
+
+For more information, see also README.devel in the repository:
+
+  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/README.devel
+
 Co-posting selftests
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.56.0.385.gac671c819a-goog

