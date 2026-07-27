Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67442FCBB
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171046; cv=none; b=scZDWGJgFya01VoPQ+jCu4T/fnGQPul2QW/5aquSzYQgAs1uxYjP2U7Q4lTvaLtTGHlosgnD6OzkwuleNgbm2HvnJcGuatkNps3onZMiZou+vAK2MdAiueAyITPpCQFjOcraePxgXqnheRhM4fyDrz3sA3Lkz66QPYcyzIWQ8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171046; c=relaxed/simple;
	bh=99QPdMY7ypUIG0/DStAmL9MjLjbr5hccZPNXJlXO1cY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3yafJ52Vye/TnyQEmBTq4sesOhDTOk0sJjjblC5wM9KwfE9BTOgWrealF0MfJkdSTLArnbVqRjlYVLIu5Ik3dF9E11umh7jMJyApKDp6WzG/jQvgeLd9t9v/vuSM2W1xP5jqx3Bk3DDhz1v9/kLsiWPfohMNjrlpaqrYCROhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmR1DBC2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmR1DBC2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3255199a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171042; x=1785775842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gr7yzf2AuczGpyRKBEIrthKpuHy20UHm+KHcnWJKJ6E=;
        b=BmR1DBC23od0/QpqK/RgyDw7oFE4IS7Y8J13CvSPboclgTElTGG8SYbPYkwHRkodjf
         pOHBI+uuqLnFcOLB7wYfbpFNxSZIOtK58Do/HYlFg3vbAcuQb6Gf6sNOy5M347wYu5MS
         +nA8GykP5SRQWBm49a/4yfYPHdhXSXIAojiuWkqex5bbj+iW9MYHPE1KWYJo76gFXpGY
         wa0ZsLaFljCt7LLEcsRSa51IgQE4WYCttvqDL6xi7ZAJZD35+CXclTUHgjoCgZpjuZPm
         60Lx0g2/ZpwXK7U8R+NIj/jcX8jz3m25gTCPUXzBvvNASh1cD5W0V73b3bBEbIdLD+tA
         w3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171042; x=1785775842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gr7yzf2AuczGpyRKBEIrthKpuHy20UHm+KHcnWJKJ6E=;
        b=rYSMt2KICGCprVZx0ooqdW8GOBdJ1QAAIw5CvSVP0CIuqBbbkclY0BaxPwGsYS9S+x
         W0kb30tE/5OJqfWoQwGgsr7n+A//PZQZQY+5HlD8yHz5NsiyLtu2FT7iNgWn8HPFZS9X
         nr877J/9lx2OAtaxVAEnfgDlfqG9zAu8/4YBonPUh54VkWh6RIIcM2T0UgnGAvuGu02a
         HV62eSZxvXQcConMOuRWYcDaT8breYqkn5PXrGqH5H0pzpkLWi7CjLVmmTdNPldd864a
         mxZMhr6n3pn1DHkbSsUG2I5iOj3co6YyGIhwHgO985fk7Prz9nVb0T6woPLTYKTwWXnt
         nhqw==
X-Gm-Message-State: AOJu0YxpCYuuNQs8KprXY0jsdfitZbaaitHYAK7T01l9NUdV4OuEdpqT
	BCs+tjFAxDVOHbLEqgkm6L9KNQxTnHu1TYbZ3PxgvN6vDmRBRD7erKAgS/GWAh82
X-Gm-Gg: AR+sD11ImLLh//dAwm2T7VThfeDnFvJuM7sz8+GAMlph8gDpRscU0Tg6InE36S4arVE
	xwYYdpxX3ZOgV1UnWBcAsAP/Ubk+SjUbZMyfwdc/2XXMDLgAAOmxUWbu5UTLmekr/5P/zVmVFdE
	QPcjSTKhqS+Lgi7i1f2YHnjbmYocyegCNCYTnn7oduoR2fmxe/lQzWRZp6g8XJOAqP7L5wyN/QR
	sHtgVfUAdwRzhex55jfCTF6oUtdCtxVK42Y7bdGUEm+EwD0iwrB7qIy9w1xLel/75eUVTJRX0ef
	1gtNnHgIzGmqR2It4Ve1xBZOcpqmWZYNZQHM6MddI0RTEy9GVNA4iSGSGn+P5aKUQRkkMDLRAnt
	BQoqP6msKW9bpP6Y6ApnxSMvKlTWFPF9fS+trt6lKbFve97kEgnFgi1IkDXwhqRE1v6T16msw//
	6QmrEnq8bKdszkvTnSj3+9X3fkaHrIrme2WeU0o/m83oC/zC3PoDIdwpQ6zXtU8E5QBoG9GmBk0
	sXSlw==
X-Received: by 2002:a17:90b:268e:b0:38e:baf:6087 with SMTP id 98e67ed59e1d1-38f649d2e5dmr72846a91.35.1785171042274;
        Mon, 27 Jul 2026 09:50:42 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm33654029eec.11.2026.07.27.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:41 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v4 0/3] tc: fq_pie: add per-flow class statistics support
Date: Mon, 27 Jul 2026 22:20:25 +0530
Message-Id: <20260727165028.106817-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE exposes no per-flow AQM state in userspace today. This series
adds tc support for printing per-flow statistics via
'tc -s class show', matching the kernel fq_pie class ops series.

The corresponding kernel series can be viewed here:
https://lore.kernel.org/netdev/20260727164056.106203-1-hemendranaik@gmail.com/

---
Changelog:

v4:
- Split into 3 patches: fq_pie class stats, pie avg_dq_rate
  formatting, and tc_pie_xstats comment fixes.

v3: https://lore.kernel.org/netdev/20260630184453.171410-1-hemendranaik@gmail.com/
- Moved print_nl() into each xstats type block to preserve output
  formatting.

v2: https://lore.kernel.org/netdev/20260614130729.10076-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue.

v1: https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (3):
  tc: fq_pie: add support for printing per-flow PIE statistics
  tc: pie: print avg_dq_rate in human-readable format
  tc: correct tc_pie_xstats field documentation

 include/uapi/linux/pkt_sched.h | 29 +++++++++++++++--
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 man/man8/tc-pie.8              |  2 +-
 tc/q_fq_pie.c                  | 59 +++++++++++++++++++++++-----------
 tc/q_pie.c                     |  4 +--
 5 files changed, 88 insertions(+), 24 deletions(-)

-- 
2.34.1

