Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444588;
	b=z7ugsw8zXTbWG8SypfoIF8yH9ykv7ksO1JgxihMGqRkhGxRNtVFDMdth12xznsDUEWRn
	 kh/iZn6aZO0leE6+/vYO12a/qmNz4WlBJxNUUmFbuHwt0F349pnLI1yHk4QWDEt6kVhis
	 TOHNFNAc/jS1ENtkO/qMjxsp8c7IO71ZA+mkYzQ9/v+cAwee9fjX7NEm+IEH+loOkcdVK
	 0X1+zv3KqfbpEiY72/5At8TxlvxHMWdTanEZk+FgCsLnTeuJkUqsV3Izc3YQeBR+xlTsb
	 cDfBbyu0f9jHwbq4+rWXUVs7W5eeWsivSM/JSDhf9Gd3PDARK5qneryNJ2/BYzlHS6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=nji9v7YPfVp52xdQ75NSvVXCNxdpAFSkpmeIyfM0oVogFEQLzm+c1W22HuZLfwYtxkXY
	 SbHrv9p4NOlcTjZOpO+ksswbY1DFo7cGa7HHzWpllYH660bwDAPMlb2Qzhfs87tJk8Rfc
	 Ut8Gdy6bRoxkgz3qvPyDeZi8tJ8camlDefAYuu5y7svyDEh0DQ5oI6jXlR2nFbTWUnbTI
	 +u5j+AZ5IBrGRP2ZAPjUVnZRfKqWn9BugzDiKmxaKICdvR3DhJSm200oGsygHo9TxQtXq
	 K0q96yhe+BkQM8/fNWRdHHCqExciFFxWobfessOCqlAUbpeQjyiS63eLLQa5li6twUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuR2qd3C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3106606A31A;
	Sat, 31 Oct 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuR2qd3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0411F000C1;
	Sat, 31 Oct 2026 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793444587;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuR2qd3ChuWNT3PLyeA8ezzKrEugX/Krsi18nHp6PG52kmbRFYyp8nW1qZYihgKWn
	 qm1WDWAU665q35N8VZrMFBKTUwyxbc5T3L3fv5uZhbOKr5zIGDtP9sQUlywXip8bsV
	 foxXj9No3l1WvLYfOZqFb3Ciz1dtS/gXl+lXbcjoGpqWJ3j7sFSnijLeLhofuIN59C
	 s/blaMHpDl9CkyyQDzWgrQOOYz6dqVeGGHGMgInNgUMZABBwEL4gUIM95mt3gJGw1b
	 KAN7z46SOuJNCkaLiiJxf7YBUvpfpgH6CoTyJ99VM6tQHBtFJLDqZHYPULGcWpMRnc
	 q0yBeqWaKvzYQ==
From: netdev-bot+sinfo@kernel.org
To: Maholi Tumanggor <maholitumanggor@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, eajames@linux.ibm.com,
 linux-kernel@vger.kernel.org, paulfertser@gmail.com
Subject: Re: [SECURITY] net/ncsi: Fix heap OOB write in ncsi_rsp_handler_gp()
 MAC filter loop
Date: Sat, 31 Oct 2026 11:03:06 +0000
Message-ID: <179344458649.3286.6525891273156291826@kernel.org>
In-Reply-To: 
 <CAELScTboG_Bqn1hpM3855oYpM=io3sW-zMWs2AHkH6T0bpx7BQ@mail.gmail.com>
References: 
 <CAELScTboG_Bqn1hpM3855oYpM=io3sW-zMWs2AHkH6T0bpx7BQ@mail.gmail.com>
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
