Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918229;
	b=ej9yG5u0svBVPhc0jrSm2Y8c1wOdojSidNLRLVA1wl9PBB1gwaMbXxIOsIxIs1LJu21a
	 6e9Q2rXu+zAswWMFmW6RldpZz5VGs/nqWkUj3KXQUd7Fq7LiLPr7el5jHvRKtDRZ4LhKb
	 C0nQJkOgrKyiXmR0JWI4e28bmcdgfIDPckdm0OrP4vxCB1xUJUNilTEkQ/S2+R4ffUS3D
	 ZddyCBcRQ+gSsvFJD1xULtMoKLto5lqJLeGUNj0wUTkKhomJ/uc8sfqFP/9s4cbPVEniR
	 50YF8HDqQujqq2nmKBPrED38GTL0QIo1C/m4MdAtaF69YWza2pSkQ+CAIrZdHhCBBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=a8vNZa25nnSCMIkMBsOueHTRith+7KBSj5F6yPDAOyIjS8wjnlaaJ3nhphMAx2LVzToc
	 THKKQGsa8FJiH5mpgg5gjQORk64V+EWqavRyJRTFuV+DiGWZZosIXSO5d7Zf93PPn1X4R
	 lrjG6jg+Z1y3t8KoPQoY++eTCHs7X36ZrW8ekuuJqMy2duXW3c9PaqYv8mpSQdRVSIt1j
	 dknKMESCI7pvei/FW/WNCiPqFLsJ0bpzbuVUMV4nwMlPzHdkx8waCx5VDoQaolDePIvF6
	 NOTCzHnl0Ajvl+nQreZYxz56ox9aulbJQ9NPJm+HPDFrLV2dGrpFa6ZJe/l+y6yLSEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkjxTW4t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A59606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkjxTW4t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978931F0089F;
	Thu,  5 Nov 2026 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918229;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkjxTW4tgBEISZM38BO0ieLLI5SEheLHlvCr+YrIXvfbItkFNvoKIpjZvpgzMlay3
	 rSFNhRJYc0tv2IXs4C5ow8utIVEZHwW0oxIhGNltoqGQU2d6v63XPa9tC/njJqRdGv
	 uMsiAJ0uTWPv0ioPIKrf1agbajSESyfMno5MWFlsHHPOV8U8sXRaj9JEO0BrcGUJQv
	 rz3CpiRLpl0e86I1aJWyQpbbkUvGeRiqpvMCbO3W7LiFl+9AJflfEqI15W9VdoD3EQ
	 dL4o44Uj58kgiCi2IHc8Dih45VadpCssBS3kGJ2dId5xBKi3sS11OsxKohmGSzckWa
	 O9mEEFhXpD5Fw==
From: netdev-bot+sinfo@kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 Chris Mason <mason@kernel.org>, Kyle Zeng <kylebot@openai.com>,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: skbuff: uncharge trimmed zerocopy frags on error
Date: Thu, 05 Nov 2026 22:37:08 +0000
Message-ID: <179391822817.488859.907054151678387708@kernel.org>
In-Reply-To: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
References: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
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
