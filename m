Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768071;
	b=RrQ96joAYO1Ed1qPYcscHotBb86Kp5Tk8nrDjQ0cTCGCPv9w3YQFi0/WEMVboNuTKahu
	 3t6TqFBetQlNV5lsfRTQV3IS656IBQUJZ+nd/W6unV/RXfFRqzLVzZeiCYgp+7Ko4FP5t
	 3GSG06T++aw4+5ryOO2mDP61nOoZu1TushEyZVT5WVamIYCtZrCLWW38QVawTuoz6QFq/
	 ecxIbPCJphDLvOWF/p4E/Nt2vp6AmdQlNwmHVK/1zWfz4YKRz95FAag1rQe9HDOOuHhKR
	 Jyc6Yl9T6mmxSiBtanHhC/hmvz+5BLqHa7SP7Bm4Zse8/uoIzZCVlG/9oqwsStH9k4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768071;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HYU/VkZ1FqssN6MTPXobWxgICxr4ZfYF36w4a9XkZQU=;
	b=QzZnjCKG5ftsEK5FcaY5G3kya77qS8XBskagKhGPsNGuiwhRM3HNQhmZ3UvjB9P6ZZ6I
	 SvdYekhmeXliiOiGwZ4epfhksXmRjPwamh1EU0t5lwTAk94mCcPSucp44txso7G5xPazY
	 +5j0fpnl7yhdhlSpcXTqO0/dvBU7kuR0aU3+i2pQPF35RZqLqu7+APT2jAnSc298KGZPL
	 x8mzjC6J3xUICvYFKsCOYiRMZJcrxoPC5BMPrSw99zUSwt4PvMuGZzDENllQH+AIkjviN
	 MkqImGNEbXeWQDFOB/KXhmUOJqiHMcgF0gyQsbDjA8VwIghfQvdeWi7tYk4htqz628A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="idUQ1Md/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C6606A321;
	Fri, 23 Oct 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idUQ1Md/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D41F01825;
	Fri, 23 Oct 2026 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768070;
	bh=HYU/VkZ1FqssN6MTPXobWxgICxr4ZfYF36w4a9XkZQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=idUQ1Md/oJ1KixO3jY+8e1oIz9nv2/UKTKzEvO2QelTje1NI4fAaoDpCMeh1i+0Wt
	 WNHPn5AsJlhzuqvP02GjsNi4afeQ7uGqx7QSshKfwZo8HFGHJcSeyquK0Ok5nj9wKH
	 FZAtxubPnsVfYiASUL5AwN+2vyu0bYcp9lV8r+RKDRiXt60l5A9uhrZPv2/Ryim+23
	 ryEShAVoYvZ+zv9j/nOZqFiJIN5eNkN7lk8dSn3IsYWAx2ORMTVePgjfpZpuBO8vqj
	 votsHjLBADiZA3BAa7IRY1yZFIbSn8KyGowM5dBd7yu/akKx2p76uKQeVjIuJYQxew
	 xQ4Cqd+huKjPg==
Date: Fri, 23 Oct 2026 16:07:45 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: yogeshgaur.83@gmail.com, david@ixit.cz, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ian.ray@gehealthcare.com, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com
Subject: Re: [PATCH] nfc: nci: drain rx_wq before cmd_wq on unregister
Message-ID: <20261023150745.GM708417@horms.kernel.org>
References: <20261005102849.486-1-yogeshgaur.83@gmail.com>
 <179146631693.434549.10968955013781183787@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179146631693.434549.10968955013781183787@kernel.org>

On Thu, Oct 08, 2026 at 01:31:56PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new teardown order in nci_unregister_device() does not cover
>   a deferred producer of tx_work: the NCI-HCI msg_rx_work, which runs on…
> - [High] nci_recv_frame() (net/nfc/nci/core.c:1360-1368) tests
>   NCI_UP/NCI_INIT without a lock, then calls skb_queue_tail(&ndev->rx_q)…

I believe above issues are also pre-existing.

> 
> Pre-existing issues:
> - [High] This problem was not introduced by this patch, but
>   nxp_nci_i2c_remove() calls nxp_nci_remove() before…

There is always more to be done.
But this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

