Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A7221FDE;
	Sat, 21 Mar 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084546; cv=none; b=c2cHt+oEGezxSd+h2ebeFDKtRRsVkJ8jXHCV3Q/JyZeucO78pBqxNikq3e+qzY/+dffT1qJnSeXEufrcGgfA4ZpYWWhILnsRctZfJxmHIHJ2Gkud+CBDk8Mhncu/NsFs+4rS848tctihq+cngOP4GxPhTjEWbyAnpH/FAQiKQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084546; c=relaxed/simple;
	bh=NYECknoiRRYM5IDDtkno8VJoweUdma3+I//bOJcctlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht6a/bAqOLWlDsRDqC5bsZ/PAw0PzwH9xNWaaefAXy6lMPIFjdbv09jjMz1iIkq6fBXOVRp2q8tLGWbHfvu/x9OpSm8BhAY1ZFbK0B+J2fwbDllJR/+TJeH2qSz9LHO61RMwfCj/ByhGbtCBFGlaxgbPbXCHuxWBSuvqn4qPnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PePE/I3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PePE/I3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B96FC19421;
	Sat, 21 Mar 2026 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084546;
	bh=NYECknoiRRYM5IDDtkno8VJoweUdma3+I//bOJcctlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PePE/I3mtSHMTt8dPt1P4+6tGB1c63Im3wj1wYsCjjNHk+Z/6iXJbGQIm9poWxz1g
	 fdNWUwuJYR0R9HMdWpGM92skzsK5xc7NfmDlB7RZ7McWFdjAcPZZAopzRjgL0SVcAO
	 /QjcMhvS1r95gGUPRrSL+4hHdFxL/E/N+l6aq8lSEmKaUC1eTtL3YVO5+MfRqo/uAi
	 tbHJT78Qkf5C4GxYBRDRAai7Ysw12TOiWGzjsobzrtZHbwyRZkleD0pVYFjGdQn9v1
	 PvqvSYgENPkEj04QrWhxWhVoU7l0GgPgxj4GHOqdP/WCdcY9/Gh6zOEb63XNZLNUAM
	 K1jBi7lLecn4A==
Date: Sat, 21 Mar 2026 09:15:41 +0000
From: Simon Horman <horms@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: vikas.gupta@broadcom.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	vsrama-krishna.nemani@broadcom.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
	rajashekar.hudumula@broadcom.com, davem@davemloft.net,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 09/10] bng_en: implement netdev_stat_ops
Message-ID: <20260321091541.GS74886@horms.kernel.org>
References: <20260319055124.1350670-10-vikas.gupta@broadcom.com>
 <20260320112704.2065290-1-horms@kernel.org>
 <CANXQDtaMYzKS6KBR4mGmRgtQNvxX=ppBG8mgqZsxW=rQaKNFug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXQDtaMYzKS6KBR4mGmRgtQNvxX=ppBG8mgqZsxW=rQaKNFug@mail.gmail.com>

On Sat, Mar 21, 2026 at 01:57:12AM +0530, Bhargava Chenna Marreddy wrote:
> >
> > Can this race with bnge_close_core when reading bn->net_stats_prev?
> > bnge_close_core writes to bn->net_stats_prev while this function reads
> > it without any locking.
> >
> > Looking at bnge_get_stats64, it uses rcu_read_lock() before accessing
> > bn->net_stats_prev. While this won't cause a crash like the other two
> > issues, it could result in torn reads on 32-bit systems where reading
> > u64 is not atomic, potentially returning inconsistent statistics to
> > userspace.
> >
> > Should bnge_get_base_stats also use rcu_read_lock() when reading
> > bn->net_stats_prev?
> 
> Thanks, Simon.
> 
> Regarding the RCU suggestions: bnge_get_queue_stats_rx,
> bnge_get_queue_stats_tx, and bnge_get_base_stats should not
> require RCU protection here. Unlike ndo_get_stats64, these ops
> are synchronized by the netdev instance lock. Since the writer path
> (bnge_close_core via ndo_stop) also holds the netdev instance lock,
> they are already mutually exclusive.
> 
> Do you agree, or am I missing a case where these ops can be called
> without that lock?

Yes, I agree. And sorry for not thinking of that before forwarding
this review.


