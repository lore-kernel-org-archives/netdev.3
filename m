Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A552ED3C;
	Fri,  4 Sep 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559911; cv=none; b=IV+UNgK8+AalgeyK7awh1DycUuIGp9nK8rThBP/E4L4NRohWH0ZVjtPCXBCyTGxxNJJpAmtADHUyKS1Ha3A7Y748jNzPLvn/yaPvrxJfZFE/+AYSRseORmw2QVreLg+aV+Q2aD/4SiRVHn6CEoz7RJFketJCo4QZgrrEXJGFkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559911; c=relaxed/simple;
	bh=+no+FXss/SBY0Tp1nA3kydRlsKbjIBEzTNyEMZ/JXiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtZy7rnKTsq8yj1K0HpTMtBE7NezZg+eR8E/Gz66Bh4lipPjLpR+FhlZ1O8QswUWiA1UeboJjdSm16E1+c0X3JxxO3bmpdljYcqJv9FD/E0bkxNF1+Af/F1Vyl/9vHaNdR8lreO8uKp9Lyh2+Y2K/jLhoh4rtns0S0QPqnvk4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnwvvmQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnwvvmQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCCA1F00A3E;
	Fri,  4 Sep 2026 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559909;
	bh=+no+FXss/SBY0Tp1nA3kydRlsKbjIBEzTNyEMZ/JXiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CnwvvmQL4Ie44ZAM5YEpEHx1zeUlhX+q95YKS01U4YHYLFo+E6hYwRRu5VeYLUBnj
	 /x9MGqnH9nOn5800EZnL19Go3kjuJ//KTqhWbtLalHjW9d5dJhGenkyjmbkeuELzw2
	 uTiA2q4CVvqDv36hWjeoG6xD8YwstkZTHIcr0GYzuX5yaYjK6A2bznj1N1NZhgfIdN
	 C5VVN5EkGRjay8JMsrj4qJcuf9xzU2sUypwRGtC2WwGxHF2kE6+S1t/UF8ULuDmpDN
	 GZ7Ely1Jhq4zswrAToYukQ2rH5nAO9GcsPVS2uFtwKtIBe+eMhUo+RvdawbwzpAatk
	 N1NDrW8/vz+xg==
Date: Fri, 4 Sep 2026 15:11:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, Mina
 Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>, Bobby
 Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next] tcp: devmem: only pre-allocate tokens the
 receiver can consume
Message-ID: <20260904151146.602c61a4@kernel.org>
In-Reply-To: <20260902-b4-net-next_devmem-token-refill-v1-1-81d8990e5e17@meta.com>
References: <20260902-b4-net-next_devmem-token-refill-v1-1-81d8990e5e17@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 15:24:19 -0700 Bobby Eshleman wrote:
> Testing on a CX7 w/ GRO and a steady sendmsg() flow of 1MB per send, we
> see a typical RX-side skb touch upwards of ~32KB. With a 4KB recvmsg
> size, probing shows that ~75% of the allocated tokens are not used.

4kB seems unreasonably small. Is there a real life reason to use such
a small buffer / read length?
