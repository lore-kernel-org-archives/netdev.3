Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D993ACEF3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020321; cv=none; b=GaBv052zInCTJvjySy7hLMSip5ceQGYjoGdpHtuSYkPXSmfIWTYKgEbKtguLsM8/oDTKRdsbP62UlW11ZGUbl+LrkzR0yHKAcp9UGFrCNq6eFPFTDbsRA9PNekxbIRD7fAsy8ufNSYvv2EkAuA41YZMi8xXv0mH25h66iw2pZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020321; c=relaxed/simple;
	bh=5ALLlUA0JDLyU5BCEA68zsbTd8dizoNjEs+DtY3kKX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVOufvyS/MYbOhrl5Dg+mF/FeGYoyyAQl5MDxrtklGmQ+/rl1BEcFAS+RjnyHbPQDmqQnChMSdLqmOLg0PddketMt4RoVycOjOaBj9EX5zCp0xtDadpWnhSzZVUTFK6RQtYoBQKT3I+Qp0uArAvnsQP/dM+1n+84VDIKwEdLcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVZUjGMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVZUjGMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F7C1F000FF;
	Mon, 21 Sep 2026 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020317;
	bh=orUtAGMJYzqcv/TbwXugFiLjJLVusdGa2RUp9QtxTJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QVZUjGMvB5T+efr1/yYJptlvgVK/A74enOoHZANr81SyKiIrNj2XGf7laBy5Ytd97
	 VkctbS7Hb7YPHj5HuqfcAf3o1r8c1GO4XtbwBI6WmD/Db50VUfWREC3cR5zoCjQ9V/
	 fuj2R+sKeutoB7bchQpU50OgvqxwlEbPRK3laAyfTg1lYySFLN2wpWZ8sTdddm3UqR
	 rsJY8GgATXTNDzc9p5UcT0BZHaRWn6z8m4aFDnIKcRiAvkrxrugdt9cIQCqYMfZNjj
	 rzvNhXT/Pstpz85g17umD7oIxRALqR97ToGQSH3nGfJnanUl8gzrxP885DlROcA4tm
	 WnnYOCiNkJNJA==
Date: Mon, 21 Sep 2026 12:51:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/5] net: synchronize proc_do_rss_key() with
 netdev_rss_key_fill()
Message-ID: <20260921125156.6623d5ec@kernel.org>
In-Reply-To: <20260921183758.1812310-2-edumazet@google.com>
References: <20260921183758.1812310-1-edumazet@google.com>
	<20260921183758.1812310-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:37:54 +0000 Eric Dumazet wrote:
>  	struct ctl_table fake_table;
>  	char *pos = buf;
> +	bool initialized;

reverse xmas tree

Maybe we should call netdev_rss_key_fill() from the proc handler
and let the net_get_random_once() handle the safe init?

IMHO the concern is entirely academic / hallucinated so adding
LoC for it feels strange
