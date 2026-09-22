Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAE43DEBE
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110798; cv=none; b=DJbTcig36JF6F5thrXoNzKtNDcTTFx5JT4bd2hOEVLKlRorSVGHpakZvIoxVTRmqFyJY/g0NQ2mxeiAtyLHICrQm4bO/ttpPAQRV7qjGsA5CB2Kz6eb8D/6Y89e4JTAaFKqGdh2KztF241Q5dK7bYGE/ClAjDAgMI40pC4PE0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110798; c=relaxed/simple;
	bh=HfhN83NVgtaQE2H+GN2G/xzYp+SaFQJOfO1TroVBmEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGL0SIjHndWS8AaULkOenLcNafKPcAqKhsEjEE491K/JRldmmgdHd/6iOssM3A/dBZNDz/FAw1lmPxVPHcZNpYlUtRFaFu5/jYMy/o+J3UO6XWAJ83ihVVf/XmXY9yQfDSysL2Q5viVKEJGo5k0GSi+EYvsIKqhuqaBL+ZSlWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHvncLLV; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHvncLLV"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e050bso297358eec.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790110781; x=1790715581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wTN5dzyC0qAZsQ7BP1bHS2J+PZt0xUjiC71KhGCNYoo=;
        b=IHvncLLVucaZnRmuRLzXTVKWzMSIKuRGKlflIOKnX3kswaMl03R4SA/9S+KMCtrBSX
         +osGhlUpVV0MMAa8c5wA/3ty7350ud2VAgnAXC2CH3aadQ6aDP25Wu+yPLhAcyWL9Q+l
         H2ofhmy12CBwtYCORFcnJUXh2fcZSZO9gq10H7YSht21cde6MzO8c3UGJ7ZtXk+YdBON
         3+OUV9yRHZcDPcvUVFDxAuD/ldObr5cIV+NyuyvSqaT+WGorNoLtjklaHgurQYJvVZfV
         BBLJoVlv8215HnZ2hf6gS1AMAksBmyGl6aJDCiqhm+rSJo90Pz/z+/g/X0iOGM3CI7Xv
         yvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790110781; x=1790715581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTN5dzyC0qAZsQ7BP1bHS2J+PZt0xUjiC71KhGCNYoo=;
        b=hqEi23wpzdra7I9HewenrpZvatN2Y/61ZXiIyO4YxmlB2V5SaAVBUpDSFu+FV0dLx6
         tEXAlnpAzkK/KH6wWDgag5qucHHDAmOBiiev2S1O4Dn0oytXic6l4RI4tM/Iwt0nLqvB
         L9qRvcb9B7+DR4fgAXxNiUx0IpVRKaJJHeGcIaYodvMWDNepwA4iLxEqa2DXA7/Y/mKf
         uFfZ1+2VwQVxIV8KBrC3+hcBGmRnvzBzW389v/EJ2JurwFLCVpYpGfsRNGUXm5Oy+vcH
         2KU2FyPAIjosLONeW8RAJ50G0yGUIn5ONQBo5aeLUny/NohGcUyemLYziClZcAtoCeXO
         hwRw==
X-Gm-Message-State: AFuF++lyJz7I8pHMbY9aJ/P2fwrP9kw+RtF7KegeOosFmi8ppabG5f3i
	6Rem93qa0A2sq/VSb22yo1+1LauR5YkYbN9zQh8r9yVldFLSa9yEHrTRtPi0/K3j
X-Gm-Gg: AYBFou3WaQsX3lq/TGA8tfYj5JxvdY375IsMNedxTgqk/CK4aU2jCsuv5pGQvXA4dPS
	fMebn5mRNYeX6jnvohFW9Sn9fxKMj/BJ/78GbeCqZIYsOxVwdl1SMOzBg4eEscEuueQyfPOB1Ph
	o61Hycg70f64Eauuv6SCmyKjELmC9NB7uCF6MDMPY3P3PhV6lvZMYCnhsEA3LNnZgjOwxUXGIxV
	9AMbbNLYX6hbv7fRoeeIXJFQhRAW0sXaEVU/lTnRHI3yeEPQouvMxnvJCMJzqws50kPsv4mgKQY
	2ILxYcX8abN3+IFO8tFbKqWLnsynw7cPbJwwu7i9QiXqkRWODJCIVMfSmvzSAzT9u41eugv/oDF
	itjaYSD+swIggDygtXu+53BH0YvirfhM/v6iZ3vtRwEctnHWOnGvGq24RhgDU3OX/FXHaRYtzgD
	onhuO4f0OACX7IS3gJdywbIdL+eNL+LMPuEP5s8MgMve9RMhBMs49iqfNZq2sexZHo7IANSFCUc
	C9MR0B9Xiu1j1T05etk3UO9rxjMTbBD+GlgSNFkASKrIVsHPKynsUR/8O28PpufSe9MStvv2vnj
	qhuMjmVnokyPWaDavdMg
