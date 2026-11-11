Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400012;
	b=xIf4IPvGMtxQygxzsTS1pDFTPM1D3T5NN08Sqz/tX45Zt//mjXh/fKKfEJzG4jIF7gPQ
	 yQPEodbc/JUj44R/5vbr7oNaBylU+KNeE6HqPYB3tGsbHzAc79fhPnB2jqX6iuxwMYwew
	 1h07icXHlpBmJFj++K+sh7xErM4Zabjcp7srwCTI1ofLA/ngDBcy3N4s8Y2VsZyfd4/tQ
	 DRDLyewMo3Hd7UaGn7NYFE1MD6+EikHEinqErFRWOILKcPF/ZcCZ8K2AHKS2RLdhsVZ9I
	 NtEET8NsWYYCSrBjjS61EO2zqZCozh4+7J0mrFazklElhrlMtdFUzh+dLbC51Td5NHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=Vu/3CiqIz2aiQVAqx9WqVY6vbibhNU2qLwAsNQEb6oLrPBxUnPSp8/HNl+0FVEfKAbnd
	 MnblSR9kOf3BmcsGf5ubxhr0Y56BfOf+X3YUwiKMQH6s6RNHciXYd+U0lpUgRzjGEYs6X
	 n+iN//UmLT49+esgoYDKTJRIsIxivObUUEBnaCoj4DpbaidyAcThb7misQfjS2k0Gby49
	 yLbi51wsj7IepH9Mudetl929Tlxf7DjKg4RAyiNb/c3pHd8dw1DZ8+iB/Tr5R5kAJGcdT
	 3Fiddq76X1ipldUWaG0kuapQXlVwBJ1NpHVpT+8e7a1n6qwb/zhwM3ZQNs/HrpyjTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="osYbtIe/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439F606A321;
	Wed, 11 Nov 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osYbtIe/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FE41F00A05;
	Wed, 11 Nov 2026 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400012;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osYbtIe//9KH26xdUFuq2fh59vkhY2AyViVGqccxTk4G2uYkQJenl70xl3J5BTXhQ
	 FupOt7sHtLUsolgnWSBpCC13b+GZQAZNWZIKdCTeMoJyMIag/MQ7i+vyNJfZMzzQYX
	 aQuEu9kEHHvCWD/ZhuMIcWGw9mjP2A2JVLUPeqKkjuhMdFuRXnfoTR5TxGvg1XUlh2
	 AMT1CLnslj4gWznuDZBQOY9yHhFJPTVaONALntk6NgRirbBcBiWCbqK5DpAD0V3LBL
	 7fTtcQBsFhprJVmDkdB1YYztiGbj8CyKBSnluMFNmw1A/cvXpWviBeL/8z8HVfmpBD
	 I5wRa1euWMwqQ==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: fealnx: Fix potential use-after-free during removal
Date: Wed, 11 Nov 2026 12:26:51 +0000
Message-ID: <179440001109.2168702.9141461927909422219@kernel.org>
In-Reply-To: <20261111-e5624093d6-net-fealnx@mail.sdu.edu.cn>
References: <20261111-e5624093d6-net-fealnx@mail.sdu.edu.cn>
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
