Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904315;
	b=fw7jeC6q0zOMWimEZ48uH9y1FqPB1qWGO+mjjs7clNjb2ij2eUZvqW5VejDPQkvfpnLb
	 BCqihiyMcIlI6zdciSebDCLj9kwkuyXQI2A3E2vrn+FC8puuO0IJmWE80+nKGo4Gx5Qxw
	 gkhUig/GtbXPRVAiYKcePE2WjDtVpFvfY+b07ruqLYAkT2nmot26Pvx4pNH7WfqZyrK6t
	 tJ8hdvK/rUc925olf9k8nxwr9kTbJc0OYYyV/f78UEgIhiD9WEAbKdEDVAsRTfpmfDwyg
	 fhF/LPDxpYHgUQ7/Y5Fytb1Dru7T/BdccopHXMLqMbO6DKUSWaSCitZ1qJoCwavSsnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gvY7HpZJ1wJ/upxJrw1i+mIWqu8jzDOOOqeDBLKjL5M=;
	b=eEGu+P7Hb0eSC/ZLqvd1DeDLuLe7o9EoJ1ewob8WVdiqgBM0Ip7jxcR+qqygqj7H8qJt
	 zXPQZ2BW97x2JNABIPJWQO+6iO8J4aTL3rofNEXCh1xd8fdi7WjDm+wZ6aX4th24upkFp
	 K97LxAjffCoCXf7SN3Pnimcc4mWM2aEydvLmzsUSAfXzce6pR9cMd8GLHue9noSy+XSMT
	 5oTUy6BXx/SnThfKg/s9XGILWoA9nMmlAYpKbvF1Mim7TbwUtYNhPTXH36XPDGM0Z2i5X
	 r+zdjwHA7YNHa1V8oy/VTyKB0jS8oj/RHqImUgHBQRmSfIghJT+42BnmdADcdQE8Ahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qM4CtkN0;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA1606D801
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBA1606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qM4CtkN0
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so907755e0c.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904314; x=1794509114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvY7HpZJ1wJ/upxJrw1i+mIWqu8jzDOOOqeDBLKjL5M=;
        b=qM4CtkN0+6SaYM48v0oHvvb0RMSanj49lvHL37QoD2pvY3sqNhx+oDfXzmJ/1RjGOf
         Lz1dPvyUhVRT4p8Y7C7j+EEJ/ke2T/ZumfkIcB6syCQhhj9LjiGryDXSeuTFuStoWUDz
         xQBpCIOasnS+/gDXKitCCVg9EQpa9E3rX9Ne5trHewfXj0iA9R4HlyumJ8SJTtsMzkir
         /h77FF40+lDMsYSBKAmmpg2EeTPKgRBzH4V4l7gFhbq7kKxY4sOCXTHElc4lZnjT7t9S
         3ZL1sEtQd2lfjlSjIK+2YLcMQU5j0HpZt3wDYSu0OAhFOLp9H5MDLCxbKbkkwPg+nR/5
         UL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904314; x=1794509114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvY7HpZJ1wJ/upxJrw1i+mIWqu8jzDOOOqeDBLKjL5M=;
        b=fDiICsVKTepDbdD2ACT8zCuF/VKE9v1UCdYexH7yh73PBAlekmxyYZRxIre1YD5IRj
         ltxxdLhZkcQ8Qms6pDMltSJtXp62Dx2QGnEbarVzcgwnAU5Bl+LhR4rKKXld0FWVn3rp
         qFIwlBGHuulOWtgpvMSjHL7TThCGIV8NatLkbVvfa0A3gV66h+630WdgHTa90Hl9l4z/
         DtmrS7RQluD0fH0n16tPZhVq52GnCzyDa10xIVzGPy4DPIr2hcRThM9+oB4bGMo5lxZa
         VgnV/qa9c5Vhyt2kL1UaAW4MkOfnmspqvjIb4Y/AIvrwrVFhw4ubRrF+KzUxD9zvN3k8
         8qAg==
