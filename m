Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451062;
	b=dEHPKw1ROymfu9BfctuUX3ecznWR7t8/OOESN5s9EMQwRkj05SBCm4ICxosA6Q71JZlN
	 JhCuJ18QoaaaZqyCHHi48oAxuaJA9RROzNtHSwjPxUUS1MPOpSY6JoP5RlcLYZs2DpoZs
	 AT0eyI2TNNEi3Hzv+u55X77MLhsF1HC4w4bXlWswE4kfvPaDFdkBPFib7KZvAmWJvTyad
	 QUJuLSxXcGaq+20XoFrVrH/ZNSIKq3Xjstv6Si/MfJ985tsoy6X4TYrhdwctcATadxO0f
	 ANtqBwQibuXfsf/yeu8jQtQKhOOh68tpE04ZHfK24CVZlnDa1Ptees7gSa38J5NsmJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=l06vHv68Dr7raonvmJhMR2ifW51ebCoKh18xIWLBlAJZIgO3iIz8gSkihY9shU30vcNc
	 cmT/LIrm0VXPcJWppAPJw+UHEmDrpum53hK9euF+1OTnlbc9jiP3AFvfikV9F8BgpRc1u
	 emnIa1nOc/4FYWk8bLWC4aGdYT73jdK8tkj/c00Opvz/wHtck4KKtbgoluE5thpcMSiaq
	 vdzvV1aolyLMdySDYgLNxRYcWu2oYt5i/rkqJ+YMI1QzHaUpxZiLXl3poBTUXxX4hpK1z
	 C9ZmBnAsADeT20U1uW8CSoCxp8JSpVVSGqeLLlFqU/pZFVhp2GlvMaprUJdp1BUnBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERgnQqYv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CA606A8AE;
	Thu, 12 Nov 2026 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERgnQqYv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9541F00A08;
	Thu, 12 Nov 2026 02:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451061;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERgnQqYvfvolna7L7ee0cAQo8HaWthmedT63ZNTS0MmzNGGR+I5/57I2BE/lpQVAL
	 EtRz3ryIJex7MoSFK7Ln1s37xaI6rOLUtqcBlHJ6yyivBJBh8SiH8oMeoTybg/wy7A
	 NLbX9qxT1xoY+RLSbDuBlqiMSN3h0EqvZW6HlBJFID8K+Koe40lGImaFeV9ghzcOvc
	 ZkYE0lGcJh/D00cg2UTZkKhgHSBz4WbG2U0REmBKU1kqCs4aMyt6F0f/cRd6pRJSmf
	 cyzBnO+Hf/A5ThrapbDWSOoroSHvl28Upq8UR0omQi7Vku1+wuPDT2TIF5QdliyUR1
	 64hhPeeL/H4Tg==
From: netdev-bot+sinfo@kernel.org
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard: Mark concurrent accesses to reused indices
Date: Thu, 12 Nov 2026 02:37:40 +0000
Message-ID: <179445106063.2168702.961983939936124723@kernel.org>
In-Reply-To: <20261112023022.118119-1-zhujun2@cmss.chinamobile.com>
References: <20261112023022.118119-1-zhujun2@cmss.chinamobile.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
