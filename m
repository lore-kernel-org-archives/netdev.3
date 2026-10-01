Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D374DE725;
	Thu,  1 Oct 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846035; cv=none; b=N8HytIMrWK6hdLhS2yr19ZFnc7tVghea+elnsZPL3XudDGn2y6cN17yDXyaA0ITzlPoGG2yq00hxOkIHsu+PcKoHsf9gjVxfJ9mM3WWHorPIHffhjeCQ3kW1AphStDzOcOqEcSYi3XnFmjAIiW/j3pRirmm0wTRf61sbHpJTHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846035; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXzlw6B2iMaIz52Z3NOqmGbik6d+l0vH2iDbzxEw+SUDQ/IZsy4peB3MUlDPCk6Vxvaq52PIPpdcYh+yCm7Fmga2KnQ4jOa2CqL9+SQyRnMbvl9LTfppQ77p5Vdz73smuj4NqTdtH4fizotH/1O+7L2j9zlUP50lwMyEH9/7edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM90FEjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM90FEjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7641F00898;
	Thu,  1 Oct 2026 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846032;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VM90FEjnH1Jc/my4/6WFOt3N4X3uPhqaVrkqxrJAOlTNE+TubfWQHDrS+IBJPEeFM
	 RYjoDuQZwJOQRK3zUV4V7Cq/pEAXJeUpFBXdpDhY6sYL5mzsxf5xiBGBlqWr5pRn6m
	 WiSMvVt6f+b0+C35rsI4vSDDZUBlQfWf6skln9yrkHSqwq9KXx0jaDcc3mEkirEOub
	 O2JfzuVeDgDADjA0gdWXaksfkO966GjnSb137RbFS0jPKaOhFPC6rzRnh5jvKbb931
	 /2ISGXswKrx6BjuVrUS5uiCHXF9I7ZsmuHpmSTWAV8yyot6TJsf4xsCCgjPwf5S6iE
	 z/PPSE3pNax0g==
From: netdev-bot+sinfo@kernel.org
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: 
 Re: [PATCH net-next v5 0/9] r8152: refactor and extend RTL8157/8159 support
Date: Thu, 01 Oct 2026 09:13:51 +0000
Message-ID: <179084603160.31693.9503439666123508587@kernel.org>
In-Reply-To: <20261001091144.28191-1-nic_swsd@realtek.com>
References: <20261001091144.28191-1-nic_swsd@realtek.com>
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
