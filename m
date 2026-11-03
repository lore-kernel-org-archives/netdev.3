Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693107;
	b=ZBEL+kq/ZEKjeX4K8YXlIXajAQieDZZ5iTnEhBOeG25a/n+8pc5ZZiv3l5tW0r5nPI+X
	 AUEnLfwwHS4j456a5AQxbCLXbNI2birmdMFI2QPh3uA+0kDteLyH/mhuixxTGUcFVV+UW
	 bNWjVRpGVzQanqQ9Ah3y+IPUH0i8cenSLBzJqHXMfu/35UiFjapvnHR7F9k3SYez23gLR
	 jOjVHjm7CWX19yblvfIyipjmBl1SOjmkru03FVAuupTk6j+YoLxg9rIxvAwGdEKMEhbJ2
	 OY4PTo7Pg1aGvC2h9+fQTvFScWWtQCAx/Mbqf0u+9ekHLLSz/qrjUxqJ3uqn89ByHVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693107;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vv36BLNoPEPRIU5S1Q8sEEYY2dx5aoOzCPHVQm/wBQk=;
	b=FvhCNMUqTN10vzgXdvHIEhNAywqluxao2bZKiaeGzYK1z6ubwAGL5C2NkyuLR9keKhJf
	 MZmMCuaSbhZU7a41r8Sho0gR/pNjGwUwlkv0o2USIuVBnpuMBerXtWpctZnR6OcHFqA7T
	 sjUaHQ90bVf6zENKD0oLRWRs5dNxPFP6PlyB+WAOp/+Pitsn8Z+VKIH1ALpm7O8jx0zE9
	 vmDrDEFKzkOHkmyibaXrK4nb9f+3qcvp3dSx8Q4cLX0zi8VqJunVpZsTIK6ua92wO+TlF
	 J7rXAbgANBPgelQvh9EMqJzR5wPzBHLK53vR0CM1t1tMFzqju4fxd/U28jHR4xIL0yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHdqj4lz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390D606D815
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHdqj4lz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E071F000C1;
	Tue,  3 Nov 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693107;
	bh=vv36BLNoPEPRIU5S1Q8sEEYY2dx5aoOzCPHVQm/wBQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cHdqj4lz76LHsHy4miAOI+74RxVhGfMRr++RhTNxt84nLmKoKxQ5pg9iVtA1HqyCE
	 kBTOUGawobRMqRCShOgT8ex1u622W0f1CvZ0YttNgF3pk6u6y0jESMzAflmCCyWGKH
	 JyAL/EaCy8vwjd/si4DI8BiQRVhj8GWnvUbhjS6ZrF8P//9MFlSxcoYPYt66Jynds7
	 sZOkiySgzg0OlNmSmvFRJtbk5rW+PloZfE1fhQsmXOedMd8HzAb8axKecLesd4at2q
	 rxhG2Mo3+q6P+vWYhzcPYkgY7Q/E0hhKbvMMcf4uTrL2WgcdxCCbHrTGQyj/vbRuW1
	 zTsi0X5rf7R3w==
Subject: Re: [PATCH 13/14] docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE
 EEXIST tuple
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:06 +0000
Message-ID: <179369310657.488856.12324309096843147027@kernel.org>
In-Reply-To: <20261102100451.2505200-14-steffen.klassert@secunet.com>
References: <20261102100451.2505200-14-steffen.klassert@secunet.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new wildcard-shadowing text in the Error Handling section of
  Documentation/networking/xfrm/xfrm_migrate_state.rst does not say that…

--

docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple

This patch updates the XFRM_MSG_MIGRATE_STATE documentation. Mark is now
listed as part of the tuple that can return -EEXIST. The SA lookup text now
describes the exact mark/mask match done by xfrm_state_lookup_exact(). The
error handling section also gains a description of wildcard shadowing.

> diff --git a/Documentation/networking/xfrm/xfrm_migrate_state.rst b/Documentation/networking/xfrm/xfrm_migrate_state.rst
> index 9d53cb22b0075..ca2c9e5aaf33a 100644
> --- a/Documentation/networking/xfrm/xfrm_migrate_state.rst
> +++ b/Documentation/networking/xfrm/xfrm_migrate_state.rst

[ ... ]

> @@ -259,8 +264,12 @@ Attributes in the notification
>  Error Handling
>  ==============
>  
> -If the target SA tuple (new daddr, SPI, proto, new family) is already
> -occupied, the operation returns ``-EEXIST`` before the migration begins.
> +If the target SA tuple (new daddr, SPI, proto, new family, mark) is
> +already occupied, the operation returns ``-EEXIST`` before the migration
> +begins. "Occupied" includes wildcard shadowing: an existing SA with a
> +broader mask (e.g. mark 0/0) claims every mark value, so it blocks
> +migrating to any more specific mark at the same tuple, not just an
> +exact mark/mask duplicate.

[Severity: Low]
Should this text say that the SA being migrated is excluded from the check?

The SA being migrated is also an existing SA. Read literally, the new text
says that a lone 0/0 SA cannot be given a specific mark at the same daddr,
SPI, proto and family, and that the request returns -EEXIST.

The code allows this. In xfrm_do_migrate_state(), the source SA x is passed
in as self:

net/xfrm/xfrm_user.c:xfrm_do_migrate_state() {
    ...
		if (xfrm_state_mark_collides(net, new_mark->v & new_mark->m,
					     &m.new_daddr, um->id.spi,
					     um->id.proto, m.new_family, x)) {
    ...
}

xfrm_state_mark_collides() only looks at entries where x != self. Its
comment says:

/* True if some OTHER state at this tuple would wildcard-match "mark".
 * Used by MIGRATE_STATE, which must exclude the state being migrated.
 */

Because of this, the source SA's own 0/0 wildcard never causes a rejection.
The migration then goes ahead, and the new SA is installed with the
requested mark.

Could the wording say that the conflict is with another SA at the target
tuple, for example "another existing SA with a broader mask"?

>  The old SA remains intact and the operation is safe to retry after
>  resolving the conflict.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
