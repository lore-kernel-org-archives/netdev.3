Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C6347505;
	Wed, 14 Oct 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966345; cv=none; b=DfewQJMGXqSkHZgSBVlvFhc3IehkXRGGgm88BQPHu1dCnrhNSXueeWvvacprj/CI1cIRJke7a2FgEInyw15CzlibU/wb2i/J0mjBmpiYSxjHQnHjgXf8ulUcBOtAziSSNZZdfLn9ryEJbtYZCxhggS/CW+rKEGaQFDYZnBM0DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966345; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGoZ9AkTbVOuLaiV1WZzhDLZRugNPyfZKPZU+wJeM+R0ah9FyrHNozC6UOrlRlnTsPz8fYMa/LXF5qIZZHYOnfQX9tKEpHFk3LjcmNDiIZ+qjuWv2MExk5x9tzGZhd28Nboq1J3AavHfiFlPOXeA4bLFYxUGwOy1NdLoqMGdAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbLRN2i+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbLRN2i+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019B51F00899;
	Wed, 14 Oct 2026 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966344;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbLRN2i+zE+ZIyPPoSFNSASVKk83MWA5HkjC9M/swF4wNfBHyFkYOpJGi5c8fqYSy
	 AiF3B5COyXj7EwiXqBti/Ym+P5z7+x9dwMrMwem06yYUe1iRQI3ueyG57BvKE8nH1M
	 EihUmt1RaXHruRJGeTeCVB/63Sncg8QQ9KDwlRE085TyzNbH5sADcsG74fp2ioHErB
	 0qiLsksuHNns5muQ044osYzZh261gVNOOCSvKUYm5oSLMJ4iyrMaXMWW+76KBieEFb
	 gOagkk8qy1mVnyuzVyOdcLMgdjnJJN1A2dgR4vbBBvXzoh/0vkSpG5sWSYouN6LxNE
	 Kz40ldkCmA1pg==
From: netdev-bot+sinfo@kernel.org
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Subject: 
 Re: [PATCH net-next v7 00/10] r8152: refactor and extend RTL8157/8159 support
Date: Wed, 14 Oct 2026 08:25:43 +0000
Message-ID: <179196634352.285325.7698665772326745735@kernel.org>
In-Reply-To: <20261014081904.6491-1-nic_swsd@realtek.com>
References: <20261014081904.6491-1-nic_swsd@realtek.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
