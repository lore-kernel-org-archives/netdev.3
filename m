Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CF395AED
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791120608; cv=none; b=nWvQAnmVeB7px6Y29ZQCqFcny5ICW6quKDpmHQ8gJUydeMpK6k7ElZnhTrYQoylxmWVQEZr1Cks/VUfl/BUgu2w9arDYT4qkSldLR6UPRIMmgo+pEfJS5VMlavk+e0OAmbL7C2z3ZjW0XTlKX9Y4wi5OLY1tmcUCMTHvb9MypGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791120608; c=relaxed/simple;
	bh=NgPeSroR38S5Uj832S1g76Wduaubl9wRjHJZuorUhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IjT2YLuJcoXgnDqw4QSqjFBbXi+TTB3Z7GOISS0g+tyf5Q3yQr6VtwS9hTIL2LbFAwhs4BBGWc3+/TggEOjLtVPrIJsoxQWoz7m596AbvKUwZcP1cLykSS0ZRT6XJHgYlodM2U/q76/29efFAQj9ENtfZ9tuZShrkLMPIbZA+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VD2ZZN9t; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VD2ZZN9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+T5UbfHJ1+eFncc06zc8gHks0unWVa89pQcF558408M=;
	b=VD2ZZN9tstpg1Z0HlW5Pug+IMJyVqePtjwii5gukZjthEOW3Hz+1Lvt4rkR7sI
	VBlSibkiKByjP4MkNoeGvkFUfOI28YKZbKd17vbtagKJn5Qi1af0bFIy3rDIxZfQ
	tXePu4/ffhpTNCgJwzTrnJkRiasgooqRBJ2ex+6O6hTYs=
Received: from u2.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P+nOVMJqgaCpCQ--.24782S2;
	Sun, 04 Oct 2026 21:29:51 +0800 (CST)
From: taozj888@163.com
To: netdev@vger.kernel.org
Cc: taozijin <taozj888@163.com>
Subject: [PATCH net v3 0/1] brief description about the patch and its
Date: Sun,  4 Oct 2026 13:29:45 +0000
Message-Id: <20261004132946.559188-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+nOVMJqgaCpCQ--.24782S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF43Wr1kZF4DWw4rJr4ruFg_yoW3WrbE9r
	95J34rG3yjgF1DXan5ArsrZry3JFWDtws8uF4Dtry3trySyrZ5uFyDJFy3ur40qay2yryD
	Zw1kZFyvywn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRECzuPUUUUU==
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3g+TW2rCVM81rwAA3w

From: taozijin <taozj888@163.com>


This patch is titled as:
  net: macb: rate limit netdev error info print in the data path

Changes since v1:

v3: 
- add this change log since v2 missing it
- drop the blank line between the assignment sentence and the commit
  info

v2:

- update the commit message with the reason why the unlimit prints would
  bother/delay booting process
- update the commit message with the Fix commit id provided which is
  suggested by Théo Lebrun<theo.lebrun@bootlin.com>
- update the commit message with what packet type would trigger the
  error printings more easily.

v1:

- initial commit


Best Regards,

Zijin Tao
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1

