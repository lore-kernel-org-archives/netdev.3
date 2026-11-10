Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287091;
	b=WhWIRlp4k6g0EXJ3MXKOV3kSziy+MA8WPQNZ5hDlR1bVsKWZSaZ+YuOr9DG4SfDoBKi+
	 p/HIxDIjC7fpUZ1Acu7D1vqC8xDPM+utCUxIKDpQc+CmNC0rieX67cuATOZhCgnzYn9LW
	 Ta+JmgnAW2I3NNZ5qVlg3n5uzJrZcw8iRi890Zsh3LS+tKoSjkDXvnYfCKSH+tlfWXPQc
	 0IWtvuysRHJaXdFYAr1gv8wuGvE9uac9FDLmGwcArHq6dO1gKFZQjZxo+kdJrh+K9Xhdl
	 YOp8ab/nCLWYZmgCs8RGiRDcynyadUHJuoHfhG5SufGMA2dicdbQjE7pbYAUpfFXvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=2MS/pTeSBqRo/CAn6zP7gLppgljGM/Lqdb0k1d8oNXbVbCtrruSnB2vC3X0+KPynbOFW
	 sQB+/DLUjgMwJq1Im2tqMCTNpBzdMWZGw4+kEQedmMdOcEDwu9vgHjvykv+yqh8ocDjVO
	 Xl735+vryQg/YTGdgo9fKI0M3PMyVFy6Q8CIUKCSH2XmItZG+XEZBDMpP9s0JDvgLuCkX
	 FvWfVYg/cAYla4y3F9jpsDa7R/RKdjDyQfqKElsM26nzZVsHcgsHGUYNE9SY+/VYwuEHg
	 LwTcrMGYXcjmMQlj2D5Z8T2HKd0MyegBBt24q1T4TpFU/3rvZQABnTekk9PSFo3SDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFHsCplW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363A606B0BC;
	Tue, 10 Nov 2026 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFHsCplW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89B21F00901;
	Tue, 10 Nov 2026 05:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287091;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFHsCplWNglbNyh2Uossqp+TdiNVpl85viQs5DaVoYE3pqg3YmMMy0qSWC69ZQ3QL
	 Vvzczu2+GmZGnhtchIW4qxzH3Ncq96wpRnCA570ivuz7WTFUwbxVrEqTpn7dfjdUPB
	 F5z/4eUkz4DksB3tmjIFD7MJ95TRqNx5OY1lkRRYoMSI9Ey4J2Z173IymGQyTvNOOI
	 ShGerRur2KEBtqoYfXIxuUh2TWoTdyzt2qPfC8S06shLplWGSqUz/X3oiJ9bPVBVUR
	 AtQVTvOGdVHHua9KJ/HDErsPVcP2/OK3blMGP3j6MfzYBaklbgEzlD8Rfoi3s3S1FK
	 F0L+O50YYmBOQ==
From: netdev-bot+sinfo@kernel.org
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Subject: 
 Re: [PATCH net-next v8 00/11] r8152: refactor and extend RTL8157/8159 support
Date: Tue, 10 Nov 2026 05:04:50 +0000
Message-ID: <179428709025.488859.2482232158851373475@kernel.org>
In-Reply-To: <20261110032416.16968-1-nic_swsd@realtek.com>
References: <20261110032416.16968-1-nic_swsd@realtek.com>
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
