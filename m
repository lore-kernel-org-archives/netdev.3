Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AF25B0B3
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165582; cv=none; b=HhNwE2dSfYbXoJ2Qw3s74icx0n5f1tWh6MqSghXtnAm0OYDrdxgySOjZHhZBf5WIqXkS/7qca65uD7SzSsnWBibMS0NltuZr/76n4ONTcy1dBzCLKl1HfoXjfmfhVpg90Kw6ZznPccRqLB+PmaXXH4PkZSrwS8g+9Z+ARSa3qCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165582; c=relaxed/simple;
	bh=aUtFp0L0Qs77rAxqrlsG/L0Ka5rgfU2HsbpxrJxfUNc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tbvh+BzSpZUhBREFv+TrRqGKvRw3MISvkzoeqStFflCpxoKVaO+RUdPBhrn2KGNyuz7ipB8MHpuwuxeDVJgf8yqm70VNz2eFsj+HB3yPR5wCEwy3Kyb2HiRC5gHgVIWtgeNwzgUpgGnf6dR5yuIO5XMcMxol/ySBHO6BjgPscVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FrstgC/p; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FrstgC/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780165570; x=1780424770;
	bh=aUtFp0L0Qs77rAxqrlsG/L0Ka5rgfU2HsbpxrJxfUNc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FrstgC/p4rqYvT345FyO30sNVKqAdbzMjkuciJgcadr4DZJ14uVTQBpGIXKfUSvbU
	 xvgIDdiQ3lTXb8xyyDKl30cRy6KyetaHvQI4Fka3wP9+5/jKZgNPCHTqkq44rm4fBv
	 inqfIEfsgbm2B24bSrQhgqIbJpOvJk4HDrCK5xOUqFIlwRiSeiZq4J/RWjEj6ABJOA
	 7gKdrofj8cQMSCl9srPU29U5KDXeCuqnyh+m2zgg7fT/NM+i186nLT+qCmPMo+bmKb
	 BXdc7RJuonu6aCq6ckUW9lCSEpnBbOfKiJ0rnh1JBo1LJ43yF3h+tM5upDdqAKAzQH
	 O3dal/hVjE0eQ==
Date: Sat, 30 May 2026 18:26:07 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "security@kernel.org" <security@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "david+nfc@ixit.cz" <david+nfc@ixit.cz>, "oe-linux-nfc@lists.linux.dev" <oe-linux-nfc@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "w@1wt.eu" <w@1wt.eu>
Subject: [SECURITY] net/nfc/llcp_sock.c: unsafe userspace sockaddr handling
Message-ID: <PYXMRVOSKGaZwZAeXC2PScmTBrZhHXwgdSapPlE030ObXXtRedDcbPD2lx6-3lzLWqr3aB2Kf9eAbDig3HuXn2gw3cSaZhqUA5U9HrSVhC8=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: fc392576e843686a1536da83690ac91251953ec2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Greg, please disregard my previous report.

After testing with a POC (which returned -EFAULT, no crash) and reviewing t=
he
call chain (__sys_bind =E2=86=92 move_addr_to_kernel), I confirm that the s=
ockaddr
pointer passed to llcp_sock_bind() already points to kernel memory.

Thus there is no security issue. My apologies for the noise.

Signed-off-by: Eneshan Erdogan Karaca <cyberblackk@proton.me>
