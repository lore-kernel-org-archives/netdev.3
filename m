Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287070;
	b=w9/lVi2X0V3OXZ/f82D4KYBru9L3KTqyCeBKBbk4LCGnE15SenlyKj3UuSnuj2sDKaRI
	 diA9LUixQNiuA9kkK8mqE7yYB2sQ9dcmS/GUg5aZpTU3YjzJ9fdyBPwM38nwseR+Q7amv
	 SzMfGNAWdJVmSHvpXROxjE0lagcd3i59j3GKTwxdNQkPcBx3CzKWWlf5EMFBc1zl/yUtY
	 sAUI1iJNPfKv7zOHLCDe5n1yjtA0W+uHZBS3wMs+sBmmp2fESDL7H4C2M5ZlM5nIlx52F
	 yODg+zDNUa77+mzdEpVt9/BvXMMtBmJDVfknH1cgE0mK9IVLBl0hOg2LY2PRz54rVaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=TJ2tQSV2aODET047aWOJttNDlY9nVLYhmxGIgo5uh2yoxSyDtjosAdE252Zmvl68ti3H
	 XZsxrUUBmNLqNnqZZ/84fGDSRokD9XlylWP9WUaQd2a79nmanQl74g3AgQb9DBahTbYme
	 mAQpQJpNUsYSh2xdS8Rxw2ZcrkXUUb+R3XOzhgpUC0gB64ROWZEnyOuJmLPqs72YoR+vI
	 ZojaQA1BejWjX12XOXqdFXc3Ibr+qSiUh9kwCx8r+Fuk20gY2JEDn4EIOJ6sXomsjJ8rh
	 fhByhB4HXDfnSi5SKLTYv1w0GdhWfPuqN/wupyJrZJcDNwlRxLqnjxks0jQxJGCgFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI6U7Ef5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E0606A331;
	Tue, 10 Nov 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI6U7Ef5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060371F008A1;
	Tue, 10 Nov 2026 05:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287069;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VI6U7Ef5c2wUCHQEjC4GnCxthSlTWcrDdiK3cG/R7hegLGNEKWE4pDg2D/ABSgPZK
	 GICAhqS+g0Lang1sZDvQ27vwArZl04S0aorkphH8fxQrI7mrJ2JXeuIc4PU2vvHBqm
	 tm4VmkdIROKrk2ki/kl89+VS4BZvUad2sQt+v5XE3UpGFJko6hAU5+X4qBP0soKt+X
	 G+46jvYiZgXSKiwHLexURsCYphsm+ilMUB2tTJyun3dAdmPoL0XhUqgf1IGLvpUKQ9
	 JCcNyvFbirxreEDD+IRpSJu9i3BhDk8+ZMUhfVdxyjtpVrTFDINvs+DiCnp+7ZKRyC
	 7MxkY6gdseJGg==
From: netdev-bot+sinfo@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, krzk@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Subject: 
 Re: [PATCH RESEND v2 0/2] nfc: st21nfca: fix SE APDU request race condition
Date: Tue, 10 Nov 2026 05:04:28 +0000
Message-ID: <179428706850.488859.13999450246707929195@kernel.org>
In-Reply-To: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
References: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
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
