Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322018;
	b=xEpOKtVUSt0QggmXF3+M9GrCnQCp1NMd2wy8d4H1Lns6QhaBY/E5bBeeFp5Kad9Nw6KJ
	 RlMlvqCKZ8gkdoBbm3F4jjVpZnf535U0GUfUHVDaM6kSFmIuQEVQqlksHrCOcKjDCV55v
	 I6+aOJ51DD5QCP1Umbrqcs/e8WYVQU+yAsBkgnTPwvn/j7mYSLdB55aTbIV0QuMaKjn3m
	 cSflS9khizRoH877CYzxcTqMmfXr3beOWhvUcmjMUnwuR2Waul53Z1TkFZP9CpXspfw9h
	 c5mhR+yn+woFccr/ueEP3WiMuiYlcUlNlP4FEhis01CIZA2A+6cBmVFTQao0c97laww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=s8FKLnFKq6Vuw6NEJVhMa6d0NVA/JxLd21lqC6GO7MKokIr56gzOULRrAMFSwd3IANEx
	 +pRtQtoo5T5alxWcg80HqClmbsJazrB4leFnBIU4FEmXonmdcGmOIGGEyO9Y22nD1AO+4
	 qn2wEuo9AzwQTATShbFbuPxvD0N1DNhYOMbQeqAjvkvJawbkZCppUUFq1yjPYd2sJP0ML
	 PlUjglLuMOmctZkqNhGUL0VzIIbh80HjDxM3822lPpiFraBZKwYaph4TfbmMPHZrkLqOz
	 hTeWgMX6KMrKdtogXVUiPtooDKLXmEom4xpVMchst4wxgArys5aa8DWE+eZ7A3k8jRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG9VBhRg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017C60A3808
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG9VBhRg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC1C1F008A1;
	Tue, 10 Nov 2026 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322018;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lG9VBhRggWmUPp2EJkXNO4RbdNAqSexvtPAhTQX/+mS9YvL7Cv431rh+IKv4a3di4
	 HkyFJ9VIsaaBSJQmVAc2caoq0D4EYatOSUfPDA66tIEn5XPEzPLLJ2N64/81EKmBTl
	 oCQcTgUyCbi6d4BHswdkaDhLbQk9vnLevJ8rGqvU6nRB4lYNJBA8HdNij7VhcE+/OA
	 uKeZPzGnm3XTu7WnTTh6hPSeRY+Bbmi3885wC/yjdcJsCnJfFoEGNM4V2pmYSN1ZUl
	 f4k0LiAxSC4iCNhZMtd57k81DmrnNeAdAI4wuxP+7i0PnHjyljNrHc9SXp4xvblh1+
	 2pnM7u4dpw39g==
From: netdev-bot+sinfo@kernel.org
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Eyal Birger <eyal.birger@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: reschedule NAT keepalive work for new states
Date: Tue, 10 Nov 2026 14:46:57 +0000
Message-ID: <179432201725.488859.12108349638231652047@kernel.org>
In-Reply-To: <20261110144321.94096-1-pocj8ur4in@gmail.com>
References: <20261110144321.94096-1-pocj8ur4in@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
