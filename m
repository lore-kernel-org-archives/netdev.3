Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE3317144
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316190; cv=none; b=WfYlWMO2vmXYAIT46aaK6R+jqIE/D7beYpPmAm6eDwJLRBBKwX0xVHbGoIfAj952fL9tsOyO2sHW2Ha6TjXlE5VDR8kUd8b5GeEqjRMo5hNZ96UC/v9Eze368HUnytNfxGwZGjiezrkJzCiW8RH7DojlMnmB8Ul1TaJs6QjZ/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316190; c=relaxed/simple;
	bh=GXKRIU6WPkKRh85bXbrL4aIw3c7Y/uqFaE8oBwmH9tY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XWJ1tPK36v9OncHIpiLNpi2bXaDiVS0MUrYLgiEvTqumWXKjW2WwVMyd0u9CraN17Fk8ytVAseoBwvvep+a2DZxGbgieYSdfXmQClPq3GQ0aJNtakQYWlcCwAWid8O5lXbu16p79XMAB95ilF6TaDULlBxoiCFvw8dbbXv0orAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAC2incW; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAC2incW"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc433d52421so172024a12.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316188; x=1790920988; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d7u/9Wg6QjiXWXoGzRoqWQFJ1JJiOuQr0Cr3e+6hv+w=;
        b=NAC2incWJF71M+Gy3CFFPZpmPfPYEh9tP2SqYApERrfwpGra254Z6T4Sqx1bLXbtNc
         zfvRD94bHPxXVn2HNjfXeRYeFj1DeI09tK6XjcQGRiJRKkBwDpitxW9BKt3HScCGHgB4
         UIyRmXtMXDBfVDKZW/9irsHKbgKa3pu/F7iOeconFlnJsyLy6Yn2CwbTVpUryoYzCM+5
         p9Y+LBwOHgeHm9+M1cmyfqCc+yQl6hDV/eoYhUcrrL5msxr0eeG+AZl3vnxbmK3IT18c
         8cf0gTp6KI6QCVmtrzxaqP0Nx+OkEel0gRDYuLULOeJNANrt8o5Y0YmuvBKqmo+2MUTU
         rF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316188; x=1790920988;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d7u/9Wg6QjiXWXoGzRoqWQFJ1JJiOuQr0Cr3e+6hv+w=;
        b=E9aW6bzyLUuglnmt5NLuW39BlfBP2ZQR0SO7bLyPUfhN7/aF9h/JvxGpz0U5M5+Y6X
         oDDPZ1Y3dAzqcxOI5HFEs38F1tYKzJivlXVbRcPVwR+G0gg1mNEvNYCHmeEIExOAOT52
         wLfo7PdRxJCzWUHqCo3EJYeenJtoJTHFvTxnuatkpde2AIVgii7qcLtZ4nIQZ6Z2Ntz8
         A/fzIyaOKANEjg+q9psb5/Q7ihOQydpjMk2bd9uQC7HWXXnNLYmmpKqipniTh/N7zAfr
         JGwcbvzmNw+eoUMB4pRo9uoZ4VHbvlUidsOSfqADxf25YEvzqoRV3yb5MHdfuh/LIIiA
         2qyg==
X-Forwarded-Encrypted: i=1; AKwUvByoIdhGBBQRItQRf1xjlNVOWMXc23TUR7rhCzjhsPAXRh6LZKm4PPzWtChsp8o82Mrt6t/pgUA=@vger.kernel.org
X-Gm-Message-State: AFuF++l19+9AuTFlD4XbMb2OCr4zMJMgxRSJxJZv/Vl7lWj4yIXZanXE
	QMbjS+3LvDpSgPF91tmLcf9s7bAjW5gIV+ix42vK3a7sNXMxU3OYZjCq
