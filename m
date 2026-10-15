Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109148422A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099132; cv=none; b=WtMhdEX0Or02hg7nqgLZoK06HXVhTAP78APpi4rckB8kql9z9tl7Zv/PiRF3a9WSbZI6C98tlkUz5gC6KxF4yoQ2kA0OwRzYih9qLOT2ZuBf8bXtU6thNu6cqNfdQjDD3t44zOrhgcd06u6vT1cjnkaa8LZuD5Nwu8QQlGUWJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099132; c=relaxed/simple;
	bh=/NFZ2tkWdLR9IJr//ybnRXFokS6ntcalDvGYdtTOepQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph4AgV+FIeNusZB9qKDNQfc1p0iEOjDtZXh0lt+5YEsKpuHSBgUUeNgvbT3O6tHTHS8H7O/artq3DudXH2oQFBAYHlx5n9Fh8sVmQADwV1xwbXmFAAQvBdQwmaAaV9vx7a55ewrwGOhrU+WmHkrQu6WTsfvFkvEXoSBg8RwfIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=khN6W0OC; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="khN6W0OC"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so13701894eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792099127; x=1792703927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fxx1tuoEAv/PlgxC62C7y+lSjrcK6Pozoo/S/YtYY78=;
        b=khN6W0OCEp1rzHQ9SUsFrbdYBu9bAh/3wxZV6VuEg1UnmC5JhJActmcc5hJohgyA/Q
         feLZaNO8/uP6SjY2KW0Urj7oUoMv287Vhh7fM0t5+3+adfH74Ef5e8w7ZJYPaibcQYbY
         R5KBmlNN3CpuJMqabLlvPyYlWkXJWjQ8em6fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099127; x=1792703927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fxx1tuoEAv/PlgxC62C7y+lSjrcK6Pozoo/S/YtYY78=;
        b=afD0wkgF9ZTss5ODUavcYx9nvRWJIEBwQd8BbL4vs7b8p9N4niezmUtOPVJN3flwNs
         y/ybJ2qLfjh5YejC9RzxOstK9jHipiPNZwUYTD/qUaDvczYBXgAfF6/7tqZpFiMpyZsE
         jOI0smeOddd8zPNGQGOJHc3U+xzXbN8W0y+Q/n9fjljU2G6GMkwkXHJ/0/J0SPPbI6Cl
         T5AwNsVrzWIsDzxVd3pwt7nc5xyDiK7hoOi7a7FtkgMSrfp4a21AaMpAmrkawaFnjkHS
         icLgKpfzPMGDo2Du4/F5wIfxWswcBJzN7aa4Ov30FbwK9l5WsIouk9bK4n7wL076L5Ec
         EV+A==
X-Forwarded-Encrypted: i=1; AKwUvBxLMW54KIT7hi4EcR3atTVFRyLsWHXIK2eOd0KxOmRdMp6zl+fTxjWA3mH9p0Zp6f7p/zDSEfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlbuu7GjOGXg2BtUhXX+DOb1FLPS2246rduKscPHjSVN3vSyiH
	RjmoDb1wxtJq/3BSWSDS1UeLwkvBLcH5/N2jacvPapvjfgPiIi97dIyP77IoW+H2BICnQeVudhk
	m/uc=
X-Gm-Gg: AYBFou2I0TNiY9B6pSSnsRmgA838o+0JAUzENAuU89+M6UvlAd+HE57asAs4xdvqtkz
	GjIyX27gZucDr/ndotw5rwb868KnRjnHp9QQfPFeN6neS1bt4b0PwkWg0/75k18JQ7w5rjG+Z+6
	ABMEDMvp2JStb16SXuF4BNCXJgJfyF+3CjbiK6NUB5f8R3QxFs7BG4eq+tHOehT7vaemALM5Vql
	QMGMXCP7hAaCKWneSgtApL9cLCQAn1tOCvJg0pZYZ+IHZUActOKRm6w/IQLGL+zTVA1mQaf2Or3
	YwjdE2fJ1DG7fVchrdyC167XRQanSi3bUzuh3KvWpO/9PHhF4M0XQ3mfmnfOp/SHocewt66kfgz
	8khYqfLZ6lpqtZxO2+4XEg2CE2vTTNxVGckFp4zGEP5FYpapA9LdDXiIw1LjFhzBuUaCWvhwKdB
	bmKKLGfAEYvyelMArokaH4b9shlA5y9TU1FFQbh6Sxy8vMeaQD9S50lknzvO425MMwopY0NoCIJ
	RR4
X-Received: by 2002:a05:693c:8643:20b0:35e:fd8:3201 with SMTP id 5a478bee46e88-35e0fd83708mr8390127eec.14.1792099122700;
        Thu, 15 Oct 2026 14:18:42 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b859142sm216711c88.18.2026.10.15.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:18:41 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net/sched: bound the deficit-refill dequeue loops
Date: Thu, 15 Oct 2026 18:18:28 -0300
Message-ID: <QDISC-TIAE.v2.r0.20261015163454@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRR, ETS, sfq, fq, fq_codel and fq_pie refill the head entity one
quantum at a time until it can send. With a size table that inflates
packets to 1 MiB and a quantum of 256, one dequeue can loop millions of
times under the qdisc lock. This series skips the rounds in which
nothing can send, so a dequeue costs O(N).

1/3 fixes drr, ets and sfq.
2/3 fixes fq, fq_codel and fq_pie. There, a flow can still fail to send
after the skip (throttled or AQM drop), so a crafted setup can still be
slow.
3/3 adds DRR and ETS tests for the refill result and service order.

v1 -> v2:
- fq, fq_codel and fq_pie moved to their own patch (2/3)
- empty flows are credited and removed as the old loop would
- tests reworded, ETS case added
v1: https://lore.kernel.org/netdev/QDISC-TIAE.v1.20261008110502@mojatatu.com/

Victor Nogueira (3):
  net/sched: drr, ets, sfq: skip empty rounds in the deficit-refill
    dequeue loop
  net/sched: fq, fq_codel, fq_pie: skip empty rounds in the
    deficit-refill dequeue loop
  selftests: tc-testing: pin DRR and ETS deficit refill semantics

 net/sched/sch_drr.c                           | 42 +++++++++-
 net/sched/sch_ets.c                           | 41 +++++++++-
 net/sched/sch_fq.c                            | 81 +++++++++++++++++-
 net/sched/sch_fq_codel.c                      | 74 ++++++++++++++++-
 net/sched/sch_fq_pie.c                        | 68 ++++++++++++++-
 net/sched/sch_sfq.c                           | 41 +++++++++-
 .../tc-testing/tc-tests/qdiscs/drr.json       | 82 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 54 ++++++++++++
 8 files changed, 475 insertions(+), 8 deletions(-)

-- 
2.43.0

