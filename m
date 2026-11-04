Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788747;
	b=zQ4pm9YWJzIRHvehVCetnregGApQAaujVSyHV5KvFj3RwusOaHeNjIuAg1K5jNeA5NX8
	 ayho53YCea7iQVjW4mw64SiYflKSIyop5kfQ3JjfnnTDA+UtTQB2GRO0iBoLWADtPkXS4
	 PXpsaJqYk+/j2Cc5ujT7VQLFnl1LDdbDGuniYBpfpi+2KKtcudoq9jA9acFxTFQSHv42+
	 utUZUv1hAp2iUZP6XAoO5X3ENuVEeVdwfnug4jIY3LsIDUNz9fHKJyDiHcyezPO4byoww
	 YZZaoCOS7YUWkXcojGEKvf+Zpg1JN3KHZEV8v2IZHR0rOx2gc+Ydk7ImCttqR+RaQTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=tJFP9XVpWfaQZniGv4o5hOBSRECA+dxcwyELDKuPDLEmHMXcslqxX5fPfuxuG5e6LXQF
	 gptFW60G85TH/bPOhBGANQJZu1JrBKmpT5+KMKCphV/6RT7JShUFK9coSuVkRTvB2Am/i
	 H5E7YPBrbOdFuuJpmfGPo7PSwOkVqTaOMv2XvAJVFmiWJ7zvnfOirUA1FX7NHOYuOD2WO
	 m3gh8yk0gDgYRg/iamMeFWWbuyN4Qsnf/w8tmttLja8mbDytMA1sZzj0sxxKne1McsPNB
	 koxOl6p2O1pQinvbbbBQJbm86oH3jFk2EMRozxw7zn6G8k6YimmUol1cM+E7B+z+7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9NcNn5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964B606A326;
	Wed,  4 Nov 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9NcNn5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0A81F000C1;
	Wed,  4 Nov 2026 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788746;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9NcNn5JoNuP7lqMLLqD7SYkPyZ8Takqfg6UfYAGIqLmdRwm1bcBkST5OHtgD9ixO
	 ZHMIbsnyk7t+SciSGPArk66B2IlemFtbE9pfF5ErjKLfvVRRJHeCZbjz8pXajAXl7T
	 5xwmDeRsQG9BPGKt17nyMppJpPe3PaWcY7BKzK66d4ORpnQyTdosF2ev5Fh4+6ve3i
	 AzEwznqJpB2O201eXcbzs1UctlYLn9/ESKEW+JZ21WToA/22SY5ysRQxS2ayQDaPvu
	 w25egIdPOceqTd/Yv0ik/oLo8A/XIQCqtBY7DrPMCj9vAzJjXx80Kdje0e+OYSdbOX
	 uZBtDwmxZs9MQ==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Hariprasad Shenai <hariprasad@chelsio.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] cxgb4: clear the sge maps and bitmaps freed on
 adap_init0() failure
Date: Wed, 04 Nov 2026 10:39:05 +0000
Message-ID: <179378874585.488859.7495464009535804637@kernel.org>
In-Reply-To: <20261104103309.24360-2-fourier.thomas@gmail.com>
References: <20261104103309.24360-2-fourier.thomas@gmail.com>
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
