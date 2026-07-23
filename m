Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6ED377574;
	Thu, 23 Jul 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827600; cv=none; b=ezLNLzQCzkI7nR2Mg7cJlqhjP05M69sFGqGhFGkt+Z8mikc1kIlGHdyVPnEfjtMKJVgyzDe/YXa8cqO3yZyLQHgrmvZN5KuEmyuweK3IZyogywVmT1BLzEeyid5L7SrkniIwyCp2sn+bD7BH1mwShjSL+3mxgerf4YF4YH6ydDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827600; c=relaxed/simple;
	bh=eu9rOs8nHj0wnbsNO1axWevls5H4S9Yq2+uX1Y6xHEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+k7w8rHjjxTLJlKyv2bOyNovZT+hjVJDuVbzDUWjuSmY8G5laHB+BEjCaS3d+86wBJirMFga1zO4/+p+Lz4kTfxUhjckM6QMdepN5RUwdYk1WdTya8SWWpnoT4Ox+pL6tfM6ewLK3M4IKq8+U0gWOj4ZJLGxZ2DMq+K0sPuIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9219A1F00A3A;
	Thu, 23 Jul 2026 17:26:38 +0000 (UTC)
Date: Thu, 23 Jul 2026 10:26:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: horms@kernel.org, madalin.bucur@nxp.com, sean.anderson@linux.dev,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: fman: fix IRQ-related bugs and add
 probe cleanup
Message-ID: <20260723102636.28b4d920@kernel.org>
In-Reply-To: <20260721085841.488088-1-zhaojinming@uniontech.com>
References: <20260709145221.1564906-3-horms@kernel.org>
	<20260721085841.488088-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:58:39 +0800 ZhaoJinming wrote:
> This v2 series addresses the feedback from the previous irq_ready flag
> approach (v1) and the separate UAF fix patch (v3). It replaces both
> with a single root-cause fix: moving IRQ registration after driver
> initialization is complete.

The cover letter must explain how the issues were discovered and how
they were tested (what HW platform you tested on etc). Also:

Warning: drivers/net/ethernet/freescale/fman/fman_muram.c:133 missing initial short description on line:
 * fman_muram_finish
Warning: drivers/net/ethernet/freescale/fman/fman_muram.c:133 missing initial short description on line:
 * fman_muram_finish
-- 
pw-bot: cr
