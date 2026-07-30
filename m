Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108F3BFE33;
	Thu, 30 Jul 2026 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446218; cv=none; b=swv0+A8+o11ieD2FWNOBW1l1bIVTLruuoFg1raD8GKnc1LfVUIN0hJxFtkBPy1KveDKJFM+qQe7owcQdZOHPCXGLsLf5CSSob8I+h1xJKp/GogfCcqNcNjV4Ygv6Jf6f9iz3oyioXuEFVJNd0ELzL9QIBFFfavuzjRmuyd17qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446218; c=relaxed/simple;
	bh=wLUliK0qNT6XN3fFRkYlUfoZ3EfdJ3RB2Shrd8C9l5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPDVdCe6zywcfpPLDZ+wO/8OTdchR2/cDaLSK8ktMaAarzJWBKI59erFRjaKh6STgjF7UeFdXAdrsOWo07B4XyAAZHi1kD2oW0B8isvDrsokT6a5D/KS5OEKXcpKmltE820YsWdPYrOEkHwEUNx92jo7mz6vRb2WIIIW4fPjVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVmQYFFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVmQYFFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1551F000E9;
	Thu, 30 Jul 2026 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785446216;
	bh=/swWG87rr+upA5TBYrdcvg2wZ1k8HFzm4gqmEFB8jqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UVmQYFFyNgEjcHEGMExEm7wTCHKYnPMQNdVIoStKEqoRFUEpsP0A+p8oeS2Yw9T69
	 NcNOH6cWYzmyEcnMDSv79Kjpl9NFY5YqnN7loNSROtsTtl+R2HqjFrgg86fMf9u8wA
	 DG/MWBx216Kr0ZEVwMBY3MN3BCrjXF46+5B08Xl2chnMw3+gXUcoxYPsbDss/A2Slc
	 CR0cNyU65/nRO1wr8Sef8L/FliVb4GFJqZu5ZtDvSEohWsOD5+PKrC2AiCCg5Dn/WU
	 W6peuV/ML48bHkUl9y9I+LTii0EKjECqNOBVsjraMoqXZxMlKpdclPaBkiMVAB4KCb
	 hvXTa+iOU7BVQ==
Date: Thu, 30 Jul 2026 14:16:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 0/4] bnge: add more functionality
Message-ID: <20260730141655.2c326b2a@kernel.org>
In-Reply-To: <CAHLZf_tb5+JmoP9=LyKDwnmsSTzefC7py0U6HN17hGYqvU8jpA@mail.gmail.com>
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
	<20260729163352.6e0b9bc5@kernel.org>
	<CAHLZf_tb5+JmoP9=LyKDwnmsSTzefC7py0U6HN17hGYqvU8jpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 11:26:17 +0530 Vikas Gupta wrote:
> > And the concern about IRQs being in use on shutdown perhaps.  
> 
>  Since the IRQ issue stems from the new shared bng_re RoCE driver, and
> it lacks a bng_re_shutdown
>  implementation to free the IRQs, should we implement this in the
> current series, especially given that the bng_re driver
> implementation is currently minimal?

Doesn't look like the other patches will conflict, maybe I'm missing
something. If there's no conflict perhaps you could take patch 1 out 
of this series and post a combined patch series for bng and _re
scoped to the parts that need to change in both trees.
And we can pull that series into both networking and RDMA?

Note that you can post multiple series at once, as long as they don't
conflict and the sum(patches) <= 15.
