Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B19415F01;
	Tue,  6 Oct 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296752; cv=none; b=I+xewtvj29eaMmLDURGOkQzaxMsTYTrHeTvcKZinIHFWaug1wnEYd3/otRF0Z9Ly8dsg4M0TqcsW/IidFwWGv87WCRUqADVgrcUMV5fmXWLe54LB91uNE5X8oJxZNOZNxC0IlWkEKUbHm0giAK2tRBgILLNJ8J+H4tu+RITI2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296752; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvOWn+XPDuNaMh6USxZx7T1OJE1wCoTgbTHalrZb0M3w7ZNF2YeE1jFZwGpMxkHBp7DtUxeZHDr8YJbVta94CAwhGZMuua8Z8xcRur9CZ4McHyr4cIleCWZViP8BDAqfCMqLSnSK5HCNgyKIu+RAGz2mAKvZDUNbRcALzchrJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd087LV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd087LV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E1F1F000FF;
	Tue,  6 Oct 2026 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296751;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kd087LV8McQ26TXokdtZnbaKDnGyK4VHaHSvS8G2aAVtUxDZIP3qergqnF3BpZutY
	 BbGhiChPKAzPJk4NcyjYtXCmmrB+cgrrue1RctYOPP7+uFStZmEN6WZ4tqq6G4n2wd
	 YccXBK9t3Xt7kK1BYESNpIZ4Q7663DGTiJ/EbllmhYjUGng7mEnDjEeVTOJ0BJPqpj
	 1awKhancberdavn5LwNsI1qkTqgYSR9cIIiAkkooSg1IiRy2axtF2YnL7ti6xM+J0z
	 TsSOGTk6D3wxnur4eXP1wh9k8rCwRZjoUgZsMmEvGxAYcE0n7ii003eKc94TtmHIjR
	 FY5ye9k1hyQGQ==
From: netdev-bot+sinfo@kernel.org
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Subject: 
 Re: [PATCH net] bnge: skip dev_addr when building the VNIC unicast list
Date: Tue, 06 Oct 2026 14:25:49 +0000
Message-ID: <179129674990.2231598.7339597424457740197@kernel.org>
In-Reply-To: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
References: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
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
