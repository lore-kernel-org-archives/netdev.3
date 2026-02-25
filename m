Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0337419B;
	Wed, 25 Feb 2026 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010886; cv=none; b=hsrZdI4tSSanEfcIbQmvvTbyqydYPdfaifnTlZ8Pga6+Z3JogHSajxnMVjuhgWiBZXhGCcX5HLEsb4YACRMLAoRWPR9m4O+niPInXng4YmCcg8qVCUbALCRLt05xnPA2jx4uQqMX0f7DFh0SHoxQ6DGT96vzyyzq5KND/RU2VcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010886; c=relaxed/simple;
	bh=p25+5pv7NVZmKWEKuRjfwdQ6ErbXfWp0m5SN4Bks0XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqfXilt5jwg6IX+SmHHul4gOPMJvmuy4etJ7MZ55oq2/fhC7L5k61oY+QxxgRgWOndEdSjXJEqAkni1cO8ZAmjqCSoVJbZbtbx2sTWgg4DAJDLyca5n7rLrXMKB+i27QjktuVB/SkRN8z+6GZItomnEe6MZPGTM1fan3VQ4uPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIH9eEuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIH9eEuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DEEC116D0;
	Wed, 25 Feb 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772010886;
	bh=p25+5pv7NVZmKWEKuRjfwdQ6ErbXfWp0m5SN4Bks0XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIH9eEuYj/i0juLEtIdKqUN1r9o8OYN+mDL8pLrD0iulqzOW5IsanB783jYLKRgVm
	 YlLvCPqT+8O6ploD0lHhcQD/zPKsiVZ485zBqPcE+Wzp1NkgYn6vQI2KCf0wxsMYFZ
	 pPxCEcDlPykOs8VxaZdSBztOy/yvBnk5KqBxyX1sgZGh4LcU6K2++eoSlVnmXBb+4L
	 SExM6s6MPLGVP0Xc2AHURmZScuxYzpe6UmV8oEd+EtzNtSHL3lohpf6EEc8UKa2eKm
	 FU9r/Ii1Xxv1gF52gzOprhZ7UF6OE/7/7UIpZoxEoh4+cH9PZK4e/FxNMufbVdfuX9
	 Dkfk8ARplvrlg==
Date: Wed, 25 Feb 2026 09:14:38 +0000
From: Simon Horman <horms@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	ziy@nvidia.com, willy@infradead.org, toke@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, asml.silence@gmail.com, axboe@kernel.dk,
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com, shivajikant@google.com,
	io-uring@vger.kernel.org
Subject: Re: [RESEND PATCH net-next] netmem: remove the pp fields from net_iov
Message-ID: <aZ69fs1_OsqkQfQ2@horms.kernel.org>
References: <20260224061424.11219-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224061424.11219-1-byungchul@sk.com>

On Tue, Feb 24, 2026 at 03:14:24PM +0900, Byungchul Park wrote:
> Now that the pp fields in net_iov have no users, remove them from
> net_iov and clean up.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Simon Horman <horms@kernel.org>

