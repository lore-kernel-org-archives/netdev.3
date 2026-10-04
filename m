Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F462BE034;
	Sun,  4 Oct 2026 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097463; cv=none; b=bxa1CjM6ObwLSSRqKVOu2mRulVQYeayl4HMovxjD+SaJR+yHw4m3mVkRpIKE5ToXcuCGPaf1nMTB9UwZ4mky/YjvT395MszquWSgzv+7KbJh5m1ZmHp+G9KUc0OwY/McE09oU9tTbypnpb9B7NXBIMEMZCno7TMFp9o/lNp0WDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097463; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hi9FKRGCE6gy3E/bXH7f6d4PjbaNjXK9+5gQ+1gPQjAAvGPbaUKlcbNPCoKzT87hlSborXk4E6OOS6HBpXpSsKBDxK19J7kNpLukW2PjyXjBWyODL5adMrnkPeQ5eDHeZ6tBf7BB5PDVfmo+wjRm4n4I9JJFn/4AvZF3neImpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is6j0xil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is6j0xil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55A01F000FF;
	Sun,  4 Oct 2026 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791097461;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=is6j0xilXhR4ypqsKJsBM9X5lO6Qm7OUlcfEeJmeAXo0J/ruHrmYoexYJ1Z9w2nu/
	 zx7rj/yqLYTth3bUYmx8tXowSYP4aFFokyhdyMbgMI9mXNRUkrq65/0QQtSLBLJiVS
	 kByIRa6Z3baBMCYMvIlx7lRkIrVU7W8pKaf48a63aHAMnJgTHiV/Ya+86c8H1NH3vd
	 L2n9Eame+UJcugO5y/H0JhTS2asC9wlHbHxGP2Mnz4LUpBkF/O1MRdWwHCOExUZIRy
	 +YOg8aG+A8wmQ36PoqmboPnoIwMnTMSrci4sAWPZ6VuIi/mjHG1vGq3PdY52e9kNBL
	 UwatJhLYGqoaQ==
From: netdev-bot+sinfo@kernel.org
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 suraj.gupta2@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 robert.hancock@calian.com, sean.anderson@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v5] net: axienet: do not report TX completions as NAPI work
Date: Sun, 04 Oct 2026 07:04:20 +0000
Message-ID: <179109746015.1402591.14131579685594488279@kernel.org>
In-Reply-To: <20261004065930.1004953-1-maimon.sagi@gmail.com>
References: <20261004065930.1004953-1-maimon.sagi@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
