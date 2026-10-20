Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498720;
	b=FGGJms7wxOKalOOcELDw7+EeF1Fdyx7FgEQUyMMertXy9tBkW77qQQ53pAeKUK54udZm
	 CamtzgDb52o/+ldXNJxnvE+7abEDy+slkTpSQzwazUgQnvTxnWcZUPpv2Jq8I3YQ8c+JL
	 EwUvYK/Eu8O6GdGznAg5y2LT6sVp9XDzRcfyZxGb6Rr4u1usr3z3Lp4lMZEBHVMa/Jtvk
	 GfqBSRbeyj56A0qCmEn+WcfDt7zMVFwcuWeI61oUnl85vwalXJFCa6BYTod83fctsX0Zw
	 maznTTWsTebxZf3qRnyO29tMN350RtrWeOxZ+iMTmdGqX+ABjFr8AAr8jHLTCdrhPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=nCgStuHksKQ8kxyIbJ5VQYbHXkxLboQuIBGI1tfnCZomA2VJO8NMkAUDDqcVo1YBHCmS
	 r0TBoNi4rk4FPOy+jqK6InmNOE3wDS9AUpdTn/63dGLZtD+T04IMNC+BYS75zFXLFLrEz
	 pmfoT/k9dwyN7pXoc+yEgCi45ilksgKwLIgsqiO0+sAbDuCpEzZhJYVTlu+aXr+fQwV7d
	 TN7jhq0xzVVU0LQc0D1R449DYM3wA0XlZHUwJYvMs+Qj2dhZoBb3Q5fi2ybJDHsym0rYO
	 GLlztMUL11UFRXYKd4s9i+EveqToJ1v2WJmMNRWBHjd4L7YL8R+b9ruvkqMptdwjIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfWT7WIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D61606A31C;
	Tue, 20 Oct 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfWT7WIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2849F1F000CA;
	Tue, 20 Oct 2026 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498719;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfWT7WIXRND6ZIz5gONxw5Af40ud7yuTyP98GK6xvAylCxfTLue8xRWewg9E6HDt6
	 07LnkrQL5uQiS+cFhHk6Ua8JB+R+bn/DTvH7CB1yqb4PrslmMsI4LtvJUCw8zFWpek
	 P/lxpvezOYVQO7HmXA+ImkaxpiS9y0ZXcZWmA6m3WE2n7/nnS4EzAwirZRupuAf4ap
	 VpUfUmq4wdllKlngwEPYLWgPAoAOQP4vsXLSsTgWfx8wVwomHq9+REP86ucekPu6q/
	 Oeb7tez3FEtSDNS3uKvKpPr3EShrJ8CJsvFdysPh0qnju+pbrK9I8EOfUXcgs0zPYK
	 rYT3ppmx+TG2g==
From: netdev-bot+sinfo@kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, sd@queasysnail.net,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tls: fix the open record check in the max payload
 size setsockopt
Date: Tue, 20 Oct 2026 12:18:38 +0000
Message-ID: <179249871864.3290.2514170744091654346@kernel.org>
In-Reply-To: <20261020121240.29082-1-jiayuan.chen@linux.dev>
References: <20261020121240.29082-1-jiayuan.chen@linux.dev>
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
