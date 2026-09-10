Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E3396D13
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032874; cv=none; b=UwyS4dfMWvlaurnooqPhuGv6a7j7TFt3MAdCVBJZpJMx7f4YrcON7dHm1jOe/Bv2U9we4nD5HbASoFOtCpW5eFr3W6jzjHFib/VH7/Gi3CcHdM89dbpOHkNdgHieM8VD2qo6K08XKIOl0pz37AT2IR7d/XCWUj9ZVCaap8ppBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032874; c=relaxed/simple;
	bh=O5RJIBAf8bdM+SFjmTJLRNSqjUhosM/VE9Wbdt3m/JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQmpjc5/aw5V1cr+rs8kmiTtg/kjmrfyAkeGHC9ESwZESv80nmFGfyChQs3UY8qezVNHf3tp1OWauIdBuX6lAVM3hySwbLMqnOk/UgTkxnV7q3vkBQTnj+hmsvB7rwIiRoqwsrHrbY8YWHKXD7/rpsh7uikbDm6c1eFD/NCgeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kKEPIE+T; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kKEPIE+T"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O5RJIBAf8bdM+SFjmTJLRNSqjUhosM/VE9Wbdt3m/JM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789032868; v=1; x=1789637668;
 b=kKEPIE+TQJuOLKMBCD4vd/Yklk3RS8Ft4N7vEu7dBndTumZhqUFr5rSqxaIqAud192yJ2XlV
 9wmRsfswhorUNWcDazEYnM6+M8gMuzqOHpIvo6O1Jsjr+542CurCC6ddxuix5cqr12P8hRcbrPy
 1CateQQqXVlVAjxVyVQ/2UWE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b741d43ade1385a0;
	Thu, 10 Sep 2026 09:34:28 +0000
X-Mizu-Trace-ID: b741d43ade1385a0
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	marcelo.leitner@gmail.com,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1 0/2] net/sched: fix action batch deletion cleanup
Date: Thu, 10 Sep 2026 17:34:11 +0800
Message-ID: <20260910093413.34509-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Batched RTM_DELACTION requests can leak references to unprocessed actions
when deletion stops at a filter-bound action.

Patch 1 fixes the failure cleanup.

Patch 2 adds tc-testing regression coverage.

Failure reproduction (key output excerpts):

  python3 tdc.py -f /root/tc-testing/batch-delete.json

not ok 1 d710 - Release tail references after first action deletion fails
	Could not match regex pattern. Verify command output:
[...]
	 index 2 ref 2 bind 0
[...]
	 index 3 ref 2 bind 0

not ok 2 d711 - Release tail references after middle action deletion fails
	Could not match regex pattern. Verify command output:
[...]
	 index 3 ref 2 bind 0

not ok 3 d713 - Delete a tail action once after a failed batch
	Could not match regex pattern. Verify command output:
total acts 2
[...]
	 index 2 ref 1 bind 0

Xuanqiang Luo (2):
  net/sched: act_api: release tail references on DELACTION failure
  selftests: tc-testing: test action batch deletion failure cleanup

 net/sched/act_api.c                           |  11 +-
 .../tc-tests/actions/batch-delete.json        | 115 ++++++++++++++++++
 2 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json


base-commit: 7f26a5e8040b4957ef4dbdfcde6cc7ba2db53937
-- 
2.43.0

