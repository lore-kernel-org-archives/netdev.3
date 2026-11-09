Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208705;
	b=pVTv5SWllwT/Q2mnoJ4gmCNsQtEzTiOsxgDXxaotq1EX7l4rDnsRyTP4sPpJZXwIf7za
	 DeDed2681X+aqFcSacho4ns/n3MrazoCmTo9aVUyUJa+GOXlI9fLrZ8JnwuSquzsfQKCY
	 YpnJFhiwFJTk2/Vc9+fup0oOgHndoGcRah9dPMUYcLd30gbpRLU7TsrnFfBvRvd8PUIO+
	 UjsPljz/XdsDf+EydofsMC8mIKZGpllDXL+qjzuaExD+y6vyFpy16a3JdyPQ0/bHxjc89
	 NmuDJ7PNqDArdx+VHJCLlbdaA0vgLPYRCs2BZ0iZSleWztKa5VGkV4g79rZo/hzjh7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zCKO3sRARToFinSo9PL+jKK4jsq4XRctQ0QJ0NSvelc=;
	b=TpjYVhQ8G/lsavYVWXQXHxoxpVv2enAtL12FhFp1XKqrw1TgUJHMdr7L6Pzdc/ULDe4+
	 GIRDuo0i8av+DhPmaQ7afLRBd0PkBhNijgGfR3Heus513WwCo+my+loJL9+/d9e0OmZbI
	 I8MZo0pNfQDqSvBVmchKJgx7EbrsYWN5q0T90l9U4CmhALWm+7VTtKt/ui3pRTUymypLr
	 o1RBGtRL9azDMXmMsHBLB5ptS/EeXTnxeALq5uPdsRDa9MF15fyQDx3lkcwZaM3yCIer2
	 D+GXutBi2dt751rv26hLY2o25PVdSUyDypCkE7oCH3zS4ZBHjjLNvnpvWpP5ivLQ8lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ny8vlj7k;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD5606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECD5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ny8vlj7k
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3720addb068so831294eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208704; x=1794813504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCKO3sRARToFinSo9PL+jKK4jsq4XRctQ0QJ0NSvelc=;
        b=Ny8vlj7kM1s66yXg7tUw015cDF03VIMzD/CxUk/Qj7+9QrUBDx68q+9HlU7h9EYVm0
         mpPFfPTIpUUIjlYw5BPWCjASz4weYCDcUMn94Dr9Zu1vfJrzP2zkDrqN0DeChBpTt5Hr
         wLIvuW3oVRxN2buitKzOlYKHXS5h5xU+2hdyExD0s94fPMl71yEJRpp6JifaJTNbHOIl
         /eqlf7sIrTfkRRTmcsr+En01fQlX9QJDTZS8RkSObAPrwfajdnmq8rLmV4IU12QnLnr6
         /7V4BySMPi+PkUadScJyOwvtueo4HnyadVZfgT12m4vf01BnR7w32Tz2dh5FIOMGQDhP
         rVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208704; x=1794813504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCKO3sRARToFinSo9PL+jKK4jsq4XRctQ0QJ0NSvelc=;
        b=Lq+/kulKbnUv5jvG2DjcntyxQMPbWPOsY2tKA/7XZpnskwIcIJ6NW0kNCezkcniDKF
         p+y6yZtQTZPX5KyzD9/CbgGNuv87Ljec3555/zSSSI/OvN8N76Wf/m4TRwWg3bj589jX
         zSikgeHZzOr5bsjY34Yekqd+jFIJT+/N3v+HoLtvQR5snbMMQjh0YkIc9cORwv4R57RT
         QoYhQmIVz1fsobPa4PH0zZpLWLh/C5Ez73fFkdcG/VlNmdLjh/zL3JFGYMij7+2JEfUk
         X/yyuH7aMO9FyqI/Oud/bJFN4BMh41HlV2R+ctaFzP2IXdwqTnfG0z1yy6xZoTFUubo4
         iBQQ==
X-Gm-Message-State: APuU4Z/ycEVF3q7oRaCUpEOMMt+H6Kl6vQsD7B/ratrkFJrLc7T+2F56
	IbfduAXep6Qb47+i0M3XcruIjOyesgpruK8tD2V+mUu6udd9YXpgcwSkFmSLrR3E7Ok=
