Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208237;
	b=xwKxGdq1xolGz26jNtkePf7evwTOVNk0aqn/+gXLQ9s2gj2m1EoAFCMVA1T2PRN9X1pM
	 wGsHlmu012+QCR+3/Rq0i49JNqyvaEBYTjwaWV4Cz6FCkzMs5AfUObDjpZCOOFcSxCXrB
	 70K4ecECdEIIbsspf+naXgYdlMJbXygl76XYLBcusFYp0gE/HOoFHjU0CyRIWDlMwzKBf
	 nCXLBy6k+aF37oOQyJmBGSPOWetI5D3xntLb8od79qiMWuytmzgg+gxKLA3EjlX52eKMy
	 xf75qeq93kqD+SCbJBbRgdW/kDCUG/kRmjWhzLtRrEDf39AT8P6XrpALV5TAwIz8iDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qMu+E00+xLkfpIW7uvacAeDC12OVnUmiLpjE/Y+qhVQ=;
	b=1Ez79DJ45au122nExJG/5FQeHPV/9yj1kiCR7+naITbEFM1W4gbrJgTIS+IET6di/NH1
	 WFrR/XLwIj7z3mbYDGSYdr5AKZ5a/SX4VEH8oAPLcWhTUC/cc4ZO8na1nCVwUT4AvY6QS
	 0bSdfHlhKWSSp+apPrlfZWHlaGNHQv4dwgfYt0P+Dubr3V+xTO7v48B/GOBYDsvW43jlK
	 eyGQHRVI1ogBAXdR/sodZk7G7cLFeUwBg3SuSBjeB3mkXkf0lk8+WR+1oaZG7IFp0uXVA
	 2QZp3SBTdTTT7P4nb37AxLj1sDzgh8LPlUxOgBbpAKBZq1exBFOo901iAqDy769flEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N57GV0WI;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B11606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B11606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N57GV0WI
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-170135e43c7so759792c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208236; x=1794813036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMu+E00+xLkfpIW7uvacAeDC12OVnUmiLpjE/Y+qhVQ=;
        b=N57GV0WIWarWe3ZrYQQvE6FGtouwvf0dlkbJO492VMsz9IM9FmnXH6L78Hqel1qF6H
         IPTMmSalKejGbC8ehdfpK0qEdGKyViWoTij3Lz8eAqBwiBHb9kTZilsqmX5Ex7DJu1gf
         DMQI9x4p0YY2nOYnthUt6WRSFp60B59bcozRolgKhVosh9JEB8RkGeQiD4y7WRYUYlv1
         OAxduc4g9dUu6gBXqpEUlPIYPrjm0dfP/LcaHY8dQ95XH3P1snUqlx1fiyBduB43x+n3
         p0Ths6cpvC/zDADpFqJ9rm4OA8NBlf4D/zf+YUoBB+MAjFisBkOx1NPzdGUZ3iUoYHuO
         05Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208236; x=1794813036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMu+E00+xLkfpIW7uvacAeDC12OVnUmiLpjE/Y+qhVQ=;
        b=RhoXMiBh/i1WbAdJGojfzMJsvGy2m4VNu40HBfwWmcHZcPwpLALPWXUUUULl50tOq8
         Eti1qKKy/Rfh5I4vOpqdbfSXOAThSidqEHbooMDL0x4nSZ+CtnowlMXo2FDVzlhxWW+h
         YUcaRkRLfSloTrRAZuRaATdfKir/oI/Xp8GDMIe/zpwrEgZiqosa+/iF7UgNFeKZeMj4
         AIISf54mD6a+sRrUtUikqzUUe7ypHrB9+xeBmQKVjbusR3Q+nVM+dfW+KdwnBb6S7B+D
         3qmEsezbZ1iyrXZyJPa1Wd20OIEK/JfwL7S9NzEDeBSN2KD/n3mdDlUrvheQ92tp6hsx
         mFtQ==
X-Gm-Message-State: APuU4Z8idbxL5zxH1E9KasUNgmAM7biH55z06+rI9iwU82r/ajnqX5W1
	VqPvzZgZNNwzJZSOg/oQWQS4Xsn/BAKsi7iCEpaxpTCx6yJTEXh190g4hjxVGO1FrOI=
X-Gm-Gg: AYBFou3INNKE838h8E4w/QxuWfcItTM3/HhWih0Jwfy/ODylUs7ApxzTNiwBq/BdrNm
	F9ylTPiS4JyLpKZq5KZK/UguYet8uhB69qjaX/w5HjO+gj8C1bixRmwxYhUqEr1wiB5xE4wxEc0
	2cgj4jLBm/x70APxHW+k3ipZjtEBqyaQM7C611dW+wbA1Pl2lX5fRHhDteZemB0HR6yfWUWTLCw
	9hJCR09WA9vu3NIgl5E8DU0q2LagrDzqQwJ5T6XKaSU39xiSGfcOonNAYwybnBsLUN5VkIqpr5Y
	qRPxZhehOU+lVog9YCn8IDXFBssMa3wjQ+L5z4dDJlz3yMyJCIlbKQ9oxpZOeyGU7rFQvgcTTJF
	nV7cKQIGm5cQv6yuBcIiy0eJVPaKfM1lo3CEGEwcpPL47tVOUmrEzGIHTzjaHnEBF5QADOV2t0b
	G8dEkI+6+VKda23EbhUKPRwZCAmQn+kCQZpYDlhakte1t7EjZ+OTdbmTuJJ2PnP1JVjAgnh43l1
	QmzcSul42u3Owvg84HEC2jv0Sl/FSjG3dWMlwogBAHPjdI3e7KgI7gBfUAQFJtvuDn+pnZy56X9
	FewaiG4s7+1G3EvBq5YPwrcVP2g5mkm1o6VMfUOalIYynQ2k98+wJlVUqKJp88s+nIwKt0RUdNb
	fv8KolUcQZPEDpKvocY/WzEr4CvGxmWEM+rX+U/Fny0wlqHFJ9g==
X-Received: by 2002:a05:701b:4558:10b0:1b3:a9c0:6a3e with SMTP id a92af1059eb24-1b3a9c06ac8mr3048889c88.29.1794208235645;
        Sun, 08 Nov 2026 23:10:35 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm13443513c88.4.2026.11.08.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:10:35 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	toke@redhat.com,
	liuhangbin@kylinos.cn,
	j.koeppeler@tu-berlin.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v10 0/4] net/sched: sch_fq_pie: add per-flow class statistics
Date: Mon,  9 Nov 2026 12:40:13 +0530
Message-Id: <20261109071017.438478-1-hemendranaik@gmail.com>
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

v10: 
- Update Documentation/netlink/specs/tc.yaml for fq_pie

v9: https://lore.kernel.org/netdev/20260928043358.6866-1-hemendranaik@gmail.com/
- Add a blank line between structs in commit 1/3.

v8: https://lore.kernel.org/netdev/20260922205924.32173-1-hemendranaik@gmail.com/
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

Hemendra M. Naik (4):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test
  net/sched: pie: correct tc_pie_xstats field documentation
  Documentation/netlink/specs: tc: describe fq_pie per-flow class stats

 Documentation/netlink/specs/tc.yaml           | 32 +++++++
 include/uapi/linux/pkt_sched.h                | 21 ++++-
 net/sched/sch_fq_pie.c                        | 88 ++++++++++++++++++-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 27 ++++++
 4 files changed, 165 insertions(+), 3 deletions(-)

-- 
2.34.1