X-Gm-Message-State: APuU4Z80HbpWlJSlitxL8ZILNaxrC3rW1HY4JeRosCIdV+d8DjhuCCNw
	uiAuOO+IzANzm0RmQnLnXW05K+n6xvDfYKi3fTQEiOaHkwfuIB2VnOo0BelVqQ==
X-Gm-Gg: AYBFou2vlxeCYS9Sv67tH2dUs2Nk4pKDk2rrxzWMtEASZ1D6hCG3P1ekpTqweX5pbqU
	fwDocz1IAskhrWmiS1jRcGmVkSHwAq3l3f+hi+RCavUdVK/uVEn12koYrd++kEHSrK7BZbszIAq
	GLUGLBoov02sE9nJ4JhPnV8NQyy1j9bvF9wXoEm4GaJsZ0BrknSxdB7StUSZieyrt8FUUqM2UGE
	8XH4oyb5QCNqGDsiKniJpWSW8NEDWwqDYOJCQ8hFKjbc7x6dYFvAqQw4ci0f2Q9G6QjPEtB8Rs7
	lYcJ//uzb4t7hpJ3TGhpJicWK48jxojU8RsflHiglOkEXGt6yIHz/gq7Mmb2ertL6F28BBKVCVi
	lg7bVYF/hk84fEHi2Tc+2ihmGaeDSQVRgiAx+SZfTBDle0yC7zBe9LcSCqWPNs+0zXp62BAb1K4
	my7zpwvXV9GFzRnAwig/ITg+7ZmUgQz9ARkPR3kITn3Hco0FEWyQB/XV6Qc7k9SzNw4Qud9SzK0
	nBL2Gi7wSKg8mO1A0piCsNYSQM8jmqFUgv0B0GXYvzeuqC6pnm64jUUHBnlYDyNNIdMNqJ77OV8
	wSaG8SyUqNbn6lrlqgn7m930aaB7GPmMorjILvFVcpVZqLlRvpqDEHJbSS6X+/8ahGa+RCZPj3o
	Ue/xfl5fgjQwSe1DnVSBVsG0OFo5xm86HeF6Tbvo9xpZqb4LA5Ji/GhVDHqPko/hz8UwRIiCupI
	omkwAmDvX15ORLmJJCwA==
X-Received: by 2002:a05:6102:3750:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7d286b2ed7amr2201319137.32.1793904313847;
        Thu, 05 Nov 2026 10:45:13 -0800 (PST)
Received: from willemb.c.googlers.com.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca889381asm4989858e0c.0.2026.11.05.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:45:13 -0800 (PST)
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
	Willem de Bruijn <willemb@google.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH net-next v2] docs: netdev: fix iproute2 process documentation
Date: Thu,  5 Nov 2026 13:44:51 -0500
Message-ID: <20261105184510.3230744-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
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
- Update URLs to patchwork instance and delegates
- Update subject prefix rules
- Add suggestion to Cc: maintainers
- Add pointer to iproute2 MAINTAINERS
- Add pointer to iproute2 README.devel

Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
v2:
  - list separate patchwork delegates for iproute2 ('shemminger') and
    iproute2-next ('dsa') (Stephen)
  - Kept ast@kernel.org Ack, as no changes to the BPF portion
v1: https://lore.kernel.org/netdev/20261103033611.949104-1-willemdebruijn.kernel@gmail.com/
---
 Documentation/bpf/bpf_devel_QA.rst          | 30 ++++--------------
 Documentation/process/maintainer-netdev.rst | 35 +++++++++++++++++++++
 2 files changed, 41 insertions(+), 24 deletions(-)

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
index df220a965438..6a0f27778213 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -363,6 +363,41 @@ to the mailing list, e.g.::
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
+Patches are tracked in patchwork under the netdevbpf project. iproute2
+patches are delegated to 'shemminger' (Stephen Hemminger), iproute2-next
+patches to 'dsa' (David Ahern):
+
+- iproute2: https://patchwork.kernel.org/project/netdevbpf/list/?delegate=7961&state=*
+- iproute2-next: https://patchwork.kernel.org/project/netdevbpf/list/?delegate=123859&state=*
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
2.56.0.455.g6c5a503b38-goog