X-Gm-Gg: AYBFou2iX/G+/sj97MjzJLh5BXQd2IesAoZCT3SUiM6v/P95KHDPU6WFSfs8zWlh1KV
	KMd5f7+4A/7QEHn7Oqy/dh2KLZyM6UzuwAKhDD4ZNTZLsOoDCVUozUQ0xmwuA1j0bYzYrcP77RR
	1Amhp+0R2z1MpeKVJqFBUtLKKgr4T1UO7If+jkg+okiQ81FoauyeQe8TwRoEKWvRHcaJEls4OXQ
	eHLVrnFJQMI4SLq7Qi/tvp81uCpogYAORCLlMBa16kqwV/GeMqKApdz54uBTp4Bkfnks7lC4BL/
	p3wfZNN8DZr+XVH78U4oFdxlJG7Hku+vVZWkW/HirIKIkKriungLsm+InfmhsJhrJgxlKXRizXh
	VWfa19/p+SezaQ5b9h9ISXqOyQWbswDxuZfwUwSkYa0ihPGbvumwXbp7vn/5PlCuiGCelHv86ej
	de7I65RaRU+oBDwJNVmstSTw3X3K471PrSmHgcopG6t/HaQu3rScXEoKTVt1cPRn8+oenffhY1R
	GAUYm1U
X-Received: by 2002:a17:90b:1644:b0:39e:6c69:f47a with SMTP id 98e67ed59e1d1-3a098cf7650mr4544964a91.57.1790316188019;
        Thu, 24 Sep 2026 23:03:08 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78795dd54sm645963a12.30.2026.09.24.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:03:07 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH RFC net-next v4 0/2] seg6: add support for the SRv6 End.MAP
 behavior
Date: Fri, 25 Sep 2026 15:03:02 +0900
Message-Id: <20260925-seg6-mobile-end-map-v4-0-457733c08586@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYOtmoC/23OSw6CMBAG4KuYrh3TKVioKxMTD+DWuGjLiDVQD
 EWiMdxdqAuNYTmv758XC9Q6CmyzeLGWehdc48ciXS6YvWhfErhirJngQvK1SCBQKaFujKsIyBd
 Q6xsoS1akqDDHjI2Xt5bO7hHVIzvsd1PPUweeHh07fRbC3VzJdpM9jS8udE37jH/0GA9jZIZ8N
 rJH4KCUIS4KmWOabMtau2plmzom9OJrKI7zhhgNlEKZs0UpyfwbyY+B2byRTH/kimvJtZU6+zW
 GYXgDVygddmEBAAA=
X-Change-ID: 20260523-seg6-mobile-end-map-9cec24191817
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Justin Iurman <justin.iurman@gmail.com>, 
 Florian Westphal <fw@strlen.de>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3850;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=GXKRIU6WPkKRh85bXbrL4aIw3c7Y/uqFaE8oBwmH9tY=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqtg6XUt1rHbMQKZwC8vwvoFR6Ne42ZJfXWxZty
 vjdi/3Zs0SJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarYOlwAKCRAq19F1Kl0b
 TYFeEACWTwpPg4AkDzEQsjoLv4BVhLOVR17mjbJbwCWno8n4L6Uu/6GOZeLvrw2iwThFPMs08l0
 3OdsDTpzeE8XuWJbXJyQFpS4I1oA0dprCMlaMAUgOcH+2lrANvxC5CSci+D/aVx0v9Yt5uA/Ibh
 EdJJepnPPrC/OjrWXiQzO3ZEc3fZUSA1Q9zildRXeKsfT6wYDzHSwKajj7hJTOPaDIkRW9hVUam
 Zt4eQPQJ9V2IRv3j5LOWL0twMo+hOQzLjP1ypsKDBHfw3Z2ytsbmQomnN5zzoTkIWfmUKQA/U+I
 i45l/1wETgj4CvzvLNfYbSKW+wB4hSx1wNJjrOy0+aVG8ymuewlPP7undo1lyDjUkAm7NVk/Km7
 uL6JebwwxyLxZi3XiJxK70fl1eki+fIQEZCHembEDspD/+geBAuni3GgCkzfPu64RHSTjZEDTQL
 jA2UO8GJ6LLaqF15b1pR9llnlpx5wDmvgcj6E5Ayarx6SyGNQdwLkefizSsoBFrPYwp63V05Bvu
 UCbPBzSdkB5KPAUp8fUu5L5IKu3jFlFcumq1tM1BLaz9HiGqeBBBRimnAkdOF7A1kEh9sM25FQV
 PrTxzua2ka4u/r+QQuLy8mU8C/xeBZQTBln1Sc0zBKodpSVLPJ32lUjZyMPGtJDrCByEjWiK2ej
 YWq7EkRWJ0QUW7A==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

