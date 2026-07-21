Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8933BB13A;
	Tue, 21 Jul 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624432; cv=none; b=FhrQUJmP2tgXtj4C23l5B0AgTxG1ygdCke4GDcTZbcEDq2ZYmeEYemsUL6WPxceB+O6RYkI4bKTcP/fyv21flrmE4r4fw+KzLhSkoHs01ep4T4NmPGDDVCOT8SPDOD1+VuCxKJ5U4+9ZRz9Jmc/tZTVy7czZY+GAJokWu4rYDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624432; c=relaxed/simple;
	bh=wg2R0O9jIiz8XQD4zLwCh27qvRCLFqO7jRdAu55Kn3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTFJduYrJpcGQyeOefZXmFhfhD02jV/wR8hl4+uS8nYdZjbR2ujcys0/xRQ1+VkS4/LhL7gZ4hk+FgMiPR8mLj5UApZnvVp9BGvFfxpaNXVIMvVMOH1XkHs2Ykr1S/1smF8mYjQHP0uZ9CtA1fFSReqJnmXVd+jiBe3az11Crpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nmEf+Yzb; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nmEf+Yzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784624358;
	bh=3sdxPL8G7q4mqiuvAxDaYhVO3red+x5oG0NxOIHEf6A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nmEf+YzbjLSLQysiP4CCCgM1vhH0HDN6Bk4B9U0R7rC0PXWpiXKTYPXrGdX2/rH36
	 paxN3hssDyvVlX+0sW5JW7n7H3ZMyu9Yhm/emuFlclUrajMSE1/aDohq1wb34wqazV
	 n527U9FV63ipdmaUiPzY9rUfZK02XGjCpfW59bzc=
X-QQ-mid: esmtpsz16t1784624340t9677e2c9
X-QQ-Originating-IP: oSV6oG/FFee85rSGttmZ/xjMMQZMQdRO3/LuOAmF6V8=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 16:58:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2477360243233712857
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: horms@kernel.org,
	madalin.bucur@nxp.com,
	sean.anderson@linux.dev
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net v2 0/2] net: fman: fix IRQ-related bugs and add probe cleanup
Date: Tue, 21 Jul 2026 16:58:39 +0800
Message-Id: <20260721085841.488088-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260709145221.1564906-3-horms@kernel.org>
References: <20260709145221.1564906-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Ncyz9M6n7cjdUjyWgeJqVcKQXWRXnAQu44AA7uh039z2i2wzWBuTUC2D
	a5/dQ7A36qj7A6PlpToNe62x6HNZkzn5N9dSxlvUSfeJJ34R0WPPfcQgiFTyPTIBYK4CR/F
	2Xn5OQQPQbSc33nd+xcLbNl15rm89U89nadMWOqqSkZu1LzTUGJVekBJl20Wvb/UsEiitsn
	y1uyXVYuvCASustIsRkR2NRCqE+mkyjFyCAiNO6H7tDw5ARljDNSU+1RgSJvnqawcFAe6G1
	x+OJrw9ewwXfMqHCIQB1vo1VV3QJkyFvoM1xLMGYiRSX+0848wtAoqeR/YGibW6WBzQIybA
	awI9fT0yrHyKwI26fhTGRHjBHYeFL1V1W4p78z4JMsuAsdKJMoiMBxIwIbvyvyo1yO5vHiU
	aEqax4wqpadpThgFCKvHLrcg5VRgGsKvAj02V3ZYy4Tvmrs+Mugd1/8YOWvQoArz5e6mmrt
	qjqv9mDt8cZNwYAm/eAieXqCGoVdMNoBUxoWRKueaR+l6/Z5MkLbXHB1FwCP+AmWA6RyMAc
	b0GMW+dsz5BZWmKIQodGqf+hRRFrZEU2Yg9Wk222Ujd8VuAHf0OYI8xE8BAURMuwFTWU6xs
	JLuuy7HEG5UGuagSBd6SEFxbpUcSGzxY50/+388Qe20ypwKIQ3AVLIrl9u2cOkkdfePF99y
	FAqC/dUxaZgyS9L9FLwg43maoGj0zs5tzzrZqzGe8sEOiT4h0AL7Fl/HUSupzLTSak8KeRv
	4+DlgQzKQ3rgr5EmFx2ovxlwfLAfc+A9qw/g+Tfff1qGiZlwC1qaNa1sFhGpI8jr/Mi+pPI
	eB035IJX3aQtcEpzquLj5DRN5CqTi4FGHLs9FUzlxdMBHcZ7VGaVJbu3O2S7L6mAzuXnvVQ
	ZVa6p9R3aapILsIgw8eklavt4+8c6YXs5kTyl6lQWOGtNOj2mcDO5nO1V/eu1u0mhYjXuGl
	5pXHEYOTsQYRuxZmxD6X0ZvdvuT4HNQfLHY8AU3jrUf6iIGDkIXCw5V4n9nLukYvhbthEY/
	RoC/VFLUiXgORn3eN159GUnv9z/YrYUdZIEZ12DMMXXtUOpvHP7FTedi5jclE=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi all,

