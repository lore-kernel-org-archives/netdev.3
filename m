Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953833;
	b=rYEhIhEKTsqN4Icgbe65Sf53j4RUhiQ8tHXaNZyZ1FZ8GJRji9pN+ef66/NPu1f/i6kz
	 4y1f0c3yGn773rp+MNIaUs91EJj/DlGN/rSkMiuB3n+Klcpv/mqS/T4snLj75+I3+CyLM
	 5PYxCDq3mUGMa91OgHStLKGioeo4HVh22CebZhP4MDWXIH7sK7Wo27q867m9YZB3494Ft
	 xXf2zcj0oUd0bPL6AEEdWaEqieuRIYUtCGY//pOKALhk0tCfyS0PVIhJTdOccE1za9bhP
	 BjGDViZoZk055KAASH6zNaEzFmjeaaXNgaaHE5jx4z2TRLo9r4cyCBhJ2L/tt7PzVLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3N258oZT74mhgatkaTIaW62KzUyIR4jJZkFJiLgrRQ8=;
	b=BQxvVGeRaZHXXL3QciV72R1xEvcjQbAUj4R2HdSKHU9tR1DNzac/PWJMUj+xS8fPZGIP
	 i/I7T1W129mjcV8l712lkcYfn96YvqmAhvdDe+ik+XIaDm3/n214U4zkSHEnhllS1J6KW
	 HugDFi7B2K0ygZcYQ4C4V/gB1gs3TiH9x85osZLhwSEGHFII5HIpMslZQIVIQSLdtkdN2
	 7gVDv+rNmsuoaS+K1I+qWAztOvj76Thcic9SFX9O6oQqcHzxmfaDOm5jm2lpOZzPfGSUH
	 9yg2W493I+xm+xmldyL2BIigvEkmqqCgiyLnzBNGa4VgjvQQxRb9B8IM6+ggBIZ0pDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B03nwNLN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79563606A32C;
	Fri,  6 Nov 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B03nwNLN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812861F008A1;
	Fri,  6 Nov 2026 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953833;
	bh=3N258oZT74mhgatkaTIaW62KzUyIR4jJZkFJiLgrRQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B03nwNLN5bke7U/Cj5BvvV/NfbR+FoJjEaEvKHFnD+7Q1JVY58BDgDIJV6LULSI1p
	 mOSShNtQD6mr7FW0ilC7iF1YNf+F3LL1roadBLoFhM5BuH5/p2AeW11ykuPYyhC6hM
	 FA2Vtfj6qr3Ux6qhGR/BHBPnh7dJfYlASQYRtXMumXVTNFq7UWvFPgTbjKsJlFo4wo
	 ny9U5eeQow601rqYDib9TRrnB7dHL4mxbtMsJTz5wFJfpoYsGiGxdZleDFYKqJofOK
	 csKld4Nu2QkgHQpHeanzP3eVcFffeBRzOCEvsydRPYAYI+aQTZscUVU7z+F9z1tzkP
	 tVP2il7Zh15qw==
Date: Fri, 6 Nov 2026 08:30:29 +0000
From: Simon Horman <horms@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netlink: Do not call the unbind callback with the
 table locked
Message-ID: <20261106083029.GB865646@horms.kernel.org>
References: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>

On Mon, Nov 02, 2026 at 12:09:29PM +0000, Anil Kaushik wrote:
> When netlink_bind() fails to insert the socket, it calls
> netlink_undo_bind() with the table locked. genl_unbind() then takes
> cb_lock, while genl_unregister_family() and genl_register_family() take
> cb_lock for writing and then wait in netlink_table_grab() for the table
> users to go away:
> 
>   netlink_bind()                 genl_unregister_family()
>     netlink_lock_table()           down_write(&cb_lock)
>     netlink_insert() fails
>     netlink_undo_bind()            netlink_table_grab()
>       genl_unbind()                  waits for nl_table_users == 0
>         down_read(&cb_lock)
> 
> An unprivileged user can get here by binding to a port ID that is in
> use, with nl_groups set. Lockdep does not see it, as nl_table_users is a
> plain counter.
> 
> Unlock the table first, as the comment in netlink_release() asks for.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101101347.3910654-1-anilkaushikwireless@gmail.com
> Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