End.MAP is the simplest of the SRv6 Mobile User Plane (RFC 9433)
behaviors: it replaces the IPv6 destination address with the
configured mapped SID and forwards via the IPv6 FIB without consuming
the SRH.  This series is the first per-behavior rebuild of the SRv6
Mobile User Plane v2 submission [1], split one series per behavior
following upstream review.

Because End.MAP is the first behavior to land, this series also
introduces the SRv6 Mobile User Plane lwtunnel framework that the
subsequent per-behavior series plug into:

  * a new LWTUNNEL_ENCAP_SEG6_MOBILE encap type with a
    CONFIG_IPV6_SEG6_MOBILE build option,
  * net/ipv6/seg6_mobile.c, which hosts the action dispatch table,
  * include/uapi/linux/seg6_mobile.h, a dedicated SEG6_MOBILE_*
    attribute namespace, so that attributes whose semantics differ
    between the mobility behaviors and the RFC 8986 behaviors do
    not overload the SEG6_LOCAL_* table.

This layout follows the discussion on the v2 thread; feedback on it
from the lwtunnel maintainers is particularly welcome.  Per the same
discussion, netfilter hook integration, VRF support and SRv6-specific
drop reasons are left out of this initial series and will be
revisited separately.

A matching iproute2 series adding the "seg6mobile" encap keyword
follows shortly after this posting, since the selftest needs it to
run.

[1] https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com/

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v4:
- Fix the checkpatch line-length reports
- Link to v3: https://lore.kernel.org/r/20260917-seg6-mobile-end-map-v3-0-9890a60ac6a7@gmail.com

Changes in v3:
- Silence the shellcheck SC2154 reports for the namespace variables
  setup_ns assigns
- Fix the checkpatch alignment and __func__ reports in the selftest
  helper
- Link to v2: https://lore.kernel.org/r/20260901-seg6-mobile-end-map-v2-0-1629bfc166eb@gmail.com

Changes in v2:
- End.MAP: patch the L4 checksum also for an SRH with no segments
  left and for first fragments; selftest cases added for both.
- Use nla_parse_nested() for the nested attributes.
- Rework the selftest helper and cases; wait for counters instead of
  sampling them; add CONFIG_IPV6_SEG6_MOBILE to the selftests config.
- Rename the SEG6_MOBILE_NH6 attribute and the nh6 keyword to
  SEG6_MOBILE_MAPPED_SID/mapped_sid to match the RFC 9433 "mapped
  SID" wording and avoid clashing with the SEG6_LOCAL_NH6 nexthop
  semantics.
- Trim the Kconfig help; add Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com

---
Yuya Kusakabe (2):
      seg6: add support for the SRv6 End.MAP behavior
      selftests: seg6: add selftest for End.MAP behavior

 include/net/seg6.h                               |   8 +
 include/uapi/linux/lwtunnel.h                    |   1 +
 include/uapi/linux/seg6_mobile.h                 |  61 ++
 net/core/lwtunnel.c                              |   2 +
 net/ipv6/Kconfig                                 |  10 +
 net/ipv6/Makefile                                |   1 +
 net/ipv6/seg6.c                                  |   7 +
 net/ipv6/seg6_mobile.c                           | 703 +++++++++++++++++++++++
 tools/testing/selftests/net/.gitignore           |   1 +
 tools/testing/selftests/net/Makefile             |   2 +
 tools/testing/selftests/net/config               |   1 +
 tools/testing/selftests/net/srv6_end_map_test.sh | 400 +++++++++++++
 tools/testing/selftests/net/srv6_mobile_send.c   | 262 +++++++++
 13 files changed, 1459 insertions(+)
---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260523-seg6-mobile-end-map-9cec24191817

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

