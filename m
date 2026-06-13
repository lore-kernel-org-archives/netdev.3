Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDD342509;
	Sat, 13 Jun 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388816; cv=none; b=bxDy7UW1DNyAtMVqj8UJBDIb59xxTIIAtW8ZtGP1WMvKq435dn0cgLIDFDCN3z9CtB/FJoXf1YA5DNd+t7vAdRNs+aYefFatfe4D0X3i5obr0qrlAqLUx9GatCE+i2cDIbMQptwlcsdJpMrTHZVFEmwDjmWtxSFxpOOWnL5usm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388816; c=relaxed/simple;
	bh=Y8Lezj3lvMaLQ6PwBDR8Aq+/aErLJ9Bsl4xd0v03sp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg6LmaFr7qU5PBW1Tbn0YScnxMpZF5qc2yN6J4Eg8/gUe74vwdK0g5ivhgbzyNlg6vuRpliflxEx3T7uf6xEpcVFaS4Rq/a5MmyLhFeJbz/xb2khko1G8Xnc+/XoVIqZ7liGrgAWFMdHT0n18piXOb3NT6zgvtlPV63ZnqwgxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPrd/UVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPrd/UVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415A51F000E9;
	Sat, 13 Jun 2026 22:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388815;
	bh=Y8Lezj3lvMaLQ6PwBDR8Aq+/aErLJ9Bsl4xd0v03sp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hPrd/UVsix22kJGWdCA1MGaKCp1oGwPzQh2Dy+5aWn1lcRzAHwn7FL1/RCA3gF+bf
	 ICaEJoeVERVdGIU3t5h6l3er1eCtDo6ITLUpz6zpY6SYSXBEASsOedD0xxHPsxdaHd
	 OLtEEN8fdd6JyW4UH9b4iJf6dH4jMnJJW60HLMXKJbpu7LBbnpoEBNbWsia2V6HQIR
	 pE/gUiMgxo3bVYsdSd7Fm0YHEHnKi/FWpa4sNxbPqpNd5ru/C6t2ZHOj9ODtkcQsqx
	 12bKOXo+4C+yRA+rgxjgC5/q+wT5FDH6TEzXmDup1Z8JNn+VqBmi1gSnewNoeC28GP
	 mmDH1QL7sQawA==
Date: Sat, 13 Jun 2026 15:13:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, amakarov@marvell.com, tduszynski@marvell.com,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, Ratheesh Kannoth
 <rkannoth@marvell.com>
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state
 before request_irq()
Message-ID: <20260613151333.09de141a@kernel.org>
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 00:00:12 +0800 Runyu Xiao wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.

cc Ratheesh
