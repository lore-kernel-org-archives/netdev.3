Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001624;
	b=WPYmZeZEyM3eoC6I3zdiJZLV3j1ywz2P4wEqPrpiY3wazM9xFaKWi2PJjompmud/nv3v
	 PKK4m59ZaJ3Jl3jclgeQXw956AJaEHxbZBF3Ae+D8n1XSn5Oz3U0CZc0OeSJYPyeYvuXe
	 /2gR+nofM/1qmLtj260U+6DT6MxmkIKdAC0SeI+tmo5sw6Nb5BeJH4X8+tgQK/nOYGGe7
	 a3U33Xj87ysDmyJ7E28I3Y9TINcefHxdNu8m5haBe3pf2tj80KGgT8qAzW25nTey6fa/e
	 vhZqIsHPwIh7+TUCiqC+f08PeGpTEkMdkV1BlOuSp4IfdYjp/QhMrD3n3n23JX2RKqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=VTVhZ77HMf3KWZYs+JTy3r72EU2F17EVyXla6tbrLZ5X1uTHSsrWfh6MMnmbWuao8sRY
	 SqdWtRcd3PElzM01OT8WBNwnMm+njo5GAulPdF+16fTEIfWSHW1ZZKg5lyfu21slD7Wcb
	 fTgxPnUDa7hn8hKSPrlzzFdTY0Swoed3dhCvzgYD88wOVPsitX98timhVpesfAAW7GLuj
	 EUiZH3pqWfHDr9kFzmqxyKkHTp6DvrZSWr7r7NFKywTU7EQOS/y0p8oNOBkHk/9qrIku7
	 7xiSMa9y18CH6MotwFVa4njClyUJ8zqABQFtmyY1NT+2dbYvHDFUTBUW+vOB3YjASNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QECr/k6o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DC606A321;
	Mon, 26 Oct 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QECr/k6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9481F01825;
	Mon, 26 Oct 2026 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793001624;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QECr/k6oPnJQSYrB8n8135pm0yWfma3W8gHbGBvPPvekVnkM/TjL6OjHvCrm1QW1w
	 Bkb6xDeGmOhZDxN3t63xry94md6Zf2EYBXS8j3BY+RTRribLkAHkp7QFrvtSUIStnw
	 7U7u6ZAxNEhbQjmhQs9uwIu4La3H7PumY91o95wze/bqoAsIrRJCSyVLydMZDEfJW9
	 870cwJTxR3cRFL5m+EEVgQ9FcE8npchwziEnso7MeTJErvjigZ2R3fYhDXYB4uAVpO
	 td/2FPDai/Mggm9NMOZFCng+w/9LvpqXlR9tgl2TfPYpkv1q890751GAO8DFCRMXOD
	 ZVt5RRNBS8q+A==
From: netdev-bot+sinfo@kernel.org
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: 
 Re: [PATCH net] net: rnpgbe: Accept link-down events without speed magic
Date: Mon, 26 Oct 2026 08:00:22 +0000
Message-ID: <179300162296.3327.8577140950893281339@kernel.org>
In-Reply-To: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
References: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
