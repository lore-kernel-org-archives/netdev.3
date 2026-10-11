Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050E28506C;
	Sun, 11 Oct 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723925; cv=none; b=b9ABYhtDfu5wDAh6OesCSdKhPULS4ED5g3dE3zP0P9zOxv+/Vnl4MnVre0WjFK/akbnZK95LAygW+kL1bgyfabfUXCsML3iZu9YIx9Np9WYIbD672ePR7x9gvwhd7YVNr7jKvr+nre0DfO/KD2TO7+q7Gj7wPoRfbjUccsvXt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723925; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TulWzOgC29uhx2jg4nJMRKRJy4K4Ryz27j3NYAGC53U+pM89DR2Fvp3vYA/4xeN3hYFmPpVnxcyt1O4aR24f5mpCBVm05DtgBOsHE4OzzGHQZN6y8TsOkI70L98OyOM/FTPqbYlHYjIAAkoWliGCpX6hmGuk9wuKMHpa8Ygr/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU9gHXGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU9gHXGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3458C1F0089B;
	Sun, 11 Oct 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723924;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LU9gHXGmAF82MewX7rDnusPgofkg7B/0cklxGVQaO56iF3GHa0He+K79HQyq43aFh
	 dwBuN4156z+gc93R8I3+jhYzy4cikH1cTrdVwC06qAjRjiibcPWpYS++5m/GFcLB0R
	 RigWi1wR36rfYpxqoPlvgNxljUCkTSizCFhSp7rtIV0BdhoxqmEfC6QooNFPeyIG1d
	 PBMyky2IFVERTUWNTEtQbIb6QlZe+x8zf4UGtqx5HfVBWt/NWHTXseA3oA3D4QYs1C
	 GmWjg0/LuWSOfwcNYMG9w2BI0I/6HMmHyo00TV7skNCRPzLKxL9QWXM4PLIdVkKWwh
	 Wsa0QY3g+X5SQ==
From: netdev-bot+sinfo@kernel.org
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>,
 Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Subject: Re: [PATCH net-next v2 00/11] net: ethernet: qualcomm: ppe: Add
 support for IPQ5424 SoC
Date: Sun, 11 Oct 2026 13:05:22 +0000
Message-ID: <179172392274.2527009.4852578355298213005@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
