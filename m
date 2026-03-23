Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B202BE644;
	Mon, 23 Mar 2026 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302345; cv=none; b=nI1HC51My+LL8oCHobabqpQQrMoakxEhbk+4uqtHpc4c87D6V4CKhPMwWWMJ3smazy/tlUSBYLWsTTMxBPADMVVRGAa5Li/g9Wk8QdRKyT/852NIw0b8O8rFEqF7+9mklnAIjtwh0vBoNOKl7w9Zj4BPlvRH8WxKm2kXjBvtAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302345; c=relaxed/simple;
	bh=VITFuGFpBD7idTQ9bwVIiO0Kbe8zJIHPqCz5ac4iSos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doQZPiZ2Ogp9iTIRDISkJv+vOtTlajuFV57I5lzFw15ByZlYwbOP1CM8JfmS7IM3R3VaHXspDHe4xC1PcmeGVbacxA/ZT4FYGCznBG1ryFK42Bv5aeofURK18ZMoNppIIqKfCBcCX+STFhfFGEk+tOmUOMLngHIaXWEbwgKF6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSjjjMlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSjjjMlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAFBC2BCB0;
	Mon, 23 Mar 2026 21:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774302344;
	bh=VITFuGFpBD7idTQ9bwVIiO0Kbe8zJIHPqCz5ac4iSos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSjjjMlB9hVE7KL2JxQ3Me4D7+o2MTI5tyWkYMUFI0YByVA9qerXqXhE3DFB9IOax
	 XGS8figT5TEnNPtarT1YGXUX6kyWtaKj9z/vYmdMuUfK0z2/wKaXp/9yUwjfg1xB26
	 kcvqg9m33WZclAjxAu6eL84YfbIbCMg6cNBEU5vyF4GZfjroVniVeX6iitgfzV1TaA
	 7OJdRc3j2FB2je5OJ6NySvhWzpHC1cEgonMd+VHN2MU6aJFPaRQ4PmLCskSUsJNzlP
	 RID4lFVabzh+dFXtandeFZwGvAneieSLY4qmONvjIOgZDbAPhupOjNDRtDVpYlwqrU
	 4LqbdwPtxAJdg==
Date: Mon, 23 Mar 2026 14:45:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, horms@kernel.org,
 alok.a.tiwari@oracle.com, davem@davemloft.net, marc.dionne@auristor.com,
 linux-kernel@vger.kernel.org, security@1seal.org, stable@kernel.org,
 pabeni@redhat.com, anderson@allelesecurity.com, jaltman@auristor.com,
 edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing
 queued RESP challenge serial
Message-ID: <20260323144541.3ef887b7@kernel.org>
In-Reply-To: <1433905.1774080919@warthog.procyon.org.uk>
References: <20260321014543.3892478-2-kuba@kernel.org>
	<20260319150150.4189381-3-dhowells@redhat.com>
	<1433905.1774080919@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 08:15:19 +0000 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > The review under --- is AI generated. It looks legit to me.  
> 
> I saw that there was one on patchwork, but I couldn't access it.

There's a 24h delay before results are public otherwise noobs spam
the list with 100 versions until the AI is happy.
