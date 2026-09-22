Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646C5208B2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111522; cv=none; b=i925eUfZ/TKYw0fuB65XlaWVunS+jjlT9fqI4SH2PWrkoOKKc6I9EaleK0TdltQq3N5K70Hf8+UvMeBPY9C4aiGljFeSX5JXzmGg5gdQcYrVHS8W8eOXTO2XyBKqtz1+XZwl4IodRyuu92Ppt7TyiLQyq2zjs1xg6Nt6o9cINd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111522; c=relaxed/simple;
	bh=pwkIcIUByJ9bqE4bpqhEhpT5m+9siVjLIN8nEvUfo1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePNrlS1/ZLtvYSnQMhjG5XfJkAOO1ZOPO85stXlX4ENVi6CmB3blLiKWZpbhP2giCzY1EQ2LiFlIKYeZw9CpRNLV/RCWdPq9yFuZFzeHLW6SqhnbLzuOwFE4nBMe1GP1yPaXb3It12CbeDdSNU8mhtu+57Zy7MISzSzqSFfM86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j225aI0o; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j225aI0o"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef78fso136446eec.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111511; x=1790716311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFc3cVt28AUvIwgg0fMAo3JWLIDnX5xw3DJZeSq88MY=;
        b=j225aI0o7rU7Lql2ONANtcjymgdYQXyGyUE5AqFgx8dcKu2o018VnCrt102qzR9N8T
         I3lx9iN7NV2SqIqqpqyAqY+7LjE0yCcPkHZGBBaHzQRBm/jjpOu33jfzaxTPj91Jq4XN
         gHozCPjnad7DsQcjx/67TedonU9FVAE7352mkZmsBdPhk/ZJKqQFhAhbDoz2eey+JONX
         mZObAcw8yMYlnD3fjT0fPrGij6dhbI1+uOsVa817xu+btH+8FeAsUOJLxJwpt+dKM+w5
         ap0TBicLcSPpFGrA7NvO0cB3HmKXCH74lnpCu8/VHVnk7oyJOiLr0k66yjUTRad9zBnY
         JL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111511; x=1790716311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFc3cVt28AUvIwgg0fMAo3JWLIDnX5xw3DJZeSq88MY=;
        b=BfLfNcwnBj6wtANwezKcdOTP+Y7rxEYGG44H3cp/GaBjFyR4SdM+03isRuHG4ROvZB
         yfB0fxfN+SWjV2SKMUQRowfUQSGBEb+fmb/oPasv1vBpYW0Gx1veiqM12TobhfRJ3CJb
         iPf7jVfUZtKSI/qAGUzpd1qIrh5s5CMHTYUidMfyjjOWpl6ZoGiBkz2kpucY4KzJArer
         i/vb+coXUgdEs96AzfU4SDACwa3iUiEyCwqhUooq2zNaDXttAwh49RMe2y5tn5RexoR2
         30Wy5jUlQJmP/veKmJ+UUmt2TwuCHrXh9ZvJ5p326qBmyckeda9Ipsem9cTr0boBrmF1
         M06A==
X-Gm-Message-State: AFuF++lIX0jFsAnSLjNQfcEiL7YHdiFOMd111C4W8HbAQGBqdBgf0VfA
	bUqTaTX//DI5Tufnb6WDt9HmSIXcdoEgG+lOhYwJdhjWzC3JuhCIf4r2J60h2qpL
X-Gm-Gg: AYBFou0NBW04ROlXMworOVqKmAGXU+HVO03m81+lQpmdPBx+ixjtz/QSn1Ee/vXdXLK
	n6/wYmRMu/J6HSr4NLCc3HUKxJN8E1WTDKrLdhpdaB1PqUvAIoGRonzJ2841GSEKv2eYtqoc4dd
	PgRuFRlJYsRf4w04Y1JhNIY4u97WxQS9WNyfscFdV0wxspw8pwt85UBho1Siy2qSLPM7zI3phb6
	kOW3k24Cw89Ig70QSonzsYHz1SAx3ZO1Ia6+SpJZrqgL9XN36D949PZz6Td7yS4gdV11w8AHTvP
	rOCGv2x3DwsevsKje++m65yUkrkOl6uIQSqOmT/WreYGoRqbW+M0h1KQF2LlcZ8VTNsx/EJxAcy
	d7+oGxZ7zLTgguLmWybwo9UbXntzhUqNpkeYAP0FAi/4iBQDNJkAVEdjp9YIz2oTdns1ccXFZ11
	Ld/DQqjAtFnA6F6WFDLZr774znr/e5FCmoP0ziZnPov7BE2wd4VRT5fBAWZp4MyKXFhuFhf8p6d
	FN9eZnmxxau4MhK/TavyCenRS65mF2APpZzmO2FjWyzsmeGNw7GuXRmxMyT98z4bQ9keJHR6V8=
X-Received: by 2002:a05:693c:41db:10b0:33e:6b65:5eb6 with SMTP id 5a478bee46e88-33e8dec45f6mr503707eec.30.1790111510073;
        Tue, 22 Sep 2026 14:11:50 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:f16e:2102:25ad:9cdb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm943147eec.4.2026.09.22.14.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:11:49 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v7 0/2] tc: fq_pie: add per-flow class statistics support
Date: Wed, 23 Sep 2026 02:41:37 +0530
Message-Id: <20260922211139.38570-1-hemendranaik@gmail.com>
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
https://lore.kernel.org/netdev/20260922205924.32173-1-hemendranaik@gmail.com/

Both the kernel and iproute2 patches can also be found in GitHub:
- https://github.com/H-N41K/linux-net-next/tree/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/
---
Changelog:

v7:
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

