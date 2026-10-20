Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540155;
	b=RDUQ1rcqWTihmzpDONLy5RZJUXo5h2Bdbqqs8MlhO8y+lLV9Q9dsKKxr0bwEmypoXotG
	 pPBLip3TlbAJR/jbMTXOSY7L+rzgjKJp8Vzgcspd66w8KxGeH9Wz9kIS2ISAZaZ8Dh9+t
	 xTcvmVpHWTXbdqiFLj3FQjbOr020i49OZNwkd1H1Oxoxh+htPrXZzYukLxm5A8g+Npm+a
	 PGLafH27khP7xLI7/uT5IKa8vfZ1mZW+CmT+SHYDSBnjGt2n98E0JTCsDtAKj2qq9YrS6
	 kXntT1LtFO/BMVDe0R6MlbddZq7pVuEgC5cDi1kaYAsnkV4f8lE/d3uFlxRDjlWKfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540155;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=4efstRBCTkshss+kZp4p+7Q0K/msjYnI8Ln+ssjawoAuxUvyHnEI0IuQCrXnZKn6B2Vm
	 nb73Oadg3EyJMsv+zYeayDcW3K/NCu+PAldYGLO+Jj2nWhi69FQV/V5/jRlrxvPRTmPdo
	 e7Qu2JayiIXa0yqpRcj4U1Lm53apjzLH2ekKJDqgCcomMoGZpS3KxpSbkjDBCzNcP1XOW
	 hoX7+Jpf9qgZA6hVg3ENA1t4xJBx6Dcrzmp7VNtNrAsH88up2hwbyUBkgClh1V0WgDyNT
	 3DKaUS80KfhSCsaN1MkygEEedynRtIKe78JdlKzlm8tUHARHeCrpvcwFyN+9jgDoYzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/fB3u+t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93882606A31A;
	Tue, 20 Oct 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/fB3u+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774801F000C9;
	Tue, 20 Oct 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792540155;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/fB3u+todQZI2tcuq2nMT5ajP9bLQTwH0pZMWtpiByoKUrC0VjsOkv/5TbL/ZYEH
	 jmPSpgrwIyrfaZUpPbFGbQ9tevlCapLduc1zGM3LgtR/k0hz1OuElLBEmIRKlgi451
	 9Hayw5Ggmn/A+gENgbxmxiTPC+29ggDQpT0kP3WsJD6ldDOavjhazgjqv/Rdut/m/C
	 e8gw0qrV8Io/3jRK2mZ3TXXkFebzlqBU78TOi+0KAon+cQWR3DTgIth3+frQLYnk66
	 DffhZ1yF/zgdBZLgvaYbmLuQLj9aYw2hv+BXkI+Qc1F/LuC4itvALFJ8GRdeP4KKUw
	 K2l9B04AUkWbg==
From: netdev-bot+sinfo@kernel.org
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, shda@confident.ru
Subject: 
 Re: [PATCH net] net: sundance: fix sign extension of the octet counters
Date: Tue, 20 Oct 2026 23:49:13 +0000
Message-ID: <179254015395.3290.17577233959153156723@kernel.org>
In-Reply-To: <20261020234434.318-1-rand.sec96@gmail.com>
References: <20261020234434.318-1-rand.sec96@gmail.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
