Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425571;
	b=luWG0/0vs2eKmlKQB2heb54g6cGT701EKoHFOfPJ1stEqmd91/vi7w9GRsMf+SzaS51E
	 +avRY8ad1ESS93WWwGB72YAcR57xrgTjud3YQj05Hx+ZRQlw+0KKnB26YA4CvWrwLsQVi
	 CKwDdWVkybgHdTazAyTSfU18TBgFqz0mqk/Lqo7HwVxAB9CFqAJksq1HHdGpRpq3lwo0c
	 HRe3zVCtLZCPRs68MwNJLzdr3Gt5Z2mMloW/OiTJqd7xUNDYO0woPh6pzXXlM0LG7EmJj
	 jiElOX8azuKnoA0jXbWDnDowrmrByc9GpmXZaKSCoO4rHMiC7BXTbXELX2aJ84idcaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=mN2ep11qOK1DYwLdIdwJeOnZLmrW2+5ufsf+2tUslI4J9FBCXax1jq+Xov+ndRL3WeGQ
	 0nlDVrdFcTiSUgzzZIhyngbdMt3uvCLFivG/hfWjIFJzaZq/XT5aL3wLnz5W97bpMLoMV
	 Mz3hSwiSfnwyzIajTRlAb1eVprGPyWuBvKZBU8QSRx+A9tAn+wRagW00sbfrn7lj9xHDu
	 zqb711BahZYOzmrEwrYIsAVZfe1p0yFVinX3TNQ3ycsAKPujBJ0xkWLFI7hR9E1Ye7ucJ
	 +ve503ScAS68ych1svx5bt8qUTIKwKvPmkzfT4PO4yeOY0PhCrn95LRCzJGkQVtxtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOI8LEzm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64E6072484
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOI8LEzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374D1F000CA;
	Mon, 19 Oct 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425571;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOI8LEzm3KAD1o8KuCaZ8nhbcDjI8iC2n7SDqRF4qKftxIelKQDKHx2lG08qM6RdJ
	 ayQL/HXCbbuTir2RCGTUCQ5THIOA0ho7DGUG5Bvxn6gC5qn3QJUmupb2dEU49IlYFq
	 uih4IG/vwphj5YZBaVQikF/eubPyQwp22iSvnmd0yj1cPXzTNq4zcM5V25o3BQAYsX
	 QSlURdroalFP3kqQnkAxWgRzssHaNfaypm/d4FYW8xMlu7BqJvhj+72IuHxUahHKy0
	 gLmz+RFIgxU+OYOPGHeesO8VMABxV+e/FMgqTDWdRUvAhAYjCl/Tb9VXVKHeElYxbr
	 uaqzp/LJBzn0A==
From: netdev-bot+sinfo@kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net v5] team: reject CAN, IEEE 802.15.4 and 6LoWPAN
 devices in team_port_add
Date: Mon, 19 Oct 2026 15:59:30 +0000
Message-ID: <179242557006.3290.1248852285610208076@kernel.org>
In-Reply-To: <20261019155407.61487-1-socketcan@hartkopp.net>
References: <20261019155407.61487-1-socketcan@hartkopp.net>
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
