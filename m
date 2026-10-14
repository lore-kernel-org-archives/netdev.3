Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C229C328;
	Wed, 14 Oct 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968736; cv=none; b=tFVtDJ/BJ8QMOb2QocIVDztQnlihmblY0/4NMoFUa9DSlKcC8ut3LDILT6xzyMuOimeVSyXjj3o8PPkeMz4wmlUObQehiXkRrx6tKLQWMNBroxlkIErnl9HQCSPBOY00S4mnLE/DCjVqlDB6Mxisdj5cb9aXhw2VEXhDUadZaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968736; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qssvLI4u4+BcnaUf/GBQCZ2KKsx8DQtQudvYg+fiTsfk4UGIu/EPrZidMY0A3TrU1fSIrOkYsGCEfnZ909dE4bljnwTGRgoxEIkJ0XYUb7dBAAeqjmr8JDR8kOs7y0RpgeuUGbEmBFfTqSMdHbV+75HL39kQzEfJy9lkFGAQIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLeJJPjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLeJJPjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20141F000FF;
	Wed, 14 Oct 2026 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968735;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLeJJPjCN1mieb5PFqMRcBoDVwPdZebHp5rYC++YCFisHjDRXc9/nimDzAcK/ncVL
	 bDhdxL7wUq0yXyMdShKNPjWIIbQc64i/EiugE0UoI+0kXa2cOLSTCdxIoTTl1YliGV
	 vlgkp1nNLZ4Axr9u7eDuRL2OjbV9F29t2qTOwxxJcZBatlYBiq6QdgLd/RpdXSXVBz
	 gIkvGTrLYwPhfiRU0iWgTvl8Uqzf/DJ2he8/Z5CPmyqxjArZL2fIhbx+oV2qdH6dOT
	 StyQ9IUqoCJDNts+YqYYR0UKFj9KpMD0kIpe2CMZ/wNZ2mAJyA9Xle+29REFr5S03Q
	 v/kEf7tFLYRyg==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] drivers: net: xgene: Fix dma_unmap_single() size
Date: Wed, 14 Oct 2026 09:05:34 +0000
Message-ID: <179196873447.320699.13617341073721247406@kernel.org>
In-Reply-To: <20261014084817.41805-2-fourier.thomas@gmail.com>
References: <20261014084817.41805-2-fourier.thomas@gmail.com>
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
