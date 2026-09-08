Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025273B7B72;
	Tue,  8 Sep 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899799; cv=none; b=dYmTWRDzdEchOIx3XsFJea3qdNkgU2GxswE/FmH2b+qMHoHnEW0NAvziYPEGhKyWaf4hFS2JrM0cS7fOQRiq5LgIePLP7qXc0tbP74ndlzYFiT7EHifpzq7UxBRq6DFMKKTK4qboDiSKs2ukRwWLZVuAmKCj8WHokmnkjJ2zOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899799; c=relaxed/simple;
	bh=En3L5stSUiDxr4u14JrrhR3Td47pg5j0HIDk/Se9pRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCsMYfXyPh9R2Swj7pJbMGd/5QWdpfq2nrzLmhBv60G7tnhgzhJUyjmBJcH+Ef0kidEQK6gIS3wtU6/3V4me6J1YuxzYON25eoRSxt/YnSCNygcCxdzWK7A6naAmuoHJah1Pof2us6Y4P1hcEKZEBPrhVR7jfs0p8TTAQMEXfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwu5NVJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwu5NVJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEBD1F00A3A;
	Tue,  8 Sep 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788899797;
	bh=YkhrU60lkYWjMLRg+mcGdBRBDPjCQKJlQBVqkc+X7WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dwu5NVJxjcHSqMaqfJ3os9XJhEutBGyaKU7vqO3/bUhLSDwD18WQc8Rv2pNMFLUOX
	 qJM5S3EPHDpJh1b4yXWXRiAXkH/ZDyVWJZn00UIgDitK5AmOHcztzbcPczH5mlFpmW
	 DjeaBKtE1qo74fRUAJi6p4jHJEV9kzKC2hwOzzK3U5NTxJoaCkxddDm9NP3HORPBVX
	 uHDw9STfNIFr++wVFWNRb4HqguzbDvTXuk4UFHW6v2rJCqgjEYabvJ11HBS1XVk71e
	 s7r66mt7HtcH6BCZWZA5jBcStQMJ5nKXiUI0YQrhJv/RgtydYbcXTLFRAoC9fGWPFJ
	 WyA5ioHx2OiKA==
Date: Tue, 8 Sep 2026 13:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin
 Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, Neal
 Cardwell <ncardwell@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <20260908133636.2ea807d9@kernel.org>
In-Reply-To: <20260908060410.3982-1-nashuiliang@gmail.com>
References: <20260908060410.3982-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 14:04:00 +0800 Chuang Wang wrote:
> v8 -> v9:
> - fix errors in AI submissions by Simon Horman

I commented on v8 6 hours before you sent this.
Please pay more attention to what you're doing.
-- 
pw-bot: cr
