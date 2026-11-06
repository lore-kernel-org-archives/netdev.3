Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972520;
	b=I8QQPXrm/R+snVVfQNx2oAPfN43GMoBPaRtiQp7pcRgfkePTwEoAK9JcIK7WDYMdM+Hw
	 j0GTSB33j2imZ9kWGOjf3Bt334X901lXdUfVDZgIWboeMNZzmad0Wu2RYbhSMWvJjduuJ
	 AfW1WcM82OciZXUa6cVNI6jQW6oz70+kEwMeigg0XupzrujJKH2UjAhtVYFeBkBRiSc3G
	 MRvOmg+bg2Ay770svGCXvfEJRajMtZX8rM1UN1dnp0l2QHUcglMUF1noFlpcV32KSecEG
	 OI5E3OcwxGDEjerDU407Sgv8Xxqtz40Uteb+EXDYBX+e2jiV/7vRFXjC3Ul5J2n6bVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=Ji0JU7A0FkxL8aCv8ZZhJN3Mtmo+2l5n18Z2Ao6DXUec7R7f/OnEGae4ie9MGj5K1drb
	 Vq7NuksjBSTFaHMEarg+sqCSoo+1zTAjx50W4WEAJs3rXpEF/nZcggf2udCkyZASm96c4
	 /ftGeGMqpESBBo8at1SARCYMejnElPqY/kHV+K2SZUlMIHFwfeLuYv8KCuq5qjmMG+GJv
	 xkNCkxxgFOMrpszp0mdqfau2c+986+ao1AaoeM0cfL9qfEOLQ/230rONT5M74mVqf8/SU
	 3cqXGYkWkz96O6mjhovVdqXkoQq0TIlVJQ4vtgMdGPA6VG3yYjYrbajcJaGc7JRmhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aisZjjso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54215606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aisZjjso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFFD1F0089F;
	Fri,  6 Nov 2026 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972519;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aisZjjsomh0LDyMr0cHUnNyYP4nBvYwN6IZbLP3h159gjn4F1XKiC4RmYpBiDxMhB
	 /MoJXeBizJcHtXBjAE4YkUNaSPJtSO/h58HV2MqbPLhf2mFO8h9EAoyrwLinQRVF/z
	 OiEnJ9hltewsRRlJGFtWdmbZlKiIwcPpXdw5jzoy4k6rruzNTKlQ3QwjwimZCSssXI
	 t9Jvq4S8EozxTApgtGTtpYm+xBF5ZJHmXNPoQzmpO0LoXdO4t7G0jZyXtduKtWXrSh
	 7+yelNsnECe6dK60IBQS/x24odtuzWcxOLvpGLGly4E60N2EqLTaCO8AmB5rXsjKsC
	 OKcZ03tH+84hg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] tcp: cubic: do not trust snd_cwnd set by BPF
 congestion controls
Date: Fri, 06 Nov 2026 13:41:58 +0000
Message-ID: <179397251892.488859.17742398754045102912@kernel.org>
In-Reply-To: <20261106133748.2181133-1-edumazet@kernel.org>
References: <20261106133748.2181133-1-edumazet@kernel.org>
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
