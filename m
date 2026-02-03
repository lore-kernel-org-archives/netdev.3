Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBD28690;
	Tue,  3 Feb 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083315; cv=none; b=MfpkrSVDoI8867f8kTwH5b4JO60aVGUOk7wDAP56D4WFEeu09QCDqbMqhgsxqY3MP/SoS5uj842PeZOWC39V5g92o+Jcft2RIlC9x0Uo68iqhD6Vq0ncEv+EOn5dyvQrZIPqDgRJ9vAIvvrpadaYoLvWrBlnWqujHA+pVA6GHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083315; c=relaxed/simple;
	bh=9lzm8SI5baCzlelXKFMWtlw5t0GVxqCRKrOPDGdPFSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ4VSO5R8OBtRbPeHervL4YDqybhjsgA8qqLUWi7kFJiJZ0lUKieVfdq+I/n91cqFIdiHuLkcidrtGOG9PZkwwnOHE2clQnci/QRBS3qUT8ctVwkDXREXQbYNbhmJYZndxoQ/BIdk+ALNulNTXN4I4HhSc6+ers6tNssa517i34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVJ6iT5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVJ6iT5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26CC116C6;
	Tue,  3 Feb 2026 01:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083315;
	bh=9lzm8SI5baCzlelXKFMWtlw5t0GVxqCRKrOPDGdPFSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVJ6iT5te8A2jWaV7UIiNClb3Sdrtbju0KzzxJe+aPoIszTbl4/ugZd0Ds8PhVnXw
	 qUebo9tifhYidps/b/G/nmqyrchIPWkCSHTbycnBDXFQmujBC7IkQro5ok64N+zxpS
	 wWXtmdoD0BrQ9sfvNjele/1J61gA4i88hLkjap4U5q+nX9u1j6fSv04Absiy1/uEri
	 WAPid4VDynvaOmTJHWvnKfT1r/40iutw7+M9LAsasVLQwpWB943T931WAWW9sKHSFH
	 rwafdAcjkq+5Gc3arvWAh3OzeFApxA3W0BuVjTFOOVRBWweFsVMk5La1inYIMyG5GV
	 HoAYn7T11g69w==
Date: Mon, 2 Feb 2026 17:48:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Hodges <hodgesd@meta.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ying Xue <ying.xue@windreiver.com>, Tuong Lien
 <tuong.t.lien@dektech.com.au>, <netdev@vger.kernel.org>,
 <tipc-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()
Message-ID: <20260202174833.3e0ea821@kernel.org>
In-Reply-To: <20260201022128.2658251-1-hodgesd@meta.com>
References: <20260201022128.2658251-1-hodgesd@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Jan 2026 18:21:28 -0800 Daniel Hodges wrote:
> tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
> in 'tmp' for the NULL check, and again inside the atomic_add_unless()
> call.
> 
> Use the already-dereferenced 'tmp' pointer consistently, matching the
> correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().
> 
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>

Somehow this didn't reach patchwork, please resend, and while you do
that please remove the empty line between cc stable and you sob.