This v2 series addresses the feedback from the previous irq_ready flag
approach (v1) and the separate UAF fix patch (v3). It replaces both
with a single root-cause fix: moving IRQ registration after driver
initialization is complete.

Issues fixed in this series:

1. Pre-init NULL dereference (crash on shared IRQ): is_init_done(NULL)
   returns true, so the guard in fman_irq()/fman_err_irq() is bypassed
   when fman->cfg is NULL before fman_config() allocates it. Moving
   devm_request_irq() to after fman_init() eliminates this window.

2. Use-after-free on probe failure (UAF): kfree(fman) was called in
   read_dts_node() error paths while devm IRQ handlers were still
   registered. Moving IRQ registration later eliminates this window.

3. Interrupt storm risk on shared IRQ line: deferred enable() to after
   IRQ registration, so the hardware is never active without a handler.

4. Memory leaks on probe failure: added fman_free_resources() and
   fman_muram_finish() to properly release all sub-resources on
   error paths after fman_config() succeeds.

5. Double-free in free_init_resources(): cleared fifo_offset and
   cam_offset after each call in fman_init() error paths, and added
   IS_ERR_VALUE() guards to prevent -ENOMEM from being treated as a
   valid offset.

Pre-existing issues NOT addressed in this series
(suggested as follow-up patches):

- Missing .remove callback: the driver has no remove/unbind path,
  causing all kzalloc'd resources to leak on device removal. This
  is a larger issue affecting the entire driver lifecycle.

- Child device probe ordering: of_platform_populate() is called
  before dev_set_drvdata(), so MAC drivers probing synchronously
  will find no parent driver data. This is a pre-existing design
  issue in the probe sequence.

- Hardware not disabled on cleanup: if enable() or devm_request_irq()
  fails after fman_init() completes, the hardware remains active
  while all software structures are freed. The driver lacks a
  disable/stop function.

- fman_muram_alloc() failure stores -ENOMEM in fifo_offset: this is
  a pre-existing issue that is now mitigated by the IS_ERR_VALUE()
  guard in free_init_resources(), but the root cause (error code
  stored in an unsigned long field) remains.

v2 changes:
- Move devm_request_irq() to fman_probe() after init (replaces
  irq_ready + READ_ONCE approach from v1)
- Defer enable() to after IRQ registration to prevent interrupt storm
- Add proper error cleanup with fman_free_resources()
- Add fman_muram_finish() for complete MURAM teardown
- Clear fifo_offset/cam_offset after free_init_resources() to
  prevent double-free
- Add IS_ERR_VALUE() guards in free_init_resources()
- Supersede the separate UAF fix patch (v3)

v1: https://lore.kernel.org/netdev/20260629084529.3709393-1-zhaojinming@uniontech.com/

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>