X-Received: by 2002:a05:7300:4628:b0:33b:dfe3:250d with SMTP id 5a478bee46e88-33e8dbc4687mr514090eec.23.1790110781046;
        Tue, 22 Sep 2026 13:59:41 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d497e1sm760952eec.25.2026.09.22.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:59:40 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v8 0/3] net/sched: sch_fq_pie: add per-flow class statistics
Date: Wed, 23 Sep 2026 02:29:21 +0530
Message-Id: <20260922205924.32173-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE runs an independent PIE controller per flow but exposes no
per-flow statistics. This series wires up fq_pie_class_ops to expose
per-flow AQM state (prob, delay, deficit, avg_dq_rate) via
'tc -s class show', following a similar pattern as FQ-CoDel.

This patch series is accompanied by a companion iproute2 patch series that
will be posted on net-next as well.

Both the kernel and iproute2 patches can also be found in GitHub:
- https://github.com/H-N41K/linux-net-next/tree/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats

---
Changelog:
v8:
- No code changes since v7.
- Reword commit message to reflect usage of div_u64().

v7: https://lore.kernel.org/netdev/20260919060125.38063-1-hemendranaik@gmail.com/
- No code changes since v6.
- Rebased over the latest net-next tree and re-submitted patch.

v6: https://lore.kernel.org/netdev/20260917204225.275251-1-hemendranaik@gmail.com/
- Address Sashiko review comments:
  - Revert the fq_pie flows range to [1..65536]. 
  - Also drop the accompanying selftest 83be change.
  - Compute the per-flow delay with div_u64() on the full 64-bit
    nanosecond value.
  - Widen avg_dq_rate to u64 before scaling it by PSCHED_TICKS_PER_SEC.
  - Document the 36 to 64 byte xstats growth in the patch 1 commit message.
  - Fix selftest 83c0. The ping payload exceeded the TBF burst so no
    packet ever reached fq_pie, and the missing -W left the run waiting
    out ping's default timeout.

v5: https://lore.kernel.org/netdev/20260902035231.81866-1-hemendranaik@gmail.com/
- Addressed Sashiko review comments:
 - Omitted .tcf_block / .bind_tcf / .unbind_tcf from cl_ops (statistics
   only being exported; filter attach to fq_pie is now disabled).
 - Dropped empty tc_fq_pie_xqd_stats placeholder; class_stats is a direct
   struct member.
 - Limited flows to [1..65535] so per-flow class handles fit in a 16-bit
   TC minor.
 - Rewrote selftest 83c0 with TBF + fq_pie, ping traffic, and
   matchCount 1 on per-flow stats output.
 - Updated selftest 83be for the new flows limit.
 - Dropped the tools/include UAPI mirror changes from patch 3/3.

v4: https://lore.kernel.org/netdev/20260727164056.106203-1-hemendranaik@gmail.com/
- Fixed unaligned commit message; moved typo fixes to another patch.

v3: https://lore.kernel.org/netdev/20260630183702.170798-1-hemendranaik@gmail.com/
- No changes since v2.
- Resent after the previous submission was deferred due to the
  net-next tree closing during review.
- Updated corresponding iproute2 patch in response to review comments;
  kernel patches unchanged.

v2: https://lore.kernel.org/netdev/20260614125000.6058-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue for tc_fq_pie_xstats.

v1: https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (3):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test
  net/sched: pie: correct tc_pie_xstats field documentation

 include/uapi/linux/pkt_sched.h                | 20 ++++-
 net/sched/sch_fq_pie.c                        | 86 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 27 ++++++
 3 files changed, 130 insertions(+), 3 deletions(-)

-- 
2.34.1