X-Gm-Gg: AYBFou3sE35ATqNd+QIz70ZvvZDLDfgO1fgQQLv4haXnHF46CzFtzLaMxIyTU+BmOx7
	vhYyI82yPFx6U1syVLXLdgdlTs721JFYa5do2oSKQIsHSERE43zAQScJUiNkFCX9oNTcSwuCSND
	5ZvTHbbQRej3Noz4qIclFBxl7HaOcrY4xIplymMcDVaz7FTUFt+SOv3sdJCUwAy+hgQfoMnSZMp
	nhi6+vzANq7zogDdaQAns4QtDQMcC9qaDw6Ed7o6PfbM3QrpemuBF0gxozlAieGOsvn/jirQkbS
	neJN9asiYSmLgPQQ0NYCZiGXcCG+j7fZ/ExuVmSUlaetIxHyd/YDxWItvgRObDpCXSt4+3iOpUo
	3vTFgMBWCeTbVuGMVza+OCiIDzgxTklR8+y9XUvIX5XwsK+793SwlgCFJxbEpowabMq4OXpUbiw
	4kvjt2xluq4Ks3C+EKOOkdA/euNZm+Nka1I+usU9CUR69EqDjjKBfFznXpa3OAvL+NCcwGghifV
	6kBRAFJmEGzY1kdqbzfzXV3nfCj0N72NLT6nlGHI+JHfOneKmJWfSKZRXUiMAhSCh/5k/5W8DOx
	hlVUxvbwyW3c4RTK8CYrqEZ1VRTbtYatlJoG2y7i+YOfHhJZk4NyC6C9mlHghcS08NV6BnXUCCG
	XfvgPrAo6lDIb8GhGb1hXn2B0nDRp
X-Received: by 2002:a05:7300:50f4:b0:369:d992:e3 with SMTP id 5a478bee46e88-37258658f8dmr5379014eec.32.1794208704312;
        Sun, 08 Nov 2026 23:18:24 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12878306eec.21.2026.11.08.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:18:23 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v9 0/2] tc: fq_pie: add per-flow class statistics support
Date: Mon,  9 Nov 2026 12:47:46 +0530
Message-Id: <20261109071748.438946-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

FQ-PIE exposes no per-flow AQM state in userspace today. This series
adds tc support for printing per-flow statistics via
'tc -s class show', matching the kernel fq_pie class ops series.

The corresponding kernel series can be viewed here:
https://lore.kernel.org/netdev/20261109071017.438478-1-hemendranaik@gmail.com/

Both the kernel and iproute2 patches can also be found in GitHub:
- https://github.com/H-N41K/linux-net-next/tree/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/
---
Changelog:

v9:
- No code changes since v8.
- Rebased and reposted patch since corresponding kernel series was reposted.

v8:
- No code changes since v7.
- Rebased and reposted patch since corresponding kernel series was reposted.

v7: https://lore.kernel.org/all/20260922211139.38570-1-hemendranaik@gmail.com/
- Removed UAPI header changes. The series now contains 2 commits.

v6: https://lore.kernel.org/netdev/20260919061254.39678-1-hemendranaik@gmail.com/
- No code changes since v5.
- Rebased over the latest iproute2-next tree and re-submitted patch.

v5: https://lore.kernel.org/netdev/20260902040221.83734-1-hemendranaik@gmail.com/
- Addressed Sashiko review comments (folded into patch 1/3):
 - Dropped empty tc_fq_pie_xqd_stats placeholder; class_stats is now a direct
   struct member in the UAPI header.

v4: https://lore.kernel.org/netdev/20260727165028.106817-1-hemendranaik@gmail.com/
- Split into 3 patches: fq_pie class stats, pie avg_dq_rate
  formatting, and tc_pie_xstats comment fixes.

v3: https://lore.kernel.org/netdev/20260630184453.171410-1-hemendranaik@gmail.com/
- Moved print_nl() into each xstats type block to preserve output
  formatting.

v2: https://lore.kernel.org/netdev/20260614130729.10076-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue.

v1: https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (2):
  tc: fq_pie: add support for printing per-flow PIE statistics
  tc: pie: print avg_dq_rate in human-readable format

 man/man8/tc-fq_pie.8 | 18 ++++++++++++++
 man/man8/tc-pie.8    |  2 +-
 tc/q_fq_pie.c        | 59 ++++++++++++++++++++++++++++++--------------
 tc/q_pie.c           |  4 +--
 4 files changed, 61 insertions(+), 22 deletions(-)

-- 
2.34.1

